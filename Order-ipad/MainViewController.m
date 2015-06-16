//
//  MainViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/22.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "MainViewController.h"
#import "HMSegmentedControl.h"
#import "CollectionViewCell.h"
#import "TableViewCell.h"
#import "CrossLineLabel.h"
#import "DeviceInfo.h"
#import "Number.h"

#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()
{
    long long expectedLength;
    long long currentLength;
}
@property(nonatomic)NSArray *data;
@property(nonatomic)NSArray *tabledata;
@property(nonatomic)NSDictionary *rowdata;
@property(nonatomic)int isDone;
@end

@implementation MainViewController{
//    NSMutableArray *tableNames;
    float sum;
    NSMutableArray *collectionNames;
    NSMutableArray *selectIDs;
    int total;
    int secondsCountDown;
}
static NSString *CellTableIdentifier=@"CellTableIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    // Do any additional setup after loading the view.
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSArray *classlist=[ud objectForKey:@"classlist"];
    NSMutableArray *classlistTitle;
    for (NSDictionary *class in classlist) {
        if (classlistTitle.count==0) {
            classlistTitle=[[NSMutableArray alloc]initWithObjects:class[@"classname"], nil];
        }else{
            [classlistTitle addObject:class[@"classname"]];
        }
        
    }

    int width=[UIScreen mainScreen].bounds.size.width;


    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:classlistTitle];
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.scrollEnabled = YES;
    [segmentedControl1 setBackgroundColor:[UIColor colorWithRed:42/255 green:59/255 blue:85/255 alpha:1]];

    [segmentedControl1 setTextColor:[UIColor whiteColor]];

    [segmentedControl1 setSelectionIndicatorColor:[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f]];
    [segmentedControl1 setSelectionStyle:HMSegmentedControlSelectionStyleBox];

    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl1 setFrame:CGRectMake(352, 55, width-372, 57)];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl1];
    
    [self.collectionview registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    self.collectionview.dataSource=self;
    self.collectionview.delegate=self;


    NSArray *foodlist=[ud objectForKey:@"foodlist"];
    self.data=[self GetFoodList:foodlist withClassList:classlist];
    NSLog(@"%@",self.data);

    self.tableNames=[NSMutableArray arrayWithArray:self.tabledata];
    collectionNames=[NSMutableArray arrayWithArray:self.data[0]];
    
    self.tableview.separatorStyle=UITableViewCellSelectionStyleNone;//去掉tableview分割线

    sum=0;
    total=0;
    
    [self.AcountNameBtn setTitle:[ud objectForKey:@"displayname"] forState:UIControlStateNormal];
    self.RestaurantNameLabel.text=[ud objectForKey:@"company"];

    NSLog(@"%@",[ud objectForKey:@"desknum"]);
    NSString *desknum=[ud objectForKey:@"desknum"];
    [self.DeskNumBtn setTitle:[NSString stringWithFormat:@"第%@桌",[ud objectForKey:@"desknum"]] forState:UIControlStateNormal];
    Number *number=[[Number alloc]init];
    if (![number isPureInt:desknum]||![number isPureFloat:desknum]) {//非数字
        [self.DeskNumBtn setTitle:[NSString stringWithFormat:@"%@",[ud objectForKey:@"desknum"]] forState:UIControlStateNormal];
    }
    if(!_timer){
        
        secondsCountDown = 1;//60秒倒计时
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
    }
    self.isDone=1;
    
}
-(NSArray *)GetFoodList:(NSArray *)foodlist withClassList:(NSArray *)classlist{
    NSLog(@"foodlist=%@",foodlist);
    NSLog(@"classlist=%@",classlist);
    NSMutableArray *resultlist;
    for (NSDictionary *class in classlist) {
        NSMutableArray *classm;
        for (NSDictionary *food in foodlist) {
            if ([class[@"classid"] intValue]==[food[@"classid"]intValue]) {
                if(classm.count==0){
                    classm=[[NSMutableArray alloc] initWithObjects:food, nil];
                }else{
                    [classm addObject:food];
                }
            }
        }
        if (classm.count==0) {
            classm=[[NSMutableArray alloc] initWithObjects:@{}, nil];;
        }
        if (resultlist.count==0) {
            resultlist=[[NSMutableArray alloc]initWithObjects:classm, nil];
        }else{
            [resultlist addObject:classm];
        }
    }
    NSLog(@"%@",resultlist);
    return resultlist;
}
-(void)timeFireMethod{
//    secondsCountDown--;
//    if(secondsCountDown==0){
//        [_timer invalidate];
//        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//        NSString *desknum=[ud objectForKey:@"desknum"];
//        if (desknum==nil) {
//            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"deskinfoview2"]; ///////通过storyboard来
//            vc.modalPresentationStyle=UIModalPresentationFormSheet;
//            vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
//            
//            dispatch_after(0.4, dispatch_get_main_queue(), ^{
//                [self presentModalViewController:vc animated:YES];
//            });
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)viewDidAppear:(BOOL)animated{
//    [self viewDidLoad];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [collectionNames count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell=(CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    CALayer *layer=[cell.viewForBaselineLayout layer];
    [layer setCornerRadius:5.0];
    //图片名称
//    NSLog(@"%@",self.data[indexPath.row]);
//    NSString *imageToLoad=self.data[indexPath.row];
    
    NSDictionary *rowdata=collectionNames[indexPath.row];
    
    if (rowdata!=nil&&rowdata.count!=0) {
        cell.alpha=1.0f;
        //加载图片
        NSString *url=rowdata[@"picname"];
        cell.imageview.image=[UIImage imageNamed:url];
        [cell.OrderBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        [cell.OrderBtn.layer setMasksToBounds:YES];
        [cell.OrderBtn.layer setCornerRadius:5.0];
        [cell.OrderBtn.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 0.5, 1 });
        [cell.OrderBtn.layer setBorderColor:colorref];
        
        //    cell.RealNum=[[CrossLineLabel alloc] initWithFrame:CGRectMake(66, 171, 42, 21)];
//        CrossLineLabel *Realnum=[[CrossLineLabel alloc] initWithFrame:CGRectMake(86, 171, 100, 21)];
//        Realnum.text=[NSString stringWithFormat:@"￥%@",rowdata[@"realNum"]];
//        Realnum.textColor=[UIColor grayColor];
//        [cell addSubview:Realnum];
        
        cell.GoodsName.text=[NSString stringWithFormat:@" %@",rowdata[@"title"]];
        cell.GoodsNum.text=[NSString stringWithFormat:@"￥%@",rowdata[@"price"]];
        cell.GoodsNum2Label.text=[NSString stringWithFormat:@"%@",rowdata[@"price"]];
        cell.IDLabel.text=[NSString stringWithFormat:@"%@",rowdata[@"id"]];
        
        cell.IconBtn.layer.masksToBounds=YES;
        cell.IconBtn.layer.cornerRadius=15;
        cell.IconBtn.alpha=0;
        NSLog(@"%@",selectIDs);
        for (NSDictionary *s in selectIDs) {
            NSLog(@"%@,%@",s,rowdata[@"id"]);
            if ([s[@"id"] isEqual:[NSString stringWithFormat:@"%@",rowdata[@"id"]]]) {
                cell.IconBtn.alpha=1;
                [cell.IconBtn setTitle:[NSString stringWithFormat:@"%@",s[@"num"]] forState:UIControlStateNormal];
            }
        }
        [cell addSubview:cell.IconBtn];

    }else{
        cell.alpha=0.0f;
    }
    
    
    return cell;
}
-(void)clickButton:(id)sender{

    
    self.OrderBtn.enabled=YES;
    NSLog(@"%@",self.tableNames);
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    
//    [self.tableNames addObject:@{@"name":@"涮菜",@"acountnum":@"10.5"}];
    NSDictionary *d=[ud objectForKey:@"dishes"];
    NSLog(@"%@",[ud objectForKey:@"dishes"]);
    NSLog(@"%@",d[@"id"]);
    
    total++;
    self.NumLabel.text=[NSString stringWithFormat:@"%d",total];
    sum+=[d[@"acountnum"]floatValue];
    self.SumLabel.text=[NSString stringWithFormat:@"%.2f",sum];
    if (total<9) {
        self.SumLabel.frame=CGRectMake(220, 63+total*30, self.SumLabel.layer.bounds.size.width, self.SumLabel.layer.bounds.size.height);
        self.SumTitleLabel.frame=CGRectMake(176, 63+total*30, self.SumTitleLabel.layer.bounds.size.width, self.SumTitleLabel.layer.bounds.size.height);
    }
    int n=1;
//    NSMutableArray *selectIDsCopy;
//    for (NSDictionary *sid in selectIDs) {
//        if ([sid[@"id"] isEqual:[NSString stringWithFormat:@"%@",d[@"id"]]]) {
//            n=n+[sid[@"num"] intValue];
//            NSLog(@"%@",sid);
////            [selectIDs removeObject:sid];//删除有问题
//        }else{
//            if (selectIDsCopy.count==0) {
//                selectIDsCopy=[[NSMutableArray alloc]initWithObjects:sid, nil];
//            }else{
//                [selectIDsCopy addObject:sid];
//            }
//            selectIDs=selectIDsCopy;//为了删除
//        }
//    }
    for (NSDictionary *sid in selectIDs) {
        if ([sid[@"id"] isEqual:[NSString stringWithFormat:@"%@",d[@"id"]]]) {
            n=n+[sid[@"num"] intValue];
            NSLog(@"%@",sid);
//            [selectIDs removeObject:sid];//删除有问题
            selectIDs=[self removeObject:sid];
        }
    }

    
    NSDictionary *s=@{@"id":[NSString stringWithFormat:@"%@",d[@"id"]],@"num":[NSString stringWithFormat:@"%d",n]};
    if (selectIDs.count==0) {
        selectIDs=[[NSMutableArray alloc]initWithObjects:s, nil];
     }else{
         [selectIDs addObject:s];
     }
    NSLog(@"%@",selectIDs);
    [self.collectionview reloadData];
    [self.tableNames addObject:[ud objectForKey:@"dishes"]];
//    sum=0;
    [self.tableview reloadData];
    NSLog(@"%@",self.tableNames);
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %li (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);

    [collectionNames removeAllObjects];
    collectionNames=[NSMutableArray arrayWithArray:self.data[segmentedControl.selectedSegmentIndex]];
    [self.collectionview reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    NSDictionary *rowData=self.tableNames[indexPath.row];
    NSLog(@"%@",self.tableNames);
    NSLog(@"%@",rowData);
    if (rowData!=nil) {
        int num=indexPath.row+1;
//        self.NumLabel.text=[NSString stringWithFormat:@"%d",num];
        cell.NameLabel.text=[NSString stringWithFormat:@"%ld %@",(long)num,rowData[@"name"]];
        cell.NameLabel.textColor=[UIColor whiteColor];
//        sum+=[rowData[@"acountnum"] floatValue];
//        NSLog(@"%.2f",sum);
//        self.SumLabel.text=[NSString stringWithFormat:@"%.2f",sum];
        cell.AcountNumLabel.text=[NSString stringWithFormat:@"￥%@",rowData[@"acountnum"]];
        cell.AcountNumLabel.textColor=[UIColor whiteColor];
    }
    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(100, 10, 30, 30)];
//    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.contentView addSubview:button];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选中");
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *m=self.data[indexPath.row];
//    NSLog(@"%@",m);
//    NSDictionary *l=@{@"name":m,@"acountnum":@"10"};
//    [tableNames addObject:l];
//    [self.tableview reloadData];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[ud objectForKey:@"type"]);
    NSDictionary *GoodsInfo=collectionNames[indexPath.row];
    [ud setObject:GoodsInfo forKey:@"GoodsInfo"];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"GoodsInfoView"]; ///////通过storyboard来
    vc.modalPresentationStyle=UIModalPresentationFormSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
//    dispatch_after(0.4, dispatch_get_main_queue(), ^{
//        [self presentModalViewController:vc animated:YES];
//    });
    [self presentModalViewController:vc animated:YES];
}
//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSString *m=self.data[indexPath.row];
//    NSLog(@"%@",m);
//    NSDictionary *l=@{@"name":m,@"acountnum":@"10"};
//    [tableNames addObject:l];
//    [self.tableview reloadData];
//}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//点击关闭
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)GetDeskInfo:(id)sender {

//    HUD=[[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"正在获取中......";
//

    
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSArray *tablelist=@[@{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"1"},
                         @{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"2"},
                         @{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"3"},
                         @{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"4"},
                         @{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"5"},
                         @{@"havenum":@"4",
                           @"state":@"0",
                           @"tableid":@"25",
                           @"tablename":@"6"}
                         ];
    
    [ud setObject:tablelist forKey:@"tablelist"];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"deskinfoview2"]; ///////通过storyboard来
    vc.modalPresentationStyle=UIModalPresentationFormSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    //            dispatch_after(0.4, dispatch_get_main_queue(), ^{
    //                [self presentModalViewController:vc animated:YES];
    //            });
    [self presentModalViewController:vc animated:YES];

}

- (IBAction)GetAcountInfo:(id)sender {
    
    HUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在获取中......";
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"acountview"]; ///////通过storyboard来
    vc.modalPresentationStyle=UIModalPresentationFormSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
//    dispatch_after(0.4, dispatch_get_main_queue(), ^{
//        [self presentModalViewController:vc animated:YES];
//    });
    [self presentModalViewController:vc animated:YES];
}

- (IBAction)Order:(id)sender {
   //下单
//    HUD=[[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"正在下单中......";
//    
//    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:@"order" forKey:@"alertType"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"下单" message:@"是否确定下单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==1) {
//        NSLog(@"%lu",(unsigned long)self.OrderAll.count);
//        if (self.OrderAll.count==0) {
//            self.OrderAll=[self.tableNames mutableCopy];
//        }else{
//            for (NSDictionary *o in self.tableNames) {
//                [self.OrderAll addObject:o];
//            }
//        }
//        NSLog(@"%lu",(unsigned long)self.OrderAll.count);
//        [self.tableNames removeAllObjects];
//        total=0;
//        sum=0;
//        [self.tableview reloadData];
//        self.NumLabel.text=@"0";
//        self.SumLabel.text=@"0";
//    }
//}
- (IBAction)GetDishes:(id)sender {
    
//    HUD=[[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"正在获取中......";
//    
//    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:self.OrderAll forKey:@"OrderAll"];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"OrderInfo"]; ///////通过storyboard来
    
    vc.modalPresentationStyle=UIModalPresentationFormSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:vc animated:YES];
    vc.view.superview.frame=CGRectMake(0, 0, 100, 100);
    

}

- (IBAction)CheckOut:(id)sender {//结账

    float sum2=0.00;
    for (NSDictionary *s in self.OrderAll) {
        sum2+=[s[@"price"] floatValue];
    }
    NSLog(@"%f",sum2);
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:[NSString stringWithFormat:@"%.2f",sum2] forKey:@"sum"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"结账" message:@"结账成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]forKey:@"deleteNum"];
        [ud setObject:@"del" forKey:@"alertType"];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"删除" message:@"确认是否删除此菜品" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
//        [self.tableNames removeObjectAtIndex:[indexPath row]];
////        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
////        [self.tableview deleteSections:[NSIndexSet indexSetWithIndex:indexPath.row] withRowAnimation:UITableViewRowAnimationFade];
//        [self.tableview reloadData];
        
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    tableView.editing=YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *alertType=[ud objectForKey:@"alertType"];
    if ([alertType isEqualToString:@"del"]) {
        //删除
        if (buttonIndex==1) {
            //确认按钮
            //        NSLog(@"1");
            
            int num=[[ud objectForKey:@"deleteNum"]intValue];
            NSDictionary *d=self.tableNames[num];
            for (NSDictionary *s in selectIDs) {
                if ([s[@"id"] isEqual:d[@"id"]]) {
                    int num=[s[@"num"]intValue];
                    if (num>1) {
                        num--;
                        NSDictionary *sid=@{@"id":s[@"id"],@"num":[NSString stringWithFormat:@"%d",num]};
                        //                    [selectIDs removeObject:s];
                        selectIDs=[self removeObject:s];
                        [selectIDs addObject:sid];
                        [self.collectionview reloadData];
                    }else{
                        //                    [selectIDs removeObject:s];
                        selectIDs=[self removeObject:s];
                        [self.collectionview reloadData];
                    }
                }
            }
            int m=[self.NumLabel.text intValue];
            m--;
            self.NumLabel.text=[NSString stringWithFormat:@"%d",m];
            NSLog(@"%f",[d[@"acountnum"] floatValue]);
            float n=[self.SumLabel.text floatValue]-[d[@"acountnum"] floatValue];
            NSLog(@"%f",n);
            self.SumLabel.text=[NSString stringWithFormat:@"%.2f",n];
            [self.tableNames removeObjectAtIndex:num];
            //        sum=0;
            if (self.tableNames.count==0) {
                self.OrderBtn.enabled=NO;
            }
            [self.tableview reloadData];
        }else if(buttonIndex==0){
            //取消按钮
            [self.tableview reloadData];
        }
    }else if([alertType isEqualToString:@"order"]){
        //下单
        
        if (buttonIndex==1) {
            
            NSString *ids=@"";
            for (int i=0;i<self.tableNames.count;i++) {
                NSDictionary *order=self.tableNames[i];
                ids=[ids stringByAppendingString:[NSString stringWithFormat:@"%@",order[@"id"]]];
                if (i!=self.tableNames.count-1) {
                    ids=[ids stringByAppendingString:@","];
                }
            }
            NSLog(@"%@",ids);
           
            if (self.OrderAll.count==0) {
                self.OrderAll=[self.tableNames mutableCopy];
            }else{
                for (NSDictionary *o in self.tableNames) {
                    [self.OrderAll addObject:o];
                }
            }
            NSLog(@"%lu",(unsigned long)self.OrderAll.count);
            [self.tableNames removeAllObjects];
            total=0;
            sum=0;
            self.OrderBtn.enabled=NO;
            
            [self.tableview reloadData];
            self.NumLabel.text=@"0";
            self.SumLabel.text=@"0";
            self.SumLabel.frame=CGRectMake(220, 312, 67, 21);
            self.SumTitleLabel.frame=CGRectMake(176, 312, 41, 21);
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"下单" message:@"下单成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];

        }

    }
}
-(NSMutableArray *)removeObject:(NSDictionary *)s{
    NSMutableArray *selectIDsCopy;
    for (NSDictionary *sid in selectIDs) {
        if ([sid[@"id"] isEqual:s[@"id"]]) {
           //不操作
        }else{
            if (selectIDsCopy.count==0) {
                selectIDsCopy=[[NSMutableArray alloc]initWithObjects:sid, nil];
            }else{
                [selectIDsCopy addObject:sid];
            }
        }
    }
    return selectIDsCopy;
}


- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

@end
