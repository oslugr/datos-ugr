Company = c("Company1", "Company2", "Company3") 
X2011 = c(300, 320, 310) 
X2013 = c(350, 430, 420) 
df = data.frame(Company, X2011, X2013) 

library("ggplot2")

library("reshape2")
mdf <- melt(df, id.vars="Company", value.name="value", variable.name="Year")

ggplot(data=mdf, aes(x=Year, y=value, group = Company, colour = Company)) +
  #geom_line() +
  geom_point( size=4, shape=21, fill="white")
