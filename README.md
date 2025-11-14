# Allopathy Drugs Market Analysis

A comprehensive SQL and Power BI analysis project exploring **drug pricing patterns, manufacturer performance, and product discontinuation trends** in the Indian allopathy pharmaceutical market.

> A data-driven study uncovering key pricing dynamics, manufacturer diversity, and market discontinuation insights through SQL analytics and Power BI dashboarding.

![Title Page](Images/Title%20Page.png)

---

## Features

- **SQL Server (T-SQL)** – For advanced analytical querying and view creation.  
- **Power BI Desktop** – For building a multi-page, interactive dashboard.  
- **Data Modelling (Star Schema)** – Converted a flat 253K+ row dataset into 4 relational tables.  
- **Data Cleaning** – Implemented `TRY_CONVERT`, `NULLIF`, and `LTRIM/RTRIM` for field standardization.  
- **Dynamic Views** – Created multiple SQL views for reusable analytical logic (`base`, `composition_pairs`, `active_vs_inactive`).  

---

##  Introduction

MedCare Pharma Data Ltd. is a nationwide distributor and manufacturer of allopathic medicines.  
They oversee over **250K product listings** across India, spanning **60+ manufacturers** and **1,200+ drug compositions**.  
Due to market fluctuations, product discontinuations, and irregular pricing, the company needed **data-backed visibility** into their portfolio’s structure, pricing, and active/inactive product mix.

---

##  Business Objective

The aim of this project was to:
- Analyze **price distribution, outliers, and market range** of medicines.  
- Evaluate **manufacturer performance** in terms of product count, average pricing, and discontinuation rates.  
- Identify **composition diversity** and the most commonly paired compounds.  
- Compare **price behavior across different pack sizes** and product types.  
- Deliver a **visual Power BI dashboard** to support pricing decisions and portfolio optimization.

---

## Analytical Approach

1. **Data Modeling**  
   - Original flat CSV was normalized into a **Star Schema** with four tables:  
     - `fact` – Price, status, manufacturer_id  
     - `medicine` – Drug details and manufacturer mapping  
     - `composition` – Active ingredients (1 & 2)  
     - `pack_size` – Label and unit details  

2. **SQL Querying & View Creation**  
   - Built reusable SQL views for:  
     - Price aggregation (`base`)  
     - Composition mapping (`composition_pairs`)  
     - Product activity status (`active_vs_inactive`)  

3. **Power BI Visualization**  
   - Two-page interactive dashboard:  
     - *Price Distribution & Market Analysis*  
     - *Manufacturer Analysis*  
   - Integrated with slicers, dynamic KPIs, and ranked visuals.

---

##  Key Insights

###  Price Distribution and Market Analysis
- **Average medicine price:** ₹270.54; **Median price:** ₹79  
- **Costliest manufacturer:** Roche Products India Pvt Ltd (~₹47K average)  
- **Highest-priced medicine:** Imbruvica 140mg Capsule – ₹7.64 lakh  
- **Most affordable medicines:** Femidin 10mg Tablet and Setor Tablet (~₹1–₹1.1)  
- **Larger pack sizes** (60–120 tablets) command the highest average price, reflecting bulk pricing strategies.

###  Manufacturer Analysis
- **Top manufacturers by volume:** Sun Pharma, Cipla, and Abbott, contributing ~40% of total products.  
- **Highest discontinuation rate:** Abbott (646 discontinued products).  
- **Manufacturer diversity:** Cipla Ltd. leads with 1,632 unique drug compositions.  
- **Premium pricing:** Roche, Astellas, and BMS India dominate high-end product segments.

![Price Distribution and Market Analysis](Images/Price%20Distribution%20and%20Market%20Analysis.png)
![Manufacturer Analysis](Images/Manufacturer%20Analysis.png)

---

## Business Recommendations

- Revisit **Abbott’s discontinued product lines** to identify potential reactivation opportunities.  
- Expand partnerships with **high-diversity manufacturers** (e.g., Cipla, Alkem) to enhance market coverage.  
- Explore **bulk pack pricing optimization**, as larger packs show higher per-unit profitability.  
- Maintain a balanced portfolio by **monitoring high-priced outliers** and **standardizing mid-tier pricing**.  
- Strengthen supply focus on **top-selling and stable drug categories** with consistent demand and low discontinuation.

---

## How to Use
1. Run `allopathy_drugs_analysis.sql` in SQL Server to create all views.  
2. Open `Allopathy_Drugs_Analysis.pbix` in Power BI and connect it to SQL.  
3. Refresh visuals and explore dashboard pages using filters and slicers.  

---
##  Project Resources  

- [📖 Data Dictionary](./data_dictionary.md)  
- [📄 Power BI Dashboard (PDF)](./Allopathy_Drugs_Dashboard.pdf)
- [🗂️ View SQL Analysis Script](./sql/allopathy_drugs_analysis.sql)


##  Contact  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/tanvikhandelwal30)  [![Email](https://img.shields.io/badge/Email-Contact-red?style=for-the-badge&logo=gmail)](mailto:tanvikhandelwal14@gmail.com)  



![SQL Server](https://img.shields.io/badge/SQL%20Server-TSQL-blue?logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX-yellow?logo=powerbi&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Advanced-green?logo=microsoftexcel&logoColor=white)



