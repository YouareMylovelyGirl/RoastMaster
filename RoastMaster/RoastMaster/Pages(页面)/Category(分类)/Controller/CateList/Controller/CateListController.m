//
//  CateListController.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "CateListController.h"
#import "NetManager.h"
#import "RecommendItem.h"
#import "RecommendCell.h"
#import "RecommendSmallCell.h"
#import "RecommendWebController.h"
@interface CateListController ()<CHTCollectionViewDelegateWaterfallLayout>
/** 推荐数组 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *recommendArr;
/** 推荐页数 */
@property(nonatomic,assign)NSInteger pageNum;
/** 存放喜欢模型 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *loveArr;


@end

@implementation CateListController

static NSString * const recommendCell = @"recommendCell";
static NSString * const recommendSmallCell = @"recommendSmallCell";

- (instancetype)initWithMainID:(NSString *)mainID
{
    if (self = [super init]) {
        self.mainID = mainID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self leftBarButtonItem];
}

- (void)configUI
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.pageNum = 1;
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [NetManager GETRecommendItem:1 mainld:weakSelf.mainID completionHandler:^(RecommendItem *recommends, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (!error) {
                
                //读取进度
                NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
                NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
                weakSelf.loveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                
                [weakSelf.recommendArr removeAllObjects];
                [weakSelf.recommendArr addObjectsFromArray:recommends.data.recipes];
                [weakSelf.collectionView reloadData];
                if (recommends.data.recipes.count < 40) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
                else
                {
                    [weakSelf.collectionView resetNoMoreData];
                }
            }
        }];
        
    }];
    
    [self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [NetManager GETRecommendItem:weakSelf.pageNum + 1 mainld:weakSelf.mainID completionHandler:^(RecommendItem *recommends, NSError *error) {
            [weakSelf.collectionView endFooterRefresh];
            if (!error) {
                weakSelf.pageNum += 1;
                NSLog(@"页数为%ld", weakSelf.pageNum);
                [weakSelf.recommendArr addObjectsFromArray:recommends.data.recipes];
                [weakSelf.collectionView reloadData];
                if (recommends.data.recipes.count < 40) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
            }
        }];
    }];
    [self.collectionView registerClass:[RecommendCell class] forCellWithReuseIdentifier:recommendCell];
    [self.collectionView registerClass:[RecommendSmallCell class] forCellWithReuseIdentifier:recommendSmallCell];
    
    
    
}

- (void)leftBarButtonItem
{
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.frame = CGRectMake(0, 0, 10, 18);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"jiantou_20x36_@1x"] forState:UIControlStateNormal   ];
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"jiantou_20x36_@1x"] forState:UIControlStateHighlighted];
    [goBackBtn addTarget:self action:@selector(goBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    self.navigationItem.leftBarButtonItem = goBack;
}

- (void)goBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommendDataRecipesItem *recipesItem = self.recommendArr[indexPath.row];
    if (indexPath.row == 1) {
        RecommendSmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendSmallCell forIndexPath:indexPath];
        [cell.titleIV setImageWithURL:self.recommendArr[indexPath.row].img_url.yg_url placeholder:[UIImage imageNamed:@"loadIcon_100x100_"]];
        cell.titleLB.text = recipesItem.title;
        cell.describeLB.text = recipesItem.des;
        return cell;
    }
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendCell forIndexPath:indexPath];
    [cell.titleIV setImageWithURL:self.recommendArr[indexPath.row].img_url.yg_url placeholder:[UIImage imageNamed:@"loadIcon_100x100_"]];
    cell.titleLB.text = recipesItem.title;
    cell.describeLB.text = recipesItem.des;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendWebController *webVC = [[RecommendWebController alloc] initWithID:self.recommendArr[indexPath.row].ID web_url:self.recommendArr[indexPath.row].page_url];
    webVC.title = self.recommendArr[indexPath.row].title;
    webVC.recipesItem = self.recommendArr[indexPath.row];
    
    webVC.recipesArray = ^(RecommendDataRecipesItem *love){
        [self.loveArr addObject:love];
        NSLog(@"-love--%ld", self.loveArr.count);
        //归档
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
//        [NSKeyedArchiver archiveRootObject:self.loveArr toFile:filePath];
        //    webVC.loveArr = self.loveArr;
        
        //读取进度
//        NSString *path1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *filePath1 = [path1 stringByAppendingPathComponent:@"LOVE"];
//        self.loveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    };
    webVC.disRecipesArray = ^(RecommendDataRecipesItem *disLove){
        [self.loveArr removeObject:disLove];
        NSLog(@"-disLove--%ld", self.loveArr.count);
//        //归档
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
//        [NSKeyedArchiver archiveRootObject:self.loveArr toFile:filePath];
        //    webVC.loveArr = self.loveArr;
        
        //读取进度
//        NSString *path1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *filePath1 = [path1 stringByAppendingPathComponent:@"LOVE"];
//        self.loveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    };
    //归档
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
    [NSKeyedArchiver archiveRootObject:self.loveArr toFile:filePath];
    webVC.loveArr = self.CategoryLove;
    //传到上一个控制器
//    self.loveClick(self.loveArr);
    NSLog(@"%@", filePath);
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        CGFloat scale = 4 / 5.0;
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        CGFloat height = width * scale + 50;
        return CGSizeMake(width, height);
    }
    CGFloat scale = 5 / 4.0;
    CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30) / 2);
    CGFloat height = width * scale + 70;
    return CGSizeMake(width, height);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - lazy
- (NSMutableArray *)recommendArr {
    if(_recommendArr == nil) {
        _recommendArr = [[NSMutableArray alloc] init];
    }
    return _recommendArr;
}

- (NSMutableArray *)loveArr {
    if(_loveArr == nil) {
        _loveArr = [[NSMutableArray alloc] init];
    }
    return _loveArr;
}

- (NSMutableArray *)CategoryLove {
    if(_CategoryLove == nil) {
        _CategoryLove = [[NSMutableArray alloc] init];
    }
    return _CategoryLove;
}

@end
