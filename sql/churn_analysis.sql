-- create database churn_analysis;
 use churn_data_analysis;

select * from telco; /* For now we can consider partner, dependents, phoneservice multiple lines, onlinesecurity,
onlinebackup, techsupport, streamingtv, churn are BINARY CATEGORICAL DATA */

-- How many total customers are their in dataset
select distinct count(customerID) from telco;-- 7032

-- DATA CLEANING-------------------------------------------------------------------------
 
-- Is there any missing values in the dataset
SELECT * FROM telco
WHERE tenure IS NULL;
SELECT * FROM telco
WHERE MonthlyCharges IS NULL;
SELECT * FROM telco
WHERE TotalCharges IS NULL;

-- Incorrect Data-----------------------------------------
SELECT * FROM telco
WHERE tenure < 0;

SELECT * FROM telco
WHERE TotalCharges < 0;

SELECT * FROM telco
WHERE MonthlyCharges < 0; 

-- Duplicate data-------------------------------------
SELECT customerID, COUNT(*)
FROM telco
GROUP BY customerID;

SELECT customerID, COUNT(*) 
FROM telco 
GROUP BY customerID
HAVING count(*) > 1;

SELECT TotalCharges 
FROM telco
WHERE TotalCharges=" ";

SELECT TotalCharges
FROM telco
WHERE TotalCharges IN ("NAN","nan","NA","na");

SELECT TotalCharges 
FROM telco
WHERE TotalCharges IS NULL;

-- REMOVING SPACES FROM THE COLUMN-------------------------------------
UPDATE telco
SET customerID = TRIM(customerID);

-- Checking Datatypes------------------------------------------------
DESC telco;



-- Data Analysis--------------------------------

-- Grouping churned data... 
SELECT Churn, count(churn), COUNT(*)
FROM telco 
GROUP BY Churn;	/* yes = 1869 No = 5163 total records = 7032 
26.6% churned and 74.2% retained.*/
		-- Dividing Churn rate by service, tenure, demography or any other reason...

-- Cross Tabulation Phone Service  Vrs  Churn
SELECT 
PhoneService,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) As Retained,
COUNT(*) AS Total,
((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*))*100) AS Churned_Percentage
FROM telco
GROUP BY PhoneService;

-- Checking how many type muliplelines contain
SELECT MultipleLines, Count(Multiplelines) as count
FROM telco
Group by MultipleLines;-- found 'no phone service / no / yes'

-- updating the "no phone service" into "no"
UPDATE telco
SET MultipleLines = 'No'
WHERE MultipleLines = 'No phone service';

-- Now churn vrs multiplelines
SELECT MultipleLines,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY MultipleLines;

-- InternetService
SELECT InternetService, COUNT(InternetService) as total
FROM telco
GROUP BY InternetService;

SELECT InternetService,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY InternetService; 

-- Online security vrs churn
SELECT OnlineSecurity, COUNT(OnlineSecurity)
FROM telco
GROUP BY OnlineSecurity;-- contains yes/no/no internet service...

-- creating new column for Onlinesecurity to cleaned_online_security...
ALTER TABLE telco
ADD Cleaned_online_security VARCHAR(50);

UPDATE telco -- updating...
SET cleaned_online_security = CASE
WHEN OnlineSecurity = 'No internet service' THEN 'No' 
ELSE OnlineSecurity END;

SELECT Cleaned_online_Security, COUNT(Cleaned_online_Security)-- grouping...
FROM telco
GROUP BY Cleaned_online_Security;

SELECT Cleaned_online_Security,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY Cleaned_online_Security;

-- onlinebackup vrs. churn
SELECT OnlineBackup, COUNT(OnlineBackup)
FROM telco
GROUP BY OnlineBackup; -- YES/NO/No internet service

-- CREATING and UPDATING online_backup to cleaned_online_backup
ALTER TABLE telco
ADD cleaned_online_backup VARCHAR(50);

UPDATE telco
SET cleaned_online_backup = CASE
WHEN OnlineBackup = 'No internet service' THEN 'No' 
ELSE OnlineBackup 
END;

SELECT cleaned_online_backup, COUNT(cleaned_online_backup)
FROM telco
GROUP BY cleaned_online_backup;

SELECT cleaned_online_backup,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY cleaned_online_backup;

-- device protection vrs churn
SELECT DeviceProtection, COUNT(DeviceProtection)
FROM telco
GROUP BY DeviceProtection;

ALTER TABLE telco
ADD cleaned_device_protection VARCHAR(50);

UPDATE telco
SET cleaned_device_protection = CASE
WHEN DeviceProtection = 'No internet service' THEN 'No' 
ELSE DeviceProtection 
END;

SELECT cleaned_device_protection, COUNT(cleaned_device_protection)
FROM telco
GROUP BY cleaned_device_protection;

SELECT cleaned_device_protection,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY cleaned_device_protection;

-- Techsupport vrs. churn
SELECT TechSupport, COUNT(TechSupport)
FROM telco
GROUP BY TechSupport;

ALTER TABLE telco
ADD cleaned_TechSupport VARCHAR(50);

UPDATE telco
SET cleaned_TechSupport = CASE
WHEN TechSupport = 'No internet service' THEN 'No' 
ELSE TechSupport
END;

SELECT cleaned_TechSupport, COUNT(cleaned_TechSupport)
FROM telco
GROUP BY cleaned_TechSupport;

SELECT cleaned_TechSupport,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY cleaned_TechSupport;

-- StreamingTV vrs. churn
SELECT StreamingTV, COUNT(StreamingTV)
FROM telco
GROUP BY StreamingTV;

ALTER TABLE telco
ADD cleaned_StreamingTV VARCHAR(50);

UPDATE telco
SET cleaned_StreamingTV = CASE
WHEN StreamingTV = 'No internet service' THEN 'No' 
ELSE StreamingTV
END;

SELECT cleaned_StreamingTV, COUNT(cleaned_StreamingTV)
FROM telco
GROUP BY cleaned_StreamingTV;

SELECT cleaned_StreamingTV,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY cleaned_StreamingTV;

-- StreamingMovies vrs. churn
SELECT StreamingMovies, COUNT(StreamingMovies)
FROM telco
GROUP BY StreamingMovies;

ALTER TABLE telco
ADD cleaned_StreamingMovies VARCHAR(50);

UPDATE telco
SET cleaned_StreamingMovies = CASE
WHEN StreamingMovies = 'No internet service' THEN 'No' 
ELSE StreamingMovies
END;

SELECT cleaned_StreamingMovies, COUNT(cleaned_StreamingMovies)
FROM telco
GROUP BY cleaned_StreamingMovies;

SELECT cleaned_StreamingMovies,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained,
COUNT(*) AS Total,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY cleaned_StreamingMovies;

-- grouping customers by contract type
SELECT Contract, 
COUNT(CustomerID) as customers,
(SELECT COUNT(*) from telco) as total_customers,-- using subquery...
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY Contract;


-- Grouping all Services( phoneservice, mulitpleservice, internetservice, onlinesercurity
-- onlinebackup, deviceprotection, techsupport)

SELECT "MultipleLines" as Service,
MultipleLines as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

UNION ALL

SELECT "onlinesecurity" as Service,
Cleaned_online_security as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

Union all

SELECT "onlinebackup" as Service,
cleaned_online_backup as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

Union all

SELECT "deviceprotection" as Service,
cleaned_device_protection as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

Union all

SELECT "TechSupport" as Service,
cleaned_TechSupport as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value;


-- Combining streaming service TV and Movies...
SELECT "StreamingTV" as Streaming_Service,
cleaned_StreamingTV as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

UNION all

SELECT "StreamingMovies" as Service,
cleaned_StreamingMovies as value,
ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value;


SELECT SeniorCitizen from telco;
SELECT SeniorCitizen, 
COUNT(CustomerID) as customers,
SUM(COUNT(customerID)) OVER() as total_customers,-- using window function...
ROUND((COUNT(CustomerID)) / SUM(COUNT(customerID)) OVER() * 100,2) as distribution_percentage,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY SeniorCitizen;
-- Updating sernior citizen values (0 & 1) to (yes & no)
-- adding new column and updating....
ALTER TABLE telco 
ADD Cleaned_Senior_citizen VARCHAR(20);

UPDATE  telco 
SET  Cleaned_Senior_citizen =
CASE WHEN SeniorCitizen = 0 THEN 'No' ELSE 'Yes' END;

-- Combining Demographics (SeniorCitizen, Partner and Dependent)
select SeniorCitizen, Cleaned_Senior_citizen FROM telco ;
SELECT "SeniorCitizen" as Demographics,
		Cleaned_Senior_citizen as value,
        ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

Union all

SELECT "Partner" as Demographics,
		Partner as value,
        ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value

Union all

SELECT "Dependents" as Demographics,
		Dependents as value,
        ROUND(((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END))/ (COUNT(*)))*100,2) AS Churned_Percentage
FROM telco
GROUP BY value;

SELECT PaymentMethod, 
COUNT(CustomerID) as customers,
SUM(COUNT(customerID)) OVER() as total_customers,-- using window function...
ROUND((COUNT(CustomerID)) / SUM(COUNT(customerID)) OVER() * 100,2) as distribution_percentage,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY PaymentMethod;


SELECT PaperlessBilling
 FROM telco;
SELECT PaperlessBilling, COUNT(PaperlessBilling)
FROM telco
GROUP BY PaperlessBilling;

SELECT PaperlessBilling, 
COUNT(CustomerID) as customers,
SUM(COUNT(customerID)) OVER() as total_customers,-- using window function...
ROUND((COUNT(CustomerID)) / SUM(COUNT(customerID)) OVER() * 100,2) as distribution_percentage,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY PaperlessBilling;

SELECT MonthlyCharges, 
COUNT(CustomerID) as customers,
SUM(COUNT(customerID)) OVER() as total_customers,-- using window function...
ROUND((COUNT(CustomerID)) / SUM(COUNT(customerID)) OVER() * 100,2) as distribution_percentage,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
FROM telco
GROUP BY MonthlyCharges;-- CONTINIOUS VARIBALE... Bucketing them into ranges.

SELECT CASE
WHEN MonthlyCharges < 20 THEN '0-20' 
WHEN MonthlyCharges BETWEEN 21 AND 40 THEN '21-40'
WHEN MonthlyCharges BETWEEN 41 AND 60 THEN '41-60'
WHEN MonthlyCharges BETWEEN 61 AND 80 THEN '61-80'
WHEN MonthlyCharges BETWEEN 81 AND 100 THEN '81-100'
ELSE '100+' END AS monthly_charge_range,
COUNT(customerID) AS customers,
ROUND(SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) / COUNT(CustomerID) *100,2) as Churn_Percentage
FROM Telco
GROUP BY monthly_charge_range
ORDER BY monthly_charge_range;
 
-- TOTAL CHARGES..
SELECT * FROM telco; 
SELECT MAX(TotalCharges), MIN(TotalCharges)
FROM telco;
-- CONVERTING INTO BUCKETS..
SELECT CASE
WHEN TotalCharges BETWEEN 0 AND 1000 THEN '0-1000'
WHEN TotalCharges BETWEEN 1001 AND 3000 THEN '1001-3000'
WHEN TotalCharges BETWEEN 3001 AND 5000 THEN '3001-5000'
WHEN TotalCharges BETWEEN 5001 AND 7000 THEN '5001-7000'
ELSE '7001+' END as Total_charge_range,
COUNT(customerID) AS Customers,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(CustomerID) *100,2) as churned_percentage,
ROUND(SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) / COUNT(CustomerID) *100,2) as retained_percentage
FROM telco
GROUP BY Total_charge_range
ORDER BY Total_charge_range;



-- grouping tenure into buckets
SELECT CASE
WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
ELSE '49+ Months' 
END AS tenure_group,
COUNT(CustomerID) as customers,
ROUND((COUNT(CustomerID)) / SUM(COUNT(customerID)) OVER() * 100,2) as distribution_percentage,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) /COUNT(CustomerID) *100,2) as Churn_percentage
from telco
group by tenure_group
ORDER BY tenure_group; 

-- using CTE..
WITH tenure_segments AS (
    SELECT *,
        CASE
            WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
			WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
			ELSE '49+ Months' 
        END AS tenure_group
    FROM telco
)
SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS churn_percentage
FROM tenure_segments
GROUP BY tenure_group
ORDER BY churn_percentage DESC;

SELECT 
SUM(CASE WHEN tenure BETWEEN 0 AND 12 THEN 1 ELSE 0 END) as tenure_0_12_months,
SUM(CASE WHEN Contract = 'Month-to-month' THEN 1 ELSE 0 END) AS contract_monthbymonth,
SUM(CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END) as payment_electronic_check,
COUNT(*) AS total
FROM telco; 

SELECT 
Contract,
PaymentMethod,
CASE WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
ELSE '49+ Months'
END AS tenure_group,
COUNT(CustomerID) AS customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(CustomerID), 2) AS churn_percentage
FROM telco
GROUP BY Contract, PaymentMethod,
CASE WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
ELSE '49+ Months' 
END
ORDER BY Contract, PaymentMethod, tenure_group;

SELECT 
COUNT(CASE WHEN churn='Yes' THEN 1 END) as churned_customers,
COUNT(CASE WHEN churn = 'No' THEN 1 END) as retained_customers,
(COUNT(CASE WHEN churn='Yes' THEN 1 END) / COUNT(*) *100) as churn_rate_percentage 
FROM telco;
select* from telco;