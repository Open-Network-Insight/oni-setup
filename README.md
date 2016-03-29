# oni-setup
OpenNetworkInsight initial setup

These scripts will create the tables needed for storing Flows and DNS records in Hive.
We want to create tables in Avro/Parquet format to get a faster query performance. This format is an industry standard and you can find more information about it on:

Avro is a data serialization system - https://Avro.apache.org/
Parquet is a columnar storage format - https://parquet.apache.org/

To get to Avro/parquet format we need a staging table to store CSV data temporarily. Then, run a Hive query statement to insert these text-formatted records into the Avro/parquet table. Hive will manage to convert the text data into the desired format. The staging table must be cleaned after loading data to Avro/parquet table for the next batch cycle.  

A set of a staging (CSV) and a final (Avro/parquet) tables are needed for each data entity. 

### Flow Tables

- flow : Avro/parquet final table to store flow records 
- flow_tmp : Text table to store temporarily flow records in CSV format

### DNS Tables

- dns : Avro/parquet final table to store DNS records 
- dns_tmp : Text table to store temporarily DNS records in CSV format
- dns_ml : Avro/parquet final table to store DNS machine learning output records 
- dns_ml_tmp : Text table to store temporarily DNS machine learning output records in CSV format
- dns_susp : Avro/parquet final table to store DNS suspicious records 
- dns_susp_tmp : Text table to store temporarily DNS suspicious records in CSV format
- dns_scores : Avro/parquet final table to store DNS score records 
- dns_scores_tmp : Text table to store temporarily DNS score records in CSV format
- dns_comments : Text table to store comments about scoring DNS records

