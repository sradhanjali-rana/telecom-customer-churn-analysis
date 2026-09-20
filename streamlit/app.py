import streamlit as st
import pandas as pd


st.set_page_config(
    page_title="Telecom Customer Churn Analysis",
    layout="wide"
)

st.title("📱 Telecom Customer Churn Analysis")
st.write("Customer churn, usage and recharge behavior analysis")

# Load data
uploaded_file = st.file_uploader(
    "Upload Telecom Churn Dashboard CSV",
    type=["csv"]
)

if uploaded_file is not None:

    df = pd.read_csv(uploaded_file)

    st.success("Data loaded successfully!")

    # KPIs
    total_customers = df["id"].nunique()
    churned_customers = df[df["churn_status"] == "Churn"]["id"].nunique()
    churn_rate = (churned_customers / total_customers) * 100
    avg_arpu = df["arpu_8"].mean()

    col1, col2, col3, col4 = st.columns(4)

    col1.metric("Total Customers", f"{total_customers:,}")
    col2.metric("Churned Customers", f"{churned_customers:,}")
    col3.metric("Churn Rate", f"{churn_rate:.2f}%")
    col4.metric("Average ARPU", f"{avg_arpu:.2f}")

    st.divider()

    # Churn distribution
    st.subheader("Customer Churn Distribution")

    churn_count = df["churn_status"].value_counts()

    st.bar_chart(churn_count)

    # ARPU
    st.subheader("Average ARPU by Churn Status")

    arpu_analysis = df.groupby("churn_status")["arpu_8"].mean()

    st.bar_chart(arpu_analysis)

    # Recharge
    st.subheader("Average Recharge Count by Churn Status")

    recharge_analysis = df.groupby("churn_status")[
        "total_rech_num_8"
    ].mean()

    st.bar_chart(recharge_analysis)

    # Voice usage
    st.subheader("Average Outgoing Voice Usage by Churn Status")

    voice_analysis = df.groupby("churn_status")[
        "total_og_mou_8"
    ].mean()

    st.bar_chart(voice_analysis)

else:
    st.info("Please upload the telecom_churn_dashboard.csv file to view the dashboard.")
