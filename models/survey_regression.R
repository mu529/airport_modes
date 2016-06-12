1+2
2+3

x = c(1,2,3,4)
y = c(23,19,8,39)

plot(x,y*x,typ="l")

s <- c(50,63,49,38,29,60,55)
mean(s)
var(s)
sd(s)

resp <-c(1,2,0,1)
n <- length(resp)
n

dat = read.csv("joined_jfk_responses.csv", header = TRUE)

head(dat)

mod.los <- coxph(Surv(time,status) ~ gender, data = dat)

survival::clogit(MAINMODE ~ zipcode + ODTravelTimeToAirport, dat)
