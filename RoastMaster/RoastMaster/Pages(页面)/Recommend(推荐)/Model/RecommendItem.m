//
//  RecommendItem.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "RecommendItem.h"

@implementation RecommendItem
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"data"];
}
//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}
@end


@implementation RecommendDataItem
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.recipes forKey:@"recipes"];
}
//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.recipes = [aDecoder decodeObjectForKey:@"recipes"];
    }
    return self;
}

+ (NSDictionary<NSString *,id> *)
modelContainerPropertyGenericClass
{
    
    return @{
             @"recipes":@"RecommendDataRecipesItem"
             };
}

@end


@implementation RecommendDataRecipesItem

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.des forKey:@"des"];
    [aCoder encodeObject:self.page_url forKey:@"page_url"];
    [aCoder encodeObject:self.img_url forKey:@"img_url"];
    
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.des = [aDecoder decodeObjectForKey:@"des"];
        self.page_url = [aDecoder decodeObjectForKey:@"page_url"];
        self.img_url = [aDecoder decodeObjectForKey:@"img_url"];
    }
    return self;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end




