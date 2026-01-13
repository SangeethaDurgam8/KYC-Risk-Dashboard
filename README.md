# KYC-Risk-Dashboard
**Overview**
This project demonstrates a mock KYC (Know Your Customer) dashboard built with Python, Streamlit, and Plotly.
It showcases the creation of a synthetic customer dataset, risk flagging, verification status, and an interactive dashboard suitable for fintech or compliance environments.

**Features**
Filter customers by country, verification status, and risk flag
Search customers by name or ID
Key metrics displayed: Total Customers, High/Low Risk, Verification Status Counts
Interactive charts:
Risk Flag Distribution (Pie Chart)
Verification Status Distribution (Pie Chart)
Customers by Country (Bar Chart)
High/Low Risk Customers by Verification Status (Stacked Bar Chart)
**Dataset** 
Generated with [Faker]
Contains 1000 mock customers
9 columns: first_name, last_name, dob, country_code, id_number, email, phone, risk_flag, status
Binary risk_flag: High / Low**
Tech Stack
**Python 3.x
[Streamlit] – interactive dashboard
[Pandas] – data manipulation
[Plotly Express] – visualizations
[Faker] – mock data generation
How to Run
To run the KYC Dashboard, clone the repository with git clone https://github.com/abertm/kyc-risk-dashboard.git and change into the folder using cd kyc-risk-dashboard. Then install the required dependencies with pip install -r requirements.txt and launch the dashboard with streamlit run app.py. This will start the dashboard in your web browser.
