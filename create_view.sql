-- create_view.sql
-- View to calculate KYC risk scores

USE KYCRiskDB;
GO

CREATE VIEW kyc_risk_scores AS
SELECT
    customer_id,
    name,
    country,
    industry,
    monthly_txn_volume,
    pep_flag,
    adverse_media_flag,
    onboarding_date,

    -- Country Risk
    CASE 
        WHEN country IN ('Iran', 'North Korea', 'Syria', 'Sudan', 'Afghanistan') THEN 50
        WHEN country IN ('Brazil', 'India', 'South Africa', 'Turkey', 'Mexico') THEN 25
        ELSE 0
    END AS country_score,

    -- Industry Risk
    CASE 
        WHEN industry IN ('Crypto Exchange', 'Gambling', 'Oil & Gas') THEN 30
        WHEN industry IN ('Finance', 'Real Estate') THEN 15
        ELSE 0
    END AS industry_score,

    -- Volume Risk
    CASE
        WHEN monthly_txn_volume > 100000 THEN 20
        WHEN monthly_txn_volume BETWEEN 50000 AND 100000 THEN 10
        ELSE 0
    END AS volume_score,

    -- Flags
    CASE WHEN pep_flag = 1 THEN 40 ELSE 0 END AS pep_score,
    CASE WHEN adverse_media_flag = 1 THEN 40 ELSE 0 END AS adverse_media_score,

    -- Total Score
    (
        CASE 
            WHEN country IN ('Iran', 'North Korea', 'Syria', 'Sudan', 'Afghanistan') THEN 50
            WHEN country IN ('Brazil', 'India', 'South Africa', 'Turkey', 'Mexico') THEN 25
            ELSE 0
        END
        +
        CASE 
            WHEN industry IN ('Crypto Exchange', 'Gambling', 'Oil & Gas') THEN 30
            WHEN industry IN ('Finance', 'Real Estate') THEN 15
            ELSE 0
        END
        +
        CASE
            WHEN monthly_txn_volume > 100000 THEN 20
            WHEN monthly_txn_volume BETWEEN 50000 AND 100000 THEN 10
            ELSE 0
        END
        +
        CASE WHEN pep_flag = 1 THEN 40 ELSE 0 END
        +
        CASE WHEN adverse_media_flag = 1 THEN 40 ELSE 0 END
    ) AS total_score,

    -- Risk Tier
    CASE
        WHEN (
            CASE 
                WHEN country IN ('Iran', 'North Korea', 'Syria', 'Sudan', 'Afghanistan') THEN 50
                WHEN country IN ('Brazil', 'India', 'South Africa', 'Turkey', 'Mexico') THEN 25
                ELSE 0
            END
            +
            CASE 
                WHEN industry IN ('Crypto Exchange', 'Gambling', 'Oil & Gas') THEN 30
                WHEN industry IN ('Finance', 'Real Estate') THEN 15
                ELSE 0
            END
            +
            CASE
                WHEN monthly_txn_volume > 100000 THEN 20
                WHEN monthly_txn_volume BETWEEN 50000 AND 100000 THEN 10
                ELSE 0
            END
            +
            CASE WHEN pep_flag = 1 THEN 40 ELSE 0 END
            +
            CASE WHEN adverse_media_flag = 1 THEN 40 ELSE 0 END
        ) >= 71 THEN 'High'
        WHEN (
            CASE 
                WHEN country IN ('Iran', 'North Korea', 'Syria', 'Sudan', 'Afghanistan') THEN 50
                WHEN country IN ('Brazil', 'India', 'South Africa', 'Turkey', 'Mexico') THEN 25
                ELSE 0
            END
            +
            CASE 
                WHEN industry IN ('Crypto Exchange', 'Gambling', 'Oil & Gas') THEN 30
                WHEN industry IN ('Finance', 'Real Estate') THEN 15
                ELSE 0
            END
            +
            CASE
                WHEN monthly_txn_volume > 100000 THEN 20
                WHEN monthly_txn_volume BETWEEN 50000 AND 100000 THEN 10
                ELSE 0
            END
            +
            CASE WHEN pep_flag = 1 THEN 40 ELSE 0 END
            +
            CASE WHEN adverse_media_flag = 1 THEN 40 ELSE 0 END
        ) BETWEEN 41 AND 70 THEN 'Medium'
        ELSE 'Low'
    END AS risk_tier

FROM kyc_customers;
