options(bitmapType = "cairo")
library(DBI)
library(RPostgres)
library(tidyverse)
library(shiny)
library(bs4Dash)
library(ciTools)
library(vitaltable)
library(leaflet)
library(dplyr)
library(shinythemes)
library(janitor)
library(plotly)
library(reshape2)
library(forcats)
library(tidyr)
library(DT)
library(haven)
library(writexl)
library(fresh)
library(leaflet.extras)
library(shinymanager)
library(shinyWidgets)
library(colourpicker)
library(shinyjs)
library(bslib)
library(fontawesome)
library(tibble)
library(fresh)


# ids
load('dados/id_rd.Rdata')

# layer 1
adm1 <- readRDS("dados/shp_adm1_2025_simpl.rds")

# layer 2
adm2 <- readRDS("dados/shp_adm2_2025_simpl.rds")

