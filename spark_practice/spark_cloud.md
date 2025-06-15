#### Create dataproc instance
```bash
gsutil cp spark_local.py gs://spark_practice_dataproc_bucket/code/

--input_green=gs://spark_practice_dataproc_bucket/pq/green/2021/* \
--input_yellow=gs://spark_practice_dataproc_bucket/pq/yellow/2021/* \
--output=gs://spark_practice_dataproc_bucket/report-2021

gcloud dataproc jobs submit pyspark \
    --cluster=spark-practice-cluster \
    --region=europe-north2 \
    gs://spark_practice_dataproc_bucket/code/spark_local.py \
    -- \
        --input_green=gs://spark_practice_dataproc_bucket/pq/green/2020/* \
        --input_yellow=gs://spark_practice_dataproc_bucket/pq/yellow/2020/* \
        --output=gs://spark_practice_dataproc_bucket/report-2020

gsutil cp spark_big_query.py gs://spark_practice_dataproc_bucket/code/
gcloud dataproc jobs submit pyspark \
    --cluster=spark-practice-cluster \
    --region=europe-north2 \
    gs://spark_practice_dataproc_bucket/code/spark_big_query.py \
    -- \
        --input_green=gs://spark_practice_dataproc_bucket/pq/green/2021/* \
        --input_yellow=gs://spark_practice_dataproc_bucket/pq/yellow/2021/* \
        --output=spark_big_query.reports-2021
```