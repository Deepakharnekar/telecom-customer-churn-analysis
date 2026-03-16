### Dataset: WA\_Fn-UseC\_-Telco-Customer-Churn --- from Kaggle.com

### Rows: 7032

### Columns: 21



#### Data Cleaning:

* Dataset renamed from  WA\_Fn-UseC\_-Telco-Customer-Churn to telco.



\- No NULL values found in tenure, montlycharges and Totalcharges

\- Did not found any Incorrect Datatype tenure, monthlycharges and Totalcharges < 0

\- TotalCharges numeric

\- No duplicate customer IDs





#### Business Questions, Analyzing and Querying Data:



1. ##### What does churn mean for this company?

In this dataset,

churn = customer no longer subscribed.

Retained = customer still subscribed.



a telecom/network subscription dataset.



##### 2\. How many Customers Churned vr. Retained?

yes = 1869

No = 5163

total records = 7032

**Overall churn Rate = 26.6%  and retained = 74.2%**



##### 3\. Which services (Phone Service, Multiple Lines, Internet Service, Online Security, Online Backup, Device Protection, Tech Support, Streaming TV, Streaming Movies) have higher churn?

##### 

######  	A. Does Phone Service affects customer churn.

 	-->Churn rates are nearly the same for PhoneService users and non‑users (~26–27%). This indicates that PhoneService alone does not 	strongly influence customer retention. Other factors such as internet service quality, pricing, or bundled offers may be driving 	churn.

 	RECOMENDATIONS

 	improve quality, Collecting Customer Feedback..



######  	B. Multiple Line

 	-->Churn rates differ slightly between customers with multiple lines and those without (~25–28%). This suggests that multiple lines 	may influence retention, but the effect is not strong. Further analysis is needed to understand the churn patterns and identify 	other contributing factors..

 

######      \*\*\*c. Internet Service ====>    fiber optic churn rate 43%---highest till now....

 	--> Fiber optic customers churn at a much higher rate (~43%) compared to DSL (~19%) and non‑internet users (~7%). This suggests 	potential dissatisfaction among fiber optic users, possibly due to service quality, speed issues, or pricing. Further investigation 	 through customer feedback and service quality checks is recommended to identify the root cause and improve retention.

 

######  	D. Online Security... i.e cleaned online security...

 	--> updated to cleaned\_online\_security

 	Customers who subscribe to Online Security churn at less than half the rate of those who don’t (14.6% vs 31.4%). This indicates 	that Online Security is a strong retention driver. Offering or promoting Online Security could help reduce overall churn.

 

######  	E. Online Backup -- ie. cleaned\_online\_backup

 	--> Customers who subscribe to OnlineBackup churn at a significantly lower rate (21.6%) compared to those who don’t (29.2%). This 	suggests that OnlineBackup provides value that helps retain customers. However, further investigation into the quality of the 	backup service and customer feedback is needed to understand the drivers of churn more deeply.

 

######  	F. Device Protection -- i.e cleaned\_device\_protection

 	--> Customers who subscribe to Device Protection churn at a lower rate (22.4%) compared to those who don’t (28.7%). This suggests 	that Device Protection contributes to customer retention. However, further investigation into service quality, customer  	satisfaction, and feedback is recommended to confirm whether the reduced churn is directly linked to Device Protection or other 	bundled factors.



######  	G. Tech Support --i.e cleaned\_TechSupport

 	--> Strong retention driver. Customers with Tec Support churn at less than half the rate of those without.



######  	H. Streaming TV --i.e cleaned\_StreamingTV

 	--> Surprisingly, customers with StreamingTV churn more. This suggests possible dissatisfaction with pricing, content, or bundling.



######  	I. Streaming Movies --i.e cleaned\_StreamingMovies

 	--> Same pattern as Streaming TV — subscription correlates with higher churn.



##### 4\. Analyzing Contract, Tenure, Payment mothods and Paperless billings churning behaviour.



######  	A. Contract

 	Month‑to‑month = 55%, One year = 20%, Two years = 23%.

 	Month‑to‑month dominates, and these customers usually churn more because they have less commitment.

 	Since 55% of customers are on month‑to‑month contracts, retention strategies should focus on converting them to longer‑term plans 	through bundled offers, discounts, and trust‑building initiatives.

 

######  	B.payment method

 	Electronic check = 33%, Mailed check = 22%, Bank transfer = 21%, Credit card = 21%.

 	Electronic check customers represent the largest share (33%) and often show higher churn. Investigating hidden fees or customer 	dissatisfaction with payment methods, and introducing more transparent, money‑friendly options, could reduce churn.

 

######  	C.tenure

 	0–12 months → 49% churn		13–24 months → 20% churn

 	25–48 months → 28% churn	49+ months → 9% churn



 	Nearly half of customers in their first year churn (49%), compared to only 9% among long‑tenure customers (49+ months). This 	highlights that early‑stage customers are at the highest risk. Retention strategies should focus on onboarding initiatives, pricing 	offers, and trust‑building during the first year to reduce churn.



 	The most vulnerable segment is new customers (0–12 months) on month‑to‑month contracts paying by electronic check, with churn rates 	exceeding 60%. Even as tenure increases, electronic check users remain significantly more likely to churn compared to other payment 	methods. Targeted retention strategies should focus on converting these customers to safer payment options and longer‑term 	contracts, supported by discounts, transparent pricing, and trust‑building initiatives.



######  	D. Paperlessbillings

 	Paperless billing customers churn twice (i.e 33.59%) as much as non‑paperless(i.e 16.38%), indicating a customers are linked with 	digital payments.





##### 5\. Monthly Charges churn Behaviour

 	Monthly charges Ranges from 0 to 100 -- bucketizing the monthly charges

 	0-20 churn rate(9%)

 	21-40 (17%)

 	41-60 (26%)

 	61-80 (33%)

 	81-100 (37%)--highest churn driver

 	100+  (22%)

 	Churn increases with higher monthly charges. Customers paying above 80 units per month churn at nearly double the rate of 	low‑charge customers, indicating price sensitivity as a 	major churn driver.

 	High monthly charges are strongly linked to churn. Offering discounts, loyalty rewards, or tiered pricing for high‑charge customers 	could reduce attrition.

##### 6\. Demographics Churning Behaviour..

##### 

######  	A. Senior citizens

 	Senior customers (42%) and non-senior customers(24%)

 	Senior citizens are significantly more likely to churn, highlighting the need for targeted retention strategies for older 	customers.



######  	B. Partner

 	without a partner (33%) and with partner(20%)

 	Having Partner linked with low churn.



######  	C.Dependents

 	Non Dependents (31%) and Dependents(16%)

 	Dependents are associated with more retention rate, possibly due to more family usage.

