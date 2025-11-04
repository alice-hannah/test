
library(shiny)
library(dplyr)
library(SPARQL)
library(stringr)
library(lubridate)
library(here)
library(DT)

# query <- "
#   SELECT  ?LastUpdated ?DownloadURL
#   WHERE {
#   <http://statistics.gov.scot/data/national-performance-framework>
#   <http://purl.org/dc/terms/modified> ?LastUpdated ;
#   <http://publishmydata.com/def/dataset#downloadURL> ?DownloadURL.
#   }"
# 
# npfMetaData <-
#   SPARQL("http://statistics.gov.scot/sparql", query)$results



# Read data from URL ----

url <- c(
  sg_xlsx = "https://statistics.gov.scot/downloads/file?id=ca23e4da-4aa2-49e7-96e2-38f227f9d0de%2FALL+NPF+INDICATORS+-+2024+-+statistics.gov.scot+NPF+database+excel+file+-+August+2024.xlsx",
  phs_xlsx = "https://www.opendata.nhs.scot/dataset/4ace86c2-2c0f-4620-b544-932148c2c4d3/resource/530cb70a-f747-4b3b-b75a-06353ae78e8d/download/icd10-lookup.xlsx",
  phs_csv = "https://www.opendata.nhs.scot/dataset/cbd1802e-0e04-4282-88eb-d7bdcfb120f0/resource/c698f450-eeed-41a0-88f7-c1e40a568acc/download/hospitals.csv"
)

x1 <- tryCatch(
  openxlsx::read.xlsx(url["sg_xlsx"]) %>%
  filter(Characteristic == "Age" & Outcome == "Poverty"),
  error = function(e) data.frame(x = 1)
)

x2 <- tryCatch(
  openxlsx::read.xlsx(url["phs_xlsx"]),
  error = function(e) data.frame(x = 1)
)

x3 <- tryCatch(
  readr::read_csv(url["phs_csv"]),
  error = function(e) data.frame(x = 1)
)


# App ----

ui <- fluidPage(
  
  titlePanel("Equality test"),
  
  h2("SG xlsx"),
  datatable(x1),
  h2("PHS xlsx"),
  datatable(x2),
  h2("PHS csv"),
  datatable(x3)
  
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
