shinyUI(fluidPage(theme = "yeti.css",
                  tagList(
                    singleton(tags$head(tags$script(src='//cdn.datatables.net/fixedheader/2.1.2/js/dataTables.fixedHeader.min.js',type='text/javascript'))),
                    singleton(tags$head(tags$link(href='//cdn.datatables.net/fixedheader/2.1.2/css/dataTables.fixedHeader.css',rel='stylesheet',type='text/css')))
                  ),
                  navbarPage('Landowner Report Tool',
                             tabPanel("NLA",
                                      sidebarPanel('Instructions',
                                                   selectInput('site',"Select a site for report generation.",
                                                               choices=paste(NLA2012$SITE_ID,NLA2012$EVAL_NAME,sep=": "),
                                                               selected=NULL),
                                                   conditionalPanel("input.metalToPlot !== null",
                                                                    uiOutput("visitno_")),
                                                   #selectInput('visitno',"Select visit number, if applicable",
                                                  #             choices=NLA2012$VISIT_NO,
                                                   #            selected=NULL),
                                                   
                                                   hr(),
                                                   downloadButton('knitNLA','Send to Report')),
                                      mainPanel("Data Preview",
                                                tableOutput('previewData'))
                                      
                             ),
                             tabPanel("NRSA"),
                             tabPanel("ProbMon")
                  ))
        )
                             
                                                 