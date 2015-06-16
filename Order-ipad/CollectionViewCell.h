//
//  CollectionViewCell.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/22.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;
@property (weak, nonatomic) IBOutlet UILabel *GoodsNum;
@property (weak, nonatomic) IBOutlet UILabel *RealNum;
@property (weak, nonatomic) IBOutlet UIButton *OrderBtn;
@property (weak, nonatomic) IBOutlet UILabel *GoodsNum2Label;
@property (weak, nonatomic) IBOutlet UIButton *IconBtn;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;

- (IBAction)OrderGoods:(id)sender;
@end
