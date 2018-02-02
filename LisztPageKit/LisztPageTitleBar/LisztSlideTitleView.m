//
//  LisztSlideTitleView.m
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/28.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztSlideTitleView.h"

@interface LisztSlideTitleView()<UIScrollViewDelegate>
{
    __weak UIView *_bottomLineView,*_indicatorView;
    /** 总宽度 */
    CGFloat _appendContentWidth;
    /** 记录左右 */
    NSInteger leftItemIndex,rightItemIndex;
    /** 存放按钮控件 */
    NSMutableArray *itemButtons;
    /** 是否第一次加载 */
    BOOL isFirstLoad;
    
}
@end

@implementation LisztSlideTitleView
#pragma mark - 构造方法
+ (instancetype)slideTitleViewFrame:(CGRect)frame pageTitleNames:(NSArray<NSString *> *)titleNames didSelectCompleted:(LisztSlideTitleComponentDidSelectedBlock)compleBlock{
    LisztSlideTitleView *stv = [[LisztSlideTitleView alloc] initWithFrame:frame];
    stv.selectBlock = compleBlock;
    stv.titleNames = titleNames;
    return stv;
}
+ (instancetype)slideTitleViewFrame:(CGRect)frame pageTitleNames:(NSArray<NSString *> *)titleNames didSelectTarget:(id)target didSelectedAction:(SEL)action{
    LisztSlideTitleView *stv = [[LisztSlideTitleView alloc] initWithFrame:frame];
    stv.slideTitleTarget = target;
    stv.selectAction = action;
    stv.titleNames = titleNames;
    return stv;
}

#pragma mark - 覆盖父类方法
/** 初始化 */
- (void)prepare{
    [super prepare];
    isFirstLoad = YES;
    self.scrollView.delegate = self;
}

- (void)placeSubviews{
    [super placeSubviews];
    
    CGRect bottomLineFrame = CGRectZero;
    bottomLineFrame.size = CGSizeMake(CGRectGetWidth(self.bounds), 0.6);
    bottomLineFrame.origin = CGPointMake(0, CGRectGetHeight(self.bounds) - 0.6);
    
    self.bottomLineView.frame = bottomLineFrame;
    
    if(self.selectedSlideTitleViewIndex){
        /** 触发回调 */
        [self executeDidSelectedCallbackIndex:self.selectedSlideTitleViewIndex];
    }
    
    if(!self.selectedSlideTitleViewIndex)self.selectedSlideTitleViewIndex = 0;
}

#pragma mark - action
/** 点击事件 */
- (void)buttonAction:(LisztSlideTitleButton *)sender{
    isFirstLoad = NO;
    
    /** 触发回调 */
    [self executeDidSelectedCallbackIndex:sender.tag];
    
    /** 滚动标题居中 */
    [self setSelectedButtonCenter:sender];
    
    /** 更新指示器 */
    [self updateIndicatorViewOffsetCurrentButton:sender];
    
    /** 更新选中按钮状态 */
    [self updateSeletedButton:sender];
}

/** 更新按钮选中状态 */
- (void)updateSeletedButton:(LisztSlideTitleButton *)sender{
    [itemButtons enumerateObjectsUsingBlock:^(LisztSlideTitleButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj.tag == sender.tag;
        UIColor *tempColor = self.normalTitleColor?self.normalTitleColor:LisztPageKit_SlideTitle_Default_TitleColor;
        UIColor *tempSeletedColor = self.selectedColor?self.selectedColor:LisztPageKit_SlideTitle_Default_SelectedTitleColor;
        if(obj.selected){
            obj.titleLabel.textColor = tempSeletedColor;
        }
        else{
            obj.titleLabel.textColor = tempColor;
        }
    }];
}

/** 滚动标题居中 */
- (void)setSelectedButtonCenter:(LisztSlideTitleButton *)sender {
    if(sender.tag>itemButtons.count)return;
    
    /** 计算偏移量 */
    CGFloat offsetX = sender.center.x - self.bounds.size.width * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    /** 获取最大滚动范围 */
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.frame.size.width;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    /** 滚动标题滚动条 */
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

/** 跟新指示器坐标 */
- (void)updateIndicatorViewOffsetCurrentButton:(LisztSlideTitleButton *)sender{
    if(sender.tag>itemButtons.count)return;
    
    __block CGFloat indicatorView_W = 0,indicatorView_H = LisztPageKit_SlideTitle_Default_IndicatorView_height,indicatorView_X = 0,indicatorView_Y = CGRectGetHeight(self.bounds) - indicatorView_H;
    
    if (self.appendContentWidth <= self.bounds.size.width) {
        /** 小于屏幕宽度则不可滚动 */
        [UIView animateWithDuration:isFirstLoad?0:0.2 animations:^{
            if (self.indicatorViewStyle == LisztSlideTitleIndicatorViewStyleDefault) {
                indicatorView_X = sender.center.x - LisztPageKit_SlideTitle_Default_IndicatorView_Width / 2;
                indicatorView_W = LisztPageKit_SlideTitle_Default_IndicatorView_Width;
            } else if (self.indicatorViewStyle == LisztSlideTitleIndicatorViewStyleTextWidth) {
                indicatorView_W = [self lisztPageKitGetTextWidthContent:sender.titleLabel.text font:sender.titleLabel.font];
                indicatorView_X = sender.center.x - indicatorView_W / 2;
            } else if(self.indicatorViewStyle == LisztSlideTitleIndicatorViewStyleWeights){
                indicatorView_W = CGRectGetWidth(sender.bounds);
                indicatorView_X = sender.frame.origin.x;
            }
            else{
                indicatorView_X = sender.center.x - LisztPageKit_SlideTitle_Default_IndicatorView_Width / 2;
                indicatorView_W = LisztPageKit_SlideTitle_Default_IndicatorView_Width;
            }
            self.indicatorView.frame = CGRectMake(indicatorView_X, indicatorView_Y, indicatorView_W, indicatorView_H);
        }];
    }
    else
    {
        if(_indicatorViewStyle == LisztSlideTitleIndicatorViewStyleWeights){
            NSLog(@"当前内容小于屏幕宽度,indicatorViewStyle会默认为:LisztSlideTitleIndicatorViewStyleDefault");
        }
        
        [UIView animateWithDuration:isFirstLoad?0:0.2 animations:^{
            if (self.indicatorViewStyle == LisztSlideTitleIndicatorViewStyleDefault) {
                indicatorView_X = sender.center.x - LisztPageKit_SlideTitle_Default_IndicatorView_Width / 2;
                indicatorView_W = LisztPageKit_SlideTitle_Default_IndicatorView_Width;
            } else if (self.indicatorViewStyle == LisztSlideTitleIndicatorViewStyleTextWidth) {
                indicatorView_X = sender.frame.origin.x;
                indicatorView_W = [self lisztPageKitGetTextWidthContent:sender.titleLabel.text font:sender.titleLabel.font];
            }
            else{
                indicatorView_X = sender.center.x - LisztPageKit_SlideTitle_Default_IndicatorView_Width / 2;
                indicatorView_W = LisztPageKit_SlideTitle_Default_IndicatorView_Width;
            }
            
            self.indicatorView.frame = CGRectMake(indicatorView_X, indicatorView_Y, indicatorView_W, indicatorView_H);
        }];
    }
}

#pragma mark - set
- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self updateSlideTitleAttributes];
}
- (void)setSpacingValue:(CGFloat)spacingValue{
    _spacingValue = spacingValue;
    [self updateSlideTitleAttributes];
}
- (void)setContentInset:(LisztSlideTitleViewEdgeInsets)contentInset{
    _contentInset = contentInset;
    [self updateSlideTitleAttributes];
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [self updateSlideTitleAttributes];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
    [self updateSlideTitleAttributes];
}
- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    if(_indicatorColor){
        self.indicatorView.backgroundColor = indicatorColor;
    }
}
- (void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    self.indicatorView.hidden = _showIndicator;
}
- (void)setIndicatorViewStyle:(LisztSlideTitleIndicatorViewStyle)indicatorViewStyle{
    _indicatorViewStyle = indicatorViewStyle;
    [self updateSlideTitleAttributes];
}
- (void)setSelectedSlideTitleViewIndex:(NSInteger)selectedSlideTitleViewIndex{
    _selectedSlideTitleViewIndex = selectedSlideTitleViewIndex;
    [self updateSlideTitleAttributes];
}
- (void)setSlideTitlebadges:(NSArray<NSNumber *> *)slideTitlebadges{
    _slideTitlebadges = slideTitlebadges;
    [itemButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_slideTitlebadges enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger i, BOOL * _Nonnull stop) {
            if(idx == [number integerValue]){
                [obj showBadge:YES];
            }
        }];
    }];
}
- (void)setHiddenSlideBadges:(NSArray<NSNumber *> *)hiddenSlideBadges{
    _hiddenSlideBadges = hiddenSlideBadges;
    [itemButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_hiddenSlideBadges enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger i, BOOL * _Nonnull stop) {
            if(idx == [number integerValue]){
                [obj showBadge:NO];
            }
        }];
    }];
}
- (void)setBadgeColor:(UIColor *)badgeColor{
    _badgeColor = badgeColor;
    [self updateSlideTitleAttributes];
}
- (void)setBottomLineViewColor:(UIColor *)bottomLineViewColor{
    _bottomLineViewColor = bottomLineViewColor;
    self.bottomLineView.backgroundColor = bottomLineViewColor;
}
- (void)setShowBottomLineView:(BOOL)showBottomLineView{
    _showBottomLineView = showBottomLineView;
    self.bottomLineView.hidden = !_showBottomLineView;
}

/** 设置标题 */
- (void)setTitleNames:(NSArray *)titleNames{
    
    /** 清空 */
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    itemButtons = [NSMutableArray array];
    
    __block CGFloat titleButton_X = LisztPageKit_SlideTitle_Default_ContentInset.left;
    [titleNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        /** 计算按钮宽度 */
        CGFloat width = [self lisztPageKitGetTextWidthContent:obj font:LisztPageKit_SlideTitle_Default_Font];
        
        /** 添加按钮 */
        CGRect titleFrame = CGRectMake(titleButton_X, 0, width, CGRectGetHeight(self.bounds));
        LisztSlideTitleButton *titleButton = [self createItemButtonFrame:titleFrame titleName:obj];
        titleButton.selected = self.selectedSlideTitleViewIndex == idx;
        titleButton.tag = idx;
        [titleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [itemButtons addObject:titleButton];
        [self.scrollView addSubview:titleButton];
        
        /** 得到按钮的X */
        titleButton_X = titleButton.frame.origin.x + CGRectGetWidth(titleButton.bounds) + LisztPageKit_SlideTitle_Default_Spacing;
        
        /** 给scrollView赋值contentSize */
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(titleButton.frame) + titleButton.frame.origin.x + LisztPageKit_SlideTitle_Default_ContentInset.right, CGRectGetHeight(self.scrollView.bounds));
        
        _appendContentWidth = self.scrollView.contentSize.width;
    }];
}

/** 更新标题栏属性 */
- (void)updateSlideTitleAttributes{
    __block CGFloat titleButton_X = self.contentInset.left?self.contentInset.left:LisztPageKit_SlideTitle_Default_ContentInset.left;
    
    CGFloat spacing = self.spacingValue?self.spacingValue:LisztPageKit_SlideTitle_Default_Spacing;
    [itemButtons enumerateObjectsUsingBlock:^(LisztSlideTitleButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIFont *tempFont = self.titleFont?self.titleFont:LisztPageKit_SlideTitle_Default_Font;
        UIColor *tempColor = self.normalTitleColor?self.normalTitleColor:LisztPageKit_SlideTitle_Default_TitleColor;
        UIColor *tempSeletedColor = self.selectedColor?self.selectedColor:LisztPageKit_SlideTitle_Default_SelectedTitleColor;
        UIColor *tempNoticeColor = self.badgeColor?self.badgeColor:LisztPageKit_SlideTitle_Default_NoticeColor;
        
        CGFloat rigthSpace = self.contentInset.right?self.contentInset.right:LisztPageKit_SlideTitle_Default_ContentInset.right;
        CGFloat width = [self lisztPageKitGetTextWidthContent:obj.titleLabel.text font:tempFont];
        
        CGRect titleFrame = CGRectMake(titleButton_X, 0, width, CGRectGetHeight(self.bounds));
        obj.frame = titleFrame;
        obj.selected = idx == self.selectedSlideTitleViewIndex;
        obj.titleLabel.font = tempFont;
        obj.badgeColor = tempNoticeColor;
        
        [obj setTitleColor:tempSeletedColor forState:UIControlStateSelected];
        [obj setTitleColor:tempColor forState:UIControlStateNormal];
        /** 得到按钮的X */
        titleButton_X = obj.frame.origin.x + CGRectGetWidth(obj.bounds) + spacing;
        /** 给scrollView赋值contentSize */
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(obj.frame) + obj.frame.origin.x + rigthSpace, CGRectGetHeight(self.scrollView.bounds));
        
        /** 得到总宽度 */
        _appendContentWidth = self.scrollView.contentSize.width;
    }];
    
    /** 如果内容宽度小于本控件宽度就重新架构按钮 */
    if(self.appendContentWidth<=self.frame.size.width){
        [itemButtons enumerateObjectsUsingBlock:^(LisztSlideTitleButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat width = self.frame.size.width / itemButtons.count;
            CGRect titleFrame = CGRectMake(idx * width, 0, width, CGRectGetHeight(self.bounds));
            obj.frame = titleFrame;
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        }];
    }
    
    /** 判断是否满足移动条件 */
    if(_selectedSlideTitleViewIndex<itemButtons.count){
        [self setSelectedButtonCenter:itemButtons[_selectedSlideTitleViewIndex]];
        [self updateIndicatorViewOffsetCurrentButton:itemButtons[_selectedSlideTitleViewIndex]];
    }
}

/** 移动 */
- (void)changeIndicatorScrollView:(UIScrollView *)scrollView targetIndex:(NSInteger)targetIndex {
    CGRect indicatorFrame = self.indicatorView.frame;
    indicatorFrame.origin = CGPointMake(scrollView.contentOffset.x, indicatorFrame.origin.y);
    self.indicatorView.frame = indicatorFrame;
}

/** 创建标题按钮 */
- (LisztSlideTitleButton *)createItemButtonFrame:(CGRect)frame titleName:(NSString *)title{
    LisztSlideTitleButton *tempButton = [LisztSlideTitleButton buttonWithType:UIButtonTypeCustom];
    [tempButton setTitle:title forState:UIControlStateNormal];
    [tempButton setTitleColor:LisztPageKit_SlideTitle_Default_TitleColor forState:UIControlStateNormal];
    [tempButton setTitleColor:LisztPageKit_SlideTitle_Default_SelectedTitleColor forState:UIControlStateSelected];
    tempButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    tempButton.frame = frame;
    return tempButton;
}

#pragma mark - 懒加载子控件
- (UIView *)bottomLineView{
    if(!_bottomLineView){
        UIView *bottomLineView = [UIView new];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomLineView = bottomLineView];
    }
    return _bottomLineView;
}
- (UIView *)indicatorView{
    if(!_indicatorView){
        UIView *indicatorView = [UIView new];
        indicatorView.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:_indicatorView = indicatorView];
    }
    return _indicatorView;
}
- (CGFloat)appendContentWidth{
    return _appendContentWidth;
}
@end
