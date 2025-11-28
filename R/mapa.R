# mod_mapa.R --------------------------------------------------------------

mapa_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # -------- CSS del módulo --------
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

        /* ---- Pills de Nivel territorial (Región / Provincia) ---- */
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
        .map-toggle-group input[type='radio'] {
          display: none;
        }
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
        .map-toggle-group input[type='radio']:checked + span {
          background: #f6c446;
          border-color: #f6c446;
          color: #172e52;
          font-weight: 600;
        }

        .map-caption {
          font-size: 0.84rem;
          color: #6b737a;
          margin-top: 6px;
        }

        /* ---- Cards generales ---- */
        .map-card {
          border-radius: 16px;
          background: #ffffff;
          padding: 16px 20px 18px 20px;
          box-shadow: 0 18px 40px rgba(15,23,42,0.12);
          border: 1px solid rgba(148,163,184,0.18);
        }
        .map-card + .map-card {
          margin-top: 16px;
        }
        .map-card-header {
          display: flex;
          align-items: flex-start;
          justify-content: space-between;
          gap: 12px;
          margin-bottom: 10px;
        }
        .map-card-title {
          display: flex;
          align-items: center;
          gap: 8px;
          font-size: 1rem;
          font-weight: 700;
          color: #0f172a;
          margin: 0;
        }
        .map-card-title i {
          font-size: 0.9rem;
          padding: 6px;
          border-radius: 999px;
          background: linear-gradient(135deg, #f6c446, #f97316);
          color: #111827;
        }
        .map-card-subtitle {
          margin: 2px 0 0 0;
          font-size: 0.82rem;
          color: #6b7280;
        }

        .map-card-collapse-btn {
          border: none;
          background: transparent;
          cursor: pointer;
          padding: 4px 6px;
          border-radius: 999px;
          color: #9ca3af;
          align-self: flex-start;
        }
        .map-card-collapse-btn:hover {
          background: rgba(148,163,184,0.16);
          color: #4b5563;
        }

        /* ---- Panel de filtros (Nivel + Indicador) ---- */
        .map-filter-card {
          border-radius: 16px;
          background: #ffffff;
          padding: 12px 18px 10px 18px;
          box-shadow: 0 12px 30px rgba(15,23,42,0.08);
          border: 1px solid rgba(148,163,184,0.2);
          display: flex;
          flex-wrap: wrap;
          align-items: flex-end;
          gap: 16px 24px;
          margin-bottom: 8px;
        }
        .map-filter-group {
          display: flex;
          flex-direction: column;
        }
        .map-indicator-group {
          flex: 1 1 420px;
          max-width: 600px;
        }

        /* ---- Panel del mapa ---- */
        .map-panel {
          position: relative;
          min-height: 480px;
          border-radius: 12px;
          overflow: hidden;
        }
        .map-panel .leaflet-container {
          background: #f8f9f7;
        }

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
          display: none;
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

        .map-table-title {
          font-size: 0.95rem;
          font-weight: 600;
          color: #111827;
          margin-bottom: 4px;
        }
        .map-table-caption {
          font-size: 0.82rem;
          color: #6b7280;
          margin-bottom: 10px;
        }
      "))
    ),
    
    # -------- Hero --------
    fluidRow(
      column(
        width = 12,
        div(
          class = "map-hero",
          h2("Mapa demográfico de la República Dominicana"),
          p("Visualiza la división territorial por Región o Provincia en un mapa estático, con la opción de mostrar o no el mapa de fondo.")
        )
      )
    ),
    
    # -------- Caja de filtros --------
    fluidRow(
      column(
        width = 12,
        div(
          class = "map-filter-card",
          div(
            class = "map-filter-group map-toggle-group",
            div(class = "map-switch-label", "NIVEL TERRITORIAL"),
            radioButtons(
              inputId = ns("nivel"),
              label   = NULL,
              choices = list("Región" = "region", "Provincia" = "provincia"),
              selected = "region",
              inline  = TRUE
            )
          ),
          div(
            class = "map-filter-group map-indicator-group",
            uiOutput(ns("indicador_ui"))
          )
        )
      )
    ),
    
    # -------- Mapa --------
    fluidRow(
      column(
        width = 12,
        div(
          class = "map-card",
          div(
            class = "map-card-header",
            div(
              h3(
                class = "map-card-title",
                icon("map"),
                span("Mapa estático por nivel territorial")
              ),
              p(
                class = "map-card-subtitle",
                "Usa los controles superiores para alternar el nivel territorial y el indicador."
              )
            )
          ),
          div(
            class = "map-panel",
            leaflet::leafletOutput(ns("mapa_estatico"), height = "520px"),
            div(
              class = "map-toggle-floating",
              tags$label(
                class = "map-pill-toggle",
                tags$input(
                  id    = ns("mostrar_base"),
                  type  = "checkbox",
                  checked = "checked"
                ),
                tags$span("Mapa de fondo")
              )
            )
          ),
          div(
            class = "map-caption",
            "El mapa es estático: sin zoom ni desplazamiento, ideal para resaltar gradientes y categorías por área."
          )
        )
      )
    ),
    
    br(),
    
    # -------- Tabla colapsable --------
    fluidRow(
      column(
        width = 12,
        div(
          class = "map-card",
          div(
            class = "map-card-header",
            div(
              h3(
                class = "map-card-title",
                icon("table"),
                span("Tabla de indicadores por territorio")
              ),
              p(
                class = "map-card-subtitle",
                "Explora los valores utilizados en el mapa, haz clic en un territorio para resaltarlo en el mapa y expórtalos si es necesario."
              )
            ),
            tags$button(
              type  = "button",
              class = "map-card-collapse-btn",
              `aria-label` = "Minimizar tabla",
              onclick = sprintf(
                "var el=document.getElementById('%s'); 
                 if(!el){return;} 
                 if(el.style.display==='none'){
                   el.style.display='block';
                   this.setAttribute('aria-label','Minimizar tabla');
                   var ic=this.querySelector('i'); if(ic){ic.className='fa fa-chevron-up';}
                 } else {
                   el.style.display='none';
                   this.setAttribute('aria-label','Expandir tabla');
                   var ic=this.querySelector('i'); if(ic){ic.className='fa fa-chevron-down';}
                 }",
                ns("tabela_body")
              ),
              icon("chevron-up")
            )
          ),
          div(
            id = ns("tabela_body"),
            class = "map-table-wrapper",
            div(class = "map-table-title", "Datos por territorio"),
            div(
              class = "map-table-caption",
              "Incluye las principales variables de envejecimiento para el nivel seleccionado. Haz clic en un territorio para resaltarlo en el mapa."
            ),
            DT::dataTableOutput(ns("tabela_mapa"))
          )
        )
      )
    )
  )
}

mapa_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    ns <- session$ns
    
    # -------- metadatos de indicadores --------
    indicadores_provincia <- c(
      "Clasificación demográfica (tipología)" = "classificacao",
      "Población 50+ (%)"                    = "pct_pop_50m",
      "Población 60+ (%)"                    = "pct_pop_60m",
      "Población 50–64 años (%)"             = "pct_pop_50_64",
      "Población 65–74 años (%)"             = "pct_pop_65_74",
      "Razón de dependencia (total)"         = "razao_dependencia_geral",
      "Razón de dependencia joven"           = "razao_dependencia_jovem",
      "Razón de dependencia senil"           = "razao_dependencia_senil"
    )
    
    indicador_tipo <- c(
      classificacao           = "categ",
      pct_pop_50m             = "pct",
      pct_pop_60m             = "pct",
      pct_pop_50_64           = "pct",
      pct_pop_65_74           = "pct",
      razao_dependencia_geral = "taxa",
      razao_dependencia_jovem = "taxa",
      razao_dependencia_senil = "taxa"
    )
    
    indicador_label <- function(cod) {
      nm <- names(indicadores_provincia)[indicadores_provincia == cod]
      if (length(nm) == 0) return(cod)
      nm[1]
    }
    
    # -------- shape reactivo --------
    get_shape <- reactive({
      req(input$nivel)
      shp <- if (input$nivel == "region") adm1 else adm2
      
      if (!inherits(shp, "sf")) {
        shp <- sf::st_as_sf(shp)
      }
      if (is.null(sf::st_geometry(shp))) {
        if ("geom" %in% names(shp)) {
          sf::st_geometry(shp) <- "geom"
        } else {
          geom_cols <- names(shp)[sapply(shp, function(x) inherits(x, "sfc"))]
          if (length(geom_cols) == 0) {
            stop("Objeto sf sin columna de geometría definida.")
          }
          sf::st_geometry(shp) <- geom_cols[1]
        }
      }
      shp
    })
    
    # -------- UI indicador --------
    output$indicador_ui <- renderUI({
      req(input$nivel)
      if (input$nivel != "provincia") return(NULL)
      
      shp <- get_shape()
      valid_cols <- indicadores_provincia[indicadores_provincia %in% names(shp)]
      if (length(valid_cols) == 0) return(NULL)
      
      selectInput(
        inputId  = ns("indicador"),
        label    = "Indicador (Provincia)",
        choices  = valid_cols,
        selected = if ("classificacao" %in% valid_cols) "classificacao" else valid_cols[1],
        width    = "100%"
      )
    })
    
    # -------- mapa estático --------
    output$mapa_estatico <- leaflet::renderLeaflet({
      shp <- get_shape()
      req(nrow(shp) > 0)
      
      nivel_atual <- input$nivel
      indicador   <- input$indicador
      
      provincia_mode <- (
        nivel_atual == "provincia" &&
          "provincia" %in% names(shp)
      )
      
      label <- NULL
      label_opts <- NULL
      popup <- NULL
      
      if (provincia_mode) {
        if ("adm1_es" %in% names(shp)) {
          shp$region_label <- tools::toTitleCase(tolower(shp$adm1_es))
        } else {
          shp$region_label <- NA_character_
        }
        
        extra <- rep("", nrow(shp))
        if (!is.null(indicador) && indicador %in% names(shp)) {
          tipo <- indicador_tipo[[indicador]]
          vals <- shp[[indicador]]
          if (is.numeric(vals)) {
            if (!is.null(tipo) && tipo == "pct") {
              vals_fmt <- sprintf("%.1f%%", vals)
            } else {
              vals_fmt <- sprintf("%.2f", vals)
            }
            extra <- sprintf(
              "<br/><strong>%s: </strong>%s",
              indicador_label(indicador),
              vals_fmt
            )
          }
        }
        
        label_txt <- sprintf(
          "<div style='font-size:13px;'>
             <strong>Provincia: </strong>%s<br/>
             <strong>Región: </strong>%s%s
           </div>",
          shp$provincia,
          shp$region_label,
          extra
        )
        
        label <- lapply(label_txt, htmltools::HTML)
        popup <- lapply(label_txt, htmltools::HTML)
        
        label_opts <- leaflet::labelOptions(
          style = list(
            "background-color" = "white",
            "padding"          = "6px 8px",
            "border-radius"    = "4px",
            "box-shadow"       = "0 0 6px rgba(0,0,0,0.25)",
            "border"           = "1px solid rgba(0,0,0,0.2)"
          ),
          textsize  = "13px",
          direction = "auto"
        )
      }
      
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
      
      mostrar_base <- is.null(input$mostrar_base) || isTRUE(input$mostrar_base)
      if (mostrar_base) {
        map <- map |>
          leaflet::addProviderTiles("CartoDB.Positron")
      }
      
      usar_classificacao <- (
        provincia_mode &&
          !is.null(indicador) &&
          indicador == "classificacao" &&
          "classificacao" %in% names(shp)
      )
      
      if (usar_classificacao) {
        pal <- leaflet::colorFactor(
          palette = c(
            "Aging Society" = "#f6c446",
            "Aged Society"  = "#752c91"
          ),
          domain = shp$classificacao
        )
        
        map <- map |>
          leaflet::addPolygons(
            color        = "#ffffff",
            weight       = 1.2,
            opacity      = 1,
            fillColor    = ~pal(classificacao),
            fillOpacity  = 0.8,
            smoothFactor = 0.2,
            label        = label,
            labelOptions = label_opts,
            popup        = popup,
            group        = "areas"
          ) |>
          leaflet::addLegend(
            position = "bottomright",
            pal      = pal,
            values   = ~classificacao,
            title    = "Clasificación demográfica",
            opacity  = 0.9
          )
        
      } else if (!is.null(indicador) && indicador %in% names(shp) &&
                 is.numeric(shp[[indicador]])) {
        
        vals <- shp[[indicador]]
        tipo <- indicador_tipo[[indicador]]
        
        if (!is.null(tipo) && tipo == "pct") {
          pal <- leaflet::colorNumeric(
            palette  = c("#eff6ff", "#bfdbfe", "#60a5fa", "#1d4ed8"),
            domain   = vals,
            na.color = "transparent"
          )
          lab_format <- leaflet::labelFormat(suffix = "%")
        } else {
          pal <- leaflet::colorNumeric(
            palette  = c("#f5f3ff", "#ddd6fe", "#a855f7", "#6d28d9"),
            domain   = vals,
            na.color = "transparent"
          )
          lab_format <- leaflet::labelFormat()
        }
        
        map <- map |>
          leaflet::addPolygons(
            color        = "#ffffff",
            weight       = 1.2,
            opacity      = 1,
            fillColor    = ~pal(vals),
            fillOpacity  = 0.8,
            smoothFactor = 0.2,
            label        = label,
            labelOptions = label_opts,
            popup        = popup,
            group        = "areas"
          ) |>
          leaflet::addLegend(
            position  = "bottomright",
            pal       = pal,
            values    = vals,
            title     = indicador_label(indicador),
            labFormat = lab_format,
            opacity   = 0.9
          )
        
      } else {
        map <- map |>
          leaflet::addPolygons(
            color        = "#ffffff",
            weight       = 1.2,
            opacity      = 1,
            fillColor    = "#172e52",
            fillOpacity  = 0.7,
            smoothFactor = 0.2,
            label        = label,
            labelOptions = label_opts,
            popup        = popup,
            group        = "areas"
          )
      }
      
      map
    })
    
    # -------- tabela --------
    output$tabela_mapa <- DT::renderDataTable({
      shp <- get_shape()
      req(nrow(shp) > 0)
      
      # força dependência do indicador para reordenar a tabela
      indicador_atual <- input$indicador
      
      id_cols <- intersect(c("region", "adm1_es", "provincia"), names(shp))
      ind_cols <- c(
        "classificacao",
        "pct_pop_50m", "pct_pop_60m", "pct_pop_50_64", "pct_pop_65_74",
        "razao_dependencia_geral", "razao_dependencia_jovem", "razao_dependencia_senil"
      )
      ind_cols <- intersect(ind_cols, names(shp))
      
      df <- shp |>
        sf::st_drop_geometry() |>
        dplyr::select(dplyr::all_of(c(id_cols, ind_cols)))
      
      # ---- ordena pela coluna do indicador (decrescente), se for numérica ----
      if (!is.null(indicador_atual) &&
          indicador_atual %in% names(df) &&
          is.numeric(df[[indicador_atual]])) {
        
        df <- df[order(df[[indicador_atual]], decreasing = TRUE), ]
      }
      
      dt <- DT::datatable(
        df,
        rownames   = FALSE,
        selection  = list(mode = "multiple", target = "row"),
        extensions = "Buttons",
        options    = list(
          dom        = "Bfrtip",
          buttons    = c("excel"),
          pageLength = 32,
          scrollX    = TRUE
        )
      )
      
      num_cols <- intersect(ind_cols, names(df)[sapply(df, is.numeric)])
      if (length(num_cols) > 0) {
        dt <- DT::formatRound(dt, columns = num_cols, digits = 2)
      }
      
      dt
    })
    
    # -------- ao trocar de indicador: limpar seleção da tabela e highlight --------
    observeEvent(input$indicador, {
      # limpar seleção da tabela
      dt_proxy <- DT::dataTableProxy("tabela_mapa", session = session)
      DT::selectRows(dt_proxy, NULL)
      
      # limpar destaque no mapa
      leaflet::leafletProxy("mapa_estatico", session = session) |>
        leaflet::clearGroup("highlight")
    })
    
    # -------- destacar múltiplos territórios ao clicar na tabela --------
    observeEvent(
      input$tabela_mapa_rows_selected,
      ignoreNULL = FALSE,   # reage quando vira NULL (sem seleção)
      {
        shp <- get_shape()
        req(nrow(shp) > 0)
        
        sel <- input$tabela_mapa_rows_selected
        
        # proxy do mapa dentro do módulo
        proxy_map <- leaflet::leafletProxy("mapa_estatico", session = session)
        
        # sempre limpar o grupo de destaque
        proxy_map <- proxy_map |>
          leaflet::clearGroup("highlight")
        
        # se não há nenhuma linha selecionada -> só limpa e sai
        if (is.null(sel) || length(sel) == 0) {
          return()
        }
        
        id_cols <- intersect(c("region", "adm1_es", "provincia"), names(shp))
        ind_cols <- c(
          "classificacao",
          "pct_pop_50m", "pct_pop_60m", "pct_pop_50_64", "pct_pop_65_74",
          "razao_dependencia_geral", "razao_dependencia_jovem", "razao_dependencia_senil"
        )
        ind_cols <- intersect(ind_cols, names(shp))
        
        df <- shp |>
          sf::st_drop_geometry() |>
          dplyr::select(dplyr::all_of(c(id_cols, ind_cols)))
        
        # mesma regra de ordenação da tabela
        indicador_atual <- input$indicador
        if (!is.null(indicador_atual) &&
            indicador_atual %in% names(df) &&
            is.numeric(df[[indicador_atual]])) {
          
          df <- df[order(df[[indicador_atual]], decreasing = TRUE), ]
        }
        
        # coluna de nome (prioridade: provincia > adm1_es > region)
        nome_col <- NULL
        if ("provincia" %in% names(df)) {
          nome_col <- "provincia"
        } else if ("adm1_es" %in% names(df)) {
          nome_col <- "adm1_es"
        } else if ("region" %in% names(df)) {
          nome_col <- "region"
        }
        req(nome_col)
        
        # nomes de TODOS os territórios selecionados na tabela
        nomes_sel <- df[[nome_col]][sel]
        nomes_sel <- unique(nomes_sel[!is.na(nomes_sel)])
        req(length(nomes_sel) > 0)
        
        # filtra todos os polígonos correspondentes
        shp_sel <- shp[shp[[nome_col]] %in% nomes_sel, ]
        req(nrow(shp_sel) > 0)
        
        # adiciona highlight para todos de uma vez
        proxy_map |>
          leaflet::addPolylines(
            data         = shp_sel,
            group        = "highlight",
            color        = "#1C1C1C",
            weight       = 1.8,
            opacity      = 1,
            smoothFactor = 0
          )
      }
    )
  })
}
