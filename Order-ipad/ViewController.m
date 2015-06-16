//
//  ViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/22.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "ViewController.h"
#import "UIImage.h"
#import "CRNavigationBar.h"
#import "CRNavigationController.h"
#import "DeviceInfo.h"
#import <unistd.h>

@interface ViewController (){
    long long expectedLength;
    long long currentLength;
}
@property(nonatomic)int isDone;
@end

@implementation ViewController{
    int isTranformWifi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.UserNameText.delegate=self;
    self.PassWordText.delegate=self;
    
    UIImageView *UserNameView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"8-1.png"] TransformtoSize:CGSizeMake(35, 35)]];
    UserNameView.frame=CGRectMake(15, 500, 35, 35);
    UserNameView.backgroundColor=[UIColor whiteColor];
    self.UserNameText.leftView=UserNameView;
    self.UserNameText.leftViewMode=UITextFieldViewModeAlways;
    
    self.UserNameText.clearButtonMode=UITextFieldViewModeAlways;
    
    UIImageView *PassWdView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"8-2.png"] TransformtoSize:CGSizeMake(35, 35)]];
    PassWdView.frame=CGRectMake(15, 500, 35, 35);
    PassWdView.backgroundColor=[UIColor whiteColor];
    self.PassWordText.leftView=PassWdView;
    self.PassWordText.leftViewMode=UITextFieldViewModeAlways;
    
    self.UserNameText.clearButtonMode=UITextFieldViewModeAlways;
    
    self.TopImage.layer.masksToBounds=YES;
    self.TopImage.layer.cornerRadius=50;
     [self.view addSubview:self.TopImage];
//    [self.NavigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.NavigationBar setShadowImage:[UIImage new]];
//    self.NavigationBar.barTintColor=[[UIColor alloc]initWithRed:48/255 green:111/255 blue:254/255 alpha:1];
    self.NavigationBar.translucent=NO;
//    [self setBarTintColorWithRed:198.0/255.0 green:50.0/255.0 blue:53.0/255.0 alpha:1];
    self.isDone=1;
    isTranformWifi=0;
}
//- (void)setBarTintColorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha {
//    UIColor *tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//    self.NavigationBar.barTintColor = tintColor;
//    
//    const CGFloat *components = CGColorGetComponents(tintColor.CGColor);
//    
////    self.redValue.text = [NSString stringWithFormat:@"%d", (int)((components[0] / 1.0f) * 255)];
////    self.greenValue.text = [NSString stringWithFormat:@"%d", (int)((components[1] / 1.0f) * 255)];
////    self.blueValue.text = [NSString stringWithFormat:@"%d", (int)((components[2] / 1.0f) * 255)];
////    self.alphaValue.text = [NSString stringWithFormat:@"%d%%", (int)((CGColorGetAlpha(tintColor.CGColor) / 1.0f) * 100)];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    if (textField.tag==1) {
        //选择UserNameText
//        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//        NSMutableArray *loginlist=[ud objectForKey:@"LoginList"];
        NSMutableString *userName=[self.UserNameText.text mutableCopy];
        [userName replaceCharactersInRange:range withString:string];
  
//        for (NSDictionary *login in loginlist) {
//            if ([login[@"UserName"] isEqual:userName]) {
//                NSString *url=login[@"piclogo"];
//                NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
//                self.TopImage.image=[[UIImage alloc]initWithData:data];
//            }
//        }

        NSMutableString *passwd=[self.PassWordText.text mutableCopy];
        if (userName.length==0||passwd.length==0) {
            self.LoginBtn.enabled=NO;
        }else{
            self.LoginBtn.enabled=YES;
        }
    }else if(textField.tag==2){
        //选择PassWordText
       
        NSMutableString *UserName=[self.UserNameText.text mutableCopy];
               NSMutableString *PassWd=[self.PassWordText.text mutableCopy];
        [PassWd replaceCharactersInRange:range withString:string];
        if (UserName.length==0||PassWd.length==0) {
            self.LoginBtn.enabled=NO;
            
        }else{
            self.LoginBtn.enabled=YES;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.LoginBtn.enabled=NO;
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.UserNameText resignFirstResponder];
    [self.PassWordText resignFirstResponder];
}

- (IBAction)Login:(id)sender {

    HUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在登陆中......";
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:self.UserNameText.text forKey:@"UserName"];
    [ud setObject:self.PassWordText.text forKey:@"Passwd"];
    [ud setObject:@"1" forKey:@"LogID"];
    [ud setObject:@"1" forKey:@"siteuserid"];
    [ud setObject:@"郭嘉" forKey:@"displayname"];
    [ud setObject:@"1439125361@qq.com" forKey:@"alipayaccount"];
    [ud setObject:@"有云小卖部" forKey:@"company"];
    
    NSArray *classlist= @[@{@"classid":@"4498",@"classname":@"煲仔"},
                          @{@"classid":@"2017",@"classname":@"甜品"},
                          @{@"classid":@"2016",@"classname":@"冷菜"},
                          @{@"classid":@"2015",@"classname":@"热菜"}];

    [ud setObject:classlist forKey:@"classlist"];
    
    NSArray *foodlist=@[@{@"classid":@"2015",
                          @"descrip":@"干辣椒不是主料胜似主料，充分体现了江湖厨师\"下手重\"的特点",
                          @"id":@"30958",
                          @"picname":@"5.jpg",
                          @"price":@"35",
                          @"tags":@"偏辣",
                          @"title":@"重庆辣子鸡"},
                        @{@"classid":@"2016",
                          @"descrip":@"马铃薯色拉凉拌菜，凉粉肉丝凉拌菜",
                          @"id":@"7454",
                          @"picname":@"2.jpg",
                          @"price":@"15",
                          @"tags":@"偏咸",
                          @"title":@"凉拌菜"},
                        @{@"classid":@"2016",
                          @"descrip":@"白萝卜:100g 芹菜:50g 红椒:50g 李锦记纯香芝麻油:1 ",
                          @"id":@"7455",
                          @"picname":@"3.jpg",
                          @"price":@"15",
                          @"tags":@"凉拌",
                          @"title":@"凉拌三丝"},
                        @{@"classid":@"2017",
                          @"descrip":@"芒果和西柚都含有丰富的维生素，是一道营养丰富的甜品",
                          @"id":@"7456",
                          @"picname":@"4.jpg",
                          @"price":@"0.01",
                          @"tags":@"有点甜",
                          @"title":@"杨枝甘露"},
                        @{@"classid":@"4498",
                          @"descrip":@"选用净仔公鸡肉为主料",
                          @"id":@"30960",
                          @"picname":@"1.jpg",
                          @"price":@"30",
                          @"tags":@"偏辣",
                          @"title":@"宫爆鸡丁"},

                        ];
    
    [ud setObject:foodlist forKey:@"foodlist"];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"mainview"]; ///////通过storyboard来实例
    
    dispatch_after(0.4, dispatch_get_main_queue(), ^{
        [self presentViewController:vc animated:YES completion:nil];
    });
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"登陆" message:@"签到成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}
- (IBAction)Up:(id)sender {
    [self slideFrame:YES];
}

- (IBAction)Down:(id)sender {
    [self slideFrame:NO];
}

-(void)slideFrame:(BOOL) up{
    const int movementDistance=180;
    const float movementDuration=0.3f;
    
    int movement=(up ? -movementDistance:movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
