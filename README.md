# CountDownDemon
一款简单好用的倒计时
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
