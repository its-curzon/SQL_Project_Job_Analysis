/*
What are the top skills based on salary for data analysts?
- Look at the average salary for each Data Analyst skill.
- Focus on roles with specified salaries, in any location.
- Why? To reveal how different skills impact salary, helping job seekers prioritize skill development for better compensation.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as average_salary
   
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;

/*

- Emerging Technologies Command Premium Salaries: Skills in high-growth areas like blockchain development (e.g., Solidity) and modern backend programming (Golang) are experiencing strong demand, leading to some of the highest average salaries and continued growth potential. 

- Stable Demand for Core Infrastructure and Big Data Skills: Established technologies and infrastructure tools like Couchbase, Kafka, Terraform, Ansible, and programming languages such as Scala continue to command competitive and relatively stable high salaries.

- Varying Trends for Collaborative and Version Control Tools: Salaries associated with widely adopted development and collaboration tools such as SVN, GitLab, Atlassian, Bitbucket, and productivity platforms like Notion can vary. While essential, these skills are often part of a broader skillset rather than primary drivers of top-tier salaries.

*/
