// pages/shopInformation/shopInformation.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    reachtime: '12:00',
    items: [
      { name: 'USA', value: '在店吃' },
      { name: 'CHN', value: '带走' },//checked: 'true' 
    ],
    informationList: [
      {
        foodName: "孔式酱棒骨",
        num: 1,
        price: 48,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%AD%94%E5%BC%8F%E9%85%B1%E6%A3%92%E9%AA%A848%E5%85%83.jpg'
      },
      {
        foodName: "多宝鱼",
        num: 1,
        price: 198,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%A4%9A%E5%AE%9D%E9%B1%BC198.jpg'
      },
      {
        foodName: "翡翠虾",
        num: 2,
        price: 46,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%BF%A1%E7%BF%A0%E8%99%BE46.jpg'
      },
      {
        foodName: "家乡千湖藕",
        num: 3,
        price: 32,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%AE%B6%E4%B9%A1%E5%8D%83%E6%B9%96%E8%97%9532.jpg'
      },
      {
        foodName: "风味皮蛋",
        num: 1,
        price: 18,
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E9%A3%8E%E5%91%B3%E7%9A%AE%E8%9B%8B18.jpg'
      },
      {
        foodName: "千锅一品脆",
        num: 1,
        price: 38,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%8D%83%E9%94%85%E4%B8%80%E5%93%81%E8%84%8638.jpg'
      },
      {
        foodName: "锅贴",
        num: 10,
        price: 18,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E9%94%85%E8%B4%B418.jpg'
      },
      {
        foodName: "滋补野山菌汤",
        num: 2,
        price: 28,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E6%BB%8B%E8%A1%A5%E9%87%8E%E5%B1%B1%E8%8F%8C%E6%B1%A428.jpg'
      },
      {
        foodName: "疙瘩汤",
        num: 2,
        price: 16,
        foodImageUrl: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%96%99%E7%98%A9%E6%B1%A416.jpg'
      },
    ],
  },

  onLoad: function (options) {
      console.log(options)
    // wx.getSystemInfo({
    //   success: function (res) {
    //     console.log(res.model)
    //     console.log(res.pixelRatio)
    //     console.log(res.windowWidth)
    //     console.log(res.windowHeight)
    //     console.log(res.language)
    //     console.log(res.version)
    //   }
    // })
      var navigationname = options.navigationbarName + '订单'
    wx.setNavigationBarTitle({
        title: navigationname,
        success: function(res) {},
        fail: function(res) {},
        complete: function(res) {},
    })
  },
  radioChange: function (e) {
    console.log('radio发生change事件，携带value值为：', e.detail.value)
  },

  timeChange: function (e) {
    console.log('ghgfjhsgf\sjgj');
    this.setData({
      reachtime: e.detail.value
    })
  },

})