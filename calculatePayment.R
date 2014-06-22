calculatePayment <- function (principle, rate, duration)
{
    months <- duration*12.0
    interest <- (rate/100.0)/12.0
    payment <- (principle*interest)/(1.0 - (1.0 + interest)^(-months))
    return(payment)
}