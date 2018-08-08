
mapper = function(data) {
  require(shiny)
  require(leaflet)
  shinyApp(
  
  ui = leafletOutput('map'),
  
  server = function(input,output) {
    output$map <- renderLeaflet({
    leaflet(options = leafletOptions(minZoom = 6)) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(lng = mean(data$lon), 
              lat = mean(data$lat), 
              zoom = 6) %>%
      setMaxBounds(lng1 = -130.3933357,
                   lat1 = 43.108951,
                   lng2 = -109.729128,
                   lat2 = 32.144795)
  })
    observe({
    leafletProxy('map') %>%
      clearShapes() %>%
      addCircles(data = data, #Cannot use addcirclemarkers as popup info does not work
                 lat = ~lat,
                 lng = ~lon,
                 opacity = 1,
                 radius = 5)
    })
  },#closes server
  )#closes shinyApp
}#closes function
