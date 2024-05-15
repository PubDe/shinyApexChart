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

``` r 
library(shinyApexChart)

# Create a donut chart
# donutChart("id", dataframe, data_labels_enabled, chart_title)
donutChart("id", dataframe, TRUE, "chart_title")

# Create a radial bar chart
# radialChart("id", dataframe, color_hex)
radialChart("id", dataframe, "#FF00FF")

# Create a circle gauge
# circleGauge("id", value)
circleGauge("id", 78)
```

## Contributing
Contributions to shinyApexChart are welcome! If you encounter any bugs, have feature requests, or want to contribute enhancements or fixes, please open an issue or submit a pull request on the GitHub repository.

## License

 - [MIT](https://choosealicense.com/licenses/mit/)


## Acknowledgements

 - [Apex Charts javascript library](https://apexcharts.com/docs/installation/)



