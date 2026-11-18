CREATE TABLE accountsakshi (
    accountid INT PRIMARY KEY,
    balance DECIMAL(18,2) NOT NULL
        CHECK (balance >= 0)
);

CREATE TABLE transactions (
    transactionid INT PRIMARY KEY,
    accountid INT NOT NULL,
    amount DECIMAL(18,2) NOT NULL
        CHECK (amount > 0),
    TransType VARCHAR(10) NOT NULL
        CHECK (TransType IN ('CREDIT', 'DEBIT')),
    FOREIGN KEY (accountid)
        REFERENCES accountsakshi(accountid)
);


create trigger update_balance 
on transactions
after insert
as
begin


if exists(
select 1 from accountsakshi a
inner join( select accountid,sum(amount) as debitamt from inserted
where TransType = 'DEBIT'
group by accountid
)d on a.accountid = d.accountid
where isnull(a.balance,0) < d.debitamt
)
begin 
throw 50001, 'Insufficient account balance.', 1;
end;

update a 
set a.balance = case when i.TransType='Credit' then isnull(balance,0)+I.amount else isnull(balance,0)-I.amount end
from accountsakshi a
inner join inserted i on a.accountid = i.accountid
left join deleted d ON d.transactionid=i.transactionid
where d.transactionid is null

end

SELECT * FROM accountsakshi
select * from transactions

alter table transactions
add requestid uniqueidentifier null
go 

create unique index transactions_requestid
on transactions(requestid)
where requestid is not null

INSERT INTO accountsakshi (accountid, balance)
VALUES
(1, 5000),
(2, 2000),
(3, 1000);

INSERT INTO transactions
(transactionid, accountid, amount, TransType)
VALUES
(101, 1, 1000, 'CREDIT'),
(102, 1, 500, 'DEBIT'),
(103, 2, 300, 'DEBIT'),
(104, 3, 2000, 'DEBIT');

