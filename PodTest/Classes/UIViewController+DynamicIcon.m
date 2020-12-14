//
//  UIViewController+DynamicIcon.m
//  VIPStudent
//
//  Created by 姜鹏 on 2020/4/13.
//  Copyright © 2020 VIPractice. All rights reserved.
//

#import "UIViewController+DynamicIcon.h"

@implementation UIViewController (DynamicIcon)

/// test
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(jp_presentViewController:animated:completion:));
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

- (void)jp_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (
            (alertController.preferredStyle == UIAlertControllerStyleAlert && alertController.title == nil && alertController.message == nil) ||
            (alertController.preferredStyle == UIAlertControllerStyleActionSheet && alertController.actions.count == 0)
            ) { // alert & action sheet
            return;
        }
    }
    [self jp_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
