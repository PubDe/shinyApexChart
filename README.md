---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

```{r, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%"
)
```

# shinyApexChart

<!-- badges: start -->
<!-- badges: end -->

ChartPackage is an R package for creating interactive charts using the ApexCharts library. It provides functions to generate donut charts, radial bar charts, and circle gauges with customizable options.

## Installation

You can install the development version of shinyApexChart from GitHub using the `devtools` package:

``` r
# Install devtools package if not already installed
if (!require(devtools)) {
  install.packages("devtools")
}

# Install ChartPackage from GitHub
devtools::install_github("PubDe/shinyApexChart")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(shinyApexChart)

df <- data.frame(
  Lables = c("Team A", "Team B", "Team C", "Team D", "Team E", "Team F"),
  Series = c(44, 55, 41, 17, 15, 45)
)

# Create a donut chart
donutChart("id", df, TRUE, "chart_title")

# Create a radial bar chart
radialChart("id", df, "#FF00FF")

# Create a circle gauge
circleGauge("id", 78)
```

## Contributing
Contributions to shinyApexChart are welcome! If you encounter any bugs, have feature requests, or want to contribute enhancements or fixes, please open an issue or submit a pull request on the GitHub repository.

## License
ChartPackage is released under the MIT License. See the LICENSE file for details.
