# Install package if it's not already installed
if (!requireNamespace(c("devtools", "lares", "ggplot"), quietly = TRUE))
  install.packages(c("devtools", "lares", "ggplot"))

# All packages used below must be installed first
library(devtools)
# devtools::install_github("laresbernardo/lares")
library(lares)
library(ggplot2)


today <- as.character(Sys.Date())


### Edit from here ###
cv <- data.frame(rbind(
  c("M Educational Sciences: Learning in Interaction (research)", "UU", "Academic", "2022-09-01", today),
  c("Pre-master Educational Sciences", "UU", "Academic", "2021-09-01", "2022-08-31"),
  c("Teacher Education in Chemics", "FLOT", "Academic", "2016-09-01", "2021-08-31"),
  c("Chemics Teacher", "BLC", "Work Experience", "2018-08-10", "2019-09-01"),
  c("Chemics Teacher", "BLC", "Work Experience", "2019-09-01", "2021-07-01"),
  c("Chemics Teacher", "Intership", "Work Experience", "2015-11-19", "2016-04-21"), # van Maerlantlyceoum 
  c("Chemics Teacher", "Intership", "Work Experience", "2017-08-28", "2018-04-23"), # Stella Maris College
  c("Internship: Study development & data collection", "UU", "Work Experience", "2023-08-31", "2024-01-31"),
  c("Awareness Project", "UU", "Extra", "2023-05-01", today),
  c("Eye-tracking Network NL-BE", NA, "Extra", "2019-01-01", today),
  c("SIG Group", NA, "Extra", "2019-12-01", today)
))
### Edit until here ###


order <- c("Role", "Place", "Type", "Start", "End")
colnames(cv) <- order


plot_timeline2 <- function(event, start, end = start + 1, label = NA, group = NA,
                           title = "Curriculum Vitae Timeline", subtitle = "Antoine Soetewey",
                           size = 7, colour = "orange", save = FALSE, subdir = NA) {
  df <- data.frame(
    Role = as.character(event), Place = as.character(label),
    Start = lubridate::date(start), End = lubridate::date(end),
    Type = group
  )
  cvlong <- data.frame(pos = rep(
    as.numeric(rownames(df)),
    2
  ), name = rep(as.character(df$Role), 2), type = rep(factor(df$Type,
                                                             ordered = TRUE
  ), 2), where = rep(
    as.character(df$Place),
    2
  ), value = c(df$Start, df$End), label_pos = rep(df$Start +
                                                    floor((df$End - df$Start) / 2), 2))
  maxdate <- max(df$End)
  p <- ggplot(cvlong, aes(
    x = value, y = reorder(name, -pos),
    label = where, group = pos
  )) +
    geom_vline(
      xintercept = maxdate,
      alpha = 0.8, linetype = "dotted"
    ) +
    labs(
      title = title,
      subtitle = subtitle, x = NULL, y = NULL, colour = NULL
    ) +
    theme_minimal() +
    theme(panel.background = element_rect(
      fill = "white",
      colour = NA
    ), axis.ticks = element_blank(), panel.grid.major.x = element_line(
      linewidth = 0.25,
      colour = "grey80"
    ))
  if (!is.na(cvlong$type)[1] | length(unique(cvlong$type)) >
      1) {
    p <- p + geom_line(aes(color = type), linewidth = size) +
      facet_grid(type ~ ., scales = "free", space = "free") +
      guides(colour = "none") +
      scale_colour_manual(values = c("#BCCACB", "#00BA38", "#4A6F73")) +
      theme(strip.text.y = element_text(size = 10))
  } else {
    p <- p + geom_line(linewidth = size)
  }
  p <- p + geom_label(aes(x = label_pos),
                      colour = "black",
                      size = 2, alpha = 0.7
  )
  if (save) {
    file_name <- "cv_timeline.png"
    if (!is.na(subdir)) {
      dir.create(file.path(getwd(), subdir), recursive = T)
      file_name <- paste(subdir, file_name, sep = "/")
    }
    p <- p + ggsave(file_name, width = 8, height = 6)
    message(paste("Saved plot as", file_name))
  }
  return(p)
}




plot_timeline2(
  event = cv$Role,
  start = cv$Start,
  end = cv$End,
  label = cv$Place,
  group = cv$Type,
  save = FALSE,
  subtitle = " Rens van Haaren") # replace with your name
