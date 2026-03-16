# 📉 Telecom Customer Churn Analysis

![SQL](https://img.shields.io/badge/SQL-Analysis-blue?style=flat&logo=postgresql)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?style=flat&logo=powerbi)
![Kaggle](https://img.shields.io/badge/Dataset-Kaggle-20BEFF?style=flat&logo=kaggle)

## 📌 Project Overview

This project analyzes customer churn behavior in a telecom company using **SQL** and **Power BI**. The objective is to identify patterns and key factors influencing customer churn, and translate those findings into actionable business recommendations.

---

## 🗂️ Project Structure

```
telecom-customer-churn-analysis/
│
├── data/
│   └── WA_Fn-UseC_-Telco-Customer-Churn.csv   # Raw dataset
│
├── sql/
│   └── churn_analysis.sql                       # All SQL queries
│
├── dashboard/
│   ├── churn_dashboard.pbix                     # Power BI dashboard (editable)
│   └── churn_dashboard.pdf                      # Dashboard export (view without Power BI)
│
├── insights.md                                  # Detailed insights & business recommendations
└── README.md
```

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| SQL | Data exploration, cleaning & analysis |
| Power BI | Interactive dashboard & visualization |
| CSV (Kaggle) | Source dataset |

---

## 📦 Dataset

- **Source:** [Kaggle — Telco Customer Churn (IBM Watson)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- **File:** `WA_Fn-UseC_-Telco-Customer-Churn.csv`
- **Rows:** 7,043 customers
- **Columns:** 21 features

**Key fields used in analysis:**

| Column | Description |
|--------|-------------|
| `customerID` | Unique customer identifier |
| `tenure` | Number of months with the company |
| `Contract` | Contract type (Month-to-month, One year, Two year) |
| `InternetService` | Type of internet service (DSL, Fiber optic, No) |
| `MonthlyCharges` | Monthly billing amount |
| `TotalCharges` | Total amount billed |
| `Churn` | Whether the customer churned (Yes/No) |

---

## ❓ Key Business Questions

1. What is the overall churn rate?
2. Which services have the highest churn?
3. How do contract types influence churn?
4. Do higher charges increase churn?
5. How does customer tenure impact churn?

---

## 🧠 SQL Analysis

The analysis used the following SQL concepts:

- **Aggregations** — `GROUP BY`, `COUNT`, `AVG` to summarize churn by category
- **CASE WHEN** — to classify customers into segments (e.g., tenure groups, charge buckets)
- **CTEs (WITH clause)** — to break complex queries into readable, reusable steps
- **Subqueries** — for filtering and nested calculations
- **Window Functions** — for running totals and ranking patterns
- **JOINs** — to combine segmentation logic across derived tables

---


## 📊 Dashboard Preview
```

```

## 💡 Key Insights

| # | Insight | Business Implication |
|---|---------|---------------------|
| 1 | **Overall churn rate is 26.58%** | Over 1 in 4 customers are leaving — retention is a critical priority |
| 2 | **Month-to-month customers churn the most** | Incentivizing annual contracts could significantly reduce churn |
| 3 | **Fiber optic users show the highest churn** | Service quality or pricing for fiber users needs to be reviewed |
| 4 | **Customers with tenure < 12 months are most likely to churn** | Early onboarding programs and loyalty perks could improve 1st-year retention |
| 5 | **Higher monthly charges correlate with higher churn** | Offering tiered pricing or discounts for at-risk segments could help retain them |

---

## ✅ Recommendations

1. **Invest in early retention programs** — The first 12 months are the highest-risk window. Proactive check-ins, onboarding support, and early loyalty discounts can reduce this drop-off significantly.

2. **Incentivize long-term contracts** — Month-to-month customers churn at a much higher rate. Offering discounts or added value for 1- or 2-year commitments could shift customers toward more stable plans.

3. **Investigate Fiber Optic service quality** — The high churn among fiber optic users suggests dissatisfaction with either pricing or service reliability. A targeted customer satisfaction survey for this segment is recommended.

---

## 🙋 Author

**Deepak Rajesh Harnekar**
[[LinkedIn Profile](https://www.linkedin.com/in/deepakharnekar/)] | [https://github.com/Deepakharnekar]
