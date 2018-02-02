//
//  LisztSlideTitleButton.h
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/29.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LisztSlideTitleButton : UIButton
/** 通知View */
@property (nonatomic, readonly, weak) UIView *badgeView;

/** 设置badge颜色 */
@property (nonatomic, strong) UIColor *badgeColor;

/** 显示消息 */
- (void)showBadge:(BOOL)show;
@end
