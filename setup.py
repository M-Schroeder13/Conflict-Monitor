from setuptools import setup, find_packages

setup(
    name="conflict-zone-monitor",
    version="0.1.0",
    packages=find_packages(exclude=["tests", "docs", "notebooks"]),
    install_requires=[
        "dlt[duckdb]>=0.4.12",
        "dagster>=1.5.12",
        "pandas>=2.1.4",
        "streamlit>=1.29.0",
    ],
    python_requires=">=3.9",
)
