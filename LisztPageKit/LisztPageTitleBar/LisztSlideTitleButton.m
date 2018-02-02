//
//  LisztSlideTitleButton.m
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/29.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztSlideTitleButton.h"

@interface LisztSlideTitleButton()
{
    __weak UIView *_badgeView;
    BOOL _showBadge;
}
@end

@implementation LisztSlideTitleButton

- (void)showBadge:(BOOL)show{
    _showBadge = show;
    self.badgeView.hidden = !_showBadge;
}

- (void)setBadgeColor:(UIColor *)badgeColor{
    _badgeColor = badgeColor;
    self.badgeView.backgroundColor = _badgeColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIColor *tempBadgeColor = self.badgeColor?self.badgeColor:[UIColor redColor];
    self.badgeView.backgroundColor = tempBadgeColor;
    
    CGRect badgeFrame = CGRectZero;
    badgeFrame.size = CGSizeMake(8, 8);
    
    badgeFrame.origin = CGPointMake((self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x) - badgeFrame.size.height / 2, self.titleLabel.frame.origin.y - badgeFrame.size.height / 2);
    self.badgeView.frame = badgeFrame;
}

#pragma mark - 懒加载子控件
- (UIView *)badgeView{
    if(!_badgeView){
        UIView *badgeView = [UIView new];
        badgeView.layer.cornerRadius = 4;
        badgeView.hidden = YES;
        badgeView.clipsToBounds = YES;
        [self addSubview:_badgeView = badgeView];
    }
    return _badgeView;
}

@end
