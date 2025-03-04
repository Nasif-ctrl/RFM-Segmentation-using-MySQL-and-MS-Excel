# RFM Segmentation using MySQL and MS Excel  
## __Overview__  
The objective of this project was to analyze a dataset titled Superstore Sales Data by segmenting the customer base based on recency, frequency of purchase, and monetary value (RFM segmentation). RFM segmentation is a marketing analysis technique used to classify customers based on their purchasing behavior: Recency (how recently a customer made a purchase), Frequency (how often they purchase), and Monetary value (how much they spend). The primary software used for this project were MySQL Workbench 8.0 CE and Microsoft Excel, both of which can function offline without requiring an internet connection. Before analyzing the dataset, it was inspected for missing, duplicate, and unsupported values. To bulk insert a dataset into MySQL, it must be in CSV format. Some datasets contain certain characters that are not supported in CSV format and require preprocessing in XLSX format before conversion. Once successfully imported into MySQL, further data handling can be performed within the software as needed. The SQL queries used in this project included basic queries as well as window functions. After generating the output tables, views were created to facilitate easy access to the derived insights.
  
## __Contents__  
| File Name | File Type | Description |
|-----------|-----------|-------------|
| Superstore Sales Data (Unmodified) | XLSX | Raw dataset as received initially |
| Superstore Sales Data (Modified) | CSV | Modified dataset with removed unsupported characters |
| Project1_Query | SQL | File containing queries used in MySQL |
| RFM Analysis | XLSX | Output table showing individual, total and combined RFM scores and corresponding segments | 
| Monetary Value & Number of Customers per Segment | XLSX | Output table showing Monetary Value & Number of Customers per Segment |  

## How to Execute the Program  
The files Project1_Query and Superstore Sales Data should be downloaded and saved to the desired folder. If you want to practice identifying and correcting the anomalies within the dataset, you can download the unmodified XLSX file. If you want to skip doing so, you can download the modified CSV file instead.  
  
Following are the steps that were followed to modify the dataset for this project:  
i) The column with the heading "Product Name" was selected.  
ii) The Find and Replace window was opened by Pressing `Ctrl + H`.   
iii) The characters ™ was copied in the  `Find what` field and `Replace all` was clicked. Same was done for the character ®.  
iv) A quotaion mark (") was typed in the  `Find what` field and '_inch_' was typed in the `Replace with` field. Next, `Replace all` was clicked.
v) The XLSX file was then saved as CSV file.  
  
After generating the CSV file, MySQL was opened and a database called _project_rfm_ was created. Right clicking on 'Tables' under project_rfm in the `Schemas` window, the Table Data Import Wizard was used to bulk insert the CSV file. The Order date and Ship date in the inserted table were stored as serial numbers representing the number of days since January 1, 1900. To convert them to actual dates, the day numbers in the columns Order date and Ship date were added to the date __1899-12-30__. These added values were stored in the newly generated columns Order Date (Converted) and Ship Date (Converted).  
Afterwards, queries were run as shown in the SQL file. The generated outputs were exported as CSV files.  
