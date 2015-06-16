//
//  DishesInfoViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "DishesInfoViewController.h"

@interface DishesInfoViewController ()
@property(nonatomic)NSDictionary *dishes;
@end

@implementation DishesInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSDictionary *GoodsInfo=[ud objectForKey:@"GoodsInfo"];
    self.dishes=GoodsInfo;
    NSString *url=self.dishes[@"picname"];
    self.Imageview.image=[UIImage imageNamed:url];
    
    self.TitleLabel.text=self.dishes[@"title"];
    self.DishesDescript.text=self.dishes[@"descrip"];
    self.PriceLabel.text=[NSString stringWithFormat:@"￥%@",self.dishes[@"price"]];
    self.TagLabel.text=self.dishes[@"tags"];
    self.DishesDescript.editable=NO;
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

- (IBAction)GoMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
