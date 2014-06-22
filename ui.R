shinyUI(pageWithSidebar(
    headerPanel("Mortgage Calculator"),
    sidebarPanel(
        textInput('principle', 'Princlple (U.S. Dollars)',200000.00),
        textInput('interest','Interest Rate (%)',6.5),
        textInput('duration', 'Payment Period (Years)',30),
        br(),
        submitButton("Submit"),
        br(),
        textOutput("payment")
        
    ),
    mainPanel(
        plotOutput('mortagePlot')
    )
))