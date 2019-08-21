import "bootstrap";
import $ from 'jquery';

import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import 'mapbox-gl/dist/mapbox-gl.css';

// import { bootstrapStudio } from "../plugins/bootstrapstudio"

import { initMapbox } from '../plugins/init_mapbox';
import { timeFormSubmission } from '../components/time_form';
// import { initAutocomplete } from '../plugins/init_autocomplete';

initMapbox();
timeFormSubmission();
// bootstrapStudio(jQuery);

