-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `gcp-practice-16925.bigquery_dataset.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://gcp-practice-16925-bigquery-bucket/yellow_tripdata_2024-*.parquet']
);

-- Check yello yellow
SELECT * FROM gcp-practice-16925.bigquery_dataset.external_yellow_tripdata limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned AS
SELECT * FROM gcp-practice-16925.bigquery_dataset.external_yellow_tripdata;

SELECT count(*) FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned
WHERE VendorID = 1;

SELECT count(*) FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_partitioned
WHERE VendorID = 1;

SELECT count(*) FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_partitioned_clustered
WHERE VendorID = 1;

-- Impact of partition
-- Scanning 0 MB of data
SELECT COUNT(DISTINCT(PULocationID)) 
FROM gcp-practice-16925.bigquery_dataset.external_yellow_tripdata;

-- Impact of partition
-- Scanning 155.12 MB of data
SELECT COUNT(DISTINCT(PULocationID)) 
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned;

-- Impact of partition
-- Scanning 155.12 MB of data
SELECT PULocationID
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned;

-- Impact of partition
-- Scanning 310.24 MB of data
SELECT PULocationID, DOLocationID
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned;


-- Impact of partition
-- Scanning 155.12 MB of data
SELECT COUNT(1)
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned
WHERE fare_amount = 0;


-- Creating a partition and cluster table
CREATE OR REPLACE TABLE gcp-practice-16925.bigquery_dataset.yellow_tripdata_partitioned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM gcp-practice-16925.bigquery_dataset.external_yellow_tripdata;

SELECT DISTINCT(VendorID)
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_non_partitioned
WHERE tpep_dropoff_datetime > '2024-03-01' and tpep_dropoff_datetime <= '2024-03-15';

SELECT DISTINCT(VendorID)
FROM gcp-practice-16925.bigquery_dataset.yellow_tripdata_partitioned_clustered
WHERE tpep_dropoff_datetime > '2024-03-01' and tpep_dropoff_datetime <= '2024-03-15';

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE gcp-practice-16925.bigquery_dataset.yellow_tripdata_partitioned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM gcp-practice-16925.bigquery_dataset.external_yellow_tripdata;