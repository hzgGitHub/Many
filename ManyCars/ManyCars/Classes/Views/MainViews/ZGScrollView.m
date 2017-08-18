//
//  ZGScrollView.m
//  ZGScrollView
//
//  Created by Mac on 16/3/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZGScrollView.h"

//导入要使用的YY第三方头文件
#import "UIImageView+WebCache.h"


#define kPageSize 16
//获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
//pageControl颜色
#define kPageColor RGB(255, 100, 222)
//ImageView 数量3个
#define kImageViewCount 3

//滚动宽度
#define kScrollWidth self.frame.size.width
// 滚动高度
#define kScrollHeight self.frame.size.height

@interface ZGScrollView ()<UIScrollViewDelegate>
//存放照片数组
@property (nonatomic,strong)NSArray *imageArray;

@end

@implementation ZGScrollView
{
    //Scrollview上三张图片
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak  UIScrollView *_scrollView;
    
    __weak  UIPageControl *_pageControl;
    
    NSTimer *_timer;
    
    // 当前显示的是第几个
    NSInteger _currentIndex;
    
    // 图片个数
    NSInteger _maxImageCount;
    
    //是否是网络图片
    BOOL _isNetworkImage;
}

#pragma mark--本地图片，下面的ScrollView
- (instancetype)initWithFrame:(CGRect)frame withLocalImages:(NSArray *)imageArray {
    if (imageArray.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _isNetworkImage = NO;
        //创建滚动视图
        [self createScrollView];
        //加入本地image
        [self setImageArray:imageArray];
        //设置数量
        [self setMaxImageCount:_imageArray.count];
    }
    
    return self;
    
}
#pragma mark--网络图片，上面的ScrollView
- (instancetype)initWithFrame:(CGRect)frame withNetImages:(NSArray *)imageArray{
    if (imageArray.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _isNetworkImage = YES;
        //创建滚动视图
        [self createScrollView];
        //加入本地image
        [self setImageArray:imageArray];
        //设置数量
        [self setMaxImageCount:_imageArray.count];
    }
    
    return self;
    
}

#pragma mark--创建滚动视图
- (void)createScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    
    //配置ScrollView，只创建三个ImageView，复用
    scrollView.contentSize = CGSizeMake(kScrollWidth * kImageViewCount, 0);
    //设置滚动延时
    _autoScrollDelay = 0;
    //开始显示的是第一个   前一个是最后一个   后一个是第二张
    _currentIndex = 0;
    
    _scrollView = scrollView;
    
}
#pragma mark--创建图片数组
- (void)setImageArray:(NSArray *)imageArray{
    if (_isNetworkImage) {
        _imageArray = [imageArray copy];
    }else{
        NSMutableArray *localImageArray = [NSMutableArray arrayWithCapacity:imageArray.count];
        for (NSString *imageName in imageArray) {
            [localImageArray addObject:[UIImage imageNamed:imageName]];
            
        }
        _imageArray = [localImageArray copy];
        
    }
}

#pragma mark--设置图片数量
- (void)setMaxImageCount:(NSInteger)maxImageCount{
    _maxImageCount = maxImageCount;
    
    //复用imageView初始化创建
    [self initImageView];
    //创建pageControl
    [self createPageControl];
    //设置定时器
    [self setTimer];
    //初始化图片位置
    [self changeImageLeft:_maxImageCount-1 center:0 right:1];
    
}
#pragma mark--复用imageView初始化创建
- (void)initImageView{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScrollWidth, kScrollHeight)];
    UIImageView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScrollWidth, 0,kScrollWidth, kScrollHeight)];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScrollWidth * 2, 0,kScrollWidth, kScrollHeight)];
    //中间图片的交互打开
    centerImageView.userInteractionEnabled = YES;
    //添加手势
    [centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:leftImageView];
    [_scrollView addSubview:centerImageView];
    [_scrollView addSubview:rightImageView];
    
    _leftImageView = leftImageView;
    _centerImageView = centerImageView;
    _rightImageView = rightImageView;
    
    
}
#pragma mark--imageView上点击事件
- (void)imageViewDidTap
{
    [self.netDelegate didSelectedNetImageAtIndex:_currentIndex];
    [self.localDelegate didSelectedLocalImageAtIndex:_currentIndex];
}
#pragma mark--创建pageControl
- (void)createPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScrollHeight-kPageSize, kScrollWidth, 8)];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = kPageColor;
    pageControl.numberOfPages = _maxImageCount;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    _pageControl = pageControl;
    
}
#pragma mark--设置定时器
- (void)setTimer{
    
    _timer = [NSTimer timerWithTimeInterval:_autoScrollDelay target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
#pragma mark--定时器方法
- (void)scroll{//x轴每次加一个宽度，y轴不变
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x +kScrollWidth, 0) animated:YES];
}

#pragma mark--初始化图片位置
- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex{
    if (_isNetworkImage) {//网络
        dispatch_async(dispatch_get_main_queue(), ^{//直接放到主线程
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[LeftIndex]] placeholderImage:_placeholderImage];
            [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[centerIndex]] placeholderImage:_placeholderImage];
            [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[rightIndex]] placeholderImage:_placeholderImage];
            
        });

    }else{//本地
        _leftImageView.image = _imageArray[LeftIndex];
        _centerImageView.image = _imageArray[centerIndex];
        _rightImageView.image = _imageArray[rightIndex];
        
    }
    [_scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
    
}
#pragma mark - 滚动代理,结束拖动重新启用定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setTimer];
}
#pragma mark--开始被拖动则移除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
#pragma mark--移除定时器
- (void)removeTimer
{
    if (nil == _timer) return;
    [_timer invalidate];
    _timer = nil;
}
#pragma mark--开始滚动，判断位置，然后替换复用的三张图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //开始滚动，判断位置，然后替换复用的三张图
    [self changeImageWithOffset:scrollView.contentOffset.x];
}
#pragma mark--判断位置，然后替换复用的三张图
- (void)changeImageWithOffset:(CGFloat)offsetX{
    
    if (offsetX >=kScrollWidth * 2) {
        _currentIndex++;
        if (_currentIndex == _maxImageCount - 1) {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _maxImageCount){
            
            _currentIndex = 0;
            [self changeImageLeft:_maxImageCount - 1 center:0 right:1];
            
        }else{
            
            [self changeImageLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
            
        }
        _pageControl.currentPage = _currentIndex;
    }
    
    if (offsetX <= 0)
    {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_maxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _maxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        _pageControl.currentPage = _currentIndex;
    }
    
    
}
#pragma mark - set方法，设置间隔时间
- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay
{
    _autoScrollDelay = AutoScrollDelay;
    
    [self removeTimer];
    [self setTimer];
}
#pragma mark--处理定时器
-(void)dealloc
{
    [self removeTimer];
}



@end
