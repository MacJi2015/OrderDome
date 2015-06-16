//
//  Desk2CollectionViewCell.m
//  Order-ipad
//
//  Created by mac on 15/5/29.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "Desk2CollectionViewCell.h"

@implementation Desk2CollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        //初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews=[[NSBundle mainBundle] loadNibNamed:@"Desk2CollectionViewCell" owner:self options:nil];
        
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


@end
