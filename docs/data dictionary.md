# 📖 Data Dictionary — Allopathy Drugs in India

This document describes the key tables and fields used in the **Allopathy Drugs in India** analytics project.  
The dataset represents pharmaceutical products sold in India, covering their pricing, compositions, manufacturers, and product status.

---

## 1. Base Dataset (`allopathy_drugs`)
**Rows:** 253,793  
**Description:** Primary dataset containing details of all Allopathy drugs available in India.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **id** | Integer (PK) | Unique identifier for each drug/product. |
| **name** | String | Official or marketed name of the drug. |
| **price** | Decimal(10,2) | Listed retail price per unit/pack. |
| **is_discontinued** | Bit / Integer | Product status flag — `0` = Active, `1` = Discontinued. |
| **manufacturer_name** | String | Name of the pharmaceutical manufacturer. |
| **type** | String | Drug system — e.g., Allopathy, Ayurvedic, etc. |
| **pack_size_label** | String | Packaging size label (e.g., "10 Tablets", "100 ml Bottle"). |
| **short_composition1** | String | Primary active ingredient or compound. |
| **short_composition2** | String | Secondary active ingredient or compound (if applicable). |

---

## 2. Cleaned Base View (`base`)
**Rows:** 253,793  
**Description:** Cleaned and standardized version of the raw dataset, used for all subsequent analysis.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **id** | Integer | Drug/product ID (same as source). |
| **name** | String | Trimmed and standardized product name. |
| **price** | Decimal(18,2) | Converted numeric price (cleaned using `TRY_CONVERT`). |
| **is_discontinued** | Bit | Product activity flag (0 = Active, 1 = Discontinued). |
| **manufacturer_name** | String | Standardized manufacturer name. |
| **pack_size_label** | String | Normalized packaging label. |
| **sc1** | String | Cleaned primary composition. |
| **sc2** | String | Cleaned secondary composition. |

---

## 3. Composition Pairs (`composition_pairs`)
**Rows:** 200K+  
**Description:** Derived table showing paired active ingredients for each drug.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **id** | Integer (FK) | Product ID (from `base`). |
| **manufacturer_name** | String | Manufacturer producing the drug. |
| **composition_pair** | String | Combination of `sc1` and `sc2` ordered alphabetically (e.g., "Caffeine, Paracetamol"). |

---

## 4. Active vs Inactive Summary (`active_vs_inactive`)
**Rows:** ~5,000 (by manufacturer)  
**Description:** Aggregated manufacturer summary showing active and discontinued product counts.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **manufacturer_name** | String (PK) | Manufacturer name. |
| **total_products** | Integer | Total number of products made by the manufacturer. |
| **active_count** | Integer | Count of currently active (non-discontinued) products. |
| **discontinued_count** | Integer | Count of discontinued products. |
| **active_rate** | Decimal(5,2) | Percentage of active products. |
| **discontinued_rate** | Decimal(5,2) | Percentage of discontinued products. |

---

## 5. All Compositions (`all_compositions`)
**Rows:** ~500K (flattened)  
**Description:** Union of all compositions across both `short_composition1` and `short_composition2`.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **composition** | String | Single active composition (flattened view from both composition columns). |

---

## 6. Manufacturer Diversity (`manufacturer_diversity`)
**Rows:** ~5,000  
**Description:** Aggregated table showing the number of unique composition pairs per manufacturer.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **manufacturer_name** | String | Manufacturer name. |
| **manufacturer_diversity** | Integer | Number of distinct composition pairs offered. |

---

## 7. Pack Size Analysis (`pack_size_summary`)
**Rows:** Variable  
**Description:** Aggregated table summarizing average prices and counts by packaging label.  

| Column Name | Type | Description |
|--------------|------|-------------|
| **pack_size_label** | String | Packaging label (e.g., "10 Tablets", "1 Strip"). |
| **average_price** | Decimal(10,2) | Average price of all drugs within the same pack size. |
| **items_count** | Integer | Number of items with this pack size label. |

---

## 🔑 Notes
- **Data Cleaning:**  
  - Empty strings and whitespace trimmed from all text columns.  
  - `price` converted to numeric using `TRY_CONVERT` and filtered for `price > 0`.  
  - Null and zero prices excluded from price distribution calculations.  

- **Relationships:**  
  - `base.id = composition_pairs.id` (1:1)  
  - `base.manufacturer_name = active_vs_inactive.manufacturer_name` (many:1)  
  - `composition_pairs.manufacturer_name` used to derive manufacturer diversity.  
  - `base.pack_size_label` used in `pack_size_summary`.  

- **Aggregation Level:**  
  - `base` → one row per product  
  - `composition_pairs` → one row per drug with cleaned composition info  
  - `active_vs_inactive` → one row per manufacturer  
  - `pack_size_summary` → one row per packaging type  

- **Database Engine:** Microsoft SQL Server (T-SQL)  
- **Visualization Tool:** Power BI  
- **Supporting Tables:** CSV files imported for Power BI modeling (manufacturer, pack size, price range, compositions, status)

---

## 📌 Usage in Analysis
- Used to visualize:  
  - Price distribution, manufacturer rankings, and costliest/cheapest drugs.  
  - Manufacturer diversity and discontinued product trends.  
  - Pack size trends and pricing behavior across the Indian market.

---
