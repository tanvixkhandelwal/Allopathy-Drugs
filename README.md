# Allopathy-Drugs
SQL + Power BI project analyzing 250K+ allopathy drugs in India — exploring pricing, manufacturer trends, composition diversity, and product discontinuation through interactive dashboards.

# Allopathy Drugs in India — SQL + Power BI Project

**End-to-end market analytics case study on India’s Allopathy Drugs dataset.**  
I used SQL for data modeling and Power BI to visualize pricing trends, manufacturer behavior, and product diversity across 250K+ medicines.

---

## Project Overview
The dataset contains **253,793 records** of drugs sold in India with details on:
- **Drug Info:** Name, Type, Pack Size, Price  
- **Manufacturer Info:** Manufacturer Name, Discontinuation Status  
- **Compositions:** Primary and Secondary Ingredients  

**Goal:** Analyze pricing distribution, manufacturer trends, and active vs discontinued product behavior in India’s pharmaceutical market.

---

## Tools & Skills
- **SQL (T-SQL)** — data cleaning, transformation, and analytical queries  
- **Power BI** — dashboard design, KPIs, and interactive visuals  
- **Excel / CSV** — relational tables for Power BI data modeling  
- **Data Analysis** — market segmentation, manufacturer insights, composition diversity  

---

## Key Analysis
- **Price Distribution:** Min, Max, Average, Median prices  
- **Manufacturer Ranking:** Costliest & Cheapest Manufacturers by Avg Price  
- **Composition Diversity:** Distinct composition pairs per manufacturer  
- **Active vs Discontinued:** Product lifecycle and discontinuation rates  
- **Pack Size Trends:** Pricing by packaging and product count  

---

## 📈 Dashboard Highlights
**Page 1 – Title Page**  
Introductory page with project title and theme.

**Page 2 – Price Distribution & Market Analysis**  
- Cards: Avg, Min, Max, and Median Price  
- Multi-row card: Costliest Manufacturer, Costliest Drug, Cheapest Drug  
- Column chart: Manufacturer by Avg Price  
- Bar chart: Top 10 Most Expensive Drugs  
- Line chart: Price by Pack Size  
- Bar chart: Cheapest Drugs  

**Page 3 – Manufacturer Analysis**  
- Column chart: Total Products by Manufacturer  
- Line chart: Discontinued Count by Manufacturer  
- Table: Manufacturer Diversity (Distinct Compositions)  
- Bar chart: Manufacturer by Average Price  
- Slicer: Manufacturer Name Filter  

---
## 📊 Dashboard Preview


### Title Page  
![Title Page](Images/Title%20Page.png)

### Price Distribution and Market Analysis
![Price Distribution and Market Analysis](Images/Price%20Distribution%20and%20Market%20Analysis.png)

### Manufacturer Analysis
![Manufacturer Analysis](Images/Manufacturer%20Analysis.png)



## Insights
- Wide **price variation** across manufacturers and pack sizes  
- Some manufacturers have **high discontinuation rates**  
- **Composition diversity** strongly linked to broader product portfolios  
- Premium drugs heavily influence the market’s average price  

---

## How to Use
1. Run `allopathy_drugs_analysis.sql` in SQL Server to create all views.  
2. Open `Allopathy_Drugs_Analysis.pbix` in Power BI and connect it to SQL.  
3. Refresh visuals and explore dashboard pages using filters and slicers.  

---
##  Contact  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/tanvikhandelwal30)  [![Email](https://img.shields.io/badge/Email-Contact-red?style=for-the-badge&logo=gmail)](mailto:tanvikhandelwal14@gmail.com)  



![SQL Server](https://img.shields.io/badge/SQL%20Server-TSQL-blue?logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX-yellow?logo=powerbi&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Advanced-green?logo=microsoftexcel&logoColor=white)



