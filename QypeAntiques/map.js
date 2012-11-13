var map;

//wax.tilejson('http://api.tiles.mapbox.com/v2/mapbox.geography-class.jsonp',
	//'http://a.tiles.mapbox.com/v3/diroru.QypeAntiquesTest.jsonp'
wax.tilejson('http://api.tiles.mapbox.com/v3/diroru.QypeAntiquesTest.jsonp',
  function(tilejson) {
    map = new L.map('map')
      .addLayer(new wax.leaf.connector(tilejson))
      .setView(new L.LatLng(52.52, 13.4), 13);
});