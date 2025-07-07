# 🏦 Banking Data Analysis Project using SQL

This project focuses on performing data analysis on a mock banking database using **SQL**. It involves creating a relational database, cleaning the data, and extracting meaningful business insights to support decision-making.

---

## 📁 Files Included

- `banking sql.sql` – Contains all SQL queries including:
  - Table creation (`clients`, `gender`, `investment_advisior`)
  - Data cleaning and exploration
  - Business KPIs and insight queries

- `my banking project.xlsx` – Supplementary Excel file used for exploring or visualizing the data.

---

## 🛠️ Key Skills & Tools Used

- SQL (PostgreSQL/MySQL compatible syntax)  
- Data Cleaning & Validation  
- CTEs and Window Functions  
- Aggregation and Grouping  
- Business Intelligence & KPI Reporting

---

## 🧾 Dataset Overview

**Tables:**

- `clients`: Client demographic, financial, and risk data.
- `gender`: Lookup table for gender classification.
- `investment_advisior`: Advisor assignments for each client.

---

## 🔍 Business Insights Extracted

- Total clients by gender, age group, and nationality
- Client distribution by risk level and loyalty classification
- Top 10 clients by estimated income (segmented by gender)
- Aggregate totals for income, loans, deposits, and savings

---

## 📊 Sample KPI Queries

```sql
-- Gender-wise total clients
SELECT g.gender, COUNT(*) 
FROM clients AS c
JOIN gender AS g ON c.genderid = g.genderid
GROUP BY g.gender;

-- Total deposits, savings, and loans
SELECT
  COUNT(client_id),
  ROUND(SUM(bank_loans)) AS bank_loans,
  ROUND(SUM(bank_deposits)) AS bank_deposits,
  ROUND(SUM(saving_accounts)) AS saving_accounts
FROM clients;
