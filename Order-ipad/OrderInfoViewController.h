//
//  OrderInfoViewController.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OrderInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *NavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;
- (IBAction)checkout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *SumLabel;
- (IBAction)GoMain:(id)sender;

@end
