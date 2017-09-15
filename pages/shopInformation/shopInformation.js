// pages/shopInformation/shopInformation.js


Page({

    /**
     * 页面的初始数据
     */
    data: {
        total: '',
        foodlist: [],
        items: [
            { name: 'USA', value: '在店吃' },
            { name: 'CHN', value: '带走' },//checked: 'true'
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
    }




})