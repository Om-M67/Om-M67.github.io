# Portfolio site

This repo is a ready-to-deploy portfolio site for GitHub Pages.

## Structure
```
index.html          ← the portfolio site itself
dashboard.html       ← interactive churn dashboard (linked from index.html)
dashboard-data.json  ← data powering dashboard.html
sql-project/         ← Telecom Churn SQL project (dataset, queries, write-up)
  customers.csv
  churn_queries.sql
  README.md
```

## Deploy to GitHub Pages

1. **Create a repo** on GitHub (either name it `Om-M67.github.io` for a root
   site, or any other name — e.g. `portfolio` — and it'll be served at
   `Om-M67.github.io/portfolio`).
2. **Push these files** to the root of that repo:
   ```bash
   git init
   git add .
   git commit -m "Initial portfolio site"
   git branch -M main
   git remote add origin https://github.com/Om-M67/YOUR-REPO-NAME.git
   git push -u origin main
   ```
3. **Turn on Pages**: in the repo, go to *Settings → Pages*, set Source to
   `main` branch, `/ (root)` folder, save.
4. Give it a minute — your site will be live at the URL GitHub shows you.

## Before you push

Your real contact info, projects, skills, experience, and education are already
filled in from your resume. Only these still need a real link (currently `#`):
- The **Telco Customer Churn Analysis**, **Superstore Sales Analysis**,
  **Duffing Oscillator**, **KelogsDojo**, and **Netflix Analysis** project cards
  → point each to its real GitHub repo once pushed
- `resume.pdf` is already included in this folder — no change needed unless you
  update your resume later (just replace the file, keep the same name)

## Still in progress

- **Power BI Desktop file (.pbix)** — I can't run Power BI Desktop myself (it's a
  Windows GUI app), so `dashboard.html` is a real, working interactive dashboard
  built in HTML + Chart.js on the same dataset — it's live and linked from the
  site now. If your resume bullet specifically says "Power BI," build the actual
  `.pbix` too using the steps below (~30–45 min), then add a screenshot or a
  Publish-to-Web embed link to `index.html`.

### Power BI Desktop build steps

1. Open Power BI Desktop → **Get Data → Text/CSV** → import `sql-project/customers.csv`
2. **Model data**: confirm `tenure_months`, `monthly_charges`, `total_charges` are
   typed as numbers, `churn` as text
3. **KPI cards**: add 4 Card visuals —
   - Total customers → `Count of customer_id`
   - Churned customers → new measure: `Churned = CALCULATE(COUNT(customers[customer_id]), customers[churn]="Yes")`
   - Churn rate → new measure: `Churn Rate = DIVIDE([Churned], COUNT(customers[customer_id])) `, format as %
   - Avg monthly charge → `Average of monthly_charges`
4. **Bar chart**: Churn Rate (the measure above) by `contract_type`
5. **Donut chart**: Count of customers by `internet_type`
6. **Line chart**: Average of `monthly_charges` by `tenure_months`
7. **Slicer**: add a Slicer visual on `region`, connect it to all visuals (default behavior)
8. Save as `.pbix`, add to `sql-project/` (or a new `power-bi/` folder) and push to GitHub
9. Optional: **File → Publish to web** to get a live embeddable link for `index.html`

