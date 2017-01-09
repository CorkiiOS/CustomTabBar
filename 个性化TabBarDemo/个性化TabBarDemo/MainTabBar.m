//
//  MainTabBar.m
//  个性化TabBarDemo
//
//  Created by admin on 17/1/9.
//  Copyright © 2017年 Corki. All rights reserved.
//

#import "MainTabBar.h"
#import <objc/runtime.h>
#import "ViewController.h"
#import "UIView+BGFrame.h"
@interface MainTabBar()

@property (nonatomic, strong) UIButton *button;

@end

@implementation MainTabBar

- (void)layoutSubviews {
    //重写layoutSubviews 首先调用父类layoutSubviews
    
    //父类布局完成之后,进行微调就可以了
    [super layoutSubviews];
    
    //1.找到UITabBarButton
    CGFloat width = self.frame.size.width/5;
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        
        //2.判断UITabBarButton类 ->问题:直接手打找不到这个类
        
        Class barClass = objc_getClass("UITabBarButton");
        
        if ([view isKindOfClass:barClass]) {
            
            NSLog(@"%@",view);
            //输出结果
            //<UITabBarButton: 0x7fc1dacc4720; frame = (2 1; 100 48); opaque = NO; layer = <CALayer: 0x7fc1dacc71d0>>
            //进行微调, 把中间位置空余出来 放置我们自定义的按钮
            
            if (index<2) {
                
                view.left = width*index;
 
            }else{
                
                view.left = width*(index+1);

            }
            view.width = width;
            index++;
            
        }
        
        
    }
    
    [self addSubview:self.button];
}

- (UIButton *)button {
    
    if (_button == nil) {
        
        CGFloat width = self.frame.size.width/5;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.left = width*2;
        _button.width = width;
        _button.top = 0;
        _button.height = self.height;
        _button.backgroundColor = [UIColor cyanColor];
        [_button setImage:[UIImage imageNamed:@"toolbar_live"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)action {
    
    NSLog(@"个性化 按钮点击了");
    //至于点击按钮 进入什么界面 .. 进入的方式都是我们自己定了
    ViewController *vc =  [[ViewController alloc]init];
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}
@end
