--We have transcation details of a bank account ,we want to see current balance of the account on each Year.
--Asked by one of JPMorgan Chase & Co


USE [SSIS]
create table BANK_TRANSCATION(TRANSCATION_ID varchar(10), type nvarchar(10), transcation_date datetime, amount NUMERIC(10));


insert into BANK_TRANSCATION values(19002, 'Deposit', '2021-12-11 16:32:49.433',199)
insert into BANK_TRANSCATION values(19003, 'Deposit', '2021-12-12 16:32:49.433',200)
insert into BANK_TRANSCATION values(19004, 'withdraw', '2021-12-13 16:32:49.433',200)
insert into BANK_TRANSCATION values(19005, 'Deposit', '2021-12-14 16:32:49.433',200)
insert into BANK_TRANSCATION values(19006, 'withdraw', '2021-12-15 16:32:49.433',22)
insert into BANK_TRANSCATION values(19007, 'Deposit', '2021-12-21 16:32:49.433',200)
insert into BANK_TRANSCATION values(19008, 'withdraw', '2021-1-18 16:32:49.433',200)
insert into BANK_TRANSCATION values(19009, 'Deposit', '2021-1-19 16:32:49.433',200)
insert into BANK_TRANSCATION values(19010, 'withdraw', '2021-5-8 16:32:49.433',28)
insert into BANK_TRANSCATION values(19012, 'withdraw', '2021-4-9 16:32:49.433',200)
insert into BANK_TRANSCATION values(19022, 'Deposit', '2021-9-10 16:32:49.433',200)
insert into BANK_TRANSCATION values(19032, 'Deposit', '2020-2-11 16:32:49.433',200)
insert into BANK_TRANSCATION values(19042, 'withdraw', '2020-12-1 16:32:49.433',12)
insert into BANK_TRANSCATION values(19052, 'Deposit', '2020-2-18 16:32:49.433',200)
insert into BANK_TRANSCATION values(19062, 'withdraw', '2020-9-18 16:32:49.433',20)
insert into BANK_TRANSCATION values(19072, 'Deposit', '2020-8-18 16:32:49.433',28)
insert into BANK_TRANSCATION values(19082, 'withdraw', '2021-7-1 16:32:49.433',2)
insert into BANK_TRANSCATION values(1902, 'withdraw', '2021-7-2 16:32:49.433',204)
insert into BANK_TRANSCATION values(1903, 'Deposit', '2021-7-3 16:32:49.433',202)
insert into BANK_TRANSCATION values(1904, 'Deposit', '2021-7-4 16:32:49.433',209)
insert into BANK_TRANSCATION values(1906, 'withdraw', '2021-7-5 16:32:49.433',212)
insert into BANK_TRANSCATION values(1907, 'withdraw', '2019-12-18 16:32:49.433',276)
insert into BANK_TRANSCATION values(1908, 'Deposit', '2019-12-18 16:32:49.433',202)

insert into BANK_TRANSCATION values(1909, 'Deposit', '2019-1-1 16:32:49.433',201)
insert into BANK_TRANSCATION values(190012, 'Deposit', '2019-1-2 16:32:49.433',200)



SELECT * FROM BANK_TRANSCATION

SELECT REPLICATE('*',200) as 'Output'
GO

WITH CTE_Withdraw as (
SELECT DATENAME (year,transcation_date) as 'YEAR',SUM (amount) OVER (PARTITION BY DATENAME (year,transcation_date)) as 'Withdraw_Amount'  from BANK_TRANSCATION 
where type='withdraw'
)
,CTE_YEARLY_Withdraw_Amount as 
(

select YEAR,MAX (Withdraw_Amount) as 'Yearly Withdraw Amount' from  CTE_Withdraw 
group by YEAR

),
CTE_Deposit as (
SELECT DATENAME (year,transcation_date) as 'YEAR',SUM (amount) OVER (PARTITION BY DATENAME (year,transcation_date)) as 'Deposit_Amount'  from BANK_TRANSCATION
where type='Deposit'
),
CTE_YEARLY_Deposit_Amount as
(
select YEAR,MAX (Deposit_Amount) as 'Yearly Deposit Amount' from  CTE_Deposit
group by YEAR
)



SELECT  CTE_YEARLY_Withdraw_Amount.[YEAR], SUM(CTE_YEARLY_Withdraw_Amount.[Yearly Withdraw Amount]- CTE_YEARLY_Deposit_Amount.[Yearly Deposit Amount]) 'Current balance'
FROM CTE_YEARLY_Withdraw_Amount
INNER JOIN CTE_YEARLY_Deposit_Amount ON CTE_YEARLY_Withdraw_Amount.[YEAR]=CTE_YEARLY_Deposit_Amount.[YEAR]
GROUP BY CTE_YEARLY_Withdraw_Amount.[YEAR]
ORDER BY  CTE_YEARLY_Withdraw_Amount.[YEAR] DESC





