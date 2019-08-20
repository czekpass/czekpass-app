import "bootstrap";
import $ from 'jquery';
import Chart from "chart.js";
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import 'mapbox-gl/dist/mapbox-gl.css';
import { initChartArea } from "../plugins/chart-area"
import { initChartPie } from "../plugins/chart-pie"
import { initChartBar } from "../plugins/chart-bar"
import { initDataTable } from "../plugins/datatable"
// import { bootstrapStudio } from "../plugins/bootstrapstudio"

import { initMapbox } from '../plugins/init_mapbox';
// import { initAutocomplete } from '../plugins/init_autocomplete';

initMapbox();
// bootstrapStudio(jQuery);

initChartArea()
initChartPie()
initChartBar()
initDataTable($)