var WxAutoImage = require('../../js/wxAutoImageCal.js');
var app = getApp();

//test oschina


Page({
    data: {
      imgUrls: [
        'http://rlty.oss-cn-beijing.aliyuncs.com/banner4.png',
        'http://rlty.oss-cn-beijing.aliyuncs.com/banner5.png' 
        ],
        indicatorDots: true,
        vertical: false,
        autoplay: true,
        interval: 3000,
        duration: 1200,
        scr: '../../image/icon-qiandao.png',
        mode: [{
            iconText: '店内扫码点餐',

        },
        {
            iconText: '店外点餐',

        },
        ],
    },
    scan: function (event) {

        wx.scanCode({
            success: function (res) {
    
                console.log(res)
                //测试扫码跳转
                wx.navigateTo({
                    url: '../../pages/shop/shop'
                }),
                    //以上为测试代码

                    that.setData({
                        result: res.result
                    })
            },
            fail: function (res) {
            }
        })
    },
    // cusImageLoad: function(e){
    //     var that = this;
    //     that.setData(WxAutoImage.wxAutoImageCal(e));
    // }

    onLoad: function (options) {

          
        
        wx.removeStorage({
            key: 'describeinfo',
            success: function (res) {
                
            }
        })

        //测试扫码跳转
        wx.getStorage({
            key: 'scanCode',
            success: function (res) {
                // console.log('success数据：'),
                //     console.log(res.data)
            },
            complete: function (res) {
                // console.log('数据：'),
                    // console.log(res.data)
                if (!res.data) {
                    wx.navigateTo({
                        url: '../../pages/shop/shop'
                    })
                }
            }
        })
        //以上为测试代码

    },


})