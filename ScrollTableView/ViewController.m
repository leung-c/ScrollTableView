//
//  ViewController.m
//  ScrollTableView
//
//  Created by liangchao on 16/5/11.
//  Copyright © 2017年 lch. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+SimultaneouslyGesture.h"



static CGFloat HeadHeight = 200;
static CGFloat TitleHeight = 50;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *mainScrollView;
@property (strong,nonatomic) UIView *headView;
@property (strong,nonatomic) UIView *titleView;
@property (strong,nonatomic) UIScrollView *contentScrollView;
@end

@implementation ViewController
{
    BOOL _headNeedOnTop;
}

- (UIScrollView*)mainScrollView{
    if(!_mainScrollView){
        _mainScrollView = [UIScrollView new];
        _mainScrollView.contentSize = CGSizeMake(0, HeadHeight+[UIScreen mainScreen].bounds.size.height);
        _mainScrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.shouldRecognizeSimultaneouslyGesture = YES;
    }
    return _mainScrollView;
}
- (UIView*) headView{
    if(!_headView){
        _headView = [UIView new];
        _headView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , HeadHeight);
        _headView.backgroundColor = [UIColor redColor];
        _headView.userInteractionEnabled = NO;
    }
    return _headView;
}
- (UIView*) titleView{
    if(!_titleView){
        _titleView = [UIView new];
        _titleView.frame = CGRectMake(0, HeadHeight,[UIScreen mainScreen].bounds.size.width , TitleHeight);
        
        _titleView.userInteractionEnabled = YES;
        UIButton *title1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [title1 setTitle:@"第一个Table" forState:(UIControlStateNormal)];
        title1.frame =CGRectMake(0, 0, _titleView.bounds.size.width*0.5,TitleHeight);
        [title1 addTarget:self action:@selector(titleTaped:) forControlEvents:(UIControlEventTouchDown)];
        [title1 setBackgroundColor:[UIColor blueColor]];
        [_titleView addSubview:title1];
        
        UIButton *title2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [title2 setTitle:@"第二个Table" forState:(UIControlStateNormal)];
        title2.frame =CGRectMake(_titleView.bounds.size.width*0.5,0 , _titleView.bounds.size.width*0.5,TitleHeight);
        [title2 addTarget:self action:@selector(titleTaped:) forControlEvents:(UIControlEventTouchDown)];
        [title2 setBackgroundColor:[UIColor greenColor]];
        [_titleView addSubview:title2];
    }
    return _titleView;
}
- (UIScrollView*) contentScrollView{
    if(!_contentScrollView){
        _contentScrollView = [UIScrollView new];
        _contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2,0);
        _contentScrollView.frame = CGRectMake(0, HeadHeight+TitleHeight,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-TitleHeight);
        
        UITableView *table1 = [UITableView new];
        table1.frame = CGRectMake(0, 0, _contentScrollView.bounds.size.width, _contentScrollView.bounds.size.height);
        [_contentScrollView addSubview:table1];
        table1.delegate = self;
        table1.dataSource = self;
        table1.shouldRecognizeSimultaneouslyGesture = YES;
        
        UITableView *table2 = [UITableView new];
        table2.frame = CGRectMake(_contentScrollView.bounds.size.width, 0, _contentScrollView.bounds.size.width, _contentScrollView.bounds.size.height);
        table2.dataSource = self;
        table2.delegate = self;
        table2.shouldRecognizeSimultaneouslyGesture = YES;
        [_contentScrollView addSubview:table2];
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headView];
    [self.mainScrollView addSubview:self.titleView];
    [self.mainScrollView addSubview:self.contentScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.mainScrollView){
        [self.mainScrollView superScrollViewDidScrollWithFixedHeight:HeadHeight];
    }else{
        [scrollView childScrollViewDidScrollInSuperScrollView:self.mainScrollView];
    }
}
- (void) titleTaped:(UIButton*)sender{
    NSInteger index = [self.titleView.subviews indexOfObject:sender];
    [self.contentScrollView setContentOffset:CGPointMake(index*[UIScreen mainScreen].bounds.size.width, self.contentScrollView.contentOffset.y) animated:YES];
}
@end
