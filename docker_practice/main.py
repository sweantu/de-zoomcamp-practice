#!/usr/bin/env python

import pandas as pd
from sqlalchemy import create_engine

from time import time
import subprocess
import argparse


def main(args):
    url = args.url
    host = args.host
    port = args.port
    db = args.db
    user = args.user
    pw = args.pw
    tb = args.tb
    filename = url.split("/")[-1]
    subprocess.run(["wget", url, "-O", filename])

    engine = create_engine(f"postgresql://{user}:{pw}@{host}:{port}/{db}")
    conn = engine.connect()

    df_iter = pd.read_csv(filename, iterator=True, chunksize=100000)
    df = next(df_iter)
    if "tpep_pickup_datetime" in df:
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    if "tpep_dropoff_datetime" in df:
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    df.head(n=0).to_sql(tb, con=conn, if_exists="replace")
    while True:
        try:
            start_t = time()
            df.to_sql(tb, con=conn, if_exists="append")
            end_t = time()
            print("runs in %.3f seconds" % (end_t - start_t))
            df = next(df_iter)
            if "lpep_dropoff_datetime" in df:
                df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
            if "lpep_pickup_datetime" in df:
                df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        except StopIteration as e:
            print(e)
            print("stop ingesting data ....")
            break


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", required=True)
    parser.add_argument("--host", required=True)
    parser.add_argument("--port", required=True)
    parser.add_argument("--db", required=True)
    parser.add_argument("--tb", required=True)
    parser.add_argument("--user", required=True)
    parser.add_argument("--pw", required=True)
    args = parser.parse_args()
    print(args)
    main(args)
