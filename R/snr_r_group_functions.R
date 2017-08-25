scatter_with_box <- function(xvar,yvar, xlim=NULL, ylim=NULL, xlabel=NULL, ylabel=NULL,data){
  require(ggplot2)
  require(gtable)
  
  if(is.null(xlim)){
    xlim<-range(data[names(data)==xvar])
  }
  
  if(is.null(ylim)){
    ylim<-range(data[names(data)==yvar])
  }
  
  if(is.null(xlabel)){
    xlabel<-xvar
  }
  
  if(is.null(ylabel)){
    ylabel<-yvar
  }
  
  ## Create the base scatterplot
  
  p1 <- ggplot(data = data) + 
    geom_point(aes(x = eval(parse(text = xvar)), y = eval(parse(text = yvar)))) + 
    coord_cartesian(xlim = xlim, ylim = ylim, expand = FALSE) +
    labs(x = xlabel, y = ylabel) +
    theme_bw() +
    theme(plot.margin = unit(c(0.2, 0.2, 0.5, 0.5), "lines"))
  
  # horizontal marginal boxplots
  
  p2 <- ggplot(data = data) + 
    geom_boxplot(aes(x = factor(1),y = eval(parse(text = xvar)))) + 
    geom_jitter(aes(x = factor(1),y = eval(parse(text = xvar))),position = position_jitter(width = 0.05)) + 
    # scale_y_continuous(expand = c(0, 0))  +
    coord_flip(ylim = xlim, expand = FALSE) + 
    theme_void() +
    theme(axis.text = element_blank(), 
          axis.title = element_blank(), 
          axis.ticks = element_blank(), 
          plot.margin = unit(c(1, 0.2, -0.5, 0.5), "lines"))
  
  # vertical marginal boxplots
  
  p3 <- ggplot(data = data) + 
    geom_boxplot(aes(x = factor(1),y = eval(parse(text = yvar)))) + 
    geom_jitter(aes(x = factor(1),y = eval(parse(text = yvar))), position = position_jitter(width = 0.05)) + 
    # scale_y_continuous(expand = c(0, 0)) +
    coord_cartesian( ylim = ylim, expand = FALSE) +
    theme_void() +
    theme(axis.text = element_blank(), 
          axis.title = element_blank(), 
          axis.ticks = element_blank(), 
          plot.margin = unit(c(0.2, 1, 0.5, -0.5), "lines"))
  
  
  gt1 <- ggplot_gtable(ggplot_build(p1))
  gt2 <- ggplot_gtable(ggplot_build(p2))
  gt3 <- ggplot_gtable(ggplot_build(p3))
  
  
  # Get maximum widths and heights
  maxWidth <- unit.pmax(gt1$widths[2:3], gt2$widths[2:3])
  maxHeight <- unit.pmax(gt1$heights[4:5], gt3$heights[4:5])
  
  # Set the maximums in the gtables for gt1, gt2 and gt3
  gt1$widths[2:3] <- as.list(maxWidth)
  gt2$widths[2:3] <- as.list(maxWidth)
  
  gt1$heights[4:5] <- as.list(maxHeight)
  gt3$heights[4:5] <- as.list(maxHeight)
  
  # Create a new gtable
  gt <- gtable(widths = unit(c(7, 1), "null"), height = unit(c(1, 7), "null"))
  
  # Insert gt1, gt2 and gt3 into the new gtable
  gt <- gtable_add_grob(gt, gt1, 2, 1)
  gt <- gtable_add_grob(gt, gt2, 1, 1)
  gt <- gtable_add_grob(gt, gt3, 2, 2)
  
  
  # And render the plot
  grid.newpage()
  grid.draw(gt)
  
  
}


