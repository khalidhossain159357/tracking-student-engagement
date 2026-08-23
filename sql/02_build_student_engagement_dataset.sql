USE student_engagement_info;

-- ============================================================
-- Calculate total minutes watched by each student in 2021.
-- Consolidate multiple purchase records into one Q2 subscription status per student.
-- Combine engagement data with subscription status.
-- Repeat the same process for 2022.
-- ============================================================

WITH engagement_2021 AS(
	SELECT 
		student_id,
		ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
	FROM 
		student_video_watched
	WHERE 
		YEAR(date_watched) = 2021
	GROUP BY 
		student_id
),

paid_status AS(
	SELECT
		student_id,
		MAX(paid_q2_2021) AS paid_in_q2
	FROM
		purchases_info
	GROUP BY
		student_id
),

student_engagement AS(
	SELECT 
		e.student_id,
        e.minutes_watched,
        p.paid_in_q2
	FROM 
		engagement_2021 AS e
    LEFT JOIN
		paid_status As p
	ON
		e.student_id = p.student_id		
)

SELECT
	*
FROM
	student_engagement
WHERE
	paid_in_q2 IS NOT NULL
AND
	paid_in_q2 = 0
;

WITH engagement_2021 AS(
	SELECT 
		student_id,
		ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
	FROM 
		student_video_watched
	WHERE 
		YEAR(date_watched) = 2021
	GROUP BY 
		student_id
),

paid_status AS(
	SELECT
		student_id,
		MAX(paid_q2_2021) AS paid_in_q2
	FROM
		purchases_info
	GROUP BY
		student_id
),

student_engagement AS(
	SELECT 
		e.student_id,
        e.minutes_watched,
        p.paid_in_q2
	FROM 
		engagement_2021 AS e
    LEFT JOIN
		paid_status As p
	ON
		e.student_id = p.student_id		
)

SELECT
	*
FROM
	student_engagement
WHERE
	paid_in_q2 IS NOT NULL
AND
	paid_in_q2 = 1
;


WITH engagement_2022 AS(
	SELECT 
		student_id,
		ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
	FROM 
		student_video_watched
	WHERE 
		YEAR(date_watched) = 2022
	GROUP BY 
		student_id
),

paid_status AS(
	SELECT
		student_id,
		MAX(paid_q2_2022) AS paid_in_q2
	FROM
		purchases_info
	GROUP BY
		student_id
),

student_engagement AS(
	SELECT 
		e.student_id,
        e.minutes_watched,
        p.paid_in_q2
	FROM 
		engagement_2022 AS e
    LEFT JOIN
		paid_status As p
	ON
		e.student_id = p.student_id		
)

SELECT
	*
FROM
	student_engagement
WHERE
	paid_in_q2 IS NOT NULL
AND
	paid_in_q2 = 0
;


WITH engagement_2022 AS(
	SELECT 
		student_id,
		ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
	FROM 
		student_video_watched
	WHERE 
		YEAR(date_watched) = 2022
	GROUP BY 
		student_id
),

paid_status AS(
	SELECT
		student_id,
		MAX(paid_q2_2022) AS paid_in_q2
	FROM
		purchases_info
	GROUP BY
		student_id
),

student_engagement AS(
	SELECT 
		e.student_id,
        e.minutes_watched,
        p.paid_in_q2
	FROM 
		engagement_2022 AS e
    LEFT JOIN
		paid_status As p
	ON
		e.student_id = p.student_id		
)

SELECT
	*
FROM
	student_engagement
WHERE
	paid_in_q2 IS NOT NULL
AND
	paid_in_q2 = 1
;
