//
//  LisztTitleViewViewController.m
//  LisztPageKitProject
//
//  Created by LisztCoder on 2018/1/29.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztTitleViewViewController.h"
#import "LisztPageKit.h"

@interface LisztTitleViewViewController ()
@property (nonatomic, strong) LisztSlideTitleView *stvOne;
@property (nonatomic, strong) LisztSlideTitleView *stvTwo;
@end

@implementation LisztTitleViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.stvOne];
    [self.view addSubview:self.stvTwo];
}

/** 更改默认颜色 */
- (IBAction)changeTitleNormalColor:(id)sender {
    UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.f green:arc4random_uniform(255) / 255.f blue:arc4random_uniform(255) / 255.f alpha:1];
    self.stvOne.normalTitleColor = randColor;
    self.stvTwo.normalTitleColor = randColor;
}
/** 更改选中颜色 */
- (IBAction)changeSeletedColor:(id)sender {
    UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.f green:arc4random_uniform(255) / 255.f blue:arc4random_uniform(255) / 255.f alpha:1];
    self.stvOne.selectedColor = randColor;
    self.stvTwo.selectedColor = randColor;
}
/** 更改指示器颜色 */
- (IBAction)changeIndicatorViewColor:(id)sender {
    UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.f green:arc4random_uniform(255) / 255.f blue:arc4random_uniform(255) / 255.f alpha:1];
    self.stvOne.indicatorColor = randColor;
    self.stvTwo.indicatorColor = randColor;
}
/** 切换效果 */
- (IBAction)changeStyle:(UISegmentedControl *)sender {
    self.stvOne.indicatorViewStyle = sender.selectedSegmentIndex;
    self.stvTwo.indicatorViewStyle = sender.selectedSegmentIndex;
}
/** 是否显示指示器 */
- (IBAction)changeIndicatorState:(UISwitch *)sender {
    self.stvOne.showIndicator = !sender.isOn;
    self.stvTwo.showIndicator = !sender.isOn;
}
/** 更改字体 */
- (IBAction)changeFont:(UISlider *)sender {
    self.stvOne.titleFont = [UIFont systemFontOfSize:sender.value];
    self.stvTwo.titleFont = [UIFont systemFontOfSize:sender.value];
}
/** 默认选中下标 */
- (IBAction)changeSeletedIndex:(UIStepper *)sender {
    self.stvOne.selectedSlideTitleViewIndex = sender.value;
    self.stvTwo.selectedSlideTitleViewIndex = sender.value;
}
/** 设置列间距 */
- (IBAction)changeSectionSpace:(UISlider *)sender {
    self.stvOne.spacingValue = sender.value;
    self.stvTwo.spacingValue = sender.value;
}
/** 设置两边间距 */
- (IBAction)leftRightSpace:(UISlider *)sender {
    self.stvOne.contentInset = LisztSlideTitleViewOffsetMake(sender.value, sender.value);
    self.stvTwo.contentInset = LisztSlideTitleViewOffsetMake(sender.value, sender.value);
}
/** 更改通知圆点 */
- (IBAction)changeShowNotice:(UISwitch *)sender {
    if(sender.isOn){
        self.stvOne.slideTitlebadges = @[@(1),@(5),@(8)];
    }
    else{
        self.stvOne.hiddenSlideBadges = @[@(1),@(5),@(8)];
    }
}
/** 更改线条颜色 */
- (IBAction)lineColor:(UIButton *)sender {
    UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.f green:arc4random_uniform(255) / 255.f blue:arc4random_uniform(255) / 255.f alpha:1];
    self.stvOne.bottomLineViewColor = randColor;
}
/** 是否显示底部线条 */
- (IBAction)showBottomLine:(UISwitch *)sender {
    self.stvOne.showBottomLineView = sender.on;
}
/** 通知颜色 */
- (IBAction)noticeColor:(id)sender {
    UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.f green:arc4random_uniform(255) / 255.f blue:arc4random_uniform(255) / 255.f alpha:1];
    self.stvOne.badgeColor = randColor;
}

#pragma mark - 懒加载
- (LisztSlideTitleView *)stvOne{
    if(!_stvOne){
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 13; i ++){
            [tempArray addObject:[NSString stringWithFormat:@"Tab %li",i]];
        }
        _stvOne = [LisztSlideTitleView slideTitleViewFrame:CGRectMake(0, 450, CGRectGetWidth(self.view.bounds), 44) pageTitleNames:tempArray didSelectCompleted:^(LisztSlideTitleComponent *slideTitleView, NSInteger selectIndex) {
            NSLog(@"\n\nBlock回调--------------slideTitleView:%@,selectIndex:%li",slideTitleView,selectIndex);
        }];
        _stvOne.slideTitlebadges = @[@(1),@(5),@(8)];
    }
    return _stvOne;
}

- (LisztSlideTitleView *)stvTwo{
    if(!_stvTwo){
        _stvTwo = [LisztSlideTitleView slideTitleViewFrame:CGRectMake(0, 500, CGRectGetWidth(self.view.bounds), 44) pageTitleNames:@[@"One",@"Two",@"Three"] didSelectTarget:self didSelectedAction:@selector(slideTitleView:selectIndex:)];
        _stvTwo.slideTitlebadges = @[@(0),@(2)];
        _stvTwo.badgeColor = [UIColor orangeColor];
    }
    return _stvTwo;
}

/** SEL写法 */
- (void)slideTitleView:(LisztSlideTitleView *)slideTitleView selectIndex:(NSInteger)selectIndex{
    NSLog(@"\n\nSEL回调--------------slideTitleView:%@,selectIndex:%li",slideTitleView,selectIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
