USE student_engagement_info;

-- ============================================================
-- Calculate the expected subscription end date based on plan duration.
-- Adjust the subscription end date when a refund occurred.
-- Flag whether each subscription was active during Q2 2021 and Q2 2022.
-- 1 = active during the quarter
-- 0 = not active during the quarter
-- ============================================================

DROP VIEW IF EXISTS purchases_info;

CREATE VIEW purchases_info AS

WITH base_dates AS(
	SELECT 
		purchase_id,
		student_id,
		plan_id,
		date_purchased AS date_start,
		CASE
			WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)
			WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)
			WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)
			WHEN plan_id = 3 THEN CURDATE()
		END AS original_date_end,
        date_refunded
	FROM
		student_purchases
),

effective_dates AS(
	SELECT
		purchase_id,
		student_id,
		plan_id,
		date_start,
        COALESCE(date_refunded, original_date_end) AS date_end
	FROM
		base_dates
)

SELECT 
	*,
    CASE
		WHEN date_end < '2021-04-01' THEN 0
        WHEN date_start > '2021-06-30' THEN 0
        ELSE 1
	END AS paid_q2_2021,
    CASE
		WHEN date_end < '2022-04-01' THEN 0
        WHEN date_start > '2022-06-30' THEN 0
        ELSE 1
    END AS paid_q2_2022
FROM 
	effective_dates
;