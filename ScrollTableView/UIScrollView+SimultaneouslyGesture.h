//
//  UIScrollView+SimultaneouslyGesture.h
//  liangchao
//
//  Created by liangchao on 15/9/4.
//  Copyright © 2017年 liangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SimultaneouslyGesture)
/**
 是否需要处理同时发生的手势，内嵌scrollview如需无缝滚动，请设置为YES；
 
 */
@property (nonatomic,assign) BOOL shouldRecognizeSimultaneouslyGesture;

/**
 @param height 外部ScrollView滑动后需固定的高度
*/
- (void) superScrollViewDidScrollWithFixedHeight:(CGFloat)height;

/**
 @param superScrollView 外部ScrollView
 */
- (void) childScrollViewDidScrollInSuperScrollView:(UIScrollView*)superScrollView;
@end
