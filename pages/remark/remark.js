var app = getApp()
// var common = require('../../utils/common.js').userInfo()
// var tasteDescripe = ''
Page({
    data: {
        submitDetails: '',
        tasteList: ['少放辣', '不放辣', '不放蒜', '不放葱', '多放肉', '多加米'],
        test:'',

    },
    onLoad: function (options) {
        // 生命周期函数--监听页面加载
        var that = this;
        wx.getStorage({
            key: 'describeinfo',
            success: function (res) {
                // console.log(res.data.submitDetails) 
                // testdetails = res.data.submitDetails
                // console.log(testdetails);
                that.setData({
                    test: res.data.submitDetails
                })
            }
        })
    },

    bindFormSubmit: function (e) {
        var that = this;
        // var emailinfo = e.detail.value.mail;
        var describeinfo = e.detail.value.describe;
        // console.log("获取email" + emailinfo);
        wx.setStorage({
            key: "describeinfo",
            data: {
                submitDetails: describeinfo
            }
        })
        var pages = getCurrentPages();
        var currPage = pages[pages.length - 1];   //当前页面
        var prevPage = pages[pages.length - 2];  //上一个页面

        //直接调用上一个页面的setData()方法，把数据存到上一个页面中去
        prevPage.setData({
            submitDetails: describeinfo
        })
        wx.navigateBack()
        // console.log("获取描述" + describeinfo);
        // console.log("获取" + this.data.submitDetails);
        //判断是否为邮箱的正则表达式
        // var usableEmail = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;

        // console.log(usableEmail.test(emailinfo));
        // if (usableEmail.test(emailinfo)) {
        //   wx.request({
        //     url: app.globalData.globalUrl + "insertfaq",
        //     method: 'POST',
        //     header: {
        //       'content-type': 'application/json'
        //     },
        //     data: {
        //       "openid": common.openid,
        //       "email": emailinfo,
        //       "description": describeinfo
        //     },

        //     success: function (res) {

        //       console.log("当前网址反馈成功");
        //     },
        //     fail: function (error) {
        //       console.log(error);

        //     }
        //   })
        // } else {
        //   wx.showToast({
        //     title: '请输入正确的邮箱地址',
        //     duration: 2000
        //   })
        // }


    },
    //口味标签选择功能
    // addtates: function (event) {
    //     console.log(event.currentTarget.id);
    //     var index = event.currentTarget.id
    //     var num = parseInt(index)
    //     console.log(num);
    //     // var tasteDescripe = this.data.submitDetails + this.data.tasteList[num]
    //     // console.log(tasteDescripe);
        
    //     tasteDescripe = tasteDescripe + this.data.tasteList[num]
    //     console.log(tasteDescripe);
    //    this.setData({
    //        test: tasteDescripe
    //    })

    //     //   var buttonValue = document.getElementById('button').innerText
    //     //   console.log(buttonValue);

    // },
})