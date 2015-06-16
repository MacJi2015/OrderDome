//
//  GRCodeViewController.m
//  Order-ipad
//
//  Created by 郭嘉 on 15/5/26.
//  Copyright (c) 2015年 杭州有云科技. All rights reserved.
//

#import "GRCodeViewController.h"
#import "DeviceInfo.h"

@interface GRCodeViewController ()

@end

@implementation GRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *type=[ud objectForKey:@"type"];

    self.NavigationBar.delegate = self;
    UINavigationItem *item = [self.NavigationBar.items objectAtIndex:0];
    [self.NavigationBar pushNavigationItem:item animated:YES];
    UINavigationItem *back;
    if ([type isEqualToString:@"1"]) {
        back = [[UINavigationItem alloc] initWithTitle:@"上一步"];
        [ud setObject:@"0" forKey:@"type"];
    }else{
       back = [[UINavigationItem alloc] initWithTitle:@"首页"];
    }
    NSArray *items = [[NSArray alloc] initWithObjects:back,item,nil];
    [self.NavigationBar setItems:items animated:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSString *sum=[ud objectForKey:@"sum"];
    self.AmountLabel.text=[NSString stringWithFormat:@"￥ %@",sum];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
    NSString *url=[ud objectForKey:@"qrcodeurl"];
    NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
    //        self.TopImage.image=[[UIImage alloc]initWithData:data];
    
    self.CodeImageView.image=[[UIImage alloc]initWithData:data];
    
    if(!_timer){
        
        //创建一个定时器，这个是直接加到当前消息循环中，注意与其他初始化方法的区别
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkOrderState) userInfo:nil repeats:YES];
        
        //  [_timer fire]; //对于这个fire方法，稍后会详解，它不是启动一个定时器，这么简单
        
    }
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
-(void)checkOrderState{
    //    NSString *UUID=[DeviceInfo getIphoneUUID];//设备唯一标识
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *orderid=[ud objectForKey:@"orderid"];
    NSLog(@"%@",orderid);
    NSString *Orderids=[ud objectForKey:@"orderids"];
    NSLog(@"%@",Orderids);
    self.matchiingElemenr=@"GetOrderStateResult";
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<GetOrderState xmlns=\"http://tempuri.org/\">"
                         "<deviceid>%@</deviceid>"
                         "<payorderid>%@</payorderid>"
                         "<orderids>%@</orderids>"
                         "<opid>%@</opid>"
                         "<opass>%@</opass>"
                         "</GetOrderState>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",[ud objectForKey:@"UUID"],orderid,Orderids,[ud objectForKey:@"UserName"],
                         [ud objectForKey:@"Passwd"]];
    
    NSURL *url=[NSURL URLWithString:@"http://api.food.mobile.aduer.com/api.asmx"];
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [req addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.conn=[[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (self.conn) {
        self.webData=[NSMutableData data];
    }
    
}
//刚开始接受响应时调用
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self.webData setLength:0];
}

//每接收到一部分数据就追加到webData中
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.webData appendData:data];
}

//出现出错
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.conn=nil;
    self.webData=nil;
}

//完成接收数据时调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //    NSString *theXML=[[NSString alloc] initWithBytes:[self.webData mutableBytes] length:[self.webData length] encoding:NSUTF8StringEncoding];
    //打印出得到的XML
    //    NSLog(@"%@",theXML);
    //使用NSXMLParse解析出我们想要的结果
    self.xmlParser=[[NSXMLParser alloc] initWithData:self.webData];
    [self.xmlParser setDelegate:self];
    [self.xmlParser setShouldResolveExternalEntities:YES];
    [self.xmlParser parse];
}

//开始解析一个元素名称
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:self.matchiingElemenr]) {
        if (!self.soapResults) {
            self.soapResults=[[NSMutableString alloc]init];
        }
        self.elementFound=YES;
    }
}

//追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (self.elementFound) {
        //        NSLog(@"%@",string);
        [self.soapResults appendFormat:@"%@",string];
    }
}

//结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"%@",elementName);
    if ([elementName isEqualToString:self.matchiingElemenr]) {
        
        NSLog(@"%@",self.soapResults);
        NSData *string2data = [self.soapResults dataUsingEncoding:NSUTF8StringEncoding];
        
        id jsonobjc=[NSJSONSerialization JSONObjectWithData:string2data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",jsonobjc);
        if([[jsonobjc objectForKey:@"success"]intValue]==1){
            //收款成功
            
            [self dismissViewControllerAnimated:YES completion:^
             {
                 [self.timer invalidate];
                 [self.timer setFireDate:[NSDate distantFuture]];//关闭定时器
             }];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"收款" message:@"收款成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }
    
        self.elementFound=false;
        //强制放弃解析
        [self.xmlParser abortParsing];
    }else{
        if (self.isDone==1) {
            self.isDone=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"收款失败" message:@"接口错误，请联系管理员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }
        
    }
}

//解析整个文件结束
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    if (self.soapResults) {
        self.soapResults=nil;
    }
}

//出错时，例如强制结束解析
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    if (self.soapResults) {
        self.soapResults=nil;
    }
}

- (IBAction)GoMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
