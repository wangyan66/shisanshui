//
//  WYhistoryTableViewCell.m
//  shisanshui
//
//  Created by 王焱 on 2019/10/15.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYhistoryTableViewCell.h"

@implementation WYhistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)loadCell{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WYhistoryTableViewCell" owner:self options:nil] lastObject];
}

@end
