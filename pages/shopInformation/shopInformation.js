// pages/shopInformation/shopInformation.js
var timeStamp = require('../../js/timeStamp.js')

Page({

    /**
     * 页面的初始数据
     */
    data: {
        submitDetails: '',
        total: '',
        reachtime: '12:00',
        isinshop: true,
        foodlist: [],
        items: [
            { name: 'USA', value: '在店吃', checked: 0 },
            { name: 'CHN', value: '带走', checked: 0 },//checked: 'true'
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
        // console.log(options.total);
        var that = this
        //获取时分
        var now = new Date()
        var hour = now.getHours()
        var minute = now.getMinutes()
       //格式化时分
        var nowTime = [hour, minute].map(timeStamp.formatNumber).join(':')
        that.setData({
            reachtime: nowTime
        })

        //获取订单信息
        var food = JSON.parse(options.foodlist);
        var total = JSON.parse(options.total);
        // console.log(food);
        var that = this;
        that.setData({
            total: total,
            foodlist: food,
        });
    },

    immediatelyPay: function () {
        var info1 = this.data.items[0];
        var info2 = this.data.items[1];
        if (info1.checked == 0 && info2.checked == 0) {
            wx.showModal({
                title: '提示',
                content: '请确认用餐方式“在店吃”或者“自取”和预计到店时间',
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
    },
    onShareAppMessage: function () {
        return {
            title: '西马坊大食堂',
            path: '/pages/shopInformation/shopInformation',
            success: function (res) {
                // 转发成功
                console.log('转发ok');
            },
            fail: function (res) {
                // 转发失败
            }
        }
    },
    //预计到达时间
    timeChange: function (e) {

        var that = this;
        that.setData({
            reachtime: e.detail.value
        });
    },
    payment: function () {
        wx.requestPayment({
            timeStamp: '',
            nonceStr: '',
            package: '',
            signType: '',
            paySign: '',
            'success': function (res) {
                wx.removeStorage({
                    key: 'describeinfo',
                    success: function (res) {
                        console.log(res.data)
                    }
                })
            },
            'fail': function (res) {

            }
        })


    },

    onShow: function (options) {
        // console.log(options);
        console.log(this.data.submitDetails);
    }


})