# ScrollTableView
ScrollView内嵌tableview(Scrollview)无缝滚动的解决方案
利用苹果提供的API实现ScrollView内嵌tableview的滚动，并将实现方式封装到了UIScrollView的分类中，用法如下：
```objc
#import "UIScrollView+SimultaneouslyGesture.h"
...
...
//scrollview的同滚动东处理打开
_mainScrollView.shouldRecognizeSimultaneouslyGesture = YES;
...
//tableView的同时滚动处理打开
table.shouldRecognizeSimultaneouslyGesture = YES;

//滚动过程的处理
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.mainScrollView){//外部scrollview
        [self.mainScrollView superScrollViewDidScrollWithFixedHeight:HeadHeight];
    }else{//内部tableview
        [scrollView childScrollViewDidScrollInSuperScrollView:self.mainScrollView];
    }
}

```
