//
//  CYTimeManagementViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/10/18.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "CYTimeManagementViewController.h"

@interface CYTimeManagementViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *startTimePickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *endTimePickerView;

@property (nonatomic ,strong)NSArray *hoursArr;
@property (nonatomic ,strong)NSArray *mintiusArr;

@end

@implementation CYTimeManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"设置营业时间";
    //设置代理
    self.startTimePickerView.delegate = self;
    self.startTimePickerView.dataSource = self;
//    self.endTimePickerView.delegate = self;
//    self.endTimePickerView.dataSource = self;
    
}
#pragma  mark --懒加载
- (NSArray *)hoursArr{
    if (!_hoursArr) {
         _hoursArr = @[@"00",@"01"] ;
    }
    return _hoursArr;
}

-(NSArray *)mintiusArr{
    if (!_mintiusArr) {
        _mintiusArr = @[@"00",@"02"];
    }
    return _mintiusArr;
}

#pragma  mark -- UIPickerViewDelegate UiPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"%lu",(unsigned long)self.hoursArr.count);
    if (component == 0) {
        
        return self.hoursArr.count;
        
    } else {
        
        return self.mintiusArr.count;
    }
}

- ( NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  
    if (component == 0) {
        
        return self.hoursArr[row];
        
    } else {
        
        return self.mintiusArr[row];
    }
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return nil;
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
//    return nil;
//}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//   
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
