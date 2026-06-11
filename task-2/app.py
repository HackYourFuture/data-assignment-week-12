"""
Week 12 Engineering Dashboard , Streamlit app

Run:  streamlit run app.py

Credentials: copy .env.example to .env and fill in values.
             Load with: pip install python-dotenv, then call load_dotenv() below.
             Never hardcode credentials in this file.
"""

import os

import requests
import streamlit as st

# TODO: uncomment these two lines after installing python-dotenv
# from dotenv import load_dotenv
# load_dotenv()

AIRFLOW_URL = os.environ.get("AIRFLOW_URL", "")
AIRFLOW_USER = os.environ.get("AIRFLOW_USER", "")
AIRFLOW_PASS = os.environ.get("AIRFLOW_PASS", "")
PG_URL = os.environ.get("PG_URL", "")  # postgresql://user:pass@host/db

st.set_page_config(page_title="Pipeline Health", layout="wide")
st.title("Pipeline Health Dashboard")


# ── Panel 1: Last DAG run status ─────────────────────────────────────────────


@st.cache_data(ttl=60)
def get_dag_runs(dag_id: str, limit: int = 10) -> list:
    """Return recent DAG runs from the Airflow REST API."""
    # TODO: implement this function
    # Endpoint: GET {AIRFLOW_URL}/api/v2/dags/{dag_id}/dagRuns
    # Auth (Airflow 3): POST {AIRFLOW_URL}/auth/token with username/password to
    #   get an access_token, then send headers={"Authorization": f"Bearer {token}"}.
    #   Basic Auth (auth=(user, pass)) returns 401 on Airflow 3. Cache the token.
    # Return: list of run dicts, each with "state", "start_date", "end_date"
    raise NotImplementedError("TODO: implement get_dag_runs")


dag_id = "ingest_taxi_month"  # TODO: on the shared Airflow your DAG id is
#                                 prefixed: <yourname>_ingest_taxi_month

st.subheader("Last DAG run")
try:
    runs = get_dag_runs(dag_id, limit=1)
    if runs:
        last = runs[0]
        state = last["state"]
        if state == "success":
            st.success(f"Last run: **{state}**, started {last['start_date']}")
        elif state == "failed":
            st.error(f"Last run: **{state}**, check Airflow logs")
        else:
            st.warning(f"Last run: **{state}**")
    else:
        st.info("No runs found for this DAG.")
except NotImplementedError:
    st.warning("Panel 1: implement `get_dag_runs` to show live data.")
except Exception as exc:
    st.error(f"Could not reach Airflow: {exc}")


# ── Panel 2 (Target): Run duration trend ─────────────────────────────────────

st.subheader("Run duration trend (last 30 runs)")
# TODO (Target): call get_dag_runs(dag_id, limit=30), compute duration from
# start_date and end_date, and plot with st.line_chart.
st.info("TODO (Target): add a line chart of run durations.")


# ── Panel 3 (Target): Data freshness from Postgres ───────────────────────────

st.subheader("Data freshness")
# TODO (Target): query MAX(pickup_datetime) and COUNT(*) from
# dev_<name>.fct_trips using psycopg2 or sqlalchemy + PG_URL.
# Display as st.metric widgets.
st.info("TODO (Target): add freshness metrics from Postgres.")
