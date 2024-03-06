# Ensure required packages are installed and loaded
required_packages <- c("devtools", "lares", "ggplot2")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)
lapply(required_packages, library, character.only = TRUE)

# Only install the latest version of 'lares' from GitHub if it's not already installed
if (!"lares" %in% installed.packages()[,"Package"]) {
  devtools::install_github("laresbernardo/lares")
}

# Current date
today <- Sys.Date()

# Curriculum vitae data
cv_data <- data.frame(
  Role = c("M Educational Sciences: Learning in Interaction (research)",
           "Pre-master Educational Sciences",
           "Teacher Education in Chemistry",
           "Teacher education in Chemics",
           "Internship: Study development & data collection",
           "Awareness Project",
           "Eye-tracking Network NL-BE",
           "Watch Me Project"),
  Place = c("UU", "UU", "FLOT", "BLC", "UU", "UU", NA, NA),
  Type = c("Academic", "Academic", "Academic", "Work Experience", "Work Experience", "Extra", "Extra", "Extra"),
  Start = as.Date(c("2022-09-01", "2021-09-01", "2015-09-01", "2019-09-01", "2023-08-31", "2023-05-01", "2019-12-01", "2022-11-01")),
  End = as.Date(c(today, "2022-08-31", "2020-08-31", "2021-07-01", "2024-01-31", today, today, "2023-07-01"))
)

# Function to plot curriculum vitae timeline
plot_timeline2 <- function(cv, title = "Curriculum Vitae Timeline", subtitle = "Your Name Here", size = 7, colour = "orange", save = FALSE, subdir = NULL) {
  require(lubridate)
  require(ggplot2)
  
  # Transform cv data for plotting
  cv_long <- tidyr::pivot_longer(cv, cols = c(Start, End), names_to = "Phase", values_to = "Date") %>%
    mutate(Phase = ifelse(Phase == "Start", 1, 2),
           Role = factor(Role, levels = unique(cv$Role))) %>%
    arrange(Role, Phase)
  
  # Plot
  p <- ggplot(cv_long, aes(x = Date, y = Role, group = Role)) +
    geom_line(aes(color = Type), size = size) +
    geom_point(size = size / 2) +
    scale_color_manual(values = c(Academic = "#4E79A7", "Work Experience
