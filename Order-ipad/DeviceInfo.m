//
//  Device.m
//  Cashier
//
//  Created by mac on 15/4/25.
//  Copyright (c) 2015年 有云科技. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

//获得UUID

+(NSString *)getIphoneUUID{
    return [[NSUUID UUID] UUIDString];
}

@end
