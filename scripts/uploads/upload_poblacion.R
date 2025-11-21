source('conectar/conectar.R')
library(dplyr)
library(vitaltable)

# Load ID data
pob10 <- readxl::read_excel('scripts/uploads/dados_upload/poblacion.xlsx', sheet = '2010')

pob22 <- readxl::read_excel('scripts/uploads/dados_upload/poblacion.xlsx', sheet = '2022')

pob <- bind_rows(pob10, pob22)

# Save to database
dbWriteTable(con, 'pob_dom', pob, overwrite = TRUE, row.names = FALSE)
