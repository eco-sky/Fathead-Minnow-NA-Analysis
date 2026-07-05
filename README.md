# Analysis of Naphthenic acids (NAs) on Fathead Minnow Fish

R script exploring how naphthenic acid concentration and environmental factors affect fathead minnow (Pimephales promelas) fry length using Alberta government monitoring data.

## Project Description
This project was completed as part of EVSC 445: Environmental Data Analysis. Environmental contaminants from oil sands, agriculture, and other industrial sources can bioaccumulate in fish, affecting growth and development. This project investigates how naphthenic acid fraction compounds (NAFC), combined with environmental factors such as dissolved oxygen, pH, and chemical treatment, influence fry length.

## Methods
- **Data cleaning:** Convert quantitative variables to numeric, recode categorical predictors as factors, remove missing values (N/A).  
- **Analysis:** Fit multiple linear regression models with and without interaction terms; use Akaike Information Criterion (AIC) for model selection.  
- **Treatment effects:** One-way ANOVA followed by Tukey post hoc comparisons.  
- **Visualization:** Figures showing residual diagnostics, boxplots of treatment effects, and fry length trends.

<img width="1920" height="975" alt="image" src="https://github.com/user-attachments/assets/614d075e-2fe1-4804-9d38-29444f85a28e" />

## Folder Structure
- `Data.mcd/` - Raw and cleaned datasets  
- `R Script/` - Script for data cleaning, regression analysis, ANOVA, and visualization
  
## Key Findings
- NAFC exposure reduces fry length compared with controls and NA-treated embryos.  
- Dissolved oxygen moderates toxicity effects.  
- Interactions between concentration, chemical type, and environmental factors are important for fry growth.  
- The final regression model explained ~53% of variation in fry length.
  
<img width="1920" height="975" alt="image" src="https://github.com/user-attachments/assets/11c33518-86f2-4c37-a19b-53e57538c573" />

<img width="1920" height="975" alt="image" src="https://github.com/user-attachments/assets/6b57f043-e07e-46c5-bcf1-fa9c7395379e" />

## Tools
- **R & RStudio**  
- **inspection**, **ggplot2**, and other R packages for reproducible workflows  
