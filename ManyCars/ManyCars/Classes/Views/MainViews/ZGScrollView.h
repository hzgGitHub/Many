//
//  ZGScrollView.h
//  ZGScrollView
//
//  Created by Mac on 16/3/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

// 遵循该代理就可以监控到网络滚动视图的index

@protocol ZGScrollViewNetDelegate <NSObject>

@optional

//点中网络滚动视图后出发
- (void)didSelectedNetImageAtIndex:(NSInteger)index;

@end

// 遵循该代理就可以监控到本地滚动视图的index

@protocol ZGScrollViewLocalDelegate <NSObject>

@optional

//点中网络滚动视图后出发
- (void)didSelectedLocalImageAtIndex:(NSInteger)index;

@end

@interface ZGScrollView : UIView

//以下添加两个代理属性

@property (nonatomic,assign)id<ZGScrollViewNetDelegate> netDelegate;

@property (nonatomic,assign)id<ZGScrollViewLocalDelegate>localDelegate;

//图片加载占位图
@property (nonatomic,strong)UIImage *placeholderImage;

//滚动延时
@property (nonatomic,assign)NSTimeInterval autoScrollDelay;

//本地图片加载初始化
- (instancetype)initWithFrame:(CGRect)frame withLocalImages:(NSArray *)imageArray;

//网络图片加载初始化
- (instancetype)initWithFrame:(CGRect)frame withNetImages:(NSArray *)imageArray;

@end
