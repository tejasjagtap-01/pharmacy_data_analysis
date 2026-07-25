# 🔍 Exploratory Data Analysis (EDA) in Python: PharmaRetail Dataset

[![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Pandas-Data_Analysis-150458?style=flat&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Seaborn](https://img.shields.io/badge/Seaborn-Data_Visualization-38B6FF?style=flat&logo=python&logoColor=white)](https://seaborn.pydata.org/)

## 📌 Introduction & Objectives
Exploratory Data Analysis (EDA) is the critical first phase of our data pipeline. Before constructing our relational database schema or building reporting dashboards, we used **Python** to inspect, clean, and profile **62,000+ raw sales records**. 

The main goals of this EDA phase were:
1. Understanding the underlying distribution and structure of the raw transaction logs.
2. Detecting data quality defects (missing values, extreme outliers, incorrect types).
3. Discovering core business patterns regarding margins, revenue leakage, peak days, and promotion efficiency.

---

## 🛠️ Python Libraries Used
* **`pandas`**: Data manipulation, aggregation, and structural profiling.
* **`numpy`**: Numerical operations and vector calculations.
* **`matplotlib.pyplot`**: Baseline statistical plotting and layout customization.
* **`seaborn`**: Advanced statistical visualizations (heatmaps, box plots, distribution curves).

---

## 🔬 1. Data Profiling & Structural Discovery

### A. Initial Dataset Assessment
Upon loading the flat file via `pd.read_csv()`, Python profiling revealed:
* **Total Dataset Size:** ~62,140 rows × 8 raw columns.
* **Data Types Identified:** Mixed string objects, floating-point currencies, and unparsed date objects.
* **Missing Values:** Small pockets of null/blank records in transaction identifiers and product codes.

```python
# Initial inspection script
print(df.info())
print(df.describe())
print(df.isnull().sum())
