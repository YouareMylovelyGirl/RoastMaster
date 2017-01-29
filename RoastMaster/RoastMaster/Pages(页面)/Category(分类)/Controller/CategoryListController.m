//
//  CategoryListController.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "CategoryListController.h"
#import "NetManager.h"
#import "CategoryListCell.h"
#import "CategoryItem.h"
#import "CateListController.h"
@interface CategoryListController ()
/** 分类数组 */
@property(nonatomic,strong)NSArray *cateListArr;

/** 喜欢 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *loveArr;

/** 解档数组 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *archArr;


@end

@implementation CategoryListController

- (void)viewDidLoad {
    //解档
    //    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
    //    self.archArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.bounces = NO;
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI
{
    [NetManager GETCategoryItemCompletionHandler:^(CategoryItem *categorys, NSError *error) {
        if (!error) {
            self.cateListArr = categorys.data;
            [self.tableView reloadData];
        }
    }];
    [self.tableView registerClass:[CategoryListCell class] forCellReuseIdentifier:@"cell"];
    //    self.tableView.estimatedRowHeight = 80;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cateListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CategoryDataItem *dataItem = self.cateListArr[indexPath.row];
    [cell.iconIV setImageURL:dataItem.img_url.yg_url];
    
    
    return cell;
}

#pragma mark - 高性能自动计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDataItem *dataItem = self.cateListArr[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(CategoryListCell *cell) {
        [cell.iconIV setImageURL:dataItem.img_url.yg_url];
    }];
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDataItem *dataItem = self.cateListArr[indexPath.row];
    CateListController *listVC = [[CateListController alloc] initWithCollectionViewLayout:[[CHTCollectionViewWaterfallLayout alloc] init]];
    listVC.mainID = dataItem.mainId;
    listVC.title = dataItem.title;
    listVC.loveClick = ^(NSMutableArray *loveArr){
        self.loveArr = loveArr;
       
    };
    
    //归档
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
//    [NSKeyedArchiver archiveRootObject:self.loveArr toFile:filePath];
        listVC.CategoryLove = self.loveArr;
    [self.navigationController pushViewController:listVC animated:YES];
    
}

#pragma mark - lazy

- (NSMutableArray *)loveArr {
    if(_loveArr == nil) {
        _loveArr = [[NSMutableArray alloc] init];
    }
    return _loveArr;
}

- (NSMutableArray *)archArr {
    if(_archArr == nil) {
        _archArr = [[NSMutableArray alloc] init];
    }
    return _archArr;
}

@end
