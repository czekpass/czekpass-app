import "bootstrap";
import $ from 'jquery'

import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import 'mapbox-gl/dist/mapbox-gl.css';

// import { bootstrapStudio } from "../plugins/bootstrapstudio"

import { initMapbox } from '../plugins/init_mapbox';
// import { initAutocomplete } from '../plugins/init_autocomplete';

initMapbox();
// bootstrapStudio(jQuery);
