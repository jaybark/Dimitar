var stw = new L.StamenTileLayer("watercolor");



var map;

//wax.tilejson('http://api.tiles.mapbox.com/v2/mapbox.geography-class.jsonp',
	//'http://a.tiles.mapbox.com/v3/diroru.QypeAntiquesTest.jsonp'
wax.tilejson('http://api.tiles.mapbox.com/v2/diroru.QypeAntiquesTest.jsonp',
//wax.tilejson('http://api.tiles.mapbox.com/v2/mapbox.geography-class.jsonp',
  function(tilejson) {
    map = new L.Map('map')
      .addLayer(new wax.leaf.connector(tilejson))
      .setView(new L.LatLng(52.52, 13.4), 1);

});



var markerList = jQuery.parseJSON({
"name":"Kunst & Antikmarkt am Kupergraben",
"lon":"52.5215",
"lat":"13.3939",
"details":"3"
}
,	{
"name":"Alte Schilder, Dosen, Flaschen",
"lon":"52.5202",
"lat":"13.3906",
"details":"5"
}
,	{
"name":"L. Waroschitz",
"lon":"52.5201",
"lat":"13.392",
"details":"0"
}
,	{
"name":"Strobel's Raritäten Antikmarkt",
"lon":"52.5167",
"lat":"13.4065",
"details":"0"
}
,	{
"name":"Antiquitäten Martina Brown",
"lon":"52.52",
"lat":"13.3911",
"details":"0"
}
,	{
"name":"Claudia & Mike Antiquitäten",
"lon":"52.5201",
"lat":"13.3892",
"details":"0"
}
,	{
"name":"brillenschatz",
"lon":"52.5234",
"lat":"13.4114",
"details":"0"
}
,	{
"name":"asdf",
"lon":"52.5234",
"lat":"13.4114",
"details":"0"
}
,	{
"name":"designpanoptikum - museum für skurrile objekte",
"lon":"52.528",
"lat":"13.3909",
"details":"5"
}
,	{
"name":"Antiquitäten Rola",
"lon":"52.5295",
"lat":"13.3992",
"details":"4"
}
);

for(i=0;i<markerList.length;i++){
	L.marker([markerList[i].lon,markerList[i].lat]).addTo(map);
}

var customIcon = new L.Icon( {
	iconUrl: 'images/thonet_marker_002.png',
	iconSize: [53, 51],
	iconAnchor: [27, 51],
	popupAnchor: [0, 0],
	shadowUrl: 'images/thonet_marker_002_shadow.png',
	shadowSize: [83, 51],
	shadowAnchor: [27, 51]
});

L.marker([52.52, 13.4], {icon: customIcon }).addTo(map);