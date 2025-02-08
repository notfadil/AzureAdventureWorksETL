# azureetlproject
This project aims to create an end-to-end ETL data pipeline with the Adventure Works dataset (https://www.kaggle.com/datasets/ukveteran/adventure-works/data), which contains information about
products being sold, customer data, and the sales data from 2015 to 2017.

![Flowchart](<images/diagram.png>)

Data Ingestion:

The data ingestion process is performed from Github repository to the Bronze Container in Azure Data Lake Storage Gen2. This is where all raw data will be stored.
This is what the bronze container looks like: (each folder contains a .csv file linked with the same name as the folder)

![BronzeContainer](<images/bronze.png>)

This is the pipeline built in Data Factory for the ingestion process:

![DataFactory](<images/DataFactory.png>)

The Files are iteratively directed into the Bronze Container using parameters stored in git.json, which is generated through json_generator.py. 

