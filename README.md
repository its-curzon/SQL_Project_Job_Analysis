# Introduction
The data job market is vast, so, whilst focusing on Data Analyst positions, I explored top paying jobs, in-demand skills, and where demand meets high salary in Analytics.
- SQL queries seen here: [project_sql folder](project_sql/)
# Background
  I wanted to understand the ins and outs of Data Analytics job postings, specifically the salaries and skills needed.

  With data provided by [Luke B.](https://lukebarousse.com), I was able to find a plethora of listings, with insights on job titles, salaries, and necessary skills.
### Questions Answered:
1. What are the salaries for the highest paying Analyst positions?
2. What skills are associated with these positions?
3. What skills are in highest demand for Analysts?
4. Which exact skills are associated with higher salaries?
5. What are the best skills to have demand and salary wise?

# Tools Used
For this project, I wanted to showcase these tools and skills:

- **SQL**: I used SQL to build and query tables based on a large dataset for critical insight.
- **PostgreSQL**: I chose PostgreSQL as my database manager due to it's powerful handling of data and it's open source!
- **Visual Studio Code (VS Code)**: Code editor I use for all SQL and Database queries and operations.
- **Git and Github**: Perfect for version control and sharing queries and analysis.
# Analysis
**For** each query, I wanted to check out all the most in-demand skills and highest salary for Data Analysts.

### 1. Top Paying Analyst Positions
- To identify the top paying Data Analyst positions, filtered by yearly salary. This highlights the huge demand for data professionals.
```sql
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
```

### 2. Top Paying Skills
- To identify the skills associated with the top paying Analyst positions, filtered by the number of times they appear in each dataset.

```sql
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
```

### 3. Highest Skill Demand
- To identify the skill with the highest demand, filtered by the number of times the specific skill was featured in the data.
```sql
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

```

### 4. Top Skill by Salary
- To focus on the skills listed in the highest salary openings, filtered by highest salarys and the skills associated.
```sql
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
```

### 5. Optimal Skills
- Finally, focusing on the optimal skills for data analysts, filtered and grouped by the highest salaries coupled with the most in-demand skills.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) as average_salary
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
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC, 
    demand_count DESC
LIMIT 25;
```
Inital Breakdown of 2023 Analyst Position Postings:
- **Wide Salary Range**: The top 10 paying analyst roles span from $184K to $650K, which means there is a massive salary potential in this field.
- **Diverse Employment**: Companies like Meta and AT&T are among those with higher salaries, highlighting a broad use case for Analyst among many industries.
- **Job Title Count**: There is a massive diversity among data job titles, from Analyst to Sr. Analyst to Director of Analytics, indicating a wide variety of roles and specializations.
# What I Learned
In this project, I have greatly enhanced my SQL skill set;

- **Complex Query Crafting**: I mastered the art of advanced SQL, including table creation and merging, subquerying, and CTEs.
- **Data Aggregation**: I furthered my ability to aggregate data using GROUP BY and utilizing functions like COUNT() and AVG() in a concise and clear way.
- **Deeper Analysis**: I greatly advanced my SQL skills by fully utilizing my advanced problem solving and logic skills by turning honest questions into actionable data insights.

# Conclusions
### Insights
1. **Top Paying Analyst Positions**: The highest paying salary for a data analyst is $650,000, which is the top of an incredibly varied and vast salary range.

2. **Top Paying Skills**: Nearly every high paying Analyst position requires total proficiency in SQL, suggesting it's criticality.

3. **Most In-Demand Skills**: SQL is also the most required skill for Data Analysts, making it a must-learn.

4. **Higher Salary Skills**: Specialized skills, such as SVN and Solidarity, are associated with the highest average salaries, suggesting an implicit premium on specialized skills.

5. **Optimal Skills**: SQL leads in demand and offers for higher average salaries, which indicates it is the most optimal skill for analysts to use to maximize their earning potential.

### In closing:

This project was a great exercise in SQL and PostgreSQL operations. It also created a guide for skill development and career searching in data. Aspiring data analysts, as well as a vast array of other data positions, can better position themselves in the skill and job markets by focusing on high demand, high salary skills. This highlights how important is is to continually learn and adapt to emerging trends and possibly skill specializations.