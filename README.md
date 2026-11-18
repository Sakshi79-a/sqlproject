# sqlproject
SQL Stored Procedures, Triggers and Database Projects
# Bank Account Balance Management Using SQL Triggers

## Project Overview
This project demonstrates automated bank account balance management using SQL Server triggers. It maintains account balances automatically whenever a credit or debit transaction is inserted into the transactions table.

## Database Structure

**1. accountsakshi**
- `accountid`: Unique account identifier (Primary Key).
- `balance`: Current account balance.
- CHECK constraint prevents negative balances.

**2. transactions**
- `transactionid`: Unique transaction identifier (Primary Key).
- `accountid`: References the account table.
- `amount`: Transaction amount.
- `TransType`: Specifies CREDIT or DEBIT.
- `requestid`: Supports unique request identification through a filtered unique index.

## Key Features

- **Automated Balance Updates:** Uses an AFTER INSERT trigger to update account balances automatically.
- **Credit Transactions:** Adds the transaction amount to the account balance.
- **Debit Transactions:** Deducts the transaction amount from the account balance.
- **Insufficient Balance Validation:** Prevents debit transactions when the available balance is insufficient.
- **Data Integrity:** Uses PRIMARY KEY, FOREIGN KEY and CHECK constraints.
- **Duplicate Request Protection:** Implements a filtered unique index on `requestid` to prevent duplicate non-NULL request IDs.

## SQL Concepts Demonstrated
- CREATE TABLE
- SQL Server Triggers
- INSERTED and DELETED virtual tables
- JOIN and GROUP BY
- Aggregate functions (SUM)
- CASE statements
- IF EXISTS
- THROW for custom error handling
- Constraints and Indexing

## Technologies
- Microsoft SQL Server
- T-SQL

## Learning Outcome
Developed practical experience in database automation, transaction validation, data integrity and trigger-based business logic.
