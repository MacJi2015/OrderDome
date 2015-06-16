//
//  AcountViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "AcountViewController.h"
#import "DeviceInfo.h"

@interface AcountViewController ()
@property(nonatomic)int isDone;
@end

@implementation AcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NavigationBar.delegate = self;
    UINavigationItem *item = [self.NavigationBar.items objectAtIndex:0];
    [self.NavigationBar pushNavigationItem:item animated:YES];
    UINavigationItem *back = [[UINavigationItem alloc] initWithTitle:@"首页"];
    NSArray *items = [[NSArray alloc] initWithObjects:back,item,nil];
    [self.NavigationBar setItems:items animated:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *infoDict=[[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",infoDict);
    NSString *versionNum=[infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *appName=[infoDict objectForKey:@"CFBundleDisplayName"];
    self.VersionNameLabel.text=[NSString stringWithFormat:@"%@ %@",appName,versionNum];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *acountName=[ud objectForKey:@"displayname"];
    self.AcountNameLabel.text=acountName;
    
    self.TopImage.layer.masksToBounds=YES;
    self.TopImage.frame=CGRectMake(150, 58, 100, 100);
    self.TopImage.layer.cornerRadius=50;
    [self.view addSubview:self.TopImage];
    self.isDone=1;
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    //在此处添加点击back按钮之后的操作代码
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GoOut:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"0" forKey:@"LogID"];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"loginview"]; ///////通过storyboard来实例
    
    dispatch_after(0.4, dispatch_get_main_queue(), ^{
        [self presentViewController:vc animated:YES completion:nil];
    });
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"签退" message:@"签退成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}


- (IBAction)GoMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
