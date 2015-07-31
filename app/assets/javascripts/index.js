
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

  var pinCustomer = function(customer) {
    // console.log(customer);
    var lngLat = [customer.lnglat.split(',')[0],customer.lnglat.split(',')[1]];
    var placeName = customer.address;
    var placeTitle = customer.name;
    var marker = L.mapbox.featureLayer({
        type: 'Feature',
        geometry: {
            type: 'Point',
            coordinates: lngLat
        },
        properties: {
            title: placeTitle,
            description: placeName,
            'marker-size': 'medium',
            'marker-color': '#B70911'
        }
    }).addTo(map);
    markers.push(marker);
  };

  // LOAD MARKERS
  for (var c=0;c<gon.customers.length;c++) {
    var pin = pinCustomer(gon.customers[c]);
  }
  for (var n=0;n<gon.notes.length;n++) {
    var customer = gon.customersAll.filter(function (customer) {
      if (customer.id==gon.notes[n].customer_id) {
        return true;
      } else {
        return false;
      }
    });
    console.log('load note markers : customer',customer);
    if (customer.length>0) {
      var pin = pinCustomer(customer[0]);
    }

  }

  // console.log('markers:',markers);

  map.on('popupopen',function(centerMarker) {
    var latAdj = (.017 * 12) / (map.getZoom() * 14);
    map.panTo([centerMarker.popup._latlng.lat+latAdj,centerMarker.popup._latlng.lng]);
    console.log(map.getZoom(),latAdj);
  });


  $('#mapButton').on('click', function(e) {
    console.log('mapButton Clicked!',e,markers);
    for (var c=0;c<gon.customers.length;c++) {
      map.removeLayer(markers[c]);
    }
  });


  $('.BD2Go-marker').on('click', function(e) {
    var noteId = e.currentTarget.dataset.noteid;
    console.log('BD2Go-marker:click : noteId',noteId);
    console.log('BD2Go-marker:click : gon.customers',gon.customers);
    var targetTitle = '';
    if (typeof noteId !== 'undefined') {
      console.log(gon.notes);
      var note = gon.notes.filter(function (note) {
        if (note.id == noteId) {
          return true;
        } else {
          return false;
        }
      });
      var customerId = note[0].customer_id;
      var customer = gon.customersAll.filter(function (customer) {
        if (customer.id == customerId) {
          return true;
        } else {
          return false;
        }
      });
      if (customer.length>0) {
        targetTitle = customer[0].name;
      }
    } else {
      var targetTitle = e.toElement.dataset.title;
    }
    if (targetTitle !== '') {
      for (var m=0;m<markers.length;m++) {
        if (markers[m]._geojson.properties.title==targetTitle) {
          map.panTo([markers[m]._geojson.geometry.coordinates[1],markers[m]._geojson.geometry.coordinates[0]]);
          markers[m].openPopup();
        }
      }
    }
  });

  $('.completed-button').on('click', function(e) {
    var noteId = e.currentTarget.dataset.id;
    console.log('completed button clicked',notedId);
  });



  // Listen for the `found` result and display the first result
  // in the output container. For all available events, see
  // https://www.mapbox.com/mapbox.js/api/v2.2.1/l-mapbox-geocodercontrol/#section-geocodercontrol-on
  geocoderControl.on('found', function(res) {

      var lngLat = res.results.features[0]['center'];
      var placeName = res.results.features[0]['place_name'];

      // output.innerHTML = JSON.stringify(res.results.features[0]);
      // output.innerHTML = ('lng,lat: '+lngLat+'    placeName: '+placeName);


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
              title: 'User geoCode Location',
              description: placeName,
              // one can customize markers by adding simplestyle properties
              // https://www.mapbox.com/guides/an-open-platform/#simplestyle
              'marker-size': 'medium',
              'marker-color': '#1DAD23',
              'marker-symbol': 'bar'
          }
      }).addTo(map);
  });
  // end of geoCoder.FOUND >> pin it

});