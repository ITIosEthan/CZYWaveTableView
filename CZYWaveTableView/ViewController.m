//
//  ViewController.m
//  CZYWaveTableView
//
//  Created by macOfEthan on 16/12/20.
//  Copyright © 2016年 macOfEthan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *czyTableView;

@property (nonatomic, strong) CzyWaveView *waveView;


@end

@implementation ViewController

#pragma mark - 初始化
- (CzyWaveView *)waveView
{
    if (_waveView == nil) {
        self.waveView = [[CzyWaveView alloc] initWithFrame:CGRectMake(0, 0, kCzyFullWidth, 100)];
    }
    return _waveView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInitNav];
    
    [self czyInitTableView];

}

#pragma mark - 设置导航栏
- (void)customInitNav
{
    self.navigationItem.title = @"波浪导航栏";
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma mark - 初始化表格视图
- (void)czyInitTableView
{
    
    self.czyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.czyTableView.delegate = self;
    self.czyTableView.dataSource = self;
    self.czyTableView.tableHeaderView = self.waveView;
    
    [self.view addSubview:self.czyTableView];
    self.czyTableView.tableFooterView = [UIView new];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offset=%f",offsetY);
    //CGFloat p = (offsetY + 220) / (200+64);
    
    // 计算导航透明度
    //self.navigationController.navigationBar.alpha = p;
    
    // 判断是否往下拖拽
    if (offsetY < -200) {
        
        CGFloat scale = (-offsetY - 200) * 0.01;
        
        self.waveView.transform = CGAffineTransformMakeScale(scale + 1, scale + 1);
    }
}

#pragma mark - 表格视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    
    cell.textLabel.text = @"abby ethan together forever!";
    cell.textLabel.textColor = kCzyBrownColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end





