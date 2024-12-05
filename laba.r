# Завантаження бібліотек
library(dplyr)
library(lubridate)

# Читання датасетів
arrest_data <- read.csv("Arrest_Data_from_2020_to_2024.csv")
crime_data <- read.csv("Crime_Data_from_2020_to_2024.csv")
calls_data <- read.csv("LAPD_Calls_for_Service_2020.csv")

glimpse(arrest_data)
glimpse(crime_data)
glimpse(calls_data)

# Перетворення дат і фільтрація за 2020 рік
arrest_data <- arrest_data %>%
  mutate(Arrest.Date = mdy_hms(Arrest.Date)) %>%
  filter(year(Arrest.Date) == 2020)

crime_data <- crime_data %>%
  mutate(DATE.OCC = mdy_hms(DATE.OCC)) %>%
  filter(year(DATE.OCC) == 2020)

calls_data <- calls_data %>%
  mutate(Dispatch_Date = mdy_hms(Dispatch_Date)) %>%
  filter(year(Dispatch_Date) == 2020)

# Додавання джерела даних
arrest_data <- arrest_data %>% mutate(Source = "Arrest")
crime_data <- crime_data %>% mutate(Source = "Crime")
calls_data <- calls_data %>% mutate(Source = "Calls")

# Об'єднання всіх даних
combined_data <- bind_rows(arrest_data, crime_data, calls_data)

# Збереження об'єднаного датасету
write.csv(combined_data, "Combined_Data_2020.csv", row.names = FALSE)

# Перевірка результату
cat("Кількість записів за 2020 рік:", nrow(combined_data), "\n")