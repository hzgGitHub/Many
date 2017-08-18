//
//  UIBarButtonItem+NavBarButton.h
//  ManyCars
//
//  Created by tom on 2017/8/18.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIBarButtonItem (NavBarButton)

//
+ (UIBarButtonItem *)leftItemWithImageName:(NSString *)imageName
                                 withTitle:(NSString *)title
                                    target:(id)target
                                    action:(SEL)action;
//

@end
