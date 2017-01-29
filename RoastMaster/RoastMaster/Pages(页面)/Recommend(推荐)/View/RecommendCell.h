//
//  RecommendCell.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UICollectionViewCell
/** 内容图片 */
@property(nonatomic,strong)UIImageView *titleIV;
/** 内容标题 */
@property(nonatomic,strong)UILabel *titleLB;
/** 内容详细 */
@property(nonatomic,strong)UILabel *describeLB;
/** 整体背景 */
@property(nonatomic,strong)UIView *backView;









@end
