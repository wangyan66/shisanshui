//
//  RankViewController.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "RankViewController.h"
#import "WYTableViewCell.h"
#import "WYtitleView.h"
#import "ZWAPIRequestTool.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *DataAry;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.DataAry = [[NSArray alloc]init];
    [self fecthData];
    [self setupUI];
    [self setupTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)fecthData{
    __weak __typeof(self) weakSelf = self;
    [ZWAPIRequestTool requestRankInfo:^(id response, BOOL success) {
        NSLog(@"response%@",response);
        if (success) {
            weakSelf.DataAry = (NSArray *)response;
            [weakSelf.tableView reloadData];
        }
    }];
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rank"]];
    imageView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:imageView];
    
    WYtitleView * view = [WYtitleView loadView];
    CGRect frame = UIScreen.mainScreen.bounds;
    frame.size = CGSizeMake(kScreenW, 60);
    frame.origin = CGPointMake(0,34);
    view.frame = frame;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
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
    frame.origin = CGPointMake(0, 80);
    tableView.frame = frame;
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
}
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return 10;
    return self.DataAry.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"WYTableViewCell";
   WYTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell=[WYTableViewCell loadCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSString *str = [NSString stringWithFormat:@"第%ld名",indexPath.row+1];
    cell.rank.text = str;
    NSDictionary *data = _DataAry[indexPath.row];
    cell.name.text = (NSString *)data[@"name"];
    NSLog(@"%@",(NSString *)data[@"name"]);
    NSString *c1 = (NSString *)data[@"player_id"];
    NSString *c2 = (NSString *)data[@"score"];
    int v1 =[c1 intValue];
    int v2 =[c2 intValue];
    cell.ID.text = [NSString stringWithFormat:@"%d",v1 ];
    cell.score.text = [NSString stringWithFormat:@"%d",v2];
    NSLog(@"data:%@",data);
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 300;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    WYCommentModel *model=self.commentList[indexPath.row];
//   // NSLog(@"rowheight%f",model.rowHeight);
//    return model.rowHeight;
//
//}


@end
