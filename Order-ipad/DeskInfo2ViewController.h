//
//  DeskInfo2ViewController.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/29.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DeskInfo2ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
- (IBAction)GoMain:(id)sender;

- (IBAction)Forward:(id)sender;
- (IBAction)NextBtn:(id)sender;
- (IBAction)NumBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *OneBtn;
@property (weak, nonatomic) IBOutlet UIButton *TwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *TreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourBtn;
@property (weak, nonatomic) IBOutlet UIButton *FireBtn;
@property (weak, nonatomic) IBOutlet UIButton *SixBtn;
@property (weak, nonatomic) IBOutlet UIButton *SevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *EightBtn;
@property (weak, nonatomic) IBOutlet UIButton *NineBtn;
@property (weak, nonatomic) IBOutlet UIButton *TenBtn;
@property (weak, nonatomic) IBOutlet UIButton *ElevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *TirthBtn;

@end
