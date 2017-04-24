//var fjson={};
var margin = {top: 5, right: 0, bottom: 0, left: 0};
var data,regionData=[];
var currentYear = 2015, // default year
	yearArray=[1955,1965,1975,1985,2005,2015],
	timer = null,
	changeYearDelay= 1200;
	playYearDelay = 2400;
var margin = {top: 20, right: 40, bottom: 10, left: 20},
	width = 300,
	height = 100 - margin.top - margin.bottom;
var regionMinuteMax,regionMessageMax,regionRevenueMax,regionDataMinute,regionDataMessage,regionDataRevenue;
var countryMinuteMax,countryMessageMax,countryRevenueMax,countryDataMinute,countryDataMessage,countryDataRevenue;
var format = d3.format(",");

var xMessage = d3.scale.linear().range([0, width]);
var xMinute = d3.scale.linear().range([0, width]);
var xRevenue = d3.scale.linear().range([0, width]);
var xMessageCountry = d3.scale.linear().range([0, width]);
var xMinuteCountry = d3.scale.linear().range([0, width]);
var xRevenueCountry = d3.scale.linear().range([0, width]);

var yMinute = d3.scale.ordinal()
	.rangeRoundBands([0, height], .1);
var yMessage = d3.scale.ordinal()
.rangeRoundBands([0, height], .1);
var yRevenue = d3.scale.ordinal()
	.rangeRoundBands([0, height], .1);
var yMinuteCountry = d3.scale.ordinal()
.rangeRoundBands([0, height], .1);
var yMessageCountry = d3.scale.ordinal()
.rangeRoundBands([0, height], .1);
var yRevenueCountry = d3.scale.ordinal()
.rangeRoundBands([0, height], .1);

var xMessageAxis = d3.svg.axis()
	.scale(xMessage)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);
var xMinuteAxis = d3.svg.axis()
	.scale(xMinute)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);
var xRevenueAxis = d3.svg.axis()
	.scale(xRevenue)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);
var xMessageCountryAxis = d3.svg.axis()
	.scale(xMessageCountry)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);
var xMinuteCountryAxis = d3.svg.axis()
	.scale(xMinuteCountry)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);
var xRevenueCountryAxis = d3.svg.axis()
	.scale(xRevenueCountry)
	.orient("top")
	.tickSize(-height - margin.bottom)
	.tickFormat(format);

var svgMinute = d3.select("#regionMinuteChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
svgMinute.append("g").attr("class", "x axis");
svgMinute.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

var svgMessage = d3.select("#regionMessageChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top +")");
svgMessage.append("g").attr("class", "x axis");
svgMessage.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

var svgRevenue = d3.select("#regionRevenueChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top +")");
svgRevenue.append("g").attr("class", "x axis");
svgRevenue.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

var svgMinuteCountry = d3.select("#countryMinuteChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
svgMinuteCountry.append("g").attr("class", "x axis");
svgMinuteCountry.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

var svgMessageCountry = d3.select("#countryMessageChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top +")");
svgMessageCountry.append("g").attr("class", "x axis");
svgMessageCountry.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

var svgRevenueCountry = d3.select("#countryRevenueChart").append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	/*.style("margin-left", -margin.left + "px")*/
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top +")");
svgRevenueCountry.append("g").attr("class", "x axis");
svgRevenueCountry.append("g")
	.attr("class", "y axis")
	.append("line")
	.attr("class", "domain")
	.attr("y2", height);

function redrawRegion() {
	  yMinute.domain(regionDataMinute.map(function(d) { return d.RegionName; }));
	  var barMinute = svgMinute.selectAll(".bar")
	      .data(regionDataMinute, function(d) { return d.RegionName; });

	  var barMinuteEnter = barMinute.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yMinute(d.RegionName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barMinuteEnter.append("rect")
	      .attr("width", function(d) {return xMinute(parseFloat(d.RegionTotals.population)); })
	      .attr("height", yMinute.rangeBand());

	  barMinuteEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yMinute.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.RegionName; });

	  barMinuteEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xMinute(parseFloat(d.RegionTotals.population)) - 3; })
	      .attr("y", yMinute.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barMinuteUpdate = d3.transition(barMinute)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yMinute(d.RegionName)) + ")"; })
	      .style("fill-opacity", 1);

	  barMinuteUpdate.select("rect")
	      .attr("width", function(d) { return xMinute(parseFloat(d.RegionTotals.population)); });
	  


	  barMinuteUpdate.select(".value")
	      .attr("x", function(d) { return xMinute(parseFloat(d.RegionTotals.population)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.RegionTotals.population))); });

	  var barMinuteExit = d3.transition(barMinute.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barMinuteExit.select("rect")
	      .attr("width", function(d) { return xMinute(parseFloat(d.RegionTotals.population)); });

	  barMinuteExit.select(".value")
	      .attr("x", function(d) { return xMinute(parseFloat(d.RegionTotals.population)) - 3; })
	      .text(function(d) { return format(parseFloat(d.RegionTotals.population)); });

	  d3.transition(svgMinute).select(".x.axis")
	      .call(xMinuteAxis);
	  
	  //for message
	  yMessage.domain(regionDataMessage.map(function(d) { return d.RegionName; }));
	  var barMessage = svgMessage.selectAll(".bar")
	      .data(regionDataMessage, function(d) { return d.RegionName; });

	  var barMessageEnter = barMessage.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yMessage(d.RegionName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barMessageEnter.append("rect")
	      .attr("width", function(d) {return xMessage(parseFloat(d.RegionTotals.ppi)); })
	      .attr("height", yMessage.rangeBand());

	  barMessageEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yMessage.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.RegionName; });

	  barMessageEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xMessage(parseFloat(d.RegionTotals.ppi)) - 3; })
	      .attr("y", yMessage.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barMessageUpdate = d3.transition(barMessage)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yMessage(d.RegionName)) + ")"; })
	      .style("fill-opacity", 1);

	  barMessageUpdate.select("rect")
	      .attr("width", function(d) { return xMessage(parseFloat(d.RegionTotals.ppi)); });

	  barMessageUpdate.select(".value")
	      .attr("x", function(d) { return xMessage(parseFloat(d.RegionTotals.ppi)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.RegionTotals.ppi))); });

	  var barMessageExit = d3.transition(barMessage.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barMessageExit.select("rect")
	      .attr("width", function(d) { return xMessage(parseFloat(d.RegionTotals.ppi)); });

	  barMessageExit.select(".value")
	      .attr("x", function(d) { return xMessage(parseFloat(d.RegionTotals.ppi)) - 3; })
	      .text(function(d) { return format(parseFloat(d.RegionTotals.ppi)); });

	  d3.transition(svgMessage).select(".x.axis")
	      .call(xMessageAxis);
	  
	//for revenue
	  yRevenue.domain(regionDataRevenue.map(function(d) { return d.RegionName; }));
	  var barRevenue = svgRevenue.selectAll(".bar")
	      .data(regionDataRevenue, function(d) { return d.RegionName; });

	  var barRevenueEnter = barRevenue.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yRevenue(d.RegionName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barRevenueEnter.append("rect")
	      .attr("width", function(d) {return xRevenue(parseFloat(d.RegionTotals.cpi)); })
	      .attr("height", yRevenue.rangeBand());

	  barRevenueEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yRevenue.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.RegionName; });

	  barRevenueEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xRevenue(parseFloat(d.RegionTotals.cpi)) - 3; })
	      .attr("y", yRevenue.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barRevenueUpdate = d3.transition(barRevenue)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yRevenue(d.RegionName)) + ")"; })
	      .style("fill-opacity", 1);

	  barRevenueUpdate.select("rect")
	      .attr("width", function(d) { return xRevenue(parseFloat(d.RegionTotals.cpi)); });

	  barRevenueUpdate.select(".value")
	      .attr("x", function(d) { return xRevenue(parseFloat(d.RegionTotals.cpi)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.RegionTotals.cpi))); });

	  var barRevenueExit = d3.transition(barRevenue.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barRevenueExit.select("rect")
	      .attr("width", function(d) { return xRevenue(parseFloat(d.RegionTotals.cpi)); });

	  barRevenueExit.select(".value")
	      .attr("x", function(d) { return xRevenue(parseFloat(d.RegionTotals.cpi)) - 3; })
	      .text(function(d) { return format(parseFloat(d.RegionTotals.cpi)); });

	  d3.transition(svgRevenue).select(".x.axis")
	      .call(xRevenueAxis);
	 
	}

function redrawCountry() {
	  yMinuteCountry.domain(countryDataMinute.map(function(d) { return d.CountryName; }));
	  var barMinuteCountry = svgMinuteCountry.selectAll(".bar")
	      .data(countryDataMinute, function(d) { return d.CountryName; });

	  var barMinuteCountryEnter = barMinuteCountry.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yMinuteCountry(d.CountryName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barMinuteCountryEnter.append("rect")
	      .attr("width", function(d) {return xMinuteCountry(parseFloat(d.CountryDetail.population)); })
	      .attr("height", yMinuteCountry.rangeBand());

	  barMinuteCountryEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yMinuteCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.CountryName; });

	  barMinuteCountryEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xMinuteCountry(parseFloat(d.CountryDetail.population)) - 3; })
	      .attr("y", yMinuteCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barMinuteCountryUpdate = d3.transition(barMinuteCountry)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yMinuteCountry(d.CountryName)) + ")"; })
	      .style("fill-opacity", 1);

	  barMinuteCountryUpdate.select("rect")
	      .attr("width", function(d) { return xMinuteCountry(parseFloat(d.CountryDetail.population)); });

	  barMinuteCountryUpdate.select(".value")
	      .attr("x", function(d) { return xMinuteCountry(parseFloat(d.CountryDetail.population)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.CountryDetail.population))); });

	  var barMinuteCountryExit = d3.transition(barMinuteCountry.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barMinuteCountryExit.select("rect")
	      .attr("width", function(d) { return xMinuteCountry(parseFloat(d.CountryDetail.population)); });

	  barMinuteCountryExit.select(".value")
	      .attr("x", function(d) { return xMinuteCountry(parseFloat(d.CountryDetail.population)) - 3; })
	      .text(function(d) { return format(parseFloat(d.CountryDetail.population)); });

	  d3.transition(svgMinuteCountry).select(".x.axis")
	      .call(xMinuteCountryAxis);
	  
	  //for message
	  yMessageCountry.domain(countryDataMessage.map(function(d) { return d.CountryName; }));
	  var barMessageCountry = svgMessageCountry.selectAll(".bar")
	      .data(countryDataMessage, function(d) { return d.CountryName; });

	  var barMessageCountryEnter = barMessageCountry.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yMessageCountry(d.CountryName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barMessageCountryEnter.append("rect")
	      .attr("width", function(d) {return xMessageCountry(parseFloat(d.CountryDetail.ppi)); })
	      .attr("height", yMessageCountry.rangeBand());

	  barMessageCountryEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yMessageCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.CountryName; });

	  barMessageCountryEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xMessageCountry(parseFloat(d.CountryDetail.ppi)) - 3; })
	      .attr("y", yMessageCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barMessageCountryUpdate = d3.transition(barMessageCountry)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yMessageCountry(d.CountryName)) + ")"; })
	      .style("fill-opacity", 1);

	  barMessageCountryUpdate.select("rect")
	      .attr("width", function(d) { return xMessageCountry(parseFloat(d.CountryDetail.ppi)); });

	  barMessageCountryUpdate.select(".value")
	      .attr("x", function(d) { return xMessageCountry(parseFloat(d.CountryDetail.ppi)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.CountryDetail.ppi))); });

	  var barMessageCountryExit = d3.transition(barMessageCountry.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barMessageCountryExit.select("rect")
	      .attr("width", function(d) { return xMessageCountry(parseFloat(d.CountryDetail.ppi)); });

	  barMessageCountryExit.select(".value")
	      .attr("x", function(d) { return xMessageCountry(parseFloat(d.CountryDetail.ppi)) - 3; })
	      .text(function(d) { return format(parseFloat(d.CountryDetail.ppi)); });

	  d3.transition(svgMessageCountry).select(".x.axis")
	      .call(xMessageCountryAxis);
	  
	//for revenue
	  yRevenueCountry.domain(countryDataRevenue.map(function(d) { return d.CountryName; }));
	  var barRevenueCountry = svgRevenueCountry.selectAll(".bar")
	      .data(countryDataRevenue, function(d) { return d.CountryName; });

	  var barRevenueCountryEnter = barRevenueCountry.enter().insert("g", ".axis")
	      .attr("class", "bar")
	      .attr("transform", function(d) { return "translate(0," + (yRevenueCountry(d.CountryName) + height) + ")"; })
	      .style("fill-opacity", 0);
	  
	  barRevenueCountryEnter.append("rect")
	      .attr("width", function(d) {return xRevenueCountry(parseFloat(d.CountryDetail.cpi)); })
	      .attr("height", yRevenueCountry.rangeBand());

	  barRevenueCountryEnter.append("text")
	      .attr("class", "label")
	      .attr("x", -10)
	      .attr("y", yRevenueCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end")
	      .text(function(d) { return d.CountryName; });

	  barRevenueCountryEnter.append("text")
	      .attr("class", "value")
	      .attr("x", function(d) { return xRevenueCountry(parseFloat(d.CountryDetail.cpi)) - 3; })
	      .attr("y", yRevenueCountry.rangeBand() / 2)
	      .attr("dy", ".35em")
	      .attr("text-anchor", "end");

	  var barRevenueCountryUpdate = d3.transition(barRevenueCountry)
	      .attr("transform", function(d) { return "translate(0," + (d.y0 = yRevenueCountry(d.CountryName)) + ")"; })
	      .style("fill-opacity", 1);

	  barRevenueCountryUpdate.select("rect")
	      .attr("width", function(d) { return xRevenueCountry(parseFloat(d.CountryDetail.cpi)); });

	  barRevenueCountryUpdate.select(".value")
	      .attr("x", function(d) { return xRevenueCountry(parseFloat(d.CountryDetail.cpi)) - 3; })
	      .text(function(d) {return format(Math.round(parseFloat(d.CountryDetail.cpi))); });

	  var barRevenueCountryExit = d3.transition(barRevenueCountry.exit())
	      .attr("transform", function(d) { return "translate(0," + (d.y0 + height) + ")"; })
	      .style("fill-opacity", 0)
	      .remove();

	  barRevenueCountryExit.select("rect")
	      .attr("width", function(d) { return xRevenueCountry(parseFloat(d.CountryDetail.cpi)); });

	  barRevenueCountryExit.select(".value")
	      .attr("x", function(d) { return xRevenueCountry(parseFloat(d.CountryDetail.cpi)) - 3; })
	      .text(function(d) { return format(parseFloat(d.CountryDetail.cpi)); });

	  d3.transition(svgRevenueCountry).select(".x.axis")
	      .call(xRevenueCountryAxis);
	 
	}




	
function drawYears(yearsArray){		
$('#scrubber_dates li').removeClass('valid').unbind('click');	
for (var i = 0; i < yearArray.length; i++) {
	$('#scrubber_dates li#t' + yearArray[i]).addClass('valid').click(yearClickHandler);
}
}


function drawTimeline(animateOption){
$('#scrubber_dates').find('li').removeClass('active');
$('#t' + currentYear).addClass('active');

var newScrubberXPos = ((currentYear - 1955) * 10) +5,
	$scrubberKnob = $('#scrubber_knob');	
if (animateOption) {
	$scrubberKnob.css({'display' : 'block'}).animate({'left' : newScrubberXPos}, changeYearDelay, 'linear'); 
} else {
	$scrubberKnob.css({'display' : 'block'});
}

getCurrentYearData(currentYear);


$('#play_btn').unbind('click').click(playTimeline); // also, the amount of time here should match how far away the year is, somewhat. close years seem slow, long years seem quick. or should it?
}

function playTimeline(){
	var startYear;
	if (timer == null){
		if(currentYear == 2015){
			changeYear(1955, true);
		}
		else{
			//changeYear(currentYear);
		}
		
		timer = window.setInterval(advanceTimelineYear, playYearDelay);
	}
}

function changeYear(newYear, animateOption){
	currentYear = newYear;
	drawTimeline(animateOption);
}


function advanceTimelineYear(){	
	var nextYear = parseInt(currentYear) + 1;
	changeYear(nextYear, true);	
	
	if (nextYear == 2015){
		window.clearInterval(timer);
		timer = null;
	};
}

function yearClickHandler(event){
	if(timer != null){
		window.clearInterval(timer);
		timer = null;
	}
	var clickedYear = this.id.slice(1,5);
	if (clickedYear != currentYear) {
		changeYear(clickedYear, true);
	}
}

function getCurrentYearData(cYear){
	regionDataMessage=[],regionDataMinute=[],regionDataRevenue=[];
	countryDataMessage=[],countryDataMinute=[],countryDataRevenue=[];
	data.details.forEach(function(d){
		if (d.Year == cYear){
			d.Regions.forEach(function(r){
				regionDataMessage.push(r);
				regionDataMinute.push(r);
				regionDataRevenue.push(r);
				r.RegionDetail.forEach(function(c){
					countryDataMinute.push(c);
					countryDataMessage.push(c);
					countryDataRevenue.push(c);
				})
			})			
		}
	})
	
	regionDataMinute.sort(function(a, b) { return parseFloat(b.RegionTotals.population) - parseFloat(a.RegionTotals.population); });
	regionDataRevenue.sort(function(a, b) { return parseFloat(b.RegionTotals.cpi) - parseFloat(a.RegionTotals.cpi); });
	
	countryDataMinute = countryDataMinute.sort(function(a,b){return parseFloat(b.CountryDetail.population)-parseFloat(a.CountryDetail.population);}).slice(0,10);
	
	countryDataRevenue = countryDataRevenue.sort(function(a,b){return parseFloat(b.CountryDetail.cpi)-parseFloat(a.CountryDetail.cpi);}).slice(0,10);
	
	  d3.transition()
      .duration(changeYearDelay-400)
      .each(redrawRegion);
	  
	  d3.transition()
      .duration(changeYearDelay-400)
      .each(redrawCountry);
}

function setAxisDomains(){
	regionMinuteMax = 0;
	regionMessageMax = 0;
	regionRevenueMax = 0;
	countryMinuteMax = 0;
	countryMessageMax = 0;
	countryRevenueMax = 0;

	data.details.forEach(function(d){
		d.Regions.forEach(function(r){
			regionMinuteMax = Math.max(parseFloat(r.RegionTotals.population), regionMinuteMax);
			regionMessageMax = Math.max(parseFloat(r.RegionTotals.ppi), regionMessageMax);
			regionRevenueMax = Math.max(parseFloat(r.RegionTotals.cpi), regionRevenueMax);
			
			r.RegionDetail.forEach(function(c){
				countryMinuteMax = Math.max(parseFloat(c.CountryDetail.population), countryMinuteMax);
				countryMessageMax = Math.max(parseFloat(c.CountryDetail.ppi), countryMessageMax);
				countryRevenueMax = Math.max(parseFloat(c.CountryDetail.cpi), countryRevenueMax);
			})
		}) 			
	});

	xMinute.domain([0, regionMinuteMax/80000]); 
	xMessage.domain([0, regionMessageMax/20000000]);
	xRevenue.domain([0, regionRevenueMax/1000000]);

	xMinuteCountry.domain([0, countryMinuteMax/8000000]);
	xMessageCountry.domain([0, countryMessageMax/1000000]);
	xRevenueCountry.domain([0, countryRevenueMax/50000000]);
}	

d3.json("resources/economicAnalysisD3.json", function(d){
	data = d;
	setAxisDomains();
	getCurrentYearData(currentYear);
	drawYears(yearArray);
	drawTimeline(true);
});


  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-40170701-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();