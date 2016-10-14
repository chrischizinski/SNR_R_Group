---
title: "Web graphics"
output: html_document
tags: [R, ggvis, googleVis]
---

## Plots for the web

There has been increasing need and desirability to produce interactive graphics online.  News outlets, like the The Economist, New York Times, Vox, 538, Pew, and Quartz, routinely use interactive displays.

There are two packages (among several) that allow us to create interactive graphics.  The first is `ggivis`, which is based on `ggplot2` and the other is `googlevis`.  

ggvis follows the similar underlying theory of the grammar of graphics as ggplot2 but is expressed a little bit differently.  It incorporates aspects from `shiny` as well as `dplyr`.  

### `ggvis()`

**NOTE**:  For some reason my `ggvis` figures are not rendering and I am not 100% sure why.  If you follow along with the below R code in RStudio these will generate.  Hopefully, I can figure out what the issues are and I will update the post. 

```r
#install.packages("ggvis")

library(tidyverse)
```

```
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

```r
library(ggvis)
```

```
## 
## Attaching package: 'ggvis'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     resolution
```


Like `ggplot()`, every call to `ggvis` starts with the `ggvis()` statement.  


```r
point_plot<-mtcars %>%
            ggvis(x = ~wt, y = ~mpg) %>%
            layer_points()

view_static(point_plot)
```

<!--html_preserve--><div id="plot_696895192-container" class="ggvis-output-container">
<div id="plot_696895192" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_696895192_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_696895192" data-renderer="svg">SVG</a>
 | 
<a id="plot_696895192_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_696895192" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_696895192_download" class="ggvis-download" data-plot-id="plot_696895192">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_696895192_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "width": 600,
    "height": 400,
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0
  },
  "handlers": null
};
ggvis.getPlot("plot_696895192").parseSpec(plot_696895192_spec);
</script><!--/html_preserve-->


Like ggplot, you can mapping other visual properties like `fill`, `stroke`, `size` and `shape`.


```r
mtcars %>% ggvis(~mpg, ~disp, stroke = ~vs) %>% layer_points()
```

<!--html_preserve--><div id="plot_id563568919-container" class="ggvis-output-container">
<div id="plot_id563568919" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id563568919_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id563568919" data-renderer="svg">SVG</a>
 | 
<a id="plot_id563568919_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id563568919" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id563568919_download" class="ggvis-download" data-plot-id="plot_id563568919">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id563568919_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "vs": "number",
          "mpg": "number",
          "disp": "number"
        }
      },
      "values": "\"vs\",\"mpg\",\"disp\"\n0,21,160\n0,21,160\n1,22.8,108\n1,21.4,258\n0,18.7,360\n1,18.1,225\n0,14.3,360\n1,24.4,146.7\n1,22.8,140.8\n1,19.2,167.6\n1,17.8,167.6\n0,16.4,275.8\n0,17.3,275.8\n0,15.2,275.8\n0,10.4,472\n0,10.4,460\n0,14.7,440\n1,32.4,78.7\n1,30.4,75.7\n1,33.9,71.1\n1,21.5,120.1\n0,15.5,318\n0,15.2,304\n0,13.3,350\n0,19.2,400\n1,27.3,79\n0,26,120.3\n1,30.4,95.1\n0,15.8,351\n0,19.7,145\n0,15,301\n1,21.4,121"
    },
    {
      "name": "scale/stroke",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n1"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n51.055\n492.045"
    }
  ],
  "scales": [
    {
      "name": "stroke",
      "domain": {
        "data": "scale/stroke",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": ["#132B43", "#56B1F7"]
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.vs"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.disp"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "stroke": "stroke",
      "title": "vs"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "disp"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id563568919").parseSpec(plot_id563568919_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~mpg, ~disp, fill = ~vs) %>% layer_points()
```

<!--html_preserve--><div id="plot_id433288584-container" class="ggvis-output-container">
<div id="plot_id433288584" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id433288584_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id433288584" data-renderer="svg">SVG</a>
 | 
<a id="plot_id433288584_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id433288584" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id433288584_download" class="ggvis-download" data-plot-id="plot_id433288584">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id433288584_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "vs": "number",
          "mpg": "number",
          "disp": "number"
        }
      },
      "values": "\"vs\",\"mpg\",\"disp\"\n0,21,160\n0,21,160\n1,22.8,108\n1,21.4,258\n0,18.7,360\n1,18.1,225\n0,14.3,360\n1,24.4,146.7\n1,22.8,140.8\n1,19.2,167.6\n1,17.8,167.6\n0,16.4,275.8\n0,17.3,275.8\n0,15.2,275.8\n0,10.4,472\n0,10.4,460\n0,14.7,440\n1,32.4,78.7\n1,30.4,75.7\n1,33.9,71.1\n1,21.5,120.1\n0,15.5,318\n0,15.2,304\n0,13.3,350\n0,19.2,400\n1,27.3,79\n0,26,120.3\n1,30.4,95.1\n0,15.8,351\n0,19.7,145\n0,15,301\n1,21.4,121"
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n1"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n51.055\n492.045"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": ["#132B43", "#56B1F7"]
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "scale": "fill",
            "field": "data.vs"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.disp"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "fill": "fill",
      "title": "vs"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "disp"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id433288584").parseSpec(plot_id433288584_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~mpg, ~disp, size = ~vs) %>% layer_points()
```

<!--html_preserve--><div id="plot_id105126653-container" class="ggvis-output-container">
<div id="plot_id105126653" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id105126653_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id105126653" data-renderer="svg">SVG</a>
 | 
<a id="plot_id105126653_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id105126653" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id105126653_download" class="ggvis-download" data-plot-id="plot_id105126653">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id105126653_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "vs": "number",
          "mpg": "number",
          "disp": "number"
        }
      },
      "values": "\"vs\",\"mpg\",\"disp\"\n0,21,160\n0,21,160\n1,22.8,108\n1,21.4,258\n0,18.7,360\n1,18.1,225\n0,14.3,360\n1,24.4,146.7\n1,22.8,140.8\n1,19.2,167.6\n1,17.8,167.6\n0,16.4,275.8\n0,17.3,275.8\n0,15.2,275.8\n0,10.4,472\n0,10.4,460\n0,14.7,440\n1,32.4,78.7\n1,30.4,75.7\n1,33.9,71.1\n1,21.5,120.1\n0,15.5,318\n0,15.2,304\n0,13.3,350\n0,19.2,400\n1,27.3,79\n0,26,120.3\n1,30.4,95.1\n0,15.8,351\n0,19.7,145\n0,15,301\n1,21.4,121"
    },
    {
      "name": "scale/size",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n1"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n51.055\n492.045"
    }
  ],
  "scales": [
    {
      "name": "size",
      "domain": {
        "data": "scale/size",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": [20, 100]
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "scale": "size",
            "field": "data.vs"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.disp"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "size": "size",
      "title": "vs"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "disp"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id105126653").parseSpec(plot_id105126653_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~mpg, ~disp, shape = ~factor(cyl)) %>% layer_points()
```

<!--html_preserve--><div id="plot_id610159841-container" class="ggvis-output-container">
<div id="plot_id610159841" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id610159841_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id610159841" data-renderer="svg">SVG</a>
 | 
<a id="plot_id610159841_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id610159841" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id610159841_download" class="ggvis-download" data-plot-id="plot_id610159841">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id610159841_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "mpg": "number",
          "disp": "number"
        }
      },
      "values": "\"factor(cyl)\",\"mpg\",\"disp\"\n\"6\",21,160\n\"6\",21,160\n\"4\",22.8,108\n\"6\",21.4,258\n\"8\",18.7,360\n\"6\",18.1,225\n\"8\",14.3,360\n\"4\",24.4,146.7\n\"4\",22.8,140.8\n\"6\",19.2,167.6\n\"6\",17.8,167.6\n\"8\",16.4,275.8\n\"8\",17.3,275.8\n\"8\",15.2,275.8\n\"8\",10.4,472\n\"8\",10.4,460\n\"8\",14.7,440\n\"4\",32.4,78.7\n\"4\",30.4,75.7\n\"4\",33.9,71.1\n\"4\",21.5,120.1\n\"8\",15.5,318\n\"8\",15.2,304\n\"8\",13.3,350\n\"8\",19.2,400\n\"4\",27.3,79\n\"4\",26,120.3\n\"4\",30.4,95.1\n\"8\",15.8,351\n\"6\",19.7,145\n\"8\",15,301\n\"4\",21.4,121"
    },
    {
      "name": "scale/shape",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n51.055\n492.045"
    }
  ],
  "scales": [
    {
      "name": "shape",
      "type": "ordinal",
      "domain": {
        "data": "scale/shape",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "shapes"
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "shape": {
            "scale": "shape",
            "field": "data.factor(cyl)"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.disp"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "shape": "shape",
      "title": "factor(cyl)"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "disp"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id610159841").parseSpec(plot_id610159841_spec);
</script><!--/html_preserve-->

Unlike ggplot, you specify points a fixed colour or size, you need to use `:=` instead of `=`. The `:=` operator means to use a raw, unscaled value. 


```r
mtcars %>% ggvis(~wt, ~mpg, fill := "black", stroke := "firebrick") %>% layer_points()
```

<!--html_preserve--><div id="plot_id957164260-container" class="ggvis-output-container">
<div id="plot_id957164260" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id957164260_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id957164260" data-renderer="svg">SVG</a>
 | 
<a id="plot_id957164260_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id957164260" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id957164260_download" class="ggvis-download" data-plot-id="plot_id957164260">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id957164260_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "value": "black"
          },
          "stroke": {
            "value": "firebrick"
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id957164260").parseSpec(plot_id957164260_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~wt, ~mpg, size := 400, opacity := 0.25) %>% layer_points()
```

<!--html_preserve--><div id="plot_id456025374-container" class="ggvis-output-container">
<div id="plot_id456025374" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id456025374_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id456025374" data-renderer="svg">SVG</a>
 | 
<a id="plot_id456025374_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id456025374" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id456025374_download" class="ggvis-download" data-plot-id="plot_id456025374">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id456025374_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 400
          },
          "opacity": {
            "value": 0.25
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id456025374").parseSpec(plot_id456025374_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~wt, ~mpg, size := 100, shape := "square") %>% layer_points()
```

<!--html_preserve--><div id="plot_id931136045-container" class="ggvis-output-container">
<div id="plot_id931136045" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id931136045_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id931136045" data-renderer="svg">SVG</a>
 | 
<a id="plot_id931136045_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id931136045" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id931136045_download" class="ggvis-download" data-plot-id="plot_id931136045">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id931136045_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 100
          },
          "shape": {
            "value": "square"
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id931136045").parseSpec(plot_id931136045_spec);
</script><!--/html_preserve-->

### Layers

- Points, `layer_points()`, with properties `x`, `y`, `shape`, `stroke`, `fill`, `strokeOpacity`, `fillOpacity`, and `opacity`.


```r
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()
```

<!--html_preserve--><div id="plot_id656574773-container" class="ggvis-output-container">
<div id="plot_id656574773" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id656574773_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id656574773" data-renderer="svg">SVG</a>
 | 
<a id="plot_id656574773_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id656574773" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id656574773_download" class="ggvis-download" data-plot-id="plot_id656574773">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id656574773_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id656574773").parseSpec(plot_id656574773_spec);
</script><!--/html_preserve-->

- Paths and polygons, `layer_paths()`


```r
set.seed(12345)

df <- data.frame(x = 1:20, y = runif(20))
df %>% ggvis(~x, ~y) %>% layer_paths()
```

<!--html_preserve--><div id="plot_id508355265-container" class="ggvis-output-container">
<div id="plot_id508355265" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id508355265_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id508355265" data-renderer="svg">SVG</a>
 | 
<a id="plot_id508355265_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id508355265" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id508355265_download" class="ggvis-download" data-plot-id="plot_id508355265">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id508355265_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\"\n1,0.720903896261007\n2,0.875773193081841\n3,0.760982328327373\n4,0.886124566197395\n5,0.456480960128829\n6,0.166371785104275\n7,0.325095386710018\n8,0.509224335663021\n9,0.727705253753811\n10,0.989736937917769\n11,0.0345354350283742\n12,0.152373490156606\n13,0.735684952465817\n14,0.00113658653572202\n15,0.391203335253522\n16,0.462494654115289\n17,0.388143981574103\n18,0.402485141763464\n19,0.178963584825397\n20,0.951658753678203"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.0499999999999999\n20.95"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.0482934310333803\n1.03916695548687"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id508355265").parseSpec(plot_id508355265_spec);
</script><!--/html_preserve-->


If you add `fill`, you will get a polygon.


```r
vals<-rbind(data.frame(x = 1:10, y = 1),
      data.frame(x = 1:10, y = 3),
      data.frame(x = 1, y = 1:3),
      data.frame(x = 10, y = 1:3))

vals %>% ggvis(~x, ~y) %>% layer_paths(fill := "pink")
```

<!--html_preserve--><div id="plot_id394077167-container" class="ggvis-output-container">
<div id="plot_id394077167" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id394077167_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id394077167" data-renderer="svg">SVG</a>
 | 
<a id="plot_id394077167_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id394077167" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id394077167_download" class="ggvis-download" data-plot-id="plot_id394077167">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id394077167_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\"\n1,1\n2,1\n3,1\n4,1\n5,1\n6,1\n7,1\n8,1\n9,1\n10,1\n1,3\n2,3\n3,3\n4,3\n5,3\n6,3\n7,3\n8,3\n9,3\n10,3\n1,1\n1,2\n1,3\n10,1\n10,2\n10,3"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.55\n10.45"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.9\n3.1"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "fill": {
            "value": "pink"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id394077167").parseSpec(plot_id394077167_spec);
</script><!--/html_preserve-->


- Filled areas, `layer_ribbons()`. Use properties `y` and `y2` to control the extent of the area.


```r
df %>% ggvis(~x, ~y) %>% layer_ribbons(fill:="green", opacity:=0.3)
```

<!--html_preserve--><div id="plot_id968873790-container" class="ggvis-output-container">
<div id="plot_id968873790" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id968873790_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id968873790" data-renderer="svg">SVG</a>
 | 
<a id="plot_id968873790_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id968873790" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id968873790_download" class="ggvis-download" data-plot-id="plot_id968873790">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id968873790_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\"\n1,0.720903896261007\n2,0.875773193081841\n3,0.760982328327373\n4,0.886124566197395\n5,0.456480960128829\n6,0.166371785104275\n7,0.325095386710018\n8,0.509224335663021\n9,0.727705253753811\n10,0.989736937917769\n11,0.0345354350283742\n12,0.152373490156606\n13,0.735684952465817\n14,0.00113658653572202\n15,0.391203335253522\n16,0.462494654115289\n17,0.388143981574103\n18,0.402485141763464\n19,0.178963584825397\n20,0.951658753678203"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.0499999999999999\n20.95"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.0482934310333803\n1.03916695548687"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "area",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "fill": {
            "value": "green"
          },
          "opacity": {
            "value": 0.3
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id968873790").parseSpec(plot_id968873790_spec);
</script><!--/html_preserve-->

```r
df %>% ggvis(~x, ~y + 0.25, y2 = ~y - 0.25) %>% layer_ribbons(fill:="green", opacity:=0.3)
```

<!--html_preserve--><div id="plot_id736733688-container" class="ggvis-output-container">
<div id="plot_id736733688" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id736733688_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id736733688" data-renderer="svg">SVG</a>
 | 
<a id="plot_id736733688_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id736733688" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id736733688_download" class="ggvis-download" data-plot-id="plot_id736733688">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id736733688_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "y - 0.25": "number",
          "x": "number",
          "y + 0.25": "number"
        }
      },
      "values": "\"y - 0.25\",\"x\",\"y + 0.25\"\n0.470903896261007,1,0.970903896261007\n0.625773193081841,2,1.12577319308184\n0.510982328327373,3,1.01098232832737\n0.636124566197395,4,1.1361245661974\n0.206480960128829,5,0.706480960128829\n-0.0836282148957253,6,0.416371785104275\n0.0750953867100179,7,0.575095386710018\n0.259224335663021,8,0.759224335663021\n0.477705253753811,9,0.977705253753811\n0.739736937917769,10,1.23973693791777\n-0.215464564971626,11,0.284535435028374\n-0.0976265098433942,12,0.402373490156606\n0.485684952465817,13,0.985684952465817\n-0.248863413464278,14,0.251136586535722\n0.141203335253522,15,0.641203335253522\n0.212494654115289,16,0.712494654115289\n0.138143981574103,17,0.638143981574103\n0.152485141763464,18,0.652485141763464\n-0.0710364151746035,19,0.428963584825397\n0.701658753678203,20,1.2016587536782"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.0499999999999999\n20.95"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.32329343103338\n1.31416695548687"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "area",
      "properties": {
        "update": {
          "y2": {
            "scale": "y",
            "field": "data.y - 0\\.25"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y + 0\\.25"
          },
          "fill": {
            "value": "green"
          },
          "opacity": {
            "value": 0.3
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y + 0.25"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id736733688").parseSpec(plot_id736733688_spec);
</script><!--/html_preserve-->

- Rectangles, `layer_rects()`. The location and size of the rectangle is controlled by the `x`, `x2`, `y` and `y2` properties.


```r
set.seed(12345)
df <- data.frame(x1 = runif(2), x2 = runif(2), y1 = runif(2), y2 = runif(2))

df %>% ggvis(~x1, ~y1, x2 = ~x2, y2 = ~y2, fillOpacity := 0.55, fill:= "blue") %>% layer_rects()
```

<!--html_preserve--><div id="plot_id754934727-container" class="ggvis-output-container">
<div id="plot_id754934727" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id754934727_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id754934727" data-renderer="svg">SVG</a>
 | 
<a id="plot_id754934727_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id754934727" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id754934727_download" class="ggvis-download" data-plot-id="plot_id754934727">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id754934727_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x2": "number",
          "y2": "number",
          "x1": "number",
          "y1": "number"
        }
      },
      "values": "\"x2\",\"y2\",\"x1\",\"y1\"\n0.760982328327373,0.325095386710018,0.720903896261007,0.456480960128829\n0.886124566197395,0.509224335663021,0.875773193081841,0.166371785104275"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.712642862764187\n0.894385599694215"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.149229157576337\n0.526366963190958"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "rect",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x2": {
            "scale": "x",
            "field": "data.x2"
          },
          "y2": {
            "scale": "y",
            "field": "data.y2"
          },
          "fillOpacity": {
            "value": 0.55
          },
          "fill": {
            "value": "blue"
          },
          "x": {
            "scale": "x",
            "field": "data.x1"
          },
          "y": {
            "scale": "y",
            "field": "data.y1"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x1"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y1"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id754934727").parseSpec(plot_id754934727_spec);
</script><!--/html_preserve-->

- Text, `layer_text()`. Many options to control the apperance of the text: `text` (the label), `dx` and `dy` (margin in pixels between text and anchor point), `angle` (rotate the text), `font` (font name), `fontSize` (size in pixels), `fontWeight` (bold or normal), and `fontStyle` (e.g. italic or normal)


```r
df2 <- data.frame(x = 4:1, y = c(1, 3, 2,4), label = c("a", "b", "c", "d"))

df2 %>% ggvis(~x, ~y, text := ~label) %>% layer_text()
```

<!--html_preserve--><div id="plot_id990763243-container" class="ggvis-output-container">
<div id="plot_id990763243" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id990763243_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id990763243" data-renderer="svg">SVG</a>
 | 
<a id="plot_id990763243_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id990763243" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id990763243_download" class="ggvis-download" data-plot-id="plot_id990763243">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id990763243_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"label\",\"x\",\"y\"\n\"a\",4,1\n\"b\",3,3\n\"c\",2,2\n\"d\",1,4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.85\n4.15"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.85\n4.15"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "text",
      "properties": {
        "update": {
          "fill": {
            "value": "#333333"
          },
          "text": {
            "field": "data.label"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id990763243").parseSpec(plot_id990763243_spec);
</script><!--/html_preserve-->

```r
df2 %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 50, fontWeight:= "bold", angle:= 45)
```

<!--html_preserve--><div id="plot_id131081891-container" class="ggvis-output-container">
<div id="plot_id131081891" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id131081891_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id131081891" data-renderer="svg">SVG</a>
 | 
<a id="plot_id131081891_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id131081891" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id131081891_download" class="ggvis-download" data-plot-id="plot_id131081891">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id131081891_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"label\",\"x\",\"y\"\n\"a\",4,1\n\"b\",3,3\n\"c\",2,2\n\"d\",1,4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.85\n4.15"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.85\n4.15"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "text",
      "properties": {
        "update": {
          "fill": {
            "value": "#333333"
          },
          "text": {
            "field": "data.label"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "fontSize": {
            "value": 50
          },
          "fontWeight": {
            "value": "bold"
          },
          "angle": {
            "value": 45
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id131081891").parseSpec(plot_id131081891_spec);
</script><!--/html_preserve-->

### Compound layers

- `layer_lines()`  automatically orders by the x variable:


```r
t <- seq(0, 2 * pi, length = 20)

df3 <- data.frame(x = sin(t), y = cos(t))

df3 %>% ggvis(~x, ~y) %>% layer_paths()
```

<!--html_preserve--><div id="plot_id237136140-container" class="ggvis-output-container">
<div id="plot_id237136140" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id237136140_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id237136140" data-renderer="svg">SVG</a>
 | 
<a id="plot_id237136140_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id237136140" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id237136140_download" class="ggvis-download" data-plot-id="plot_id237136140">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id237136140_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\"\n0,1\n0.324699469204683,0.945817241700635\n0.614212712689668,0.789140509396394\n0.837166478262529,0.546948158122427\n0.96940026593933,0.245485487140799\n0.99658449300667,-0.0825793454723323\n0.915773326655058,-0.401695424652969\n0.735723910673132,-0.677281571625741\n0.475947393037074,-0.879473751206489\n0.164594590280734,-0.986361303402722\n-0.164594590280734,-0.986361303402722\n-0.475947393037074,-0.879473751206489\n-0.735723910673131,-0.677281571625741\n-0.915773326655057,-0.40169542465297\n-0.99658449300667,-0.0825793454723327\n-0.96940026593933,0.245485487140799\n-0.837166478262529,0.546948158122427\n-0.614212712689668,0.789140509396393\n-0.324699469204684,0.945817241700635\n-2.44929359829471e-16,1"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-1.09624294230734\n1.09624294230734"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-1.08567936857286\n1.09931806517014"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id237136140").parseSpec(plot_id237136140_spec);
</script><!--/html_preserve-->

```r
df3 %>% ggvis(~x, ~y) %>% layer_lines()
```

<!--html_preserve--><div id="plot_id762116456-container" class="ggvis-output-container">
<div id="plot_id762116456" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id762116456_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id762116456" data-renderer="svg">SVG</a>
 | 
<a id="plot_id762116456_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id762116456" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id762116456_download" class="ggvis-download" data-plot-id="plot_id762116456">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id762116456_spec = {
  "data": [
    {
      "name": ".0/arrange1",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\"\n-0.99658449300667,-0.0825793454723327\n-0.96940026593933,0.245485487140799\n-0.915773326655057,-0.40169542465297\n-0.837166478262529,0.546948158122427\n-0.735723910673131,-0.677281571625741\n-0.614212712689668,0.789140509396393\n-0.475947393037074,-0.879473751206489\n-0.324699469204684,0.945817241700635\n-0.164594590280734,-0.986361303402722\n-2.44929359829471e-16,1\n0,1\n0.164594590280734,-0.986361303402722\n0.324699469204683,0.945817241700635\n0.475947393037074,-0.879473751206489\n0.614212712689668,0.789140509396394\n0.735723910673132,-0.677281571625741\n0.837166478262529,0.546948158122427\n0.915773326655058,-0.401695424652969\n0.96940026593933,0.245485487140799\n0.99658449300667,-0.0825793454723323"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-1.09624294230734\n1.09624294230734"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-1.08567936857286\n1.09931806517014"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/arrange1"
          }
        }
      },
      "from": {
        "data": ".0/arrange1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "y"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id762116456").parseSpec(plot_id762116456_spec);
</script><!--/html_preserve-->

- `layer_histograms()` and `layer_freqpolys()` first bin the data with `compute_bin()` and then display the results with either rects or lines.


```r
mtcars %>% ggvis(~mpg) %>% layer_histograms(fill:= "red")
```

```
## Guessing width = 1 # range / 24
```

<!--html_preserve--><div id="plot_id101022927-container" class="ggvis-output-container">
<div id="plot_id101022927" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id101022927_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id101022927" data-renderer="svg">SVG</a>
 | 
<a id="plot_id101022927_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id101022927" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id101022927_download" class="ggvis-download" data-plot-id="plot_id101022927">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id101022927_spec = {
  "data": [
    {
      "name": ".0/bin1/stack2",
      "format": {
        "type": "csv",
        "parse": {
          "xmin_": "number",
          "xmax_": "number",
          "stack_upr_": "number",
          "stack_lwr_": "number"
        }
      },
      "values": "\"xmin_\",\"xmax_\",\"stack_upr_\",\"stack_lwr_\"\n9.5,10.5,2,0\n10.5,11.5,0,0\n11.5,12.5,0,0\n12.5,13.5,1,0\n13.5,14.5,1,0\n14.5,15.5,5,0\n15.5,16.5,2,0\n16.5,17.5,1,0\n17.5,18.5,2,0\n18.5,19.5,3,0\n19.5,20.5,1,0\n20.5,21.5,5,0\n21.5,22.5,0,0\n22.5,23.5,2,0\n23.5,24.5,1,0\n24.5,25.5,0,0\n25.5,26.5,1,0\n26.5,27.5,1,0\n27.5,28.5,0,0\n28.5,29.5,0,0\n29.5,30.5,2,0\n30.5,31.5,0,0\n31.5,32.5,1,0\n32.5,33.5,0,0\n33.5,34.5,1,0"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n8.25\n35.75"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n5.25"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "rect",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "fill": {
            "value": "red"
          },
          "x": {
            "scale": "x",
            "field": "data.xmin_"
          },
          "x2": {
            "scale": "x",
            "field": "data.xmax_"
          },
          "y": {
            "scale": "y",
            "field": "data.stack_upr_"
          },
          "y2": {
            "scale": "y",
            "field": "data.stack_lwr_"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/bin1/stack2"
          }
        }
      },
      "from": {
        "data": ".0/bin1/stack2"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "count"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id101022927").parseSpec(plot_id101022927_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~mpg) %>% layer_freqpolys(fill:= "red")
```

```
## Guessing width = 1 # range / 24
```

<!--html_preserve--><div id="plot_id452083001-container" class="ggvis-output-container">
<div id="plot_id452083001" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id452083001_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id452083001" data-renderer="svg">SVG</a>
 | 
<a id="plot_id452083001_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id452083001" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id452083001_download" class="ggvis-download" data-plot-id="plot_id452083001">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id452083001_spec = {
  "data": [
    {
      "name": ".0/bin1",
      "format": {
        "type": "csv",
        "parse": {
          "x_": "number",
          "count_": "number"
        }
      },
      "values": "\"x_\",\"count_\"\n9,0\n10,2\n11,0\n12,0\n13,1\n14,1\n15,5\n16,2\n17,1\n18,2\n19,3\n20,1\n21,5\n22,0\n23,2\n24,1\n25,0\n26,1\n27,1\n28,0\n29,0\n30,2\n31,0\n32,1\n33,0\n34,1\n35,0"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n7.7\n36.3"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.25\n5.25"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "fill": {
            "value": "red"
          },
          "x": {
            "scale": "x",
            "field": "data.x_"
          },
          "y": {
            "scale": "y",
            "field": "data.count_"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/bin1"
          }
        }
      },
      "from": {
        "data": ".0/bin1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "count"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id452083001").parseSpec(plot_id452083001_spec);
</script><!--/html_preserve-->

- `layer_smooths()` fits a smooth model to the data, and displays predictions with a line


```r
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()
```

<!--html_preserve--><div id="plot_id516245188-container" class="ggvis-output-container">
<div id="plot_id516245188" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id516245188_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id516245188" data-renderer="svg">SVG</a>
 | 
<a id="plot_id516245188_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id516245188" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id516245188_download" class="ggvis-download" data-plot-id="plot_id516245188">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id516245188_spec = {
  "data": [
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.08897233857\n1.56250632911392,31.6878645869701\n1.61201265822785,31.2816303797919\n1.66151898734177,30.8703709543688\n1.7110253164557,30.4541875480347\n1.76053164556962,30.0331813981232\n1.81003797468354,29.6074537419678\n1.85954430379747,29.1771058169022\n1.90905063291139,28.7422388602601\n1.95855696202532,28.3001719301537\n2.00806329113924,27.834621969428\n2.05756962025316,27.3476575600419\n2.10707594936709,26.84497968394\n2.15658227848101,26.3322893230667\n2.20608860759494,25.8152874593666\n2.25559493670886,25.2996750747841\n2.30510126582278,24.7911531512637\n2.35460759493671,24.29542267075\n2.40411392405063,23.8181846151875\n2.45362025316456,23.3651399665205\n2.50312658227848,22.955253039598\n2.55263291139241,22.6138488714952\n2.60213924050633,22.3275852300224\n2.65164556962025,22.0817586181852\n2.70115189873418,21.8616655389892\n2.7506582278481,21.65260249544\n2.80016455696203,21.4398659905432\n2.84967088607595,21.2087525273044\n2.89917721518987,20.953335722037\n2.9486835443038,20.7158424594628\n2.99818987341772,20.4957065225374\n3.04769620253165,20.2829337645837\n3.09720253164557,20.0675300389245\n3.14670886075949,19.8395011988825\n3.19621518987342,19.5888530977805\n3.24572151898734,19.2971559094315\n3.29522784810127,18.9444093670088\n3.34473417721519,18.5670026794964\n3.39424050632911,18.2056968860288\n3.44374683544304,17.9009022641924\n3.49325316455696,17.620602502374\n3.54275949367089,17.3400153015964\n3.59226582278481,17.079077805285\n3.64177215189873,16.8175887231322\n3.69127848101266,16.5575726926136\n3.74078481012658,16.3083303048321\n3.79029113924051,16.0791621508901\n3.83979746835443,15.8793688218903\n3.88930379746835,15.7018119854881\n3.93881012658228,15.5259429561214\n3.9883164556962,15.3517253848296\n4.03782278481013,15.1793328075288\n4.08732911392405,15.0089387601353\n4.13683544303798,14.8407167785652\n4.1863417721519,14.6748403987346\n4.23584810126582,14.5114831565596\n4.28535443037975,14.3508185879563\n4.33486075949367,14.193020228841\n4.3843670886076,14.0382616151298\n4.43387341772152,13.8867162827388\n4.48337974683544,13.7385577675841\n4.53288607594937,13.5939596055819\n4.58239240506329,13.4530953326483\n4.63189873417722,13.3161384846995\n4.68140506329114,13.1832625976516\n4.73091139240506,13.0546412074207\n4.78041772151899,12.930447849923\n4.82992405063291,12.8108560610747\n4.87943037974684,12.6960393767918\n4.92893670886076,12.5861713329905\n4.97844303797468,12.4814254655869\n5.02794936708861,12.3819753104973\n5.07745569620253,12.2879944036376\n5.12696202531646,12.1996562809241\n5.17646835443038,12.117134478273\n5.2259746835443,12.0406025316002\n5.27548101265823,11.9702339768221\n5.32498734177215,11.9062023498547\n5.37449367088608,11.8486811866141\n5.424,11.7978440230166"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n10.7832876072389\n33.1035287543477"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id516245188").parseSpec(plot_id516245188_spec);
</script><!--/html_preserve-->

### Multiple layers

Like `ggplot2` we can combine multiple layers together.  


```r
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points %>% layer_smooths()
```

<!--html_preserve--><div id="plot_id449329583-container" class="ggvis-output-container">
<div id="plot_id449329583" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id449329583_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id449329583" data-renderer="svg">SVG</a>
 | 
<a id="plot_id449329583_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id449329583" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id449329583_download" class="ggvis-download" data-plot-id="plot_id449329583">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id449329583_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.08897233857\n1.56250632911392,31.6878645869701\n1.61201265822785,31.2816303797919\n1.66151898734177,30.8703709543688\n1.7110253164557,30.4541875480347\n1.76053164556962,30.0331813981232\n1.81003797468354,29.6074537419678\n1.85954430379747,29.1771058169022\n1.90905063291139,28.7422388602601\n1.95855696202532,28.3001719301537\n2.00806329113924,27.834621969428\n2.05756962025316,27.3476575600419\n2.10707594936709,26.84497968394\n2.15658227848101,26.3322893230667\n2.20608860759494,25.8152874593666\n2.25559493670886,25.2996750747841\n2.30510126582278,24.7911531512637\n2.35460759493671,24.29542267075\n2.40411392405063,23.8181846151875\n2.45362025316456,23.3651399665205\n2.50312658227848,22.955253039598\n2.55263291139241,22.6138488714952\n2.60213924050633,22.3275852300224\n2.65164556962025,22.0817586181852\n2.70115189873418,21.8616655389892\n2.7506582278481,21.65260249544\n2.80016455696203,21.4398659905432\n2.84967088607595,21.2087525273044\n2.89917721518987,20.953335722037\n2.9486835443038,20.7158424594628\n2.99818987341772,20.4957065225374\n3.04769620253165,20.2829337645837\n3.09720253164557,20.0675300389245\n3.14670886075949,19.8395011988825\n3.19621518987342,19.5888530977805\n3.24572151898734,19.2971559094315\n3.29522784810127,18.9444093670088\n3.34473417721519,18.5670026794964\n3.39424050632911,18.2056968860288\n3.44374683544304,17.9009022641924\n3.49325316455696,17.620602502374\n3.54275949367089,17.3400153015964\n3.59226582278481,17.079077805285\n3.64177215189873,16.8175887231322\n3.69127848101266,16.5575726926136\n3.74078481012658,16.3083303048321\n3.79029113924051,16.0791621508901\n3.83979746835443,15.8793688218903\n3.88930379746835,15.7018119854881\n3.93881012658228,15.5259429561214\n3.9883164556962,15.3517253848296\n4.03782278481013,15.1793328075288\n4.08732911392405,15.0089387601353\n4.13683544303798,14.8407167785652\n4.1863417721519,14.6748403987346\n4.23584810126582,14.5114831565596\n4.28535443037975,14.3508185879563\n4.33486075949367,14.193020228841\n4.3843670886076,14.0382616151298\n4.43387341772152,13.8867162827388\n4.48337974683544,13.7385577675841\n4.53288607594937,13.5939596055819\n4.58239240506329,13.4530953326483\n4.63189873417722,13.3161384846995\n4.68140506329114,13.1832625976516\n4.73091139240506,13.0546412074207\n4.78041772151899,12.930447849923\n4.82992405063291,12.8108560610747\n4.87943037974684,12.6960393767918\n4.92893670886076,12.5861713329905\n4.97844303797468,12.4814254655869\n5.02794936708861,12.3819753104973\n5.07745569620253,12.2879944036376\n5.12696202531646,12.1996562809241\n5.17646835443038,12.117134478273\n5.2259746835443,12.0406025316002\n5.27548101265823,11.9702339768221\n5.32498734177215,11.9062023498547\n5.37449367088608,11.8486811866141\n5.424,11.7978440230166"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id449329583").parseSpec(plot_id449329583_spec);
</script><!--/html_preserve-->

```r
mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_points %>% 
  layer_smooths(span = 1) %>%
  layer_smooths(span = 0.5, stroke := "red")
```

<!--html_preserve--><div id="plot_id462236627-container" class="ggvis-output-container">
<div id="plot_id462236627" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id462236627_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id462236627" data-renderer="svg">SVG</a>
 | 
<a id="plot_id462236627_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id462236627" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id462236627_download" class="ggvis-download" data-plot-id="plot_id462236627">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id462236627_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.3559076033652\n1.56250632911392,31.8753059433938\n1.61201265822785,31.4002837186303\n1.66151898734177,30.9307786143783\n1.7110253164557,30.4667283159411\n1.76053164556962,30.0080705086221\n1.81003797468354,29.5547428777247\n1.85954430379747,29.1066831085523\n1.90905063291139,28.6638288864083\n1.95855696202532,28.2261593300757\n2.00806329113924,27.7939085521993\n2.05756962025316,27.3671227416083\n2.10707594936709,26.9458006046978\n2.15658227848101,26.5299408478625\n2.20608860759494,26.1195421774975\n2.25559493670886,25.7146032999975\n2.30510126582278,25.3151229217576\n2.35460759493671,24.9210997491726\n2.40411392405063,24.5325324886374\n2.45362025316456,24.1494198465469\n2.50312658227848,23.7704013112288\n2.55263291139241,23.3930410310992\n2.60213924050633,23.0184854507692\n2.65164556962025,22.648013375053\n2.70115189873418,22.2829036087647\n2.7506582278481,21.9244349567186\n2.80016455696203,21.5738862237289\n2.84967088607595,21.2325362146096\n2.89917721518987,20.8994648774453\n2.9486835443038,20.563314278298\n2.99818987341772,20.2260322794124\n3.04769620253165,19.8921207313051\n3.09720253164557,19.5660814844932\n3.14670886075949,19.2524163894935\n3.19621518987342,18.9556272968227\n3.24572151898734,18.6776819657173\n3.29522784810127,18.4109241123963\n3.34473417721519,18.1533810871694\n3.39424050632911,17.9038917888661\n3.44374683544304,17.6613801039195\n3.49325316455696,17.4367412601373\n3.54275949367089,17.2198928657746\n3.59226582278481,16.9885817927012\n3.64177215189873,16.7560619903523\n3.69127848101266,16.5274875375278\n3.74078481012658,16.3032371340526\n3.79029113924051,16.0836894797512\n3.83979746835443,15.8692232744485\n3.88930379746835,15.6600927173047\n3.93881012658228,15.4562638006676\n3.9883164556962,15.2577332064667\n4.03782278481013,15.064498632161\n4.08732911392405,14.8765577752094\n4.13683544303798,14.6939083330709\n4.1863417721519,14.5165480032044\n4.23584810126582,14.344474483069\n4.28535443037975,14.1776854701235\n4.33486075949367,14.016178661827\n4.3843670886076,13.8599517556385\n4.43387341772152,13.7090024490167\n4.48337974683544,13.5633284394209\n4.53288607594937,13.4229274243098\n4.58239240506329,13.2877971011425\n4.63189873417722,13.157935167378\n4.68140506329114,13.0333393204751\n4.73091139240506,12.9140072578929\n4.78041772151899,12.7999366770903\n4.82992405063291,12.6911252755264\n4.87943037974684,12.58757075066\n4.92893670886076,12.4892707999501\n4.97844303797468,12.3962231208557\n5.02794936708861,12.3084254108357\n5.07745569620253,12.2258753673492\n5.12696202531646,12.148570687855\n5.17646835443038,12.0765090698122\n5.2259746835443,12.0096882106797\n5.27548101265823,11.9481058079165\n5.32498734177215,11.8917595589815\n5.37449367088608,11.8406471613337\n5.424,11.7947663124321"
    },
    {
      "name": ".0/model_prediction2",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,31.1578692505819\n1.56250632911392,31.0986698802032\n1.61201265822785,30.9960250236674\n1.66151898734177,30.8383424549115\n1.7110253164557,30.6393840227985\n1.76053164556962,30.402462560398\n1.81003797468354,30.1308363791107\n1.85954430379747,29.8277637903378\n1.90905063291139,29.4965031054802\n1.95855696202532,29.1340918645825\n2.00806329113924,28.708615118389\n2.05756962025316,28.2315702353424\n2.10707594936709,27.7227606790902\n2.15658227848101,27.2019899132795\n2.20608860759494,26.6870287695318\n2.25559493670886,26.0498911543942\n2.30510126582278,25.2716542771294\n2.35460759493671,24.4462603917728\n2.40411392405063,23.6676517523597\n2.45362025316456,23.0297706129253\n2.50312658227848,22.5366687667688\n2.55263291139241,22.043105457921\n2.60213924050633,21.570549028688\n2.65164556962025,21.1479030539244\n2.70115189873418,20.8040711084846\n2.7506582278481,20.5679567672234\n2.80016455696203,20.5569873525453\n2.84967088607595,20.8445160338316\n2.89917721518987,20.9150757299609\n2.9486835443038,21.0236783093429\n2.99818987341772,21.1931078212329\n3.04769620253165,21.3480628664792\n3.09720253164557,21.4132420459303\n3.14670886075949,21.3133439604345\n3.19621518987342,21.0111564991249\n3.24572151898734,20.5411184425284\n3.29522784810127,19.8057099685569\n3.34473417721519,18.9323662081205\n3.39424050632911,18.0620855801734\n3.44374683544304,17.3226686118672\n3.49325316455696,16.5274083695918\n3.54275949367089,15.8723922871438\n3.59226582278481,15.4663920667705\n3.64177215189873,15.3537231538096\n3.69127848101266,15.4388816990418\n3.74078481012658,15.5860801145833\n3.79029113924051,15.6670179988257\n3.83979746835443,15.7678124698591\n3.88930379746835,15.8617856545769\n3.93881012658228,15.9278944039487\n3.9883164556962,15.9675915666615\n4.03782278481013,15.9822130539336\n4.08732911392405,15.9730947769829\n4.13683544303798,15.9415726470276\n4.1863417721519,15.8889825752859\n4.23584810126582,15.8166604729758\n4.28535443037975,15.7259422513154\n4.33486075949367,15.6181638215229\n4.3843670886076,15.4946610948164\n4.43387341772152,15.356769982414\n4.48337974683544,15.2058263955337\n4.53288607594937,15.0431662453937\n4.58239240506329,14.8701254432122\n4.63189873417722,14.6880399002072\n4.68140506329114,14.4982455275968\n4.73091139240506,14.3020782365992\n4.78041772151899,14.1008739384324\n4.82992405063291,13.8959685443146\n4.87943037974684,13.6886979654639\n4.92893670886076,13.4803981130983\n4.97844303797468,13.2724048984361\n5.02794936708861,13.0660542326953\n5.07745569620253,12.862682027094\n5.12696202531646,12.6636241928504\n5.17646835443038,12.4702166411825\n5.2259746835443,12.2837952833085\n5.27548101265823,12.1047883164442\n5.32498734177215,11.9291725392028\n5.37449367088608,11.7569216240903\n5.424,11.5887935207892"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "stroke": {
            "value": "red"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction2"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction2"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id462236627").parseSpec(plot_id462236627_spec);
</script><!--/html_preserve-->

### Scales

Scales, to control the mapping between data and visual properties. These are described in the [properties and scales vignette](http://ggvis.rstudio.com/properties-scales.html)

### Legends

Legends and axes to control the appearance of the guides produced by the scales. See the axes and [legends vignette](http://ggvis.rstudio.com/axes-legends.html) for more details.

### Basic interactivity

#### `input_slider()


```r
mtcars %>% 
  ggvis(x = ~wt, y = ~mpg) %>% 
  layer_smooths(span = input_slider(0.5, 1, 1, label = "span")) %>% 
  layer_points(size := input_slider(100, 1000, label = "size"))
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id968873790-container" class="ggvis-output-container">
<div id="plot_id968873790" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id968873790_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id968873790" data-renderer="svg">SVG</a>
 | 
<a id="plot_id968873790_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id968873790" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id968873790_download" class="ggvis-download" data-plot-id="plot_id968873790">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id968873790_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number",
          "reactive_394077167": "number"
        }
      },
      "values": "\"wt\",\"mpg\",\"reactive_394077167\"\n2.62,21,550\n2.875,21,550\n2.32,22.8,550\n3.215,21.4,550\n3.44,18.7,550\n3.46,18.1,550\n3.57,14.3,550\n3.19,24.4,550\n3.15,22.8,550\n3.44,19.2,550\n3.44,17.8,550\n4.07,16.4,550\n3.73,17.3,550\n3.78,15.2,550\n5.25,10.4,550\n5.424,10.4,550\n5.345,14.7,550\n2.2,32.4,550\n1.615,30.4,550\n1.835,33.9,550\n2.465,21.5,550\n3.52,15.5,550\n3.435,15.2,550\n3.84,13.3,550\n3.845,19.2,550\n1.935,27.3,550\n2.14,26,550\n1.513,30.4,550\n3.17,15.8,550\n2.77,19.7,550\n3.57,15,550\n2.78,21.4,550"
    },
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.3559076033652\n1.56250632911392,31.8753059433938\n1.61201265822785,31.4002837186303\n1.66151898734177,30.9307786143783\n1.7110253164557,30.4667283159411\n1.76053164556962,30.0080705086221\n1.81003797468354,29.5547428777247\n1.85954430379747,29.1066831085523\n1.90905063291139,28.6638288864083\n1.95855696202532,28.2261593300757\n2.00806329113924,27.7939085521993\n2.05756962025316,27.3671227416083\n2.10707594936709,26.9458006046978\n2.15658227848101,26.5299408478625\n2.20608860759494,26.1195421774975\n2.25559493670886,25.7146032999975\n2.30510126582278,25.3151229217576\n2.35460759493671,24.9210997491726\n2.40411392405063,24.5325324886374\n2.45362025316456,24.1494198465469\n2.50312658227848,23.7704013112288\n2.55263291139241,23.3930410310992\n2.60213924050633,23.0184854507692\n2.65164556962025,22.648013375053\n2.70115189873418,22.2829036087647\n2.7506582278481,21.9244349567186\n2.80016455696203,21.5738862237289\n2.84967088607595,21.2325362146096\n2.89917721518987,20.8994648774453\n2.9486835443038,20.563314278298\n2.99818987341772,20.2260322794124\n3.04769620253165,19.8921207313051\n3.09720253164557,19.5660814844932\n3.14670886075949,19.2524163894935\n3.19621518987342,18.9556272968227\n3.24572151898734,18.6776819657173\n3.29522784810127,18.4109241123963\n3.34473417721519,18.1533810871694\n3.39424050632911,17.9038917888661\n3.44374683544304,17.6613801039195\n3.49325316455696,17.4367412601373\n3.54275949367089,17.2198928657746\n3.59226582278481,16.9885817927012\n3.64177215189873,16.7560619903523\n3.69127848101266,16.5274875375278\n3.74078481012658,16.3032371340526\n3.79029113924051,16.0836894797512\n3.83979746835443,15.8692232744485\n3.88930379746835,15.6600927173047\n3.93881012658228,15.4562638006676\n3.9883164556962,15.2577332064667\n4.03782278481013,15.064498632161\n4.08732911392405,14.8765577752094\n4.13683544303798,14.6939083330709\n4.1863417721519,14.5165480032044\n4.23584810126582,14.344474483069\n4.28535443037975,14.1776854701235\n4.33486075949367,14.016178661827\n4.3843670886076,13.8599517556385\n4.43387341772152,13.7090024490167\n4.48337974683544,13.5633284394209\n4.53288607594937,13.4229274243098\n4.58239240506329,13.2877971011425\n4.63189873417722,13.157935167378\n4.68140506329114,13.0333393204751\n4.73091139240506,12.9140072578929\n4.78041772151899,12.7999366770903\n4.82992405063291,12.6911252755264\n4.87943037974684,12.58757075066\n4.92893670886076,12.4892707999501\n4.97844303797468,12.3962231208557\n5.02794936708861,12.3084254108357\n5.07745569620253,12.2258753673492\n5.12696202531646,12.148570687855\n5.17646835443038,12.0765090698122\n5.2259746835443,12.0096882106797\n5.27548101265823,11.9481058079165\n5.32498734177215,11.8917595589815\n5.37449367088608,11.8406471613337\n5.424,11.7947663124321"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    },
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          },
          "size": {
            "field": "data.reactive_394077167"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id968873790").parseSpec(plot_id968873790_spec);
</script><!--/html_preserve-->

#### `input_checkbox`


```r
mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_smooths(se = input_checkbox(label = "Confidence interval", value = TRUE))
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id450845636-container" class="ggvis-output-container">
<div id="plot_id450845636" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id450845636_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id450845636" data-renderer="svg">SVG</a>
 | 
<a id="plot_id450845636_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id450845636" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id450845636_download" class="ggvis-download" data-plot-id="plot_id450845636">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id450845636_spec = {
  "data": [
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.08897233857\n1.56250632911392,31.6878645869701\n1.61201265822785,31.2816303797919\n1.66151898734177,30.8703709543688\n1.7110253164557,30.4541875480347\n1.76053164556962,30.0331813981232\n1.81003797468354,29.6074537419678\n1.85954430379747,29.1771058169022\n1.90905063291139,28.7422388602601\n1.95855696202532,28.3001719301537\n2.00806329113924,27.834621969428\n2.05756962025316,27.3476575600419\n2.10707594936709,26.84497968394\n2.15658227848101,26.3322893230667\n2.20608860759494,25.8152874593666\n2.25559493670886,25.2996750747841\n2.30510126582278,24.7911531512637\n2.35460759493671,24.29542267075\n2.40411392405063,23.8181846151875\n2.45362025316456,23.3651399665205\n2.50312658227848,22.955253039598\n2.55263291139241,22.6138488714952\n2.60213924050633,22.3275852300224\n2.65164556962025,22.0817586181852\n2.70115189873418,21.8616655389892\n2.7506582278481,21.65260249544\n2.80016455696203,21.4398659905432\n2.84967088607595,21.2087525273044\n2.89917721518987,20.953335722037\n2.9486835443038,20.7158424594628\n2.99818987341772,20.4957065225374\n3.04769620253165,20.2829337645837\n3.09720253164557,20.0675300389245\n3.14670886075949,19.8395011988825\n3.19621518987342,19.5888530977805\n3.24572151898734,19.2971559094315\n3.29522784810127,18.9444093670088\n3.34473417721519,18.5670026794964\n3.39424050632911,18.2056968860288\n3.44374683544304,17.9009022641924\n3.49325316455696,17.620602502374\n3.54275949367089,17.3400153015964\n3.59226582278481,17.079077805285\n3.64177215189873,16.8175887231322\n3.69127848101266,16.5575726926136\n3.74078481012658,16.3083303048321\n3.79029113924051,16.0791621508901\n3.83979746835443,15.8793688218903\n3.88930379746835,15.7018119854881\n3.93881012658228,15.5259429561214\n3.9883164556962,15.3517253848296\n4.03782278481013,15.1793328075288\n4.08732911392405,15.0089387601353\n4.13683544303798,14.8407167785652\n4.1863417721519,14.6748403987346\n4.23584810126582,14.5114831565596\n4.28535443037975,14.3508185879563\n4.33486075949367,14.193020228841\n4.3843670886076,14.0382616151298\n4.43387341772152,13.8867162827388\n4.48337974683544,13.7385577675841\n4.53288607594937,13.5939596055819\n4.58239240506329,13.4530953326483\n4.63189873417722,13.3161384846995\n4.68140506329114,13.1832625976516\n4.73091139240506,13.0546412074207\n4.78041772151899,12.930447849923\n4.82992405063291,12.8108560610747\n4.87943037974684,12.6960393767918\n4.92893670886076,12.5861713329905\n4.97844303797468,12.4814254655869\n5.02794936708861,12.3819753104973\n5.07745569620253,12.2879944036376\n5.12696202531646,12.1996562809241\n5.17646835443038,12.117134478273\n5.2259746835443,12.0406025316002\n5.27548101265823,11.9702339768221\n5.32498734177215,11.9062023498547\n5.37449367088608,11.8486811866141\n5.424,11.7978440230166"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n10.7832876072389\n33.1035287543477"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id450845636").parseSpec(plot_id450845636_spec);
</script><!--/html_preserve-->

### `input_radiobuttons`


```r
  mtcars %>% ggvis(x = ~wt, y = ~mpg) %>%
  layer_points(
    fill := input_radiobuttons(
      choices = c("Red" = "red", "Green" = "green", "Blue" = "blue"),
      label = "Colors",
      selected = "red")
  )
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id303820460-container" class="ggvis-output-container">
<div id="plot_id303820460" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id303820460_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id303820460" data-renderer="svg">SVG</a>
 | 
<a id="plot_id303820460_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id303820460" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id303820460_download" class="ggvis-download" data-plot-id="plot_id303820460">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id303820460_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\",\"reactive_589652077\"\n2.62,21,\"red\"\n2.875,21,\"red\"\n2.32,22.8,\"red\"\n3.215,21.4,\"red\"\n3.44,18.7,\"red\"\n3.46,18.1,\"red\"\n3.57,14.3,\"red\"\n3.19,24.4,\"red\"\n3.15,22.8,\"red\"\n3.44,19.2,\"red\"\n3.44,17.8,\"red\"\n4.07,16.4,\"red\"\n3.73,17.3,\"red\"\n3.78,15.2,\"red\"\n5.25,10.4,\"red\"\n5.424,10.4,\"red\"\n5.345,14.7,\"red\"\n2.2,32.4,\"red\"\n1.615,30.4,\"red\"\n1.835,33.9,\"red\"\n2.465,21.5,\"red\"\n3.52,15.5,\"red\"\n3.435,15.2,\"red\"\n3.84,13.3,\"red\"\n3.845,19.2,\"red\"\n1.935,27.3,\"red\"\n2.14,26,\"red\"\n1.513,30.4,\"red\"\n3.17,15.8,\"red\"\n2.77,19.7,\"red\"\n3.57,15,\"red\"\n2.78,21.4,\"red\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          },
          "fill": {
            "field": "data.reactive_589652077"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id303820460").parseSpec(plot_id303820460_spec);
</script><!--/html_preserve-->

### `input_checkboxgroup`


```r
  mtcars %>% ggvis(x = ~wt, y = ~mpg) %>%
  layer_points(
    fill := input_checkboxgroup(
      choices = c("Red" = "r", "Green" = "g", "Blue" = "b"),
      label = "Point color components",
      map = function(val) {
        rgb(0.8 * "r" %in% val, 0.8 * "g" %in% val, 0.8 * "b" %in% val)
      }
    )
  )
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id105388866-container" class="ggvis-output-container">
<div id="plot_id105388866" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id105388866_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id105388866" data-renderer="svg">SVG</a>
 | 
<a id="plot_id105388866_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id105388866" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id105388866_download" class="ggvis-download" data-plot-id="plot_id105388866">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id105388866_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\",\"reactive_813706452\"\n2.62,21,\"#000000\"\n2.875,21,\"#000000\"\n2.32,22.8,\"#000000\"\n3.215,21.4,\"#000000\"\n3.44,18.7,\"#000000\"\n3.46,18.1,\"#000000\"\n3.57,14.3,\"#000000\"\n3.19,24.4,\"#000000\"\n3.15,22.8,\"#000000\"\n3.44,19.2,\"#000000\"\n3.44,17.8,\"#000000\"\n4.07,16.4,\"#000000\"\n3.73,17.3,\"#000000\"\n3.78,15.2,\"#000000\"\n5.25,10.4,\"#000000\"\n5.424,10.4,\"#000000\"\n5.345,14.7,\"#000000\"\n2.2,32.4,\"#000000\"\n1.615,30.4,\"#000000\"\n1.835,33.9,\"#000000\"\n2.465,21.5,\"#000000\"\n3.52,15.5,\"#000000\"\n3.435,15.2,\"#000000\"\n3.84,13.3,\"#000000\"\n3.845,19.2,\"#000000\"\n1.935,27.3,\"#000000\"\n2.14,26,\"#000000\"\n1.513,30.4,\"#000000\"\n3.17,15.8,\"#000000\"\n2.77,19.7,\"#000000\"\n3.57,15,\"#000000\"\n2.78,21.4,\"#000000\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          },
          "fill": {
            "field": "data.reactive_813706452"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id105388866").parseSpec(plot_id105388866_spec);
</script><!--/html_preserve-->

#### `input_text()`


```r
fill_text <- input_text(label = "Point color", value = "dodgerblue")
mtcars %>% ggvis(~wt, ~mpg, fill := fill_text) %>% layer_points()
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id433093710-container" class="ggvis-output-container">
<div id="plot_id433093710" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id433093710_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id433093710" data-renderer="svg">SVG</a>
 | 
<a id="plot_id433093710_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id433093710" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id433093710_download" class="ggvis-download" data-plot-id="plot_id433093710">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id433093710_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"reactive_713650260\",\"wt\",\"mpg\"\n\"dodgerblue\",2.62,21\n\"dodgerblue\",2.875,21\n\"dodgerblue\",2.32,22.8\n\"dodgerblue\",3.215,21.4\n\"dodgerblue\",3.44,18.7\n\"dodgerblue\",3.46,18.1\n\"dodgerblue\",3.57,14.3\n\"dodgerblue\",3.19,24.4\n\"dodgerblue\",3.15,22.8\n\"dodgerblue\",3.44,19.2\n\"dodgerblue\",3.44,17.8\n\"dodgerblue\",4.07,16.4\n\"dodgerblue\",3.73,17.3\n\"dodgerblue\",3.78,15.2\n\"dodgerblue\",5.25,10.4\n\"dodgerblue\",5.424,10.4\n\"dodgerblue\",5.345,14.7\n\"dodgerblue\",2.2,32.4\n\"dodgerblue\",1.615,30.4\n\"dodgerblue\",1.835,33.9\n\"dodgerblue\",2.465,21.5\n\"dodgerblue\",3.52,15.5\n\"dodgerblue\",3.435,15.2\n\"dodgerblue\",3.84,13.3\n\"dodgerblue\",3.845,19.2\n\"dodgerblue\",1.935,27.3\n\"dodgerblue\",2.14,26\n\"dodgerblue\",1.513,30.4\n\"dodgerblue\",3.17,15.8\n\"dodgerblue\",2.77,19.7\n\"dodgerblue\",3.57,15\n\"dodgerblue\",2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "field": "data.reactive_713650260"
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id433093710").parseSpec(plot_id433093710_spec);
</script><!--/html_preserve-->

#### `input_numeric()`


```r
size_num <- input_numeric(label = "Point size", value = 25)
mtcars %>% ggvis(~wt, ~mpg, size := size_num) %>% layer_points()
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id913739198-container" class="ggvis-output-container">
<div id="plot_id913739198" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id913739198_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id913739198" data-renderer="svg">SVG</a>
 | 
<a id="plot_id913739198_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id913739198" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id913739198_download" class="ggvis-download" data-plot-id="plot_id913739198">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id913739198_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "reactive_881915407": "number",
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"reactive_881915407\",\"wt\",\"mpg\"\n25,2.62,21\n25,2.875,21\n25,2.32,22.8\n25,3.215,21.4\n25,3.44,18.7\n25,3.46,18.1\n25,3.57,14.3\n25,3.19,24.4\n25,3.15,22.8\n25,3.44,19.2\n25,3.44,17.8\n25,4.07,16.4\n25,3.73,17.3\n25,3.78,15.2\n25,5.25,10.4\n25,5.424,10.4\n25,5.345,14.7\n25,2.2,32.4\n25,1.615,30.4\n25,1.835,33.9\n25,2.465,21.5\n25,3.52,15.5\n25,3.435,15.2\n25,3.84,13.3\n25,3.845,19.2\n25,1.935,27.3\n25,2.14,26\n25,1.513,30.4\n25,3.17,15.8\n25,2.77,19.7\n25,3.57,15\n25,2.78,21.4"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "field": "data.reactive_881915407"
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id913739198").parseSpec(plot_id913739198_spec);
</script><!--/html_preserve-->


#### `input_select()`


```r
iris %>% 
  ggvis(x = input_select(c('Petal.Width', 'Sepal.Length'), map = as.name)) %>% 
  layer_points(y = ~Petal.Length, fill = ~Species)
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id803973951-container" class="ggvis-output-container">
<div id="plot_id803973951" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id803973951_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id803973951" data-renderer="svg">SVG</a>
 | 
<a id="plot_id803973951_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id803973951" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id803973951_download" class="ggvis-download" data-plot-id="plot_id803973951">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id803973951_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "reactive_220628470": "number",
          "Petal.Length": "number"
        }
      },
      "values": "\"reactive_220628470\",\"Petal.Length\",\"Species\"\n0.2,1.4,\"setosa\"\n0.2,1.4,\"setosa\"\n0.2,1.3,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.4,\"setosa\"\n0.4,1.7,\"setosa\"\n0.3,1.4,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.4,\"setosa\"\n0.1,1.5,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.6,\"setosa\"\n0.1,1.4,\"setosa\"\n0.1,1.1,\"setosa\"\n0.2,1.2,\"setosa\"\n0.4,1.5,\"setosa\"\n0.4,1.3,\"setosa\"\n0.3,1.4,\"setosa\"\n0.3,1.7,\"setosa\"\n0.3,1.5,\"setosa\"\n0.2,1.7,\"setosa\"\n0.4,1.5,\"setosa\"\n0.2,1,\"setosa\"\n0.5,1.7,\"setosa\"\n0.2,1.9,\"setosa\"\n0.2,1.6,\"setosa\"\n0.4,1.6,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.4,\"setosa\"\n0.2,1.6,\"setosa\"\n0.2,1.6,\"setosa\"\n0.4,1.5,\"setosa\"\n0.1,1.5,\"setosa\"\n0.2,1.4,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.2,\"setosa\"\n0.2,1.3,\"setosa\"\n0.1,1.4,\"setosa\"\n0.2,1.3,\"setosa\"\n0.2,1.5,\"setosa\"\n0.3,1.3,\"setosa\"\n0.3,1.3,\"setosa\"\n0.2,1.3,\"setosa\"\n0.6,1.6,\"setosa\"\n0.4,1.9,\"setosa\"\n0.3,1.4,\"setosa\"\n0.2,1.6,\"setosa\"\n0.2,1.4,\"setosa\"\n0.2,1.5,\"setosa\"\n0.2,1.4,\"setosa\"\n1.4,4.7,\"versicolor\"\n1.5,4.5,\"versicolor\"\n1.5,4.9,\"versicolor\"\n1.3,4,\"versicolor\"\n1.5,4.6,\"versicolor\"\n1.3,4.5,\"versicolor\"\n1.6,4.7,\"versicolor\"\n1,3.3,\"versicolor\"\n1.3,4.6,\"versicolor\"\n1.4,3.9,\"versicolor\"\n1,3.5,\"versicolor\"\n1.5,4.2,\"versicolor\"\n1,4,\"versicolor\"\n1.4,4.7,\"versicolor\"\n1.3,3.6,\"versicolor\"\n1.4,4.4,\"versicolor\"\n1.5,4.5,\"versicolor\"\n1,4.1,\"versicolor\"\n1.5,4.5,\"versicolor\"\n1.1,3.9,\"versicolor\"\n1.8,4.8,\"versicolor\"\n1.3,4,\"versicolor\"\n1.5,4.9,\"versicolor\"\n1.2,4.7,\"versicolor\"\n1.3,4.3,\"versicolor\"\n1.4,4.4,\"versicolor\"\n1.4,4.8,\"versicolor\"\n1.7,5,\"versicolor\"\n1.5,4.5,\"versicolor\"\n1,3.5,\"versicolor\"\n1.1,3.8,\"versicolor\"\n1,3.7,\"versicolor\"\n1.2,3.9,\"versicolor\"\n1.6,5.1,\"versicolor\"\n1.5,4.5,\"versicolor\"\n1.6,4.5,\"versicolor\"\n1.5,4.7,\"versicolor\"\n1.3,4.4,\"versicolor\"\n1.3,4.1,\"versicolor\"\n1.3,4,\"versicolor\"\n1.2,4.4,\"versicolor\"\n1.4,4.6,\"versicolor\"\n1.2,4,\"versicolor\"\n1,3.3,\"versicolor\"\n1.3,4.2,\"versicolor\"\n1.2,4.2,\"versicolor\"\n1.3,4.2,\"versicolor\"\n1.3,4.3,\"versicolor\"\n1.1,3,\"versicolor\"\n1.3,4.1,\"versicolor\"\n2.5,6,\"virginica\"\n1.9,5.1,\"virginica\"\n2.1,5.9,\"virginica\"\n1.8,5.6,\"virginica\"\n2.2,5.8,\"virginica\"\n2.1,6.6,\"virginica\"\n1.7,4.5,\"virginica\"\n1.8,6.3,\"virginica\"\n1.8,5.8,\"virginica\"\n2.5,6.1,\"virginica\"\n2,5.1,\"virginica\"\n1.9,5.3,\"virginica\"\n2.1,5.5,\"virginica\"\n2,5,\"virginica\"\n2.4,5.1,\"virginica\"\n2.3,5.3,\"virginica\"\n1.8,5.5,\"virginica\"\n2.2,6.7,\"virginica\"\n2.3,6.9,\"virginica\"\n1.5,5,\"virginica\"\n2.3,5.7,\"virginica\"\n2,4.9,\"virginica\"\n2,6.7,\"virginica\"\n1.8,4.9,\"virginica\"\n2.1,5.7,\"virginica\"\n1.8,6,\"virginica\"\n1.8,4.8,\"virginica\"\n1.8,4.9,\"virginica\"\n2.1,5.6,\"virginica\"\n1.6,5.8,\"virginica\"\n1.9,6.1,\"virginica\"\n2,6.4,\"virginica\"\n2.2,5.6,\"virginica\"\n1.5,5.1,\"virginica\"\n1.4,5.6,\"virginica\"\n2.3,6.1,\"virginica\"\n2.4,5.6,\"virginica\"\n1.8,5.5,\"virginica\"\n1.8,4.8,\"virginica\"\n2.1,5.4,\"virginica\"\n2.4,5.6,\"virginica\"\n2.3,5.1,\"virginica\"\n1.9,5.1,\"virginica\"\n2.3,5.9,\"virginica\"\n2.5,5.7,\"virginica\"\n2.3,5.2,\"virginica\"\n1.9,5,\"virginica\"\n2,5.2,\"virginica\"\n2.3,5.4,\"virginica\"\n1.8,5.1,\"virginica\""
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"setosa\"\n\"versicolor\"\n\"virginica\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.02\n2.62"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.705\n7.195"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "type": "ordinal",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "category10"
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.reactive_220628470"
          },
          "y": {
            "scale": "y",
            "field": "data.Petal\\.Length"
          },
          "fill": {
            "scale": "fill",
            "field": "data.Species"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "fill": "fill",
      "title": "Species"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "reactive_220628470"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "Petal.Length"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id803973951").parseSpec(plot_id803973951_spec);
</script><!--/html_preserve-->


#### Outputting your ggvis plot

This is still in active development and is not especially user friendly.  For more information, visit [here](https://rdrr.io/cran/ggvis/man/print.ggvis.html)


```r
outfile <- iris %>% 
  ggvis(x = input_select(c('Petal.Width', 'Sepal.Length'), map = as.name)) %>% 
  layer_points(y = ~Petal.Length, fill = ~Species) %>%
  view_dynamic() %>% htmltools::html_print(viewer = NULL)
```


#### Some last notes on `ggvis`

ggvis is still actively being developed and there is a lot more detail than I have provided. In addition, there is still a lot that ggvis can not do.   I encourage you to check out the [ggvis website](http://ggvis.rstudio.com/) for more information and updates. 


### googleVis

The googleVis package provides an interface between R and the Google
Charts API. Google Charts offer interactive charts which can be embedded
into web pages.

There are many options for figures and given our time constraint, we will only cover a portion of what is available.  I encourage you to look [here](https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html) and [here](https://developers.google.com/chart/interactive/docs/) for additional ideas and details. 


```r
# install.packages("googleVis")
library(googleVis)
```

```
## Creating a generic function for 'toJSON' from package 'jsonlite' in package 'googleVis'
```

```
## 
## Welcome to googleVis version 0.6.1
## 
## Please read the Google API Terms of Use
## before you start using the package:
## https://developers.google.com/terms/
## 
## Note, the plot method of googleVis will by default use
## the standard browser to display its output.
## 
## See the googleVis package vignettes for more details,
## or visit http://github.com/mages/googleVis.
## 
## To suppress this message use:
## suppressPackageStartupMessages(library(googleVis))
```

```r
op <- options(gvis.plot.tag='chart')
```

To get these to work in RMarkdown you will need to specify `results='asis'` in the chunk options.  

### [Line plots](https://developers.google.com/chart/interactive/docs/gallery/linechart)


```r
df <- data.frame(time=c(1:70), 
              val1=c(1:70)*3 +rnorm(70, sd = 6), 
              val2=c(1:70)*5 +rnorm(70, sd = 10))
```



```r
Line_plot <- gvisLineChart(df, xvar = "time", yvar = c("val1", "val2"))
plot(Line_plot)
```

<!-- LineChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataLineChartID33746e60c5f8 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"1",
-0.8659705754,
23.86946942
],
[
"2",
-3.318824431,
6.08180628
],
[
"3",
-0.5862571002,
5.193670511
],
[
"4",
22.83058511,
26.87332101
],
[
"5",
12.11011582,
19.94956482
],
[
"6",
21.72227881,
51.57719817
],
[
"7",
24.67274096,
29.00202436
],
[
"8",
23.02613414,
33.05453307
],
[
"9",
31.87123907,
47.23925408
],
[
"10",
43.18100128,
38.4377667
],
[
"11",
45.29514202,
59.22418528
],
[
"12",
45.79467384,
46.75244744
],
[
"13",
40.52562716,
66.41084313
],
[
"14",
44.94712968,
64.63952002
],
[
"15",
43.05548053,
71.88393915
],
[
"16",
38.02769854,
95.56109643
],
[
"17",
61.60640311,
80.51966709
],
[
"18",
54.15480629,
93.21123537
],
[
"19",
63.771065,
82.69827753
],
[
"20",
45.71785163,
86.75941308
],
[
"21",
56.63840669,
117.6124227
],
[
"22",
71.62284324,
123.1923172
],
[
"23",
74.12671032,
114.1924624
],
[
"24",
80.76437642,
114.9491019
],
[
"25",
66.52140733,
124.4784641
],
[
"26",
81.40441952,
136.2886063
],
[
"27",
84.49912592,
156.800024
],
[
"28",
76.159207,
139.3098269
],
[
"29",
83.75768356,
160.448636
],
[
"30",
101.686156,
163.2145202
],
[
"31",
93.32154162,
158.2215158
],
[
"32",
98.10997704,
175.3095512
],
[
"33",
94.97414077,
160.7876031
],
[
"34",
103.6677222,
158.4117898
],
[
"35",
109.1470276,
156.5463171
],
[
"36",
112.942772,
191.5732529
],
[
"37",
123.8703901,
163.7645012
],
[
"38",
99.91833613,
178.0396848
],
[
"39",
117.8975519,
211.4219199
],
[
"40",
111.9448111,
208.8365483
],
[
"41",
126.3198185,
210.2487589
],
[
"42",
135.5397771,
198.1534093
],
[
"43",
125.4787224,
241.5578827
],
[
"44",
121.0057362,
209.5208629
],
[
"45",
140.3288366,
214.8887748
],
[
"46",
147.5609308,
236.6892165
],
[
"47",
144.101128,
236.2917729
],
[
"48",
136.2259699,
235.7742313
],
[
"49",
147.3276935,
233.5973586
],
[
"50",
145.2921038,
237.0628471
],
[
"51",
146.7038831,
249.0530123
],
[
"52",
169.9830718,
244.9918592
],
[
"53",
167.4162323,
265.1585569
],
[
"54",
167.6556051,
275.4016957
],
[
"55",
169.9575497,
259.5270803
],
[
"56",
163.1307571,
288.4965293
],
[
"57",
173.8574897,
293.9601318
],
[
"58",
180.1275504,
291.38691
],
[
"59",
180.8722984,
278.8067168
],
[
"60",
186.2588613,
305.4839792
],
[
"61",
181.1737853,
306.9528215
],
[
"62",
200.8626655,
301.9350201
],
[
"63",
194.827324,
313.9137576
],
[
"64",
203.2025951,
317.4905338
],
[
"65",
199.0322548,
341.9934667
],
[
"66",
196.1522797,
326.557012
],
[
"67",
204.2191423,
335.6777206
],
[
"68",
208.9492204,
333.4943027
],
[
"69",
201.2165911,
340.1236148
],
[
"70",
204.8695049,
353.0315124
] 
];
data.addColumn('string','time');
data.addColumn('number','val1');
data.addColumn('number','val2');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartLineChartID33746e60c5f8() {
var data = gvisDataLineChartID33746e60c5f8();
var options = {};
options["allowHtml"] = true;

    var chart = new google.visualization.LineChart(
    document.getElementById('LineChartID33746e60c5f8')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartLineChartID33746e60c5f8);
})();
function displayChartLineChartID33746e60c5f8() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartLineChartID33746e60c5f8"></script>
 
<!-- divChart -->
  
<div id="LineChartID33746e60c5f8" 
  style="width: 500; height: automatic;">
</div>


```r
Line_plot2 <- gvisLineChart(df, xvar = "time", yvar = c("val1", "val2"), options = list(series = "[{targetAxisIndex: 0}, {targetAxisIndex:1}]", 
    vAxes = "[{title:'val1'}, {title:'val2'}]"))
plot(Line_plot2)
```

<!-- LineChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataLineChartID337461c963d5 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"1",
-0.8659705754,
23.86946942
],
[
"2",
-3.318824431,
6.08180628
],
[
"3",
-0.5862571002,
5.193670511
],
[
"4",
22.83058511,
26.87332101
],
[
"5",
12.11011582,
19.94956482
],
[
"6",
21.72227881,
51.57719817
],
[
"7",
24.67274096,
29.00202436
],
[
"8",
23.02613414,
33.05453307
],
[
"9",
31.87123907,
47.23925408
],
[
"10",
43.18100128,
38.4377667
],
[
"11",
45.29514202,
59.22418528
],
[
"12",
45.79467384,
46.75244744
],
[
"13",
40.52562716,
66.41084313
],
[
"14",
44.94712968,
64.63952002
],
[
"15",
43.05548053,
71.88393915
],
[
"16",
38.02769854,
95.56109643
],
[
"17",
61.60640311,
80.51966709
],
[
"18",
54.15480629,
93.21123537
],
[
"19",
63.771065,
82.69827753
],
[
"20",
45.71785163,
86.75941308
],
[
"21",
56.63840669,
117.6124227
],
[
"22",
71.62284324,
123.1923172
],
[
"23",
74.12671032,
114.1924624
],
[
"24",
80.76437642,
114.9491019
],
[
"25",
66.52140733,
124.4784641
],
[
"26",
81.40441952,
136.2886063
],
[
"27",
84.49912592,
156.800024
],
[
"28",
76.159207,
139.3098269
],
[
"29",
83.75768356,
160.448636
],
[
"30",
101.686156,
163.2145202
],
[
"31",
93.32154162,
158.2215158
],
[
"32",
98.10997704,
175.3095512
],
[
"33",
94.97414077,
160.7876031
],
[
"34",
103.6677222,
158.4117898
],
[
"35",
109.1470276,
156.5463171
],
[
"36",
112.942772,
191.5732529
],
[
"37",
123.8703901,
163.7645012
],
[
"38",
99.91833613,
178.0396848
],
[
"39",
117.8975519,
211.4219199
],
[
"40",
111.9448111,
208.8365483
],
[
"41",
126.3198185,
210.2487589
],
[
"42",
135.5397771,
198.1534093
],
[
"43",
125.4787224,
241.5578827
],
[
"44",
121.0057362,
209.5208629
],
[
"45",
140.3288366,
214.8887748
],
[
"46",
147.5609308,
236.6892165
],
[
"47",
144.101128,
236.2917729
],
[
"48",
136.2259699,
235.7742313
],
[
"49",
147.3276935,
233.5973586
],
[
"50",
145.2921038,
237.0628471
],
[
"51",
146.7038831,
249.0530123
],
[
"52",
169.9830718,
244.9918592
],
[
"53",
167.4162323,
265.1585569
],
[
"54",
167.6556051,
275.4016957
],
[
"55",
169.9575497,
259.5270803
],
[
"56",
163.1307571,
288.4965293
],
[
"57",
173.8574897,
293.9601318
],
[
"58",
180.1275504,
291.38691
],
[
"59",
180.8722984,
278.8067168
],
[
"60",
186.2588613,
305.4839792
],
[
"61",
181.1737853,
306.9528215
],
[
"62",
200.8626655,
301.9350201
],
[
"63",
194.827324,
313.9137576
],
[
"64",
203.2025951,
317.4905338
],
[
"65",
199.0322548,
341.9934667
],
[
"66",
196.1522797,
326.557012
],
[
"67",
204.2191423,
335.6777206
],
[
"68",
208.9492204,
333.4943027
],
[
"69",
201.2165911,
340.1236148
],
[
"70",
204.8695049,
353.0315124
] 
];
data.addColumn('string','time');
data.addColumn('number','val1');
data.addColumn('number','val2');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartLineChartID337461c963d5() {
var data = gvisDataLineChartID337461c963d5();
var options = {};
options["allowHtml"] = true;
options["series"] = [{targetAxisIndex: 0}, {targetAxisIndex:1}];
options["vAxes"] = [{title:'val1'}, {title:'val2'}];

    var chart = new google.visualization.LineChart(
    document.getElementById('LineChartID337461c963d5')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartLineChartID337461c963d5);
})();
function displayChartLineChartID337461c963d5() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartLineChartID337461c963d5"></script>
 
<!-- divChart -->
  
<div id="LineChartID337461c963d5" 
  style="width: 500; height: automatic;">
</div>


### [Bar plots](https://developers.google.com/chart/interactive/docs/gallery/barchart)


```r
mpg<-mtcars %>% 
    mutate(gear = paste("gear",gear,sep="_")) %>% 
    group_by(cyl, gear) %>% 
    summarise(M_mpg = mean(mpg)) %>% 
    spread(gear, M_mpg) %>% 
    as.data.frame()

mpg$gear_4[is.na(mpg$gear_4)] <-0
```



```r
mpg_side <- gvisBarChart(data = mpg, xvar = c("cyl"), yvar = c("gear_3", "gear_4", 
    "gear_5"))

plot(mpg_side)
```

<!-- BarChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataBarChartID337439ef1866 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
4,
21.5,
26.925,
28.2
],
[
6,
19.75,
19.75,
19.7
],
[
8,
15.05,
0,
15.4
] 
];
data.addColumn('number','cyl');
data.addColumn('number','gear_3');
data.addColumn('number','gear_4');
data.addColumn('number','gear_5');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartBarChartID337439ef1866() {
var data = gvisDataBarChartID337439ef1866();
var options = {};
options["allowHtml"] = true;

    var chart = new google.visualization.BarChart(
    document.getElementById('BarChartID337439ef1866')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartBarChartID337439ef1866);
})();
function displayChartBarChartID337439ef1866() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartBarChartID337439ef1866"></script>
 
<!-- divChart -->
  
<div id="BarChartID337439ef1866" 
  style="width: 500; height: automatic;">
</div>



```r
mpg_vert <- gvisColumnChart(data = mpg, xvar = c("cyl"), yvar = c("gear_3", 
    "gear_4", "gear_5"), options = list(title = "The mean mpg per cylinder", 
    colors = "['#cbb69d', '#603913', '#c69c6e']", vAxes = "[{title:'miles per gallon'}]", 
    hAxes = "[{title:'Number of cylinders'}]"))
plot(mpg_vert)
```

<!-- ColumnChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataColumnChartID337427fed7d () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
4,
21.5,
26.925,
28.2
],
[
6,
19.75,
19.75,
19.7
],
[
8,
15.05,
0,
15.4
] 
];
data.addColumn('number','cyl');
data.addColumn('number','gear_3');
data.addColumn('number','gear_4');
data.addColumn('number','gear_5');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartColumnChartID337427fed7d() {
var data = gvisDataColumnChartID337427fed7d();
var options = {};
options["allowHtml"] = true;
options["title"] = "The mean mpg per cylinder";
options["colors"] = ['#cbb69d', '#603913', '#c69c6e'];
options["vAxes"] = [{title:'miles per gallon'}];
options["hAxes"] = [{title:'Number of cylinders'}];

    var chart = new google.visualization.ColumnChart(
    document.getElementById('ColumnChartID337427fed7d')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartColumnChartID337427fed7d);
})();
function displayChartColumnChartID337427fed7d() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartColumnChartID337427fed7d"></script>
 
<!-- divChart -->
  
<div id="ColumnChartID337427fed7d" 
  style="width: 500; height: automatic;">
</div>


```r
mpg_cars<-mtcars %>% 
    mutate(gear = paste("gear",gear,sep="_")) %>% 
    group_by(cyl, gear) %>% 
    summarise(N = n()) %>% 
    spread(gear, N) %>% 
    as.data.frame()

mpg$gear_4[is.na(mpg$gear_4)] <-0
```


```r
mpg_stack <- gvisColumnChart(data = mpg, xvar = c("cyl"), yvar = c("gear_3", 
    "gear_4", "gear_5"), options = list(isStacked = TRUE, title = "The mean mpg per cylinder", 
    colors = "['#cbb69d', '#603913', '#c69c6e']", vAxes = "[{title:'Number of cars'}]", 
    hAxes = "[{title:'Number of cylinders'}]"))
plot(mpg_stack)
```

<!-- ColumnChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataColumnChartID3374383ed358 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
4,
21.5,
26.925,
28.2
],
[
6,
19.75,
19.75,
19.7
],
[
8,
15.05,
0,
15.4
] 
];
data.addColumn('number','cyl');
data.addColumn('number','gear_3');
data.addColumn('number','gear_4');
data.addColumn('number','gear_5');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartColumnChartID3374383ed358() {
var data = gvisDataColumnChartID3374383ed358();
var options = {};
options["allowHtml"] = true;
options["isStacked"] = true;
options["title"] = "The mean mpg per cylinder";
options["colors"] = ['#cbb69d', '#603913', '#c69c6e'];
options["vAxes"] = [{title:'Number of cars'}];
options["hAxes"] = [{title:'Number of cylinders'}];

    var chart = new google.visualization.ColumnChart(
    document.getElementById('ColumnChartID3374383ed358')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartColumnChartID3374383ed358);
})();
function displayChartColumnChartID3374383ed358() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartColumnChartID3374383ed358"></script>
 
<!-- divChart -->
  
<div id="ColumnChartID3374383ed358" 
  style="width: 500; height: automatic;">
</div>


### [Area plots](https://developers.google.com/chart/interactive/docs/gallery/areachart)


```r
df4 <- data.frame(Year = c(2013:2016), Sales = c(1000, 1170, 660, 1030), Expenses = c(400, 460, 1120, 540))

df4
```

```
##   Year Sales Expenses
## 1 2013  1000      400
## 2 2014  1170      460
## 3 2015   660     1120
## 4 2016  1030      540
```



```r
Area <- gvisAreaChart(df4, xvar = "Year", yvar = c("Sales", "Expenses"))

plot(Area)
```

<!-- AreaChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataAreaChartID337421a819e0 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"2013",
1000,
400
],
[
"2014",
1170,
460
],
[
"2015",
660,
1120
],
[
"2016",
1030,
540
] 
];
data.addColumn('string','Year');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartAreaChartID337421a819e0() {
var data = gvisDataAreaChartID337421a819e0();
var options = {};
options["allowHtml"] = true;

    var chart = new google.visualization.AreaChart(
    document.getElementById('AreaChartID337421a819e0')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartAreaChartID337421a819e0);
})();
function displayChartAreaChartID337421a819e0() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartAreaChartID337421a819e0"></script>
 
<!-- divChart -->
  
<div id="AreaChartID337421a819e0" 
  style="width: 500; height: automatic;">
</div>


```r
Area_stack <- gvisAreaChart(df4, xvar = "Year", yvar = c("Sales", "Expenses"), 
    options = list(isStacked = TRUE))

plot(Area_stack)
```

<!-- AreaChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataAreaChartID33746aca73a6 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"2013",
1000,
400
],
[
"2014",
1170,
460
],
[
"2015",
660,
1120
],
[
"2016",
1030,
540
] 
];
data.addColumn('string','Year');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartAreaChartID33746aca73a6() {
var data = gvisDataAreaChartID33746aca73a6();
var options = {};
options["allowHtml"] = true;
options["isStacked"] = true;

    var chart = new google.visualization.AreaChart(
    document.getElementById('AreaChartID33746aca73a6')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartAreaChartID33746aca73a6);
})();
function displayChartAreaChartID33746aca73a6() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartAreaChartID33746aca73a6"></script>
 
<!-- divChart -->
  
<div id="AreaChartID33746aca73a6" 
  style="width: 500; height: automatic;">
</div>


### Combo plots


```r
head(CityPopularity)
```

         City Popularity
1    New York        200
2      Boston        300
3       Miami        400
4     Chicago        500
5 Los Angeles        600
6     Houston        700

```r
CityPopularity$Mean = mean(CityPopularity$Popularity)
CC <- gvisComboChart(CityPopularity, xvar = "City", yvar = c("Mean", "Popularity"), 
    options = list(seriesType = "bars", width = 450, height = 300, title = "City Popularity", 
        series = "{0: {type:\"line\"}}"))
plot(CC)
```

<!-- ComboChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataComboChartID337419a8561 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"New York",
450,
200
],
[
"Boston",
450,
300
],
[
"Miami",
450,
400
],
[
"Chicago",
450,
500
],
[
"Los Angeles",
450,
600
],
[
"Houston",
450,
700
] 
];
data.addColumn('string','City');
data.addColumn('number','Mean');
data.addColumn('number','Popularity');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartComboChartID337419a8561() {
var data = gvisDataComboChartID337419a8561();
var options = {};
options["allowHtml"] = true;
options["seriesType"] = "bars";
options["width"] = 450;
options["height"] = 300;
options["title"] = "City Popularity";
options["series"] = {0: {type:"line"}};

    var chart = new google.visualization.ComboChart(
    document.getElementById('ComboChartID337419a8561')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartComboChartID337419a8561);
})();
function displayChartComboChartID337419a8561() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartComboChartID337419a8561"></script>
 
<!-- divChart -->
  
<div id="ComboChartID337419a8561" 
  style="width: 450; height: 300;">
</div>

### [GeoChart plots](https://developers.google.com/chart/interactive/docs/gallery/map)


```r
library(datasets)
states <- data.frame(state.name, state.x77)

head(states)
```

```
##            state.name Population Income Illiteracy Life.Exp Murder HS.Grad
## Alabama       Alabama       3615   3624        2.1    69.05   15.1    41.3
## Alaska         Alaska        365   6315        1.5    69.31   11.3    66.7
## Arizona       Arizona       2212   4530        1.8    70.55    7.8    58.1
## Arkansas     Arkansas       2110   3378        1.9    70.66   10.1    39.9
## California California      21198   5114        1.1    71.71   10.3    62.6
## Colorado     Colorado       2541   4884        0.7    72.06    6.8    63.9
##            Frost   Area
## Alabama       20  50708
## Alaska       152 566432
## Arizona       15 113417
## Arkansas      65  51945
## California    20 156361
## Colorado     166 103766
```



```r
GeoStates <- gvisGeoChart(states, "state.name", "Murder", options = list(region = "US", 
    displayMode = "regions", resolution = "provinces", width = 600, height = 400, 
    colors = "['skyblue','red']"))
plot(GeoStates)
```

<!-- GeoChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID337467256c56 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"Alabama",
15.1
],
[
"Alaska",
11.3
],
[
"Arizona",
7.8
],
[
"Arkansas",
10.1
],
[
"California",
10.3
],
[
"Colorado",
6.8
],
[
"Connecticut",
3.1
],
[
"Delaware",
6.2
],
[
"Florida",
10.7
],
[
"Georgia",
13.9
],
[
"Hawaii",
6.2
],
[
"Idaho",
5.3
],
[
"Illinois",
10.3
],
[
"Indiana",
7.1
],
[
"Iowa",
2.3
],
[
"Kansas",
4.5
],
[
"Kentucky",
10.6
],
[
"Louisiana",
13.2
],
[
"Maine",
2.7
],
[
"Maryland",
8.5
],
[
"Massachusetts",
3.3
],
[
"Michigan",
11.1
],
[
"Minnesota",
2.3
],
[
"Mississippi",
12.5
],
[
"Missouri",
9.3
],
[
"Montana",
5
],
[
"Nebraska",
2.9
],
[
"Nevada",
11.5
],
[
"New Hampshire",
3.3
],
[
"New Jersey",
5.2
],
[
"New Mexico",
9.7
],
[
"New York",
10.9
],
[
"North Carolina",
11.1
],
[
"North Dakota",
1.4
],
[
"Ohio",
7.4
],
[
"Oklahoma",
6.4
],
[
"Oregon",
4.2
],
[
"Pennsylvania",
6.1
],
[
"Rhode Island",
2.4
],
[
"South Carolina",
11.6
],
[
"South Dakota",
1.7
],
[
"Tennessee",
11
],
[
"Texas",
12.2
],
[
"Utah",
4.5
],
[
"Vermont",
5.5
],
[
"Virginia",
9.5
],
[
"Washington",
4.3
],
[
"West Virginia",
6.7
],
[
"Wisconsin",
3
],
[
"Wyoming",
6.9
] 
];
data.addColumn('string','state.name');
data.addColumn('number','Murder');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID337467256c56() {
var data = gvisDataGeoChartID337467256c56();
var options = {};
options["width"] = 600;
options["height"] = 400;
options["region"] = "US";
options["displayMode"] = "regions";
options["resolution"] = "provinces";
options["colors"] = ['skyblue','red'];

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID337467256c56')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID337467256c56);
})();
function displayChartGeoChartID337467256c56() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID337467256c56"></script>
 
<!-- divChart -->
  
<div id="GeoChartID337467256c56" 
  style="width: 600; height: 400;">
</div>

### Interactive plots

Like using `ggvis`, you do have the option to make fully interactive plots.  You won't be able to get it to work in the console or in Rstudio because `googleVis` creates  javascript that is embedded into an HTML document . The only way to know for sure if it's working is to knit it to HTML, and then publish it to Rpubs (or anywhere else online). Once it is online it will work. Depending on your browser settings, you might be able to get it to work by opening the HTML locally, but the browser often blocks the embedded plot when opened locally


```r
M <- gvisMotionChart(Fruits, "Fruit", "Year")
```


```r
plot(M, 'chart')
```

<!-- MotionChart generated in R 3.3.1 by googleVis 0.6.1 package -->
<!-- Tue Oct  4 12:00:43 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataMotionChartID3374123bc891 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"Apples",
2008,
"West",
98,
78,
20,
"2008-12-31"
],
[
"Apples",
2009,
"West",
111,
79,
32,
"2009-12-31"
],
[
"Apples",
2010,
"West",
89,
76,
13,
"2010-12-31"
],
[
"Oranges",
2008,
"East",
96,
81,
15,
"2008-12-31"
],
[
"Bananas",
2008,
"East",
85,
76,
9,
"2008-12-31"
],
[
"Oranges",
2009,
"East",
93,
80,
13,
"2009-12-31"
],
[
"Bananas",
2009,
"East",
94,
78,
16,
"2009-12-31"
],
[
"Oranges",
2010,
"East",
98,
91,
7,
"2010-12-31"
],
[
"Bananas",
2010,
"East",
81,
71,
10,
"2010-12-31"
] 
];
data.addColumn('string','Fruit');
data.addColumn('number','Year');
data.addColumn('string','Location');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addColumn('number','Profit');
data.addColumn('string','Date');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartMotionChartID3374123bc891() {
var data = gvisDataMotionChartID3374123bc891();
var options = {};
options["width"] = 600;
options["height"] = 500;
options["state"] = "";

    var chart = new google.visualization.MotionChart(
    document.getElementById('MotionChartID3374123bc891')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "motionchart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartMotionChartID3374123bc891);
})();
function displayChartMotionChartID3374123bc891() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartMotionChartID3374123bc891"></script>
 
<!-- divChart -->
  
<div id="MotionChartID3374123bc891" 
  style="width: 600; height: 500;">
</div>


### Outputting `googlevis` plots


```r
# write the HTML body to a temporary file without header and footer
cat(M$html$chart, file="/Users/cchizinski2/Documents/DataDepot/temp.html")
```


