![Time to Purchase Banner](https://images.unsplash.com/photo-1551288049-bebda4e38f71?crop=entropy&cs=tinysrgb&fit=crop&w=1400&h=400&fm=jpg)

# Time to Purchase – Clickstream Analysis

*This project was developed as part of the Data Analytics program at **Turing College.***

The dashboaard is also available in **[Tableau Public](https://public.tableau.com/views/TimeBeforePurchaseanalysis/DASHBOARD?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## Project Overview 🔍

This project explores **how long it takes users to complete their first purchase** after arriving on a website.  
The analysis focuses specifically on **same-day behavior**, meaning all events are filtered to remain within the same calendar day.

Understanding **“time to purchase”** helps detect friction points in the user journey, uncover behavioral patterns, and guide business and UX decisions.

📅 **Timeframe:** November 2020 – January 2021

---

## Goal 🎯

Quantify the time (in seconds) from a user’s **first recorded event** to their **first same-day purchase**, enabling performance benchmarking and experience optimization.

---

## Methodology ⚙️

- **SQL in BigQuery** was used to extract and process data from the `turing_data_analytics.raw_events` table.
- For each user per day:
  - The **first event** and the **first purchase** were identified.
  - The **time difference** between them was calculated (in seconds).
- The final dataset contains one row per user per day, enriched with:
  - Device type, browser, country, and event metadata.
- Two engineered fields were added:
  - `is_outlier` → Flags rows exceeding the IQR thresholds.
  - `is_gift` → Flags purchases with no revenue, likely gift redemptions.

---

## Key Findings 📊

- Removing **outliers (14.8%)** reduced the **average time to purchase by 70%**.
- **No correlation** was found between **spending** and **time to purchase**.
- In **late December**, purchase time **dropped >50%**, despite stable revenue.
- A group of **8 tablet users** took **625% longer** than the tablet average and **554% longer** than the global average.
- **Evening users (21:00–00:00)** converted **2× slower** than users at other times.
- **Gift claimers** started out slower, but their average time **gradually decreased**, eventually falling **below that of standard purchasers**.

---

## Limitations ⚠️

- No context was available about the **product type** or **website complexity**, making interpretation subjective.
- Only **calendar-day behavior** was tracked — **true session data** was unavailable.
- The `session_start` event was **inconsistently logged**, limiting precision.
- Outliers represent **diverse and isolated cases**, often one-off purchases with unknown intent.

---

## Recommendations 💡

- 🔧 Investigate potential **UX or performance issues** for **tablet users**.
- 🌙 Explore **UX improvements** or **nudging mechanisms** for **late-evening visitors**.
- 🎁 Refine and simplify the **gift redemption flow**, especially during initial exposure periods.
- ⏱ Start tracking **active session duration** for more reliable behavioral insights.
- 🧪 Use **outlier detection** to trigger **qualitative investigations**, not quantitative benchmarks.

---

## Project Files 🗂️

- `ABP-PA_query.sql` → SQL query used to extract and prepare the dataset for analysis.
- `ABP-PA_data-ready.xlsx` → Cleaned dataset extracted via SQL and used in Tableau for dashboard development.
- `ABP-PA_dashboard.twbx` → Tableau dashboard package for visual exploration of the analysis results.
- `ABP-PA_presentation.pptx` → PowerPoint presentation summarizing the project, key findings, and business recommendations.

---

## Tools & Technologies 🛠️

| Tool / Library                | Purpose                            |
|-------------------------------|------------------------------------|
| **SQL (BigQuery)**            | Data extraction & processing       |
| **Tableau**                   | Data aggregation and visualization |
| **Microsoft PowerPoint**      | Presentation                       |

---

## More from Leonardo Valoppi 👨‍💻

[LinkedIn](https://linkedin.com/in/leonardo-valoppi)  

[GitHub Profile](https://github.com/leonardovaloppi)  

[Tableau Public](https://public.tableau.com/app/profile/leonardo.valoppi/vizzes)
