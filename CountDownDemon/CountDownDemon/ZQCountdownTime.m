//
//  ZQCountdownTime.m
//  自定义倒计时-18-4-2-1
//
//  Created by zq on 2018/4/2.
//  Copyright © 2018年 zq. All rights reserved.
//

#import "ZQCountdownTime.h"

@interface ZQCountdownTime ()
/**  */
@property (nonatomic, copy) void (^block)(NSString *time);
/**  */
@property (nonatomic, strong) dispatch_source_t    timer;
@end

@implementation ZQCountdownTime

+(ZQCountdownTime *)shareManage{
    static ZQCountdownTime*_countTime;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _countTime = [[self alloc]init];
    });
    return _countTime;
}

-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

-(void)countDownViewWithEndData:(NSDate *)endDate returnBlock:(void(^)(NSString *time))block{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];
    [self fireWithTimeIntervar:timeInterval endTimeStr:@"00秒"  returnBlock:block];
}

-(void)countDownViewWithEndString:(NSString *)endStr timeType:(ZQTimeType)type returnBlock:(void(^)(NSString *time))block{
    NSString *timeType = nil;
    NSString *endTimeStr = nil;
    switch (type) {
//        case ZQYearTime:
//            endTimeStr = @"00年";
//            timeType = @"yyyy";
//            break;
//        case ZQMonthTime:
//            endTimeStr = @"00月";
//            timeType = @"yyyy-MM";
//            break;
        case ZQDayTime:
            endTimeStr = @"00天";
            timeType = @"yyyy-MM-dd";
            break;
        case ZQHourTime:
            endTimeStr = @"00小时";
            timeType = @"yyyy-MM-dd HH";
            break;
        case ZQMinuteTime:
            endTimeStr = @"00分";
            timeType = @"yyyy-MM-dd HH:mm";
            break;
        case ZQSecondTime:
            endTimeStr = @"00秒";
            timeType = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            break;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = timeType;
    NSDate *endDate = [formatter dateFromString:endStr];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceNow];
    NSAssert(timeInterval >= 0, @"起始时间不能小于当前时间");
    [self fireWithTimeIntervar:timeInterval endTimeStr:endTimeStr returnBlock:block];
}

/**
 *  根据指定时间间隔开始倒计时
 */
- (void)fireWithTimeIntervar:(NSTimeInterval)timerInterval endTimeStr:(NSString *)endTimeStr  returnBlock:(void(^)(NSString *time))block
{
    if (_timer != nil) _timer = nil;
    __block int timeout = timerInterval; //倒计时时间
    if (timeout == 0) return;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
           _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                !block ?: block(endTimeStr);
            });
        }else{
            int days = (int)(timeout/(3600*24));
            int hours = (int)((timeout-days*24*3600)/3600);
            int minute = (int)(timeout-days*24*3600-hours*3600)/60;
            int second = timeout-days*24*3600-hours*3600-minute*60;
//            NSLog(@"%d==%d==%d==%d",days,hours,minute,second);
            __block NSString *dayStr = @"";
            __block NSString *hourStr = @"";
            __block NSString *minuteStr = @"";
            __block NSString *secondStr = @"";
            dispatch_async(dispatch_get_main_queue(), ^{
                if (days > 0) dayStr = [NSString stringWithFormat:@"%d天",days];
                if (hours > 0) hourStr = [NSString stringWithFormat:@"%d小时",hours];
                if (minute >0) minuteStr = [NSString stringWithFormat:@"%d分",minute];
                if (second >=0) secondStr = [NSString stringWithFormat:@"%d秒",second];
                !block ?: block([NSString stringWithFormat:@"%@%@%@%@",dayStr,hourStr,minuteStr,secondStr]);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
