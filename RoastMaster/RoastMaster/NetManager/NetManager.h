//
//  NetManager.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "BaseNetManager.h"
#import "RecommendItem.h"
#import "CategoryItem.h"
@interface NetManager : BaseNetManager
//推荐
+ (id)GETRecommendItem:(NSInteger)page completionHandler:(void(^)(RecommendItem *recommends, NSError *error))completionHandler;

//分类
+ (id)GETCategoryItemCompletionHandler:(void(^)(CategoryItem *categorys, NSError *error))completionHandler;

//详细分类
+ (id)GETRecommendItem:(NSInteger)page mainld:(NSString *)mainld completionHandler:(void(^)(RecommendItem *recommends, NSError *error))completionHandler;
@end
