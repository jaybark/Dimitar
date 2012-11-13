var map;

//wax.tilejson('http://api.tiles.mapbox.com/v2/mapbox.geography-class.jsonp',
	//'http://a.tiles.mapbox.com/v3/diroru.QypeAntiquesTest.jsonp'
wax.tilejson('http://api.tiles.mapbox.com/v2/diroru.QypeAntiquesTest.jsonp',
  function(tilejson) {
map = L.map('map', {
	center : [52.52, 13.4],
	zoom : 13
	});
});