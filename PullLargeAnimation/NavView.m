//
//  NavView.m
//  PullLargeAnimation
//
//  Created by Yvan on 2016/10/11.
//  Copyright © 2016年 Yvan. All rights reserved.
//

#import "NavView.h"
#define kButtonHeight 44

@interface NavView ()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *rightBt;

@end

@implementation NavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];
    }
    return self;
}
- (void)loadContent {
    self.backgroundColor=[UIColor clearColor];
    [self loadHeadBackView];
    [self loadTitleLabel];
    [self loadButtons];
}
- (void)loadHeadBackView {
    self.headBackView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NavViewHeight)];
    self.headBackView.backgroundColor=[UIColor whiteColor];
    
    self.headBackView.alpha = 0;
    
    [self addSubview:self.headBackView];

}
- (void)loadTitleLabel {
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(44, 20, SCREENWIDTH -kButtonHeight -kButtonHeight, kButtonHeight)];
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.label];
}

- (void)loadButtons {
    self.leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBt.backgroundColor=[UIColor clearColor];
    self.leftBt.frame=CGRectMake(10, 30, 22, 22);
    [self.leftBt addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBt];
    
    self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBt.backgroundColor = [UIColor clearColor];
    self.rightBt.frame = CGRectMake(SCREENWIDTH-32, 30, 22, 22);
    [self.rightBt addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBt];
}
- (void)leftClick {
    
}
- (void)rightClick {
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}
- (void)setColor:(UIColor *)color {
    _color = color;
    self.label.textColor = color;
}
- (void)setLeftBtnImage:(NSString *)leftBtnImage {
    _leftBtnImage = leftBtnImage;
    self.leftBt.contentMode = UIViewContentModeScaleAspectFit;
    [self.leftBt setBackgroundImage:[UIImage imageNamed:leftBtnImage] forState:UIControlStateNormal];
}
- (void)setRightBtnImage:(NSString *)rightBtnImage {
    _rightBtnImage = rightBtnImage;
    self.rightBt.contentMode = UIViewContentModeScaleAspectFit;
    [self.rightBt setBackgroundImage:[UIImage imageNamed:rightBtnImage] forState:UIControlStateNormal];
}


@end
