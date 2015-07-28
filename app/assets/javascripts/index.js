$(function() {

  L.mapbox.accessToken = 'pk.eyJ1IjoiY2pveWJsdXYiLCJhIjoiNzQ3MWQzMjNiOGI2ZDQzOTJhNGFlY2YyMzZiMjg5NDIifQ.A6YxoDaBVo73wIutjHFrQg';
  // var map = L.mapbox.map('map', 'cjoybluv.n0012j3j');
  var map = L.mapbox.map('map', 'cjoybluv.n0012j3j');

  // Initialize the geocoder control and add it to the map.
  var geocoderControl = L.mapbox.geocoderControl('mapbox.places');
  geocoderControl.addTo(map);

  var markers = [];

  console.log('on load', gon.customers);

  // lat.lng  47.600 - 47.700
  //          -122.300 - -122.400

  // var markers = [];
  // var locations = [
  //   [-122.32421142292, 47.617371603574],
  //   [-122.33421142292, 47.619371603574],
  //   [-122.31431142292, 47.618471603574],
  //   [-122.34411142292, 47.616271603574],
  // ];

  for (var c=0;c<gon.customers.length;c++) {

    var lngLat = [gon.customers[c].lnglat.split(',')[0],gon.customers[c].lnglat.split(',')[1]];
    var placeName = gon.customers[c].address;
    var placeTitle = gon.customers[c].name;



    var marker = L.mapbox.featureLayer({
        // this feature is in the GeoJSON format: see geojson.org
        // for the full specification
        type: 'Feature',
        geometry: {
            type: 'Point',
            // coordinates here are in longitude, latitude order because
            // x, y is the standard for GeoJSON and many formats
            coordinates: lngLat
        },
        properties: {
            title: placeTitle,
            description: placeName,
            // one can customize markers by adding simplestyle properties
            // https://www.mapbox.com/guides/an-open-platform/#simplestyle
            'marker-size': 'small',
            'marker-color': '#B70911'
            // 'marker-symbol': 'cafe'
        }
    }).addTo(map);
    markers.push(marker);
  }

  console.log('markers:',markers);

  map.on('popupopen',function(centerMarker) {
      map.panTo([centerMarker.popup._latlng.lat,centerMarker.popup._latlng.lng]);

      console.log('popupopen',centerMarker.popup._latlng);
      console.log('lat:',centerMarker.popup._latlng.lat);
      console.log('lng:',centerMarker.popup._latlng.lng);
  });


  $('#mapButton').on('click', function(e) {
    console.log('mapButton Clicked!',e,markers);
    for (var c=0;c<gon.customers.length;c++) {
      map.removeLayer(markers[c]);
    }
  });





});