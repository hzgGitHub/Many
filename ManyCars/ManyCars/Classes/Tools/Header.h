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

#endif /* Header_h */
