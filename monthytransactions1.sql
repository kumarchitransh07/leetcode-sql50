WITH total_stats AS (
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        COUNT(*) AS trans_count,
        SUM(amount) AS trans_total_amount
    FROM Transactions
    GROUP BY month, country
),
approved_stats AS (
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        COUNT(*) AS approved_count,
        SUM(amount) AS approved_total_amount
    FROM Transactions
    WHERE state = 'approved'
    GROUP BY month, country
)
SELECT 
    t.month,
    t.country,
    t.trans_count,
    COALESCE(a.approved_count, 0) AS approved_count,
    t.trans_total_amount,
    COALESCE(a.approved_total_amount, 0) AS approved_total_amount
FROM total_stats t
LEFT JOIN approved_stats a 
    ON t.month = a.month 
    AND (t.country = a.country OR (t.country IS NULL AND a.country IS NULL));



///

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(IF(state = 'approved', 1, 0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country;
