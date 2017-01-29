//
//  RecommendItem.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendDataItem,RecommendDataRecipesItem;



/**
 *  RecommendItem
 */
@interface RecommendItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *result;

@property (nonatomic, strong) RecommendDataItem *data;

@end



/**
 *  RecommendDataItem
 */
@interface RecommendDataItem : NSObject<NSCoding>

@property (nonatomic, strong) NSArray<RecommendDataRecipesItem *> *recipes;

@end




/**
 *  RecommendDataRecipesItem
 */
@interface RecommendDataRecipesItem : NSObject<NSCoding>
/**
 *  id -> ID
 */
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;
/**
 *  description -> des
 */
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *page_url;

@property (nonatomic, copy) NSString *img_url;

@end

