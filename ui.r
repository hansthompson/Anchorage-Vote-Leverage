shinyUI(fluidPage(
  verticalLayout(    
    plotOutput('testplot')),
  mainPanel(
    # Copy the chunk below to make a group of checkboxes
    sliderInput('Prop1Quantile', label = h3("Prop1Quantile"), .5,
                 min = 0, max = .999),
    sliderInput('Prop2Quantile', label = h3("Prop2Quantile"), .5,
                 min = 0, max = .999),
    sliderInput('Prop3Quantile', label = h3("Prop3Quantile"), .5,
                 min = 0, max = .999),
    sliderInput('Prop4Quantile', label = h3("Prop4Quantile"), .5,
                 min = 0, max = .999),
    selectInput("Gov_Can", label = h3("Gov_Can"), 
                choices = list("Walker","Clift", "Myers", "Parnell"), 
                selected = "Walker"),
    sliderInput('GovQuantile', label = h3("GovQuantile"), .5,
                 min = 0, max = 1),
    selectInput("House_Can", label = h3("House_Can"), 
                choices = list("Young", "McDermott", "Dunbar"), 
                selected = "Young"),
    sliderInput('HouseQuantile', label = h3("HouseQuantile"), .5,
                 min = 0, max = 1),
    selectInput("Senate_Can", label = h3("Senate_Can"), 
                choices = list("Begich", "Fish", "Gianoutsos", "Sullivan"), 
                selected = "Sullivan"),
    sliderInput('SenateQuantile', label = h3("SenateQuantile"), .5,
                min = 0, max = 1)
  )
)
)