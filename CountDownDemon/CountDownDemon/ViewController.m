//
//  ViewController.m
//  自定义倒计时-18-4-2-1
//
//  Created by zq on 2018/4/2.
//  Copyright © 2018年 zq. All rights reserved.
//

#import "ViewController.h"
#import "ZQCountdownTime.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [[ZQCountdownTime  shareManage]countDownViewWithEndData:[NSDate dateWithTimeIntervalSinceNow:60] returnBlock:^(NSString *time) {
//        NSLog(@"time====%@",time);
//        self.timeLabel.text = time;
//    }];
    
    [[[ZQCountdownTime alloc]init]countDownViewWithEndString:@"2018-04-04 20:02:20" timeType:ZQSecondTime returnBlock:^(NSString *time) {
        self.timeLabel.text = time;
    }];
    
    [[[ZQCountdownTime alloc]init]countDownViewWithEndString:@"2018-04-04 20:50" timeType:ZQMinuteTime returnBlock:^(NSString *time) {
        self.minuteLabel.text = time;
    }];
    
    [[[ZQCountdownTime alloc]init]countDownViewWithEndString:@"2018-04-04 16" timeType:ZQHourTime returnBlock:^(NSString *time) {
        self.hourLabel.text = time;
    }];
    
    [[[ZQCountdownTime alloc]init]countDownViewWithEndString:@"2018-04-05" timeType:ZQDayTime returnBlock:^(NSString *time) {
        self.dayLabel.text = time;
    }];
}

- (IBAction)btnclick:(id)sender {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
