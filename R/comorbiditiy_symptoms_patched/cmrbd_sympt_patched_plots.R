cleaned_data_22092020 <- readr::read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020_2nd_dataset.csv")

cleaned_data_22092020 <- cleaned_data_22092020 %>%
  dplyr::mutate(age_band = dplyr::case_when(
    age == 0 | age <= 9 ~ '0-9',
    age == 10 | age <= 19 ~ '10-19',
    age == 20 | age <= 29 ~ '20-29',
    age == 30 | age <= 39 ~ '30-39',
    age == 40 | age <= 49 ~ '40-49',
    age == 50 | age <= 59 ~ '50-59',
    age >= 60 ~ "60+"))

cleaned_data_22092020 <- cleaned_data_22092020 %>%
  dplyr::group_by(covid_tested) %>%
  drop_na()

cleaned_data_22092020 %>%
  dplyr::group_by(covid_tested) %>%
  tally() %>%
  dplyr::mutate(Percent = n/sum(n)*100)


country_covid_tested <- cleaned_data_22092020 %>%
  dplyr::group_by(country) %>%
  tally() %>%
  dplyr::mutate(Percent = n/sum(n)*100)

count_symptoms_positive <- cleaned_data_22092020 %>%
  dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
                sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
  dplyr::filter(covid_tested == "positive") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "Symptoms",
                      values_to = "bolean_yn_sympt") %>%
  dplyr::filter(bolean_yn_sympt == "Yes") %>%
  dplyr::rename(country = Country) %>%
  dplyr::group_by(country, age_band, Symptoms) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100)


count_symptoms_positive_all_countries <- cleaned_data_22092020  %>%
  dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
                sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(Country != "Brazil" ) %>%
  dplyr::filter(Country != "India") %>%
  dplyr::filter(Country != "Pakistan") %>%
  dplyr::filter(Country != "Mexico") %>%
  dplyr::filter(Country != "United Kingdom") %>%
  dplyr::filter(covid_tested == "positive") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "Symptoms",
                      values_to = "bolean_yn_sympt") %>%
  dplyr::filter(bolean_yn_sympt == "Yes") %>%
  add_column(country = c("All countries")) %>%
  dplyr::group_by(country, age_band, Symptoms) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::select(country, Symptoms, country, Count, Percent)

count_symptoms_positive_add <- full_join(count_symptoms_positive_all_countries, count_symptoms_positive)


symptom_levels <- c(
  "muscle ache" = "muscle_ache",
  "nasal congestion" = "nasal_congestion",
  "nausea and vomiting" = "nausea_vomiting",
  "sore throat" = "sore_throat",
  "loss of appetite" = "loss_appetite",
  "chest pain" = "chest_pain",
  "itchy eyes" = "itchy_eyes",
  "joint pain" = "joint_pain"
)


count_symptoms_positive_add <- count_symptoms_positive_add %>%
  dplyr::mutate(Symptoms = forcats::fct_recode(Symptoms, !!!symptom_levels))

sympt_count_plot <- ggplot2::ggplot(count_symptoms_positive_add, ggplot2::aes(x = age_band, y = Count, group = Symptoms, fill = Symptoms)) +
  ggplot2::geom_area( color = "white") +
  ggplot2::scale_x_discrete(limits = c( "0-9", "10-19", "20-29", "30-39", "40-49", "50-59", 
                                        "60+"), expand = c(0, 0)) +
  ggplot2::scale_fill_viridis_d() +
  ggplot2::scale_y_continuous( breaks = c(0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000
                )) +
  ggplot2::labs(#title = "% of responders across countries",
    y = "Count", x = "Age band") +
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = ggplot2::element_text(size = 17, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 17),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    strip.background = element_blank(),
    strip.text = element_text(size = 10, face = "bold", hjust = 0), 
    legend.title = element_text(size = 16), 
    legend.text = element_text(size = 13)) +
  ggplot2::facet_wrap(~country, ncol = 1)

sympt_count_plot

count_comorbidities_positive <- cleaned_data_22092020 %>%
  dplyr::select(id, Country, age_band,asthma, diabetes_type_one, diabetes_type_two,
                obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
  dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
  tidyr::pivot_longer(cols = 4:12,
                      names_to = "Comorbidities",
                      values_to = "bolean_yn_comorb") %>%
  dplyr::filter(bolean_yn_comorb == "Yes") %>%
  dplyr::group_by(Country, age_band, Comorbidities) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::rename(country = Country)

count_comorbidities_positive_all_countries <- cleaned_data_22092020  %>%
  dplyr::select(id, Country, age_band, asthma, diabetes_type_one, diabetes_type_two,
                obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
  dplyr::filter(Country != "Brazil" ) %>%
  dplyr::filter(Country != "India") %>%
  dplyr::filter(Country != "Pakistan") %>%
  dplyr::filter(Country != "Mexico") %>%
  dplyr::filter(Country != "United Kingdom") %>%
  dplyr::filter(covid_tested == "positive") %>%
  tidyr::pivot_longer(cols = 4:12,
                        names_to = "Comorbidities",
                        values_to = "bolean_yn_comorb") %>%
  dplyr::filter(bolean_yn_comorb == "Yes") %>%
  add_column(country = c("All countries")) %>%
  dplyr::group_by(country, age_band, Comorbidities) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::select(country, Comorbidities, country, Count, Percent)

count_comorbidities_positive_add <- full_join(count_comorbidities_positive, count_comorbidities_positive_all_countries)

comorbidities_levels <- c(
  "heart disease" = "heart_disease",
  "lung disease" = "lung_disease",
  "liver disease" = "liver_disease",
  "kidney disease" = "kidney_disease"
)


count_comorbidities_positive_add <- count_comorbidities_positive_add %>%
  dplyr::mutate(Comorbidities = forcats::fct_recode(Comorbidities, !!!comorbidities_levels))




# sympt_percent_plot <- ggplot(count_symptoms_positive) +
#   geom_area(aes(x = age_band, y = Percent, group = Symptoms, fill = Symptoms),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_viridis_d() +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# sympt_percent_plot


comorb_count_plot <- ggplot2::ggplot(count_comorbidities_positive_add, ggplot2::aes(age_band, Count, group = Comorbidities, fill = Comorbidities), color = "white") +
  ggplot2::geom_area( color = "white") +
  scale_x_discrete(limits = c("0-9", "10-19", "20-29", "30-39", "40-49", "50-59", 
                              "60+"), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(breaks = c(0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000)) +
  scale_fill_brewer(palette = "Set1") +
  ggplot2::labs(#title = "% of responders across countries",
    y = "Count", x = "Age band") +
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = ggplot2::element_text(size = 17, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 17),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    strip.background = element_blank(),
    strip.text = element_text(size = 10, face = "bold", hjust = 0), 
    legend.title = element_text(size = 16), 
    legend.text = element_text(size = 13)) +
  ggplot2::facet_wrap(~country, ncol = 1) 


comorb_count_plot


`# comorb_percent_plot <- ggplot(count_comorbidities_positive) +
#   geom_area(aes(age_band, Percent, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Oranges") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_percent_plot


plot_sympt_comorb <-  sympt_count_plot + theme(legend.position = "none") +
  comorb_count_plot + theme(legend.position = "none") + plot_legend


plot_sympt_comorb

plot_comorb <- comorb_count_plot + theme(legend.position = "none") +
  comorb_percent_plot + theme(legend.position = "none")

plot_legend <- wrap_plots(
  cowplot::get_legend(sympt_count_plot),
  cowplot::get_legend(comorb_count_plot),
  ncol = 1)


wrap_plots(sympt_count_plot,comorb_count_plot,
           nrow = 1, widths = c(2, 2, 1))
  # plot_annotation(
  #   title = "Figure 2: SARS-Covid-19 Symptoms and Comorbidities in responders with Covid tested positive, across top 5 countries with the highest prevalence of responders",
  #   subtitle = "Symptoms of SARS-Covid-19, first two columns, on the left in counts and percentages and comorbidities on the right counts and percentages \nNote: i) excludes the responders who show symptoms of SARS-Covid-19; ii) period chosen - between 04/09/2020 - 22/09/2020",
  #   caption = "Data source: Your.md")



######################################################
# Doing the same for showing symptoms responders
#####################################################
count_symptoms_shwsympt <- cleaned_data_22092020 %>%
  dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
                sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "Symptoms",
                      values_to = "bolean_yn_sympt") %>%
  dplyr::filter(bolean_yn_sympt == "Yes") %>%
  dplyr::group_by(Country, age_band, Symptoms) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::rename(country = Country)

count_symptoms_showing_symptoms_all_countries <- cleaned_data_22092020  %>%
  dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
                sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(Country != "Brazil" ) %>%
  dplyr::filter(Country != "India") %>%
  dplyr::filter(Country != "Pakistan") %>%
  dplyr::filter(Country != "Mexico") %>%
  dplyr::filter(Country != "United Kingdom") %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "Symptoms",
                      values_to = "bolean_yn_sympt") %>%
  dplyr::filter(bolean_yn_sympt == "Yes") %>%
  add_column(country = c("All countries")) %>%
  dplyr::group_by(country, age_band, Symptoms) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::select(country, Symptoms, country, Count, Percent)


count_symptoms_showing_symptoms_add <- full_join(count_symptoms_showing_symptoms_all_countries, count_symptoms_shwsympt)

symptom_levels <- c(
  "muscle ache" = "muscle_ache",
  "nasal congestion" = "nasal_congestion",
  "nausea and vomiting" = "nausea_vomiting",
  "sore throat" = "sore_throat",
  "loss of appetite" = "loss_appetite",
  "chest pain" = "chest_pain",
  "itchy eyes" = "itchy_eyes",
  "joint pain" = "joint_pain"
)


count_symptoms_showing_symptoms_add  <- count_symptoms_showing_symptoms_add  %>%
  dplyr::mutate(Symptoms = forcats::fct_recode(Symptoms, !!!symptom_levels))

sympt_count_plot_shwsympt <- ggplot2::ggplot(count_symptoms_showing_symptoms_add, ggplot2::aes(x = age_band, y = Count, group = Symptoms, fill = Symptoms)) +
  ggplot2::geom_area( color = "white") +
  ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
  ggplot2::scale_fill_viridis_d() +
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  ggplot2::labs(#title = "% of responders across countries",
    y = "Count", x = "Age band") +
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = ggplot2::element_text(size = 17, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 17),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    strip.background = element_blank(),
    strip.text = element_text(size = 10, face = "bold", hjust = 0), 
    legend.title = element_text(size = 16), 
    legend.text = element_text(size = 13)) +
  ggplot2::facet_wrap(~country, ncol = 1)

sympt_count_plot_shwsympt

count_comorbidities_shwsympt <- cleaned_data_22092020 %>%
  dplyr::select(id, Country, age_band,asthma, diabetes_type_one, diabetes_type_two,
                obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
  tidyr::pivot_longer(cols = 4:12,
                      names_to = "Comorbidities",
                      values_to = "bolean_yn_comorb") %>%
  dplyr::filter(bolean_yn_comorb == "Yes") %>%
  dplyr::group_by(Country, age_band, Comorbidities) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::rename(country = Country)


count_comorbidities_showing_symptoms_all_countries <- cleaned_data_22092020  %>%
  dplyr::select(id, Country, age_band, asthma, diabetes_type_one, diabetes_type_two,
                obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
  dplyr::filter(Country != "Brazil" ) %>%
  dplyr::filter(Country != "India") %>%
  dplyr::filter(Country != "Pakistan") %>%
  dplyr::filter(Country != "Mexico") %>%
  dplyr::filter(Country != "United Kingdom") %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  tidyr::pivot_longer(cols = 4:12,
                      names_to = "Comorbidities",
                      values_to = "bolean_yn_comorb") %>%
  dplyr::filter(bolean_yn_comorb == "Yes") %>%
  add_column(country = c("All countries")) %>%
  dplyr::group_by(country, age_band, Comorbidities) %>%
  dplyr::tally() %>%
  dplyr::rename(Count = n) %>%
  dplyr::mutate(Percent = Count/sum(Count) *100) %>%
  dplyr::select(country, Comorbidities, country, Count, Percent)

count_comorbidities_showing_symptoms_add <- full_join(count_comorbidities_showing_symptoms_all_countries, count_comorbidities_shwsympt)


comorbidities_levels <- c(
  "heart disease" = "heart_disease",
  "lung disease" = "lung_disease",
  "liver disease" = "liver_disease",
  "kidney disease" = "kidney_disease"
)

count_comorbidities_showing_symptoms_add  <- count_comorbidities_showing_symptoms_add  %>%
  dplyr::mutate(Comorbidities = forcats::fct_recode(Comorbidities, !!!comorbidities_levels))

# sympt_percent_plot <- ggplot(count_symptoms_shwsympt) +
#   geom_area(aes(x = age_band, y = Percent, group = Symptoms, fill = Symptoms),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_viridis_d() +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# sympt_percent_plot


comorb_count_plot_shwsympt <- ggplot(count_comorbidities_showing_symptoms_add) +
  geom_area(aes(age_band, Count, group = Comorbidities, fill = Comorbidities),
            color = "white") +
  scale_x_discrete(limits = c("0-19", "20-39", "40-59","60+"),
                   expand = c(0, 0)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  scale_fill_brewer(palette = "Reds") +
  ggplot2::labs(#title = "% of responders across countries",
    y = "Count", x = "Age band") +
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = ggplot2::element_text(size = 17, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 17),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    strip.background = element_blank(),
    strip.text = element_text(size = 10, face = "bold", hjust = 0), 
    legend.title = element_text(size = 16), 
    legend.text = element_text(size = 13)) +
  ggplot2::facet_wrap(~country, ncol = 1)

comorb_count_plot_shwsympt
# comorb_percent_plot <- ggplot(count_comorbidities_shwsympt) +
#   geom_area(aes(age_band, Percent, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Oranges") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_percent_plot


plot_sympt_comorb_showsympt <-  sympt_count_plot_shwsympt + theme(legend.position = "none") +
  comorb_count_plot_shwsympt + theme(legend.position = "none") + plot_legend


plot_sympt_comorb_showsympt

# plot_comorb <- comorb_count_plot + theme(legend.position = "none") +
#   comorb_percent_plot + theme(legend.position = "none")

plot_legend_shwsympt <- wrap_plots(
  cowplot::get_legend(sympt_count_plot_shwsympt),
  cowplot::get_legend(comorb_count_plot_shwsympt),
  ncol = 1)


# wrap_plots(sympt_count_plot_shwsympt,comorb_count_plot_shwsympt,
#            nrow = 1, widths = c(2, 2, 1))
