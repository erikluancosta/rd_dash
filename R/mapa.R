# mod_mapa.R

mapa_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # -------- CSS do módulo --------
    tags$head(
      tags$style(HTML("
        .map-hero {
          background: linear-gradient(120deg, #172e52 0%, #0a1b32 50%, #752c91 100%);
          color: #fff;
          padding: 20px 24px;
          border-radius: 16px;
          box-shadow: 0 10px 26px rgba(0,0,0,0.15);
          margin-bottom: 18px;
        }
        .map-hero h2 {
          margin: 0 0 4px 0;
          font-weight: 800;
          letter-spacing: .03em;
        }
        .map-hero p {
          margin: 0;
          opacity: .95;
        }

        .map-switch-label {
          font-size: 0.82rem;
          text-transform: uppercase;
          letter-spacing: .12em;
          color: #7b8690;
          margin-bottom: 4px;
        }

        /* ---- Pills de Nível territorial (Region / Provincia) ---- */
        .map-toggle-group .shiny-options-group {
          display: inline-flex;
          gap: 8px;
        }
        .map-toggle-group .radio {
          margin: 0 !important;
        }
        .map-toggle-group label {
          margin-bottom: 0;
          cursor: pointer;
        }
        /* esconde o radio padrão */
        .map-toggle-group input[type='radio'] {
          display: none;
        }
        /* aparência base do pill (igual ao Mapa de fundo) */
        .map-toggle-group label span {
          display: inline-block;
          border-radius: 999px;
          padding: 5px 14px;
          border: 1px solid #d0d5dd;
          background: #ffffff;
          font-size: 0.88rem;
          color: #4a4f57;
          box-shadow: 0 4px 10px rgba(0,0,0,0.12);
        }
        .map-toggle-group label:hover span {
          border-color: #f6c446;
        }
        /* estado ativo: pill inteiro amarelo */
        .map-toggle-group input[type='radio']:checked + span {
          background: #f6c446;
          border-color: #f6c446;
          color: #172e52;
          font-weight: 600;
        }

        .map-box {
          border-radius: 18px !important;
          overflow: hidden;
          box-shadow: 0 10px 26px rgba(0,0,0,0.12);
          border: 1px solid rgba(23,46,82,0.06);
        }
        .map-box .card-header {
          border-bottom: 1px solid rgba(0,0,0,0.04);
        }

        .map-caption {
          font-size: 0.84rem;
          color: #6b737a;
          margin-top: 6px;
        }

        /* fundo neutro visível quando não há tiles */
        .map-box .leaflet-container {
          background: #f8f9f7;
        }

        /* controle flutuante dentro do mapa (top-right) tipo pill */
        .map-toggle-floating {
          position: absolute;
          top: 12px;
          right: 16px;
          z-index: 500;
        }

        .map-pill-toggle {
          cursor: pointer;
          display: inline-flex;
          align-items: center;
        }

        .map-pill-toggle input[type='checkbox'] {
          display: none; /* some o check padrão */
        }

        .map-pill-toggle span {
          border-radius: 999px;
          padding: 5px 14px;
          border: 1px solid #d0d5dd;
          background: #ffffff;
          font-size: 0.8rem;
          color: #4a4f57;
          box-shadow: 0 4px 10px rgba(0,0,0,0.12);
        }

        .map-pill-toggle input[type='checkbox']:checked + span {
          background: #f6c446;
          border-color: #f6c446;
          color: #172e52;
          font-weight: 600;
        }
      "))
    ),
    
    # -------- Hero --------
    fluidRow(
      column(
        width = 12,
        div(
          class = "map-hero",
          h2("Mapa demográfico da República Dominicana"),
          p("Visualize a divisão territorial por Region ou Provincia em um mapa estático, com opção de exibir ou não o mapa de fundo.")
        )
      )
    ),
    
    # -------- Linha com toggle e descrição --------
    fluidRow(
      column(
        width = 6,
        div(
          class = "map-toggle-group",
          div(class = "map-switch-label", "Nível territorial"),
          radioButtons(
            inputId = ns("nivel"),
            label   = NULL,
            choices = list("Region" = "region", "Provincia" = "provincia"),
            selected = "region",
            inline  = TRUE
          )
        ),
        div(
          class = "map-caption",
          "O mapa é estático: sem zoom ou arraste, ideal para destacar gradientes e categorias por área."
        )
      ),
      column(
        width = 6,
        div(
          class = "map-caption",
          style = "text-align:right; margin-top: 22px;",
          "Em breve: gradientes e indicadores por ",
          tags$strong("Region"), " e ", tags$strong("Provincia"), "."
        )
      )
    ),
    
    br(),
    
    # -------- Mapa + controle flutuante --------
    fluidRow(
      column(
        width = 12,
        box(
          width = 12,
          status = "info",
          solidHeader = FALSE,
          title = tagList(icon("map"), " Mapa estático por nível territorial"),
          class = "map-box",
          div(
            style = "position:relative;",
            leaflet::leafletOutput(ns("mapa_estatico"), height = "520px"),
            # controle flutuante dentro do mapa, estilo pill
            div(
              class = "map-toggle-floating",
              tags$label(
                class = "map-pill-toggle",
                tags$input(
                  id    = ns("mostrar_base"),
                  type  = "checkbox",
                  checked = "checked"
                ),
                tags$span("Mapa de fundo")
              )
            )
          )
        )
      )
    )
  )
}

mapa_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # shape reativo
    get_shape <- reactive({
      req(input$nivel)
      
      # adm1 = Region, adm2 = Provincia (carregados no global.R)
      shp <- if (input$nivel == "region") adm1 else adm2
      
      # garante que é sf
      if (!inherits(shp, "sf")) {
        shp <- sf::st_as_sf(shp)
      }
      
      # garante que tem geometria setada
      if (is.null(sf::st_geometry(shp))) {
        # tenta usar 'geom' se existir
        if ("geom" %in% names(shp)) {
          sf::st_geometry(shp) <- "geom"
        } else {
          # tenta achar uma coluna sfc
          geom_cols <- names(shp)[sapply(shp, function(x) inherits(x, "sfc"))]
          if (length(geom_cols) == 0) {
            stop("Objeto sf sem coluna de geometria definida.")
          }
          sf::st_geometry(shp) <- geom_cols[1]
        }
      }
      
      # CRS já está em 4326 (WGS84), então não transformo aqui
      shp
    })
    
    output$mapa_estatico <- leaflet::renderLeaflet({
      shp <- get_shape()
      req(nrow(shp) > 0)
      
      # base do mapa, estático
      map <- leaflet::leaflet(
        data = shp,
        options = leaflet::leafletOptions(
          zoomControl      = FALSE,
          dragging         = FALSE,
          scrollWheelZoom  = FALSE,
          doubleClickZoom  = FALSE,
          boxZoom          = FALSE,
          keyboard         = FALSE
        )
      )
      
      # adiciona tiles de fundo só se o pill estiver ativo
      if (isTRUE(input$mostrar_base)) {
        map <- map |>
          leaflet::addProviderTiles("CartoDB.Positron")
      }
      
      # adiciona os polígonos
      map |>
        leaflet::addPolygons(
          color       = "#ffffff",
          weight      = 1.2,
          opacity     = 1,
          fillColor   = "#172e52",
          fillOpacity = 0.7,
          smoothFactor = 0.2
        )
    })
  })
}
