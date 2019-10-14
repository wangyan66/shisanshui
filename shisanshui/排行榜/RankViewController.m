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
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTableView];
    
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rank"]];
    imageView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:imageView];
    
    WYtitleView * view = [WYtitleView loadView];
    CGRect frame = UIScreen.mainScreen.bounds;
    frame.size = CGSizeMake(kScreenW, 60);
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
    frame.origin = CGPointMake(0, 100);
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
    static NSString *reuseIdentifier = @"WYTableViewCell";
   WYTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell=[WYTableViewCell loadCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
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
