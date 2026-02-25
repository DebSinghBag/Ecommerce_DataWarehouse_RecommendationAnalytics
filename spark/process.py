from pyspark.sql import SparkSession

# Create Spark session
spark = SparkSession.builder.appName("EcommerceBatchProcessing").getOrCreate()

# Load data
df = spark.read.csv("../data/sales_transformed.csv", header=True, inferSchema=True)

# Show data
df.show()

# Aggregation example
result = df.groupBy("product_id").sum("total_amount")

print("Product revenue summary:")
result.show()