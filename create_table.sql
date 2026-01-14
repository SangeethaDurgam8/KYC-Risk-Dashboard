-- create_table.sql
-- Schema for KYC customer onboarding data

CREATE DATABASE KYCRiskDB;
GO

USE KYCRiskDB;
GO

CREATE TABLE kyc_customers (
    customer_id INT PRIMARY KEY,
    name NVARCHAR(255),
    country NVARCHAR(100),
    industry NVARCHAR(100),
    monthly_txn_volume DECIMAL(18,2),
    pep_flag BIT,
    adverse_media_flag BIT,
    onboarding_date DATE
);
