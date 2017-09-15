var app = getApp();

Page({
  data: {
    userInfo: {},
    // mode: ['我的收藏','我的订单','我的地址','联系客服','关于我们']
  },
  onLoad: function () {
    var that = this;
    wx.login({
      success: function () {
        wx.getUserInfo({
          success: function (res) {
            that.setData({
              userInfo: res.userInfo
            })
          }
        })
      }
    });
  },
  callphone: function (e) {
    wx.makePhoneCall({
      phoneNumber: '18625714900' //仅为示例，并非真实的电话号码
    })
  },
  mapaddess: function (e) {

    wx.getLocation({
      type: 'gcj02', //返回可以用于wx.openLocation的经纬度
      success: function (res) {
        console.log(res);
        var latitude = res.latitude
        var longitude = res.longitude
        console.log("latitude:" + latitude)
        console.log("longitude:" + longitude)
        // console.log("speed:" + speed)
        // console.log("accuracy:" + accuracy)
        wx.openLocation({
          latitude: latitude,
          longitude: longitude,
          scale: 28
        })
      }
    })
  },
  checkdocument: function(e){
    wx.navigateTo({
      url: '../../pages/fooddocument/fooddocument',
    })
  }
})