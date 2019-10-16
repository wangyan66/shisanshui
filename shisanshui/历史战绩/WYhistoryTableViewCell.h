//
//  WYhistoryTableViewCell.h
//  shisanshui
//
//  Created by 王焱 on 2019/10/15.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYhistoryTableViewCell : UITableViewCell
+(instancetype)loadCell;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *poker;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

NS_ASSUME_NONNULL_END
