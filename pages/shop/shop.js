var app = getApp();
// var server = require('../../utils/server');
Page({
  data: {
    getfood: [],
    goods: {
      1: {
        id: 1,
        name: '孔式酱棒骨',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%AD%94%E5%BC%8F%E9%85%B1%E6%A3%92%E9%AA%A848%E5%85%83.jpg',
        sold: 1014,
        price: 48,
        num: 0
      },
      2: {
        id: 2,
        name: '双椒鱼头配面王',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%8F%8C%E6%A4%92%E9%B1%BC%E5%A4%B4%E9%85%8D%E9%9D%A2%E7%8E%8B78%E5%85%83.jpg',
        sold: 1029,
        price: 78,
        isHidden: 1
      },
      3: {
        id: 3,
        name: '多宝鱼',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%A4%9A%E5%AE%9D%E9%B1%BC198.jpg',
        sold: 1030,
        price: 198,
        num: 0
      },
      4: {
        id: 4,
        name: '翡翠虾',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%BF%A1%E7%BF%A0%E8%99%BE46.jpg',
        sold: 1059,
        price: 46,
        num: 0
      },
      5: {
        id: 5,
        name: '家乡千湖藕',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%AE%B6%E4%B9%A1%E5%8D%83%E6%B9%96%E8%97%9532.jpg',
        sold: 1029,
        price: 32,
        num: 0
      },
      6: {
        id: 6,
        name: '千锅一品脆',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%8D%83%E9%94%85%E4%B8%80%E5%93%81%E8%84%8638.jpg',
        sold: 1064,
        price: 38,
        num: 0
      },
      7: {
        id: 7,
        name: '石门肥肠',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%9F%B3%E9%97%A8%E8%82%A5%E8%82%A042.jpg',
        sold: 814,
        price: 42,
        num: 0
      },
      8: {
        id: 8,
        name: '湘望馋嘴蛙',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E6%B9%98%E6%9C%9B%E9%A6%8B%E5%98%B4%E8%9B%9948.jpg',
        sold: 124,
        price: 48,
        num: 0
      },
      9: {
        id: 9,
        name: '鱼头泡饼',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E9%B1%BC%E5%A4%B4%E6%B3%A1%E9%A5%BC78.jpg',
        sold: 102,
        price: 78,
        num: 0
      },
      10: {
        id: 10,
        name: '特色小油饼',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%89%B9%E8%89%B2%E5%B0%8F%E6%B2%B9%E9%A5%BC18.jpg',
        sold: 102,
        price: 18,
        num: 0
      },
      11: {
        id: 11,
        name: '川椒口口脆',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E5%B7%9D%E6%A4%92%E5%8F%A3%E5%8F%A3%E8%84%8626.jpg',
        sold: 102,
        price: 26,
        num: 0
      },
      12: {
        id: 12,
        name: '风味皮蛋',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E9%A3%8E%E5%91%B3%E7%9A%AE%E8%9B%8B18.jpg',
        sold: 102,
        price: 18,
        num: 0
      },
      13: {
        id: 13,
        name: '橄榄油拌丝瓜尖',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E6%A9%84%E6%A6%84%E6%B2%B9%E6%8B%8C%E4%B8%9D%E7%93%9C%E5%B0%9628.jpg',
        sold: 102,
        price: 28,
        num: 0
      },
      14: {
        id: 14,
        name: '疙瘩汤',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%96%99%E7%98%A9%E6%B1%A416.jpg',
        sold: 102,
        price: 16,
        num: 0
      },
      15: {
        id: 15,
        name: '筒子骨炖湖藕',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E7%AD%92%E5%AD%90%E9%AA%A8%E7%82%96%E6%B9%96%E8%97%9548.jpg',
        sold: 102,
        price: 48,
        num: 0
      },
      16: {
        id: 16,
        name: '滋补野山菌汤',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E6%BB%8B%E8%A1%A5%E9%87%8E%E5%B1%B1%E8%8F%8C%E6%B1%A428.jpg',
        sold: 102,
        price: 28,
        num: 0
      },
      17: {
        id: 17,
        name: '葱花饼',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E8%91%B1%E8%8A%B1%E9%A5%BC16.jpg',
        sold: 102,
        price: 16,
        num: 0
      },
      18: {
        id: 18,
        name: '锅贴',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E9%94%85%E8%B4%B418.jpg',
        sold: 102,
        price: 18,
        num: 0
      },
      19: {
        id: 19,
        name: '水饺',
        pic: 'http://rlty.oss-cn-beijing.aliyuncs.com/%E6%B0%B4%E9%A5%BA28.jpg',
        sold: 102,
        price: 28,
        num: 0
      }
    },
    goodsList: [
      {
        id: 'hot',
        classifyName: '本店招牌',
        goods: [1, 2]
      },
      {
          id: 'vegetable',
          classifyName: '今日特价',
          goods: [9, 10]
      },
      {
        id: 'new',
        classifyName: '风味菜',
        goods: [3, 4, 5, 6, 7, 8]
      },
     
      {
        id: 'mushroom',
        classifyName: '精选凉菜',
        goods: [11, 12, 13]
      },
      {
        id: 'food',
        classifyName: '汤羹',
        goods: [14, 15, 16]
      },
      {
        id: 'zhushi',
        classifyName: '主食',
        goods: [17, 18, 19]
      }
    ],
    cart: {
      count: 0,
      total: 0,
      list: {},
    },
    showCartDetail: false
  },
  // onLoad: function (options) {
  // 	var shopId = options.id;
  // 	for (var i = 0; i < app.globalData.shops.length; ++i) {
  // 		if (app.globalData.shops[i].id == shopId) {
  // 			this.setData({
  // 				shop: app.globalData.shops[i]
  // 			});
  // 			break;
  // 		}
  // 	}
  // },
  onShow: function () {
    this.setData({
      classifySeleted: this.data.goodsList[0].id
    });
  },
  tapAddCart: function (e) {
    this.addCart(e.target.dataset.id);
  },
  tapMinusCart: function (e) {
    this.reduceCart(e.target.dataset.id);
  },
  addCart: function (id) {
    var num = this.data.cart.list[id] || 0;
    this.data.cart.list[id] = num + 1;
    this.countCart();
  },
  reduceCart: function (id) {
    var num = this.data.cart.list[id] || 0;
    if (num <= 1) {
      delete this.data.cart.list[id];
    } else {
      this.data.cart.list[id] = num - 1;
    }
    this.countCart();
  },
  countCart: function () {
    var count = 0,
      total = 0;
    for (var id in this.data.cart.list) {
      var goods = this.data.goods[id];
      count += this.data.cart.list[id];
      total += goods.price * this.data.cart.list[id];
    }
    this.data.cart.count = count;
    this.data.cart.total = total;
    this.setData({
      cart: this.data.cart
    });
  },
  follow: function () {
    this.setData({
      followed: !this.data.followed
    });
  },
  // onGoodsScroll: function (e) {
  // 	if (e.detail.scrollTop > 10 && !this.data.scrollDown) {
  // 		this.setData({
  // 			scrollDown: true
  // 		});
  // 	} else if (e.detail.scrollTop < 10 && this.data.scrollDown) {
  // 		this.setData({
  // 			scrollDown: false
  // 		});
  // 	}

  // 	var scale = e.detail.scrollWidth / 570,
  // 		scrollTop = e.detail.scrollTop / scale,
  // 		h = 0,
  // 		classifySeleted,
  // 		len = this.data.goodsList.length;
  // 	this.data.goodsList.forEach(function (classify, i) {
  // 		var _h = 70 + classify.goods.length * (46 * 3 + 20 * 2);
  // 		if (scrollTop >= h - 100 / scale) {
  // 			classifySeleted = classify.id;
  // 		}
  // 		h += _h;
  // 	});
  // 	this.setData({
  // 		classifySeleted: classifySeleted
  // 	});
  // },
  onLoad: function (options) {
    // wx.request({
    //   url: 'https://api.weixin.qq.com/cgi-bin/token',
    //   // url: 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET', //仅为示例，并非真实的接口地址
    //   data: {
    //     xgrant_type: 'client_credential',
    //     appid: 'wx29d24f01064d80e5',
    //     secret:'def49627587fa2347f0e265fc84250fa'
    //   },
    //   header: {
    //     'content-type': 'application/json' // 默认值
    //   },
    //   success: function (res) {
    //     console.log(res.data)
    //   }
    // }),
      wx.request({
      url: 'https://api.weixin.qq.com/cgi-bin/token', //仅为示例，并非真实的接口地址
      
        data: {
          AppID: 'wx29d24f01064d80e5',
          AppSecret: 'def49627587fa2347f0e265fc84250fa'
        },
        // header: {
        //   'content-type': 'application/json' // 默认值
        // },
        success: function (res) {
          console.log(res.data)
        }
      })
    
  },
  tapClassify: function (e) {
    var id = e.target.dataset.id;
    this.setData({
      classifyViewed: id
    });
    var self = this;
    setTimeout(function () {
      self.setData({
        classifySeleted: id
      });
    }, 100);
  },
  showCartDetail: function () {
    this.setData({
      showCartDetail: !this.data.showCartDetail
    });
  },
  hideCartDetail: function () {
    this.setData({
      showCartDetail: false
    });
  },

  onShow: function () {

  },
  submit: function () {
    var that = this;
    that.setData({
      getfood: []
    })
    for (var id in this.data.cart.list) {
      var goods = this.data.goods[id];
      goods.num = this.data.cart.list[id];
      this.data.getfood.push(goods);
    }
    var total = that.data.cart.total;
    var foodlist = that.data.getfood;
    console.log(total);
    console.log(foodlist);
    wx.navigateTo({
      url: '../../pages/shopInformation/shopInformation?foodlist=' + JSON.stringify(foodlist) + '&total=' + total,
    })
    // server.sendTemplate(e.detail.formId, null, function (res) {
    // 	if (res.data.errorcode == 0) {
    // 		wx.showModal({
    // 			showCancel: false,
    // 			title: '恭喜',
    // 			content: '订单发送成功！下订单过程顺利完成，本例不再进行后续订单相关的功能。',
    // 			success: function(res) {
    // 				if (res.confirm) {
    //           wx.navigateTo('../../pages/shopInformation/shopInformation');
    // 				}
    // 			}
    // 		})
    // 	}
    // }, function (res) {
    // 	console.log(res)
    // });
  },

  //测试扫码跳转
  onLoad: function (options) {
    wx.setStorage({
      key: "scanCode",
      data: "2"
    })
  },
  //以上为测试代码
});

