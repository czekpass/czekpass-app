import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const fitMapToLocation = (map, coords) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([coords.lng, coords.lat]);
  // console.log(map);
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

function getCoords(map, position) {
  const coords = {
    lng: position.coords.longitude,
    lat: position.coords.latitude
  }

  fitMapToLocation(map, coords);
}

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  if (markers.length >= 1) {
    markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

        new mapboxgl.Marker()
            .setLngLat([marker.lng, marker.lat])
            .setPopup(popup)
            .addTo(map);
    });
  } else {
      const popup = new mapboxgl.Popup().setHTML(markers.infoWindow); // add this

      new mapboxgl.Marker()
          .setLngLat([markers.lng, markers.lat])
          .setPopup(popup)
          .addTo(map);
  }
};

// CUT this****

// const addMarkersToMap = (map, markers) => {
//   markers.forEach((marker) => {
//     new mapboxgl.Marker()
//       .setLngLat([ marker.lng, marker.lat ])
//       .addTo(map);
//   });
// };

//********

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    window.showmap = map
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    // loc is the button on the view page
    loc.addEventListener('click', (e) => {
      window.navigator.geolocation.getCurrentPosition(
        (position) => {
          getCoords(map, position)
        },
        (err) => {
          console.error(err)
        }
      );
    })
  }
};

// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
// // [...]
// if (mapElement) {
//   // [...]
//   map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken }));
// }

export { initMapbox };
