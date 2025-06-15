## Mac
#### Installing Spark

```bash
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.14
export PATH="$JAVA_HOME/bin/:$PATH"

export SPARK_HOME=/opt/homebrew/Cellar/apache-spark/3.5.5/libexec
export PATH="$SPARK_HOME/bin/:$PATH"

export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH"
```

## Linux
#### Installing Spark
```bash
mkdir spark
cd spark

wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
tar xzfv openjdk-17.0.2_linux-x64_bin.tar.gz
rm openjdk-17.0.2_linux-x64_bin.tar.gz

export JAVA_HOME="${HOME}/spark/jdk-17.0.2"
export PATH="${JAVA_HOME}/bin:${PATH}"
java --version

wget https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz
tar xzfv spark-3.4.4-bin-hadoop3
rm spark-3.4.4-bin-hadoop3

export SPARK_HOME="${HOME}/spark/spark-3.4.4-bin-hadoop3"
export PATH="${SPARK_HOME}/bin:${PATH}"
spark-shell

export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH"
```

#### Testing Spark
```python
import pyspark

pyspark.__version__
pyspark.__file__

!wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv
!head taxi_zone_lookup.csv

from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .master("local[*]") \
    .appName('test') \
    .getOrCreate()

df = spark.read \
    .option("header", "true") \
    .csv('taxi_zone_lookup.csv')
df.show()

df.write.parquet('zones')

!ls -lh
!ls zones
```