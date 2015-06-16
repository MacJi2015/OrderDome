//
//  CrossLineLabel.h
//  Order-ipad
//
//  Created by mac on 15/5/25.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrossLineLabel : UILabel

@property (assign, nonatomic) BOOL strikeThroughEnabled; // 是否画线

@property (strong, nonatomic) UIColor *strikeThroughColor; // 画线颜色
@end
