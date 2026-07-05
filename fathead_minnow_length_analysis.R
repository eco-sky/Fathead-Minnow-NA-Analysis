# ---- Project information ----
# Fathead Minnow Length Analysis
# EVSC 445: Environmental Data Analysis
# Date: 2025-11-25

# Analyzing effects of naphthenic acid concentration and
# Environmental factors on fry length

# ---- 0. Setup ----
# Load required packages (install if missing)

packages <- c("readxl", "ggplot2", "interactions") 

installed <- packages %in% rownames(installed.packages())
if(any(!installed)) install.packages(packages[!installed])

# Load libraries
invisible(lapply(packages, library, character.only = TRUE))

# ---- 1. Load dataset ----

Acid <- read_excel("naphthenic_acid.xlsx")

# ---- 2. Data preparation ----
# Convert numeric columns
numeric_vars <- c("Concentration", "Avg_TimeToHatch", "Avg_TimeToHatch_Viable",
                  "Hatchability", "Deformity_Severe", "Deformity_Mild", "Deformity_All",
                  "HatchSuccess", "Length", "Length_Viable", "Movement", "Heart_Rate",
                  "Temperature", "Dissolved_Oxygen", "pH")
Acid[numeric_vars] <- lapply(Acid[numeric_vars], as.numeric)

# Convert categorical predictors to factors
categorical_vars <- c("Treatment_Source", "Treatment_Type", "PlateID", "GroupID", "Chemical")
Acid[categorical_vars] <- lapply(Acid[categorical_vars], factor)

# ---- 3. Multiple Linear Regression ----
full_model <- lm(Length ~ Concentration + Temperature + Dissolved_Oxygen + pH + Chemical,
                 data = Acid)
null_model <- lm(Length ~ 1, data = Acid)

aic_model <- step(null_model,
                  scope = list(lower = ~1, upper = formula(full_model)),
                  direction = "both")

interaction_formula <- Length ~ Concentration * (Temperature + Dissolved_Oxygen + pH + Chemical)
aic_interaction_model <- step(null_model,
                              scope = list(lower = ~1, upper = interaction_formula),
                              direction = "both")

summary(aic_interaction_model)

# ---- 4. One-way ANOVA and post-hoc ----
anova_model <- aov(Length ~ Chemical, data = Acid)
summary(anova_model)
TukeyHSD(anova_model)

# ---- 5. Residual diagnostics ----
residuals_interaction <- resid(aic_interaction_model)

par(mfrow = c(2, 2))
plot(Acid$Concentration, residuals_interaction, xlab = "Concentration (mg/L)",
     ylab = "Residuals", main = "Residuals vs Concentration")
abline(h = 0, col = "red")

plot(Acid$Dissolved_Oxygen, residuals_interaction, xlab = "Dissolved Oxygen (mg/L)",
     ylab = "Residuals", main = "Residuals vs Dissolved Oxygen")
abline(h = 0, col = "blue")

plot(Acid$pH, residuals_interaction, xlab = "pH",
     ylab = "Residuals", main = "Residuals vs pH")
abline(h = 0, col = "green")

boxplot(residuals_interaction ~ Acid$Chemical, xlab = "Chemical",
        ylab = "Residuals", main = "Residuals vs Chemical")
par(mfrow = c(1, 1))

# ---- 6. Boxplot of Length by Chemical Treatment ----
ggplot(Acid, aes(x = Chemical, y = Length, fill = Chemical)) +
  geom_boxplot(alpha = 0.7) +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal(base_size = 14) +
  labs(title = "Fry Length by Chemical Treatment",
       x = "Chemical Treatment", y = "Length") +
  theme(legend.position = "none")

# ---- 7. Interaction plot: Concentration x Chemical ----
interact_plot(
  model = aic_interaction_model,
  pred = "Concentration",
  modx = "Chemical",
  interval = FALSE,
  colors = c("#d95f02", "#2acc18", "#1b9e77", "#cc0e2e"),
  linetype = "dotted"
) +
  theme_minimal(base_size = 14) +
  labs(x = "Concentration (mg/L)",
       y = "Length",
       title = "Effect of Concentration on Fry Length by Chemical Treatment")