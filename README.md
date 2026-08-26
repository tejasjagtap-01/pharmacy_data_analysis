<img width="1236" height="680" alt="gif1" src="https://github.com/user-attachments/assets/11614e73-500f-4422-80d3-c3de25d66e21" />


# Pharmacy Chain Performance Intelligence Report

### Prepared by: Tejas Jagtap, Data Analyst  
### Dataset Period: FY 2024 – FY 2025  
### Scope: Multi-location pharmacy network | 100+ pharmacy IDs  
### Tools: SQL · Python · Power BI  
---

# 🔍 Exploratory Data Analysis (EDA) in Python: PharmaRetail Dataset

[![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Pandas-Data_Analysis-150458?style=flat&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Seaborn](https://img.shields.io/badge/Seaborn-Data_Visualization-38B6FF?style=flat&logo=python&logoColor=white)](https://seaborn.pydata.org/)

 This report presents a comprehensive business intelligence analysis of a multi-location pharmacy chain spanning two full fiscal years (2024–2025). The network generated **$8.63M** in total revenue across **62,140 transactions**, delivering a **28.0% gross profit margin** and **$2.42M** in total profit.

The analysis surfaces four critical business findings that demand immediate management attention:

1. **Q3 Seasonal Uplift:** Q3 is structurally the highest-revenue quarter across every filter — representing a **$240K revenue uplift** over Q1 that is going underutilised from an inventory and staffing standpoint.
2. **Margin Compression:** Promotional discount campaigns are destroying profitability — compressing margins by **9 full percentage points** while contributing only 10.8% of revenue and 7.7% of profit.
3. **Location Variance:** An **18% performance gap** exists between the top and bottom performing locations — a spread large enough to suggest structural, not coincidental, operational differences.
4. **Basket Potential:** The Average Basket Value of **$138.95** across **7.2 units per transaction** signals a high cross-sell environment that most pharmacy operators are not actively measuring or optimising.

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
```
---

## 1. Business Context

### The Network at a Glance

| KPI | Value | Business Signal |
| :--- | :--- | :--- |
| **Total Revenue (2 Years)** | $8.63M | Healthy mid-market multi-location network |
| **Total Cost** | $6.21M | 72% cost-to-revenue ratio |
| **Total Gross Profit** | $2.42M | — |
| **Gross Profit Margin** | 28.0% | Industry-competitive for retail pharmacy |
| **Total Transactions** | 62,140 | ~31K transactions per year |
| **Average Basket Value** | $138.95 | High-value, multi-item customer behaviour |
| **Units Per Transaction** | 7.2 | Strong cross-sell signal |
| **Average Product Cost** | $99.98 | Premium product positioning |
| **Total Units Sold** | 446K | — |

> **Key Insight:** A 28% gross margin in retail pharmacy is competitive. The critical question is not whether the margin is acceptable — it is whether operational and promotional decisions are protecting it.

---

## 2. Revenue Performance & Seasonality

### 2.1 Year-Over-Year Growth

| Metric | FY 2024 | FY 2025 | Growth |
| :--- | :---: | :---: | :---: |
| **Revenue (Excl. Promo)** | $3.77M | $3.96M | **+5.0%** |
| **Profit (Excl. Promo)** | $1.09M | $1.15M | **+5.5%** |
| **Units Sold (Excl. Promo)** | 192K | 202K | **+5.2%** |

The network is growing at a stable **5.0–5.5%** rate organically — without relying on promotional discounting to drive volume. Profit is growing slightly faster than revenue (+5.5% vs +5.0%), indicating a modest improvement in cost efficiency year over year.

> **Business Implication:** The network is on a sustainable, self-funded growth trajectory. The risk is not stagnation — it is that management may undermine this organic momentum by over-relying on discounting to chase short-term revenue targets.

---

### 2.2 Quarterly Seasonality — The Q3 Opportunity

Quarterly revenue analysis reveals a consistent and repeatable seasonal pattern across both fiscal years and all filter combinations:

| Quarter | FY 2024–2025 Revenue | vs. Q1 | Note |
| :--- | :---: | :---: | :--- |
| **Q1** | $2.63M | Baseline | — |
| **Q2** | $2.76M | +4.9% | — |
| **Q3** | **$2.87M** | **+9.1%** | **Peak** |
| **Q4** | $2.80M | +6.5% | — |

Q3 generates **$240,000** more revenue than Q1 — a 9.1% seasonal uplift that is structurally repeatable, not anomalous.

> **Business Implication:** This is not luck. This is a seasonal demand cycle the network should be engineering around, not simply reacting to. Every major operational decision — inventory procurement, supplier negotiations, staffing increases, marketing spend — should be planned to peak in Q3. A pharmacy that is understocked during Q3 is leaving $240K+ on the table every single year.

---

## 3. Promotional Strategy — A Profitability Warning

*This is the most important finding in the entire analysis.*

### 3.1 The Margin Compression Problem

| Scenario | Revenue | Profit | Margin % |
| :--- | :---: | :---: | :---: |
| **FY 2024 — Standard Sales** | $3.77M | $1.09M | **28.9%** |
| **FY 2024 — Promo Sales** | $456.98K | $90.87K | **19.9%** |
| **FY 2025 — Standard Sales** | $3.96M | $1.15M | **29.0%** |
| **FY 2025 — Promo Sales** | ~$450.00K | ~$90.00K | **~20.0%** |

Every promotional sale costs the business **9.0 percentage points** of gross margin. This pattern is not a FY 2024 anomaly — it repeated with near-identical precision in FY 2025.

---

### 3.2 The Revenue vs. Profit Disconnect

| Metric | Promo Contribution | Non-Promo Contribution |
| :--- | :---: | :---: |
| **Share of Total Revenue** | 10.8% | 89.2% |
| **Share of Total Profit** | 7.7% | 92.3% |

Promo campaigns contribute 10.8% of revenue but only 7.7% of profit — a **3.1 percentage point gap** that represents millions of dollars in underperforming capital when scaled across the network.

---

### 3.3 The Strategic Question Management Must Answer

The data does not say: *stop running promotions.*  
The data says: *you are currently running promotions without measuring whether the volume uplift justifies the margin compression.*

In FY 2024, promo campaigns generated 26K units and $456K revenue. Standard sales generated 192K units and $3.77M revenue. The promo volume is 13.5% of standard volume — not nearly enough to compensate for the 9-point margin loss.

> **Business Recommendation:** Implement a minimum margin floor for promotional approvals. Any campaign that would compress gross margin below 25% should require CFO-level sign-off with explicit volume targets that justify the discount. The current approach — blanket discounting at ~20% margin — is structurally value-destructive.

---

## 4. Network Performance — Location Intelligence

### 4.1 Top Performing Locations (Combined FY 2024–2025)

| Rank | Pharmacy ID | Revenue | Profit |
| :---: | :--- | :---: | :---: |
| **1** | PH0095 | $162,320.29 | $45,172.56 |
| **2** | PH0023 | $159,495.01 | $44,152.23 |
| **3** | PH0058 | $158,935.66 | $43,683.53 |
| **4** | PH0078 | $151,533.96 | — |
| **5** | PH0010 | $147,924.27 | — |
| **6** | PH0073 | $143,722.53 | — |
| **7** | PH0055 | $137,122.29 | — |

---

### 4.2 The Performance Gap

The revenue gap between Rank 1 (`PH0095`) and Rank 7 (`PH0055`) is **$25,197** — an **18.4% performance spread**.

In a mature, well-managed pharmacy network, top-to-bottom location variance should be in the 5–10% range. An 18% spread signals that performance differences are structural, not circumstantial.

> **Business Implication:** Management should investigate three immediate areas for lower-performing locations:
> 1. **Product Mix:** Are lower-performing locations stocking the same high-margin product categories as top performers?
> 2. **Local Competition:** Is the competitive environment meaningfully different in underperforming locations?
> 3. **Operational Execution:** Are there differences in staffing, store hours, or customer experience that the revenue data is proxying for?
>
> Closing even 50% of that 18% performance gap across the bottom half of the network would generate significant incremental revenue without a single new store opening.

---

## 5. Customer Behaviour Analysis

### 5.1 Basket Value & Transaction Profile

| Metric | Value | Interpretation |
| :--- | :---: | :--- |
| **Average Basket Value** | $138.95 | Customers are not single-item buyers |
| **Units Per Transaction** | 7.2 | Strong multi-category purchasing behaviour |
| **Average Product Cost** | $99.98 | Premium product positioning confirmed |
| **Total Transactions** | 62,140 | ~31,070 transactions per year |

An average basket of $138.95 across 7.2 units means customers are purchasing across multiple product categories per visit. This is fundamentally different from a convenience-purchase behaviour pattern.

> **Business Implication:** This is a high cross-sell environment. The network is not capturing it intentionally — it is happening organically. A structured cross-sell program (e.g., bundling high-margin categories with high-frequency consumables, or training pharmacy staff to recommend complementary products) could meaningfully increase basket value without increasing customer acquisition costs.

---

## 6. Cost Structure & Operational Efficiency

| Metric | Value | Note |
| :--- | :---: | :--- |
| **Total Revenue** | $8.63M | Full 2-Year Network Total |
| **Total Operating Cost** | $6.21M | 72.0% Cost-to-Revenue Ratio |
| **Gross Profit** | $2.42M | 28.0% Gross Profit Margin |

The cost gauge from the Financial Health dashboard shows $6.21M in total costs against a modelled maximum of $12.43M — indicating the network is operating at **50% of its cost capacity ceiling**. This suggests significant headroom to grow volume without proportional cost increases, assuming the fixed cost base scales efficiently.

> **Business Implication:** The business has operational leverage available. Growing revenue while holding the cost base relatively flat is the highest-value near-term priority — and the data suggests this is achievable given the current utilisation rate.

---

## 7. Strategic Recommendations Summary

| Priority | Finding | Recommended Action |
| :---: | :--- | :--- |
| 🔴 **Critical** | Promo campaigns destroying 9pp of margin | Implement minimum margin floor (25%) for all promotional approvals |
| 🟠 **High** | Q3 seasonal peak underutilised | Build Q3-anchored procurement and staffing calendar 12 weeks in advance |
| 🟡 **Medium** | 18% location performance spread | Audit bottom-performing locations for product mix, staffing, and competitive context |
| 🟡 **Medium** | $138.95 basket value uncaptured | Launch structured cross-sell program targeting high-margin complementary categories |
| 🟢 **Monitor** | 5.0% YoY organic growth | Protect this trajectory by not over-indexing on promotional volume 

---

## 8. Technical Architecture

The analytical pipeline was built in three decoupled stages designed for performance and reproducibility:

* **Stage 1 — Data Ingestion & Transformation (SQL):** Handled all raw data ingestion, structural cleaning, null handling, date field standardisation, and pharmacy ID normalisation. All filtering and schema decisions were made upstream before data entered the analysis layer.
* **Stage 2 — Exploratory Data Analysis (Python & Pandas):** Handled exploratory data analysis including revenue distribution profiling, quarterly seasonality analysis, promo versus non-promo segmentation, and basket value calculations.
* **Stage 3 — Business Intelligence & Reporting (Power BI):** Delivered two dashboard pages:
  * **Pharmacy Performance Overview:** Features dynamic year and promo code filters.
  * **Financial and Inventory Health Report:** Supports monthly drill-down capabilities.
  * *DAX Measures:* All KPIs were implemented as custom DAX measures, including `Profit Margin %`, `Year-over-Year Growth`, and `Average Basket Value`.

---

## 9. About This Project

This analysis was built as a response to a real-world data access problem.

While researching entry-level Data Analyst roles, I approached 6 local medical stores in Pune requesting their sales data to build a real-world portfolio project. Every owner declined on data privacy grounds. One put it simply:

> *"Bhaiya, sales ka data bohot private hota hai. Yeh main kisi ko nahi de sakta — not even my wife."*

Rather than treating this as a dead end, I sourced a comparable pharmacy dataset from Kaggle and built the exact analytical infrastructure those store owners wouldn't let me build with their own data — then designed it to answer the exact questions a real pharmacy business owner would need answered daily.

The goal was not just a portfolio piece. It was a business-ready analytical product.

--

## 10. 👤 Contact & Connect

This end-to-end pipeline and analytical report was developed by **Tejas Jagtap**. 

I am a **Data Analytics learner** focused on bridging the gap between robust data infrastructure and executive decision-making. I specialize in designing clean ETL architectures, authoring complex server-side analytical data models, and translating tracking metrics into high-impact interactive visual stories.

* **Core Competencies:** Full-Stack Data Engineering, Database Modeling (SQL/PostgreSQL), Python Automation, UI/UX Dashboard Design (Power BI).
* **📬 Let's Connect:** www.linkedin.com/in/tejasjagtap01 | [GitHub] https://github.com/tejasjagtap-01
* **Portfolio/Website**:  https://mavenshowcase.com/project/57336

## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details.
