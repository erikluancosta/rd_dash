# mod_demografias_site.R
demografias_site_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # ------- CSS com cara de site/landing page -------
    tags$head(
      tags$style(HTML("
    /* =====================================================
       BASE
    ======================================================*/
    html, body {
      font-size: 16px;
    }

    body, .content-wrapper, .content {
      background-color: #ffffff !important;
    }

    /* Wrapper da página site */
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

    .site-section {
      padding: 26px 0 24px;
    }
    .site-section-inner {
      max-width: 1040px;
      margin: 0 auto;
      padding: 0 18px;
    }

    /* =====================================================
       TIPOGRAFIA FLUIDA
    ======================================================*/
    .site-kicker {
      text-transform: uppercase;
      letter-spacing: .12em;
      font-size: clamp(0.72rem, 0.6rem + 0.25vw, 0.78rem);
      font-weight: 700;
      opacity: .85;
      margin-bottom: 6px;
    }

    .site-hero {
      color: #fff;
      padding: 34px 0 16px;
      margin-bottom: 6px;
    }
    .site-hero h1 {
      font-weight: 800;
      margin: 0 0 8px 0;
      font-size: clamp(1.8rem, 1.4rem + 1.2vw, 2.6rem);
      line-height: 1.15;
    }
    .site-hero p {
      max-width: 740px;
      font-size: clamp(1.0rem, 0.95rem + 0.3vw, 1.1rem);
      line-height: 1.6;
      opacity: .95;
    }

    .site-section h2 {
      font-weight: 700;
      margin-bottom: 14px;
      font-size: clamp(1.25rem, 1.05rem + 0.8vw, 1.9rem);
      line-height: 1.3;
    }
    .site-section h3 {
      font-weight: 700;
      margin-top: 10px;
      margin-bottom: 6px;
      font-size: clamp(1.05rem, 0.95rem + 0.45vw, 1.3rem);
      line-height: 1.3;
    }

    .site-text p {
      font-size: clamp(0.98rem, 0.94rem + 0.25vw, 1.05rem);
      line-height: 1.6;
      margin-bottom: .7rem;
    }

    .site-tagline {
      font-weight: 700;
      text-align: center;
      font-size: clamp(1.0rem, 0.95rem + 0.35vw, 1.1rem);
    }

    .site-pill,
    .site-pill2 {
      display: inline-block;
      padding: 3px 9px;
      border-radius: 999px;
      font-size: clamp(0.70rem, 0.68rem + 0.2vw, 0.75rem);
      text-transform: uppercase;
      letter-spacing: .1em;
      margin-bottom: 4px;
      white-space: nowrap;
    }
    .site-pill {
      background: rgba(117, 44, 145,0.18);
      color: #752c91;
    }
    .site-pill2 {
      background: rgba(246,196,70,0.18);
      color: #f6c446;
    }

    .site-note {
      border-left: 4px solid #f6c446;
      padding-left: 10px;
      margin-top: 6px;
      font-weight: 600;
      font-size: clamp(0.9rem, 0.86rem + 0.2vw, 0.95rem);
      line-height: 1.5;
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
      font-size: clamp(0.98rem, 0.94rem + 0.25vw, 1.05rem);
      line-height: 1.6;
    }
    .site-list li::before {
      content: '•';
      position: absolute;
      left: 0;
      top: 0;
      color: #f6c446;
      font-weight: 900;
    }

    /* =====================================================
       FUNDOS
    ======================================================*/
    .site-section.dark {
      background:
        linear-gradient(
          180deg,
          rgba(0, 0, 0, 0.0) 0%,
          rgba(0, 0, 0, 0.15) 40%,
          rgba(0, 0, 0, 0.35) 100%
        ),
        linear-gradient(120deg, #172e52 0%, #0a1b32 60%, #752c91 100%);
      color: #fff;
    }
    .site-section.alt {
      background: #F8F9F7;
    }

    /* =====================================================
       MEDIA QUERIES – AJUSTES POR TAMANHO
    ======================================================*/

    /* Tablets e telas médias */
    @media (max-width: 992px) {
      .site-section {
        padding: 20px 0 18px;
      }
      .site-section-inner {
        padding: 0 14px;
      }
      .site-hero {
        padding: 26px 0 12px;
      }
    }

    /* Celulares */
    @media (max-width: 576px) {
      .site-section {
        padding: 18px 0 16px;
      }
      .site-section-inner {
        padding: 0 10px;
      }
      .site-hero {
        padding: 22px 0 10px;
      }
      .site-hero p {
        max-width: 100%;
      }
      .site-note {
        font-size: 0.9rem;
      }
    }
  "))
    ),
    
    # ---------- WRAPPER QUE EXPANDE ATÉ AS BORDAS ----------
    div(
      class = "site-wrapper-full",
      
      # ========== FAIXA ESCURA ÚNICA: METODOLOGÍA + 1 / 1.1 / 1.2 ==========
      div(
        class = "site-section dark",
        div(
          class = "site-section-inner",
          
          # --- METODOLOGÍA – POR QUÉ: El punto de partida (slide 1) ---
          div(
            class = "site-hero",
            div(class = "site-kicker", "Metodología"),
            h1("Por qué — el punto de partida"),
            p("Imagine un país que envejece silenciosamente. No aparece en los titulares, no genera crisis súbitas. 
              Pero modifica, año tras año, la estructura profunda de la economía, del mercado laboral y de las oportunidades de negocio. 
              Ese proceso, el envejecimiento poblacional, es hoy una de las transformaciones más decisivas para las instituciones financieras.")
          ),
          
          div(
            class = "site-text",
            h3("¿Por qué importa?"),
            p("Porque cada año que pasa, la estructura demográfica del país deja de ser una pirámide y se convierte en un rectángulo. 
               Hay menos jóvenes entrando al mercado y más personas viviendo más tiempo, con más necesidades, más decisiones financieras 
               y más expectativas de calidad en los servicios. Y, aun así, la mayor parte de las instituciones financieras sigue operando 
               con un modelo pensado para una sociedad que ya no existe."),
            div(
              class = "site-note",
              "Oportunidad o riesgo: depende de quién actúe antes."
            )
          ),
          
          br(), br(),
          
          # --- 1. Los datos confirman… (slide 2) ---
          div(
            class = "site-text",
            div(class = "site-pill2", "1. Dinámica demográfica"),
            h2("1. Los datos confirman: el país está envejeciendo a pasos acelerados"),
            p("El envejecimiento poblacional ya no es una proyección distante: es una realidad que avanza año tras año 
               y que reconfigura la estructura demográfica del país. Las generaciones mayores ganan peso relativo, mientras 
               la base joven se estrecha."),
            p("Las estadísticas muestran un aumento rápido y sostenido del número de personas de 50 años o más — tanto en valores 
               absolutos como en proporción del total de la población. Comprender esta transformación es esencial para cualquier 
               institución financiera que desee anticiparse a los cambios del mercado y posicionarse frente a un nuevo ciclo demográfico.")
          ),
          
          br(),
          
          # --- 1.1 + 1.2 (slides 3 e 4) + gráficos ---
          fluidRow(
            # 1.1 – texto + gráficos (absoluto e relativo)
            column(
              width = 6,
              div(
                class = "site-text",
                h3("1.1 La población 50+ ya es numéricamente relevante — y crece rápidamente"),
                p(HTML("En números absolutos, el contingente de personas con 50 años o más nunca ha sido tan alto — 
                   y seguirá creciendo durante décadas. <br>
                  En términos relativos, el peso de este grupo dentro del total de la población aumenta año tras año.")),
                p("")
              ),
              div(
                style = "margin-top: 16px; font-size:0.9rem; opacity:.85;",
                "Indicadores 1.1: en números absolutos y en términos relativos (50+, 1993–2022)."
              ),
              plotOutput(ns("plot_11_site"), height = "260px"),
              div(
                class = "site-note",
                "En otras palabras: la fuerza demográfica se está desplazando hacia la población 50+."
              )
            ),
            
            # 1.2 – texto + gráfico de tasas
            column(
              width = 6,
              div(
                class = "site-text",
                h3("1.2 El ritmo de crecimiento de la población 50+ es muy superior al de la población más joven"),
                p("Mientras la población menor de 50 años crece lentamente o incluso se estabiliza, la población 50+ avanza como un 
                   \"boom silencioso\". La tasa de crecimiento geométrico de las personas mayores es varias veces mayor.")
              ),
              div(
                style = "margin-top:16px; font-size:0.9rem; opacity:.8;",
                "Indicador visual: tasa de crecimiento geométrico de la población 50+ y 50-."
              ),
              # p(""),
              plotOutput(ns("plot_crecimiento_site"), height = "260px"),
              div(
                class = "site-note",
                "Esto significa que toda estrategia que ignore a este grupo se vuelve, progresivamente, una estrategia obsoleta."
              )
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
      
      # ========== SEÇÃO 2: Caso de negocio – ALT (igual estava) ==========
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
    
    # --------- DADOS 1.2: Tasa de crecimiento geométrico 50+ x 50- ---------
    dados_12 <- tibble::tribble(
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
    
    # --------- DADOS 1.1: Absoluto e relativo ---------
    dados_11 <- tibble::tribble(
      ~tipo,                   ~ano,   ~valor,
      "En números absolutos",  "1993",  902670,
      "En números absolutos",  "2002", 1252062,
      "En números absolutos",  "2010", 1580312,
      "En números absolutos",  "2022", 2519080,
      "En términos relativos", "1993", 12.38,
      "En términos relativos", "2002", 14.62,
      "En términos relativos", "2010", 16.73,
      "En términos relativos", "2022", 23.38
    ) |>
      dplyr::mutate(
        es_abs = tipo == "En números absolutos",
        etiqueta = dplyr::if_else(
          es_abs,
          # inteiros com separador de milhar, SEM casas decimais
          trimws(                      # <- remove os espaços
            format(
              round(valor, 0),
              big.mark     = ".",
              decimal.mark = ",",
              nsmall       = 0,
              scientific   = FALSE
            )
          ),
          # percentuais com 1 casa decimal e vírgula
          paste0(
            trimws(                    # <- remove os espaços
              format(
                round(valor, 1),
                big.mark     = ".",
                decimal.mark = ",",
                nsmall       = 1
              )
            ),
            "%"
          )
        )
      )
    
    
    # --------- GRÁFICO 1.1 (dois painéis) ---------
    output$plot_11_site <- renderPlot({
      ggplot2::ggplot(dados_11, ggplot2::aes(x = ano, y = valor)) +
        ggplot2::geom_col(fill = "#752c91", width = 0.62) +
        ggplot2::geom_text(
          ggplot2::aes(label = etiqueta),
          vjust = -0.35,
          size  = 4
        ) +
        ggplot2::facet_wrap(~ tipo, ncol = 2, scales = "free_y") +
        ggplot2::scale_y_continuous(
          expand = ggplot2::expansion(mult = c(0.02, 0.20))
        ) +
        ggplot2::scale_x_discrete(
          breaks = c("1993", "2002", "2010", "2022")
        ) +
        ggplot2::labs(x = NULL, y = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(
          legend.position  = "none",
          strip.text       = ggplot2::element_text(face = "bold", colour = "black"),
          panel.grid.major = ggplot2::element_blank(),
          panel.grid.minor = ggplot2::element_blank(),
          axis.text.y      = ggplot2::element_blank(),
          axis.ticks.y     = ggplot2::element_blank(),
          axis.text.x      = ggplot2::element_text(colour = "black"),
          plot.background  = ggplot2::element_rect(fill = "transparent", colour = NA),
          panel.background = ggplot2::element_rect(fill = "transparent", colour = NA),
          strip.background = ggplot2::element_rect(fill = NA, colour = NA),
          plot.margin      = ggplot2::margin(5.5, 12, 5.5, 12)
        )
    })
    
    
    # --------- GRÁFICO 1.2 (tasa geométrica) ---------
    output$plot_crecimiento_site <- renderPlot({
      ggplot2::ggplot(dados_12, ggplot2::aes(x = ano, y = valor, fill = grupo)) +
        ggplot2::geom_col(width = 0.62) +
        ggplot2::geom_text(
          ggplot2::aes(
            label = paste0(
              format(
                round(valor, 1),
                big.mark     = ".",
                decimal.mark = ",",
                nsmall       = 1
              ),
              "%"
            )
          ),
          vjust    = -0.3,
          size     = 4#,
          #fontface = "bold"
        ) +
        ggplot2::facet_wrap(~ grupo, ncol = 2) +
        ggplot2::scale_y_continuous(
          expand = ggplot2::expansion(mult = c(0.02, 0.18)),
          labels = NULL
        ) +
        ggplot2::scale_x_discrete(
          breaks = c("1993", "2002", "2010", "2022")
        ) +
        ggplot2::scale_fill_manual(
          values = c("50+" = "#f6c446", "50-" = "#752c91")
        ) +
        ggplot2::labs(x = NULL, y = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(
          legend.position  = "none",
          strip.text       = ggplot2::element_text(face = "bold"),
          panel.grid.major = ggplot2::element_blank(),
          panel.grid.minor = ggplot2::element_blank(),
          axis.text.y      = ggplot2::element_blank(),
          axis.ticks.y     = ggplot2::element_blank(),
          axis.text.x      = ggplot2::element_text(
            colour = "black"#,
            #face   = "bold"
          ),
          plot.background  = ggplot2::element_rect(fill = "transparent", colour = NA),
          panel.background = ggplot2::element_rect(fill = "transparent", colour = NA),
          plot.margin      = ggplot2::margin(5.5, 12, 5.5, 12)
        )
    })
  })
}


