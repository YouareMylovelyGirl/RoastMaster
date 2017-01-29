//
//  RecommendWebController.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendItem.h"
@interface RecommendWebController : UIViewController
/** ID */
@property(nonatomic,assign)NSInteger ID;
/** web_url */
@property(nonatomic,strong)NSString *web_url;
/** RecommendDataRecipesItem模型 */
@property(nonatomic,strong)RecommendDataRecipesItem *recipesItem;

- (instancetype)initWithID:(NSInteger)ID web_url:(NSString *)web_url;

/** block回调 */
@property(nonatomic,strong)void(^recipesArray)(RecommendDataRecipesItem *);

/** 一共有多少喜欢 */
@property(nonatomic,strong)NSMutableArray *loveArr;

@property(nonatomic,strong)void(^disRecipesArray)(RecommendDataRecipesItem *);





@end
