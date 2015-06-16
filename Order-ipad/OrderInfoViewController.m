//
//  OrderInfoViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderTableViewCell.h"

@interface OrderInfoViewController ()

@end

@implementation OrderInfoViewController{
    NSMutableArray *tableNames;
    float sum;
}

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
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    tableNames=[[ud objectForKey:@"OrderAll"]mutableCopy];
    NSLog(@"%@",tableNames);
    self.NumLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)tableNames.count];
    sum=0.00;
    for (NSDictionary *s in tableNames) {
        sum+=[s[@"acountnum"] floatValue];
    }
    self.SumLabel.text=[NSString stringWithFormat:@"￥ %.2f",sum];
    NSLog(@"%@",tableNames);

    self.tableview.separatorStyle=UITableViewCellSelectionStyleNone;//去掉tableview分割线

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:@"OrderCellTableIdentifier" forIndexPath:indexPath];
    NSDictionary *rowData=tableNames[indexPath.row];
    if (rowData!=nil) {
        int num=indexPath.row+1;
        cell.NameLabel.text=[NSString stringWithFormat:@"%d %@",num,rowData[@"name"]];
        cell.AcountNumLabel.text=[NSString stringWithFormat:@"￥%@",rowData[@"acountnum"]];

    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选中");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)checkout:(id)sender {
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:[NSString stringWithFormat:@"%.2f",sum] forKey:@"sum"];
    [ud setObject:@"1" forKey:@"type"];
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"QRCodeview"]; ///////通过storyboard来
    
    vc.modalPresentationStyle=UIModalPresentationFormSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    dispatch_after(0.4, dispatch_get_main_queue(), ^{
        [self presentModalViewController:vc animated:YES];
    });
    vc.view.superview.frame=CGRectMake(0, 0, 100, 100);
   
}
- (IBAction)GoMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
