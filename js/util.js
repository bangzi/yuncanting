function formatTime(time) {
  // if (typeof time !== 'number' || time < 0) {
  //   return time
  // }

  // var hour = parseInt(time / 3600)
  // time = time % 3600
  // var minute = parseInt(time / 60)
  // time = time % 60
  // var second = time

  // // return ([hour, minute, second]).map(function (n) {
  // //   n = n.toString()
  // //   return n[1] ? n : '0' + n
  // // }).join(':')
  // return [year, month, day].map(formatNumber).join('/') + ' ' + [hour, minute, second].map(formatNumber).join(':');
  //获取当前时间戳
  var timestamp = Date.parse(time);
  timestamp = timestamp / 1000;
  console.log("当前时间戳为：" + timestamp);

  //获取当前时间
  var n = timestamp * 1000;
  var date = new Date(n);
  //年
  var Y = date.getFullYear();
  //月
  var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1);
  //日
  var D = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
  //时
  var h = date.getHours() == 0 ? '00' : date.getHours();
  //分
  var m = date.getMinutes();
  //秒
  var s = date.getSeconds();

  return Y + '.' + M + '.' + D + ' ' + h + ':' + m;
}

function formatLocation(longitude, latitude) {
  if (typeof longitude === 'string' && typeof latitude === 'string') {
    longitude = parseFloat(longitude)
    latitude = parseFloat(latitude)
  }

  longitude = longitude.toFixed(2)
  latitude = latitude.toFixed(2)

  return {
    longitude: longitude.toString().split('.'),
    latitude: latitude.toString().split('.')
  }
}

module.exports = {
  formatTime: formatTime,
  formatLocation: formatLocation
}
