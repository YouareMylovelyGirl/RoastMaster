//
//  RecommendController.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "RecommendController.h"
#import "NetManager.h"
#import "RecommendItem.h"
#import "RecommendCell.h"
#import "RecommendSmallCell.h"
#import "RecommendWebController.h"
@interface RecommendController ()<CHTCollectionViewDelegateWaterfallLayout>
/** 推荐数组 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *recommendArr;
/** 推荐页数 */
@property(nonatomic,assign)NSInteger pageNum;
/** 存放喜欢模型 */
@property(nonatomic,strong)NSMutableArray *loveArr;


@end

@implementation RecommendController

static NSString * const recommendCell = @"recommendCell";
static NSString * const recommendSmallCell = @"recommendSmallCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI
{
    //读取进度
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
    self.loveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.pageNum = 1;
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [NetManager GETRecommendItem:1 completionHandler:^(RecommendItem *recommends, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (!error) {
                
                [weakSelf.recommendArr removeAllObjects];
                [weakSelf.recommendArr addObjectsFromArray:recommends.data.recipes];
                [weakSelf.collectionView reloadData];
                if (recommends.data.recipes.count < 15) {
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
        [NetManager GETRecommendItem:weakSelf.pageNum + 1 completionHandler:^(RecommendItem *recommends, NSError *error) {
            [weakSelf.collectionView endFooterRefresh];
            if (!error) {
                weakSelf.pageNum += 1;
                [weakSelf.recommendArr addObjectsFromArray:recommends.data.recipes];
                [weakSelf.collectionView reloadData];
                if (recommends.data.recipes.count < 15) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
            }
        }];
    }];
    [self.collectionView registerClass:[RecommendCell class] forCellWithReuseIdentifier:recommendCell];
    [self.collectionView registerClass:[RecommendSmallCell class] forCellWithReuseIdentifier:recommendSmallCell];
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
        
    };
    webVC.disRecipesArray = ^(RecommendDataRecipesItem *disLove){
        [self.loveArr removeObject:disLove];
    };
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
//    [NSKeyedArchiver archiveRootObject:self.loveArr toFile:filePath];
//    NSLog(@"----------%@", filePath);
    
    webVC.loveArr = self.loveArr;
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

@end
