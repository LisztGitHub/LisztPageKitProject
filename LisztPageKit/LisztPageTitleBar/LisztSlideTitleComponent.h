//
//  LisztSlideTitleComponent.h
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/28.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LisztPageConstant.h"

@class LisztSlideTitleComponent;

/** 选择完成后回调 */
typedef void(^LisztSlideTitleComponentDidSelectedBlock)(LisztSlideTitleComponent *slideTitleView, NSInteger selectIndex);

@interface LisztSlideTitleComponent : UIView

#pragma mark - 回调
/** 选择完成 */
@property (nonatomic, copy) LisztSlideTitleComponentDidSelectedBlock selectBlock;
/** 设置回调对象和放 */
- (void)setSlideTitleCommponentTarget:(id)target action:(SEL)action;
/** 回调对象 */
@property (nonatomic, weak) id slideTitleTarget;
/** 回调方法 */
@property (nonatomic, assign) SEL selectAction;
/** 触发回调 (子类调用) */
- (void)executeDidSelectedCallbackIndex:(NSInteger)selectIndex;

#pragma mark - 子类访问
/** 父控件 */
@property (nonatomic, readonly, weak) UIScrollView *scrollView;

#pragma mark - 子类实现
/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 摆放控件 */
- (void)placeSubviews NS_REQUIRES_SUPER;
@end

@interface LisztSlideTitleComponent(LisztPageKit)
/** 得到文本宽度 */
- (CGFloat)lisztPageKitGetTextWidthContent:(NSString *)content font:(UIFont *)font;
@end
