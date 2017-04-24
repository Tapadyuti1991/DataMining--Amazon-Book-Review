<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Economic Analytics</title>
        <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
        <script type="text/javascript" src="http://d3js.org/d3.v2.min.js"></script>
        <style type="text/css">

            body {
                font: 12px sans-serif;
            }

            .axis path,
            .axis line {
                fill: none;
                stroke: #000;
                shape-rendering: crispEdges;
            }

            .x.axis path {
                fill: none;
                stroke: #000;
                shape-rendering: crispEdges;
            }

            .line {
                fill: none;
                stroke-width: 7px;
            }

            .country {opacity: 0.5;}
            .country:hover {opacity:1;}
            </style>
               <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <link href="resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="resources/dist/css/sb-admin-2.css" rel="stylesheet">


        <!-- Custom Fonts -->
        <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js"></script>
    </head>
<body>

        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Economic Analytics Dashboard</a>
                </div>
                <!-- /.navbar-header -->

                <ul class="nav navbar-top-links navbar-right">

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                            </li>
                            <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                            </li>
                            <li class="divider"></li>
                            <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                            </li>
                        </ul>
                        <!-- /.dropdown-user -->
                    </li>
                    <!-- /.dropdown -->
                </ul>
                <!-- /.navbar-top-links -->

                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">

                            <li>
                                <a href="index"><i class="fa fa-bar-chart-o fa-fw"></i>Economy Analytics For USA</a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="index">GDP Prediction</a>
                                    </li>
                                    <li>
                                        <a href="flot">Analysis of Economic Indicators</a>
                                    </li>
                                </ul>   
                            </li>
                            <li>
                                <a href="morris"><i class="fa fa-bar-chart-o fa-fw"></i> Economy Analytics For India<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                   
                                    <li>
                                        <a href="morris">Prediction</a>
                                    </li>
                                    <li>
                                        <!--                                        <a href="morris.html">Morris.js Charts</a>-->
                                    </li>
                                </ul>
                                <!-- /.nav-second-level -->
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Comparing Indian and USA Economies<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="comparing">Comparison Analysis</a>
                                    </li>
                                    
                                </ul>
                                <!-- /.nav-second-level -->
                            </li>
<!--                            <li>
                                <a href="tables.html"><i class="fa fa-table fa-fw"></i>Data Tables</a>
                            </li>-->
                            
                            <li>
                                <a href="sentiment"><i class="fa fa-wrench fa-fw"></i> Sentiment Analysis over Different Economic Issues<span class="fa arrow"></span></a>
                                
                                <!-- /.nav-second-level -->
                            </li>
                            <li>
                                <a href="dictionary"><i class="fa fa-edit fa-fw"></i> Economipedia</a>
                            </li>

                        </ul>
                    </div>

                </div>

            </nav>

            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Comparison of Different Economic Indicators for India and USA</h1>
                    </div>
                </div>
              
                <div class="row">
                    <div class="col-lg-7">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="fa fa-bar-chart-o fa-fw"></i>Comparison in various indicators from 1996-2014
                                <div class="pull-right">
                                    Select series:<select>
                                        <option value="Percent_Change_GDP">GDP growth (in %)</option>
                                        <option value="Inflation_Rate">Inflation Rate (in %)</option>
                                        <option value="Unemployment">Unemployment Rate (in %)</option>
                                    </select>
                                </div>
                            </div>
                            <div id="gdpchart" class="panel-body"></div>
                        </div>
                       
                    </div>
                    <div class="col-lg-5">
                        <div class="panel panel-default">
                            <div class="panel-heading">Data Analysis</div>
                            <div class="panel-body">
                                <p>As we can observe, the growth rate of India is incredibly high in comparison to USA. When USA was affected by recession during the years 2008-2009, the growth rate of India was also impacted by that.<br><br>  The graph Inflation Rate indicates, that there was very low inflation rate during the years 1999-2005 but because of recession during 2008-2009, the inflation rate also increased.There was a tremendous decrease in inflation rate for India from 2012-2014. <br><br> The unemployment rate graph indicates, that due to recession USA witnessed a large amount of unemployed people from years 2008-2009. However, as USA recovered from the recession, the unemployment rate started recovering and decreased significantly from 2011-2014. 
                                </p></div>
                    </div>
                </div>
                </div></div></div>
           
                   <!-- jQuery -->
        <script src="resources/vendor/jquery/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="resources/vendor/metisMenu/metisMenu.min.js"></script>

        <script src="resources/vendor/raphael/raphael.min.js"></script>


        <!-- Custom Theme JavaScript -->
        <script src="resources/dist/js/sb-admin-2.js"></script>
         <script type="text/javascript">
            // set the stage for the visualization
            var margin = {top: 10, right: 80, bottom: 30, left: 50},
                    w = 660 - margin.left - margin.right,
                    h = 400 - margin.top - margin.bottom,
                    x = d3.time.scale().range([0, w]),
                    y = d3.scale.linear().range([h, 0]);
            parseDate = d3.time.format("%Y").parse;

            var color = d3.scale.category10(); // to generate a different color for each line

            // to be used later
            var countries,
                    filtered,
                    transpose;

            // where the line gets its properties, how it will be interpolated
            var line = d3.svg.line()
                    .interpolate("basis")
                    .x(function (d) {
                        return x(d.year);
                    })
                    .y(function (d) {
                        return y(d.stat);
                    });

            // add svg box where viz will go    
            var svg = d3.select("#gdpchart").append("svg")
                    .attr("width", w + margin.left + margin.right)
                    .attr("height", h + margin.top + margin.bottom)
                    .append("g")
                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            // define the x axis and its class, append it to svg 
            var xAxis = d3.svg.axis()
                    .scale(x)
                    .orient("bottom")
            svg.append("svg:g")
                    .attr("class", "x axis");

            // define the y axis and its class, append it to svg
            var yAxis = d3.svg.axis()
                    .scale(y)
                    .orient("left")
            svg.append("svg:g")
                    .attr("class", "y axis");

            // force data to update when menu is changed    
            var menu = d3.select("select")
                    .on("change", change);

            // put data from csv into countries variable
            //run redraw function that will refresh whenever a new data series is selected 
            d3.csv("resources/Book1.csv", function (csv) {
                countries = csv;
                redraw();
            });

            d3.select(window)
                    .on("keydown", function () {
                        altKey = d3.event.altKey;
                    })
                    .on("keyup", function () {
                        altKey = false;
                    });

            var altKey;

            // set terms of transition that will take place
            // when a new economic indicator is chosen   
            function change() {
                clearTimeout(timeout);

                d3.transition()
                        .duration(altKey ? 7500 : 1500)
                        .each(redraw);
            }

            // all the meat goes in the redraw function
            function redraw() {

                // create data nests based on economic indicator (series)
                var nested = d3.nest()
                        .key(function (d) {
                            return d.indicatorName;
                        })
                        .map(countries)

                // get value from menu selection
                // the option values are set in HTML and correspond
                //to the [indicatorCode] value we used to nest the data  
                var series = menu.property("value");

                // only retrieve data from the selected series, using the nest we just created
                var data = nested[series];

                // for object constancy we will need to set "keys", one for each country.
                // the keyring variable contains only the names of the countries
                var keyring = d3.keys(data[0]).filter(function (key) {
                    return (key !== "indicatorName" && key !== "year" && key !== "quarter");
                });

                // get the year and related statistics, map them to each country separately 
                var transpose = keyring.map(function (name) {
                    return {
                        name: name,
                        values: data.map(function (d) {
                            return {year: parseDate(d.year), stat: +d[name]};
                        })
                    };
                });

                // set the x and y domains as the max and min
                // of the related year and statistics, respectively
                x.domain([
                    d3.min(transpose, function (c) {
                        return d3.min(c.values, function (v) {
                            return v.year;
                        });
                    }),
                    d3.max(transpose, function (c) {
                        return d3.max(c.values, function (v) {
                            return v.year;
                        });
                    })
                ]);

                y.domain([
                    d3.min(transpose, function (c) {
                        return d3.min(c.values, function (v) {
                            return v.stat;
                        });
                    }),
                    d3.max(transpose, function (c) {
                        return d3.max(c.values, function (v) {
                            return v.stat;
                        });
                    })
                ]);

                // announce to d3 that we will be using something called
                // "country" that makes use of the transposed data 
                var country = svg.selectAll(".country")
                        .data(transpose);

                // create separate groups for each country
                // assign them a class and individual IDs (for styling) 
                var countryEnter = country.enter().append("g")
                        .attr("class", "country")
                        .attr("id", function (d) {
                            return d.name;
                        });

                // draw the lines and color them according to their names
                countryEnter.append("path")
                        .attr("class", "line")
                        .attr("d", function (d) {
                            return line(d.values);
                        })
                        .style("stroke", function (d) {
                            return color(d.name);
                        });

                // create lables for each country
                // set their position to that of the last year and stat
                countryEnter.append("text")
                        .attr("class", "names")
                        .datum(function (d) {
                            return {name: d.name, value: d.values[d.values.length - 1]};
                        })
                        .attr("transform", function (d) {
                            return "translate(" + x(d.value.year) + "," + y(d.value.stat) + ")";
                        })
                        .attr("x", 4)
                        .attr("dy", ".35em")
                        .text(function (d) {
                            return d.name;
                        });

                // set variable for updating visualization
                var countryUpdate = d3.transition(country);

                // change values of path to those of the new series
                countryUpdate.select("path")
                        .attr("d", function (d) {
                            return line(d.values);
                        });

                // change position of text alongside the moving path  
                countryUpdate.select("text")
                        .attr("transform", function (d) {
                            return "translate(" + x(d.values[d.values.length - 1].year) + "," + y(d.values[d.values.length - 1].stat) + ")";
                        });

                // update the axes, though only the y axis will change    
                d3.transition(svg).select(".y.axis")
                        .call(yAxis);

                d3.transition(svg).select(".x.axis")
                        .attr("transform", "translate(0," + h + ")")
                        .call(xAxis);

                // that concludes redraw()
            }

            // automatically change value after a few seconds
            var timeout = setTimeout(function () {
                //menu.property("value", "ENEUSE").node().focus();
                change();
            }, 7000);

            // ugly javascript for highlighting the two groups of countries

            // done!
        </script>
</body>
</html>