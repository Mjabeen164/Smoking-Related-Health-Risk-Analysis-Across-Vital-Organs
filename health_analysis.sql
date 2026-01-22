-- Which organs are most affected by smoking?
SELECT
    organ,
    ROUND(AVG(risk_score), 2) AS avg_risk_score
FROM smoking_health_data
WHERE smoker_status = 'Smoker'
GROUP BY organ
ORDER BY avg_risk_score DESC;

-- Distribution of Smoking-Related Cases by Organ
SELECT
    organ,
    SUM(cases_reported) AS total_cases
FROM smoking_health_data
WHERE smoker_status = 'Smoker'
GROUP BY organ
ORDER BY total_cases DESC;

-- Organ-wise Severity Comparison (Risk Levels)
SELECT
    organ,
    CASE
        WHEN risk_score >= 8 THEN 'High Risk'
        WHEN risk_score BETWEEN 4 AND 7 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,
    COUNT(*) AS condition_count
FROM smoking_health_data
WHERE smoker_status = 'Smoker'
GROUP BY organ, risk_level
ORDER BY organ;

-- Which organ contributes the most to total health risk?
SELECT
    organ,
    ROUND(
        SUM(risk_score) * 100.0 /
        SUM(SUM(risk_score)) OVER (),
        2
    ) AS risk_percentage
FROM smoking_health_data
WHERE smoker_status = 'Smoker'
GROUP BY organ
ORDER BY risk_percentage DESC;

-- Is smoking impact isolated or systemic across the body?
SELECT
    organ,
    COUNT(DISTINCT(cond)) AS conditions_identified,
    ROUND(AVG(risk_score), 2) AS avg_risk_score
FROM smoking_health_data
WHERE smoker_status = 'Smoker'
GROUP BY organ
ORDER BY conditions_identified DESC;
