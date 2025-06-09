/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Indentify the top 5 in demand skills.
- Focus on all job postings, not just the top-paying ones.
- Why? To retreive the top 5 skills with the highest demand in the total job market,
    to provide insights into the most valuable skills for job seeking.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
- SQL and Python Lead Demand: The most in-demand skills for data analysts are 'sql', 'excel', and 'python', appearing in nearly all job postings. This indicates that proficiency in these languages is essential for data analysis roles.

- Data Visualization and BI Tools are Key: Skills like 'tableau' and 'power bi' are also highly sought after, suggesting that the ability to create visual representations of data is a critical component of the data analyst role.

- Diverse Industry Demand: The high demand for these skills spans various industries, indicating that data analysis is a versatile and essential function across different sectors, from technology to finance and beyond.
*/