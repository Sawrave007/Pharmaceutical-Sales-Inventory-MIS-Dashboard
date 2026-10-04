# Pharma Sales MIS: Excel → SQL Server → Power BI

An end-to-end analytics project on pharmaceutical sales in Bangladesh. Raw invoice-line data is cleaned and validated in Excel, loaded into SQL Server, analysed with T-SQL, and presented in a Power BI report built on a simple star schema.

> **About the data:** The dataset is synthetic a Bangladeshi pharmaceutical distribution business using 2025 sales data, 10 products, 5 territories, sales representatives, distributors, batches, and expiry dates. Deliberate data-quality issues were introduced—including duplicates, missing values, inconsistent product names, invalid quantities, and mixed date formats—to make the cleaning and validation process realistic. No real company data is used.

---

## Pipeline

```text
Raw CSV
   ↓
Excel — cleaning + validation
   ↓
Clean CSV
   ↓
SQL Server — raw staging
   ↓
SQL Server — typed sales table
   ↓
T-SQL analysis
   ↓
SQL reporting views
   ↓
Power BI dashboard
```

| Stage            | What was done                                                                                                                                                                                                                                                                      |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Excel**     | Cleaned and validated the raw data, including duplicates, missing values, product-name variants, invalid quantities, and date formats. Added derived columns: `sales_calc`, `Net_quantity`, `net_sales`, and a near-expiry flag. Built PivotTables for exploratory sales analysis. |
| **2. Load**      | Loaded the cleaned CSV into a SQL Server `raw` schema using `BULK INSERT`.                                                                                                                                                                                                         |
| **3. Transform** | Loaded the data into the `pharma` schema with appropriate SQL Server data types such as `DATE`, `INT`, `DECIMAL(18,2)`, and `VARCHAR`.                                                                                                                                             |
| **4. Analyse**   | Used T-SQL for data-quality validation, reconciliation, KPI analysis, territory/product analysis, distributor and sales-rep analysis, and sales trends.                                                                                                                            |
| **5. Report**    | Built a Power BI report using SQL reporting views.                                                                                                                                                                                                        |

---

## Dataset

The main table is `pharma.pharma_sales`, containing **one row per invoice line**.


### Dataset coverage

* **5 territories:** Dhaka, Chattogram, Rajshahi, Khulna, Sylhet
* **10 pharmaceutical products**
* Tablets, capsules, sachets, and injections
* **8 distributors**
* Sales representatives assigned to territories
* Batch and expiry information
* Sales and return information

The `Target` field is retained in the dataset but was **not used in the final dashboard** because the synthetic target values produced unrealistic target-achievement results and were therefore not considered suitable for meaningful reporting.

---

## Data Quality & Validation

The project deliberately includes common data-quality problems found in business datasets.

Validation checks include:

* Duplicate invoice records
* Missing values
* Inconsistent product names
* Invalid or non-positive quantities

---

## SQL Analysis

SQL scripts are stored in the `sql/` folder.

### Data validation

* Data-volume and coverage checks
* Duplicate detection
* NULL profiling
* Product-name consistency checks
* Business-rule validation

### Basic analysis

* Headline sales KPIs
* Product performance
* ABC product analysis

### Sales analysis

* Monthly sales trends


### Power BI model views

`powerbi_model_views.sql` creates reporting-ready SQL views for Power BI:

* `vw_sales_clean`
* `vw_dim_month`
* `vw_dim_territory`
* `vw_dim_product`

The sales view preserves the **invoice-line grain** rather than incorrectly treating `Invoice_ID` as a unique transaction key.

---

## Power BI Model

The Power BI report uses a simple star schema.

```text
                 vw_dim_month
                      │
                      │
vw_dim_territory ── vw_sales_clean ── vw_dim_product
```

### Tables

| Table              | Purpose                                                                                        |
| ------------------ | ---------------------------------------------------------------------------------------------- |
| `vw_sales_clean`   | Main sales fact containing invoice-line records, net sales, returns, and expiry-related fields |
| `vw_dim_month`     | Month lookup for time-based analysis                                                           |
| `vw_dim_territory` | Territory lookup for geographic analysis                                                       |
| `vw_dim_product`   | Product and category lookup                                                                    |

Relationships are **one-to-many** with **single-direction filtering**.

The report uses **Import mode**.

Dimension tables are used for slicers and report axes, while measures are calculated from the sales fact.

---

## Dashboard

<!-- Add your screenshots here -->

<img width="1428" height="787" alt="Screenshot 2026-10-05 030821" src="https://github.com/user-attachments/assets/64f97a89-ccf5-4c8a-8394-d62d93d1f680" />

<img width="1408" height="807" alt="Screenshot 2026-10-05 030915" src="https://github.com/user-attachments/assets/b46c285c-fc46-4df5-b843-d4b3df586af9" />


---

## Key Findings

<!-- Replace these with findings from the completed Power BI dashboard. -->

* **Finding 1:** Identify the leading territory or product and quantify its contribution to net sales.
* **Finding 2:** Highlight an important monthly or seasonal sales trend.
* **Finding 3:** Identify a notable return, product-concentration, distributor, sales-rep, or expiry-related pattern.

---

## Tools

**Excel** · **SQL Server / T-SQL** · **Power BI** 

### Key technologies

* Excel PivotTables and data-cleaning functions
* SQL Server
* T-SQL
* `BULK INSERT`
* SQL views
* Window functions
* CTEs
* Power BI
* DAX

---



## Project Scope

The project focuses on a practical MIS reporting workflow:

```text
Clean the data
      ↓
Validate the data
      ↓
Calculate reliable business metrics
      ↓
Analyse sales performance
      ↓
Build reusable reporting views
      ↓
Present findings in Power BI
```

The goal is not to demonstrate complex machine learning or software engineering, but to show how business data can be **cleaned, validated, analysed, and transformed into useful management information**.

---

## Author

**Sawrave Ahmed**

[GitHub](https://github.com/Sawrave007?utm_source=chatgpt.com) · [LinkedIn](https://www.linkedin.com/in/sawrave-ahmed007?utm_source=chatgpt.com)
