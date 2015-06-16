//
//  Number.h
//  Order-ipad
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Number : NSObject
//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;

@end
