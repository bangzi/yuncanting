// pages/shopInformation/shopInformation.js


Page({

    /**
     * 页面的初始数据
     */
    data: {
        total: '',
        foodlist: [],
        items: [
          { name: 'USA', value: '在店吃', checked: 0 },
          { name: 'CHN', value: '自取', checked: 0 },//checked: 'true'
        ],
        informationList: [
            {
                foodName: "shugp",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shucai",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shuiguo",
                num: 3,
                price: 15,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shugp",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shucai",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shuiguo",
                num: 3,
                price: 15,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shugp",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shucai",
                num: 3,
                price: 14,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
            {
                foodName: "shuiguo",
                num: 3,
                price: 15,
                foodImageUrl: 'http://wxapp.im20.com.cn/impublic/waimai/imgs/goods/1.jpg'
            },
        ],
        radioChange: function (e) {
            console.log('radio发生change事件，携带value值为：', e.detail.value)
        }
    },
    onLoad: function (options) {
        console.log(options.total);
        //获取订单信息
        var food = JSON.parse(options.foodlist);
        var total = JSON.parse(options.total);
        console.log(food);
        var that = this;
        that.setData({
            total: total,
            foodlist: food,
        });
    },

    immediatelyPay: function() {
      var info1 = this.data.items[0];
      var info2 = this.data.items[1];
      if (info1.checked == 0 && info2.checked == 0) {
        wx.showModal({
          title: '提示',
          content: '请选择用餐方式“在店吃”或者“自取”',
          showCancel: false,
          success: function (res) {
            if (res.confirm) {
              console.log('用户点击确定')
            } else if (res.cancel) {
              console.log('用户点击取消')
            }
          }
        })
        // wx.showToast({
        //   title: '请选择用餐方式“在店吃”或者“自取”',
        // })
      }
    }




})