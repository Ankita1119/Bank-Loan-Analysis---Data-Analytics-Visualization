select * from Bank_loan_data;

-- Total Loan applications
SELECT 
	COUNT(id) as Total_Loan_Application
FROM Bank_loan_data;

-- MTD 
SELECT 
	COUNT(id) as MTD_Total_Loan_Application
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Previous Year Month Applications
SELECT 
	COUNT(id) as MTD_Total_Loan_Application
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)-1) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- TOTAL FUNDED AMOUNT
SELECT 
	SUM(loan_amount) as Total_Funded_Amount
FROM Bank_loan_data;

-- MTD Funded
SELECT 
	SUM(loan_amount) as MTD_Total_Loan_Amount_Funded
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Previous Month Amount Funded

SELECT 
	SUM(loan_amount) as PMTD_Total_Loan_Amount
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)-1) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Total Received to the Bank 
SELECT 
	SUM(total_payment) as Total_Amount_Received
FROM Bank_loan_data;

-- MTD Received
SELECT 
	SUM(total_payment) as MTD_Total_Loan_Amount_Received
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Previous Month Amount Received
SELECT 
	SUM(total_payment) as PMTD_Total_Loan_Amount_Received
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)-1) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Average Intrest Rate
Select 
	Round(AVG(int_rate),4)*100 as Avg_Int_Rate
From Bank_loan_data;

-- MTD Avg Interest Rate
SELECT 
	Round(Avg(int_rate),4)*100 as AVG_MTD_Int_Rate
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- PMTD Avg Interest Rate
SELECT 
	Round(Avg(int_rate),4)*100 as AVG_PMTD_Int_Rate
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)-1) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- AVG DTI
SELECT Round(AVG(dti),4)*100 as AVG_DTI
FROM Bank_loan_data;

-- MTD Avg DTI
SELECT 
	Round(Avg(dti),4)*100 as AVG_MTD_DTI
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- PMTD Avg DTI
SELECT 
	Round(Avg(dti),4)*100 as AVG_MTD_DTI
FROM Bank_loan_data
WHERE MONTH(issue_date) = (SELECT MAX(MONTH(issue_date)-1) FROM Bank_loan_data)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM Bank_loan_data);

-- Good Loan Applications%
Select
	(COUNT( case when loan_status IN ('Fully paid', 'Current') then id end)*100)/
	COUNT(id) as Good_Loan_Percentage
FROM Bank_loan_data;

-- Good Loan Applications
SELECT 
	COUNT(id) as Good_Loan_Applications
FROM Bank_loan_data
WHERE loan_status in ('Fully paid', 'Current');

-- Good Loan Funded Amount
SELECT 
	SUM(loan_amount) as Good_Loan_Funded_Amt
FROM Bank_loan_data
WHERE loan_status in ('Fully paid', 'Current');

-- Good Loan Received Amount
SELECT 
	SUM(total_payment) as Good_Loan_Received_Amt
FROM Bank_loan_data
WHERE loan_status in ('Fully paid', 'Current');

-- Bad Loan Applications%
Select
	(COUNT( case when loan_status = 'Charged off' then id end)*100)/
	COUNT(id) as Good_Loan_Percentage
FROM Bank_loan_data;

-- Bad Loan Applications
SELECT 
	COUNT(id) as Good_Loan_Applications
FROM Bank_loan_data
WHERE loan_status = 'charged off' 

-- Bad Loan Funded Amount
SELECT 
	SUM(loan_amount) as Bad_Loan_Funded_Amt
FROM Bank_loan_data
WHERE loan_status ='charged off' ;

-- Bad Loan Received Amount
SELECT 
	SUM(total_payment) as Bad_Loan_Received_Amt
FROM Bank_loan_data
WHERE loan_status = 'charged off';

-- Loan status Grid View
SELECT
       loan_status,
       COUNT(id) AS LoanCount,
       SUM(total_payment) AS Total_Amount_Received,
       SUM(loan_amount) AS Total_Funded_Amount,
       AVG(int_rate * 100) AS Interest_Rate,
       AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

-- dashboard 2 'Overview'
-- Monthly Trends by Issue Date 

SELECT 
	MONTH(issue_date) as Month_number,
	DATENAME(MONTH , issue_date) as Month_name,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY DATENAME(Month, issue_date), MONTH(issue_date)
ORDER BY MONTH(issue_date); 

-- Regional Analysis by State 
SELECT 
	address_state,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) desc;

-- Loan Term Analysis 
SELECT 
	term,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY term
ORDER BY term;

-- Employee Length Analysis 
SELECT 
	emp_length,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

SELECT * FROM Bank_loan_data;
-- Loan Purpose Breakdown 
SELECT 
	Purpose,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY Purpose
ORDER BY COUNT(id) DESC;

-- Home Ownership Analysis 
SELECT 
	home_ownership,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Received_Amount
FROM Bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
