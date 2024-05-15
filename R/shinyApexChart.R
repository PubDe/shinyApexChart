if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}

is_hexadecimal <- function(input_string) {
  hex_pattern <- "^#[0-9a-fA-F]{6}$"
  return(grepl(hex_pattern, input_string))
}

#' Create a Donut Chart
#'
#' @param id The ID of the chart element
#' @param df A data frame with two columns: labels and values
#' @param data_labels_enabled A boolean to enable or disable data labels (default: TRUE)
#' @param chart_title The title of the chart (default: "")
#'
#' @return An HTML element containing the donut chart
#' @export
donutChart <- function(id, df, data_labels_enabled = TRUE, chart_title = "") {
  if (!is.character(id)) {
    stop("First argument must be a character")
  }
  if (!is.data.frame(df)) {
    stop("Second argument must be a data frame")
  }
  if (ncol(df) != 2) {
    stop("Data frame must have exactly two columns")
  }
  if (!is.numeric(df[, 2])) {
    stop("Second column of data frame must be numeric")
  }

  series <- df[, 2]
  labels <- df[, 1]

  json_labels <- jsonlite::toJSON(labels)
  json_series <- jsonlite::toJSON(series)

  enabled <- ifelse(data_labels_enabled, "true", "false")

  htmltools::div(
    id = id,
    style = "height: 400px;",
    htmltools::tags$script(src = "https://cdn.jsdelivr.net/npm/apexcharts", type = "text/javascript"),
    htmltools::tags$script(
      htmltools::HTML(paste0(
        'var options = {
           series: ', json_series, ',
           labels: ', json_labels, ',
           chart: {
             type: "donut",
             height: 400
           },
           title: {
             text: "', chart_title, '"
           },
           dataLabels: {
             enabled: ', enabled, '
           },
           fill: {
             type: "gradient"
           },
           legend: {
             formatter: function (val, opts) {
               return val + " - " + opts.w.globals.series[opts.seriesIndex];
             },
             position: "bottom"
           },
           responsive: [{
             breakpoint: 768,
             options: {
               chart: {
                 width: 600
               },
               dataLabels: {
                 enabled: false
               },
               legend: {
                 position: "bottom"
               }
             }
           }]
         };
         var chart = new ApexCharts(document.querySelector("#', id, '"), options);
         chart.render();
         document.getElementById("', id, '").style.paddingTop = "20px";'
      ))
    )
  )
}

#' Create a Radial Bar Chart
#'
#' @param id The ID of the chart element
#' @param df A data frame with two columns: labels and values
#' @param color A hexadecimal color code (default: "#0259e6")
#'
#' @return An HTML element containing the radial bar chart
#' @export
radialChart <- function(id, df, color="#0259E6") {
  if (!is.character(id)) {
    stop("First argument must be a character")
  }
  if (!is.data.frame(df)) {
    stop("Second argument must be a data frame")
  }
  if (ncol(df) != 2) {
    stop("Data frame must have exactly two columns")
  }
  if (!is.numeric(df[, 2])) {
    stop("Second column of data frame must be numeric")
  }
  if (!is_hexadecimal(color)) {
    stop("Third argument must be a hexadecimal color code")
  }

  series <- df[, 2]
  labels <- df[, 1]
  num_records <- nrow(df)

  json_labels <- jsonlite::toJSON(labels)
  json_series <- jsonlite::toJSON(series)

  style_id <- paste0("#", id)

  htmltools::div(
    id = id,
    style = "height: 400px;",
    htmltools::tags$script(src = "https://cdn.jsdelivr.net/npm/apexcharts", type = "text/javascript"),
    htmltools::tags$script(src = "/sc.js", type = "text/javascript"),
    htmltools::tags$script(
      htmltools::HTML(paste0(
        'let baseColor = "', color, '";
         let numColors = ', num_records, ';
         let colorArray = generateMatchingColors(baseColor, numColors);

         var options = {
           series: ', json_series, ',
           labels: ', json_labels, ',
           colors: colorArray,
           chart: {
             height: 400,
             type: "radialBar"
           },
           stroke: {
             lineCap: "round"
           },
           plotOptions: {
             radialBar: {
               offsetY: 0,
               startAngle: 0,
               endAngle: 270,
               hollow: {
                 margin: 5,
                 size: "30%",
                 background: "transparent"
               },
               dataLabels: {
                 name: {
                   show: false
                 },
                 value: {
                   show: false
                 }
               },
               barLabels: {
                 enabled: true,
                 useSeriesColors: true,
                 margin: 8,
                 fontSize: "12px",
                 formatter: function (seriesName, opts) {
                   return seriesName + ": " + opts.w.globals.series[opts.seriesIndex];
                 }
               }
             }
           },
           responsive: [{
             breakpoint: 480,
             options: {
               legend: {
                 show: false
               }
             }
           }]
         };

         var chart = new ApexCharts(document.querySelector("', style_id, '"), options);
         chart.render();
         document.getElementById("', id, '").style.paddingTop = "20px";'
      ))
    )
  )
}

#' Create a Circle Gauge
#'
#' @param id The ID of the gauge element
#' @param value The value to display in the gauge (numeric)
#'
#' @return An HTML element containing the circle gauge
#' @export
circleGauge <- function(id, value) {
  if (!is.character(id)) {
    stop("First argument must be a character")
  }
  if (!is.numeric(value)) {
    stop("Second argument must be numeric")
  }

  json_value <- jsonlite::toJSON(value)
  style_id <- paste0("#", id)

  htmltools::div(
    id = id,
    htmltools::tags$script(src = "https://cdn.jsdelivr.net/npm/apexcharts", type = "text/javascript"),
    htmltools::tags$script(src = system.file("www/sc.js", package = "ChartPackage"), type = "text/javascript"),
    htmltools::tags$script(
      HTML(paste0(
        'var options = {
           series: ', json_value, ',
           chart: {
             height: 320,
             type: "radialBar",
             toolbar: {
               show: true
             }
           },
           plotOptions: {
             radialBar: {
               startAngle: -180,
               endAngle: 177,
               hollow: {
                 margin: 0,
                 size: "60%",
                 background: "#fff",
                 dropShadow: {
                   enabled: true,
                   top: 3,
                   left: 0,
                   blur: 4,
                   opacity: 0.24
                 }
               },
               track: {
                 background: "#fff",
                 strokeWidth: "67%",
                 dropShadow: {
                   enabled: true,
                   top: -3,
                   left: 0,
                   blur: 4,
                   opacity: 0.35
                 }
               },
               dataLabels: {
                 name: {
                   offsetY: 0,
                   show: true,
                   color: "#888",
                   fontSize: "17px"
                 },
                 value: {
                   formatter: function(val) {
                     return parseInt(val);
                   },
                   color: "#111",
                   fontSize: "25px",
                   show: true
                 }
               }
             }
           },
           fill: {
             type: "gradient",
             gradient: {
               shade: "dark",
               type: "horizontal",
               shadeIntensity: 0.5,
               gradientToColors: ["#012587"],
               inverseColors: true,
               opacityFrom: 1,
               opacityTo: 1,
               stops: [0, 100]
             }
           },
           stroke: {
             lineCap: "round"
           },
           labels: ["Percent"]
         };

         var chart = new ApexCharts(document.querySelector("', style_id, '"), options);
         chart.render();'
      ))
    )
  )
}

# additinalDonutChart<- function(...){
#
#   args <- list(...)
#   num_args <- length(args)
#
#   if (!is.character(args[[1]])) {
#     stop("First argument must be a character")
#   }
#   if (!is.data.frame(args[[2]])) {
#     stop("Second argument must be a data frame")
#   }
#
#   df <- args[[2]]
#   if(!ncol(df)==2){
#     stop("Dosen't match the number of column in data frame")
#   }
#   if (!is.numeric(df[, 2])) {
#     stop("Non-numarical values exsist in data column")
#   }
#   series <- df[, 2]
#   lables <- df[, 1]
#
#   json_lable <- toJSON(lables)
#   json_data <- toJSON(series)
#
#   if (num_args == 2) {
#     div(
#       id = args[[1]],
#       style = "height: 400px;",
#       tags$script(
#         src = "https://cdn.jsdelivr.net/npm/apexcharts",
#         type = "text/javascript"
#       ),
#       tags$script(
#         HTML(
#           paste0('
#           var options1 = {
#             series: ',json_data,',
#             labels: ',json_lable,',
#             chart: {
#               type: `donut`,
#               height: 400,
#             },
#             title: {
#               text: ""
#             },
#             dataLabels: {
#               enabled: true
#             },
#             fill: {
#               type: `gradient`,
#             },
#             legend: {
#               formatter: function (val, opts) {
#                 return val + " - " + opts.w.globals.series[opts.seriesIndex]
#               },
#               position: `bottom`
#             },
#             responsive: [{
#               breakpoint: 768,
#               options: {
#                 chart: {
#                   width: 600
#                 },
#                 dataLabels: {
#                   enabled: false
#                 },
#                 legend: {
#                   position: `bottom`
#                 }
#               }
#             }]
#           };
#           var chart = new ApexCharts(document.querySelector("#',args[[1]],'"), options1);
#           chart.render();
#           var chartContainer = document.getElementById(`',args[[1]],'`);
#           var paddingTopValue = `2px`;
#           chartContainer.style.paddingTop = paddingTopValue;
#
#                  '
#           )
#         )
#       )
#
#     )
#   }
#
#   else if (num_args == 3) {
#
#     if (is.logical(args[[3]])) {
#
#       if(args[[3]]){
#         op<- c("true")
#       }else{
#         op<- c("false")
#       }
#
#       div(
#         id = args[[1]],
#         style = "height: 400px;",
#         tags$script(
#           src = "https://cdn.jsdelivr.net/npm/apexcharts",
#           type = "text/javascript"
#         ),
#         tags$script(
#           HTML(
#             paste0('
#             var options1 = {
#               series: ',json_data,',        //data array JSON Array
#               labels: ',json_lable,',        //data lables JSON Array
#               chart: {
#                 type: `donut`,
#                 height: 400,
#               },
#               title: {
#                 text: ""
#               },
#               dataLabels: {
#                 enabled: ',op,'      //Boolean
#               },
#               fill: {
#               type: `gradient`,
#               },
#               legend: {
#                 formatter: function (val, opts) {
#                   return val + " - " + opts.w.globals.series[opts.seriesIndex]
#                 },
#                 position: `bottom`
#               },
#               responsive: [{
#                 breakpoint: 768,
#                 options: {
#                   chart: {
#                     width: 600
#                   },
#                   dataLabels: {
#                     enabled: false
#                   },
#                   legend: {
#                     position: `bottom`
#                   }
#                 }
#               }]
#             };
#             var chart = new ApexCharts(document.querySelector("#',args[[1]],'"), options1);
#             chart.render();
#             var chartContainer = document.getElementById(`',args[[1]],'`);
#             var paddingTopValue = `20px`;
#             chartContainer.style.paddingTop = paddingTopValue;'
#             )
#           )
#         )
#
#       )
#
#     }
#     else if(is.character(args[[3]])){
#       div(
#         id = args[[1]],
#         style = "height: 400px;",
#         tags$script(
#           src = "https://cdn.jsdelivr.net/npm/apexcharts",
#           type = "text/javascript"
#         ),
#         tags$script(
#           HTML(
#             paste0('
#             var options1 = {
#               series: ',json_data,',        //data array JSON Array
#               labels: ',json_lable,',        //data lables JSON Array
#               chart: {
#                 type: `donut`,
#                 height: 400,
#               },
#               title: {
#                 text: "',args[[3]],'"
#               },
#               dataLabels: {
#                 enabled: true      //Boolean
#               },
#               fill: {
#               type: `gradient`,
#               },
#               legend: {
#                 formatter: function (val, opts) {
#                   return val + " - " + opts.w.globals.series[opts.seriesIndex]
#                 },
#                 position: `bottom`
#               },
#               responsive: [{
#                 breakpoint: 768,
#                 options: {
#                   chart: {
#                     width: 600
#                   },
#                   dataLabels: {
#                     enabled: false
#                   },
#                   legend: {
#                     position: `bottom`
#                   }
#                 }
#               }]
#             };
#             var chart = new ApexCharts(document.querySelector("#',args[[1]],'"), options1);
#             chart.render();
#             var chartContainer = document.getElementById(`',args[[1]],'`);
#             var paddingTopValue = `20px`;
#             chartContainer.style.paddingTop = paddingTopValue;'
#             )
#           )
#         )
#
#       )
#     }
#     else if( !is.logical(args[[3]]) && !is.character(args[[3]])){
#       stop("Third argument dosent match")
#     }
#
#   }
#
#   else if (num_args == 4){
#     if (is.logical(args[[3]])) {
#
#       if(args[[3]]){
#         op<- c("true")
#       }else{
#         op<- c("false")
#       }
#
#       div(
#         id = args[[1]],
#         style = "height: 400px;",
#         tags$script(
#           src = "https://cdn.jsdelivr.net/npm/apexcharts",
#           type = "text/javascript"
#         ),
#         tags$script(
#           HTML(
#             paste0('
#             var options1 = {
#               series: ',json_data,',        //data array JSON Array
#               labels: ',json_lable,',        //data lables JSON Array
#               chart: {
#                 type: `donut`,
#                 height: 400,
#               },
#               title: {
#                 text: ""
#               },
#               dataLabels: {
#                 enabled: ',op,'      //Boolean
#               },
#               fill: {
#               type: `gradient`,
#               },
#               legend: {
#                 formatter: function (val, opts) {
#                   return val + " - " + opts.w.globals.series[opts.seriesIndex]
#                 },
#                 position: `bottom`
#               },
#               responsive: [{
#                 breakpoint: 768,
#                 options: {
#                   chart: {
#                     width: 600
#                   },
#                   dataLabels: {
#                     enabled: false
#                   },
#                   legend: {
#                     position: `bottom`
#                   }
#                 }
#               }]
#             };
#             var chart = new ApexCharts(document.querySelector("#',args[[1]],'"), options1);
#             chart.render();
#             var chartContainer = document.getElementById(`',args[[1]],'`);
#             var paddingTopValue = `20px`;
#             chartContainer.style.paddingTop = paddingTopValue;'
#             )
#           )
#         )
#
#       )
#
#     }
#     else {
#       stop("Third argument must be boolean")
#     }
#     if(is.character(args[[4]])){
#       div(
#         id = args[[1]],
#         style = "height: 400px;",
#         tags$script(
#           src = "https://cdn.jsdelivr.net/npm/apexcharts",
#           type = "text/javascript"
#         ),
#         tags$script(
#           HTML(
#             paste0('
#             var options1 = {
#               series: ',json_data,',        //data array JSON Array
#               labels: ',json_lable,',        //data lables JSON Array
#               chart: {
#                 type: `donut`,
#                 height: 400,
#               },
#               title: {
#                 text: "',args[[3]],'"
#               },
#               dataLabels: {
#                 enabled: true      //Boolean
#               },
#               fill: {
#               type: `gradient`,
#               },
#               legend: {
#                 formatter: function (val, opts) {
#                   return val + " - " + opts.w.globals.series[opts.seriesIndex]
#                 },
#                 position: `bottom`
#               },
#               responsive: [{
#                 breakpoint: 768,
#                 options: {
#                   chart: {
#                     width: 600
#                   },
#                   dataLabels: {
#                     enabled: false
#                   },
#                   legend: {
#                     position: `bottom`
#                   }
#                 }
#               }]
#             };
#             var chart = new ApexCharts(document.querySelector("#',args[[1]],'"), options1);
#             chart.render();
#             var chartContainer = document.getElementById(`',args[[1]],'`);
#             var paddingTopValue = `20px`;
#             chartContainer.style.paddingTop = paddingTopValue;'
#             )
#           )
#         )
#
#       )
#     }
#     else {
#       stop("Forth argument must be character")
#     }
#   }
#
#   else{
#     stop("Only four argument are accepted")
#   }
#
# }
