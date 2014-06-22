principleInterestData <- function(duration, payment, principle, rate)
{
    i_rate <- rate/100.0/12.0
    
    ip <- c(0)
    pl <- c(principle)
    t <- c(0)
    total_int_payed = 0
    for (i in 1:duration)
    {
        
        for (j in 1:12)
        {
            intPayed <- principle*i_rate
            principle <- principle + intPayed - payment
            total_int_payed = total_int_payed + intPayed
        }
        ip <- c(ip, total_int_payed)
        pl <- c(pl, principle) 
        t <- c(t, i)
    }
    
    df = data.frame(time=t, interest=ip, principle_left = pl)
}