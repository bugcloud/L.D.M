function currentPositionCallback(position) {
    var lat = position.coords.latitude
    var lon = position.coords.longitude
    setViewContent(lat, lon)
    setGoogleMaps(lat, lon)

    var growl = object(Growl)
    growl.bodyText = "You can change your spot to double-click on this map."
    growl.show()
}

function setViewContent(lat, lon) {
    $("#here").html('<p>latitude: ' + lat + '&nbsp;&nbsp;&nbsp;longitude: ' + lon + '</p>')
    var url = "/venues?lat=" + lat + "&lon=" + lon
    $("#here").append('<p><a href="' + url + '">List of venues</a></p>')
    $("#navLinkVenues").attr('href', url)
}

function setGoogleMaps(lat, lon) {
    _myMap = object(Map)
    _myMap.init(lat, lon)
}


var Map = {
  map: null,
  marker: null,
  ll: null,
  init: function(lat, lon) {
      this.ll = new google.maps.LatLng(lat, lon)
      var options = {
          zoom: 17,
          center: this.ll,
          mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      this.map = new google.maps.Map(document.getElementById("map"), options)

      this.marker = new google.maps.Marker({
          position: this.ll,
          map: this.map,
          title: 'latitude: ' + lat + ', longitude: ' + lon
      })

      var me = this
      google.maps.event.addListener(this.map, 'dblclick', function(event) {
          me.replaceMarker(event.latLng)
      })
  },
  replaceMarker: function(loc) {
      this.marker.setPosition(loc)
      setViewContent(loc.lat(), loc.lng())
  }
}
var _myMap;


$(function() {
    if (typeof _android_activity != 'undefined') {
        var lat = String(_android_activity.getLatitude())
        var lon = String(_android_activity.getLongitude())
        setViewContent(lat, lon)
        setGoogleMaps(lat, lon)

        var growl = object(Growl)
        growl.bodyText = "You can change your spot to double-click on this map."
        growl.show()
    } else {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(currentPositionCallback)
        } else {
            $("#here").html('<p>HTML5 GeoLocation API is not supported.</p>')
        }
    }
});
