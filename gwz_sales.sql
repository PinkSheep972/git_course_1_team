SELECT
    date_date,
    SUM(turnover) AS daily_turnover,
    SUM(discount) AS discount
FROM 
    `data-analytics-bootcamp-363212.course14.gwz_sales`
GROUP BY 
    date_date
ORDER BY 
    date_date;
