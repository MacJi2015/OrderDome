//
//  TableViewCell.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/23.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AcountNumLabel;

@end
