# Data Track: Week 12 Assignment

Week 12 assignment for the [HackYourFuture Data Track](https://www.notion.so/hackyourfuture/Data-Track-Overview).

The assignment for this week can be found at: [Week 12: Assignment](https://www.notion.so/hackyourfuture/Assignment-Build-Two-Dashboards)

## What you will build

- **Task 1: Metabase dashboard** — three analytical Questions on your dbt mart tables, arranged into a dashboard with a date filter, and a `metric_definitions.md` file documenting each panel.
- **Task 2: Streamlit engineering dashboard** — a Python app that shows Airflow DAG run status and data freshness from Azure Postgres.

## Getting started

### Task 1: Metabase

1. Log in to the HYF Metabase instance (URL in `task-1/README.md`).
2. Build three Questions in SQL mode on your `dev_<name>.fct_trips` table.
3. Arrange them into a Dashboard and add a date-range filter.
4. Fill in `task-1/metric_definitions.md` for each panel.
5. Copy the dashboard URL (or take screenshots) into `task-1/README.md`.

### Task 2: Streamlit

1. Open `task-2/app.py` and follow the `TODO` comments.
2. Copy `.env.example` to `.env` and fill in your credentials (never commit `.env`).
3. Run `pip install -r task-2/requirements.txt`.
4. Run `streamlit run task-2/app.py` and verify the panels load with real data.
5. Push `task-2/` to GitHub.

## Autograder

```bash
bash .hyf/test.sh
```

The scaffold returns `pass: false`. It returns `pass: true` once:
- `task-1/metric_definitions.md` contains at least 3 metric definitions
- `task-2/app.py` contains `st.cache_data` and no hardcoded passwords

## Submission

Submit the following in the class assignment tracker:

| Item | Required for |
|---|---|
| Metabase dashboard link / screenshots | Minimum |
| `task-2/` GitHub link | Minimum |
| `task-1/metric_definitions.md` | Minimum |
| Date filter on ≥2 Questions | Target |
| Streamlit freshness panel | Target |
| 5-minute presentation recording link | Target |
