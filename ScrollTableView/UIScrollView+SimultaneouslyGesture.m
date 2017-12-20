//
//  UIScrollView+SimultaneouslyGesture.h
//  liangchao
//
//  Created by liangchao on 15/9/4.
//  Copyright © 2017年 liangchao. All rights reserved.
//

#import "UIScrollView+SimultaneouslyGesture.h"
#import <objc/objc-runtime.h>

@interface UIScrollView (HangUp)
@property (nonatomic,assign) BOOL fixedOnTop;
@end
@implementation UIScrollView(HangUp)

- (void) setFixedOnTop:(BOOL)headNeedOnTop{
    
    objc_setAssociatedObject(self, @selector(fixedOnTop), @(headNeedOnTop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (BOOL) fixedOnTop{
    return  [objc_getAssociatedObject(self, @selector(fixedOnTop)) boolValue];
    
}
@end

@implementation UIScrollView (SimultaneouslyGesture)
- (void) setShouldRecognizeSimultaneouslyGesture:(BOOL)shouldRecognizeSimultaneouslyGesture{
    objc_setAssociatedObject(self, @selector(shouldRecognizeSimultaneouslyGesture), @(shouldRecognizeSimultaneouslyGesture), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL) shouldRecognizeSimultaneouslyGesture{
    return [objc_getAssociatedObject(self, @selector(shouldRecognizeSimultaneouslyGesture)) boolValue];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return self.shouldRecognizeSimultaneouslyGesture;
}


- (void) superScrollViewDidScrollWithFixedHeight:(CGFloat)height{
    if (self.contentOffset.y >= height) {
        self.contentOffset = CGPointMake(0, height);
        self.fixedOnTop = YES;
    }
    if(self.fixedOnTop){
        self.contentOffset = CGPointMake(0, height);
    }
}
- (void) childScrollViewDidScrollInSuperScrollView:(UIScrollView*)superScrollView{
    if (self.contentOffset.y <= 0) {
        self.contentOffset = CGPointMake(self.contentOffset.x, 0);
        superScrollView.fixedOnTop = NO;
    }
    if(!superScrollView.fixedOnTop){
        self.contentOffset = CGPointMake(self.contentOffset.x, 0);
    }

}

@end
