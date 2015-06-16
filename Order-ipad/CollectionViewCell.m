//
//  CollectionViewCell.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/22.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "CollectionViewCell.h"
#import "MainViewController.h"


@implementation CollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        //初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews=[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil];
        
        //如果路径不存在，return nil
        if(arrayOfViews.count<1){
            return nil;
        }
        //如果xib中view不属于UICollectionViewCell类，return nil
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        //加载nib
        self=[arrayOfViews objectAtIndex:0];
    }
    return self;
}
- (IBAction)OrderGoods:(id)sender {
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSDictionary *dishes=@{@"id":self.IDLabel.text,@"name":self.GoodsName.text,@"acountnum":self.GoodsNum2Label.text};
    [ud setObject:dishes forKey:@"dishes"];
//    UIButton *btn=[[UIButton alloc]init];
//    [btn setTitle:@"1" forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"1-4.png"] forState:UIControlStateNormal];
//    btn.frame=CGRectMake(155, 5, 40, 40);
//    [self addSubview:btn];
    self.IconBtn.alpha=1;
    [self addSubview:self.IconBtn];
}
@end
