//
//  Header.h
//  ManyCars
//
//  Created by tom on 2017/8/17.
//  Copyright © 2017年 hao. All rights reserved.
//

#ifndef Header_h
#define Header_h

//定义屏幕宽高
#define KscreenW [UIScreen mainScreen].bounds.size.width
#define KscreenH [UIScreen mainScreen].bounds.size.height

//定义16进制转RGB颜色
#define UIColorFromRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//view尺寸相关类别
#import "UIView+Extension.h"
//naV左右button类别
#import "UIBarButtonItem+NavBarButton.h"
//定义button
#import "CustomNavBarButton.h"
#import "Masonry.h"
//nslog输出宏
#ifdef DEBUG
#define HZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define HZLog(...)
#endif

#endif /* Header_h */
