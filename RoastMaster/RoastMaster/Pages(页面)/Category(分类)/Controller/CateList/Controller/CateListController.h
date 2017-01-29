//
//  CateListController.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendItem.h"
@interface CateListController : UICollectionViewController
/** mainID */
@property(nonatomic,strong)NSString *mainID;
/** 喜欢 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *CategoryLove;

- (instancetype)initWithMainID:(NSString *)mainID;

/** 回调 */
@property(nonatomic,strong)void(^loveClick)(NSMutableArray *);



@end
