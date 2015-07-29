$(function() {



  L.mapbox.accessToken = 'pk.eyJ1IjoiY2pveWJsdXYiLCJhIjoiNzQ3MWQzMjNiOGI2ZDQzOTJhNGFlY2YyMzZiMjg5NDIifQ.A6YxoDaBVo73wIutjHFrQg';
  var map = L.mapbox.map('map', 'cjoybluv.n0012j3j')
      .setView([47.613968, -122.335195], 12);

  // Initialize the geocoder control and add it to the map.
  var geocoderControl = L.mapbox.geocoderControl('mapbox.places');
  geocoderControl.addTo(map);

  var markers = [];

  console.log('on load', gon.customers);

  // lat.lng  47.600 - 47.700     SEATTLE ZONE
  //          -122.300 - -122.400


  // LOAD MARKERS
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

  $('.BD2Go-marker').on('click', function(e) {
    // alert('marker clicked!');
    // noteId = e.toElement.parentElement.parentElement.parentElement.id;
    // markerTitle = gon.customers.find(gon.notes.find(noteId).customer_id).name;
    // console.log('noteId',noteId,'markerTitle',markerTitle);
    // console.log(e.toElement.parentElement.parentNode.innerText);
    // console.log(markers[10]._geojson.properties.title,markers.length);
    // console.log(markers[10]._geojson.properties.title,markers.length;
    var targetTitle = e.toElement.parentElement.parentNode.innerText;
    for (var m=0;m<markers.length;m++) {
      if (markers[m]._geojson.properties.title==targetTitle) {
        console.log("Target Found for: "+targetTitle);
        markers[m].openPopup();
      }
    }
  });



});