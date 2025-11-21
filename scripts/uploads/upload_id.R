source('conectar/conectar.R')
library(dplyr)

# Load ID data
id <- readxl::read_excel('scripts/uploads/dados_upload/id_republica_dominicana.xlsx')

# Save to database
dbWriteTable(con, 'id_republica_dominicana', id, overwrite = TRUE, row.names = FALSE)

# Save to Rdata file
save(id, file='dados/id_rd.Rdata')


# TEST
shp <- readRDS('dados/shp_adm2_2025_simpl.rds')

shp<- shp |> 
  left_join(id, by = c('adm2_pcode' = 'adm2_pcode'))
