//
//  DetailViewCell.m
//  SanguoshaData
//
//  Created by Felix Kwan on 13/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "DetailViewCell.h"

@implementation DetailViewCell
@synthesize detailLabel, titleButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
