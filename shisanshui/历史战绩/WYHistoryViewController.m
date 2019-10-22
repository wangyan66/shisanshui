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
#import "WYDetailHistoryViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface WYHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;
@end

@implementation WYHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史战绩";
    _dataAry = [NSMutableArray array];
    [self setupUI];
    [self setupTableView];
    [self fecthData];
    // Do any additional setup after loading the view.
}
- (void)fecthData{
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary *headers = @{ @"x-auth-token": [UserManager sharedManager].token };
    NSString *str = [NSString stringWithFormat:@"https://api.shisanshui.rtxux.xyz/history?page=1&limit=10&player_id=%@",[UserManager sharedManager].user_id];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    
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
                                                        self.dataAry= responseObject[@"data"];
                                                        [self relo];
                                                    }
                                                }];
    [dataTask resume];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)relo{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}
-(NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    NSLog(@"currentDate%@",currentDateStr);
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
    
    
    return _dataAry.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"WYhistoryTableViewCell";
    WYhistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell=[WYhistoryTableViewCell loadCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dic = _dataAry[indexPath.row];
    NSArray *card = dic[@"card"];
    cell.ID.text=[NSString stringWithFormat:@"战局ID:%@",dic[@"id"]];
    if(card.count == 1){
        
    cell.poker.text=[NSString stringWithFormat:@"%@",card[0]];
    }else{
        cell.poker.text=[NSString stringWithFormat:@"%@ %@ %@",card[0],card[1],card[2]];
    }
    
    cell.score.text=[NSString stringWithFormat:@"分数:%@",dic[@"score"]];
    
    cell.time.text = [self getDateStringWithTimeStr:dic[@"timestamp"]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WYDetailHistoryViewController *vc = [[WYDetailHistoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
