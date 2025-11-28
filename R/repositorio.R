# ===================== MÓDULO: REPOSITORIO DE POWERPOINTS =====================

repositorio_ui <- function(id) {
  ns <- NS(id)
  
  # Metadatos de los archivos
  arquivos <- data.frame(
    id        = c("caso_negocio", "envejecer_genero", "impacto_economia"),
    nome      = c(
      "Caso de negocio",
      "Envejecer es una cuestión de género",
      "Impactos del envejecimiento en la economía"
    ),
    descricao = c(
      "Presentación sobre el caso de negocio del envejecimiento poblacional.",
      "Análisis de cómo envejecer es también una cuestión de género.",
      "Impactos del envejecimiento en la economía y en los mercados."
    ),
    stringsAsFactors = FALSE
  )
  
  # Monta cards de forma programática
  card_list <- lapply(seq_len(nrow(arquivos)), function(i) {
    column(
      width = 4,
      div(
        class = "ppt-card",
        div(
          class = "ppt-card-header",
          div(class = "ppt-icon", icon("file-powerpoint")),
          div(
            tags$h3(class = "ppt-title", paste("Presentación -", arquivos$nome[i])),
            tags$p(class = "ppt-subtitle", arquivos$descricao[i])
          )
        ),
        div(
          class = "ppt-card-body",
          tags$p(
            class = "ppt-meta",
            ".pptx · haz clic en \"Descargar PPTX\" para guardar el archivo y abrirlo en PowerPoint."
          )
        ),
        div(
          class = "ppt-card-footer",
          downloadButton(
            ns(paste0("download_", arquivos$id[i])),
            label = "Descargar PPTX",
            class = "btn-ppt-download"
          )
        )
      )
    )
  })
  
  tagList(
    # ------- CSS do módulo -------
    tags$head(
      tags$style(HTML("
        .ppt-hero {
          background: linear-gradient(120deg, #172e52 0%, #0a1b32 60%, #752c91 100%);
          color: #fff;
          padding: 22px 26px;
          border-radius: 16px;
          box-shadow: 0 12px 30px rgba(0,0,0,.18);
          margin-bottom: 20px;
        }
        .ppt-hero h2 {
          margin: 0 0 6px 0;
          font-weight: 800;
          letter-spacing: .03em;
        }
        .ppt-hero p {
          margin: 0;
          opacity: .95;
        }

        .ppt-card {
          background: #ffffff;
          border-radius: 16px;
          box-shadow: 0 10px 26px rgba(0,0,0,0.06);
          padding: 16px 16px 14px;
          margin-bottom: 18px;
          display: flex;
          flex-direction: column;
          height: 100%;
          border: 1px solid rgba(23,46,82,0.06);
        }
        .ppt-card-header {
          display: flex;
          align-items: center;
          margin-bottom: 10px;
        }
        .ppt-icon {
          width: 40px; height: 40px;
          border-radius: 12px;
          background: rgba(246,196,70,0.18);
          display: flex;
          align-items: center;
          justify-content: center;
          margin-right: 10px;
          color: #752c91;
        }
        .ppt-title {
          font-size: 1.02rem;
          margin: 0;
          font-weight: 700;
        }
        .ppt-subtitle {
          font-size: 0.86rem;
          margin: 2px 0 0 0;
          color: #6b737a;
        }
        .ppt-meta {
          font-size: 0.85rem;
          color: #757b80;
          margin-bottom: 0;
        }
        .ppt-card-footer {
          margin-top: 12px;
          display: flex;
          justify-content: flex-end;
        }
        .btn-ppt-download {
          background-color: #f6c446 !important;
          border-color: #f6c446 !important;
          color: #172e52 !important;
          font-weight: 600;
          border-radius: 999px;
          padding: 6px 14px;
        }
        .btn-ppt-download:hover {
          background-color: #f2b823 !important;
          border-color: #f2b823 !important;
          color: #172e52 !important;
        }
      "))
    ),
    
    # ------- Hero / Cabeçalho -------
    fluidRow(
      column(
        width = 12,
        div(
          class = "ppt-hero",
          h2("Repositorio de presentaciones"),
          p("Aquí encontrarás las presentaciones en PowerPoint. Haz clic en \"Descargar PPTX\" para abrir la presentación en tu computadora.")
        )
      )
    ),
    
    # ------- Cards com os PPTs -------
    do.call(fluidRow, card_list)
  )
}

repositorio_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    arquivos <- data.frame(
      id      = c("caso_negocio", "envejecer_genero", "impacto_economia"),
      arquivo = c(
        "caso_negocio.pptx",
        "envejecer_genero.pptx",
        "impacto_envejecimento_economia.pptx"
      ),
      stringsAsFactors = FALSE
    )
    
    # Cria um downloadHandler para cada arquivo
    for (i in seq_len(nrow(arquivos))) {
      local({
        id_local      <- arquivos$id[i]
        arquivo_local <- arquivos$arquivo[i]
        
        output[[paste0("download_", id_local)]] <- downloadHandler(
          filename = function() arquivo_local,
          content = function(file) {
            file.copy(
              from = file.path("powerpoints", arquivo_local),
              to   = file,
              overwrite = TRUE
            )
          }
        )
      })
    }
  })
}
