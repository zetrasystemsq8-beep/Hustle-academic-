import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_python_workspace.dart' show AiWorkspace, AiWorkspaceRepository, AiWorkspaceFileNode, AiFileNodeType;

// ============================================================
// AI LAB — Build Model
//
// Real: generates actual, runnable scikit-learn code from the
// student's choices and writes it directly into their Python
// Workspace files (src/model.py, src/train.py get overwritten).
// This is NOT a drag-and-drop layer canvas — that's a separate,
// much larger deliverable. This is "pick an algorithm and its
// real hyperparameters," and the generated code is exactly what
// gets executed by the Training Pipeline — no gap between what
// you configure here and what actually runs.
// ============================================================

enum AiAlgorithm {
  logisticRegression,
  randomForest,
  decisionTree,
  svm,
  linearRegression,
  kNearestNeighbors,
}

extension AiAlgorithmX on AiAlgorithm {
  String get label {
    switch (this) {
      case AiAlgorithm.logisticRegression:
        return 'Logistic Regression';
      case AiAlgorithm.randomForest:
        return 'Random Forest';
      case AiAlgorithm.decisionTree:
        return 'Decision Tree';
      case AiAlgorithm.svm:
        return 'Support Vector Machine';
      case AiAlgorithm.linearRegression:
        return 'Linear Regression';
      case AiAlgorithm.kNearestNeighbors:
        return 'K-Nearest Neighbors';
    }
  }

  bool get isClassifier => this != AiAlgorithm.linearRegression;

  String get sklearnImport {
    switch (this) {
      case AiAlgorithm.logisticRegression:
        return 'from sklearn.linear_model import LogisticRegression';
      case AiAlgorithm.randomForest:
        return 'from sklearn.ensemble import RandomForestClassifier';
      case AiAlgorithm.decisionTree:
        return 'from sklearn.tree import DecisionTreeClassifier';
      case AiAlgorithm.svm:
        return 'from sklearn.svm import SVC';
      case AiAlgorithm.linearRegression:
        return 'from sklearn.linear_model import LinearRegression';
      case AiAlgorithm.kNearestNeighbors:
        return 'from sklearn.neighbors import KNeighborsClassifier';
    }
  }
}

/// One configurable hyperparameter. Kept intentionally small and
/// typed — no free-form kwargs — so every value the student sets
/// maps to a real, valid scikit-learn constructor argument.
class AiHyperparam {
  final String name; // python kwarg name, e.g. "max_depth"
  final String label; // human label, e.g. "Max depth"
  final String type; // 'int' | 'double' | 'bool' | 'choice'
  final dynamic defaultValue;
  final List<String>? choices;
  final double? min;
  final double? max;

  const AiHyperparam({
    required this.name,
    required this.label,
    required this.type,
    required this.defaultValue,
    this.choices,
    this.min,
    this.max,
  });
}

Map<AiAlgorithm, List<AiHyperparam>> kAlgorithmHyperparams = {
  AiAlgorithm.logisticRegression: [
    const AiHyperparam(name: 'C', label: 'Regularization strength (C)', type: 'double', defaultValue: 1.0, min: 0.01, max: 10),
    const AiHyperparam(name: 'max_iter', label: 'Max iterations', type: 'int', defaultValue: 1000, min: 100, max: 5000),
  ],
  AiAlgorithm.randomForest: [
    const AiHyperparam(name: 'n_estimators', label: 'Number of trees', type: 'int', defaultValue: 100, min: 10, max: 500),
    const AiHyperparam(name: 'max_depth', label: 'Max depth (0 = unlimited)', type: 'int', defaultValue: 0, min: 0, max: 50),
  ],
  AiAlgorithm.decisionTree: [
    const AiHyperparam(name: 'max_depth', label: 'Max depth (0 = unlimited)', type: 'int', defaultValue: 0, min: 0, max: 50),
    const AiHyperparam(name: 'criterion', label: 'Split criterion', type: 'choice', defaultValue: 'gini', choices: ['gini', 'entropy', 'log_loss']),
  ],
  AiAlgorithm.svm: [
    const AiHyperparam(name: 'C', label: 'Regularization strength (C)', type: 'double', defaultValue: 1.0, min: 0.01, max: 10),
    const AiHyperparam(name: 'kernel', label: 'Kernel', type: 'choice', defaultValue: 'rbf', choices: ['linear', 'poly', 'rbf', 'sigmoid']),
  ],
  AiAlgorithm.linearRegression: [
    const AiHyperparam(name: 'fit_intercept', label: 'Fit intercept', type: 'bool', defaultValue: true),
  ],
  AiAlgorithm.kNearestNeighbors: [
    const AiHyperparam(name: 'n_neighbors', label: 'Number of neighbors (k)', type: 'int', defaultValue: 5, min: 1, max: 50),
  ],
};

class AiBuildModelScreen extends StatefulWidget {
  final AiProject project;
  const AiBuildModelScreen({super.key, required this.project});

  @override
  State<AiBuildModelScreen> createState() => _AiBuildModelScreenState();
}

class _AiBuildModelScreenState extends State<AiBuildModelScreen> {
  AiAlgorithm _algorithm = AiAlgorithm.logisticRegression;
  late Map<String, dynamic> _values;
  String _labelColumn = 'label';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _resetValuesForAlgorithm();
  }

  void _resetValuesForAlgorithm() {
    _values = {
      for (final p in kAlgorithmHyperparams[_algorithm]!) p.name: p.defaultValue,
    };
  }

  String _generateModelPy() {
    final params = kAlgorithmHyperparams[_algorithm]!;
    final args = params.map((p) {
      final v = _values[p.name];
      if (p.type == 'choice' || p.type == 'string') return '${p.name}="$v"';
      if (p.type == 'bool') return '${p.name}=$v';
      // max_depth/0 convention meaning "unlimited" -> None
      if (p.name == 'max_depth' && v == 0) return 'max_depth=None';
      return '${p.name}=$v';
    }).join(', ');

    final className = switch (_algorithm) {
      AiAlgorithm.logisticRegression => 'LogisticRegression',
      AiAlgorithm.randomForest => 'RandomForestClassifier',
      AiAlgorithm.decisionTree => 'DecisionTreeClassifier',
      AiAlgorithm.svm => 'SVC',
      AiAlgorithm.linearRegression => 'LinearRegression',
      AiAlgorithm.kNearestNeighbors => 'KNeighborsClassifier',
    };

    return '''"""
Model definition for ${widget.project.name}.

Generated by Build Model — edit freely in Python Workspace, this
is real code, not a locked template.
"""

${_algorithm.sklearnImport}


def build_model():
    return $className($args)
''';
  }

  String _generateTrainPy() {
    final isClassifier = _algorithm.isClassifier;
    final metricsImports = isClassifier
        ? 'from sklearn.metrics import accuracy_score, precision_recall_fscore_support, confusion_matrix'
        : 'from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score';

    final metricsBlock = isClassifier
        ? '''    predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    precision, recall, f1, _ = precision_recall_fscore_support(
        y_test, predictions, average="weighted", zero_division=0
    )
    classes = sorted(y.unique().tolist())
    cm = confusion_matrix(y_test, predictions, labels=classes).tolist()

    print(f"Validation accuracy: {accuracy:.4f}")
    print(f"Precision: {precision:.4f}  Recall: {recall:.4f}  F1: {f1:.4f}")

    metrics = {
        "accuracy": accuracy,
        "precision": precision,
        "recall": recall,
        "f1": f1,
        "classes": [str(c) for c in classes],
        "confusion_matrix": cm,
    }'''
        : '''    predictions = model.predict(X_test)
    mae = mean_absolute_error(y_test, predictions)
    mse = mean_squared_error(y_test, predictions)
    r2 = r2_score(y_test, predictions)

    print(f"MAE: {mae:.4f}  MSE: {mse:.4f}  R2: {r2:.4f}")

    metrics = {"mae": mae, "mse": mse, "r2": r2}''';

    return '''"""
Training entry point for ${widget.project.name}.

Generated by Build Model for a ${_algorithm.label} model. Executed
for real by the Training Pipeline on a GitHub Actions runner — this
is not a preview, it is what actually runs.
"""

import json
import pandas as pd
from sklearn.model_selection import train_test_split
from model import build_model
$metricsImports
import joblib


def load_dataset(csv_path: str, label_column: str):
    df = pd.read_csv(csv_path)
    X = df.drop(columns=[label_column])
    y = df[label_column]
    return X, y


def main():
    X, y = load_dataset("dataset.csv", label_column="$_labelColumn")

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    model = build_model()
    model.fit(X_train, y_train)

$metricsBlock

    joblib.dump(model, "model.joblib")
    print("Saved model.joblib")

    with open("metrics.json", "w") as f:
        json.dump(metrics, f)
    print("Saved metrics.json")


if __name__ == "__main__":
    main()
''';
  }

  Future<void> _applyToWorkspace() async {
    setState(() => _isSaving = true);
    try {
      final repository = AiWorkspaceRepository(Supabase.instance.client);
      final workspace = await repository.loadOrCreate(widget.project);

      final srcFolder = _findOrCreateSrcFolder(workspace);
      _writeOrReplaceFile(srcFolder, 'model.py', _generateModelPy());
      _writeOrReplaceFile(srcFolder, 'train.py', _generateTrainPy());

      await repository.save(workspace);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('model.py and train.py updated in Python Workspace')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to apply: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  AiWorkspaceFileNode _findOrCreateSrcFolder(AiWorkspace workspace) {
    final existing = workspace.root.children.where((c) => c.name == 'src' && c.isFolder);
    if (existing.isNotEmpty) return existing.first;
    final folder = AiWorkspaceFileNode(
      id: '${DateTime.now().microsecondsSinceEpoch}_src',
      name: 'src',
      type: AiFileNodeType.folder,
      isExpanded: true,
    );
    workspace.root.children.add(folder);
    return folder;
  }

  void _writeOrReplaceFile(AiWorkspaceFileNode folder, String name, String content) {
    final existingIndex = folder.children.indexWhere((c) => c.name == name && c.isFile);
    if (existingIndex != -1) {
      folder.children[existingIndex].content = content;
      folder.children[existingIndex].lastModified = DateTime.now();
    } else {
      folder.children.add(AiWorkspaceFileNode(
        id: '${DateTime.now().microsecondsSinceEpoch}_$name',
        name: name,
        type: AiFileNodeType.file,
        content: content,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final params = kAlgorithmHyperparams[_algorithm]!;

    return Scaffold(
      appBar: AppBar(title: const Text('Build Model')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.blue.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'This generates real Python code and writes it into src/model.py and src/train.py in your Python Workspace. It overwrites those two files.',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<AiAlgorithm>(
            value: _algorithm,
            decoration: const InputDecoration(labelText: 'Algorithm'),
            items: AiAlgorithm.values.map((a) => DropdownMenuItem(value: a, child: Text(a.label))).toList(),
            onChanged: (v) {
              if (v == null) return;
              setState(() {
                _algorithm = v;
                _resetValuesForAlgorithm();
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _labelColumn,
            decoration: const InputDecoration(labelText: 'Label column name (in your dataset)'),
            onChanged: (v) => _labelColumn = v,
          ),
          const SizedBox(height: 24),
          Text('Hyperparameters', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...params.map(_buildHyperparamField),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _isSaving ? null : _applyToWorkspace,
            icon: _isSaving
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.check),
            label: Text(_isSaving ? 'Applying...' : 'Apply to Python Workspace'),
          ),
        ],
      ),
    );
  }

  Widget _buildHyperparamField(AiHyperparam p) {
    switch (p.type) {
      case 'choice':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField<String>(
            value: _values[p.name] as String,
            decoration: InputDecoration(labelText: p.label),
            items: p.choices!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _values[p.name] = v),
          ),
        );
      case 'bool':
        return SwitchListTile(
          title: Text(p.label),
          value: _values[p.name] as bool,
          onChanged: (v) => setState(() => _values[p.name] = v),
        );
      case 'int':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(child: Text(p.label)),
              SizedBox(
                width: 100,
                child: TextFormField(
                  initialValue: '${_values[p.name]}',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                  onChanged: (v) => _values[p.name] = int.tryParse(v) ?? p.defaultValue,
                ),
              ),
            ],
          ),
        );
      case 'double':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(child: Text(p.label)),
              SizedBox(
                width: 100,
                child: TextFormField(
                  initialValue: '${_values[p.name]}',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                  onChanged: (v) => _values[p.name] = double.tryParse(v) ?? p.defaultValue,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
