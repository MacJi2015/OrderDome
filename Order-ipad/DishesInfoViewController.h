//
//  DishesInfoViewController.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DishesInfoViewController : BaseViewController
- (IBAction)GoMain:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *DishesDescript;
@property (weak, nonatomic) IBOutlet UIImageView *Imageview;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *TagLabel;

@end
