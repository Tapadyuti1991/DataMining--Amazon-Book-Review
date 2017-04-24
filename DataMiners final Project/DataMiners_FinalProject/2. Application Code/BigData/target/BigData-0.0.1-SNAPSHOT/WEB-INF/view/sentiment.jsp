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
        <script src="//d3js.org/d3.v4.min.js"></script>
        <style> /* set the CSS */

.bar { fill: steelblue; }

</style>
        <!-- Bootstrap Core CSS -->
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
                    <a class="navbar-brand" href="index">Economic Analytics Dashboard</a>
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
                        <h1 class="page-header">Sentiment Analysis Over Different Economic Issues</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-7">

                        <div class="panel panel-default">
                            <div class="panel-heading">Word Cloud For Recession in USA During 2008-2009</div>
                            <div class="panel-body">
                                <img src="resources/Screen Shot 2016-12-16 at 10.52.05 PM.png" style="width:80%;margin-left:10%">
                            </div>
                        </div></div>
                    <div class="col-lg-5">

                        <div class="panel panel-default">
                            <div class="panel-heading">Sentiment of People Over Recession</div> 
                            <div class="panel-body">
                                <div id="recession"></div>
                            </div>
                        </div></div>    
                </div>
                    
                <div class="row">
                    <div class="col-lg-7">

                        <div class="panel panel-default">
                            <div class="panel-heading">Word Cloud For Demonetization in India</div>
                            <div class="panel-body">
                                <img src="resources/Screen Shot 2016-12-16 at 10.51.19 PM.png" style="width:80%; margin-left: 10%">
                            </div>
                        </div></div>
                    <div class="col-lg-5">

                        <div class="panel panel-default">
                            <div class="panel-heading">Sentiment of People Over Demonetization</div> 
                            <div class="panel-body">
                                <div id="demonetization"></div>
                            </div>
                        </div></div>    
                </div>
            </div></div>
        <!-- jQuery -->
        <script src="resources/vendor/jquery/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="resources/vendor/metisMenu/metisMenu.min.js"></script>

        <script src="resources/vendor/raphael/raphael.min.js"></script>


        <!-- Custom Theme JavaScript -->
        <script src="resources/dist/js/sb-admin-2.js"></script>

<script src="//d3js.org/d3.v4.min.js"></script>
<script>

// set the dimensions and margins of the graph
var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 400 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

// set the ranges
var x = d3.scaleBand()
          .range([0, width])
          .padding(0.1);
var y = d3.scaleLinear()
          .range([height, 0]);
          
// append the svg object to the body of the page
// append a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg1 = d3.select("#demonetization").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", 
          "translate(" + margin.left + "," + margin.top + ")");
var svg = d3.select("#recession").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", 
          "translate(" + margin.left + "," + margin.top + ")");

d3.csv("resources/count_india.csv", function(error, data) {
  if (error) throw error;

  // format the data
  data.forEach(function(d) {
    d.Frequency = +d.Frequency;
  });

  // Scale the range of the data in the domains
  x.domain(data.map(function(d) { return d.vector_sentiments; }));
  y.domain([0, d3.max(data, function(d) { return d.Frequency; })]);

  // append the rectangles for the bar chart
  svg1.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.vector_sentiments); })
      .attr("width", x.bandwidth())
      .attr("y", function(d) { return y(d.Frequency); })
      .attr("height", function(d) { return height - y(d.Frequency); });

  // add the x Axis
  svg1.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // add the y Axis
  svg1.append("g")
      .call(d3.axisLeft(y));

});
// get the data
d3.csv("resources/data.csv", function(error, data) {
  if (error) throw error;

  // format the data
  data.forEach(function(d) {
    d.Frequency = +d.Frequency;
  });

  // Scale the range of the data in the domains
  x.domain(data.map(function(d) { return d.vector_sentiments; }));
  y.domain([0, d3.max(data, function(d) { return d.Frequency; })]);

  // append the rectangles for the bar chart
  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.vector_sentiments); })
      .attr("width", x.bandwidth())
      .attr("y", function(d) { return y(d.Frequency); })
      .attr("height", function(d) { return height - y(d.Frequency); });

  // add the x Axis
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // add the y Axis
  svg.append("g")
      .call(d3.axisLeft(y));

});

</script>
    </body></html>