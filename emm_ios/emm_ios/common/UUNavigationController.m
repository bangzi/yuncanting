//
//  UUNavigationController.m
//  emm_ios
//
//  Created by maqj on 4/22/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUNavigationController.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

@protocol InteractiveTransitionDelegate <NSObject>
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)ges;
@end

@interface NSObject (_UINavigationInteractiveTransition)

- (void)setDelegate:(id<InteractiveTransitionDelegate>)delegate;
- (id<InteractiveTransitionDelegate>)delegate;
- (void)myHandleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)ges;
@end

static char * const delegateChar;

@implementation NSObject (_UINavigationInteractiveTransition)
- (void)myHandleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)ges{
    
    [self myHandleNavigationTransition:ges];
    
    id<InteractiveTransitionDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(handleNavigationTransition:)]) {
        [delegate handleNavigationTransition:ges];
    }
}

- (void)setDelegate:(id<InteractiveTransitionDelegate>)delegate{
    objc_setAssociatedObject(self, &delegateChar, delegate, OBJC_ASSOCIATION_RETAIN);
}

- (id<InteractiveTransitionDelegate>)delegate{
    return objc_getAssociatedObject(self, &delegateChar);
}

@end

@interface UUNavigationController ()<UINavigationControllerDelegate, InteractiveTransitionDelegate>

@end

@implementation UUNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    UIGestureRecognizer *res = self.interactivePopGestureRecognizer;
    
    id target = res.delegate;
    [target setDelegate:self];
    [self swizzing:[target class]];
}

//- (RDVTabBarController*)uuTabBarController{
//    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    return [vc rdv_tabBarController];
//}

- (void)swizzing:(Class)class{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        NSError *error = nil;
        [class jr_swizzleMethod:@selector(handleNavigationTransition:) withMethod:@selector(myHandleNavigationTransition:) error:&error];
        if (error) {
            NSLog(@"%s, %@", __FUNCTION__, error);
        }
    });
}

- (UIViewController*)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    UIViewController *test = [vc rdv_tabBarController];
    
    [self hidden:[self isHiddenTabBar] tabBar:[self uuTabBarController].tabBar];
    return vc;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController: viewController animated:animated];
    
    if ([self uuTabBarController]) {
        [self hidden:[self isHiddenTabBar] tabBar:[self uuTabBarController].tabBar];
    }
}

- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)ges{
    //NSLog(@"%s", __FUNCTION__);
    static CGPoint startPoint;
    static CGRect startRect;
    
    CGPoint curPoint = [ges locationInView:self.view];
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            startPoint = curPoint;
            startRect = [self uuTabBarController].tabBar.frame;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            CGRect frame = startRect;
            frame.origin.y -= (curPoint.x - startPoint.x) * (startRect.size.height/startRect.size.width)-startRect.size.height;
            
            [self uuTabBarController].tabBar.frame = frame;
            break;
        }
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:{
            
            if (curPoint.x > self.view.bounds.size.width/2) {
                [self hidden:NO|[self isHiddenTabBar] tabBar:[self uuTabBarController].tabBar];
            }else{
                [self hidden:YES|[self isHiddenTabBar] tabBar:[self uuTabBarController].tabBar];
            }
            break;
        }
        default:
            break;
    }
    
}

- (void)hidden:(BOOL)is tabBar:(UIView*)view{
    CGRect frame = view.frame;
    CGRect viewSize = self.view.bounds;
    frame.origin.y = is?(viewSize.size.height):(viewSize.size.height-frame.size.height);
    
    CGFloat duration = is?0.215:0.28;
    
    if (!is) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = frame;
        } completion:nil];
    }else{
        [UIView animateWithDuration:duration delay:-5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = frame;
        } completion:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [self uuTabBarController].tabBar.hidden = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self hidden:[self isHiddenTabBar] tabBar:[self uuTabBarController].tabBar];
}

- (BOOL)isHiddenTabBar{
    NSArray *viewControllers = self.viewControllers;
    //    NSInteger idx = [self uuTabBarController].selectedIndex;
    BOOL hidden = NO;
    
    for(int i = (int)(viewControllers.count-1); i > -1; i--){
        UIViewController *vc = viewControllers[i];
        hidden |= vc.hidesBottomBarWhenPushed;
    }
    return hidden;
}

@end
