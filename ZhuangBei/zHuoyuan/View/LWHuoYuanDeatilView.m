//
//  LWHuoYuanDeatilView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SDCycleScrollView.h"
#import "zCityCollectionCell.h"
#import <WebKit/WebKit.h>
#import "BAKit_WebView.h"
#import "WKWebView+BAKit.h"

@interface LWHuoYuanDeatilView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * companL;
@property (nonatomic, strong) UILabel * proveL;
@property (nonatomic, strong) UILabel * addressL;
//@property (nonatomic, strong) UILabel * productTitleL;
@property (nonatomic, strong) UILabel * productNickL;
//@property (nonatomic, strong) UILabel * xinghaoTitleL;
@property (nonatomic, strong) UILabel * xinghaoL;

@property (nonatomic, strong) UIView * canshuView;
@property (nonatomic, strong) UIView * lunboView;
@property (nonatomic, strong) UIView * infor_topview;

//@property (nonatomic, strong) UILabel * chanpincailiaoL;
//@property (nonatomic, strong) UILabel * fanghucailiaoL;
//@property (nonatomic, strong) UILabel * fanghumianjiL;
//@property (nonatomic, strong) UILabel * guigeL;
//@property (nonatomic, strong) UILabel * guigedescL;
//@property (nonatomic, strong) UILabel * zhixingbiaozhunL;
@property (nonatomic, strong) UIView * chanpinJieSaoView;
@property (nonatomic, strong) WKWebView * productJieSaoL;
//@property (nonatomic, strong) LWLabel * productJieSaoL;
@property (nonatomic, strong) UILabel * productJiesao_titleL;
@property (nonatomic, assign) CGFloat  contentHeight_webview;

@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UIView * canshuDeatilView;
@property (nonatomic, strong) UILabel * canshuDeatilView_titleL;
@property (nonatomic, strong) UILabel * canshuDeatilView_descL;
@property (nonatomic, strong) UIView * xhItemsView;
@property (nonatomic, strong) UICollectionView * cityCollectView;
@property (nonatomic, strong) SDCycleScrollView *sdcview;
@property (nonatomic, strong) UIView * paramItemsBgView;
@property (nonatomic, strong) NSArray * canshuDeatilArray;
@property (nonatomic, strong) UITableView * canshuDeatilTv;

@end

@implementation LWHuoYuanDeatilView


- (void)setModel:(LWHuoYuanDeatilModel *)model
{
    _model = model;
    _nameL.text = _model.productInformation.zbName;
    _companL.text = _model.supplier.name;
    _proveL.text = _model.supplier.companyNameFirst;
    _addressL.text = _model.productInformation.productSourceName;
    _productNickL.text = [_model.productInformation.zbBieMing isNotBlank] ? _model.productInformation.zbBieMing : @"暂无";
    
    //    产品类型
    [self.cityCollectView reloadData];
    
    //    图片
    if (_model.productPictureList.count > 0) {
        NSMutableArray *imageids = [[NSMutableArray alloc] init];
        for (productPictureListModel *picmodel in _model.productPictureList) {
            NSString *url = [NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,picmodel.fuJianDm];
            [imageids addObject:url];
        }
        _sdcview.imageURLStringsGroup = imageids;
    }
    
    
    //    核心参数
    //    [self.paramItemsBgView removeAllSubviews];
    //    for (int i = 0; i < _model.productParameterList.count; i++) {
    //        productParameterListModel *parammodel = _model.productParameterList[i];
    //        UIView *item =  [self createCanshuItem:parammodel.canShuMc tag:i];
    //        [self.paramItemsBgView addSubview:item];
    //        [item mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.right.left.mas_equalTo(_paramItemsBgView);
    //            make.height.mas_offset(40);
    //            if (i == 0) {
    //                make.top.mas_equalTo(_paramItemsBgView.mas_top).mas_offset(0);
    //            }else{
    //                UIView *lastview = self.paramItemsBgView.subviews[self.paramItemsBgView.subviews.count - 2];
    //                make.top.mas_equalTo(lastview.mas_bottom).mas_offset(5);
    //            }
    //            if (i == _model.productParameterList.count - 1) {
    //                make.bottom.mas_equalTo(_paramItemsBgView.mas_bottom).mas_offset(-5);
    //            }
    //        }];
    //    }
    if (_model.productIntroduction.jianJieNr) {
        //        NSString* htmlString = _model.productIntroduction.jianJieNr;
        //          NSMutableAttributedString * attrStr  = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        //
        //          NSString *temstr = attrStr.string;
        //          while ([temstr hasSuffix:@"\n"]) {
        //              if ([temstr isEqualToString:@"\n"]) {
        //                  temstr = @"";
        //                  break;
        //              }
        //              temstr = [temstr substringToIndex:temstr.length - 2];
        //          }
        //          NSMutableAttributedString *atter = [[NSMutableAttributedString alloc] initWithString:temstr];
        //          NSMutableParagraphStyle *paragraphStyle                 = [[NSMutableParagraphStyle alloc] init];
        //          [paragraphStyle setLineSpacing:5];
        //          [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrStr.length)];
        //          _productJieSaoL.attributedText = atter;
        
        [_productJieSaoL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_productJiesao_titleL);
            make.top.mas_equalTo(_productJiesao_titleL.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(_chanpinJieSaoView.mas_bottom).mas_offset(-10);
        }];
        
        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
        
        NSString *htmlstring = [headerString stringByAppendingString:_model.productIntroduction.jianJieNr] ;
        if ([htmlstring containsString:@"../../../"]) {
            htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"../../../" withString:[NSString stringWithFormat:@"%@",kApiPrefix]];
        }
        LWLog(@"*********%@",htmlstring);
        [_productJieSaoL ba_web_loadHTMLString:htmlstring];
    }
    
    
    
    //    更新约束
    [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
    }];
    [self.xhItemsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height);
    }];
}


- (void)clickCanItems:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    NSLog(@"-------------点击参数的item:%ld",tag);
    //    参数详情赋值
    NSMutableArray *tem = [NSMutableArray array];
    if (tag != 4) {
        for (productParameterListModel *parammodel in _model.productParameterList) {
            if (parammodel.canShuLx == tag) {
                [tem addObject:parammodel];
            }
        }
    }else{
        for (productEnclosureListModel *parammodel in _model.productEnclosureList) {
            [tem addObject:parammodel];
        }
    }
    if (tem.count == 0) {
        [zHud showMessage:@"暂无数据"];
        return;
    }
    
    _maskView = [UIView new];
    _maskView.backgroundColor = UIColor.blackColor;
    _maskView.alpha = 0.3;
    self.canshuDeatilView.alpha = 1;
    [_maskView ex_addTapAction:self selector:@selector(clickCanshuDeatilViewBtn)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubviews:@[_maskView,self.canshuDeatilView,]];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [_canshuDeatilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(window.mas_left).mas_offset(0);
        make.right.mas_equalTo(window.mas_right).mas_offset(-0);
        make.bottom.mas_equalTo(window.mas_bottom).mas_offset(0);
    }];
    
    
    _canshuDeatilArray = [tem copy];
    [_canshuDeatilTv reloadData];
    //    _canshuDeatilView_titleL.text = parammodel.canShuMc;
    //    _canshuDeatilView_descL.text = parammodel.canShuZhi;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self confiUI];
    }
    return self;
}

- (void)confiUI
{
    _scrollView = [UIScrollView new];
    
    _nameL = [LWLabel lw_lable:@"" font:21 textColor:BASECOLOR_GREYCOLOR155];
    _nameL.numberOfLines = 3;
    _companL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];;
    _companL.numberOfLines = 3;
    _proveL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _proveL.numberOfLines = 3;
    _addressL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _addressL.numberOfLines = 3;
    _productNickL = [LWLabel lw_lable:@"" font:16 textColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0] backColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
    _xinghaoL = [LWLabel lw_lable:@"" font:16 textColor:RGB(63, 80, 181)];
    UILabel *nickL = [LWLabel lw_lable:@"产品别称" font:18 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *xinghaoL = [LWLabel lw_lable:@"产品型号" font:18 textColor:BASECOLOR_TEXTCOLOR];
    
    _nameL.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [_scrollView addSubviews:@[self.lunboView,_nameL,_productNickL,self.xhItemsView,self.canshuView,xinghaoL,nickL]];
    
    
    [self.scrollView addSubview:self.infor_topview];
    
    CGFloat margin_l = 20;
    [self.lunboView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.scrollView);
        make.height.mas_offset(200);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).mas_offset(margin_l);
        make.right.mas_equalTo(_scrollView.mas_right).mas_offset(-margin_l);
        make.width.mas_offset(SCREEN_WIDTH-margin_l-margin_l);
        make.top.mas_equalTo(_lunboView.mas_bottom).mas_offset(10);
    }];
    [self.infor_topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(10);
    }];
    
    [nickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_infor_topview.mas_bottom).mas_offset(15);
    }];
    [_productNickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL);
        make.top.mas_equalTo(nickL.mas_bottom).mas_offset(10);
        make.width.mas_greaterThanOrEqualTo(@(60));
        make.height.mas_offset(25);
    }];
    [xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_productNickL.mas_bottom).mas_offset(15);
    }];
    [_xhItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(xinghaoL.mas_bottom).mas_offset(10);
        make.height.mas_offset(10);
    }];
    [self.canshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_xhItemsView.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).mas_offset(-20);
    }];
    
    _productNickL.textAlignment = NSTextAlignmentCenter;
    [_productNickL setBoundWidth:1 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    [_xinghaoL setBoundWidth:1 cornerRadius:0 boardColor:RGB(63, 80, 181)];
    [self.canshuView setBoundWidth:0.5 cornerRadius:10 boardColor:BASECOLOR_BOARD];
}

/**
 公司相关信息
 */
- (UIView *)infor_topview
{
    if (!_infor_topview) {
        _infor_topview = [[UIView alloc] init];
        
        UILabel *comL =  [UILabel new];
        UILabel *proL = [UILabel new];
        UILabel *addL = [UILabel new];
        comL.text = @"公司名称:";
        proL.text = @"所在省份:";
        addL.text = @"供应来源:";
        comL.font = proL.font = addL.font = kFont(17);
        
        [_infor_topview addSubviews:@[_companL,_proveL,_addressL,comL,proL,addL]];
        
        [comL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_infor_topview.mas_left).mas_offset(5);
            make.top.mas_equalTo(_infor_topview.mas_top).mas_offset(10);
            make.width.mas_offset(80);
        }];
        [_companL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_infor_topview.mas_right).mas_offset(-10);
            make.left.mas_equalTo(comL.mas_right).mas_offset(10);
            make.top.mas_equalTo(comL.mas_bottom).mas_offset(5);
        }];
        [proL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(comL);
            make.top.mas_equalTo(_companL.mas_bottom).mas_offset(5);
        }];
        [_proveL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_companL);
            make.top.mas_equalTo(proL.mas_bottom).mas_offset(5);
        }];
        [addL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(comL);
            make.top.mas_equalTo(_proveL.mas_bottom).mas_offset(5);
        }];
        [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_companL);
            make.top.mas_equalTo(addL.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(_infor_topview.mas_bottom).mas_offset(-10);
        }];
        [_infor_topview setBoundWidth:1 cornerRadius:6 boardColor:BASECOLOR_BOARD];
        
        
        
    }
    return _infor_topview;
}

/**
 参数s
 */
- (UIView *)canshuView
{
    if (!_canshuView) {
        _canshuView = [[UIView alloc] init];
        //        UILabel *titleL = [LWLabel lw_lable:@"核心参数" font:18 textColor:BASECOLOR_TEXTCOLOR];
        //        titleL.textAlignment = NSTextAlignmentCenter;
        
        [_canshuView addSubviews:@[self.paramItemsBgView,self.chanpinJieSaoView]];
        
        //        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.mas_equalTo(_canshuView.mas_left).mas_offset(0);
        //            make.right.mas_equalTo(_canshuView.mas_right).mas_offset(-0);
        //            make.top.mas_equalTo(_canshuView.mas_top).mas_offset(10);
        //        }];
        [self.paramItemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_canshuView.mas_top).mas_offset(10);
            make.left.right.mas_equalTo(_canshuView);
        }];
        [self.chanpinJieSaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_canshuView);
            make.top.mas_equalTo(self.paramItemsBgView.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(_canshuView.mas_bottom).mas_offset(-10);
        }];
    }
    return _canshuView;
}

- (UIView *)paramItemsBgView
{
    if (!_paramItemsBgView) {
        _paramItemsBgView = [[UIView alloc] init];
        NSArray *items = @[@"核心参数",@"规格包装",@"售后保障",@"操作手册"];
        
        for (int i = 0; i < items.count; i++) {
            UIView *item =  [self createCanshuItem:items[i] tag:i+1];
            [self.paramItemsBgView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(_paramItemsBgView);
                make.height.mas_offset(50);
                if (i == 0) {
                    make.top.mas_equalTo(_paramItemsBgView.mas_top).mas_offset(0);
                }else{
                    UIView *lastview = self.paramItemsBgView.subviews[self.paramItemsBgView.subviews.count - 2];
                    make.top.mas_equalTo(lastview.mas_bottom).mas_offset(5);
                }
                if (i == items.count - 1) {
                    make.bottom.mas_equalTo(_paramItemsBgView.mas_bottom).mas_offset(-5);
                }
            }];
        }
    }
    return _paramItemsBgView;
}

/**
 核心参数的item
 */
- (UIView *)createCanshuItem:(NSString *)leftstr tag:(NSInteger)tag
{
    UIView *bg = [UIView new];
    UILabel *leftL = [LWLabel lw_lable:leftstr font:16 textColor:BASECOLOR_TEXTCOLOR];
    UIButton *rightBtn = [UIButton new];
    [rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGENAME(@"icon_into") forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont(12);
    [rightBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
    [bg addSubviews:@[leftL,rightBtn]];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [bg setBoundWidth:0.5 cornerRadius:6 boardColor:BASECOLOR_BOARD];
    [rightBtn layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyleRight) imageTitleSpace:5];
    bg.tag = tag;
    [bg ex_addTapAction:self selector:@selector(clickCanItems:)];
    return bg;
}

/**
 轮播图
 */
- (UIView *)lunboView
{
    if (!_lunboView) {
        _lunboView = [[UIView alloc] init];
        SDCycleScrollView *sdcview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:self placeholderImage:IMAGENAME(@"testicon")];
        _sdcview = sdcview;
        
        sdcview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        sdcview.pageDotColor = UIColor.blackColor;
        sdcview.currentPageDotColor = UIColor.grayColor;
        [_lunboView addSubview:sdcview];
        [sdcview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_lunboView);
        }];
    }
    return _lunboView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    
}

/**
 产品介绍
 */
- (UIView *)chanpinJieSaoView
{
    if (!_chanpinJieSaoView) {
        _chanpinJieSaoView = [[UIView alloc] init];
        
        UILabel *titleL = [UILabel new];
        //        _productJieSaoL = [LWLabel lw_lable:@"" font:13 textColor:BASECOLOR_TEXTCOLOR];
        //        _productJieSaoL = [[WKWebView alloc] init];
        //        _productJieSaoL.numberOfLines = 0;
        titleL.text = @"产品介绍";
        _productJiesao_titleL = titleL;
        titleL.font = kFont(16);
        [_chanpinJieSaoView addSubviews:@[self.productJieSaoL,titleL]];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_chanpinJieSaoView).mas_offset(10);
            make.right.mas_equalTo(_chanpinJieSaoView.mas_right).mas_offset(-10);
        }];
        [_productJieSaoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(5);
            make.height.mas_offset(1);
            make.bottom.mas_equalTo(_chanpinJieSaoView.mas_bottom).mas_offset(-10);
        }];
        
        [_chanpinJieSaoView setBoundWidth:0.5 cornerRadius:6 boardColor:BASECOLOR_BOARD];
        //        添加观察者
        //                [_productJieSaoL.scrollView addObserver:self forKeyPath:@"contentSize"
        //                                              options:NSKeyValueObservingOptionNew context:nil];
    }
    return _chanpinJieSaoView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([object isKindOfClass:[UICollectionView class]]){
        //    更新约束
        [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
        }];
        [self.xhItemsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height);
        }];
    }
    //    else
    //    //由于图片在实时加载，监听到内容高度变化，需要实时刷新您的控件展示高度
    //    if([keyPath isEqualToString:@"contentSize"]) {
    //        //直接使用scrollView.contentSize.height来刷新cell高度，不再使用JS获取
    //        CGFloat height = self.productJieSaoL.scrollView.contentSize.height;
    //        //定义一个属性保存高度，当上一次的高度等于这次的高度时就不要刷新cell了，不然cell会一直刷新
    //        if (self.contentHeight_webview == height) {
    //            return ;
    //        }
    //        [_productJieSaoL mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_offset(height);
    //        }];
    //        self.contentHeight_webview = height;
    //    }
    
}

- (void)clickCanshuDeatilViewBtn
{
    _maskView.alpha = 0;
    _canshuDeatilView.alpha = 0;
    //    [_maskView removeFromSuperview];
    //    [_canshuDeatilView removeFromSuperview];
    //    _maskView = nil;
    //    _canshuDeatilView = nil;
}

//参数详情
- (UIView *)canshuDeatilView
{
    if (!_canshuDeatilView) {
        _canshuDeatilView = [[UIView  alloc] init];
        _canshuDeatilView.backgroundColor = UIColor.whiteColor;
        
        //        UILabel *titleL = [LWLabel lw_lable:@"" font:18 textColor:BASECOLOR_TEXTCOLOR];
        //        UILabel *desL = [LWLabel lw_lable:@"" font:18 textColor:BASECOLOR_TEXTCOLOR];
        //        titleL.textAlignment = desL.textAlignment = NSTextAlignmentCenter;
        
        UITableView *tableview = [[UITableView alloc] init];
        tableview.dataSource = self;
        tableview.rowHeight = UITableViewAutomaticDimension;
        tableview.estimatedRowHeight = 50;
        tableview.tableFooterView = [UIView new];
        [tableview registerClass:[LWCanShuDeatilTableCell class] forCellReuseIdentifier:@"LWCanShuDeatilTableCell"];
        UIButton *btn = [LWButton lw_button:@"完成" font:15 textColor:UIColor.whiteColor backColor:[UIColor colorWithRed:63/255.0 green:80/255.0 blue:181/255.0 alpha:1.0] target:self acction:@selector(clickCanshuDeatilViewBtn)];
        [btn setBoundWidth:0 cornerRadius:6];
        [_canshuDeatilView addSubviews:@[tableview,btn]];
        _canshuDeatilTv = tableview;
        //        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.mas_equalTo(_canshuDeatilView.mas_left).mas_offset(0);
        //            make.right.mas_equalTo(_canshuDeatilView.mas_right).mas_offset(-0);
        //            make.top.mas_equalTo(_canshuDeatilView.mas_top).mas_offset(30);
        //        }];
        //        [desL mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.left.mas_equalTo(titleL);
        //            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(20);
        //        }];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_canshuDeatilView).mas_offset(0);
            make.top.mas_equalTo(_canshuDeatilView.mas_top).mas_offset(5);
            make.height.mas_offset(220);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_canshuDeatilView.mas_left).mas_offset(30);
            make.right.mas_equalTo(_canshuDeatilView.mas_right).mas_offset(-30);
            make.top.mas_equalTo(tableview.mas_bottom).mas_offset(20);
            make.height.mas_offset(40);
            make.bottom.mas_equalTo(_canshuDeatilView.mas_bottom).mas_offset(-1);
        }];
        //        _canshuDeatilView_titleL = titleL;
        //        _canshuDeatilView_descL = desL;
    }
    return _canshuDeatilView;
}

#pragma mark -----tablesourcedelegate -----

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWCanShuDeatilTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWCanShuDeatilTableCell" forIndexPath:indexPath];
    BaseModel *model = _canshuDeatilArray[indexPath.row];
    if ([model isKindOfClass:[productParameterListModel class]]) {
        productParameterListModel *prammodel = (productParameterListModel *)model;
        cell.leftL.text = prammodel.canShuMc;
        cell.descL.text = prammodel.canShuZhi;
    }else if ([model isKindOfClass:[productEnclosureListModel class]]) {
        productEnclosureListModel *prammodel = (productEnclosureListModel *)model;
        cell.descL.text = prammodel.name;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _canshuDeatilArray.count;
}


- (UIView *)xhItemsView
{
    if (!_xhItemsView) {
        _xhItemsView = [[UIView alloc] init];
        [_xhItemsView addSubview:self.cityCollectView];
        [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_xhItemsView);
            make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
        }];
        [_cityCollectView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return _xhItemsView;
}


-(UICollectionView*)cityCollectView
{
    if (!_cityCollectView) {
        UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10,0, 10,0);
        layout.minimumLineSpacing = kWidthFlot(10);
        layout.minimumInteritemSpacing = kWidthFlot(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cityCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _cityCollectView.showsVerticalScrollIndicator = NO;
        _cityCollectView.backgroundColor = [UIColor clearColor];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
        _cityCollectView.scrollEnabled = NO;
        [_cityCollectView registerClass:[zCityCollectionCell class] forCellWithReuseIdentifier:@"zCityCollectionCell"];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
    }
    return _cityCollectView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.modelList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zCityCollectionCell" forIndexPath:indexPath];
    cell.backColor = [UIColor colorWithHexString:@"#EFEFEF"];
    modelListModel * model = self.model.modelList[indexPath.item];
    cell.souceString = model.model;
    cell.select = [model.customId isEqualToString:_currentModelId];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    modelListModel * model = self.model.modelList[indexPath.item];
    return [self stringSize:model.model];
}

- (CGSize)stringSize:(NSString *)string {
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:17];
    CGFloat yOffset = 3.0f;
    CGFloat width = self.bounds.size.width - 20;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    modelListModel * model = self.model.modelList[indexPath.item];
    NSLog(@"%@",model.model);
    self.currentModelId = model.customId;
    //    [self.cityCollectView reloadData];
    if (self.block) {
        self.block(model.customId);
    }
}

- (WKWebView *)productJieSaoL
{
    if (!_productJieSaoL) {
        _productJieSaoL = [[WKWebView alloc] init];
        _productJieSaoL.ba_web_isAutoHeight = YES;
        WEAKSELF(self)
        _productJieSaoL.ba_web_getCurrentHeightBlock = ^(CGFloat currentHeight) {
            [weakself.productJieSaoL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(currentHeight);
            }];
        };
    }
    return _productJieSaoL;
}

-(void)dealloc
{
    [self removeObserverBlocks];
}

@end

@implementation LWCanShuDeatilTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _leftL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _descL = [LWLabel lw_lable:@"" font:13 textColor:BASECOLOR_GREYCOLOR155];
    _descL.numberOfLines = 0;
    [self.contentView addSubviews:@[_leftL,_descL]];
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.mas_offset(70);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftL.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
}

@end
