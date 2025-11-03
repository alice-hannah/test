
library(shiny)
library(dplyr)
library(SPARQL)
library(stringr)
library(lubridate)
library(here)
library(DT)

# SPARQL ----

# query <- "
#   PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#   SELECT  ?LastUpdated ?DownloadURL
#   WHERE {
#   <http://statistics.gov.scot/data/national-performance-framework>
#   <http://purl.org/dc/terms/modified> ?LastUpdated ;
#   <http://publishmydata.com/def/dataset#downloadURL> ?DownloadURL.
#   }"
# 
# npfMetaData <- 
#   tryCatch(
#     SPARQL("http://statistics.gov.scot/sparql", query)$results,
#     error = function(e) data.frame(x = 1:2, y = 3:4)
#   )


# Read xlsx from URL ----

f <-
  "http://statistics.gov.scot/downloads/file?id=ca23e4da-4aa2-49e7-96e2-38f227f9d0de%2FALL+NPF+INDICATORS+-+2024+-+statistics.gov.scot+NPF+database+excel+file+-+August+2024.xlsx"

NPFdata <-
  openxlsx::read.xlsx(URLdecode(f),
                      detectDates = TRUE,
                      na.strings=c("","NA")) %>%
  filter(Characteristic == "Age" & Outcome == "Poverty")


# Read csv from URL ----

# x <- readr::read_csv(
#   "https://datahub.io/core/country-list/r/data.csv"
# )


# App ----

ui <- fluidPage(
  
  titlePanel("Equality test"),
  
  datatable(NPFdata)
  
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
