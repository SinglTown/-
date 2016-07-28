//
//  KindStrategyTableViewCell.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "KindStrategyTableViewCell.h"

@implementation KindStrategyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self) {
      [self createMyView];
   }
   return self;
}

- (void)createMyView
{
   self.kindStrategyImageV = [[UIImageView alloc] init];
   [self.contentView addSubview: self.kindStrategyImageV];
   
   self.bgLabel = [[UILabel alloc] init];
   [self.contentView addSubview:self.bgLabel];
   
   self.titleLabel = [[UILabel alloc] init];
   [self.contentView addSubview:self.titleLabel];
   
   
}

- (void)layoutSubviews
{
   [super layoutSubviews];
   self.kindStrategyImageV.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
   self.kindStrategyImageV.backgroundColor = [UIColor blackColor];
   
   self.bgLabel.frame = CGRectMake(0, self.contentView.frame.size.height - 50, self.contentView.frame.size.width, 50);
   self.bgLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
   
   self.titleLabel.frame = CGRectMake(10, self.contentView.frame.size.height - 50, self.bgLabel.frame.size.width - 20, self.bgLabel.frame.size.height);
   self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)setKindStrategyModal:(KindStrategyModal *)kindStrategyModal
{
   self.titleLabel.text = kindStrategyModal.title;
   // 自适应 必须按照下边的顺序
   self.titleLabel.font = [UIFont systemFontOfSize:18];
   self.titleLabel.numberOfLines = 10000;
   [self.titleLabel sizeToFit];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
