/*
Questions:
1. What are the top-paying data analyst positions in the dataset?
- Identify the top 10 highest-paying data analyst positions, available remotely.
- Focuses on job postings with specified salaries (removed NULL values).
- Why? To understand the highest-paying roles in data analysis, especially those that offer remote work options.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*

-Seniority and Specialization Drive Top Salaries: The highest-paying data jobs frequently include senior titles such as 'Director' or 'Principal Data Analyst', indicating that leadership, extensive experience, and specialized analytical expertise are key determinants of top compensation within the data field.

-Remote/Hybrid Work Dominates High-Paying Roles: A significant portion of these top-paying data jobs are advertised as 'Anywhere' location or explicitly 'Remote/Hybrid', suggesting that flexibility in work arrangements is a prevalent characteristic of highly compensated positions in the data sector.

-Diverse Industry Players Offer Competitive Compensation: While major tech players like Meta offer very high salaries, other companies from various sectors (e.g., AT&T, SmartAsset, Pinterest Job Advertisements, Motional) are also competing for top data talent with highly attractive compensation packages, indicating broad industry demand for skilled data professionals.

*/