//
//  CategoryItem.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryDataItem;
@interface CategoryItem : NSObject

@property (nonatomic, copy) NSString *result;

@property (nonatomic, strong) NSArray<CategoryDataItem *> *data;

@end

@interface CategoryDataItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *mainId;

@property (nonatomic, copy) NSString *img_url;

@end

