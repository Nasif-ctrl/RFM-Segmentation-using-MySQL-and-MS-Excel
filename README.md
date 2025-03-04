## RFM Segmentation using MySQL and MS Excel
# __Overview__  
The objective of this project was to analyze a dataset titled Superstore Sales Data by segmenting the customer base based on recency, frequency of purchase, and monetary value (RFM segmentation). RFM segmentation is a marketing analysis technique used to classify customers based on their purchasing behavior: Recency (how recently a customer made a purchase), Frequency (how often they purchase), and Monetary value (how much they spend).

The primary software used for this project were MySQL Workbench 8.0 CE and Microsoft Excel, both of which can function offline without requiring an internet connection. Before analyzing the dataset, it was inspected for missing, duplicate, and unsupported values. To bulk insert data into MySQL, the dataset must be in CSV format. However, certain special characters are not supported in CSV, requiring preprocessing in XLSX format before conversion. Once successfully imported into MySQL, further data handling can be performed within the software as needed.

The SQL queries used in this project included basic queries as well as window functions. After generating the output tables, views were created to facilitate easy access to the derived insights.

# __Contents__  
| File Name | File Type | Description |
|-----------|-----------|-------------|
| Superstore Sales Data (Unmodified) | XLSX | Raw dataset as received initially |
| Superstore Sales Data (Modified) | CSV | Modified dataset with removed unsupported characters |
| Project1_Query | SQL | File containing queries used in MySQL |
| RFM Analysis | XLSX | Output table showing individual, total and combined RFM scores and corresponding segments | 
| Monetary Value & Number of Customers per Segment | XLSX | Output table showing Monetary Value & Number of Customers per Segment |

