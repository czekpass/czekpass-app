import "bootstrap";
import $ from 'jquery';

import Chart from "chart.js";

import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import 'mapbox-gl/dist/mapbox-gl.css';
import { initChartArea } from "../plugins/chart-area"
import { initChartPie } from "../plugins/chart-pie"
import { initChartPieRevCat } from "../plugins/chart-pie-rev-cat"
import { initChartBar } from "../plugins/chart-bar"
import { initChartBarRevenue } from "../plugins/chart-bar-revenue"
import { initDataTable } from "../plugins/datatable"
import { initSbAdmin } from "../plugins/sbadmin"
// import { bootstrapStudio } from "../plugins/bootstrapstudio"

import { initMapbox } from '../plugins/init_mapbox';
import { timeFormSubmission } from '../components/time_form';
// import { initAutocomplete } from '../plugins/init_autocomplete';

timeFormSubmission();
// bootstrapStudio(jQuery);

initSbAdmin($);
initDataTable($);
initChartArea();
initChartPie();
initChartPieRevCat();
initChartBar();
initChartBarRevenue();
initMapbox();


const table = document.querySelector("#dataTable")
if(table){
  $('#dataTable').dataTable({autoWidth: true, searching: false, paging: false, info: false, scrollX: false});
}

const btn = document.querySelector("#sidebarToggleTop")

if (btn){
  const mapElement = document.getElementById('map');
  if(mapElement){
    btn.addEventListener("click", ()=>{
      showmap.resize()
    })
  }
}
