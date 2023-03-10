function initMap() {
  const latitude = document.getElementById('post_latitude').value;
  const longitude = document.getElementById('post_longitude').value;
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: {lat: parseFloat(latitude), lng: parseFloat(longitude)},
  });
  const marker = new google.maps.Marker({
    position: {lat: parseFloat(latitude), lng: parseFloat(longitude)},
    map,
    title: "マーカータイトル",
  });

  // フォームの住所から緯度と経度を取得する
  document.getElementById('geocode-button').addEventListener('click', function () {
    const address = document.getElementById('post_address').value;
    const geocoder = new google.maps.Geocoder();
    geocoder.geocode({ address: address }, function (results, status) {
      if (status === "OK") {
        const location = results[0].geometry.location;
        const latitudeInput = document.getElementById('post_latitude');
        const longitudeInput = document.getElementById('post_longitude');
        latitudeInput.value = location.lat();
        longitudeInput.value = location.lng();
        map.setCenter(location);
        marker.setPosition(location);
      } else {
        alert('住所を取得できませんでした。もう一度入力してください。');
      }
    });
  });
}

