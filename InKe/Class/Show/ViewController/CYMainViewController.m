//
//  CYMainViewController.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYMainViewController.h"
#import "CYMainTopView.h"

@interface CYMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) CYMainTopView *topView;
@end

@implementation CYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    [self setupChildControllers];
    
    [self setupNav];
}

- (void)setupNav {
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
}

- (NSArray *)titleNames {
    
    if (!_titleNames) {
        _titleNames = @[@"关注",@"热门",@"附近",@"才艺",@"好声音"];
    }
    return _titleNames;
}

- (CYMainTopView *)topView {
    
    if (!_topView) {
        
        _topView = [[CYMainTopView alloc] initWithFrame:CGRectMake(0, 0, 250, 40) titles:self.titleNames tapView:^(NSInteger tag) {
            
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH ,self.contentScrollView.contentOffset.y);
            [UIView animateWithDuration:0.16 animations:^{
                [self.contentScrollView setContentOffset:point animated:NO];
            } completion:nil];
            
        }];
    }
    return _topView;
}

- (void)setupChildControllers {
    
    NSArray *vcNames = @[@"CYFocusLiveViewController",@"CYHotLiveViewController",@"CYNearLiveViewController",@"CYTalentViewController",@"CYGoodSoundViewController"];
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT - 64;
    CGFloat x = 0;
    for (NSInteger i = 0 ; i < vcNames.count; i ++) {
        
        UIViewController *liveVC = [[NSClassFromString(vcNames[i]) alloc] init];
        liveVC.title = self.titleNames[i];
        [self addChildViewController:liveVC];
        liveVC.view.frame = CGRectMake(x+i*width, 0, width, height);
        [_contentScrollView addSubview:liveVC.view];
    }
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleNames.count, 0);
    
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //contentScrollView的width
    CGFloat width = SCREEN_WIDTH;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //获取索引
    NSInteger index = offsetX / width;
    
    //标题线
    [self.topView scrolling:index];
    
//    UIViewController * childVC = self.childViewControllers[index];
    
    //视图控制器是否加载过
//    if ([childVC isViewLoaded]) return;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

static CGFloat lastOffsetX = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    BOOL toLeft = YES;
    
    if (offsetX > lastOffsetX) {
        toLeft = NO;
    }
    
    [_topView premiereText:offsetX / SCREEN_WIDTH toLeft:toLeft];
    
    lastOffsetX = offsetX;
}

- (void)search {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
