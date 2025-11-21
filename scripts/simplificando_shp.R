library(sf)
library(rmapshaper)
source('conectar/conectar.R')

# 1. Carregar base do Postgres
adm2 <- st_read(con, query = "SELECT adm2_pcode, adm2_es, adm1_pcode, adm1_es, area_sqkm, geom FROM dom_adm2_2025")

# 2. (Opcional, mas recomendado) garantir que está em WGS84 para web/leaflet
adm2_wgs84 <- st_transform(adm2, 4326)

# 3. Simplificar a geometria para ficar mais leve
#    Ajuste o 'keep' conforme o equilíbrio entre detalhe e leveza
adm2_simpl <- ms_simplify(
  adm2_wgs84,
  keep        = 0.05,   # 5% dos vértices (aumente/diminua conforme o teste)
  keep_shapes = TRUE    # mantém polígonos pequenos
)

# 4. Salvar como RDS preservando atributos + geometria já simplificada
saveRDS(adm2_simpl, "dados/shp_adm2_2025_simpl.rds")


### ADM 1

# 1. Carregar base do Postgres
adm1 <- st_read(con, query = "SELECT adm1_pcode, adm1_es, area_sqkm, geom FROM dom_adm1_2025")

# 2. (Opcional, mas recomendado) garantir que está em WGS84 para web/leaflet
adm1_wgs84 <- st_transform(adm1, 4326)

# 3. Simplificar a geometria para ficar mais leve
#    Ajuste o 'keep' conforme o equilíbrio entre detalhe e leveza
adm1_simpl <- ms_simplify(
  adm1_wgs84,
  keep        = 0.05,   # 5% dos vértices (aumente/diminua conforme o teste)
  keep_shapes = TRUE    # mantém polígonos pequenos
)

# 4. Salvar como RDS preservando atributos + geometria já simplificada
saveRDS(adm1_simpl, "dados/shp_adm1_2025_simpl.rds")
