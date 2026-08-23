USE student_engagement_info;

-- ============================================================
-- Identify students who were active during the selected periods.
-- Measure the overlap between student engagement across 2021 and 2022.
-- Prepare counts required to calculate marginal, joint and conditional probabilities.
-- Use these results to evaluate whether engagement behavior across the two years shows evidence of dependency.
-- ============================================================


--  Calculating the number of students who watched a lecture in Q2 2021

SELECT 
	COUNT(DISTINCT student_id)
FROM
	student_video_watched
WHERE
	YEAR(date_watched) = 2021;
    
  
-- Calculating the number of students who watched a lecture in Q2 2022

SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched
WHERE
    YEAR(date_watched) = 2022;

    
-- Calculating the number of students who watched a lecture in Q2 2021 and Q2 2022

WITH student_2021 AS(
SELECT 
	student_id
FROM
	student_video_watched
WHERE
	YEAR(date_watched) = 2021
),

student_2022 AS(
SELECT 
	student_id
FROM
	student_video_watched
WHERE
	YEAR(date_watched) = 2022
),

student_21_22 AS(
SELECT 
	student_2021.student_id
FROM
	student_2021
JOIN
	student_2022
ON
	student_2021.student_id = student_2022.student_id
)

SELECT
	COUNT(DISTINCT student_id) overlapping_student
FROM
	student_21_22
;

     
-- Calculating the total number of students who watched a lecture

SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched;