//
//  zShouyeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouyeController.h"
#import "zInterfacedConst.h"
#import "zUserModel.h"
#import "sliderNavMenu.h"
#import "zGoodsMangerController.h"
#import "zCompanyController.h"

@interface zShouyeController ()<sliderNavMenuDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)sliderNavMenu * navigationSliderMenu;

@property(strong,nonatomic)UIScrollView* childScroContentView;

@property(strong,nonatomic)UIButton * button;

@end

@implementation zShouyeController



-(sliderNavMenu*)navigationSliderMenu
{
    if (!_navigationSliderMenu) {
        _navigationSliderMenu = [[sliderNavMenu alloc]init];
        _navigationSliderMenu.userInteractionEnabled = YES;
        _navigationSliderMenu.havesliderBar = YES;
        _navigationSliderMenu.padding = kWidthFlot(30);
        _navigationSliderMenu.sliderRoundCorner = 1.5;
        _navigationSliderMenu.normalFontColor = [UIColor colorWithHexString:@"#666666"];
        _navigationSliderMenu.selectFontColor = [UIColor colorWithHexString:@"#333333"];
        [_navigationSliderMenu setSourceArray:@[@"货源管理",@"经销商管理"]];
        _navigationSliderMenu.sliderType = menuAligenLeft;
        _navigationSliderMenu.delegate = self;
    }
    return _navigationSliderMenu;
}

-(UIScrollView *)childScroContentView{
    if (!_childScroContentView) {
        CGRect frame = self.view.bounds;
        frame.size.height = SCREEN_HEIGHT - 44;
        frame.origin.y = 44;
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

-(UIButton*)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.titleLabel.font = kFont(16);
        [_button setBackgroundColor:[UIColor blackColor]];
        [_button setTitle:@"个人信息" forState:UIControlStateNormal];
        [_button setTitleColor: [kMainSingleton colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(gotoLogInVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;;
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
    //货物管理
    zGoodsMangerController* goodsVC = [[zGoodsMangerController alloc]init];
    [self addChildViewController:goodsVC];
    //经销商管理
    zCompanyController * companyVC = [[zCompanyController alloc]init];
    [self addChildViewController:companyVC];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.navigationSliderMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
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


@end
