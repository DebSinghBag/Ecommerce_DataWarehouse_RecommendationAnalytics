import pandas as pd

# Extract
sales = pd.read_csv("../data/sales.csv")

# Transform
sales["total_amount"] = sales["quantity"] * sales["price"]

# Save transformed file
sales.to_csv("../data/sales_transformed.csv", index=False)

print("ETL completed successfully")