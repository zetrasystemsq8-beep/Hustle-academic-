predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    print(f"Validation accuracy: {accuracy:.4f}")

    joblib.dump(model, "model.joblib")
    print("Saved model.joblib")

    with open("metrics.json", "w") as f:
        json.dump({"accuracy": accuracy}, f)
    print("Saved metrics.json")
