# Student Engagement & Subscription Analysis

## Project Overview

This project analyzes student engagement on an online learning platform using **SQL, Python, and Excel**. The analysis focuses on video watch time, subscription status, certificates earned, changes in engagement between Q2 2021 and Q2 2022, and the relationship between engagement and learning outcomes.

The project follows an end-to-end analytical workflow: preparing subscription and engagement data with SQL, preprocessing and removing outliers with Python, performing statistical analysis in Excel, evaluating engagement dependencies using probability, and building a simple predictive model.

> **Data Source:** The dataset and original project scenario were provided through the 365 Data Science *Tracking User Engagement with SQL, Excel, and Python* project. The SQL implementation, data preparation, analysis, calculations, visualizations, and repository organization presented here reflect my completed project work.

---

## Business Questions

The analysis aims to answer the following questions:

* How does student engagement differ between free-plan and paying students?
* Did engagement change from Q2 2021 to Q2 2022?
* Is video engagement associated with the number of certificates students earn?
* Is engagement in Q2 2021 independent of engagement in Q2 2022?
* Can minutes watched be used to estimate the number of certificates a student may earn?

---

## Tools & Technologies

* **MySQL** — data preparation, joins, CTEs, views, aggregation, and subscription-status classification
* **Python** — data preprocessing, outlier removal, visualization, and linear regression
* **Microsoft Excel** — descriptive statistics, confidence intervals, hypothesis testing, F-tests, correlation, and probability calculations
* **Pandas** — data manipulation
* **Matplotlib** — visualization
* **Scikit-learn** — train/test split and linear regression
* **Jupyter Notebook** — Python analysis environment

---

## Project Workflow

### 1. Subscription Data Preparation — SQL

Created a reusable subscription view by:

* Calculating subscription start and expected end dates
* Accounting for refunded subscriptions
* Identifying whether each subscription was active during Q2 2021 and Q2 2022
* Creating binary paid-status indicators for the two periods

---

### 2. Student Engagement Dataset Creation — SQL

Calculated total video watch time for each student and connected engagement behavior with subscription status.

The analysis produced four student groups:

* Q2 2021 — Free-plan students
* Q2 2021 — Paying students
* Q2 2022 — Free-plan students
* Q2 2022 — Paying students

These datasets became the foundation for the later statistical analysis.

---

### 3. Engagement & Certificate Dataset — SQL

Combined student engagement with certificate information to create a student-level dataset containing:

* `student_id`
* `minutes_watched`
* `certificates_issued`

This dataset was later used for correlation and predictive modeling.

---

### 4. Outlier Treatment — Python

Examined the distribution of minutes watched and removed extreme engagement observations before performing the group comparisons.

Separate cleaned datasets were maintained for each combination of year and subscription status.

---

### 5. Engagement Comparison & Hypothesis Testing — Excel

Compared engagement between Q2 2021 and Q2 2022 using:

* Mean
* Median
* Standard deviation
* Standard error
* 95% confidence intervals
* F-tests for variance assumptions
* Two-sample t-tests

The F-tests were used to determine the appropriate variance assumption:

* **Free-plan students:** equal variances could be assumed
* **Paying students:** equal variances could not be assumed

Therefore:

* Free-plan students were tested using a **two-sample t-test assuming equal variances**
* Paying students were tested using a **two-sample t-test assuming unequal variances**

---

## Key Findings

### Free-Plan Student Engagement Increased

Average watch time among free-plan students increased from:

* **14.21 minutes in Q2 2021**
* to **16.04 minutes in Q2 2022**

The hypothesis test supported an increase in engagement among free-plan students.

### Paying Students Remained Far More Engaged

Average engagement among paying students was:

* **360.10 minutes in Q2 2021**
* **292.22 minutes in Q2 2022**

Although average engagement declined between the two periods, paying students still watched substantially more content than free-plan students.

The one-sided hypothesis test did **not** provide evidence that paying-student engagement increased in Q2 2022.

### Engagement Distributions Were Right-Skewed

Across the analyzed groups, mean engagement was higher than median engagement, indicating positively skewed distributions in which a smaller number of highly engaged students watched considerably more content than typical students.

---

### 6. Engagement & Certificate Correlation — Excel

The relationship between minutes watched and certificates earned was evaluated using Pearson correlation.

**Correlation coefficient:**

`r = 0.51`

This represents a **moderate positive relationship**.

Students who spent more time watching course content generally tended to earn more certificates, although watch time alone does not fully explain certificate attainment.

---

### 7. Engagement Dependency & Probability Analysis — SQL + Excel

Student activity across Q2 2021 and Q2 2022 was evaluated using joint and conditional probabilities.

| Measure                         | Result |
| ------------------------------- | -----: |
| Students active in Q2 2021      |  7,639 |
| Students active in Q2 2022      |  8,841 |
| Students active in both periods |    640 |
| Total students considered       | 15,840 |
| P(A)                            | 48.23% |
| P(B)                            | 55.81% |
| P(A) × P(B)                     | 26.92% |
| P(A ∩ B)                        |  4.04% |
| P(B \| A)                       | 8.38% |
| P(A \| B)                       | 7.24% |

Because:

`P(A ∩ B) ≠ P(A) × P(B)`

student engagement in the two periods was **not independent**.

Only about **8.38% of students active in Q2 2021 were also active in Q2 2022**, indicating limited overlap between the two groups.

---

### 8. Certificate Prediction — Python

A simple linear regression model was built using:

**Predictor**

`minutes_watched`

**Target**

`certificates_issued`

The fitted model produced:

* **Intercept:** 1.056
* **Minutes-watched coefficient:** 0.00174
* **Training R²:** 0.305

The model therefore explained approximately **30.5% of the variation in certificates issued using minutes watched alone**.

For example, a student watching **1,200 minutes** was estimated to earn approximately:

**3.14 certificates**

The model indicates a positive relationship between engagement and certificate attainment, while the relatively modest R² suggests that additional factors beyond watch time would be needed for stronger prediction.

---

## Main Insights

1. **Subscription status is strongly associated with engagement levels.** Paying students watched substantially more content than free-plan students in both periods.

2. **Free-plan engagement improved from Q2 2021 to Q2 2022**, while average engagement among paying students declined.

3. **Higher engagement is associated with more certificates earned**, with a moderate positive correlation of **0.51**.

4. **Student activity showed limited year-to-year overlap**, with only 640 students active during both analyzed periods.

5. **Watch time alone is not sufficient for strong certificate prediction.** The simple regression model achieved a training R² of approximately **0.31**, suggesting that other behavioral or student-level variables would improve predictive performance.

---

## Repository Structure

```text
tracking-student-engagement/
│
├── README.md
│
├── data/
│   ├── 01_raw/
│   ├── 02_intermediate/
│   └── 03_processed/
│
├── sql/
│   ├── 01_prepare_subscription_data.sql
│   ├── 02_build_student_engagement_dataset.sql
│   ├── 03_build_engagement_certificate_dataset.sql
│   └── 07_analyze_engagement_probabilities.sql
│
├── notebooks/
│   ├── 04_clean_engagement_outliers.ipynb
│   └── 08_predict_certificates_from_engagement.ipynb
│
└── excel/
    ├── 05_engagement_comparison_2021_vs_2022.xlsx
    ├── 06_engagement_certificate_correlation.xlsx
    └── 07_dependencies_and_probabilities.xlsx
```

---

## Skills Demonstrated

### SQL

* Common Table Expressions (CTEs)
* Views
* JOIN operations
* Conditional logic with `CASE`
* Aggregate functions
* Date manipulation
* Data preparation
* Student-level aggregation

### Excel

* Descriptive statistics
* Confidence intervals
* F-tests
* Equal and unequal variance t-tests
* Hypothesis testing
* Correlation analysis
* Probability calculations
* Data visualization

### Python

* Pandas
* Data preprocessing
* Outlier treatment
* Data visualization
* Train/test splitting
* Simple linear regression
* Model interpretation

---

## Conclusion

This project demonstrates how multiple analytical tools can be combined to investigate user engagement from different perspectives.

SQL was used to transform raw platform activity into analysis-ready datasets, Python was used for preprocessing and predictive modeling, and Excel was used for statistical inference and exploratory analysis.

The results show clear differences in engagement between free and paying students, a positive relationship between engagement and certificate attainment, limited continuity in student activity across the two periods, and the limitations of using watch time alone to predict learning outcomes.
