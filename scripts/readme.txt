# Sales Data Transfer to SQL Server

## Description
This project contains a Python script that reads data from an Excel file and writes it to a SQL Server database 
using SQLAlchemy, pandas, and openpyxl. The script is designed to handle large datasets efficiently by processing
data in chunks.

## Prerequisites
Before running the script, ensure you have the following installed:
- Python 3.x
- pandas
- SQLAlchemy
- pyodbc
- openpyxl
- Microsoft ODBC Driver for SQL Server

You can install the required Python libraries using pip:
```sh
pip install pandas sqlalchemy pyodbc openpyxl
