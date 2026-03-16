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
- **Rows:** 7,032 customers
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

**Sample Query — Churn Rate by Contract Type:**

```sql
SELECT
    Contract, 
    COUNT(CustomerID) as customers,
    (SELECT COUNT(*) from telco) as total_customers,-- using subquery...
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY Contract;
```

**Sample Query — Churn by Tenure Group (CTE):**

```sql
WITH tenure_segments AS (
    SELECT *,
        CASE
            WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
			WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
			ELSE '49+ Months' 
        END AS tenure_group
    FROM telco
)
SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS churn_percentage
FROM tenure_segments
GROUP BY tenure_group
ORDER BY churn_percentage DESC;
```

---

## 📊 Dashboard Preview

> 📌 *Power BI dashboard screenshots*
```

```

> 📄 **Can't open Power BI?** View the full dashboard as a PDF → [`churn_dashboard.pdf`](dashboard/churn_dashboard.pdf)

---

## 💡 Key Insights

| # | Insight | Business Implication |
|---|---------|---------------------|
| 1 | **Overall churn rate is 26.6%** (1,869 out of 7,032) | Over 1 in 4 customers are leaving — retention is a critical priority |
| 2 | **Month-to-month customers churn the most** (55% of all customers) | Incentivizing annual contracts could significantly reduce churn |
| 3 | **Fiber optic users churn at 43%** vs. DSL at 19% and no internet at 7% | Service quality or pricing for fiber users urgently needs review |
| 4 | **49% of customers churn within the first 12 months** — drops to 9% after 49+ months | Early onboarding programs and loyalty perks are the highest-ROI investment |
| 5 | **Customers paying ₹81–100/month churn at 37%** — the highest charge bucket | Tiered pricing or loyalty discounts for high-charge customers could reduce attrition |
| 6 | **Online Security & Tech Support are strong retention drivers** (churn ~14–15% with vs. ~31% without) | Actively bundling these services can reduce overall churn |
| 7 | **Senior citizens churn at 42%** vs. 24% for non-seniors | Dedicated retention strategies needed for older customers |
| 8 | **Electronic check users + month-to-month + 0–12 months = 60%+ churn** | This combined segment is the most urgent intervention target |

> 📄 For a deeper breakdown of each insight with supporting data, see [`insights.md`](https://github.com/Deepakharnekar/telecom-customer-churn-analysis/blob/2e285c1eb52048260edd5dc432a0b921c979c444/insights.md)

---

## ✅ Recommendations

1. **Fix Fiber Optic churn urgently** — With a 43% churn rate vs. 19% for DSL and 7% for non-internet users, fiber optic is the single biggest service risk. Conduct customer feedback surveys to identify whether the issue is pricing, speed, or reliability.

2. **Convert month-to-month customers to longer contracts** — 55% of customers are on month-to-month plans and churn the most. Offering bundled discounts or loyalty perks for switching to 1- or 2-year plans could significantly reduce attrition.

3. **Prioritize first-year onboarding** — Nearly half of new customers (49%) churn within the first 12 months. Early-stage retention programs, welcome offers, and proactive support during onboarding are critical.

4. **Target the highest-risk segment** — New customers (0–12 months) on month-to-month contracts paying by electronic check churn at over 60%. Targeted interventions — discounts, transparent pricing, and nudges toward auto-pay — should focus here first.

5. **Promote value-added services** — Customers with Online Security (14.6% churn) and Tech Support churn at less than half the rate of those without. Actively bundling or promoting these services could act as strong retention drivers.

6. **Address price sensitivity for high-charge customers** — Customers paying 81–100 units/month churn at 37%. Introducing tiered pricing, loyalty discounts, or rewards for high-paying customers could reduce this significantly.

7. **Build targeted strategies for senior citizens** — Senior citizens churn at 42% vs. 24% for non-seniors. Simplified plans, dedicated support, and senior-friendly pricing could improve retention in this segment.

8. **Review paperless billing experience** — Paperless billing customers churn at 33.59% vs. 16.38% for non-paperless. Investigating pain points in the digital billing experience and improving transparency could help reduce this gap.

---

## 🙋 Author

**[Deepak Rajesh Harnekar]**
[[LinkedIn Profile][(https://www.linkedin.com/in/deepakharnekar/)] | [github repo][https://github.com/Deepakharnekar]
