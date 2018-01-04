library(readr)
library(dplyr)
library(stringr)

en_us_dir <- "data/final/en_US/"

# Specify file paths for English datasets
en_us_blogs_file <- file.path(en_us_dir, "en_US.blogs.txt")
en_us_news_file <- file.path(en_us_dir, "en_US.news.txt")
en_us_twitter_file <- file.path(en_us_dir, "en_US.twitter.txt")

# Get information about file sizes
system(sprintf("ls -lh %s", en_us_dir))

# Function to count number of lines in a file using system calls of wc and awk
count_lines <- function(file) {
    sys_cmd <- sprintf("wc -l %s | awk '{print $1}'", file)
    wc_str <- system(sys_cmd, intern = TRUE)
    num_lines <- as.numeric(wc_str)
    return(num_lines)
}

# Count the number of lines in each file
en_us_blogs_lines <- count_lines(en_us_blogs_file)
en_us_news_lines <- count_lines(en_us_news_file)
en_us_twitter_lines <- count_lines(en_us_twitter_file)

# Preview the first few lines of each file
read_lines(en_us_blogs_file, n_max = 10)
read_lines(en_us_news_file, n_max = 10)
read_lines(en_us_twitter_file, n_max = 10)

sample <- read_lines(en_us_blogs_file, n_max = 10)
str_length(sample)

# Function to find line lengths in a file using system calls of awk
find_line_lengths <- function(file) {
    sys_cmd <- sprintf("awk '{print length($0)}' %s", file)
    len_str <- system(sys_cmd, intern = TRUE)
    line_lengths <- as.numeric(len_str)
    return(line_lengths)
}

# Find the longest line in each file
system.time(en_us_blogs_lengths <- find_line_lengths(en_us_blogs_file))
system.time(en_us_news_lengths <- find_line_lengths(en_us_news_file))
system.time(en_us_twitter_lengths <- find_line_lengths(en_us_twitter_file))
max(en_us_blogs_lengths)
max(en_us_news_lengths)
max(en_us_twitter_lengths)

# Read in the twitter file
en_us_twitter <- read_lines(en_us_twitter_file)

# Count number of lines with the words love or hate
num_love <- sum(str_detect(en_us_twitter, "love"), na.rm = TRUE)
num_hate <- sum(str_detect(en_us_twitter, "hate"), na.rm = TRUE)
num_love / num_hate

is_biostats <- str_detect(en_us_twitter, "biostats")
en_us_twitter[is_biostats]

sentence <- paste0("A computer once beat me at chess, but it was no match ",
                   "for me at kickboxing")
is_sentence <- str_detect(en_us_twitter, sentence)
sum(is_sentence, na.rm = TRUE)
en_us_twitter[is_sentence]
