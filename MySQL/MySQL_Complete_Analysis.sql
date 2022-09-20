use DA_project_finance;

SELECT 
count(*)
from f1;

SELECT 
count(*)
from f2;

-- Year wise loan amount Stats
SELECT 
YEAR(STR_TO_DATE(issue_d, "%b-%yy")) as 'Years'
,SUM(loan_amnt) as 'Total Loan Amt'
from f1 
GROUP BY Years
order by (YEAR(STR_TO_DATE(issue_d, "%b-%yy")));


-- Grade and sub grade wise revol_bal
Select 
f1.Grade
,f1.Sub_grade
,sum(f2.revol_bal) as 'Total Revol Bal'
from f1 join f2 on f1.id = f2.id
GROUP BY f1.Sub_Grade
Order by f1.grade, f1.Sub_Grade;


-- Total Payment for Verified Status Vs Total Payment for Non Verified Status
Select
f1.Verification_status
,round(sum(f2.total_pymnt)) as 'Total Payment'
from f1 join f2 on f1.id = f2.id
where f1.verification_status in ('Verified', 'Not Verified')
group by f1.verification_status;


-- State wise and month wise loan status

Call Statewise_loanstatus('Fully Paid');

Call Monthwise_loanstatus('Fully Paid');


-- Home ownership Vs last payment date stats
Select
YEAR(STR_TO_DATE(f2.last_pymnt_d, "%b-%yy")) as 'Years'
,f1.home_ownership
,round(sum(f2.last_pymnt_amnt)) as 'Total_Payment'
from f1 join f2 on f1.id = f2.id
where f1.home_ownership in ('RENT', 'MORTGAGE', 'OWN')
group by f1.home_ownership, years
having round(sum(f2.last_pymnt_amnt)) != 0
order by YEAR(STR_TO_DATE(f2.last_pymnt_d, "%b-%yy")), round(sum(f2.last_pymnt_amnt)) desc;

-- 