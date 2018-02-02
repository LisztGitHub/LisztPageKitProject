//
//  LisztPageConstant.h
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/28.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#ifndef LisztPageConstant_h
#define LisztPageConstant_h
#import <objc/message.h>
#import <UIKit/UIKit.h>

#pragma mark - LisztSlideTitleView
/** 标题栏左右偏移量 */
typedef struct LisztSlideTitleViewEdgeInsets {
    CGFloat left, right;
} LisztSlideTitleViewEdgeInsets;

/** 左右间距设定 */
UIKIT_STATIC_INLINE LisztSlideTitleViewEdgeInsets LisztSlideTitleViewOffsetMake(CGFloat left, CGFloat right) {
    LisztSlideTitleViewEdgeInsets offset = {left, right};
    return offset;
}

/** 指示器风格 */
typedef NS_ENUM(NSUInteger,LisztSlideTitleIndicatorViewStyle) {
    /** 默认 */
    LisztSlideTitleIndicatorViewStyleDefault,
    /** 根据文本宽度 */
    LisztSlideTitleIndicatorViewStyleTextWidth,
    /** 根据屏幕宽度平均分(只有当内容小于宽度才有作用) */
    LisztSlideTitleIndicatorViewStyleWeights
};

/** 默认按钮间距 */
static CGFloat LisztPageKit_SlideTitle_Default_Spacing = 15;
/** 默认指示器宽度 */
static CGFloat LisztPageKit_SlideTitle_Default_IndicatorView_Width = 25;
/** 指示器默认高度 */
static CGFloat LisztPageKit_SlideTitle_Default_IndicatorView_height = 3;
/** 默认左右间隔 */
#define LisztPageKit_SlideTitle_Default_ContentInset LisztSlideTitleViewOffsetMake(15, 15)
/** 默认字体 */
#define LisztPageKit_SlideTitle_Default_Font [UIFont systemFontOfSize:15.f]
/** 默认字体title颜色 */
#define LisztPageKit_SlideTitle_Default_TitleColor [UIColor blackColor]
/** 默认选中时title颜色 */
#define LisztPageKit_SlideTitle_Default_SelectedTitleColor [UIColor redColor]
/** 默认通知圆点颜色 */
#define LisztPageKit_SlideTitle_Default_NoticeColor [UIColor redColor]


#pragma mark - 公共常量
#define LisztPageKitMsgSend(...) ((void (*)(void *, SEL, UIView *, NSInteger))objc_msgSend)(__VA_ARGS__)
#define LisztPageKitTarget(target) (__bridge void *)(target)

#endif /* LisztPageConstant_h */
