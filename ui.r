shinyUI(fluidPage(
  verticalLayout(    
    plotOutput('testplot')),
  mainPanel(
    # Copy the chunk below to make a group of checkboxes
    numericInput('Prop1Quantile', label = h3("Prop1Quantile"), .5,
                 min = 0, max = .999),
    numericInput('Prop2Quantile', label = h3("Prop2Quantile"), .5,
                 min = 0, max = .999),
    numericInput('Prop3Quantile', label = h3("Prop3Quantile"), .5,
                 min = 0, max = .999),
    numericInput('Prop4Quantile', label = h3("Prop4Quantile"), .5,
                 min = 0, max = .999),
    numericInput('GovQuantile', label = h3("GovQuantile"), .04,
                 min = 0, max = 1),
    numericInput('HouseQuantile', label = h3("HouseQuantile"), .04,
                 min = 0, max = 1),
    selectInput("Gov_Can", label = h3("Gov_Can"), 
                choices = list("Walker"), 
                selected = "Walker"),
    selectInput("House_Can", label = h3("House_Can"), 
                choices = list("Young"), 
                selected = "Young")
  )
)
)