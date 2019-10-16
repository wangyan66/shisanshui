//
//  WYHistoryViewController.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/15.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYHistoryViewController.h"
#import "WYhistoryTableViewCell.h"
#import "UserManager.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface WYHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WYHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史战绩";
    [self setupUI];
    [self setupTableView];
    [self fecthData];
    // Do any additional setup after loading the view.
}
- (void)fecthData{
    __weak __typeof(self) weakSelf = self;
    NSDictionary *headers = @{ @"x-auth-token": [UserManager sharedManager].token };
    NSDictionary *parameters = @{@"player_id":@474,@"limit":@5,@"page":@1};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/history"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                        NSLog(@"history response%@",responseObject);
                                                    }
                                                }];
    [dataTask resume];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rank"]];
    imageView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:imageView];
    
    
}
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = true;
    //tableView.estimatedRowHeight = 65;
    tableView.rowHeight = UITableViewAutomaticDimension;
    CGRect frame = UIScreen.mainScreen.bounds;
    frame.origin = CGPointMake(0, 44);
    tableView.frame = frame;
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"WYhistoryTableViewCell";
    WYhistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell=[WYhistoryTableViewCell loadCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
@end
