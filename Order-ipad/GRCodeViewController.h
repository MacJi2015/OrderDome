//
//  GRCodeViewController.h
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GRCodeViewController : BaseViewController<UINavigationBarDelegate,NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *CodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavigationBar;

@property(nonatomic,retain) NSTimer *timer;

@property(strong,nonatomic)NSMutableData *webData;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(nonatomic)BOOL elementFound;
@property(strong,nonatomic)NSString *matchiingElemenr;
@property(strong,nonatomic)NSURLConnection *conn;
@property (weak, nonatomic) IBOutlet UILabel *OrderNumLabel;

- (IBAction)GoMain:(id)sender;
@property(nonatomic)int isDone;
@end
