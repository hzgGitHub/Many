//
//  HZTabBarViewController.m
//  ManyCars
//
//  Created by tom on 2017/8/17.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "HZTabBarViewController.h"
#import "MainViewController.h"
#import "NetSitesViewController.h"
#import "MineViewController.h"
#import "HZNavViewController.h"
#import "Header.h"
@interface HZTabBarViewController ()

@end

@implementation HZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setBarTintColor:UIColorFromRGBHex(0xFFFFFF)];
    [self setUp];
    
    
}
//创建tabBar及上面controller
- (void)setUp {
    MainViewController *mainVC = [[MainViewController alloc]init];
    NetSitesViewController *sitesVC = [[NetSitesViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    

    [self addChildVC:mainVC normalImage:@"shouye" title:@"首页" tintColor:UIColorFromRGBHex(0x3C3D40) navbgColor:UIColorFromRGBHex(0xFFFFFF)];
    [self addChildVC:sitesVC normalImage:@"网点地图" title:@"网点" tintColor:UIColorFromRGBHex(0x717171) navbgColor:UIColorFromRGBHex(0xFFFFFF)];
    [self addChildVC:mineVC normalImage:@"geren" title:@"我的" tintColor:UIColorFromRGBHex(0x717171) navbgColor:UIColorFromRGBHex(0xFFFFFF)];

}
//封装tabbarItem添加
- (void)addChildVC:(UIViewController *)childVC
       normalImage:(NSString *)imageName
             title:(NSString *)title
         tintColor:(UIColor *)tintColor
        navbgColor:(UIColor *)bgColor {
    //配置Tabbar
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.title = title;
    [self.tabBar setTintColor:tintColor];
    
    HZNavViewController *nav = [[HZNavViewController alloc]initWithRootViewController:childVC];
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    [nav.navigationBar setBarTintColor:bgColor];//注意设置barTintcolor才是导航栏颜色
    
    [self addChildViewController:nav];
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
