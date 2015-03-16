file_address <- paste0("https://d396qusza40orc.cloudfront.net/",
                       "dsscapstone/dataset/Coursera-SwiftKey.zip")
dest_file <- file.path("data", basename(file_address))

# Download the file if it doesn't exist locally
if (!file.exists(dest_file)) {
    download.file(file_address, dest_file, method = "curl")
}

# Unzip the file
unzip(dest_file, exdir = "data", overwrite = FALSE)

