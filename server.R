source('calculatePayment.R')
source('principleInterestData.R')

shinyServer(
    
    function(input, output) {
        
        payment <- reactive({
            calculatePayment(
                principle <- as.numeric(input$principle),
                interest_rate <- as.numeric(input$interest),
                duration <- as.numeric(input$duration)
            )
        })
        
        output$payment <- renderText(paste("Monthly Payment: " , sprintf("%.2f",payment())))
        
        output$mortagePlot <- renderPlot({

            principle <- as.numeric(input$principle)
            interest_rate <- as.numeric(input$interest)
            duration <- as.numeric(input$duration)
            df <- principleInterestData(duration, payment(), principle, interest_rate)
            ## add extra space to right margin of plot within frame
            time <- df$time
            principle_left <- df$principle_left
            interest <- df$interest
            
            par(mar=c(5, 6, 4, 6) + 0.1)
        
            ## Plot first set of data and draw its axis
            plot(time, principle_left, pch=16, axes=FALSE, ylim=c(0,principle), xlab="", ylab="", 
                type="b",col="black", main="Payment History")
            axis(2, ylim=c(0,principle),col="black",las=1)  ## las=1 makes horizontal labels
            mtext("Principle",side=2,line=4.5)
            box()
        
            ## Allow a second plot on the same graph
            par(new=TRUE)
        
            ## Plot the second plot and put axis scale on right
            plot(time, interest, pch=15,  xlab="", ylab="", ylim=c(0,interest[duration]), 
             axes=FALSE, type="b", col="red")
            ## a little farther out (line=4) to make room for labels
            mtext("Interest",side=4,col="red",line=4) 
            axis(4, ylim=c(0,interest[duration]), col="red",col.axis="red",las=1)
        
            ## Draw the time axis
            axis(1,pretty(range(time),10))
            mtext("Time (Years)",side=1,col="black",line=2.5)  
        
            ## Add Legend
            legend("left",legend=c("Principle","Interest"),
               text.col=c("black","red"),pch=c(16,15),col=c("black","red"))
        })
        
    }
)