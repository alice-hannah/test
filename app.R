
library(shiny)
library(dplyr)
library(SPARQL)
library(stringr)
library(lubridate)
library(here)
library(DT)

x <- opendatascot::ods_all_datasets()

y <- opendatascot::ods_dataset("age-at-first-birth", 
                               refPeriod = "2016/17-2018/19",
                               age = "all") %>%
  slice_head(n = 500)

# source(here("set_variables.R"))
# source(here("data_processing.R"))
# source(here("readNPFdata.R"))

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


# url <- 
#   "http://statistics.gov.scot/downloads/file?id=ca23e4da-4aa2-49e7-96e2-38f227f9d0de%2FALL+NPF+INDICATORS+-+2024+-+statistics.gov.scot+NPF+database+excel+file+-+August+2024.xlsx"
# 
# NPFdata <-
#   openxlsx::read.xlsx(url, 
#                       detectDates = TRUE, 
#                       na.strings=c("","NA")) %>%
#   filter(Characteristic == "Age" & Outcome == "Poverty")


# App ----

ui <- fluidPage(
  
  titlePanel("Equality test"),
  
  sidebarLayout(
    sidebarPanel = NULL,
    mainPanel = mainPanel(
      datatable(y)
    )
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # output$table <- renderDT({
  # 
  # })
}

shinyApp(ui = ui, server = server)
