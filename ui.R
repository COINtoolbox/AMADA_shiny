
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(mvtnorm)
library(pheatmap)
library(markdown)
library(shinyIncubator)

shinyUI(fluidPage(theme = "bootstrapblue.css",collapsable = TRUE,
 
  headerPanel('AMADA Web User Interface (v0.1)'),
  img(src='COIN.jpg',height = 100, width = 600,align="right"),
  # Sidebar with controls
  sidebarPanel(
  
    tags$head(tags$style(
type="text/css", "
            #loadmessage {
               position: fixed;
               top: 50%;
               left: 0px;
               width: 100%;
               padding: 5px 0px 5px 0px;
             text-align: center;
               font-weight: bold;
               font-size: 125%;
              color: #FFFFFF;
               background-color: #B22222;
               z-index: 105;
             }
          ")),
h3("Overview"),
    p("The open source online interface for 
Analysis of Multidimensional Astronomical DAtasets. This interface employs a hierarchical clustering 
analysis into a numerical matrix for different choices of dissimilarity measurements", align = "left"),
   
h4("Data Input"),
    div(div(checkboxInput('dataSourceFlag', label=h5('Use Default'), T),class="radio"
        )),
    selectInput("data", "Dataset:",
                list("Use SNe Type Ia data" = "SNIa",
                     "N-body/hydro" = "Guo11")),
    fileInput('file1', 'Upload your file', accept=c('.dat', '.txt')),
    
    h4("Control and options"),
h5("Heatmap"),
selectInput("shown", "Display Numbers?",
            list("Yes" = "T",
                 "No" = "F"
                 )),
h5("Correlation"),
selectInput("method", "Method:",
            list("Pearson" = "pearson",
                 "Spearman" = "spearman",
                 "MIC" = "MIC")),
sliderInput('npcs', 'Number of PCs', 2,
             min = 2, max = 10,step=1),
    br(), 
submitButton("Make it so!", icon("refresh")),

br(),
wellPanel(
  helpText(HTML("<b>Author</b>")),
  HTML('Rafael S. de Souza'),
  HTML('<br>'),
  HTML('<a href="https://github.com/RafaelSdeSouza" target="_blank">Code on GitHub</a>')
)
  ),
  #Show output plot
mainPanel(
    
  tabsetPanel(
    tabPanel("Introduction", includeMarkdown("help.md")),
      tabPanel("Heatmap",plotOutput('plot1')),
      tabPanel("Correlation",plotOutput('plot2')),
      tabPanel("Dendrogram",plotOutput('plot3')),
      tabPanel("Graph",plotOutput('plot4')),
      tabPanel("PCA",plotOutput('plot5',width = "100%")),
      tabPanel("Copyright", includeMarkdown("Copyright.md"))
      )),
div(class="progress-bar",class="progress progress-striped active",style="width: 70%;",
    conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                     tags$div("Calculating... wait a minute.",align="top")))
))
