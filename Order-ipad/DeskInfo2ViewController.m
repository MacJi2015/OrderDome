//
//  DeskInfo2ViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/29.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "DeskInfo2ViewController.h"
#import "Desk2CollectionViewCell.h"
#import "Number.h"

@interface DeskInfo2ViewController ()
@property(nonatomic)NSArray *collectionData;
@property(nonatomic)int currentNum;
@end

@implementation DeskInfo2ViewController{
    NSMutableArray *collectionNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentNum=4;
    [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
    [self.FourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.collectionview registerClass:[Desk2CollectionViewCell class] forCellWithReuseIdentifier:@"Desk2CollectionCell"];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];

    self.collectionData=[ud objectForKey:@"tablelist"];
    for (NSDictionary *table in self.collectionData) {
        if ([table[@"havenum"] intValue] ==self.currentNum) {
            if (collectionNames.count==0) {
                collectionNames=[[NSMutableArray alloc]initWithObjects:table, nil];
            }else{
                [collectionNames addObject:table];
            }
        }
    }
//    collectionNames=[NSMutableArray arrayWithArray:self.collectionData];
   
//    [self.view addSubview:self.FourBtn];
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [collectionNames count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Desk2CollectionViewCell *cell=(Desk2CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Desk2CollectionCell" forIndexPath:indexPath];
    CALayer *layer=[cell.viewForBaselineLayout layer];
    [layer setCornerRadius:5.0];
    NSDictionary *desk=collectionNames[indexPath.row];
    NSLog(@"%@",desk);
    cell.DeskNumLabel.text=[NSString stringWithFormat:@"第%@桌",desk[@"tablename"]];
    Number *number=[[Number alloc]init];
    if( ![number isPureInt:desk[@"tablename"]] || ![number isPureFloat:desk[@"tablename"]])
    {
        cell.DeskNumLabel.text=[NSString stringWithFormat:@"%@",desk[@"tablename"]];
    }
    cell.DeskNumLabel.layer.masksToBounds=YES;
    cell.layer.borderWidth=1.0f;
    [cell addSubview:cell.DeskNumLabel];
    if ([desk[@"state"]intValue]!=0) {
        cell.BgImage.image=[UIImage imageNamed:@"已预订.png"];
    }else{
        cell.BgImage.image=[UIImage imageNamed:@"未订餐.png"];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
     NSDictionary *desk=collectionNames[indexPath.row];
//    if ([desk[@"state"]intValue]==0) {
        [ud setObject:desk[@"tablename"]  forKey:@"desknum"];
        //    [self dismissViewControllerAnimated:YES completion:^(void){
        ////        MainViewController *main=[[MainViewController alloc]init];
        //////        [main.DeskNumBtn setTitle:collectionNames[indexPath.row] forState:UIControlStateNormal];
        //////        [main viewDidAppear:YES];
        ////        [main do];
        ////        NSLog(@"hdhd");
        //
        //        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"mainview"]; ///////通过storyboard来实例
        //
        //        dispatch_after(0.4, dispatch_get_main_queue(), ^{
        //            [self presentViewController:vc animated:YES completion:nil];
        //        });
        //    }];
        
        
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"mainview"]; ///////通过storyboard来实例
        
        dispatch_after(0.4, dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:NO completion:nil];
        });
        
//    }else{
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"选择桌号" message:@"此桌已被预定或正在使用，请选择其他桌" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
    
}

- (IBAction)GoMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Forward:(id)sender {
    switch (self.currentNum) {
        case 1:
            break;
        case 2:
            [self.TwoBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.OneBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.OneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=1;
            
            break;
        case 3:
            [self.TreeBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TwoBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=2;
            break;
        case 4:
            [self.FourBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TreeBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=3;
            break;
        case 5:
            [self.FireBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=4;
            break;
        case 6:
            [self.SixBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.FireBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=5;
            break;
        case 7:
            [self.SevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.SixBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=6;
            break;
        case 8:
            [self.EightBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.SevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=7;
            break;
        case 9:
            [self.NineBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.EightBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=8;
            break;
        case 10:
            [self.TenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.NineBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=9;
            break;
        case 11:
            [self.ElevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=10;
            break;
        case 12:
            [self.TirthBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TirthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.ElevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=11;
            break;
        default:
            break;
    }
    [collectionNames removeAllObjects];
    for (NSDictionary *table in self.collectionData) {
        if ([table[@"havenum"] intValue] ==self.currentNum) {
            if (collectionNames.count==0) {
                collectionNames=[[NSMutableArray alloc]initWithObjects:table, nil];
            }else{
                [collectionNames addObject:table];
            }
        }
    }
    [self.collectionview reloadData];
}



- (IBAction)NextBtn:(id)sender {
    switch (self.currentNum) {
        case 1:
            [self.OneBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.OneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TwoBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=2;
            break;
        case 2:
            [self.TwoBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TreeBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=3;
            break;
        case 3:
            [self.TreeBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=4;
            break;
        case 4:
            [self.FourBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.FireBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=5;
            break;
        case 5:
            [self.FireBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.SixBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=6;
            break;
        case 6:
            [self.SixBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.SevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=7;
            break;
        case 7:
            [self.SevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.EightBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=8;
            break;
        case 8:
            [self.EightBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.NineBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=9;
            break;
        case 9:
            [self.NineBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=10;
            break;
        case 10:
            [self.TenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.ElevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=11;
            break;
        case 11:
            [self.ElevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.TirthBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TirthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=12;
            break;
        case 12:
            break;
        default:
            break;
    }

    [collectionNames removeAllObjects];
    for (NSDictionary *table in self.collectionData) {
        if ([table[@"havenum"] intValue] ==self.currentNum) {
            if (collectionNames.count==0) {
                collectionNames=[[NSMutableArray alloc]initWithObjects:table, nil];
            }else{
                [collectionNames addObject:table];
            }
        }
    }
    [self.collectionview reloadData];

}

- (IBAction)NumBtn:(id)sender {
    UIButton *button=(UIButton*)sender;
    
    NSLog(@"%d",self.currentNum);
    switch (self.currentNum) {
        case 1:
            [self.OneBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.OneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            break;
        case 2:
            [self.TwoBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 3:
            [self.TreeBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 4:
            [self.FourBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 5:
            [self.FireBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 6:
            [self.SixBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 7:
            [self.SevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 8:
            [self.EightBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 9:
            [self.NineBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 10:
            [self.TenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 11:
            [self.ElevenBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 12:
            [self.TirthBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.TirthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    switch ([button.titleLabel.text intValue]) {
        case 1:
            [self.OneBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.OneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=1;
            break;
        case 2:
            [self.TwoBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=2;
            break;
        case 3:
            [self.TreeBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=3;
            break;
        case 4:
            [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=4;
            break;
        case 5:
            [self.FireBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.FireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=5;
            break;
        case 6:
            [self.SixBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SixBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=6;
            break;
        case 7:
            [self.SevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.SevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=7;
            break;
        case 8:
            [self.EightBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.EightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=8;
            break;
        case 9:
            [self.NineBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.NineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=9;
            break;
        case 10:
            [self.TenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=10;
            break;
        case 11:
            [self.ElevenBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.ElevenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=11;
            break;
        case 12:
            [self.TirthBtn setBackgroundImage:[UIImage imageNamed:@"zhuohao.png"] forState:UIControlStateNormal];
            [self.TirthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.currentNum=12;
            break;
        default:
            break;
    }

    [collectionNames removeAllObjects];
    for (NSDictionary *table in self.collectionData) {
        if ([table[@"havenum"] intValue] ==self.currentNum) {
            if (collectionNames.count==0) {
                collectionNames=[[NSMutableArray alloc]initWithObjects:table, nil];
            }else{
                [collectionNames addObject:table];
            }
        }
    }
    [self.collectionview reloadData];

}
@end
