# Portfolio site

A multi-page portfolio site, ready to deploy on GitHub Pages.

## Structure
```
index.html              ← homepage: hero, project card grid (opens in-page modal), skills, experience, education
style.css                ← shared styling for every page
dashboard.html           ← interactive churn dashboard (practice dataset)
dashboard-data.json      ← data powering dashboard.html
telco-dashboard.html     ← live Telco Churn dashboard (real 7,043-row dataset)
telco-data.json          ← data powering telco-dashboard.html
superstore-dashboard.html← live Superstore Sales dashboard (real 9,994-row dataset)
superstore-data.json     ← data powering superstore-dashboard.html
netflix-dashboard.html   ← live Netflix Analysis dashboard (real 8,807-row dataset)
netflix-data.json        ← data powering netflix-dashboard.html
resume.pdf               ← downloadable resume
projects/
  churn-dashboard.html    ← Interactive Churn Dashboard (embeds live demo)
  sql-churn-queries.html  ← SQL Churn Queries
  telco-churn.html        ← Telco Customer Churn Analysis (embeds live demo)
  superstore-sales.html   ← Superstore Sales Analysis (embeds live demo)
  duffing-oscillator.html ← Duffing Oscillator Simulation
  kelogsdojo.html         ← KelogsDojo
  netflix-analysis.html   ← Netflix Analysis (embeds live demo)
sql-project/
  customers.csv
  churn_queries.sql
  README.md
datasets/
  telco-churn.csv         ← original Kaggle/IBM Telco Churn dataset
  superstore.csv           ← original Sample Superstore dataset
  netflix-titles.csv       ← original Netflix Movies and TV Shows dataset
```

## Deploy to GitHub Pages

If you already have this repo live, just replace all files with these and push:
```bash
git add .
git commit -m "Redesign: individual project pages"
git push
```

If starting fresh:
1. Create a repo on GitHub (e.g. `Om-M67.github.io` for a root site).
2. Push these files to the repo root:
   ```bash
   git init
   git add .
   git commit -m "Initial portfolio site"
   git branch -M main
   git remote add origin https://github.com/Om-M67/YOUR-REPO-NAME.git
   git push -u origin main
   ```
3. Settings → Pages → Source: `main` branch, `/ (root)` folder → Save.

## Still to do

- The write-up-only project pages (Duffing Oscillator, KelogsDojo) each have a
  "View on GitHub" link pointing at your GitHub profile as a placeholder —
  once each project has its own repo, update that `href` to the specific repo URL.
- Telco Churn, Superstore, and Netflix now have real live dashboards (built
  from your actual datasets) — same placeholder GitHub link applies to those too.
- If you build the real Power BI `.pbix` file, add it (and a screenshot) to
  `sql-project/` or a new `power-bi/` folder, and reference it from
  `projects/churn-dashboard.html`.
