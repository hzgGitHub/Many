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
//首页scrollView所需网络图片Array
@property (nonatomic,strong)NSArray *netImageArray;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"众车易家";
    
    
    //添加主页TableView
    [self mainTableView];
    
}
//创建滚动视图网络图片数据
- (NSArray *)netImageArray {
    if (!_netImageArray) {
        _netImageArray = @[@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg"];
    }
    return _netImageArray;

}

//懒加载主页TableView
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        //_mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_mainTableView.bounces = NO;
        
        [self.view addSubview:_mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(53);
        }];
    
    }

    return _mainTableView;
}
//cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//返回行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}
//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 166;

}
//返回区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//返回区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (KscreenH - 64)*0.27;
}
//返回区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3.6;
}
//返回区头View，滚动视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    ZGScrollView *ZGNetScrollView = [[ZGScrollView alloc]initWithFrame:CGRectMake(0, 0, KscreenW, (KscreenH - 64)*0.27) withNetImages:self.netImageArray];
        /** 设置滚动延时*/
    ZGNetScrollView.autoScrollDelay = 3.0;
    
    /** 设置占位图*/
    //ZGNetScrollView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        
    /** 获取网络图片的index*/
    ZGNetScrollView.netDelegate = self;
    return ZGNetScrollView;
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
