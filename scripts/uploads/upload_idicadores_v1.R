source('conectar/conectar.R')
library(dplyr)
library(vitaltable)

# Carregando os dados
indicadores <- readxl::read_excel('scripts/uploads/dados_upload/indicadores_v1.xlsx')


dbWriteTable(con, 'rd_indicadores_v1', indicadores, overwrite = TRUE, row.names = FALSE)

save(indicadores, file='dados/rd_indicadores_v1.Rdata')
