#group
library(ggplot2)
library(reshape)

library(ggplot2) #for ggplot use plotting
library(reshape) #for combining multiple variables
raw<-read.csv("separationexperiment.csv", sep=",") #Reads the data in each comma
mt<- melt(raw,id="separationLength") #Formats the data frame to rely on Person as Y axis

# for switching the order of variables present in the plot
#mz$Speed<-factor(mz$Person, levels=c("Experiment Group","Control Group"))
# pass in our Data Frame var mm and feed which data to graph
p<- ggplot(mt, aes(x=separationLength,y=value, colour=variable, shape=variable)) 
p<- p + geom_line(linetype=2) + geom_point(size = 4)
p<- p + scale_colour_discrete(labels=c("Low Priority", "High Priority")) +
        scale_shape_discrete(labels=c("Low Priority", "High Priority"))
p<- p + labs(title="")
p<- p + xlab("Separation Train Length")
p<- p + ylab("Aggregate Loss Rate (%)")
#p<- p + theme(panel.border=element_blank(),panel.grid.major=element_blank(),axis.line.x = element_line(color = "black"), axis.line.y = element_line(color="black"), text=element_text(size=25, family = "Times"))
p<- p + theme_bw() + theme(legend.title=element_blank(), legend.background=element_rect(color = "black"), axis.text.x = element_text(face = "bold", margin = margin(0,0,0,0)), axis.title.y=element_text(margin = margin(0,30,0,0)))
p <- p + theme(axis.line.x = element_line(color = "black"), axis.line.y = element_line(color="black"), text=element_text(size=25, family = "Helvetica"),axis.title.x=element_text(margin = margin(30,0,0,0)))
p<- p + scale_y_continuous(limit=c(0,100), expand = c(0,0), breaks=seq(20,100,20))
p <- p + coord_cartesian(xlimit=c(0,100))
p <- p + scale_x_continuous(breaks=seq(0,10,1), expand=c(0,0))
#p <- p + geom_vline(xintercept = 50, linetype="dashed", colour="orange") +
     #geom_text(aes(x=50, label="Low Separation Length\n",y=60,family="Helvetica",fontface="plain"), colour="red",angle=90,size=4) +
     #geom_text(aes(x =50, label="\nHigher Separation Length", y=60,family="Helvetica",fontface="plain"), colour="blue",angle=90,size=4)
p
ggsave(filename = "separationExperiment.pdf", plot = last_plot(), width=297,height=210,units="mm")