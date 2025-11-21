# ===================== MÓDULO: DEMOGRAFIAS =====================

demografias_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # ------- Estilos do módulo (duas colunas, hero, callouts, etc.)
    tags$head(
      tags$style(HTML("
        .hero-demog {
          background: linear-gradient(135deg, #1b3556 0%, #0e2744 100%);
          color: #fff; padding: 18px 22px; border-radius: 16px;
          box-shadow: 0 12px 30px rgba(0,0,0,.10); margin-bottom: 14px;
        }
        .hero-demog h2 { margin: 0 0 6px 0; font-weight: 800; letter-spacing: .2px; }
        .hero-demog .subtitle { opacity: .85; margin: 0; }

        /* Texto em duas colunas (desktop), 1 coluna (mobile) */
        .two-col { column-count: 2; column-gap: 2rem; column-rule: 1px solid rgba(0,0,0,.06); }
        @media (max-width: 992px) { .two-col { column-count: 1; column-rule: none; } }

        /* Tipografia mais legível */
        .prose p { font-size: 1.05rem; line-height: 1.6; margin-bottom: .9rem; }
        .prose h4 { margin-top: .2rem; font-weight: 700; }

        /* Nota / conclusão destacada */
        .note {
          background: #F8F9F7; border-left: 4px solid #752c91; padding: 12px 14px;
          border-radius: 8px; margin-top: 10px;
        }

        /* Lista com check verde */
        .checklist { list-style: none; padding-left: 0; margin-bottom: 0; }
        .checklist li { margin: .45rem 0; padding-left: 1.25rem; position: relative; }
        .checklist li::before {
          content: '✓'; position: absolute; left: 0; top: 0; color: #30660c; font-weight: 900;
        }

        /* Refinos visuais das cards/boxes */
        .soft-card { border: 1px solid rgba(48,102,12,.08) !important; border-radius: 16px !important; }
      "))
    ),
    
    # ------- Hero / Cabeçalho do módulo
    fluidRow(
      column(
        width = 12,
        div(class = "hero-demog",
            h2("Demografias 50+"),
            p(class = "subtitle", "Crescimento, causas e implicações estratégicas")
        )
      )
    ),
    
    # ------- Seção 1.2: Ritmo de crescimento + Gráfico
    fluidRow(
      column(
        width = 7,
        box(
          width = 12, status = "info", solidHeader = TRUE, collapsible = TRUE,
          title = tagList(icon("chart-line"), " 1.2 · Ritmo de crecimiento 50+ vs 50-"),
          div(class = "prose two-col",
              HTML('
                <p><strong>El ritmo de crecimiento de la población 50+</strong> es muy superior al de la población más joven.
                Mientras la población menor de 50 años crece lentamente o incluso se estabiliza, la población 50+ avanza como un <em>“boom silencioso”</em>.
                La tasa de crecimiento geométrico de las personas mayores es varias veces mayor.</p>
                <p class="note"><strong>Implicación:</strong> toda estrategia que ignore a este grupo se vuelve, progresivamente, una estrategia obsoleta.</p>
              ')
          ),
          div(style = "font-weight:700; margin-top:.4rem; margin-bottom:.6rem;", "Tasa de Crecimiento Geométrico"),
          plotOutput(ns("plot_crecimiento"), height = "280px")
        )
      ),
      column(
        width = 5,
        box(
          width = 12, status = "info", solidHeader = TRUE, collapsible = TRUE,
          title = tagList(icon("lightbulb"), " Mensajes clave"),
          tags$ul(class = "checklist",
                  tags$li("El 50+ crece más rápido que el 50-"),
                  tags$li("El crecimiento joven se desacelera o se estabiliza"),
                  tags$li("El cambio es sostenido y acumulativo")
          ),
          br(),
          bs4Callout(
            title  = "Conclusión",
            status = "warning",
            "Ignorar a la población 50+ debilita la estrategia comercial y reputacional."
          )
        )
      )
    ),
    
    # ------- Seção 1.3 e 1.4 (duas colunas na página)
    fluidRow(
      column(
        width = 6,
        box(
          width = 12, status = "info", solidHeader = TRUE, collapsible = TRUE,
          title = tagList(icon("users"), " 1.3 · Causas del envejecimiento"),
          fluidRow(
            column(6,
                   div(class = "prose",
                       HTML('
                    <h4>Mujeres con menos hijos</h4>
                    <p>Descenso sostenido de la fecundidad en las últimas décadas.</p>
                  ')
                   )
            ),
            column(6,
                   div(class = "prose",
                       HTML('
                    <h4>Las personas viven más</h4>
                    <p>Mayor esperanza de vida al nacer y a los 50 años.</p>
                  ')
                   )
            )
          ),
          div(class = "note",
              "Estas tendencias no retroceden: el envejecimiento no es un posible escenario — es el escenario garantizado.")
        )
      ),
      column(
        width = 6,
        box(
          width = 12, status = "info", solidHeader = TRUE, collapsible = TRUE,
          title = tagList(icon("chart-area"), " 1.4 · Proyecciones"),
          tags$ul(class = "checklist",
                  tags$li("El envejecimiento poblacional será más rápido"),
                  tags$li("El peso de la población 50+ será mayor"),
                  tags$li("El impacto económico será más profundo")
          ),
          br(),
          div(class = "note",
              tags$strong("En síntesis: "),
              "quien no se prepare ahora llegará demasiado tarde.")
        )
      )
    ),
    
    # ------- Seção 2: Caso de negocio (texto em duas colunas)
    fluidRow(
      column(
        width = 12,
        box(
          width = 12, status = "success", solidHeader = TRUE, collapsible = TRUE,
          title = tagList(icon("briefcase"), " 2 · Caso de negocio"),
          div(class = "prose two-col",
              HTML('
                <h4>a) Mercado potencial</h4>
                <p>La población 50+ representa uno de los segmentos de mayor crecimiento, mayor estabilidad de ingresos y mayor acumulación de activos.
                No se trata solo de personas mayores; se trata de consumidores activos, con proyectos, decisiones financieras complejas y necesidades específicas.
                Para las instituciones financieras, este grupo constituye un mercado sólido, poco explorado y con alto potencial de fidelización.</p>

                <h4>b) No se trata solo de ingresos: valor social</h4>
                <p>La economía plateada no es únicamente un motor financiero; también genera impacto social positivo.
                Al ofrecer productos y servicios adaptados, las instituciones pueden promover inclusión, autonomía, educación financiera y calidad de vida,
                fortaleciendo la reputación institucional y alineando la estrategia con los ODS y criterios ESG.</p>

                <h4>c) Oportunidad de posicionamiento</h4>
                <p>El mercado nacional aún no cuenta con una institución líder en la agenda del envejecimiento.
                Quien ocupe esta posición primero obtendrá una ventaja competitiva difícil de replicar:
                ser la marca asociada al cuidado, a la innovación social y al futuro demográfico del país.</p>
              ')
          )
        )
      )
    )
  )
}

demografias_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # ---- Dados de exemplo para o gráfico (substitua pelos seus quando quiser)
    #      Valores inspirados no material: 50+ x 50- em 1993/2002/2010/2022
    dados <- tibble::tribble(
      ~grupo, ~ano, ~valor,
      "50+", "1993", 4.6,
      "50+", "2002", 3.7,
      "50+", "2010", 3.0,
      "50+", "2022", 4.0,
      "50-", "1993", 1.9,
      "50-", "2002", 1.5,
      "50-", "2010", 0.9,
      "50-", "2022", 0.4
    )
    
    output$plot_crecimiento <- renderPlot({
      ggplot2::ggplot(dados, ggplot2::aes(x = ano, y = valor, fill = grupo)) +
        ggplot2::geom_col(width = 0.62) +
        ggplot2::geom_text(ggplot2::aes(label = paste0(valor, "%")),
                           vjust = -0.35, size = 4) +
        ggplot2::facet_wrap(~ grupo, ncol = 2) +
        ggplot2::scale_y_continuous(
          expand = ggplot2::expansion(mult = c(0.02, 0.16)),
          breaks = scales::pretty_breaks(5),
          labels = function(x) paste0(x, "%")
        ) +
        ggplot2::scale_fill_manual(values = c("50+" = "#752c91", "50-" = "#172e52")) +
        ggplot2::labs(x = NULL, y = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(
          legend.position       = "none",
          strip.text            = ggplot2::element_text(face = "bold"),
          panel.grid.major.x    = ggplot2::element_blank(),
          panel.grid.minor      = ggplot2::element_blank(),
          plot.margin           = ggplot2::margin(5.5, 12, 5.5, 12)
        )
    })
  })
}
