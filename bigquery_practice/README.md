## Big Query Practice

Quick hack to load files directly to GCS, without Airflow. Downloads csv files from https://nyc-tlc.s3.amazonaws.com/trip+data/ and uploads them to your Cloud Storage Account as parquet files.

1. Install pre-reqs (more info in `web_to_gcs.py` script)
2. Run: `export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/gcp-practice-terraform.json"`
3. Run: `python web_to_gcs.py`