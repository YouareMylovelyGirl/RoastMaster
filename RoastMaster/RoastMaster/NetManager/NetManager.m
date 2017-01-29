//
//  NetManager.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+ (id)GETRecommendItem:(NSInteger)page completionHandler:(void (^)(RecommendItem *, NSError *))completionHandler
{
    NSString *recommendPath = [NSString stringWithFormat:@"http://zaijiawan.com/matrix_common/api/recipe/detailsbook?appname=tianhongbeishipu&hardware=iphone&os=ios&page=%ld&udid=58b4fa606a8af843ce9fb066f188a6e09ba405d7&version=2.1.0",page];
    return [self GET:recommendPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([RecommendItem Parse:obj], error);
    }];
}

+ (id)GETCategoryItemCompletionHandler:(void (^)(CategoryItem *, NSError *))completionHandler
{
    NSString *categoryPath = @"http://zaijiawan.com/matrix_common/api/recipe/mainbook?appname=tianhongbeishipu&hardware=iphone&info_flow_ad%3Dtrue=true&os=ios&udid=58b4fa606a8af843ce9fb066f188a6e09ba405d7&version=2.1.0";
    return [self GET:categoryPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([CategoryItem Parse:obj], error);
    }];
}

+ (id)GETRecommendItem:(NSInteger)page mainld:(NSString *)mainld completionHandler:(void (^)(RecommendItem *, NSError *))completionHandler
{
    NSString *mainldPath = [NSString stringWithFormat:@"http://zaijiawan.com/matrix_common/api/recipe/detailsbook?appname=tianhongbeishipu&hardware=iphone&mainId=%@&os=ios&page=%ld&udid=58b4fa606a8af843ce9fb066f188a6e09ba405d7&version=2.1.0", mainld, page];
    return [self GET:mainldPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([RecommendItem Parse:obj], error);
    }];
}
@end
