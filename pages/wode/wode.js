var app = getApp();

Page({
    data: {
        //商家电话
        phoneNumber:'13716772765',
        userInfo: {},
        // mode: ['我的收藏','我的订单','我的地址','联系客服','关于我们']
    },
    onLoad: function () {
        //获取用户信息
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
    //拨打电话
    callphone: function (e) {
        wx.makePhoneCall({
            phoneNumber: this.data.phoneNumber
        })
    },
    //地图定位
    mapaddess: function (e) {
        wx.openLocation({
            latitude: 40.12481,
            longitude: 116.21308,
            scale: 28
            
        })
    },
    //查看食品档案
    checkdocument: function (e) {
        wx.navigateTo({
            url: '../../pages/fooddocument/fooddocument',
        })
    }
})