//
//  RecommendCell.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell
- (UIImageView *)titleIV {
    if(_titleIV == nil) {
        _titleIV = [[UIImageView alloc] init];
        _titleIV.contentMode = UIViewContentModeScaleAspectFill;
        _titleIV.clipsToBounds = YES;
        [self.backView addSubview:_titleIV];
        [_titleIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            CGFloat scale = 4 / 3.0;
            make.height.mas_equalTo(_titleIV.mas_width).multipliedBy(scale);
        }];
    }
    return _titleIV;
}

- (UILabel *)titleLB {
    if(_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:14];
        [self.backView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.right.offset(-5);
            make.top.mas_equalTo(self.titleIV.mas_bottom).offset(5);
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.6;
        [self.backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-3);
            make.left.offset(3);
            make.height.offset(1);
            make.top.mas_equalTo(_titleLB.mas_bottom).offset(5);
        }];
    }
    return _titleLB;
}

- (UILabel *)describeLB {
    if(_describeLB == nil) {
        _describeLB = [[UILabel alloc] init];
        _describeLB.font = [UIFont systemFontOfSize:13];
        _describeLB.textColor = [UIColor grayColor];
        [self.backView addSubview:_describeLB];
        [_describeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(3);
            make.right.offset(-3);
            make.top.mas_equalTo(self.titleLB.mas_bottom).offset(10);
        }];
    }
    return _describeLB;
}

- (UIView *)backView {
    if(_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 4;
        _backView.layer.borderWidth = 1;
        _backView.clipsToBounds = YES;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return _backView;
}
@end
