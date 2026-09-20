-- 1. DATABASE & SCHEMA SETUP
CREATE DATABASE IF NOT EXISTS TELECOM_CHURN_DB;
CREATE SCHEMA IF NOT EXISTS CHURN_ANALYTICS;
USE SCHEMA CHURN_ANALYTICS;
-- 2. TRAIN TABLE VERIFICATION

SELECT COUNT(*) FROM TRAIN;

SELECT * FROM TRAIN LIMIT 5;

DESC TABLE TRAIN;
SELECT COUNT(*) AS TOTAL_RECORDS
FROM TRAIN;
SELECT COUNT(*) AS TOTAL_RECORDS
FROM TEST;
SELECT COUNT(*) AS TOTAL_RECORDS
FROM "SAMPLE";
SELECT COUNT(*) AS TOTAL_RECORDS
FROM DATA_DICTIONARY;
-- 3. TRAIN DATA EXPLORATION
SELECT *
FROM TRAIN
LIMIT 10;
DESC TABLE TRAIN;
-- 4. CHURN DISTRIBUTION
SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS PERCENTAGE
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 5. BASIC CUSTOMER METRICS
SELECT
    COUNT(*) AS TOTAL_CUSTOMERS,
    ROUND(AVG(arpu_6), 2) AS AVG_ARPU_JUNE,
    ROUND(AVG(arpu_7), 2) AS AVG_ARPU_JULY,
    ROUND(AVG(arpu_8), 2) AS AVG_ARPU_AUGUST,
    ROUND(AVG(aon), 2) AS AVG_TENURE_DAYS
FROM TRAIN;
-- 6. CHURN VS ARPU

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(arpu_8), 2) AS AVG_ARPU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 7. CHURN VS TENURE

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(aon), 2) AS AVG_TENURE_DAYS
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 8. CHURN VS RECHARGE

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(total_rech_num_8), 2) AS AVG_RECHARGE_COUNT,
    ROUND(AVG(max_rech_amt_8), 2) AS AVG_MAX_RECHARGE
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 9. CHURN VS VOICE USAGE

SELECT
    churn_probability,
    ROUND(AVG(total_og_mou_8), 2) AS AVG_OUTGOING_MOU,
    ROUND(AVG(total_ic_mou_8), 2) AS AVG_INCOMING_MOU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;

-- 10. CHURN VS DATA USAGE

SELECT
    churn_probability,
    ROUND(AVG(vol_2g_mb_8), 2) AS AVG_2G_MB,
    ROUND(AVG(arpu_2g_8), 2) AS AVG_2G_ARPU,
    ROUND(AVG(arpu_3g_8), 2) AS AVG_3G_ARPU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;

-- 11. MONTHLY ARPU TREND

SELECT
    ROUND(AVG(arpu_6), 2) AS JUNE_ARPU,
    ROUND(AVG(arpu_7), 2) AS JULY_ARPU,
    ROUND(AVG(arpu_8), 2) AS AUGUST_ARPU
FROM TRAIN;

-- 12. DATA QUALITY CHECK
SELECT
    COUNT(*) AS TOTAL_RECORDS,
    COUNT(arpu_6) AS NON_NULL_ARPU_6,
    COUNT(arpu_7) AS NON_NULL_ARPU_7,
    COUNT(arpu_8) AS NON_NULL_ARPU_8
FROM TRAIN;
-- 13. MISSING VALUE CHECK

SELECT
    COUNT(*) AS TOTAL_RECORDS,
    COUNT(id) AS NON_NULL_ID,
    COUNT(churn_probability) AS NON_NULL_CHURN,
    COUNT(arpu_6) AS NON_NULL_ARPU_6,
    COUNT(arpu_7) AS NON_NULL_ARPU_7,
    COUNT(arpu_8) AS NON_NULL_ARPU_8
FROM TRAIN;
-- 14. CHURN DISTRIBUTION

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS PERCENTAGE
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 15. CHURN VS ARPU

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(arpu_8), 2) AS AVG_ARPU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 16. CHURN VS TENURE

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(aon), 2) AS AVG_TENURE_DAYS
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 17. CHURN VS RECHARGE

SELECT
    churn_probability,
    COUNT(*) AS CUSTOMER_COUNT,
    ROUND(AVG(total_rech_num_8), 2) AS AVG_RECHARGE_COUNT,
    ROUND(AVG(max_rech_amt_8), 2) AS AVG_MAX_RECHARGE
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 18. CHURN VS VOICE USAGE

SELECT
    churn_probability,
    ROUND(AVG(total_og_mou_8), 2) AS AVG_OUTGOING_MOU,
    ROUND(AVG(total_ic_mou_8), 2) AS AVG_INCOMING_MOU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 19. CHURN VS DATA USAGE

SELECT
    churn_probability,
    ROUND(AVG(vol_2g_mb_8), 2) AS AVG_2G_USAGE_MB,
    ROUND(AVG(arpu_2g_8), 2) AS AVG_2G_ARPU,
    ROUND(AVG(arpu_3g_8), 2) AS AVG_3G_ARPU
FROM TRAIN
GROUP BY churn_probability
ORDER BY churn_probability;
-- 20. MONTHLY ARPU TREND

SELECT
    ROUND(AVG(arpu_6), 2) AS JUNE_ARPU,
    ROUND(AVG(arpu_7), 2) AS JULY_ARPU,
    ROUND(AVG(arpu_8), 2) AS AUGUST_ARPU
FROM TRAIN;
-- 21. FINAL DATA QUALITY CHECK

SELECT
    COUNT(*) AS TOTAL_RECORDS,
    COUNT(DISTINCT id) AS UNIQUE_CUSTOMERS,
    COUNT(*) - COUNT(DISTINCT id) AS DUPLICATE_ID_COUNT,
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS NULL_ID_COUNT,
    SUM(CASE WHEN churn_probability IS NULL THEN 1 ELSE 0 END) AS NULL_CHURN_COUNT
FROM TRAIN;