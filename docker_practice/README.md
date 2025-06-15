docker run --rm -it \
--network docker_practice_network \
--name docker_practice_postgres \
-e POSTGRES_USER=root \
-e POSTGRES_PASSWORD=root \
-e POSTGRES_DB=ny_taxi \
-v $(pwd)/data/ny_taxi:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:latest

URL="https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv"
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"
python main.py --url $URL --host localhost --port 5432 --db ny_taxi --tb yellow_taxi --user root --pw root

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"
docker run --rm -it \
--network docker_practice_default \
--name docker_practice \
docker_practice \
--url $URL --host docker_practice_postgres --port 5432 --db ny_taxi --tb yellow_taxi --user root --pw root

pgcli -h localhost -p 5432 -u root -d ny_taxi
