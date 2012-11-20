/**
* Kartenobjekt zu erzeugen
* Reihenfolge vom Laden ist äußerst wichtig!!!
*/

//997 - bestimmter Style
//256 - Pixelgröße

var karte = L.map('map');
var zoom = 13;
var latitude = 52.52;
var longitude = 13.4;
var latlong = new L.LatLng(latitude, longitude);

karte.setView(latlong,zoom);

//API-KEY: 5c5f709891f240bbba32d5f42f1926ec
//TODO: sich bei cloudmade regustrieren

var layer = L.tileLayer('http://{s}.tile.cloudmade.com/5c5f709891f240bbba32d5f42f1926ec/997/256/{z}/{x}/{y}.png');
layer.addTo(karte);
var layer2 = L.tileLayer('http://api.tiles.mapbox.com/v2/diroru.QypeAntiquesTest.jsonp');
layer2.addTo(karte);

var markierung = L.marker([latitude,longitude]);
markierung.addTo(karte);

//method chaining
L
.marker([latitude,13.45])
.addTo(karte);

L.marker([latitude,13.50]).addTo(karte);


/*
var customIcon = new L.Icon( {
	iconUrl: '../img/burger-marker.png',
	iconSize: [53, 51],
	iconAnchor: [27, 51],
	popupAnchor: [0, 0],
	shadowUrl: '../img/burger-shadow.png',
	shadowSize: [83, 51],
	shadowAnchor: [27, 51]
});
*/

//L.marker([52.52, 13.4], {icon: customIcon }).addTo(map);

/*
* first argument is id, references the html tag!
***/

/*
var map = L.map('map', {
	center : [52.52, 13.4],
	zoom : 13
});
*/



var markerList = [{
"name":"Kunst & Antikmarkt am Kupergraben",
"lon":"52.5215",
"lat":"13.3939",
"details":"3"
},{"name":"Alte Schilder, Dosen, Flaschen",
"lon":"52.5202",
"lat":"13.3906",
"details":"5"
},{
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
];

var customIcon = new L.Icon( {
	iconUrl: 'images/thonet_marker_002.svg',
	iconSize: [60, 58],
	iconAnchor: [27, 51],
	popupAnchor: [0, 0],
	shadowUrl: 'images/thonet_marker_002_shadow.svg',
	shadowSize: [60, 58],
	shadowAnchor: [27, 51]
});

for(i=0;i<markerList.length;i++){
	L.marker([markerList[i].lon,markerList[i].lat], {icon: customIcon }).addTo(karte);
}


//L.marker([52.52, 13.4], {icon: customIcon }).addTo(map);