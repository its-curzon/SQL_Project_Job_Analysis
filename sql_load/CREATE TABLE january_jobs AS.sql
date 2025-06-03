CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
from march_jobs
ORDER BY job_posted_date DESC;


SELECT 
    COUNT(job_id) as number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE  'Onsite'
    END as location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY
    location_category;


WITH january_jobs AS
(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) 

SELECT *
FROM january_jobs;


SELECT name as company_name, company_id
FROM company_dim 
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)






WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name as company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;


WITH top_5_job_skills AS(
    SELECT COUNT(*) as skill_count,
    skill_id
    FROM
        skills_job_dim
    GROUP BY skill_id
    ORDER BY 
        skill_count DESC
    LIMIT 5
)
SELECT sd.skills, t5js.skill_count
FROM skills_dim as sd
JOIN top_5_job_skills as t5js ON t5js.skill_id = sd.skill_id
ORDER BY t5js.skill_count DESC;


WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) as skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact as job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = True AND
        job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)
SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN
    skills_dim as skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;


--UNION (deletes duplicates)
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

--UNION ALL - including dupes
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;


SELECT 
    q1_job_postings.job_title_short,
    q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::date,
    q1_job_postings.salary_year_avg
    FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS q1_job_postings
WHERE
    q1_job_postings.job_title_short = 'Data Analyst'
    AND
    q1_job_postings.salary_year_avg > 70000
ORDER BY salary_year_avg DESC;