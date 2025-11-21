library(shiny)
library(bs4Dash)
library(fresh)

source("global.R")

# Tema customizado (fresh para bs4Dash - Bootstrap 4)
tema <- fresh::create_theme(
  fresh::bs4dash_status(
    info      = "#172e52",
    secondary = "#f6c446",
    danger    = "#752c91",
    primary   = "#ffffff",
    warning   = "#121E54"
  )
)

ui <- bs4DashPage(
  title = "República Dominicana - Demografias",
  
  # IMPORTANTE: dark = NULL e help = NULL escondem os dois switches da direita
  dark = NULL,
  help = NULL,
  
  header = dashboardHeader(
    title = bs4DashBrand(
      title = "República Dominicana",
      color = "info",
      image = "https://dw0jruhdg6fis.cloudfront.net/producao/28001597/G/whatsapp_image_2021_03_04_at_17.35.04.jpeg"
    ),
    skin   = "light",
    status = "white",
    border = FALSE,
    compact = TRUE,
    sidebarIcon   = NULL,  # some o hamburguer do sidebar
    controlbarIcon = NULL, # some o ícone da direita
    
    # MENU NO TOPO (sem ícone pra ficar mais limpo)
    navbarMenu(
      id = "navmenu",
      navbarTab(
        text    = "El envejecimiento",
        tabName = "demografias_site"
      ),
      navbarTab(
        text    = "Mapa",
        tabName = "mapa"
      ),
      navbarTab(
        text    = "Repositorio",
        tabName = "repositorio"
      )
    )
  ),
  
  # Não usamos sidebar lateral
  sidebar = bs4DashSidebar(disable = TRUE),
  
  body = bs4DashBody(
    fresh::use_theme(tema),
    
    # ---- CSS para estilizar o menu do topo ----
    tags$head(
      tags$style(HTML("
        /* menu do topo mais bonitinho */
        .main-header .navbar-nav .nav-link {
          font-weight: 600;
          font-size: 0.95rem;
          color: #7a7a7a;
          padding: 0 18px;
          border-bottom: 2px solid transparent;
        }
        .main-header .navbar-nav .nav-link:hover {
          color: #172e52;
          border-bottom-color: rgba(246,196,70,0.6);
        }
        .main-header .navbar-nav .nav-link.active {
          color: #172e52;
          border-bottom-color: #f6c446;
        }
      "))
    ),
    
    bs4TabItems(
      bs4TabItem(
        tabName = "demografias_site",
        demografias_site_ui("demografias_site")
      ),
      bs4TabItem(
        tabName = "repositorio",
        repositorio_ui("repositorio")
      ),
      bs4TabItem(
        tabName = "mapa",
        mapa_ui("mapa")
      )
    )
  ),
  
  footer = dashboardFooter(
    left = "© IFC, 2025 | Protótipo"
  )
)

server <- function(input, output, session) {
  demografias_site_server("demografias_site")   # versão site
  repositorio_server("repositorio")            # versão dashboard
  mapa_server("mapa")                          # módulo mapa
}

shinyApp(ui, server)
