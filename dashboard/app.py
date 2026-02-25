import streamlit as st
import pandas as pd

st.title("E-Commerce Data Warehouse & Recommendation Analytics System")

df = pd.read_csv("../data/sales_transformed.csv")

st.subheader("Revenue by Product")

revenue = df.groupby("product_id")["total_amount"].sum()
st.bar_chart(revenue)

st.subheader("Customer Spending")

customer_spend = df.groupby("customer_id")["total_amount"].sum()
st.bar_chart(customer_spend)