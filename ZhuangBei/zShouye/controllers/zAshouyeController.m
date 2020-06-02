//
//  zAshouyeController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zAshouyeController.h"
#import "sliderNavMenu.h"
#import "zShouyeController.h"
#import "zHuoYuanMangerController.h"
#import "LWClientManager.h"
@interface zAshouyeController ()<sliderNavMenuDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)sliderNavMenu * navigationSliderMenu;

@property(strong,nonatomic)UIScrollView* childScroContentView;

@end

@implementation zAshouyeController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    self.tabBarItem.badgeValue = @"28";
    self.navigationController.tabBarItem.badgeValue = @"0";
}

-(sliderNavMenu*)navigationSliderMenu
{
    if (!_navigationSliderMenu) {
        _navigationSliderMenu = [[sliderNavMenu alloc]init];
        _navigationSliderMenu.alpha = 0;
        _navigationSliderMenu.userInteractionEnabled = YES;
        _navigationSliderMenu.havesliderBar = YES;
        _navigationSliderMenu.padding = kWidthFlot(30);
        _navigationSliderMenu.sliderRoundCorner = 1.5;
        _navigationSliderMenu.normalFontColor = [UIColor colorWithHexString:@"#666666"];
        _navigationSliderMenu.selectFontColor = [UIColor colorWithHexString:@"#333333"];
//        @"控制台"
        [_navigationSliderMenu setSourceArray:@[@"合作伙伴"]];
        _navigationSliderMenu.sliderType = menuAligenCenter;
        _navigationSliderMenu.delegate = self;
    }
    return _navigationSliderMenu;
}

-(UIScrollView *)childScroContentView{
    if (!_childScroContentView) {
        CGRect frame = self.view.bounds;
//        44+
        frame.size.height = SCREEN_HEIGHT -(KstatusBarHeight);
//        44+
        frame.origin.y = KstatusBarHeight;
        _childScroContentView = [[UIScrollView alloc]initWithFrame:frame];
        _childScroContentView.delegate = self;
        _childScroContentView.contentSize = CGSizeMake(SCREEN_WIDTH *self.childViewControllers.count,0);
        _childScroContentView.pagingEnabled = YES;
        _childScroContentView.backgroundColor = [UIColor whiteColor];
        _childScroContentView.showsHorizontalScrollIndicator = NO;
        [self.view insertSubview:_childScroContentView atIndex:0];
        [self scrollViewDidEndScrollingAnimation:_childScroContentView];
    }
    return _childScroContentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationSliderMenu];
    [self setupChildViewControllers];
    [self.view addSubview:self.childScroContentView];
    CGPoint offset = self.childScroContentView.contentOffset;
    offset.x = 0;
    [self.childScroContentView setContentOffset:offset animated:YES];
    
}

-(void)setupChildViewControllers
{
    //控制台
//    zHuoYuanMangerController * companyVC = [[zHuoYuanMangerController alloc]init];
//    [self addChildViewController:companyVC];
    
    //合作伙伴
    zShouyeController* goodsVC = [[zShouyeController alloc]init];
    [self addChildViewController:goodsVC];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.navigationSliderMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(KstatusBarHeight);
        make.height.mas_equalTo(44);
    }];
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.childScroContentView]) {
        //当前索引
        int index = (int)(scrollView.contentOffset.x / SCREEN_WIDTH);
        //拿到子控制器
        UIViewController *vc = self.childViewControllers[index];
        CGRect frame = vc.view.frame;
        frame.origin.x = scrollView.contentOffset.x;
        frame.origin.y = 0;// 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        frame.size.height = scrollView.frame.size.height;
        vc.view.frame = frame;
        [scrollView addSubview:vc.view];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.childScroContentView]) {
        [self scrollViewDidEndScrollingAnimation:self.childScroContentView];
        //当前索引
        int index = (int)(scrollView.contentOffset.x / SCREEN_WIDTH);
        self.navigationSliderMenu.selectIndex = index;

    }
}


-(void)sliderNavMenuSelectIndex:(NSInteger)index
{
    CGPoint offset = self.childScroContentView.contentOffset;
    offset.x = index *SCREEN_WIDTH;
    [self.childScroContentView setContentOffset:offset animated:YES];
}

-(void)gotoLogInVC
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    NSDictionary * userInfo = [model mj_keyValues];
    
    NSString * userInfojson = [userInfo jsonString];
    
    NSString * content = [NSString stringWithFormat:@"您的信息\n%@",userInfojson];
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeContent(content)
    .LeeCancelAction(@"取消", ^{
        // 点击事件Block
    })
    .LeeAction(@"确认", ^{
        // 点击事件Block
    })
    .LeeShow();
    
    [[LWClientManager share] userLogin];
}

@end
