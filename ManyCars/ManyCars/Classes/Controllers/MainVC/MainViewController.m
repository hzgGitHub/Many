//
//  MainViewController.m
//  ManyCars
//
//  Created by tom on 2017/8/17.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
#import "ZGScrollView.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,ZGScrollViewNetDelegate>

@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSArray *netImageArray;
@property (nonatomic,strong)ZGScrollView *zgScrollView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"众车易家";
    
    [self mainTableView];
    
}
//创建滚动视图网络图片数据
- (NSArray *)netImageArray {
    if (!_netImageArray) {
        _netImageArray = @[@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg"];
    }
    return _netImageArray;

}
//创建网络图片滚动视图
//-(void)createNetScrollView
//{
//    /** 设置网络scrollView的Frame及所需图片*/
//    ZGScrollView *ZGNetScrollView = [[ZGScrollView alloc]initWithFrame:CGRectMake(0, 0, KscreenW, 166) withNetImages:self.netImageArray];
//    _zgScrollView = ZGNetScrollView;
//    
//    /** 设置滚动延时*/
//    ZGNetScrollView.autoScrollDelay = 1.2;
//    
//    /** 设置占位图*/
//    ZGNetScrollView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
//    
//    
//    /** 获取网络图片的index*/
//    ZGNetScrollView.netDelegate = self;
//    
//    
//}

//懒加载
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH - 49) style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.bounces = NO;
        [self.view addSubview:_mainTableView];
    
    }

    return _mainTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 166;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3.6;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ZGScrollView *ZGNetScrollView = [[ZGScrollView alloc]initWithFrame:CGRectMake(0, 0, KscreenW, 166) withNetImages:self.netImageArray];
        /** 设置滚动延时*/
    ZGNetScrollView.autoScrollDelay = 2.0;
    
    /** 设置占位图*/
    //ZGNetScrollView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        
    /** 获取网络图片的index*/
    ZGNetScrollView.netDelegate = self;
    return ZGNetScrollView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//实现滚动视图代理点击方法
- (void)didSelectedNetImageAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
