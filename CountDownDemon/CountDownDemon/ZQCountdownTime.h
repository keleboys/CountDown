//
//  ZQCountdownTime.h
//  自定义倒计时-18-4-2-1
//
//  Created by zq on 2018/4/2.
//  Copyright © 2018年 zq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZQTimeType) {
    //    /** yyyy-MM */
    //    ZQYearTime = 0,
    //    /** yyyy-MM-dd */
    //    ZQMonthTime = 1,
    /** yyyy-MM-dd */
    ZQDayTime = 2,
    /** yyyy-MM-dd HH */
    ZQHourTime = 3,
    /** yyyy-MM-dd HH:mm */
    ZQMinuteTime = 4,
    /** yyyy-MM-dd HH:mm:ss */
    ZQSecondTime = 5,
};

@interface ZQCountdownTime : NSObject

+(ZQCountdownTime *)shareManage;
/**
 *  根据指定结束时间开始倒计时
 *  @param endDate ss格式的结束时间
 *  @param block 返回倒计时
 */
-(void)countDownViewWithEndData:(NSDate *)endDate returnBlock:(void(^)(NSString *time))block;
/**
 *  根据指定结束时间开始倒计时
 *  @param endStr YYYY-MM-dd hh:mm:ss格式的结束时间
 *  @param block 返回倒计时
 */
-(void)countDownViewWithEndString:(NSString *)endStr timeType:(ZQTimeType)type returnBlock:(void(^)(NSString *time))block;

@end
