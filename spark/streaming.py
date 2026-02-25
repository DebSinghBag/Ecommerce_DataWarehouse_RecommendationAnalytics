import os
os.environ["PYSPARK_PYTHON"] = "python"

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("EcommerceStreaming").getOrCreate()

schema = "sale_id INT, customer_id INT, product_id INT, date_id INT, quantity INT, price FLOAT, total_amount FLOAT"

stream_df = spark.readStream.schema(schema).csv("../data/stream")

query = stream_df.writeStream \
    .outputMode("append") \
    .format("console") \
    .start()

query.awaitTermination()