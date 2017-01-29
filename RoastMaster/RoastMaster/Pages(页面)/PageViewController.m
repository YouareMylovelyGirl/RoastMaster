//
//  PageViewController.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "PageViewController.h"
#import "RecommendController.h"
#import "CategoryListController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.menuBGColor = [UIColor clearColor];
        self.titleColorSelected = [UIColor blackColor];
        self.showOnNavigationBar = YES;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.itemMargin = 10;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<NSString *> *)titles
{
    return @[@"推荐", @"分类", @"收藏"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
//    if (index == 0) {
//        return [[RecommendController alloc] initWithCollectionViewLayout:[[CHTCollectionViewWaterfallLayout alloc] init]];
//    }
    if (index == 1) {
        return [[CategoryListController alloc] init];
    }
    return [[RecommendController alloc] initWithCollectionViewLayout:[[CHTCollectionViewWaterfallLayout alloc] init]];
    
}
@end
