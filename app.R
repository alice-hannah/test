
library(shiny)
library(dplyr)
library(SPARQL)
library(stringr)
library(lubridate)
library(here)
library(DT)

query <- "
  SELECT  ?LastUpdated ?DownloadURL
  WHERE {
  <http://statistics.gov.scot/data/national-performance-framework>
  <http://purl.org/dc/terms/modified> ?LastUpdated ;
  <http://publishmydata.com/def/dataset#downloadURL> ?DownloadURL.
  }"

npfMetaData <-
  SPARQL("http://statistics.gov.scot/sparql", query)$results


# Read xlsx from URL ----

# f <-
#   "https://statistics.gov.scot/downloads/file?id=ca23e4da-4aa2-49e7-96e2-38f227f9d0de%2FALL+NPF+INDICATORS+-+2024+-+statistics.gov.scot+NPF+database+excel+file+-+August+2024.xlsx"
# 
# NPFdata <-
#   openxlsx::read.xlsx(f,
#                       detectDates = TRUE,
#                       na.strings=c("","NA")) %>%
#   filter(Characteristic == "Age" & Outcome == "Poverty")

# g <-
#   "https://www.opendata.nhs.scot/dataset/4ace86c2-2c0f-4620-b544-932148c2c4d3/resource/530cb70a-f747-4b3b-b75a-06353ae78e8d/download/icd10-lookup.xlsx"
# 
# x <-
#   openxlsx::read.xlsx(g)

# Read csv from URL ----

# x <- readr::read_csv(
#   "https://datahub.io/core/country-list/r/data.csv"
# )


# App ----

ui <- fluidPage(
  
  titlePanel("Equality test"),
  
  datatable(npfMetaData)
  
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
