//
//  CategoryListCell.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "CategoryListCell.h"

@implementation CategoryListCell



- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(UIEdgeInsetsMake(5, 10, 5, 10));
            CGFloat scale = 2.0 / 1;
            make.width.mas_equalTo(_iconIV.mas_height).multipliedBy(scale);
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }];
        
    }
    return _iconIV;
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
