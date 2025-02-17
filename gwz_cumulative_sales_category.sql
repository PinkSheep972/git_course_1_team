WITH sales_data AS (
  -- Step 1: Aggregate sales data per day and category
  SELECT 
    date_date,
    category_1,
    SUM(turnover_before_promo) AS total_turnover_before_promo,
    SUM(purchase_cost) AS total_purchase_cost
  FROM `psychic-destiny-449109-v6.course14.gwz_sales`
  WHERE category_1 IS NOT NULL -- Exclude discount lines
  GROUP BY date_date, category_1
),

daily_cumulative AS (
  -- Step 2: Calculate cumulative turnover
  SELECT 
    date_date,
    category_1,
    SUM(total_turnover_before_promo) OVER (
      PARTITION BY category_1 
      ORDER BY date_date 
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_turnover,
    
    SUM(total_purchase_cost) OVER (
      PARTITION BY category_1 
      ORDER BY date_date 
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_purchase_cost
  FROM sales_data
),

final_cumulative AS (
  -- Step 3: Convert values to euros (thousands of euros)
  SELECT 
    date_date,
    category_1,
    ROUND(cumulative_turnover / 1000, 1) AS cumulative_turnover_euro,
    ROUND(cumulative_purchase_cost / 1000, 1) AS cumulative_purchase_cost_euro
  FROM daily_cumulative
)

-- Step 4: Final selection of results
SELECT 
  date_date,
  category_1,
  cumulative_turnover_euro AS cumulative_turnover,
  cumulative_purchase_cost_euro AS cumulative_purchase_cost
FROM final_cumulative
ORDER BY date_date, category_1;