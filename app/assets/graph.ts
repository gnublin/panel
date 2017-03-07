import * as d3 from 'd3'

export function init() {
  console.log(d3)
  var dataset = [ 5, 10, 65, 45, 75 ];
  d3.select("#chart_area")
  .data(dataset)
  .enter()
  .append("div")
  .attr("class", "one-bar")
  .append("div")
  .attr("class", "bar")
  .style("width", function(d) {
    return d + "px";
  });
}
