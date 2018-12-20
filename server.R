source('global.R')

shinyServer(function(input, output, session) {
  
  output$visitno_ <- renderUI({
    name <- strsplit(input$site,": ")[[1]][1]
    if(nrow(filter(NLA2012,SITE_ID==name))>1){
      selectInput('visitno_2',"Select visit number, if applicable",
                   choices=filter(NLA2012,SITE_ID==name)$VISIT_NO,
                   selected=NULL)
    }
  })
  
  selectedData <- reactive({
    if(is.null(input$site))
      return(NULL)
    name <- strsplit(input$site,": ")[[1]][1]
    if(is.null(input$visitno_2))
      visit <- 1
    visit <- ifelse(nrow(filter(NLA2012,SITE_ID==name))>1,input$visitno_2,1)
    if(is.null(visit)){filter(NLA2012,SITE_ID==name, VISIT_NO==1)}else{
      filter(NLA2012,SITE_ID==name, VISIT_NO==visit)}
  })

  
  output$previewData <- renderTable({
    if(is.null(selectedData()))
      return(NULL)
    selectedData()[,1:8]})
  
  ##---------------------------------------RMARKDOWN SECTION----------------------------------------------
  
  output$knitNLA <- downloadHandler(
    filename = 'results.html',
    content= function(file){
      tempReport <- file.path(tempdir(), "LandownerReport.Rmd")
      #image1 <- file.path(tempdir(), '20141016_131134.jpg')
      file.copy("LandownerReport.Rmd",tempReport,overwrite=T)
      #file.copy('20141016_131134.jpg',image1,overwrite=T)
      
      params <- list(table_selectedData=selectedData())
      
      rmarkdown::render(tempReport,output_file= file,
                        params=params, envir=new.env(parent=globalenv()))})
  ##------------------------------------------------------------------------------------------------------
  
 
  
})


