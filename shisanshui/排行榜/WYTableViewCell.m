//
//  WYTableViewCell.m
//  shisanshui
//
//  Created by ios group on 2019/10/14.
//  Copyright © 2019年 王焱. All rights reserved.
//

#import "WYTableViewCell.h"

@implementation WYTableViewCell

+(instancetype)loadCell{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WYTableViewCell" owner:self options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
