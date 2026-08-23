USE data_scientist_project;

-- ============================================================
-- Calculate total video engagement for each student.
-- Calculate the number of certificates earned by each student.
-- Combine engagement and certificate information at the student level for further relationship and correlation analysis.
-- ============================================================

WITH certificate_status AS(
	SELECT
		student_id,
		COUNT(certificate_id) AS certificates_issued
	FROM
		student_certificates
	GROUP BY
		student_id
),
    
video_status AS(
	SELECT 
		student_id,
		ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
	FROM
		student_video_watched
	GROUP BY
		student_id
),

certificate_video_status AS(
	SELECT
		c.student_id,
        v.minutes_watched,
        c.certificates_issued
    FROM
		certificate_status AS c
	LEFT JOIN
		video_status AS v
	ON
		c.student_id = v.student_id
)

SELECT 
	*
FROM 
	certificate_video_status
WHERE
	minutes_watched IS NOT NULL
;