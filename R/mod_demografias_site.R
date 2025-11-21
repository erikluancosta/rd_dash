# mod_demografias_site.R
demografias_site_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # ------- CSS com cara de site/landing page -------
    tags$head(
      tags$style(HTML("
        /* fundo branco geral */
        body, .content-wrapper, .content {
          background-color: #ffffff !important;
        }

        /* Wrapper da página site: puxa para fora o padding lateral
           para encostar nas bordas do conteúdo */
        .site-wrapper-full {
          margin-left: -15px;
          margin-right: -15px;
        }
        @media (min-width: 1200px) {
          .site-wrapper-full {
            margin-left: -30px;
            margin-right: -30px;
          }
        }

        /* HERO – apenas tipografia e espaçamento (fundo vem do .site-section.dark) */
        .site-hero {
          color: #fff;
          padding: 34px 0 20px;
          margin-bottom: 6px;
        }
        .site-kicker {
          text-transform: uppercase;
          letter-spacing: .12em;
          font-size: 0.78rem;
          font-weight: 700;
          opacity: .85;
          margin-bottom: 6px;
        }
        .site-hero h1 {
          font-weight: 800;
          margin: 0 0 8px 0;
        }
        .site-hero p {
          max-width: 540px;
          font-size: 1.02rem;
          opacity: .95;
        }

        .site-section {
          padding: 26px 0 24px;
        }
        .site-section-inner {
          max-width: 1040px;
          margin: 0 auto;
          padding: 0 18px;
        }

        /* FAIXA ESCURA ÚNICA: hero + seção 1.2 */
        .site-section.dark {
          background:
            linear-gradient(
              180deg,
              rgba(0, 0, 0, 0.0) 0%,    /* topo: sem escurecer (igual ao hero) */
              rgba(0, 0, 0, 0.15) 40%,  /* meio: um pouco mais escuro */
              rgba(0, 0, 0, 0.35) 100%  /* base: mais escuro */
            ),
            linear-gradient(120deg, #172e52 0%, #0a1b32 60%, #752c91 100%);
          color: #fff;
        }

        .site-section.alt {
          background: #F8F9F7;
        }

        .site-section h2 {
          font-weight: 700;
          margin-bottom: 14px;
        }
        .site-section h3 {
          font-weight: 700;
          margin-top: 10px;
          margin-bottom: 6px;
        }
        .site-text p {
          font-size: 1.02rem;
          line-height: 1.6;
          margin-bottom: .7rem;
        }

        .site-pill {
          display: inline-block;
          padding: 3px 9px;
          border-radius: 999px;
          background: rgba(117, 44, 145,0.18);
          color: #752c91;
          font-size: 0.75rem;
          text-transform: uppercase;
          letter-spacing: .1em;
          margin-bottom: 4px;
        }
        
        .site-pill2 {
          display: inline-block;
          padding: 3px 9px;
          border-radius: 999px;
          background: rgba(246,196,70,0.18);
          color: #f6c446;
          font-size: 0.75rem;
          text-transform: uppercase;
          letter-spacing: .1em;
          margin-bottom: 4px;
        }

        .site-note {
          border-left: 4px solid #f6c446;
          padding-left: 10px;
          margin-top: 6px;
          font-weight: 600;
        }

        .site-list {
          list-style: none;
          padding-left: 0;
          margin-bottom: 0.4rem;
        }
        .site-list li {
          margin: .35rem 0;
          padding-left: 1.15rem;
          position: relative;
        }
        .site-list li::before {
          content: '•';
          position: absolute;
          left: 0;
          top: 0;
          color: #f6c446;
          font-weight: 900;
        }

        .site-tagline {
          font-weight: 700;
          text-align: center;
          font-size: 1.02rem;
        }
  "))
    ),
    
    # ---------- WRAPPER QUE EXPANDE ATÉ AS BORDAS ----------
    div(
      class = "site-wrapper-full",
      
      # ========== FAIXA ESCURA ÚNICA: HERO + 1.2 ==========
      div(
        class = "site-section dark",
        div(
          class = "site-section-inner",
          
          # --- HERO (República Dominicana 50+, título, parágrafo) ---
          div(
            class = "site-hero",
            div(class = "site-kicker", "República Dominicana 50+"),
            h1("Transformación demográfica y oportunidades financieras"),
            p("El crecimiento acelerado de la población 50+ crea un nuevo mapa de riesgos, oportunidades y necesidades para el sistema financiero.")
          ),
          
          # --- 1.2 El boom silencioso + gráfico ---
          fluidRow(
            column(
              width = 6,
              div(class = "site-pill2", "1. Dinámica demográfica"),
              h2("1.2 El boom silencioso de la población 50+"),
              div(
                class = "site-text",
                HTML('
                  <p><strong>El ritmo de crecimiento de la población 50+</strong> es muy superior al de la población más joven.
                  Mientras la población menor de 50 años crece lentamente o incluso se estabiliza, la población 50+ avanza como un <em>“boom silencioso”</em>.
                  La tasa de crecimiento geométrico de las personas mayores es varias veces mayor.</p>
                '),
                div(
                  class = "site-note",
                  "Toda estrategia que ignore a este grupo se vuelve, progresivamente, una estrategia obsoleta."
                )
              )
            ),
            column(
              width = 6,
              div(style = "margin-top:10px; font-size:0.9rem; opacity:.8;",
                  "Indicador visual: tasa de crecimiento geométrico de la población 50+ y 50-."),
              plotOutput(ns("plot_crecimiento_site"), height = "260px")
            )
          )
        )
      ),
      
      # ========== SEÇÃO 1.3 / 1.4 – FUNDO CLARO (como antes) ==========
      div(
        class = "site-section",
        div(
          class = "site-section-inner",
          fluidRow(
            column(
              width = 6,
              div(class = "site-pill", "Causas estructurales"),
              h2("1.3 ¿Por qué el país está envejeciendo?"),
              div(
                class = "site-text",
                h3("Menos hijos"),
                p("Las mujeres tienen menos hijos, con un descenso sostenido de la fecundidad."),
                h3("Más años de vida"),
                p("Las personas viven más, con mayor esperanza de vida al nacer y a los 50 años."),
                div(
                  class = "site-note",
                  "Estas tendencias no retroceden: el envejecimiento no es un escenario posible — es el escenario garantizado."
                )
              )
            ),
            column(
              width = 6,
              div(class = "site-pill", "Proyecciones"),
              h2("1.4 Lo que muestran las curvas demográficas"),
              div(
                class = "site-text",
                p("Las proyecciones para 2030, 2040 o 2050 son inequívocas:"),
                tags$ul(
                  class = "site-list",
                  tags$li("El envejecimiento poblacional será más rápido."),
                  tags$li("El peso de la población 50+ será mayor."),
                  tags$li("El impacto económico será más profundo.")
                ),
                div(
                  class = "site-note",
                  "En síntesis: quien no se prepare ahora llegará demasiado tarde."
                )
              )
            )
          )
        )
      ),
      
      # ========== SEÇÃO 2: Caso de negocio – ALT ==========
      div(
        class = "site-section alt",
        div(
          class = "site-section-inner",
          div(class = "site-pill", "2. Caso de negocio"),
          h2("Un mercado creciente, oportunidades reales y un vacío estratégico"),
          br(),
          fluidRow(
            column(
              width = 4,
              div(
                class = "site-text",
                h3("a) Mercado potencial"),
                p("La población 50+ representa uno de los segmentos de mayor crecimiento, mayor estabilidad de ingresos y mayor acumulación de activos."),
                p("No se trata solo de personas mayores; se trata de consumidores activos, con proyectos, decisiones financieras complejas y necesidades específicas.")
              )
            ),
            column(
              width = 4,
              div(
                class = "site-text",
                h3("b) Valor social y reputacional"),
                p("La economía plateada no es únicamente un motor financiero; también genera impacto social positivo."),
                p("Al ofrecer productos y servicios adaptados, las instituciones pueden promover inclusión, autonomía, educación financiera y calidad de vida, fortaleciendo su reputación e alineación con ODS y criterios ESG.")
              )
            ),
            column(
              width = 4,
              div(
                class = "site-text",
                h3("c) Oportunidad de liderazgo"),
                p("El mercado financiero nacional aún no cuenta con una institución líder en la agenda del envejecimiento."),
                p("Quien ocupe esta posición primero alcanzará una ventaja competitiva difícil de replicar: ser la marca asociada al cuidado, a la innovación social y al futuro demográfico del país.")
              )
            )
          ),
          br(),
          div(
            class = "site-tagline",
            "El envejecimiento de la población 50+ no es solo un desafío demográfico: es una tesis de inversión y posicionamiento estratégico."
          )
        )
      )
    ) # fecha site-wrapper-full
  )
}




demografias_site_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Dados de exemplo – mesmos da versão dashboard
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
    
    output$plot_crecimiento_site <- renderPlot({
      ggplot2::ggplot(dados, ggplot2::aes(x = ano, y = valor, fill = grupo)) +
        ggplot2::geom_col(width = 0.62) +
        ggplot2::geom_text(
          ggplot2::aes(label = paste0(valor, "%")),
          vjust = -0.3, size = 4
        ) +
        ggplot2::facet_wrap(~ grupo, ncol = 2) +
        ggplot2::scale_y_continuous(
          expand = ggplot2::expansion(mult = c(0.02, 0.18)),
          labels = NULL    # sem valores no eixo Y
        ) +
        ggplot2::scale_fill_manual(
          values = c("50+" = "#f6c446", "50-" = "#752c91")
        ) +
        ggplot2::labs(x = NULL, y = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(
          legend.position     = "none",
          strip.text          = ggplot2::element_text(face = "bold"),
          # remove TODAS as grids
          panel.grid.major    = ggplot2::element_blank(),
          panel.grid.minor    = ggplot2::element_blank(),
          # some rótulos e ticks do eixo Y
          axis.text.y         = ggplot2::element_blank(),
          axis.ticks.y        = ggplot2::element_blank(),
          plot.background     = ggplot2::element_rect(fill = "transparent", colour = NA),
          panel.background    = ggplot2::element_rect(fill = "transparent", colour = NA),
          plot.margin         = ggplot2::margin(5.5, 12, 5.5, 12)
        )
    })
  })
}
