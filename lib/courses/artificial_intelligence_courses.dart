// ============================================================
// ARTIFICIAL INTELLIGENCE COURSES
// lib/courses/artificial_intelligence_courses.dart
// ============================================================
// Add this import to main.dart:
// import 'courses/artificial_intelligence_courses.dart';
// Then spread it inside kCourses:
// ...artificialIntelligenceCourses,
// ============================================================

import 'package:flutter/material.dart';
import '../main.dart';

final List<AppCourse> artificialIntelligenceCourses = [
  // Course 1: Machine Learning Fundamentals - Beginner
  AppCourse(
    id: 'artificial_intelligence_ml_101',
    title: 'Machine Learning Fundamentals',
    description: '''Master the core concepts of machine learning: regression, classification, clustering, and evaluation. Build predictive models with scikit-learn and understand the entire ML pipeline from data prep to deployment.''',
    instructor: 'Chidi Okonkwo',
    category: 'Artificial Intelligence',
    difficulty: 'Beginner',
    icon: Icons.psychology,
    color: Color(0xFF2196F3),
    duration: '14 hours',
    lessons: [
      AppLesson(
        title: 'What is Machine Learning?',
        body: '''Machine learning is a subset of AI that enables systems to learn from data without explicit programming. It's used in spam detection, recommendation systems, and fraud detection. The core idea is to find patterns in data and make predictions or decisions.

There are three main types: supervised learning (labeled data), unsupervised learning (unlabeled data), and reinforcement learning (trial and error). In this course, we focus on supervised and unsupervised. You'll learn the terminology: features, labels, training set, test set, and model.

We'll use Python and scikit-learn throughout. Install Anaconda or Jupyter to follow along. The first step is always understanding your data – we'll start with a simple dataset: the Iris flower dataset.''',
        codeSnippet: '''import pandas as pd
from sklearn.datasets import load_iris

iris = load_iris()
df = pd.DataFrame(iris.data, columns=iris.feature_names)
df['target'] = iris.target
print(df.head())''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Data Preprocessing and Exploration',
        body: '''Real-world data is messy. You'll handle missing values, outliers, and scale features. Learn to use pandas for data wrangling and matplotlib/seaborn for visualization. Exploratory data analysis (EDA) reveals patterns and informs feature engineering.

We'll cover imputation, one-hot encoding, and train-test splitting. Standardization (z-score) and normalization (min-max) are crucial for many algorithms. Visualize distributions and correlations to identify relationships.

Practice on the Titanic dataset: clean age, fare, and embarkation columns, then explore survival rates by gender and class. This prepares you for building your first model.''',
        codeSnippet: '''from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

X = df.drop('target', axis=1)
y = df['target']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Linear Regression and Evaluation',
        body: '''Linear regression predicts a continuous target. Learn the math behind ordinary least squares, cost function (MSE), and gradient descent. Understand assumptions: linearity, independence, homoscedasticity, and normality.

Implement linear regression using scikit-learn's LinearRegression. Evaluate with R-squared, MAE, and RMSE. Overfitting occurs when the model memorizes noise instead of learning general patterns.

We'll predict house prices using the Boston housing dataset. Plot residuals to check assumptions. This is the foundation for all regression tasks in industry.''',
        codeSnippet: '''from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

model = LinearRegression()
model.fit(X_train_scaled, y_train)
y_pred = model.predict(X_test_scaled)

print(f"RMSE: {mean_squared_error(y_test, y_pred, squared=False):.2f}")
print(f"R2: {r2_score(y_test, y_pred):.2f}")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Logistic Regression and Classification',
        body: '''Logistic regression is used for binary classification. It outputs probabilities using the sigmoid function. Decision boundary, threshold tuning, and class imbalance are key concepts.

Evaluate classification with confusion matrix, precision, recall, F1-score, and ROC-AUC. Use scikit-learn's LogisticRegression. Handle imbalanced data with class_weight or SMOTE.

We'll build a spam classifier using the SMS Spam Collection dataset. This is a classic beginner project that demonstrates the entire classification pipeline.''',
        codeSnippet: '''from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, roc_auc_score

clf = LogisticRegression(class_weight='balanced')
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
print(classification_report(y_test, y_pred))
print(f"ROC-AUC: {roc_auc_score(y_test, clf.predict_proba(X_test)[:,1]):.2f}")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Decision Trees and Random Forests',
        body: '''Decision trees are intuitive and interpretable. They split data based on feature values, maximizing information gain or minimizing Gini impurity. However, they overfit easily. Random forests build many trees and average their predictions, reducing variance and improving generalisation.

Learn about feature importance, pruning, and hyperparameters like max_depth and n_estimators. Use GridSearchCV to tune parameters. Random forests handle non-linear relationships and mixed data types well.

We'll classify customer churn using a telecom dataset. This is a common business problem where interpretability matters, so we'll also plot the decision tree and analyse feature importance.''',
        codeSnippet: '''from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV

param_grid = {'n_estimators': [50, 100], 'max_depth': [5, 10, None]}
rf = RandomForestClassifier(random_state=42)
grid = GridSearchCV(rf, param_grid, cv=5)
grid.fit(X_train, y_train)
best_rf = grid.best_estimator_
print(f"Best params: {grid.best_params_}")
print(f"Accuracy: {best_rf.score(X_test, y_test):.2f}")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Clustering with K-Means',
        body: '''Unsupervised learning finds hidden structure in data. K-means partitions data into k clusters by minimising within-cluster variance. Choose k using the elbow method or silhouette score.

We'll apply K-means to customer segmentation – grouping customers by purchasing behaviour. This is used in marketing and personalisation. Learn to scale features before clustering.

We'll also visualise clusters in 2D with PCA. This hands-on experience prepares you for customer analytics projects.''',
        codeSnippet: '''from sklearn.cluster import KMeans
from sklearn.decomposition import PCA

kmeans = KMeans(n_clusters=3, random_state=42)
clusters = kmeans.fit_predict(X_scaled)
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)
df['cluster'] = clusters
# Plot using matplotlib''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Model Evaluation and Cross-Validation',
        body: '''You must evaluate models robustly. Cross-validation (k-fold) gives a better estimate of performance than a single train-test split. Use cross_val_score to compare algorithms. Understand the bias-variance tradeoff.

We'll compare logistic regression, decision tree, and random forest using 5-fold CV on the same dataset. Learn to use learning curves to diagnose underfitting/overfitting.

This lesson is crucial for choosing the best model in production. You'll also learn to interpret validation curves for tuning hyperparameters.''',
        codeSnippet: '''from sklearn.model_selection import cross_val_score

models = [LogisticRegression(), DecisionTreeClassifier(), RandomForestClassifier()]
scores = {}
for model in models:
    score = cross_val_score(model, X, y, cv=5, scoring='accuracy')
    scores[type(model).__name__] = score.mean()
print(scores)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: ML in the Industry',
        body: '''How do companies use ML? You'll work on predictive maintenance, demand forecasting, credit scoring, or personalization. Deliverables include a model API, a Jupyter notebook with EDA, and a report explaining performance and limitations.

Freelance gigs often ask for a proof-of-concept (POC) with clear business metrics. Employers expect you to version models (DVC), track experiments (MLflow), and deploy via Flask/FastAPI. We'll simulate a client request: build a churn predictor and present it as a brief slide deck.

This lesson bridges technical skills and business communication – a non-negotiable hireable trait.''',
        codeSnippet: '''# Sample Flask API for model serving
from flask import Flask, request, jsonify
app = Flask(__name__)
model = joblib.load('model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    features = [data['feature1'], data['feature2']]
    pred = model.predict([features])[0]
    return jsonify({'prediction': int(pred)})

if __name__ == '__main__':
    app.run(debug=True)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls in ML',
        body: '''Leaky data: when information from the future or test set influences training. Always split before any preprocessing. Also, ignoring class imbalance leads to poor minority class performance. Use stratified sampling.

Another pitfall: not using a baseline model (e.g., always predict majority class). Overreliance on accuracy with imbalanced data is misleading. We'll debug a faulty churn model step by step, fixing leaks and evaluation metrics.

We'll also discuss p-hacking and over-engineering. Keep it simple: start with linear models, then complex if needed.''',
        codeSnippet: '''# Pitfall: scaling before split
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)  # uses all data, leaks test info
X_train, X_test = split(X_scaled, y)  # wrong order

# Correct:
X_train, X_test, y_train, y_test = train_test_split(X, y)
scaler.fit(X_train)
X_train_scaled = scaler.transform(X_train)
X_test_scaled = scaler.transform(X_test)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Customer Churn Prediction Pipeline',
        body: '''Build an end-to-end churn prediction pipeline: load data, clean, perform EDA with visualizations, train a random forest with hyperparameter tuning, evaluate with ROC-AUC and precision-recall, and save the model. Deploy as a simple Flask API that accepts customer features and returns churn probability.

Include a README with installation steps, data source, and model performance. Write unit tests for data validation. This project mimics a real-world assignment from a fintech company.

Upload to GitHub and include in your portfolio. It demonstrates your ability to deliver a complete ML solution from data to deployment.''',
        codeSnippet: '''# Pipeline script
import pandas as pd
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder, StandardScaler

numeric_features = ['tenure', 'monthly_charges']
categorical_features = ['gender', 'contract_type']

preprocessor = ColumnTransformer([
    ('num', StandardScaler(), numeric_features),
    ('cat', OneHotEncoder(), categorical_features)
])

pipeline = Pipeline([
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier(n_estimators=100, random_state=42))
])

pipeline.fit(X_train, y_train)
joblib.dump(pipeline, 'churn_model.pkl')''',
        hasImage: false,
      ),
    ],
  ),

  // Course 2: Deep Learning with TensorFlow - Intermediate
  AppCourse(
    id: 'artificial_intelligence_deep_learning_101',
    title: 'Deep Learning with TensorFlow',
    description: '''Build and train neural networks for image, text, and sequential data using TensorFlow and Keras. Cover CNNs, RNNs, transfer learning, and deployment.''',
    instructor: 'Adaobi Nnamdi',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.memory,
    color: Color(0xFFFF9800),
    duration: '16 hours',
    lessons: [
      AppLesson(
        title: 'Neural Networks from Scratch',
        body: '''A neural network consists of layers of neurons with weights and biases. Forward propagation computes output; backpropagation adjusts weights using gradient descent. Activation functions (ReLU, sigmoid, tanh) introduce non-linearity.

Build a simple feedforward network using NumPy to understand the math. Then use TensorFlow/Keras to build the same network more easily. We'll start with MNIST digit classification.

Learn about loss functions, optimizers (SGD, Adam), and the importance of learning rate. This foundation is essential for all deep learning.''',
        codeSnippet: '''import tensorflow as tf
from tensorflow.keras import layers, models

model = models.Sequential([
    layers.Dense(128, activation='relu', input_shape=(784,)),
    layers.Dense(64, activation='relu'),
    layers.Dense(10, activation='softmax')
])
model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
history = model.fit(x_train, y_train, epochs=10, validation_data=(x_val, y_val))''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Convolutional Neural Networks (CNNs)',
        body: '''CNNs are designed for image data. They use convolutional layers to extract spatial features, pooling layers to reduce dimensions, and fully connected layers for classification. Learn about filters, stride, padding, and feature maps.

We'll build a CNN for CIFAR-10 image classification. Use data augmentation to prevent overfitting. Understand the effect of depth and kernel size.

This is the standard architecture for computer vision tasks like object detection and image segmentation.''',
        codeSnippet: '''model = models.Sequential([
    layers.Conv2D(32, (3,3), activation='relu', input_shape=(32,32,3)),
    layers.MaxPooling2D((2,2)),
    layers.Conv2D(64, (3,3), activation='relu'),
    layers.MaxPooling2D((2,2)),
    layers.Conv2D(64, (3,3), activation='relu'),
    layers.Flatten(),
    layers.Dense(64, activation='relu'),
    layers.Dense(10, activation='softmax')
])''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Transfer Learning and Pretrained Models',
        body: '''Training large CNNs from scratch requires massive data and compute. Transfer learning leverages pretrained models (e.g., ResNet, VGG, EfficientNet) trained on ImageNet. You freeze early layers and fine-tune later ones for your task.

We'll use TensorFlow Hub or keras.applications to load a pretrained model and adapt it to a custom dataset (e.g., cat/dog classification). This is the industry standard for most vision tasks.

Learn about feature extraction vs fine-tuning, and how to choose the right pretrained model. This can save weeks of training time.''',
        codeSnippet: '''from tensorflow.keras.applications import ResNet50
from tensorflow.keras import layers, models

base_model = ResNet50(weights='imagenet', include_top=False, input_shape=(224,224,3))
base_model.trainable = False  # freeze

model = models.Sequential([
    base_model,
    layers.GlobalAveragePooling2D(),
    layers.Dense(128, activation='relu'),
    layers.Dense(1, activation='sigmoid')
])
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Recurrent Neural Networks (RNNs) and LSTMs',
        body: '''RNNs process sequential data like time series and text. They have internal memory but suffer from vanishing gradients. LSTMs (Long Short-Term Memory) and GRUs solve this with gating mechanisms.

We'll build a sentiment analysis model using LSTM on IMDb movie reviews. Learn to embed text, pad sequences, and use bidirectional LSTMs for improved context.

RNNs are used in NLP, speech recognition, and forecasting. We'll also cover stacked RNNs and attention basics.''',
        codeSnippet: '''from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

tokenizer = Tokenizer(num_words=10000)
tokenizer.fit_on_texts(texts)
sequences = tokenizer.texts_to_sequences(texts)
X = pad_sequences(sequences, maxlen=100)

model = models.Sequential([
    layers.Embedding(10000, 64, input_length=100),
    layers.LSTM(64, return_sequences=True),
    layers.LSTM(32),
    layers.Dense(1, activation='sigmoid')
])''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Generative Models: GANs and VAEs',
        body: '''Generative models learn the data distribution and can generate new samples. GANs (Generative Adversarial Networks) consist of a generator and discriminator competing. VAEs (Variational Autoencoders) use a probabilistic encoder-decoder.

We'll implement a GAN to generate handwritten digits (MNIST). Understand the training dynamics, mode collapse, and evaluation metrics like inception score.

Generative AI is exploding in popularity. This lesson gives you hands-on with the underlying technology behind tools like DALL-E and Stable Diffusion.''',
        codeSnippet: '''generator = models.Sequential([
    layers.Dense(128, activation='relu', input_dim=100),
    layers.Dense(256, activation='relu'),
    layers.Dense(784, activation='sigmoid')
])
discriminator = models.Sequential([
    layers.Dense(256, activation='relu', input_shape=(784,)),
    layers.Dense(128, activation='relu'),
    layers.Dense(1, activation='sigmoid')
])
# Compile with binary_crossentropy and train alternately''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Model Deployment with TensorFlow Serving',
        body: '''Deploying models in production requires scalability and low latency. TensorFlow Serving can serve multiple models, handle versioning, and expose a REST/gRPC API.

We'll save a trained Keras model in SavedModel format, set up a local TF Serving container with Docker, and send prediction requests. Also cover serving with Flask as an alternative.

This is a must-have skill for MLOps. You'll learn to monitor model performance and rollback if needed.''',
        codeSnippet: '''# Save model
model.save('my_model', save_format='tf')

# Run TF Serving with Docker:
# docker run -p 8501:8501 --mount type=bind,source=/path/to/model,target=/models/my_model -e MODEL_NAME=my_model -t tensorflow/serving

# Python request
import requests
data = {"instances": [input_features]}
response = requests.post('http://localhost:8501/v1/models/my_model:predict', json=data)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Professional Context: Deep Learning in Industry',
        body: '''Deep learning is used in autonomous driving, medical imaging, fraud detection, and recommendation systems. Employers value expertise in PyTorch or TensorFlow, and understanding of distributed training.

Freelance projects often involve fine-tuning a model on a custom dataset. Deliverables include the trained model, a simple API, and a demo notebook. Know how to handle limited data with augmentation and transfer learning.

We'll discuss a real case: building a defect detection system for a manufacturing client. This includes data collection, annotation, model selection, and deployment constraints.''',
        codeSnippet: '''# Example of data augmentation
from tensorflow.keras.preprocessing.image import ImageDataGenerator

datagen = ImageDataGenerator(
    rotation_range=20,
    width_shift_range=0.2,
    height_shift_range=0.2,
    horizontal_flip=True
)
train_generator = datagen.flow(x_train, y_train, batch_size=32)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Pitfalls and Debugging Neural Nets',
        body: '''Training neural networks can be frustrating. Watch for exploding/vanishing gradients – use batch normalization and proper weight initialization. Overfitting is common – use dropout, regularization, and early stopping.

Other pitfalls: wrong learning rate, insufficient data, or misconfigured loss function. We'll use TensorBoard to monitor training and debug. Learn to spot when a model is not learning at all (loss flat) or diverging (loss NaN).

We'll fix a broken CNN step by step, applying these debugging techniques. This prepares you for real-world troubleshooting.''',
        codeSnippet: '''# Early stopping
callback = tf.keras.callbacks.EarlyStopping(monitor='val_loss', patience=3)
model.fit(..., callbacks=[callback])

# Reduce learning rate on plateau
lr_callback = tf.keras.callbacks.ReduceLROnPlateau(monitor='val_loss', factor=0.5, patience=2)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Image Classifier with Deployment',
        body: '''Build an image classifier for a custom dataset of your choice (e.g., flowers, airplanes, or food). Use transfer learning with a pretrained EfficientNet. Apply data augmentation, fine-tune, and achieve >90% accuracy.

Export the model in SavedModel format and deploy it using TensorFlow Serving or a FastAPI wrapper. Create a simple React frontend to upload an image and display the top-3 predictions.

This project demonstrates full-stack AI capability. Write thorough documentation and include a Dockerfile for reproducibility. It's a standout portfolio piece.''',
        codeSnippet: '''# FastAPI deployment
from fastapi import FastAPI, File, UploadFile
from PIL import Image
import numpy as np
import tensorflow as tf

app = FastAPI()
model = tf.keras.models.load_model('efficientnet_finetuned.h5')

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    image = Image.open(file.file).resize((224,224))
    img_array = np.array(image) / 255.0
    img_batch = np.expand_dims(img_array, axis=0)
    preds = model.predict(img_batch)
    top_classes = np.argsort(preds[0])[::-1][:3]
    return {"predictions": top_classes.tolist()}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 3: Natural Language Processing - Intermediate
  AppCourse(
    id: 'artificial_intelligence_nlp_101',
    title: 'Natural Language Processing (NLP)',
    description: '''Process and analyse text data using classical NLP and modern transformers. Cover tokenisation, embeddings, sentiment analysis, NER, and fine-tuning BERT.''',
    instructor: 'Tunde Adebayo',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.chat_bubble,
    color: Color(0xFF4CAF50),
    duration: '15 hours',
    lessons: [
      AppLesson(
        title: 'Text Preprocessing and Tokenisation',
        body: '''Text data is unstructured. Clean it by lowercasing, removing punctuation, and removing stopwords. Tokenisation splits text into words or subwords. Use NLTK or SpaCy for these tasks.

We'll apply stemming (Porter) and lemmatisation to reduce words to base forms. Build a simple bag-of-words model and a TF-IDF vectorizer. This transforms text into numerical features for classical ML.

Practice on a product review dataset to build a sentiment baseline. This foundation is essential before jumping to neural methods.''',
        codeSnippet: '''import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer

nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

text = "The movie was absolutely fantastic!"
tokens = word_tokenize(text.lower())
tokens = [t for t in tokens if t.isalpha()]
stop = set(stopwords.words('english'))
tokens = [t for t in tokens if t not in stop]
lemmatizer = WordNetLemmatizer()
tokens = [lemmatizer.lemmatize(t) for t in tokens]''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Word Embeddings (Word2Vec, GloVe)',
        body: '''Word embeddings map words to dense vectors capturing semantic meaning. Word2Vec uses CBOW or skip-gram; GloVe is based on co-occurrence matrices. These embeddings improve ML models by providing more expressive features.

We'll load pretrained GloVe vectors and use them as input to a classifier. Also train our own Word2Vec on a corpus. Visualise embeddings with t-SNE to see semantic clusters.

Embeddings are the bridge to deep learning for NLP. They're used in modern transformers as input token representations.''',
        codeSnippet: '''from gensim.models import Word2Vec
sentences = [["I", "love", "NLP"], ["NLP", "is", "fun"]]
model = Word2Vec(sentences, vector_size=100, window=5, min_count=1, workers=4)
print(model.wv.most_similar("love"))''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Sentiment Analysis with RNNs',
        body: '''Build a sentiment classifier using LSTM on IMDB reviews. Use embedding layer, LSTM, and dense layers. Compare with a simple logistic regression on TF-IDF to see the benefit of deep learning.

We'll also use pre-trained GloVe embeddings as weights in the embedding layer. This improves performance with less data.

We'll evaluate with accuracy and confusion matrix, and analyse misclassified examples. This is a classic NLP task that every data scientist should master.''',
        codeSnippet: '''model = models.Sequential([
    layers.Embedding(vocab_size, 64, input_length=100, weights=[embedding_matrix], trainable=False),
    layers.LSTM(64, dropout=0.2),
    layers.Dense(1, activation='sigmoid')
])''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Named Entity Recognition (NER)',
        body: '''NER identifies entities like persons, organisations, locations, and dates in text. It's used in information extraction and search. We'll use SpaCy's pre-trained NER model and also train our own using a custom dataset.

Learn about BIO tagging (Begin, Inside, Outside) and sequence labelling. We'll implement a simple CRF model and compare with a BiLSTM-CRF architecture.

This skill is valuable for building chatbots, resume parsers, and news aggregation systems.''',
        codeSnippet: '''import spacy
nlp = spacy.load("en_core_web_sm")
doc = nlp("Apple Inc. is planning to open a new store in London next year.")
for ent in doc.ents:
    print(ent.text, ent.label_)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Transformers and BERT',
        body: '''Transformers have revolutionised NLP with self-attention mechanisms, allowing parallel processing of sequences. BERT (Bidirectional Encoder Representations from Transformers) is pre-trained on masked language modelling and next sentence prediction.

We'll fine-tune BERT for a downstream task using the Hugging Face Transformers library. Learn about tokenizers (WordPiece), input formats, and classification heads.

We'll fine-tune on a custom sentiment dataset to achieve state-of-the-art results. This is the modern standard for NLP.''',
        codeSnippet: '''from transformers import BertTokenizer, BertForSequenceClassification, Trainer, TrainingArguments

tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertForSequenceClassification.from_pretrained('bert-base-uncased', num_labels=2)
# Prepare dataset, trainer, and train''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Topic Modelling with LDA',
        body: '''Topic modelling discovers abstract topics in a collection of documents. Latent Dirichlet Allocation (LDA) is a generative probabilistic model. We'll use gensim to extract topics from a corpus of news articles.

Learn to preprocess for topic modelling, choose the number of topics, and interpret results with pyLDAvis. This is used in content recommendation and trend analysis.

We'll build a simple news article categorizer based on topic distributions. This is a practical tool for content organisers.''',
        codeSnippet: '''from gensim import corpora, models
dictionary = corpora.Dictionary(processed_docs)
corpus = [dictionary.doc2bow(doc) for doc in processed_docs]
lda = models.LdaModel(corpus, num_topics=5, id2word=dictionary)
for idx, topic in lda.print_topics(-1):
    print(f"Topic {idx}: {topic}")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: NLP in Business',
        body: '''NLP is used in customer support (chatbots), HR (resume screening), legal (contract analysis), and healthcare (clinical NLP). Employers value knowledge of both classical and transformer models.

Freelance projects often involve building a sentiment dashboard or a product review summarizer. Deliverables include an API endpoint, a Jupyter notebook explaining the pipeline, and a simple UI for demo.

We'll simulate a client request: build a system to classify incoming support tickets into categories. We'll discuss data labelling, model selection, and deployment considerations.''',
        codeSnippet: '''# Deployment using FastAPI
from fastapi import FastAPI, Request
app = FastAPI()

@app.post("/classify")
async def classify(request: Request):
    data = await request.json()
    text = data['text']
    pred = pipeline(text)
    return {"category": pred}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Mistakes and Debugging NLP',
        body: '''NLP pitfalls: tokenisation mismatches, out-of-vocabulary words, and overfitting due to small datasets. Also, not handling domain shift – models trained on Wikipedia may not work on legal text.

Learn to use data augmentation (back-translation, synonym replacement) to improve generalisation. Use cross-validation and monitor test performance.

We'll debug a sentiment model that fails on new data, applying these fixes. This prepares you for real-world adaptation challenges.''',
        codeSnippet: '''# Data augmentation with nlpaug
import nlpaug.augmenter.word as naw
aug = naw.SynonymAug(aug_src='wordnet')
text = "The product is great."
augmented = aug.augment(text)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Sentiment Analysis with BERT Deployment',
        body: '''Build a sentiment analysis microservice using fine-tuned BERT. Collect a dataset of movie reviews (or use IMDB), fine-tune BERT with Hugging Face, and deploy the model using FastAPI.

Add a simple HTML frontend that lets users type a review and see the sentiment (positive/negative) with confidence. Containerise with Docker and push to a cloud provider like Heroku or AWS.

This project showcases your ability to handle modern NLP models in production. Include a blog post explaining your approach. It's a strong addition to any AI portfolio.''',
        codeSnippet: '''# sentiment_pipeline.py
from transformers import pipeline
sentiment_pipeline = pipeline("sentiment-analysis", model="your-finetuned-bert")

# FastAPI app
@app.post("/sentiment")
def sentiment(request: Request):
    text = request.json["text"]
    result = sentiment_pipeline(text)[0]
    return {"label": result["label"], "score": result["score"]}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 4: Computer Vision - Intermediate
  AppCourse(
    id: 'artificial_intelligence_computer_vision_101',
    title: 'Computer Vision with OpenCV and PyTorch',
    description: '''Master image processing, object detection, segmentation, and face recognition using OpenCV and PyTorch. Build real-world vision applications.''',
    instructor: 'Zainab Bello',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.visibility,
    color: Color(0xFF9C27B0),
    duration: '14 hours',
    lessons: [
      AppLesson(
        title: 'Image Processing with OpenCV',
        body: '''OpenCV is the standard library for image processing. Learn to read, write, and display images. Apply filters: blur, edge detection (Canny), and morphological operations (erosion, dilation).

We'll also cover image transformations: resizing, rotation, and perspective correction. Use colour spaces (RGB, HSV) for object tracking based on colour.

We'll build a simple application that detects and circles red objects in real-time video. This is the foundation for any vision system.''',
        codeSnippet: '''import cv2
import numpy as np

img = cv2.imread('image.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray, 100, 200)
cv2.imshow('Edges', edges)
cv2.waitKey(0)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Feature Detection and Matching',
        body: '''Features are distinctive points or patterns in images. SIFT, SURF, and ORB detect keypoints and compute descriptors. Matching features across images enables panorama stitching and object recognition.

We'll implement feature matching to find correspondences between two images of the same object. Use RANSAC to filter outliers.

This is used in augmented reality and image registration. We'll build a simple panorama stitcher that combines overlapping images.''',
        codeSnippet: '''sift = cv2.SIFT_create()
kp1, des1 = sift.detectAndCompute(img1, None)
kp2, des2 = sift.detectAndCompute(img2, None)

bf = cv2.BFMatcher()
matches = bf.knnMatch(des1, des2, k=2)
good = [m for m,n in matches if m.distance < 0.75*n.distance]''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Object Detection with YOLO and SSD',
        body: '''Modern object detection uses deep learning. YOLO (You Only Look Once) is fast and accurate for real-time detection. SSD (Single Shot MultiBox Detector) is another popular model.

We'll load a pretrained YOLOv5 model from Ultralytics and run inference on images/videos. Learn to interpret bounding boxes, class labels, and confidence scores.

We'll also train YOLO on a custom dataset (e.g., detecting vehicles in traffic). This skill is essential for surveillance, autonomous driving, and retail analytics.''',
        codeSnippet: '''from ultralytics import YOLO
model = YOLO('yolov5s.pt')
results = model('image.jpg')
boxes = results[0].boxes
for box in boxes:
    print(f"Class {box.cls} at {box.xyxy} with confidence {box.conf}")''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Semantic Segmentation and Instance Segmentation',
        body: '''Segmentation classifies every pixel in an image. U-Net is common for biomedical images; DeepLab and Mask R-CNN are state-of-the-art. Instance segmentation separates individual objects.

We'll use a pretrained Mask R-CNN model to segment objects in images. Understand the architecture: backbone, region proposal network, and heads for classification, bounding box, and mask.

We'll apply segmentation to count cells in a microscope image. This is crucial for medical imaging and autonomous driving.''',
        codeSnippet: '''import torch
import torchvision
model = torchvision.models.detection.maskrcnn_resnet50_fpn(pretrained=True)
model.eval()
image = torchvision.io.read_image('image.jpg').unsqueeze(0).float()/255.0
with torch.no_grad():
    prediction = model(image)
print(prediction)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Face Recognition and Detection',
        body: '''Face detection using Haar cascades or DNNs. Face recognition with deep learning models like FaceNet or ArcFace. We'll use OpenCV's face detector and the face_recognition library.

Build a system that detects faces in real-time and identifies known individuals. Learn about face alignment and embedding extraction.

We'll create a simple attendance system that marks presence when a known face is detected. This is a common project for freelancers.''',
        codeSnippet: '''import face_recognition
known_image = face_recognition.load_image_file("person.jpg")
known_encoding = face_recognition.face_encodings(known_image)[0]
unknown_image = face_recognition.load_image_file("unknown.jpg")
unknown_encodings = face_recognition.face_encodings(unknown_image)
for encoding in unknown_encodings:
    matches = face_recognition.compare_faces([known_encoding], encoding)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Image Generation with Diffusion Models',
        body: '''Diffusion models generate high-quality images by denoising gradually. Stable Diffusion is a popular open-source model. We'll use the Hugging Face diffusers library to generate images from text prompts.

Learn about the pipeline: UNet, scheduler, and VAE. We'll also explore image-to-image translation and inpainting.

This is at the forefront of generative AI. You'll be able to create custom images for design and marketing projects.''',
        codeSnippet: '''from diffusers import StableDiffusionPipeline
import torch
pipe = StableDiffusionPipeline.from_pretrained("runwayml/stable-diffusion-v1-5")
pipe.to("cuda")
prompt = "a cat wearing a hat"
image = pipe(prompt).images[0]
image.save("cat.png")''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Professional Context: Computer Vision in Industry',
        body: '''Computer vision is used in quality inspection, retail (shelf monitoring), security, and healthcare. Employers value experience with deployment on edge devices (Raspberry Pi, Jetson) and cloud APIs.

Freelance projects often involve building a custom detector for a specific object (e.g., defects on a production line). Deliverables include a trained model, a real-time inference script, and a simple dashboard.

We'll discuss a case: building a safety vest detector for a construction site. This involves data collection, model training, and integrating with a camera feed.''',
        codeSnippet: '''# Edge deployment with TensorFlow Lite
converter = tf.lite.TFLiteConverter.from_saved_model('model')
tflite_model = converter.convert()
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Pitfalls and Debugging Vision Models',
        body: '''Vision models are sensitive to lighting, occlusion, and data distribution. Overfitting, class imbalance, and incorrect label mapping are common. Use data augmentation to generalise.

Learn to use tools like FiftyOne for dataset visualization and debugging. Monitor loss curves and use gradient clipping for training stability.

We'll fix a broken object detector that misclassifies due to label errors and poor augmentation. This prepares you for real troubleshooting.''',
        codeSnippet: '''# Debugging with FiftyOne
import fiftyone as fo
dataset = fo.Dataset.from_dir('data', fo.types.ImageDirectory)
session = fo.launch_app(dataset)  # inspect labels visually''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Real-time Object Detection Web App',
        body: '''Build a real-time object detection web application using YOLOv5 and Flask. The webcam feed streams to the server, which returns detected objects with bounding boxes. Use WebSocket for low-latency communication.

Include a feature to save snapshots and a confidence threshold slider. Deploy on a cloud VM and test with a mobile camera.

This project demonstrates full-stack vision skills. It's portfolio-worthy and can be extended to specific use cases like retail inventory tracking.''',
        codeSnippet: '''# Flask app with WebSocket
from flask import Flask, render_template, Response
from flask_socketio import SocketIO, emit
import cv2

app = Flask(__name__)
socketio = SocketIO(app)

def generate():
    cap = cv2.VideoCapture(0)
    while True:
        ret, frame = cap.read()
        results = model(frame)
        annotated = results.render()[0]
        _, jpeg = cv2.imencode('.jpg', annotated)
        yield (b'--frame\\r\\n'
               b'Content-Type: image/jpeg\\r\\n\\r\\n' + jpeg.tobytes() + b'\\r\\n')

@app.route('/video_feed')
def video_feed():
    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')''',
        hasImage: false,
      ),
    ],
  ),

  // Course 5: Reinforcement Learning - Advanced
  AppCourse(
    id: 'artificial_intelligence_reinforcement_learning_101',
    title: 'Reinforcement Learning',
    description: '''Learn to build agents that make sequential decisions. Cover MDPs, Q-learning, policy gradients, and Deep Q-Networks (DQN). Apply to games and robotics.''',
    instructor: 'Oluwaseun Ogunyemi',
    category: 'Artificial Intelligence',
    difficulty: 'Advanced',
    icon: Icons.auto_awesome,
    color: Color(0xFFE91E63),
    duration: '16 hours',
    lessons: [
      AppLesson(
        title: 'Markov Decision Processes (MDP)',
        body: '''RL is about agents interacting with an environment. MDP formalizes this with states, actions, rewards, transitions, and discount factor. The goal is to maximise cumulative reward.

We'll define an MDP for a simple grid world. Learn about value function, policy, and Bellman equation. Policy evaluation and policy iteration are classical algorithms.

We'll implement a value iteration solver for the grid world. This is the foundation of all RL algorithms.''',
        codeSnippet: '''import numpy as np

def value_iteration(env, gamma=0.9, theta=1e-6):
    V = np.zeros(env.nS)
    while True:
        delta = 0
        for s in range(env.nS):
            v = V[s]
            max_val = max(sum(p * (r + gamma * V[s_]) for p, s_, r, _ in env.P[s][a]) for a in range(env.nA))
            V[s] = max_val
            delta = max(delta, abs(v - V[s]))
        if delta < theta: break
    return V''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Q-Learning and Temporal Difference',
        body: '''Q-learning is a model-free algorithm that learns action values (Q-values) without knowing transition probabilities. It uses the Bellman optimality equation with a learning rate.

We'll implement Q-learning on the FrozenLake environment from OpenAI Gym. Learn about epsilon-greedy exploration and learning rate schedules.

This is the classic algorithm that paved the way for deep RL. We'll also compare with SARSA (on-policy).''',
        codeSnippet: '''import gym
env = gym.make('FrozenLake-v1')
Q = np.zeros([env.observation_space.n, env.action_space.n])
alpha = 0.1; gamma = 0.99; epsilon = 0.1
for episode in range(1000):
    state = env.reset()[0]
    done = False
    while not done:
        if np.random.random() < epsilon:
            action = env.action_space.sample()
        else:
            action = np.argmax(Q[state])
        next_state, reward, done, _, _ = env.step(action)
        Q[state, action] += alpha * (reward + gamma * np.max(Q[next_state]) - Q[state, action])
        state = next_state''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Deep Q-Networks (DQN)',
        body: '''DQN uses neural networks to approximate Q-values, enabling RL on high-dimensional state spaces (e.g., Atari games). Key innovations: experience replay and target network.

We'll implement a DQN agent for the CartPole environment using PyTorch. Learn to build the network, store transitions, and update using mini-batches.

This is the breakthrough that made RL practical for complex problems. We'll also discuss double DQN and dueling DQN improvements.''',
        codeSnippet: '''import torch
import torch.nn as nn
import torch.optim as optim

class DQN(nn.Module):
    def __init__(self, state_dim, action_dim):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(state_dim, 64),
            nn.ReLU(),
            nn.Linear(64, 64),
            nn.ReLU(),
            nn.Linear(64, action_dim)
        )
    def forward(self, x):
        return self.net(x)

# Training loop with replay buffer and target network''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Policy Gradients and Actor-Critic',
        body: '''Policy gradient methods directly optimise the policy. REINFORCE is a simple algorithm; actor-critic combines value-based and policy-based methods for lower variance.

We'll implement REINFORCE on a continuous environment (e.g., Pendulum). Then implement A2C (Advantage Actor-Critic) for better sample efficiency.

These methods are used in robotics and autonomous driving. We'll also discuss PPO (Proximal Policy Optimization) used in ChatGPT training.''',
        codeSnippet: '''# REINFORCE loss
log_probs = []
rewards = []
for episode in episodes:
    # collect trajectory
    log_prob = dist.log_prob(action)
    log_probs.append(log_prob)
    rewards.append(reward)
# compute discounted rewards
returns = []
G = 0
for r in reversed(rewards):
    G = r + gamma * G
    returns.insert(0, G)
loss = -sum(log_probs[i] * returns[i] for i in range(len(returns)))''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Multi-Agent Reinforcement Learning',
        body: '''Many real problems involve multiple agents interacting (e.g., traffic, economics). We'll discuss cooperative and competitive settings. Learn about independent Q-learning and MADDPG.

Implement a simple two-agent environment (e.g., shared resource) and train agents to coordinate.

This is an advanced topic but increasingly relevant in autonomous systems and game AI.''',
        codeSnippet: '''# Using PettingZoo for multi-agent envs
from pettingzoo.mpe import simple_spread_v2
env = simple_spread_v2.env()
observations = env.reset()
while env.agents:
    actions = {agent: policy(obs) for agent, obs in observations.items()}
    observations, rewards, dones, infos = env.step(actions)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: RL in Industry',
        body: '''RL is used in robotics, game AI, automated trading, and recommendation systems. Employers look for experience with simulation environments (MuJoCo, Isaac Gym) and production scaling.

Freelance projects often involve building a controller for a specific task (e.g., drone navigation). Deliverables include a trained policy, a simulation demo, and a report on sample efficiency.

We'll discuss a case: optimizing a warehouse robot's pick-and-place operation. This includes reward shaping and safe exploration.''',
        codeSnippet: '''# Using Gymnasium for custom env
class CustomEnv(gym.Env):
    def __init__(self):
        # define action_space, observation_space
        pass
    def step(self, action):
        # update state, return obs, reward, done, info
        pass''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls and Debugging RL',
        body: '''RL is notoriously unstable. Catastrophic forgetting, reward scaling, and poor exploration are common. Use reward normalisation and stable baselines.

Debug by plotting episode returns and loss curves. Ensure the environment is properly reset. Check for non-stationarity.

We'll debug a DQN that fails to learn on a simple environment, adjusting hyperparameters and network architecture.''',
        codeSnippet: '''# Reward clipping
reward = np.clip(reward, -1, 1)
# Gradient clipping
torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Atari Game Agent with DQN',
        body: '''Build a DQN agent that plays a classic Atari game (e.g., Breakout or Pong). Use OpenAI Gym Atari environment. Preprocess frames (grayscale, downsampling, stacking).

Train the agent for several million steps and achieve human-level performance. Save the trained model and create a demo video.

This is a classic deep RL project that demonstrates your ability to handle complex visual domains. Include a hyperparameter search report and learning curve visualisation. It's a strong portfolio addition.''',
        codeSnippet: '''# DQN with CNN for Atari
class DQN(nn.Module):
    def __init__(self, n_actions):
        super().__init__()
        self.net = nn.Sequential(
            nn.Conv2d(4, 32, 8, stride=4),
            nn.ReLU(),
            nn.Conv2d(32, 64, 4, stride=2),
            nn.ReLU(),
            nn.Conv2d(64, 64, 3, stride=1),
            nn.ReLU(),
            nn.Flatten(),
            nn.Linear(3136, 512),
            nn.ReLU(),
            nn.Linear(512, n_actions)
        )''',
        hasImage: false,
      ),
    ],
  ),

  // Course 6: MLOps and Model Deployment - Advanced
  AppCourse(
    id: 'artificial_intelligence_mlops_101',
    title: 'MLOps: Deploy and Monitor ML Models',
    description: '''Learn the full lifecycle of ML in production: versioning, CI/CD, monitoring, and infrastructure. Use Docker, MLflow, Kubeflow, and cloud platforms.''',
    instructor: 'Chinwe Eze',
    category: 'Artificial Intelligence',
    difficulty: 'Advanced',
    icon: Icons.hub,
    color: Color(0xFF00BCD4),
    duration: '14 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to MLOps and Lifecycle',
        body: '''MLOps bridges ML development and operations. It covers data versioning, model training, deployment, monitoring, and governance. The goal is reliable and scalable ML.

We'll map the ML lifecycle: data ingestion, feature engineering, model training, evaluation, deployment, monitoring, and retraining. Understand the challenges: reproducibility, drift, and scalability.

We'll set up a basic CI/CD pipeline using GitHub Actions to test and package a model. This is the starting point for production ML.''',
        codeSnippet: '''# sample .github/workflows/ci.yml
name: CI
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
      - run: pip install -r requirements.txt
      - run: pytest tests/''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Data Version Control (DVC)',
        body: '''DVC extends Git to version large datasets and models. It stores data in cloud storage (S3, GCS) while Git tracks metadata. This ensures reproducibility.

We'll initialise DVC, add a dataset, and push to remote storage. Also track model files. This is essential for team collaboration.

We'll practice rolling back to a previous dataset version and retrain. This skill is critical in production environments.''',
        codeSnippet: '''# Initialize DVC
dvc init
dvc add data/raw.csv
git add data/raw.csv.dvc .gitignore
git commit -m "add data"
dvc push

# Pull data on another machine
dvc pull''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Model Experiment Tracking with MLflow',
        body: '''MLflow tracks experiments, parameters, metrics, and artifacts. It supports multiple ML frameworks. We'll log runs during training and compare them.

We'll also use MLflow to save and load models in a standard format. This simplifies model promotion from dev to staging to production.

We'll set up an MLflow tracking server with a UI for visualising experiments. This is widely used in data science teams.''',
        codeSnippet: '''import mlflow
with mlflow.start_run():
    mlflow.log_param("learning_rate", 0.01)
    mlflow.log_metric("accuracy", 0.92)
    mlflow.sklearn.log_model(model, "model")''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Containerization with Docker',
        body: '''Docker packages applications and dependencies into containers, ensuring consistency across environments. We'll write a Dockerfile for a FastAPI ML service.

We'll build an image, run it locally, and test the API. Also cover multi-stage builds and .dockerignore.

This is a prerequisite for deploying on Kubernetes and cloud platforms. We'll also push the image to a registry (Docker Hub).''',
        codeSnippet: '''# Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Kubernetes and Kubeflow',
        body: '''Kubernetes orchestrates containers, enabling auto-scaling and fault tolerance. Kubeflow provides a full ML platform on Kubernetes: pipelines, notebooks, and model serving.

We'll deploy a simple model serving service using KServe (formerly KFServing). Also create a Kubeflow pipeline with components for data prep, training, and deployment.

This is for large-scale ML systems. We'll discuss when to use Kubeflow vs simpler solutions.''',
        codeSnippet: '''# kubeflow pipeline component
from kfp import dsl

@dsl.component
def train_op():
    import subprocess
    subprocess.run(["python", "train.py"])

@dsl.pipeline
def ml_pipeline():
    train_task = train_op()''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Monitoring Drift and Performance',
        body: '''Models degrade over time due to data drift (input distribution changes) and concept drift (target relationship changes). Monitor with tools like Prometheus, Evidently, or WhyLogs.

We'll implement a simple drift detector that computes population stability index (PSI) on incoming features. Also monitor prediction distribution.

We'll set up alerts for when drift exceeds thresholds. This is crucial for maintaining model reliability in production.''',
        codeSnippet: '''# PSI calculation
import numpy as np
def psi(expected, observed, bins=10):
    expected_counts, _ = np.histogram(expected, bins=bins)
    observed_counts, _ = np.histogram(observed, bins=bins)
    psi_value = 0
    for e, o in zip(expected_counts, observed_counts):
        e = (e + 1) / len(expected)  # avoid zero
        o = (o + 1) / len(observed)
        psi_value += (e - o) * np.log(e / o)
    return psi_value''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: MLOps in the Industry',
        body: '''MLOps engineers are in high demand. They work with data scientists and DevOps to automate pipelines. Employers value experience with cloud providers (AWS SageMaker, GCP Vertex AI) and tools like Airflow.

Freelance projects often involve setting up a deployment pipeline for a client's model. Deliverables include a CI/CD pipeline, monitoring dashboard, and documentation.

We'll discuss a case: deploying a fraud detection model with automated retraining weekly. This covers all aspects of MLOps.''',
        codeSnippet: '''# Airflow DAG for retraining
from airflow import DAG
from airflow.operators.python import PythonOperator
dag = DAG('retrain', schedule_interval='@weekly')
task = PythonOperator(task_id='train', python_callable=train_func, dag=dag)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls in MLOps',
        body: '''Common pitfalls: ignoring data drift, using different environments, and not versioning data. Also, overcomplicating infrastructure when a simpler solution works.

Learn to choose between batch vs real-time inference. Understand the cost-performance tradeoff. Use canary deployments and A/B testing for model updates.

We'll walk through a failed deployment and fix it step by step. This teaches you resilience in production settings.''',
        codeSnippet: '''# Canary deployment (Kubernetes)
# Use two services with different weights
# 90% traffic to stable, 10% to canary''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: End-to-End ML Pipeline with CI/CD',
        body: '''Build a full MLOps pipeline for a regression model (e.g., house price prediction). Include data versioning (DVC), experiment tracking (MLflow), testing (pytest), Dockerization, and deployment to a cloud VM (AWS EC2).

Set up a GitHub Actions workflow that triggers on push: runs tests, builds the Docker image, and deploys to the VM. Add a monitoring script that logs PSI and alerts via email.

This project demonstrates your ability to operationalize ML. It's a complex, production-grade system that will impress employers.''',
        codeSnippet: '''# deployment.yaml (GitHub Actions)
name: Deploy
on: push
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Deploy to EC2
      uses: appleboy/ssh-action@v0.1.5
      with:
        host: \${{ secrets.HOST }}
        username: \${{ secrets.USER }}
        key: \${{ secrets.KEY }}
        script: |
          docker pull myregistry/model:latest
          docker run -d -p 80:8000 myregistry/model:latest''',
        hasImage: false,
      ),
    ],
  ),

  // Course 7: Generative AI with LLMs - Intermediate
  AppCourse(
    id: 'artificial_intelligence_generative_ai_101',
    title: 'Generative AI and Large Language Models',
    description: '''Understand and apply generative models including LLMs, prompt engineering, fine-tuning, and RAG. Build chatbots and content generation tools.''',
    instructor: 'Emeka Okafor',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.smart_toy,
    color: Color(0xFFFF5722),
    duration: '15 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to Generative AI and LLMs',
        body: '''Generative AI creates new content: text, images, audio, code. LLMs (Large Language Models) like GPT, LLaMA, and Gemini are trained on massive text corpora. They predict the next token.

We'll cover the architecture: transformer decoder-only for GPT, with attention, feedforward, and layer norm. Parameters, training data, and scaling laws.

We'll use the OpenAI API or Hugging Face to interact with a pretrained model. This hands-on will generate text and explore capabilities.''',
        codeSnippet: '''from openai import OpenAI
client = OpenAI(api_key="your-key")
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "Explain quantum computing in simple terms."}]
)
print(response.choices[0].message.content)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Prompt Engineering and In-Context Learning',
        body: '''Prompt engineering is the art of crafting inputs to elicit desired outputs. Techniques: zero-shot, few-shot, chain-of-thought, and role prompting. We'll practice on various tasks: classification, summarization, and reasoning.

Learn to structure prompts with system messages, examples, and constraints. Evaluate prompt effectiveness with metrics like BLEU or relevance scoring.

We'll build a customer support chatbot using a well-designed prompt. This is a critical skill for anyone using LLMs.''',
        codeSnippet: '''# Few-shot prompt
prompt = """Classify the sentiment as positive, negative, or neutral.
Text: I love this product! -> positive
Text: The service was terrible. -> negative
Text: It's okay, nothing special. -> neutral
Text: The movie was fantastic! ->"""

response = client.completions.create(model="gpt-3.5-turbo-instruct", prompt=prompt)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Fine-Tuning LLMs',
        body: '''Fine-tuning adapts a pretrained model to a specific domain or task. We'll use Hugging Face's Trainer API to fine-tune a small model (e.g., DistilBERT) on a custom dataset (e.g., financial news classification).

Learn about dataset formatting, tokenization, training hyperparameters, and evaluation. We'll also discuss parameter-efficient fine-tuning (LoRA, QLoRA) to reduce compute cost.

This skill is in high demand for domain-specific applications like legal or medical NLP.''',
        codeSnippet: '''from transformers import AutoModelForSequenceClassification, TrainingArguments, Trainer
model = AutoModelForSequenceClassification.from_pretrained("distilbert-base-uncased", num_labels=2)
training_args = TrainingArguments(output_dir="./results", num_train_epochs=3)
trainer = Trainer(model=model, args=training_args, train_dataset=train_dataset)
trainer.train()''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Retrieval-Augmented Generation (RAG)',
        body: '''RAG combines retrieval (e.g., vector search) with generation to answer questions grounded in external documents. It reduces hallucinations and enables up-to-date information.

We'll build a RAG pipeline using LangChain: load documents, split, embed, store in a vector DB (Chroma), and retrieve relevant chunks to feed to an LLM.

This is the architecture behind many enterprise chatbots and Q&A systems. We'll build a company knowledge base chatbot.''',
        codeSnippet: '''from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
from langchain.llms import OpenAI

embedding = OpenAIEmbeddings()
vectordb = Chroma.from_documents(documents, embedding)
qa_chain = RetrievalQA.from_chain_type(llm=OpenAI(), retriever=vectordb.as_retriever())
answer = qa_chain.run("What is the company policy on leave?")''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Evaluating and Monitoring LLMs',
        body: '''LLM evaluation is challenging. Use metrics like BLEU, ROUGE, METEUR for generation, and accuracy for classification. Also, use LLM-as-a-judge with frameworks like G-Eval.

We'll implement a simple evaluation pipeline on a test set. Also discuss bias, toxicity, and safety evaluation using detoxify or perspective API.

We'll set up monitoring for drift in user queries and output quality. This is essential for production LLM applications.''',
        codeSnippet: '''# Using ROUGE score
from rouge_score import rouge_scorer
scorer = rouge_scorer.RougeScorer(['rouge1', 'rougeL'], use_stemmer=True)
scores = scorer.score(reference, generated)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: GenAI in the Industry',
        body: '''Generative AI is transforming industries: content creation, customer support, software development (copilots), and education. Employers value skills in prompt engineering, fine-tuning, and integration.

Freelance gigs often include building a custom chatbot for a business or a content summarizer. Deliverables include a working API, a demo UI, and documentation on prompt design.

We'll discuss a case: building a legal document summarizer for a law firm. This involves fine-tuning a model on legal text and adding citation tracking.''',
        codeSnippet: '''# Use of LangChain for document summarization
from langchain.chains.summarize import load_summarize_chain
chain = load_summarize_chain(llm, chain_type="map_reduce")
summary = chain.run(documents)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls and Debugging GenAI',
        body: '''Common issues: hallucinations, prompt sensitivity, and cost management. Use grounding (RAG) to reduce hallucinations. A/B test prompts to find stable ones.

Also handle rate limits, token limits, and latency. Use caching and batching. Monitor costs with token usage tracking.

We'll debug a chatbot that gives inconsistent answers, applying RAG and better prompt structuring.''',
        codeSnippet: '''# Token counting with tiktoken
import tiktoken
encoding = tiktoken.encoding_for_model("gpt-3.5-turbo")
tokens = encoding.encode("Your text here")
print(len(tokens))''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Custom Knowledge Base Chatbot',
        body: '''Build a RAG-based chatbot for a specific domain (e.g., company policies, product manuals, or academic papers). Use LangChain or LlamaIndex to create a pipeline: ingest documents, chunk, embed, store in a vector DB, and create a chat interface.

Deploy the chatbot using Streamlit or Gradio. Include a feedback mechanism to improve retrieval. Optimise retrieval with hybrid search (keyword + vector).

This project demonstrates practical GenAI application. It's highly relevant for enterprise use and will stand out in your portfolio.''',
        codeSnippet: '''# Streamlit app
import streamlit as st
from langchain.chains import RetrievalQA
qa = RetrievalQA.from_chain_type(llm=OpenAI(), retriever=vectordb.as_retriever())
user_input = st.text_input("Ask me anything:")
if user_input:
    response = qa.run(user_input)
    st.write(response)''',
        hasImage: false,
      ),
    ],
  ),

  // Course 8: AI Ethics and Responsible AI - Intermediate
  AppCourse(
    id: 'artificial_intelligence_ethics_101',
    title: 'AI Ethics and Responsible AI',
    description: '''Understand the societal impact of AI, fairness, accountability, transparency, and privacy. Learn to detect bias, implement fairness metrics, and build ethical AI systems.''',
    instructor: 'Adaora Okafor',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.science,
    color: Color(0xFF795548),
    duration: '12 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to AI Ethics',
        body: '''AI systems can perpetuate bias, invade privacy, and make opaque decisions. We'll cover key principles: fairness, accountability, transparency, and explainability.

We'll discuss historical cases: biased hiring algorithms, facial recognition errors, and predictive policing. Understand the importance of diverse teams and inclusive data.

This lesson sets the moral and professional foundation for building responsible AI. It's increasingly required by regulations (EU AI Act).''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Fairness Metrics and Bias Detection',
        body: '''Fairness metrics quantify bias: demographic parity, equal opportunity, and disparate impact. Use the AI Fairness 360 (AIF360) toolkit to measure bias.

We'll apply these metrics to a loan approval dataset to detect bias against minority groups. Learn to mitigate bias via reweighting, adversarial debiasing, or post-processing.

This is a hands-on skill for ensuring models treat all groups fairly. Employers are increasingly asking for fairness assessments.''',
        codeSnippet: '''from aif360.datasets import BinaryLabelDataset
from aif360.metrics import ClassificationMetric

# Compute disparate impact
metric = ClassificationMetric(dataset_true, dataset_pred, privileged_groups=[{'race':1}], unprivileged_groups=[{'race':0}])
print(metric.disparate_impact())''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Explainability with LIME and SHAP',
        body: '''Black-box models need explanations. LIME (Local Interpretable Model-agnostic Explanations) and SHAP (SHapley Additive exPlanations) explain individual predictions.

We'll apply SHAP to a random forest classifier to see feature contributions. Learn to interpret plots: summary, dependence, and force plots.

Explainability builds trust and helps debug models. It's essential for regulated industries like finance and healthcare.''',
        codeSnippet: '''import shap
explainer = shap.TreeExplainer(model)
shap_values = explainer.shap_values(X_test)
shap.summary_plot(shap_values, X_test)''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Privacy-Preserving ML (Differential Privacy)',
        body: '''Differential privacy ensures that model outputs do not reveal individual data points. Add noise to gradients or outputs. Use Opacus for PyTorch or TensorFlow Privacy.

We'll train a simple model with differential privacy and see the tradeoff between privacy and accuracy.

This is crucial for handling sensitive data (medical, financial). It's a growing field with high demand.''',
        codeSnippet: '''# Using Opacus
from opacus import PrivacyEngine
privacy_engine = PrivacyEngine()
model, optimizer, data_loader = privacy_engine.make_private(
    module=model,
    optimizer=optimizer,
    data_loader=data_loader,
    noise_multiplier=1.0,
    max_grad_norm=1.0,
)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Responsible AI Frameworks and Regulation',
        body: '''Organisations adopt responsible AI frameworks: Microsoft's Responsible AI Standard, Google's AI Principles, and the EU AI Act. We'll map requirements to development practices.

Learn about impact assessments, documentation (model cards), and governance. We'll create a model card for a sample model following the Google model card format.

This knowledge is necessary for compliance and building public trust. It's often a differentiator in hiring.''',
        codeSnippet: '''# Model Card template
## Model Details
- Developer: Your Name
- Version: 1.0
## Intended Use
- Primary use: ...
- Out-of-scope: ...
## Performance
- Accuracy: 0.92
- Fairness: disparity impact 0.95
## Limitations
- ...''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: Ethics in AI Roles',
        body: '''Companies hire AI ethicists, responsible AI engineers, and compliance officers. As a developer, you must incorporate ethical checks in your workflow.

Freelance projects may require bias audits or explainability reports. Deliverables include a fairness assessment, an explanation dashboard, and documentation.

We'll simulate a client request: audit a resume screening model for gender bias. You'll deliver a report with metrics and mitigation strategies.''',
        codeSnippet: '''# Bias audit checklist
1. Define sensitive attributes
2. Compute fairness metrics on test set
3. Compare across subgroups
4. Identify sources of bias (data or algorithm)
5. Propose mitigations''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls in Ethical AI',
        body: '''Pitfalls: treating fairness as a single metric, ignoring intersectionality, and not involving stakeholders. Also, over-reliance on technical fixes without addressing data collection biases.

Learn to use participatory design and include diverse testers. Avoid "fairness washing" – performing minimal checks to appear ethical.

We'll review case studies of failed ethical approaches and learn from them. This prepares you to be a conscientious practitioner.''',
        codeSnippet: '''# Avoiding fairness washing:
# Actually act on findings, not just document them''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Bias Audit and Mitigation',
        body: '''Take a pre-trained model (e.g., from a public repository) on a tabular dataset (e.g., UCI Adult). Perform a full bias audit: compute disparity, equal opportunity, and demographic parity across gender and race.

Apply at least two mitigation techniques (e.g., reweighting and adversarial debiasing). Document the tradeoffs in accuracy vs fairness. Create a report with visualisations and recommendations.

This project showcases your ability to deliver responsible AI solutions, a skill increasingly sought after by companies.''',
        codeSnippet: '''# Using AIF360 for mitigation
from aif360.algorithms.preprocessing import Reweighing
rw = Reweighing(unprivileged_groups=[{'race':0}], privileged_groups=[{'race':1}])
dataset_transf = rw.fit_transform(dataset)''',
        hasImage: false,
      ),
    ],
  ),
];
