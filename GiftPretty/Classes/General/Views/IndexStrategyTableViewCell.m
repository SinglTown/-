//
//  IndexStrategyTableViewCell.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexStrategyTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation IndexStrategyTableViewCell

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
   self.indexStrategyImageV = [[UIImageView alloc] init];
   [self.contentView addSubview: self.indexStrategyImageV];
   
   self.bgLabel = [[UILabel alloc] init];
   [self.indexStrategyImageV addSubview:self.bgLabel];
   
   self.titleLabel = [[UILabel alloc] init];
   [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews
{
   [super layoutSubviews];
   self.indexStrategyImageV.frame = CGRectMake(10, 5, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 10);
   self.indexStrategyImageV.layer.borderWidth = 0.4;
   self.indexStrategyImageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
   self.indexStrategyImageV.layer.masksToBounds = YES;
   self.indexStrategyImageV.layer.cornerRadius = 10;
   
   self.bgLabel.frame = CGRectMake(0, self.indexStrategyImageV.frame.size.height - 50, self.indexStrategyImageV.frame.size.width, 50);
   self.bgLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
   
   self.titleLabel.frame = CGRectMake(10, self.contentView.frame.size.height - 50, self.bgLabel.frame.size.width - 20, self.bgLabel.frame.size.height);
   self.titleLabel.textColor = [UIColor whiteColor];
   self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setIndexStrategy:(IndexStrategyModal *)indexStrategy
{
   [self.indexStrategyImageV sd_setImageWithURL:[NSURL URLWithString:indexStrategy.cover_image_url] placeholderImage:[UIImage imageNamed:@"cacheImage3"]];
   self.titleLabel.text = indexStrategy.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
