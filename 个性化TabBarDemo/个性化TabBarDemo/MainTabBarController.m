//
//  MainTabBarController.m
//  个性化TabBarDemo
//
//  Created by admin on 17/1/9.
//  Copyright © 2017年 Corki. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //问题 tabBar属性只读无法修改

    //@property(nonatomic,readonly) UITabBar *tabBar NS_AVAILABLE_IOS(3_0); //
    
    MainTabBar *tabBar = [[MainTabBar alloc]init];
    //利用KVC修改

    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    [self setupChildVcs];
    
}

- (void)setupChildVcs {
    
    
    //设置子控制器
    NSArray *tabBarItemImages = @[@"project", @"task", @"tweet", @"me"];
    NSArray *tabBarItemTitles = @[@"项目", @"任务", @"冒泡", @"我"];
    
    for (NSInteger i = 0; i < 4; i ++ ) {
        
        NSString *image = [tabBarItemImages objectAtIndex:i];
        NSString *title = [tabBarItemTitles objectAtIndex:i];
        NSString *selectedImage = [NSString stringWithFormat:@"%@_selected",image];
        NSString *normalImage = [NSString stringWithFormat:@"%@_normal",image];
        
        UIViewController *vc = [[UIViewController alloc]init];
        vc.tabBarItem.image = [UIImage imageNamed:normalImage];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
        vc.tabBarItem.title = title;

        [self addChildViewController:vc];
    }
    
    //以上是基本设置
    //关于 个性化的TabBar 首先需要了解UITabBar 的视图层次
    //子视图   UITabBarBackgroundView(背景)  UITabBarButton (按钮)  UIImageView (分割线)
    //所以我们这里 找到UITabBarButton  在子类进行 个性化 (什么样的都可以)
}

@end
