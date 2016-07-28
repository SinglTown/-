//
//  BeautifulThingsTableViewCell.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "BeautifulThingsTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation BeautifulThingsTableViewCell
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
   self.beautifulThingsImageV = [[UIImageView alloc] init];
   [self.contentView addSubview: self.beautifulThingsImageV];
   
   self.bgLabel = [[UILabel alloc] init];
   [self.beautifulThingsImageV addSubview:self.bgLabel];
   
   self.titleLabel = [[UILabel alloc] init];
   [self.contentView addSubview:self.titleLabel];
   
   
}

- (void)layoutSubviews
{
   [super layoutSubviews];
   self.beautifulThingsImageV.frame = CGRectMake(10, 5, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 10);
   self.beautifulThingsImageV.layer.masksToBounds = YES;
   self.beautifulThingsImageV.layer.cornerRadius = 10;
   self.beautifulThingsImageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
   self.beautifulThingsImageV.layer.borderWidth = 0.4;
   
   
   self.bgLabel.frame = CGRectMake(0, self.beautifulThingsImageV.frame.size.height - 50, self.beautifulThingsImageV.frame.size.width, 50);
   self.bgLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
   
   self.titleLabel.frame = CGRectMake(15, self.contentView.frame.size.height - 50, self.bgLabel.frame.size.width - 30, self.bgLabel.frame.size.height);
   self.titleLabel.textColor = [UIColor whiteColor];
   self.titleLabel.font = [UIFont systemFontOfSize:16];
}

- (void)setBeautifulThingsModal:(BeautifulThingsModal *)beautifulThingsModal
{
   [self.beautifulThingsImageV sd_setImageWithURL:[NSURL URLWithString:beautifulThingsModal.cover_image_url] placeholderImage:[UIImage imageNamed:@"cacheImage3"]];
   self.titleLabel.text = beautifulThingsModal.title;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
