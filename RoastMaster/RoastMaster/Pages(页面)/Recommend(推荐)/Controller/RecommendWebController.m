//
//  RecommendWebController.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/26.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "RecommendWebController.h"

@interface RecommendWebController ()<UIWebViewDelegate>
/** webView */
@property(nonatomic,strong)UIWebView *webView;
/** 模型数组 */
@property(nonatomic,strong)NSMutableArray<RecommendDataRecipesItem *> *RecipesItemArr;
/** 喜欢按钮 */
@property(nonatomic,strong)UIButton *loveBtn;


@end

@implementation RecommendWebController

- (instancetype)initWithID:(NSInteger)ID web_url:(NSString *)web_url
{
    if (self = [super init]) {
        self.ID = ID;
        self.web_url = web_url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self circleArr];
    [self configWebView];
    [self configNavigationItem];
}



/**
 *  便利数组查看是否有已经选中的按钮
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath = [path stringByAppendingPathComponent:@"LOVE"];
//    NSMutableArray *loveArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    for (RecommendDataRecipesItem *recipesItem in self.loveArr) {
        if (self.ID == recipesItem.ID) {
            NSLog(@"相同");
            self.loveBtn.selected = YES;
        }
    }
}

- (void)configNavigationItem
{
    UIButton *loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loveBtn = loveBtn;
    loveBtn.frame = CGRectMake(0, 0, 20, 20);
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"likeItem_20x20_"] forState:UIControlStateNormal];
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"likeItem_selected_20x20_"] forState:UIControlStateSelected];
    [loveBtn addTarget:self action:@selector(clickLoveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *loveItem = [[UIBarButtonItem alloc] initWithCustomView:loveBtn];
    self.navigationItem.rightBarButtonItem = loveItem;
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.frame = CGRectMake(0, 0, 10, 18);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"jiantou_20x36_@1x"] forState:UIControlStateNormal   ];
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"jiantou_20x36_@1x"] forState:UIControlStateHighlighted];
    [goBackBtn addTarget:self action:@selector(goBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    self.navigationItem.leftBarButtonItem = goBack;
}

//点击喜欢按钮
- (void)clickLoveBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.RecipesItemArr addObject:self.recipesItem];
        self.recipesArray(self.recipesItem);
    }
    else
    {
        [self.RecipesItemArr removeObject:self.recipesItem];
        self.disRecipesArray(self.recipesItem);
    }
    NSLog(@"%ld", self.RecipesItemArr.count);
}


- (void)goBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configWebView
{
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.web_url.yg_url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIWebViewDelegate>
//通过返回值来决定是否来加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (webView.isLoading) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!webView.isLoading) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//#pragma mark - 控制器即将销毁
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.recipesArray(self.RecipesItemArr);
//}


#pragma mark - lazy
- (NSMutableArray *)RecipesItemArr {
	if(_RecipesItemArr == nil) {
		_RecipesItemArr = [[NSMutableArray alloc] init];
	}
	return _RecipesItemArr;
}

@end
