//
//  LisztSlideTitleView.h
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/28.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztSlideTitleComponent.h"
#import "LisztSlideTitleButton.h"

@interface LisztSlideTitleView : LisztSlideTitleComponent

/** 创建slideTitleView Block回调*/
+ (instancetype)slideTitleViewFrame:(CGRect)frame pageTitleNames:(NSArray <NSString *>*)titleNames didSelectCompleted:(LisztSlideTitleComponentDidSelectedBlock)compleBlock;
/** 创建slideTitleView 方法回调 */
+ (instancetype)slideTitleViewFrame:(CGRect)frame pageTitleNames:(NSArray<NSString *> *)titleNames didSelectTarget:(id)target didSelectedAction:(SEL)action;

#pragma mark - readonly
/** 指示器 */
@property (nonatomic, readonly, weak) UIView *indicatorView;
/** 线条属性 */
@property (nonatomic, readonly, weak) UIView *bottomLineView;
/** 追加内容宽度 */
@property (nonatomic, readonly, assign) CGFloat appendContentWidth;

#pragma mark - readonly 或者 readwrite
/** 设置标题左右偏移量(整体左右) 注意:此属性只有在内容大于屏幕的时候生效 */
@property (nonatomic, assign) LisztSlideTitleViewEdgeInsets contentInset;
/** 中间间距(默认15) 注意:此属性只有在内容大于屏幕的时候生效 */
@property (nonatomic, assign) CGFloat spacingValue;
/** 默认下标(默认0) */
@property (nonatomic, assign) NSInteger selectedSlideTitleViewIndex;
/** 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 指示器颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 指示器风格 */
@property (nonatomic, assign) LisztSlideTitleIndicatorViewStyle indicatorViewStyle;
/** 是否显示指示器(默认YES) */
@property (nonatomic, assign) BOOL showIndicator;
/** 返回需要显示通知的下标 */
@property (nonatomic, strong) NSArray <NSNumber *>* slideTitlebadges;
/** 需要隐藏的通知下标 */
@property (nonatomic, strong) NSArray <NSNumber *>* hiddenSlideBadges;
/** badge的颜色 */
@property (nonatomic, strong) UIColor *badgeColor;
/** 底部线条颜色 */
@property (nonatomic, strong) UIColor *bottomLineViewColor;
/** 是否显示底部线条 (默认YES)*/
@property (nonatomic, assign) BOOL showBottomLineView;
@end
