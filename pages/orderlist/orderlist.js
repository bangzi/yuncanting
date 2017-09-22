// pages/orderlist/orderlist.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
      orderlist:
      [{
          inshop:'店内',
          foodname:'麻辣香锅',
          foodnum:3,
          foodprice:25,
          count:1000
      },
      {
          inshop: '店外',
          foodname: '麻辣香锅',
          foodnum: 3,
          foodprice: 26,
          count: 0
      }]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    
    wx.request({
        url:'' ,
        data:{

        } ,
        header: {
            'content-type': 'application/json'
        },
        method: 'POST',
        //dataType: json,
        success: function(res) {

        },
        fail: function(res) {

        },
        complete: function(res) {

        },
    })
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    wx.request({
        url: '',
        data:{

        } ,
        header: { 
            'content-type': 'application/json'
            },
        method: POST,
        // dataType: json,
        success: function(res) {},
        fail: function(res) {},
        complete: function(res) {},
    })
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
      return {
          title: '西马坊大食堂',
          path: '/pages/orderlist/orderlist',
          success: function (res) {
              // 转发成功
              console.log('转发ok');
          },
          fail: function (res) {
              // 转发失败
          }
      }
  }
})