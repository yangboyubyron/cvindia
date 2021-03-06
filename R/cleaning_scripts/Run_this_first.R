# library(tidyverse)
# data <- PivotMappe060520r
# data_select <- data %>%
#   dplyr::select(ID, Age, Gender, Location, Country, Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell',
#               'Long Standing Health Issues', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 'Number Of Days Symptoms Showing',
#               'Pregnant', 'Self Diagnosis', 'Shortness of Breath', 'Sore Throat','Reason For Helping', 'Sputum', 'Temperature') %>%
#   dplyr::rename( id = ID,
#                  age = Age,
#                  gender = Gender,
#                  location =  Location,
#                  country = Country,
#                  chills = Chills,
#                  diarrhoea = Diarrhoea,
#                  fatigue = Fatigue,
#                  headache = Headcahe,
#                  healthcare_worker = 'Healthcare Worker',
#                  how_unwell = 'How Unwell',
#                  long_standing_health = 'Long Standing Health Issues',
#                  loss_smell_taste = 'Loss of smell and taste',
#                  muscle_ache = 'Muscle Ache',
#                  nasal_congestion = 'Nasal Congestion',
#                  nausea_vomiting = 'Nausea and Vomiting',
#                  no_days_symptoms_show = 'Number Of Days Symptoms Showing',
#                  pregnant =  'Pregnant',
#                  shortness_breath = 'Shortness of Breath',
#                  sore_throat = 'Sore Throat',
#                  sputum = 'Sputum',
#                  temperature = 'Temperature',
#                  self_diagnosis = 'Self Diagnosis',
#                  tested_or_not = 'Reason For Helping')
# 
# data_select$tested_or_not <- as.factor(data_select)
# 
# test_data <- data_select %>%
#   tidyr::separate('long_standing_health', c('comorbidity_one', 'comorbidity_two', 'comorbidity_three', 'comorbidity_four'), sep = ",") %>%
#   tidyr::replace_na(list('comorbidity_one' = 'None', 'comorbidity_two' = 'None', 'comorbidity_three' = 'None', 'comorbidity_four' = 'None'))
# 
# test_data[test_data == 0] <- NA
# 
# data_rec <- test_data %>%
#   dplyr::mutate(tested_covid = stringr::str_match(tested_or_not, 'Positive')) %>%
#   dplyr::mutate(tested_covid = stringr::str_match(tested_or_not, 'Positive')) %>%
#   tidyr::replace_na(list('tested_covid' = 'Negative')) %>%
#   tidyr::replace_na(list('no_days_symptoms_show' = 'None' )) %>%
#   dplyr::select(id, age, gender, country, chills, Cough, diarrhoea, fatigue, healthcare_worker, 
#                 how_unwell, comorbidity_one, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
#                 no_days_symptoms_show, self_diagnosis, shortness_breath, sore_throat, sputum, temperature, tested_covid)
#   

# write.csv(data_rec, file = "/Users/gabrielburcea/Rprojects/data/data_rec.csv")
# count_positive_negative <- test_data %>% 
#   dplyr::select(id, tested_covid) %>%
#   dplyr::group_by(tested_covid) %>%
#   tally()

# asthma <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Asthma (managed with an inhaler)' | comorbidity_one == "None") 
# 
# 
# long_standing_lung_condition <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Long-Standing Lung Condition' | comorbidity_one == 'None')
# 
# high_blood_pressure <- test_data %>% 
#   dplyr::filter(comorbidity_one == 'High Blood Pressure (hypertension)' | comorbidity_one == "None") 
# 
# obesity <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Obesity' | comorbidity_one == "None") 




# dt_select <- dt_select %>%
#   dplyr::mutate(Age_band = if_else(age == 0 , '0',
#                                      age == 1 | age <= 4 ~ '1-4',
#                                      age == 5 | age <= 9 ~ '5-9',
#                                      age == 10 | age <= 14 ~ '10-14',
#                                      age == 15 | age <= 19 ~ '15-19',
#                                      age == 20 | age <= 24 ~ '20-24',
#                                      age == 25 | age <= 29 ~ '25-29',
#                                      age == 30 | age <= 34 ~ '30-34',
#                                      age == 35 | age <= 39 ~ '35-39',
#                                      age == 40 | age <= 44 ~ '40-44',
#                                      age == 45 | age <= 49 ~ '45-49',
#                                      age == 50 | age <= 54 ~ '50-54',
#                                      age == 55 | age <= 59 ~ '55-59',
#                                      age == 60 | age <= 64 ~ '60-64',
#                                      age == 65 | age <= 69 ~ '65-69',
#                                      age == 70 | age <= 74 ~ '70-74',
#                                      age == 75 | age <= 79 ~ '75-79',
#                                      age == 80 | age <= 84 ~ '80-84',
#                                      age == 85 | age <= 89 ~ '85-89',
#                                      age == 90 | age <= 94 ~ '90-94',
#                                      age >= 95  ~ '95+'))


# data_rec <- read.csv("/Users/gabrielburcea/Rprojects/data/PivotMappe060520r.csv", header = TRUE, sep = ",")
# data_select <- data_rec %>%
#   #### rename reason for helping as it contains whether respondents have been tested negative or positive
#   dplyr::rename(tested_or_not = 'Reason.For.Helping') %>%
#   tidyr::separate('Long.Standing.Health.Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
#                                                    'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight',
#                                                    'Comorbidity_nine'), sep = ",")
# data_rec <- data_select  %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   tidyr::drop_na('Comorbidity') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 'Yes') %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
#   dplyr::select(-None)



########################################
#### Loading libraries needed ##########
########################################
# library(caret)
# library(corrplot)
# library(tidyverse)
# library(e1071)
# library(DMwR)
# library(lattice)
# library(pROC)
# library(ROCR)
# library(ggplot2)
# library(reshape2)
# library(leaps)
# library(MASS)
# library(rms)
# level_key <-
#   c(
#     "None" = 'none',
#     "Curious" = "none",
#     'Showing Symptoms But Not Tested,Curious' = "showing symptoms",
#     'Showing Symptoms But Not Tested' = "showing symptoms",
#     'Self-Isolating With No Symptoms' = "none",
#     'Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms' = "showing symptoms",
#     'Tested Positive' = 'positive',
#     'Curious,Self-Isolating With No Symptoms' = 'none',
#     'Tested Negative But Have Symptoms' = 'showing symptoms',
#     'Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus' = 'live_with_scorona',
#     'Live With Someone With Coronavirus,Curious' = 'live_with_scorona',
#     'Tested Negative But Have Symptoms,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Negative But Have Symptoms,Curious' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Self-Isolating With No Symptoms' = 'positive',
#     'Showing Symptoms But Not Tested,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'showing symptoms',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms' = 'showing symptoms',
#     'Tested Positive,Curious' = 'positive',
#     'Tested Positive,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Live With Someone With Coronavirus' = 'positive',
#     'Recovered But Have New Symptoms,Curious' = 'positive',
#     'Live With Someone With Coronavirus,Self-Isolating With No Symptoms' = 'live_with_scorona',
#     'Tested Positive,Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms' = 'live_with_scorona',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious' = 'showing symptoms',
#     'Recovered But Have New Symptoms,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Showing Symptoms But Not Tested,Live With Someone With Coronavirus' = 'showing symptoms',
#     'Tested Positive,Recovered But Have New Symptoms,Curious' = 'positive',
#     'Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious'  = 'showing symptoms'
#    )

# #################################################
# ######### Get a numeric dataset #################
# #################################################

# level_key_temperature <-
#   c( "38.1-39" = '38.2-39',
#      "38.1-39" = 'Temperature')
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# 
# data_model <- data_rec %>%
#   dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key),
#                 number_days_symptoms = forcats::fct_recode(Number.Of.Days.Symptoms.Showing, !!!level_no_days_sympt_show) )

# data_model$gender <- as.factor(data_model$Gender)
# data_model$country <- as.factor(data_model$Country)
# data_model$chills <- as.factor(data_model$Chills)
# data_model$cough  <- as.factor(data_model$Cough)
# data_model$diarrhoea  <- as.factor(data_model$Diarrhoea)
# data_model$fatigue  <- as.factor(data_model$Fatigue)
# data_model$headache   <- as.factor(data_model$Headcahe)
# data_model$loss_smell_taste   <- as.factor(data_model$Loss.of.smell.and.taste)
# data_model$muscle_ache  <- as.factor(data_model$Muscle.Ache)
# data_model$nasal_congestion <- as.factor(data_model$Nasal.Congestion)
# data_model$nausea_vomiting  <- as.factor(data_model$Nausea.and.Vomiting)
# data_model$self_diagnosis <- as.factor(data_model$Self.Diagnosis)
# data_model$shortness_breath <- as.factor(data_model$Shortness.of.Breath)
# data_model$sore_throat <- as.factor(data_model$Sore.Throat)
# data_model$sputum <- as.factor(data_model$Sputum)
# data_model$temperature  <- as.factor(data_model$Temperature)
# data_model$health_care_worker <- as.factor(data_model$Healthcare.Worker)
# data_model$care_home_worker <- as.factor(data_model$Care.Home.Worker)

# data_model$asthma   <- as.factor(data_model$`Asthma (managed with an inhaler)`)
# data_model$diabetes_type_two <- as.factor(data_model$`Diabetes Type 2`)
# data_model$obesity <- as.factor(data_model$Obesity)
# data_model$hypertension  <- as.factor(data_model$`High Blood Pressure (hypertension)`)
# data_model$heart_disease  <- as.factor(data_model$`Long-Standing Heart Disease`)
# data_model$kidney_disease <- as.factor(data_model$`Long-Standing Kidney Disease`)
# data_model$lung_condition <- as.factor(data_model$`Long-Standing Lung Condition`)
# data_model$liver_disease <- as.factor(data_model$`Long-Standing Liver Disease`)
# data_model$diabetes_type_one <- as.factor(data_model$`Diabetes Type 1 (controlled by insulin)`)
# data_model$how_unwell <- as.factor(data_model$How.Unwell)
# data_model$age <- as.factor(data_model$Age)
# data_model$covid_tested <- as.factor(data_model$Covid_tested)



# data_selected$number_days_symptoms <- as.numeric(data_selected$number_days_symptoms)


 
# #### Refactor the levels ##################################################
# data_sel<- data_model %>%
#   dplyr::rename(location = Location, date_completed = Date.Completed, pregnant = Pregnant, id = ID) %>%
#   dplyr::select(id,
#                 covid_tested,
#                 tested_or_not,
#                 age,
#                 gender,
#                 country,
#                 location,
#                 date_completed,
#                 care_home_worker,
#                 health_care_worker,
#                 how_unwell,
#                 self_diagnosis,
#                 chills,
#                 cough,
#                 diarrhoea,
#                 fatigue,
#                 headache,
#                 how_unwell,
#                 loss_smell_taste,
#                 muscle_ache,
#                 nasal_congestion,
#                 nausea_vomiting,
#                 number_days_symptoms,
#                 pregnant,
#                 self_diagnosis,
#                 shortness_breath,
#                 sore_throat,
#                 sputum,
#                 temperature,
#                 asthma,
#                 diabetes_type_one,
#                 diabetes_type_two,
#                 obesity,
#                 hypertension,
#                 heart_disease,
#                 lung_condition,
#                 liver_disease,
#                 hypertension,
#                 kidney_disease)
# 
# write.csv(data_sel, file = "/Users/gabrielburcea/Rprojects/data/data_descr_15062020.csv", row.names = FALSE)




# level_key_chills <-
#   c( 'Yes' = "Chills",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_cough <-
#   c( 'Yes' = "Cough",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_diarrhoea <-
#   c( 'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_fatigue <-
#   c( 'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_headache <-
#   c('No' = "No",
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe",
#     'Yes' = "Headcahe")
# level_key_loss_smell_taste <-
#   c( 'Yes' = "Loss of smell and taste",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_muschle_ache <-
#   c( 'No' = "No",
#      'Yes' = "Muscle Ache",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_nasal_congestion <-
#   c( 'No' = "No",
#      'Yes' = "Nasal Congestion",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_nausea_vomiting <-
#   c( 'No' = "No",
#      'Yes' = "Nausea and Vomiting",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_self_diagnosis <-
#   c( 'No' = "None",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_short_breath <-
#   c( 'No' = "No",
#      'Yes' = "Shortness of Breath",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_sore_throat <-
#   c( 'No' = "No",
#      'Yes' = "Sore Throat",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_sputum <-
#   c( 'No' = "No",
#      'Yes' = "Sputum",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_care_home_worker <-
#   c('Yes' = 'Yes',
#     'No' = 'No')




#### Refactor the levels ##################################################
# data_not_sev <- data_sel %>%
#   dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills),
#                 cough = forcats::fct_recode(cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(headache, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(loss_smell_taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muschle_ache),
#                 nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(temperature, !!!level_key_temperature),
#                 care_home_worker = forcats::fct_recode(care_home_worker, !!!level_key_care_home_worker))
# 
# 
#write.csv(data_not_sev, file = "/Users/gabrielburcea/Rprojects/data/data_no_sev.csv", row.names = FALSE)


# 
# test <- data_categ_nosev %>%
#   dplyr::mutate(asthma_diabetes_one = if_else(asthma == 'Yes' | diabetes_type_one == "Yes" , TRUE, FALSE),
#                 asthma_diabetes_two = if_else(asthma == 'Yes' | diabetes_type_two == "Yes" , TRUE, FALSE),
#                 asthma_hypertension = if_else(asthma == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
#                 asthma_obesity = if_else(asthma == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 asthma_heart_disease = if_else(asthma == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 asthma_lung_cond = if_else(asthma == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 asthma_liver_disease = if_else(asthma == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 asthma_kidney_disease = if_else(asthma == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 diabetes_one_diabetes_two = if_else(diabetes_type_one == 'Yes' | diabetes_type_one == "Yes" , TRUE,FALSE ),
#                 diabetes_one_hypertension = if_else(diabetes_type_one == 'Yes' | hypertension == 'Yes' , TRUE,  FALSE),
#                 diabetes_one_obesity = if_else(diabetes_type_one == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 diabetes_one_heart_disease = if_else(diabetes_type_one == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_one_lung_cond = if_else(diabetes_type_one == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
#                 diabetes_one_liver_disease = if_else(diabetes_type_one == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_one_kidney_disease = if_else(diabetes_type_one == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
# 
#                 diabetes_two_hypertension = if_else(diabetes_type_two == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
#                 diabetes_two_obesity = if_else(diabetes_type_two == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 diabetes_two_disease = if_else(diabetes_type_two == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_two_lung_cond = if_else(diabetes_type_two == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 diabetes_two_liver_disease = if_else(diabetes_type_two == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_two_kidney_disease = if_else(diabetes_type_two == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 hypertension_obesity = if_else(hypertension == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 hypertension_heart_disease = if_else(hypertension == 'Yes' | heart_disease == 'Yes' , TRUE,FALSE ),
#                 hypertension_lung_cond = if_else(hypertension == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 hypertension_liver_disease = if_else(hypertension == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 hypertension_kidney_disease = if_else(hypertension == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 obesity_heart_disease = if_else(obesity == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 obesity_lung_cond = if_else(obesity == 'Yes' | lung_condition == 'Yes' , TRUE,  FALSE),
#                 obesity_liver_disease = if_else(obesity == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 obesity_kidney_disease = if_else(obesity == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 heart_disease_lung_cond = if_else(heart_disease == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
#                 heart_disease_liver_disease = if_else(heart_disease == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 heart_disease_kidney_disease = if_else(heart_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 lung_condition_liver_disease = if_else(lung_condition == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 lung_condition_kidney_disease = if_else(lung_condition == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# 
#                 liver_disease_kidney_disease = if_else(liver_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE))
# 
# 
# write.csv(test, file = "/Users/gabrielburcea/Rprojects/data/data_no_sev_stats.csv", row.names = FALSE)

