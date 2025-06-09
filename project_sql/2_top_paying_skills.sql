/*
Question: What skills are the top-paying data analyst positions required to have?
- Use the top 10 highest-paying data analyst positions from the previous query.
- Add the specific skills required for each position.
- Why? To identify the key skills that are associated with the highest-paying data analyst roles, which can help in career planning and skill development.
*/


-- Query to find the top-paying data analyst positions and their required skills as a CTE called `top_paying_jobs`
-- This query retrieves the top 10 highest-paying data analyst positions, available remotely, along with their required skills.
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills AS required_skills
FROM
     top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;

/*

-SQL and Python are Essential: 'sql' and 'python' are the most frequently required skills, appearing in almost all the high-paying data analyst roles. This indicates their fundamental importance for data manipulation, analysis, and scripting in these positions.

-Senior-Level Skills Dominate High Salaries: The majority of these top-paying positions are for senior roles, such as 'Principal Data Analyst', 'Director', or 'Associate Director'. This highlights that experience and leadership within data analysis are strongly correlated with higher compensation.

-Broad Industry Demand for Data Analysts: The companies offering these lucrative positions span various industries, including telecommunications (AT&T), financial technology (SmartAsset), marketing (Pinterest Job Advertisements), and automotive technology (Motional). This shows that high-paying data analyst roles are not confined to a single sector but are in demand across a diverse range of businesses.

*/