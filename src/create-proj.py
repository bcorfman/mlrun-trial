import mlrun

project = mlrun.get_or_create_project("quick-tutorial", "./", user_project=True)

data_gen_fn = project.set_function(
    "data-prep.py",
    name="data-prep",
    kind="job",
    image="mlrun/mlrun",
    handler="breast_cancer_generator",
)
project.save()

gen_data_run = project.run_function("data-prep", local=True)

"""trainer = mlrun.import_function("hub://auto_trainer")
trainer_run = project.run_function(
    trainer,
    inputs={"dataset": gen_data_run.outputs["dataset"]},
    params={
        "model_class": "sklearn.ensemble.RandomForestClassifier",
        "train_test_split_size": 0.2,
        "label_columns": "label",
        "model_name": "cancer",
    },
    handler="train",
)
trainer_run.artifact("confusion-matrix").show()

serving_fn = mlrun.new_function(
    "serving",
    image="mlrun/mlrun",
    kind="serving",
    requirements=["scikit-learn~=1.4.0"],
)

serving_fn.add_model(
    "cancer-classifier",
    model_path=trainer_run.outputs["model"],
    class_name="mlrun.frameworks.sklearn.SklearnModelServer",
)
 """
