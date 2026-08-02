import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================
// FINITE STATE MACHINE MODEL + ENGINE
// ============================================================

class FsmTransition {
  final String id;
  String fromState;
  String onInput;
  String toState;

  FsmTransition({required this.id, required this.fromState, required this.onInput, required this.toState});

  Map<String, dynamic> toJson() => {'id': id, 'fromState': fromState, 'onInput': onInput, 'toState': toState};

  factory FsmTransition.fromJson(Map<String, dynamic> json) {
    return FsmTransition(id: json['id'] as String, fromState: json['fromState'] as String, onInput: json['onInput'] as String, toState: json['toState'] as String);
  }
}

/// A student-defined finite state machine: named states, one marked as
/// start, zero or more marked as accepting, and transitions between
/// them keyed by input symbol — the actual mathematical model behind
/// regex engines, protocol parsers, and traffic-light controllers alike.
class FiniteStateMachine {
  final String id;
  String name;
  List<String> states;
  String startState;
  Set<String> acceptingStates;
  List<FsmTransition> transitions;
  String sampleInput;

  FiniteStateMachine({
    required this.id,
    required this.name,
    List<String>? states,
    this.startState = 'q0',
    Set<String>? acceptingStates,
    List<FsmTransition>? transitions,
    this.sampleInput = '',
  })  : states = states ?? ['q0'],
        acceptingStates = acceptingStates ?? {},
        transitions = transitions ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'states': states,
        'startState': startState,
        'acceptingStates': acceptingStates.toList(),
        'transitions': transitions.map((t) => t.toJson()).toList(),
        'sampleInput': sampleInput,
      };

  factory FiniteStateMachine.fromJson(Map<String, dynamic> json) {
    return FiniteStateMachine(
      id: json['id'] as String,
      name: json['name'] as String,
      states: (json['states'] as List<dynamic>? ?? ['q0']).map((e) => e.toString()).toList(),
      startState: json['startState'] as String? ?? 'q0',
      acceptingStates: ((json['acceptingStates'] as List<dynamic>? ?? []).map((e) => e.toString())).toSet(),
      transitions: (json['transitions'] as List<dynamic>? ?? []).map((t) => FsmTransition.fromJson(t as Map<String, dynamic>)).toList(),
      sampleInput: json['sampleInput'] as String? ?? '',
    );
  }

  factory FiniteStateMachine.starterExample() {
    return FiniteStateMachine(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'Turnstile (example)',
      states: ['locked', 'unlocked'],
      startState: 'locked',
      acceptingStates: {'unlocked'},
      transitions: [
        FsmTransition(id: 't1', fromState: 'locked', onInput: 'coin', toState: 'unlocked'),
        FsmTransition(id: 't2', fromState: 'unlocked', onInput: 'push', toState: 'locked'),
        FsmTransition(id: 't3', fromState: 'locked', onInput: 'push', toState: 'locked'),
        FsmTransition(id: 't4', fromState: 'unlocked', onInput: 'coin', toState: 'unlocked'),
      ],
      sampleInput: 'coin,push,push,coin,coin,push',
    );
  }
}

/// One step of a stepped FSM execution — the state before the step, the
/// input symbol consumed, and the state reached, so the UI can render
/// the whole run as a visible trail rather than just a final answer.
class FsmStep {
  final String fromState;
  final String? inputSymbol;
  final String toState;
  final bool wasValidTransition;

  const FsmStep({required this.fromState, required this.inputSymbol, required this.toState, required this.wasValidTransition});
}

class FsmExecutionResult {
  final List<FsmStep> steps;
  final bool accepted;
  final bool hitDeadEnd;

  const FsmExecutionResult({required this.steps, required this.accepted, required this.hitDeadEnd});
}

class FsmEngine {
  /// Runs [machine] against the comma-separated symbols in [input],
  /// producing a full trace of every state transition taken. A missing
  /// transition for the current state/symbol pair is a genuine dead end
  /// — the same way an unhandled input genuinely halts a real state
  /// machine — not silently ignored.
  FsmExecutionResult run(FiniteStateMachine machine, String input) {
    final symbols = input.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    final steps = <FsmStep>[];
    var current = machine.startState;
    var deadEnd = false;

    for (final symbol in symbols) {
      FsmTransition? match;
      for (final t in machine.transitions) {
        if (t.fromState == current && t.onInput == symbol) {
          match = t;
          break;
        }
      }
      if (match == null) {
        steps.add(FsmStep(fromState: current, inputSymbol: symbol, toState: current, wasValidTransition: false));
        deadEnd = true;
        break;
      }
      steps.add(FsmStep(fromState: current, inputSymbol: symbol, toState: match.toState, wasValidTransition: true));
      current = match.toState;
    }

    return FsmExecutionResult(steps: steps, accepted: !deadEnd && machine.acceptingStates.contains(current), hitDeadEnd: deadEnd);
  }
}

// ============================================================
// TINY STACK-BASED VIRTUAL MACHINE MODEL + ENGINE
// ============================================================

/// One real instruction in the tiny VM's instruction set — a genuine,
/// if minimal, machine language: values move to and from a stack and
/// named registers, arithmetic operates on the stack, and control flow
/// jumps by instruction index. This is what "how does a computer
/// actually execute a program" looks like at the smallest honest scale.
class VmInstruction {
  final String id;
  String opcode; // PUSH, POP, ADD, SUB, MUL, STORE, LOAD, JMP, JZ, PRINT, HALT
  String operand;

  VmInstruction({required this.id, required this.opcode, this.operand = ''});

  Map<String, dynamic> toJson() => {'id': id, 'opcode': opcode, 'operand': operand};

  factory VmInstruction.fromJson(Map<String, dynamic> json) {
    return VmInstruction(id: json['id'] as String, opcode: json['opcode'] as String, operand: json['operand'] as String? ?? '');
  }
}

class VirtualMachineProgram {
  final String id;
  String name;
  List<VmInstruction> instructions;

  VirtualMachineProgram({required this.id, required this.name, List<VmInstruction>? instructions}) : instructions = instructions ?? [];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'instructions': instructions.map((i) => i.toJson()).toList()};

  factory VirtualMachineProgram.fromJson(Map<String, dynamic> json) {
    return VirtualMachineProgram(
      id: json['id'] as String,
      name: json['name'] as String,
      instructions: (json['instructions'] as List<dynamic>? ?? []).map((i) => VmInstruction.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }

  factory VirtualMachineProgram.starterExample() {
    return VirtualMachineProgram(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'Sum 1 to 5 (example)',
      instructions: [
        VmInstruction(id: '0', opcode: 'PUSH', operand: '0'),
        VmInstruction(id: '1', opcode: 'STORE', operand: 'total'),
        VmInstruction(id: '2', opcode: 'PUSH', operand: '1'),
        VmInstruction(id: '3', opcode: 'STORE', operand: 'i'),
        VmInstruction(id: '4', opcode: 'LOAD', operand: 'i'),
        VmInstruction(id: '5', opcode: 'PUSH', operand: '6'),
        VmInstruction(id: '6', opcode: 'SUB'),
        VmInstruction(id: '7', opcode: 'JZ', operand: '14'),
        VmInstruction(id: '8', opcode: 'LOAD', operand: 'total'),
        VmInstruction(id: '9', opcode: 'LOAD', operand: 'i'),
        VmInstruction(id: '10', opcode: 'ADD'),
        VmInstruction(id: '11', opcode: 'STORE', operand: 'total'),
        VmInstruction(id: '12', opcode: 'LOAD', operand: 'i'),
        VmInstruction(id: '13', opcode: 'PUSH', operand: '1'),
        VmInstruction(id: '13b', opcode: 'ADD'),
        VmInstruction(id: '13c', opcode: 'STORE', operand: 'i'),
        VmInstruction(id: '13d', opcode: 'JMP', operand: '4'),
        VmInstruction(id: '14', opcode: 'LOAD', operand: 'total'),
        VmInstruction(id: '15', opcode: 'PRINT'),
        VmInstruction(id: '16', opcode: 'HALT'),
      ],
    );
  }
}

/// A full snapshot of the VM's state at one point during execution —
/// the actual instruction pointer, stack contents, and register values,
/// so the UI can show a real step-by-step trace of program execution.
class VmSnapshot {
  final int instructionPointer;
  final List<int> stack;
  final Map<String, int> registers;
  final String? lastOutput;

  const VmSnapshot({required this.instructionPointer, required this.stack, required this.registers, this.lastOutput});
}

class VmExecutionResult {
  final List<VmSnapshot> snapshots;
  final List<String> printedOutput;
  final String? error;

  const VmExecutionResult({required this.snapshots, required this.printedOutput, this.error});
}

class VirtualMachineEngine {
  static const int _maxSteps = 10000;

  /// Executes [program] instruction by instruction, capturing a
  /// [VmSnapshot] after every single step — real execution, not a
  /// summarized "here's the final answer."
  VmExecutionResult run(VirtualMachineProgram program) {
    final stack = <int>[];
    final registers = <String, int>{};
    final snapshots = <VmSnapshot>[];
    final output = <String>[];

    var pointer = 0;
    var steps = 0;

    while (pointer >= 0 && pointer < program.instructions.length && steps < _maxSteps) {
      steps++;
      final instruction = program.instructions[pointer];
      String? printed;

      try {
        switch (instruction.opcode.toUpperCase()) {
          case 'PUSH':
            stack.add(int.parse(instruction.operand));
            pointer++;
            break;
          case 'POP':
            stack.removeLast();
            pointer++;
            break;
          case 'ADD':
            final b = stack.removeLast();
            final a = stack.removeLast();
            stack.add(a + b);
            pointer++;
            break;
          case 'SUB':
            final b = stack.removeLast();
            final a = stack.removeLast();
            stack.add(a - b);
            pointer++;
            break;
          case 'MUL':
            final b = stack.removeLast();
            final a = stack.removeLast();
            stack.add(a * b);
            pointer++;
            break;
          case 'STORE':
            registers[instruction.operand] = stack.removeLast();
            pointer++;
            break;
          case 'LOAD':
            stack.add(registers[instruction.operand] ?? 0);
            pointer++;
            break;
          case 'JMP':
            pointer = _resolveJumpTarget(program, instruction.operand);
            break;
          case 'JZ':
            final top = stack.removeLast();
            pointer = top == 0 ? _resolveJumpTarget(program, instruction.operand) : pointer + 1;
            break;
          case 'PRINT':
            printed = '${stack.isNotEmpty ? stack.last : ''}';
            output.add(printed);
            pointer++;
            break;
          case 'HALT':
            snapshots.add(VmSnapshot(instructionPointer: pointer, stack: List.of(stack), registers: Map.of(registers), lastOutput: printed));
            return VmExecutionResult(snapshots: snapshots, printedOutput: output);
          default:
            return VmExecutionResult(snapshots: snapshots, printedOutput: output, error: 'Unknown instruction: ${instruction.opcode}');
        }
      } catch (e) {
        return VmExecutionResult(snapshots: snapshots, printedOutput: output, error: 'Runtime error at instruction $pointer: ${e.toString()}');
      }

      snapshots.add(VmSnapshot(instructionPointer: pointer, stack: List.of(stack), registers: Map.of(registers), lastOutput: printed));
    }

    if (steps >= _maxSteps) {
      return VmExecutionResult(snapshots: snapshots, printedOutput: output, error: 'Stopped after $_maxSteps steps — check for an infinite loop (a JMP that never reaches HALT).');
    }

    return VmExecutionResult(snapshots: snapshots, printedOutput: output);
  }

  int _resolveJumpTarget(VirtualMachineProgram program, String operand) {
    final index = int.tryParse(operand);
    if (index != null && index >= 0) return index;
    final found = program.instructions.indexWhere((i) => i.id == operand);
    return found == -1 ? program.instructions.length : found;
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class SimulationRepository {
  static const String _fsmKey = 'web_lab.simulation_fsms';
  static const String _vmKey = 'web_lab.simulation_vms';

  Future<List<FiniteStateMachine>> loadFsms() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_fsmKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => FiniteStateMachine.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveFsms(List<FiniteStateMachine> fsms) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fsmKey, jsonEncode(fsms.map((f) => f.toJson()).toList()));
  }

  Future<List<VirtualMachineProgram>> loadVms() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_vmKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => VirtualMachineProgram.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveVms(List<VirtualMachineProgram> vms) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_vmKey, jsonEncode(vms.map((v) => v.toJson()).toList()));
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class SimulationCenterController extends ChangeNotifier {
  final SimulationRepository _repository = SimulationRepository();
  final FsmEngine _fsmEngine = FsmEngine();
  final VirtualMachineEngine _vmEngine = VirtualMachineEngine();

  List<FiniteStateMachine> _fsms = [];
  List<VirtualMachineProgram> _vms = [];
  bool _isLoading = false;

  List<FiniteStateMachine> get fsms => List.unmodifiable(_fsms);
  List<VirtualMachineProgram> get vms => List.unmodifiable(_vms);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _fsms = await _repository.loadFsms();
    _vms = await _repository.loadVms();
    _isLoading = false;
    notifyListeners();
  }

  Future<FiniteStateMachine> createFsm(String name) async {
    final fsm = FiniteStateMachine(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _fsms.add(fsm);
    await _repository.saveFsms(_fsms);
    notifyListeners();
    return fsm;
  }

  Future<FiniteStateMachine> createFsmFromExample() async {
    final fsm = FiniteStateMachine.starterExample();
    _fsms.add(fsm);
    await _repository.saveFsms(_fsms);
    notifyListeners();
    return fsm;
  }

  Future<void> saveFsm(FiniteStateMachine fsm) async {
    await _repository.saveFsms(_fsms);
    notifyListeners();
  }

  Future<void> deleteFsm(String id) async {
    _fsms.removeWhere((f) => f.id == id);
    await _repository.saveFsms(_fsms);
    notifyListeners();
  }

  FsmExecutionResult runFsm(FiniteStateMachine fsm, String input) => _fsmEngine.run(fsm, input);

  Future<VirtualMachineProgram> createVm(String name) async {
    final vm = VirtualMachineProgram(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _vms.add(vm);
    await _repository.saveVms(_vms);
    notifyListeners();
    return vm;
  }

  Future<VirtualMachineProgram> createVmFromExample() async {
    final vm = VirtualMachineProgram.starterExample();
    _vms.add(vm);
    await _repository.saveVms(_vms);
    notifyListeners();
    return vm;
  }

  Future<void> saveVm(VirtualMachineProgram vm) async {
    await _repository.saveVms(_vms);
    notifyListeners();
  }

  Future<void> deleteVm(String id) async {
    _vms.removeWhere((v) => v.id == id);
    await _repository.saveVms(_vms);
    notifyListeners();
  }

  VmExecutionResult runVm(VirtualMachineProgram vm) => _vmEngine.run(vm);
}

// ============================================================
// SCREENS
// ============================================================

class SimulationCenterScreen extends StatefulWidget {
  const SimulationCenterScreen({super.key});

  @override
  State<SimulationCenterScreen> createState() => _SimulationCenterScreenState();
}

class _SimulationCenterScreenState extends State<SimulationCenterScreen> with SingleTickerProviderStateMixin {
  late final SimulationCenterController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = SimulationCenterController();
    _tabController = TabController(length: 2, vsync: this);
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _createFsm() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your state machine'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final fsm = await _controller.createFsm(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => FsmEditorScreen(controller: _controller, fsm: fsm)));
  }

  Future<void> _createVm() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your program'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final vm = await _controller.createVm(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => VmEditorScreen(controller: _controller, vm: vm)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulation Center'),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: 'State Machines'), Tab(text: 'Virtual Machines')]),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          return TabBarView(
            controller: _tabController,
            children: [_buildFsmList(), _buildVmList()],
          );
        },
      ),
    );
  }

  Widget _buildFsmList() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Colors.indigo.withOpacity(0.08),
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_outline, color: Colors.indigo),
                  title: const Text('See a working example first'),
                  subtitle: const Text('A turnstile: locked/unlocked states, coin/push transitions.'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final fsm = await _controller.createFsmFromExample();
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FsmEditorScreen(controller: _controller, fsm: fsm)));
                    },
                    child: const Text('Try it'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ..._controller.fsms.map((fsm) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(fsm.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${fsm.states.length} states · ${fsm.transitions.length} transitions'),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.deleteFsm(fsm.id)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FsmEditorScreen(controller: _controller, fsm: fsm))),
                    ),
                  )),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(12), child: SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: const Icon(Icons.add), label: const Text('New State Machine'), onPressed: _createFsm))),
      ],
    );
  }

  Widget _buildVmList() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Colors.teal.withOpacity(0.08),
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_outline, color: Colors.teal),
                  title: const Text('See a working example first'),
                  subtitle: const Text('A tiny program that sums 1 through 5 using real instructions.'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final vm = await _controller.createVmFromExample();
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => VmEditorScreen(controller: _controller, vm: vm)));
                    },
                    child: const Text('Try it'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ..._controller.vms.map((vm) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(vm.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${vm.instructions.length} instructions'),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.deleteVm(vm.id)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VmEditorScreen(controller: _controller, vm: vm))),
                    ),
                  )),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(12), child: SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: const Icon(Icons.add), label: const Text('New Program'), onPressed: _createVm))),
      ],
    );
  }
}

class FsmEditorScreen extends StatefulWidget {
  final SimulationCenterController controller;
  final FiniteStateMachine fsm;

  const FsmEditorScreen({super.key, required this.controller, required this.fsm});

  @override
  State<FsmEditorScreen> createState() => _FsmEditorScreenState();
}

class _FsmEditorScreenState extends State<FsmEditorScreen> {
  late TextEditingController _inputController;
  FsmExecutionResult? _lastResult;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.fsm.sampleInput);
  }

  Future<void> _addState() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New state name'),
        content: TextField(controller: controller, autofocus: true),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Add'))],
      ),
    );
    if (name == null || name.trim().isEmpty || widget.fsm.states.contains(name.trim())) return;
    setState(() => widget.fsm.states.add(name.trim()));
    await widget.controller.saveFsm(widget.fsm);
  }

  Future<void> _addTransition() async {
    String from = widget.fsm.states.first;
    String to = widget.fsm.states.first;
    final inputController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('New transition'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(isExpanded: true, value: from, items: widget.fsm.states.map((s) => DropdownMenuItem(value: s, child: Text('From: $s'))).toList(), onChanged: (v) => setDialogState(() => from = v!)),
              TextField(controller: inputController, decoration: const InputDecoration(labelText: 'On input symbol')),
              DropdownButton<String>(isExpanded: true, value: to, items: widget.fsm.states.map((s) => DropdownMenuItem(value: s, child: Text('To: $s'))).toList(), onChanged: (v) => setDialogState(() => to = v!)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add'))],
        ),
      ),
    );
    if (confirmed != true || inputController.text.trim().isEmpty) return;

    setState(() => widget.fsm.transitions.add(FsmTransition(id: '${DateTime.now().microsecondsSinceEpoch}', fromState: from, onInput: inputController.text.trim(), toState: to)));
    await widget.controller.saveFsm(widget.fsm);
  }

  void _toggleAccepting(String state) {
    setState(() {
      if (widget.fsm.acceptingStates.contains(state)) {
        widget.fsm.acceptingStates.remove(state);
      } else {
        widget.fsm.acceptingStates.add(state);
      }
    });
    widget.controller.saveFsm(widget.fsm);
  }

  Future<void> _run() async {
    widget.fsm.sampleInput = _inputController.text;
    await widget.controller.saveFsm(widget.fsm);
    setState(() => _lastResult = widget.controller.runFsm(widget.fsm, _inputController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.fsm.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [const Text('States', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: _addState)]),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.fsm.states.map((s) {
              final isStart = s == widget.fsm.startState;
              final isAccepting = widget.fsm.acceptingStates.contains(s);
              return GestureDetector(
                onTap: () => _toggleAccepting(s),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isAccepting ? Colors.green.withOpacity(0.15) : Colors.grey.withOpacity(0.1),
                    border: Border.all(color: isAccepting ? Colors.green : Colors.grey, width: isStart ? 2 : 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('$s${isStart ? ' (start)' : ''}${isAccepting ? ' ✓' : ''}', style: const TextStyle(fontSize: 12)),
                ),
              );
            }).toList(),
          ),
          Text('Tap a state to toggle whether it\'s an accepting state.', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          const Divider(height: 32),
          Row(children: [const Text('Transitions', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: _addTransition)]),
          ...widget.fsm.transitions.map((t) => Card(
                child: ListTile(
                  dense: true,
                  title: Text('${t.fromState} --[${t.onInput}]--> ${t.toState}', style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () { setState(() => widget.fsm.transitions.remove(t)); widget.controller.saveFsm(widget.fsm); }),
                ),
              )),
          const Divider(height: 32),
          const Text('Test input (comma-separated symbols)', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _inputController, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. coin,push,push')),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: const Text('Run'), onPressed: _run)),
          if (_lastResult != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: _lastResult!.accepted ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_lastResult!.hitDeadEnd ? 'Halted: no transition defined for that input in that state.' : (_lastResult!.accepted ? 'Accepted — ended in an accepting state.' : 'Rejected — ended in a non-accepting state.'), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._lastResult!.steps.map((step) => Text('${step.fromState} --[${step.inputSymbol}]--> ${step.toState}${step.wasValidTransition ? '' : ' (no such transition)'}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class VmEditorScreen extends StatefulWidget {
  final SimulationCenterController controller;
  final VirtualMachineProgram vm;

  const VmEditorScreen({super.key, required this.controller, required this.vm});

  @override
  State<VmEditorScreen> createState() => _VmEditorScreenState();
}

class _VmEditorScreenState extends State<VmEditorScreen> {
  VmExecutionResult? _lastResult;
  int _viewedStepIndex = 0;

  static const List<String> _opcodes = ['PUSH', 'POP', 'ADD', 'SUB', 'MUL', 'STORE', 'LOAD', 'JMP', 'JZ', 'PRINT', 'HALT'];

  Future<void> _addInstruction() async {
    String opcode = 'PUSH';
    final operandController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add instruction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(isExpanded: true, value: opcode, items: _opcodes.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(), onChanged: (v) => setDialogState(() => opcode = v!)),
              TextField(controller: operandController, decoration: const InputDecoration(labelText: 'Operand (value, register name, or line number)')),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add'))],
        ),
      ),
    );
    if (confirmed != true) return;

    setState(() => widget.vm.instructions.add(VmInstruction(id: '${DateTime.now().microsecondsSinceEpoch}', opcode: opcode, operand: operandController.text.trim())));
    await widget.controller.saveVm(widget.vm);
  }

  Future<void> _run() async {
    setState(() {
      _lastResult = widget.controller.runVm(widget.vm);
      _viewedStepIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.vm.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.vm.instructions.length,
              itemBuilder: (context, index) {
                final instruction = widget.vm.instructions[index];
                final isCurrent = _lastResult != null && _viewedStepIndex < _lastResult!.snapshots.length && _lastResult!.snapshots[_viewedStepIndex].instructionPointer == index;
                return Container(
                  color: isCurrent ? Colors.amber.withOpacity(0.2) : null,
                  child: ListTile(
                    dense: true,
                    leading: Text('$index', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    title: Text('${instruction.opcode} ${instruction.operand}', style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 16), onPressed: () { setState(() => widget.vm.instructions.remove(instruction)); widget.controller.saveVm(widget.vm); }),
                  ),
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: const Icon(Icons.add), label: const Text('Add instruction'), onPressed: _addInstruction))),
          const SizedBox(height: 8),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: const Text('Run Program'), onPressed: _run))),
          if (_lastResult != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_lastResult!.error != null)
                    Text(_lastResult!.error!, style: const TextStyle(color: Colors.red, fontSize: 12))
                  else ...[
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.skip_previous, size: 20), onPressed: _viewedStepIndex > 0 ? () => setState(() => _viewedStepIndex--) : null),
                        Text('Step ${_viewedStepIndex + 1} / ${_lastResult!.snapshots.length}'),
                        IconButton(icon: const Icon(Icons.skip_next, size: 20), onPressed: _viewedStepIndex < _lastResult!.snapshots.length - 1 ? () => setState(() => _viewedStepIndex++) : null),
                      ],
                    ),
                    if (_lastResult!.snapshots.isNotEmpty) ...[
                      Text('Stack: ${_lastResult!.snapshots[_viewedStepIndex].stack}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                      Text('Registers: ${_lastResult!.snapshots[_viewedStepIndex].registers}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                    ],
                  ],
                  if (_lastResult!.printedOutput.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text('Output: ${_lastResult!.printedOutput.join(', ')}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
