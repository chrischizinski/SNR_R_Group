require(ggplot2)
require(grid)

theme_transparent <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      strip.background = element_blank(),
      strip.text.x = element_text(size = 18),
      strip.text.y = element_text(size = 18),
      axis.text.x = element_text(size=14),
      axis.text.y = element_text(size=14),
      axis.ticks =  element_line(colour = "white",size=1.5), 
      axis.title.x= element_text(size=16),
      axis.title.y= element_text(size=16,angle=90, margin=margin(0,5,0,0)),
      #legend.position = "none", 
      panel.background = element_blank(), 
      panel.border =element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.spacing = unit(1.0, "cm"), 
      plot.background = element_blank(), 
      plot.margin = unit(c(1,  1, 1, 1), "cm"),
      axis.line = element_line(colour = "white",size=1.5),
      axis.ticks.length = unit(0.30, "cm")
    )
}


theme_mine <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      strip.background = element_blank(),
      strip.text.x = element_text(size = 18,margin=margin(0,0,5,0)),
      strip.text.y = element_text(size = 18,margin=margin(0,0,0,5)),
      axis.text.x = element_text(size=14),
      axis.text.y = element_text(size=14,hjust=1),
      axis.ticks =  element_line(colour = "black"), 
      axis.title.x= element_text(size=16,margin=margin(5,0,0,0)),
      axis.title.y= element_text(size=16,angle=90, margin=margin(0,5,0,0)),
      #legend.position = "none", 
      panel.background = element_blank(), 
      panel.border =element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.spacing = unit(1.0, "cm"), 
      plot.background = element_blank(), 
      plot.margin = unit(c(1,  1, 1, 1), "cm"),
      axis.line = element_line(colour = "black")
    )
}

theme_presentation<- function(base_size = 28, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      strip.background = element_blank(),
      strip.text.x = element_text(size = 18,colour="white",margin=margin(0,0,5,0)),
      strip.text.y = element_text(size = 18,colour="white",margin=margin(0,0,0,5)),
      axis.text.x = element_text(size=28,colour="white"),
      axis.text.y = element_text(size=28,colour="white",hjust=1),
      axis.ticks =  element_line(colour = "white"), 
      axis.title.x= element_text(size=42,colour="white", margin=margin(5,0,0,0)),
      axis.title.y= element_text(size=42,angle=90,colour="white", margin=margin(0,5,0,0)),
      #legend.position = "none", 
      panel.background = element_rect(fill="black"), 
      panel.border =element_blank(),  
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.spacing = unit(1.0, "cm"), 
      plot.background = element_rect(fill="black"), 
      plot.title =element_text(size=28,colour="white"), 
      plot.margin = unit(c(1,  1, 1, 1), "cm"),
      axis.line = element_line(colour = "white"),
      legend.background=element_rect(fill='black'),
      legend.title=element_text(size=28,colour="white"),
      legend.text=element_text(size=28,colour="white"),
      legend.key = element_rect( fill = 'black')
      # legend.key.size = unit(c(1, 1), "lines")
    )
}

theme_map <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      strip.background = element_blank(),
      strip.text.x = element_text(size = 18),
      strip.text.y = element_text(size = 18),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(), 
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.background = element_blank(), 
      panel.border =element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.spacing = unit(1.0, "cm"), 
      plot.background = element_blank(), 
      plot.margin = unit(c(1,  1, 1, 1), "cm"),
      axis.line = element_blank(),
      legend.background=element_blank(),
      legend.margin = unit(0.1, "line"),
      legend.title=element_text(size=16,colour="black"),
      legend.text=element_text(size=16,colour="black",hjust=0.2),
      legend.key = element_blank(),
      legend.key.width=unit(2, "line"),
      legend.key.height=unit(2, "line"))
    
}


theme_map_presentation <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      strip.background = element_blank(),
      strip.text.x = element_text(size = 18),
      strip.text.y = element_text(size = 18),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(), 
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.background = element_blank(), 
      panel.border =element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.spacing = unit(1.0, "cm"), 
      plot.background = element_blank(), 
      plot.margin = unit(c(1,  1, 1, 1), "cm"),
      axis.line = element_blank(),
      legend.background=element_blank(),
      legend.margin = unit(0.1, "line"),
      legend.title=element_text(size=16,colour="black"),
      legend.text=element_text(size=16,colour="black",hjust=0.2),
      legend.key = element_blank(),
      legend.key.width=unit(2, "line"),
      legend.key.height=unit(2, "line"))
  
}