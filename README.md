
# Azure ETL Project

This project demonstrates the creation of a complete ETL (Extract, Transform, Load) data pipeline using the Adventure Works dataset. The dataset contains rich information about products, customers, sales data (from 2015 to 2017), and more. The project leverages Azure services to ingest, transform, and serve data, ultimately creating a foundation for analytical reporting in **Power BI**.

## Dataset Source
The dataset is sourced from [Adventure Works Dataset on Kaggle](https://www.kaggle.com/datasets/ukveteran/adventure-works/data).

## Data Pipeline Architecture

The project architecture involves the following stages:
1. **Data Ingestion**: Data is ingested from a GitHub repository into Azure Data Lake Storage Gen2 (Bronze layer) using **Azure Data Factory**.
2. **Data Transformation**: Transformations are carried out in **Azure Databricks**, with results stored in the Silver layer.
3. **Data Serving**: Processed data is queried using **Azure Synapse** and served from the Gold layer.
4. **Visualization**: The final data is visualized in **Power BI**.

![Flowchart](<images/diagram.png>)

---

## Data Ingestion (Azure Data Factory)

The ingestion process moves raw `.csv` files from a GitHub repository into the **Bronze Container** in Azure Data Lake Storage Gen2. These raw files are stored in their original state for long-term use.

### Structure of the Bronze Container
Each folder within the Bronze container corresponds to a `.csv` file from the dataset. For example:
- **Calendar**
- **Customers**
- **Product_Categories**
- **Product_Subcategories**
- **Products**
- **Returns**
- **Sales_2015**
- **Sales_2016**
- **Sales_2017**
- **Territories**

![Bronze Container](<images/bronze.png>)

### Data Factory Pipeline
The pipeline uses parameters defined in `git.json` (generated through `json_generator.py`) to dynamically copy files into the Bronze Container.

**Pipeline Components:**
1. **Lookup Activity**: Reads the list of files and destinations from `git.json`.
2. **ForEach Activity**: Iterates over each file and performs a `Copy` activity to transfer data into the Bronze Container.

![Data Factory Pipeline](<images/DataFactory.png>)

---

## Data Transformation (Azure Databricks)

In this stage, transformations are performed to clean and enrich the data. The transformed data is stored in the **Silver Container** in Parquet format for further use.

### Transformations Performed:
1. **Calendar.csv**: Added `Month`, `Year`, and `Date` columns.
2. **Customers.csv**: Combined `Prefix`, `First Name`, and `Last Name` into a `Full Name` column.
3. **Products.csv**: Updated `ProductSKU` to only include the code before `-` and simplified `ProductName`.
4. **Sales Data (2015–2017)**: Merged all sales data, converted dates to timestamps, and replaced order number initials (`S` to `T`).

---

## Data Serving (Azure Synapse)

The transformed data in the Silver layer is further processed to create external tables and views, which are stored in the **Gold Container** for analytical purposes.

**SQL Scripts:**
1. `CreateSchema.sql`: Defines schemas for external tables.
2. `Create External Tables.sql`: Creates external tables pointing to Silver container files.
3. `Create Views Gold.sql`: Creates views for aggregated and refined data.

![Data Synapse](<images/DataSynapse.png>)

---

## Visualization (Power BI)

The final step is connecting Power BI to the Gold layer and building insightful visualizations to analyze sales trends, customer behavior, and product performance.

---

## Scripts and Configuration

### `git.json`
This JSON file defines the source `.csv` files and their destinations in the Bronze container:
```json
{
  "p_rel_url": "notfadil/azureetlproject/refs/heads/main/AdventureWorks_Calendar.csv",
  "p_sink_folder": "Calendar",
  "p_sink_file": "Calendar.csv"
}
...
```

### `json_generator.py`
This Python script dynamically generates the `git.json` file by scanning the contents of the GitHub repository.

---

## Repository Structure

```
azureetlproject/
├── images/
│   ├── bronze.png
│   ├── DataFactory.png
│   ├── DataSynapse.png
│   ├── diagram.png
├── scripts/
│   ├── json_generator.py
├── sql/
│   ├── CreateSchema.sql
│   ├── Create External Tables.sql
│   ├── Create Views Gold.sql
├── README.md
```

---

## Conclusion

This project demonstrates the end-to-end implementation of an ETL pipeline in Azure, showcasing how data can be ingested, transformed, and served for analytical purposes. By leveraging tools like Azure Data Factory, Databricks, Synapse, and Power BI, it provides a scalable and efficient solution for managing and analyzing data.
