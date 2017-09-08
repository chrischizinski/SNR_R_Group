options(stringasfactor=FALSE)

library(tidyverse)

data("mpg")
head(mpg)
#Based on grammer of graphics, defined structure to all data visualization

#Multiple ways to set up plotting code
ggplot(data = mpg,aes(x=displ, y=hwy)) +
  geom_point()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy))

ggplot() +
  geom_point(data = mpg,aes(x=displ, y=hwy))
#Using themes
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy))+
  theme_bw()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy))+
  theme_minimal()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy))+
  theme_classic()
#make own theme
      #check theme file

#Change color 
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy), color ="navy")+
  theme_classic()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy), color ="#000080")+
  theme_classic()

#change size
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy), color ="#000080",size=4)+
  theme_classic()

#Change shape
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy), color ="#000080",size=4,shape=18)+
  theme_classic()

#change transparency
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy), color ="#000080",size=4,shape=18,alpha=0.25)+
  theme_classic()

#within aesthetic 
# color
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =factor(cyl)))+
  theme_classic()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =factor(cyl)))+
  scale_color_manual(values=c("red","green","blue","goldenrod"))+
  theme_classic()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =factor(cyl)))+
  scale_color_brewer(type="seq",palette="Greens")+
  theme_classic()

ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =factor(cyl)))+
  scale_color_manual(values=c('#d7191c','#fdae61','#abd9e9','#2c7bb6'))+
  theme_classic()
#wesanderson
#teamcolorcodes
#size
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =class,size=cyl))+
  theme_classic()
#shape
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =class,size=cyl,shape=drv))+
  theme_classic()

#labelling plots
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =class))+
  labs(x="Engine displacement, L",y="Highway miles per gallon, mpg",title="Highway fuel economy")+
  theme_classic()

#set axes
ggplot(data = mpg) +
  geom_point(aes(x=displ, y=hwy, color =class))+
  labs(x="Engine displacement, L",y="Highway miles per gallon, mpg",title="Highway fuel economy")+
  coord_cartesian(xlim=c(0,8),ylim=c(0,60),expand=FALSE)+
  theme_classic()

#bar plot
ggplot(data = mpg) +
  geom_bar(aes(x=class))+
  theme_classic()

ggplot(data = mpg) +
  geom_bar(aes(x=class,y=hwy),stat="identity")+
  theme_classic()

ggplot(data = mpg) +
  geom_bar(aes(x=class,y=hwy,fill=factor(cyl)),stat="identity")+
  theme_classic()

ggplot(data = mpg) +
  geom_bar(aes(x=class,y=hwy,fill=factor(cyl)),stat="identity",position="fill")+
  theme_excel()

ggplot(data = mpg) +
  geom_bar(aes(x=class,y=hwy,fill=factor(cyl)),stat="identity",position="dodge")+
  theme_classic()

#boxplot
ggplot(mpg) + 
  geom_boxplot(aes(drv, hwy))

ggplot(mpg) + 
  geom_boxplot(aes(drv, hwy))+
  geom_jitter(alpha=0.5,color="goldenrod")

#violin plot
ggplot(mpg) + 
  geom_violin(aes(drv, hwy))+
  geom_jitter(alpha=0.5,color="goldenrod")

#histogram
ggplot(mpg) + 
  geom_histogram(aes(hwy))

ggplot(mpg) + 
  geom_histogram(aes(hwy),binwidth = 10)

ggplot(mpg) + 
  geom_histogram(aes(hwy, fill = factor(cyl)),binwidth = 10)

ggplot(mpg) + 
  geom_histogram(aes(hwy, fill = factor(cyl)),binwidth = 10)+
  coord_flip()
#frequency plot
ggplot(mpg) + 
  geom_freqpoly(aes(hwy, color = factor(cyl)),binwidth = 10,lwd=2)

ggplot(mpg) + 
  geom_freqpoly(aes(hwy, color = factor(cyl)),binwidth = 10,lwd=2,lty=3)

#geom_smooth
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(method="loess")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(span = 0.5)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(method="lm")

ggplot(mpg, aes(displ, hwy)) + 
  geom_rug()+
  geom_smooth(method="lm")

#faceting
#facet wrap
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), colour = "green") +
  facet_wrap(~ class)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), colour = "green") +
  facet_wrap(~ class, ncol = 2)

#facet grid
ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ cyl)
             
ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ cyl,scales="free")

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ cyl,scales="free_x")
            
ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ cyl,space="free")   

plot<-ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = cty)) +
  facet_grid(drv ~ cyl,space="free_x",margins=TRUE)      

#saving plots
ggsave(plot,"multipanel_plot.png",width=5, height=5, units="in",dpi=300)

############################
############################
############################

#Bring dataset "diamonds"
#Look at the relationship between cut and price
#Use most appropriate geom
#Look at the relationship between cut, price, and caret
#Use most appropriate 
#Choose one and make everything look presentation quality by manipulating the themes
#Choose two geoms from the cheatsheet, that we didn't talk about and makes some plots


