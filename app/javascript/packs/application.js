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

initMapbox();
timeFormSubmission();
// bootstrapStudio(jQuery);

initChartArea()
initChartPie()
initChartPieRevCat()
initChartBar()
initChartBarRevenue()
initDataTable($)
initSbAdmin($)

