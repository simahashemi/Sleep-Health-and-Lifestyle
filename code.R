### Add libraries
library(readr)
library(dplyr)
library(ggplot2)
library(GGally)
library(tidyr)
library(ggcorrplot)
library(factoextra)

## Read the dataset
data <- read_csv("~/Documents/Github/Sleep-Health-and-Lifestyle/dataset.csv")
glimpse(data)
summary(data)



#---------------------- 1. preprocessing------------------------------
# check for null values
colSums(is.na(data))
#check the char columns
unique(data$`Sleep Disorder`)
unique(data$`Blood Pressure`)
data <- data %>% 
  separate(`Blood Pressure`, into = c("Systolic" , "Diastolic"), sep = "/") %>%
  mutate(Systolic = as.integer(Systolic),
         Diastolic = as.integer(Diastolic))

unique(data$Occupation)

cleaned_data <- data[, !names(data) %in% c("Person ID","Blood Pressure") ]

#----------------------- 2. Univariate Analysis---------------------
## Age
ggplot(cleaned_data, aes(x = `Age`)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "white", alpha = 0.8) +
  labs(
    title = "Distribution of Participants' Age",
    x = "Age (years)",
    y = "Count"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )

## daily steps
ggplot(cleaned_data, aes(x = `Daily Steps`)) +
  geom_histogram(aes(y = after_stat(count / sum(count))),binwidth = 1000, fill = "orange", color = "white", alpha = 0.8) +
  labs(
    title = "Distribution of Participants' Daily Steps",
    x = "Daily Steps",
    y = "Proportion"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )

## Sleep Duration
ggplot(cleaned_data, aes(x = `Sleep Duration`)) +
  geom_histogram(aes(y = after_stat(count / sum(count))),binwidth = 0.5, fill = "lightgray", color = "white", alpha = 0.8) +
  labs(
    title = "Distribution of Participants' Sleep Duration",
    x = "Sleep Duration",
    y = "Proportion"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )

## BMI Category
ggplot(cleaned_data, aes(x = `BMI Category`,y = ..prop.., group = 1)) +
  geom_bar( fill = "lightgreen", color = "white", alpha = 0.8) +
  labs(
    title = "Distribution of Participants' BMI Category",
    x = "BMI Category",
    y = "Proportion"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )


## Sleep Disorder
ggplot(cleaned_data, aes(x = `Sleep Disorder`,y = ..prop.., group = 1)) +
  geom_bar( fill = "purple", color = "white", alpha = 0.8) +
  labs(
    title = "Distribution of Participants' Sleep Disorder",
    x = "Sleep Disorder",
    y = "Proportion"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )
#------------------------- 3. Bivariate Analysis------------------------
#### Categorical features
## BMI vs. Sleep Quality
ggplot(data, aes(x = `BMI Category`, y = `Quality of Sleep`, fill = `BMI Category`)) +
  geom_boxplot(outlier.color = "gray40", outlier.alpha = 0.6, width = 0.6) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "Sleep Quality Across BMI Categories",
    x = "BMI Category",
    y = "Quality of Sleep"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "gray20"),
    legend.position = "none",
    panel.grid.minor = element_blank()
  )

## BMI vs. Age
ggplot(data, aes(x = `BMI Category`, y = `Age`, fill = `BMI Category`)) +
  geom_boxplot(outlier.color = "gray40", outlier.alpha = 0.6, width = 0.6) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "Sleep Quality Across BMI Categories",
    x = "BMI Category",
    y = "Age"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "gray20"),
    legend.position = "none",
    panel.grid.minor = element_blank()
  )

########## Pair plot for numericla columns ######################
ggpairs(cleaned_data[sapply(cleaned_data, is.numeric)], mapping = aes(color = data$`Sleep Disorder`),
        upper = list(continuous = wrap("points", size = .5)),
        lower = list(continuous = wrap("points", size = .5)),
        diag = list(continuous = "densityDiag")) +
  theme_minimal()+
  theme(
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    legend.title = element_text(size = 9),
    strip.text = element_text(size = 9)
  )+ guides(color = guide_legend(title = "Sleep Disorder"))

############### Correlation matrix
cor_matrix <- cor(cleaned_data[sapply(cleaned_data , is.numeric)])
ggcorrplot(cor_matrix,
           method = "circle",
           lab = TRUE,
           lab_size = 3,
           colors = c("blue","white","red"),
           title = "Correlation Matrix",
           ggtheme = theme_minimal())


## Sleep Quality vs. Sleep Duration
ggplot(data, aes(x = `Quality of Sleep`, y = `Sleep Duration`)) +
  geom_point() +
  geom_smooth(method = "lm")


#---------------------- 4. Multivariate Analysis--------------------
## Stress vs. Sleep Duration for Disorder Groups
ggplot(data, aes(x = `Stress Level`, y = `Sleep Duration`, color = `Sleep Disorder`)) +
  geom_point() +
  geom_smooth(method = "lm")

## Daily Steps vs. Sleep Quality for Disorder Groups
ggplot(data, aes(x = `Daily Steps`, y = `Quality of Sleep`, color = `Sleep Disorder`)) +
  geom_point() +
  geom_smooth(method = "lm")

## Blood Pressure vs. Disordered Groups

ggplot(cleaned_data, aes(x = `Diastolic`, y = `Systolic`, color = `Sleep Disorder`, size = `Heart Rate`)) +
  geom_point(alpha = 0.7) +
  labs(
    
    x = "Diastolic",
    y = "Systolic",
    size = "Heart Rate",
    color = "Sleep Disorder"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )



#--------------------5. PCA ------------------------------
numeric_data <- cleaned_data[sapply(cleaned_data,is.numeric)]


scaled_data <-scale(numeric_data)

pca <- prcomp(scaled_data, center = TRUE, scale. = TRUE)
summary(pca)

fviz_pca_biplot(pca, label = "var", repel = TRUE,
                col.var = "darkblue", col.ind = "gray")

data_pca <- cbind(cleaned_data, as.data.frame(pca$x))