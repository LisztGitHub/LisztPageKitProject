//
//  LisztSlideTitleComponent.m
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/28.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztSlideTitleComponent.h"

@interface LisztSlideTitleComponent()
{
    /*父控件*/
    __weak UIScrollView *_scrollView;
}
@end

@implementation LisztSlideTitleComponent

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

- (void)prepare{}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    [self placeSubviews];
}

- (void)placeSubviews{}

#pragma mark - 设置回调对象和回调函数
- (void)setSlideTitleCommponentTarget:(id)target action:(SEL)action{
    self.slideTitleTarget = target;
    self.selectAction = action;
}

#pragma mark - 内部函数
- (void)executeDidSelectedCallbackIndex:(NSInteger)selectIndex{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.selectBlock){
            self.selectBlock(self, selectIndex);
        }
        if([self.slideTitleTarget respondsToSelector:self.selectAction]){
            LisztPageKitMsgSend(LisztPageKitTarget(self.slideTitleTarget), self.selectAction, self,selectIndex);
        }
    });
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView = scrollView];
    }
    return _scrollView;
}

@end

@implementation LisztSlideTitleComponent(LisztPageKit)
- (CGFloat)lisztPageKitGetTextWidthContent:(NSString *)content font:(UIFont *)font{
    NSDictionary *attrDic = @{NSFontAttributeName:font};
    CGRect strRect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];
    return strRect.size.width;
}
@end
