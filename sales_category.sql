SELECT 
  category_1,
  ROUND(SUM(turnover), 0) AS total_turnover,
  ROUND(SUM(purchase_cost), 0) AS total_purchase_cost
FROM `psychic-destiny-449109-v6.course14.gwz_sales`
GROUP BY category_1
ORDER BY total_turnover DESC;