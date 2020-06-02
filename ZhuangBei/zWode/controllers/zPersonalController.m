//
//  zPersonalController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPersonalController.h"
#import "zcityCell.h"
#import "zCityEditFooter.h"
#import "zPersonalModel.h"
#import "zPersonalHeader.h"
#import "zEducationRankTypeInfo.h"
#import "zUpLoadUserModel.h"
#import "zListTypeModel.h"
#import "NSDictionary+NSNull.h"
#import "HeaderManager.h"

@interface zPersonalController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * persoanTableView;
@property(strong,nonatomic)zPersonalHeader * headerView;
@property(strong,nonatomic)zCityEditFooter * footView;

@property(strong,nonatomic)NSMutableArray * persoanArray;

@property(assign,nonatomic)BOOL canEdit;

@property(strong,nonatomic)zUpLoadUserModel * upLoadModel;

@property(strong,nonatomic)NSString * companyId;

@property(strong,nonatomic)NSString * portrait;

@end

@implementation zPersonalController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(zUpLoadUserModel*)upLoadModel
{
    if (!_upLoadModel) {
        _upLoadModel = [[zUpLoadUserModel alloc]init];
        _upLoadModel.userId = [zEducationRankTypeInfo shareInstance].userInfoModel.userId;
        _upLoadModel.userDm = [zEducationRankTypeInfo shareInstance].userInfoModel.userDm;
        _upLoadModel.portrait = [zEducationRankTypeInfo shareInstance].userInfoModel.portrait;
        _upLoadModel.isShowMobile = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowMobile;
        _upLoadModel.isShowJobYear = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowJobYear;
        _upLoadModel.isShowEducation = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowEducation;
        _upLoadModel.isShowBirth = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowBirth;
    }
    return _upLoadModel;
}

-(NSMutableArray*)persoanArray
{
    if (!_persoanArray) {
        NSArray * citys = [zEducationRankTypeInfo shareInstance].citys;
        if (citys == nil) {
            citys = @[];
        }
        NSArray * persoanl = @[
            @{
                @"name":@"姓名（必填）",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.userName],
                @"canShow":@(0)
            },@{
                @"name":@"性别（必填）",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.sex],
                @"canShow":@(0)
            },@{
                @"name":@"手机号码",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.mobile],
                @"canShow":@(1)
            },@{
                @"name":@"出生日期",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.birth],
                @"canShow":@(1)
            },@{
                @"name":@"E-mail",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.email],
                @"canShow":@(0)
            },@{
                @"name":@"籍贯",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.nativePlace],
                @"canShow":@(0)
            },@{
                @"name":@"学历",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.education],
                @"canShow":@(1)
            },@{
                @"name":@"工作年限",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.jobYear],
                @"canShow":@(1)
            },@{
                @"name":@"公司名称",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.suoShuGsName],
                @"canShow":@(0)
            },@{
                @"name":@"公司类型",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.companyType],
                @"canShow":@(0)
            },@{
                @"name":@"公司所在省份（必选）",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.regLocation],
                @"canShow":@(0)
            },@{
                @"name":@"部门（必填）",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.buMen],
                @"canShow":@(0)
            },@{
                @"name":@"职务",
                @"content":[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.post],
                @"canShow":@(0)
            },
            @{
                @"name":@"管辖地",
                @"content":@"请选择",
                @"canShow":@(0),
                @"city":citys
            },
        ];
        NSMutableArray * mutableArray = [NSMutableArray array];
        [persoanl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = persoanl[idx];
            zPersonalModel * model = [zPersonalModel mj_objectWithKeyValues:dic];
            model.index = idx;
            [mutableArray addObject:model];
        }];
        _persoanArray = mutableArray;
    }
    return _persoanArray;
}

-(UITableView*)persoanTableView
{
    if (!_persoanTableView) {
        _persoanTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _persoanTableView.backgroundColor = [UIColor whiteColor];
        _persoanTableView.delegate = self;
        _persoanTableView.dataSource = self;
        _persoanTableView.allowsSelection = NO;
        _persoanTableView.estimatedRowHeight = kWidthFlot(44);
        _persoanTableView.estimatedSectionHeaderHeight = 2;
        _persoanTableView.estimatedSectionFooterHeight = 2;
        _persoanTableView.showsVerticalScrollIndicator = NO;
        _persoanTableView.rowHeight = UITableViewAutomaticDimension;
        _persoanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _persoanTableView;
}
-(zPersonalHeader*)headerView
{
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[zPersonalHeader alloc]init];
        _headerView.imageID = [NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.portrait];
        _headerView.personalTap = ^{
          
            [HeaderManager.inst showMenuWithController:weakSelf startUpload:^{
                //开始
                NSLog(@"开始上传");
            } change:^(UIImage * _Nonnull image, NSString * _Nonnull ossUrl) {
                //改变
                weakSelf.headerView.imageID = ossUrl;
                weakSelf.portrait = ossUrl;
                NSLog(@"上传成功");
            } fail:^{
                //失败
                NSLog(@"上传失败");
            }];
        };
    }
    return _headerView;
}

-(zCityEditFooter*)footView
{
    if (!_footView) {
        __weak typeof(self)weakSelf = self;
        _footView = [[zCityEditFooter alloc]init];
        _footView.tapBack = ^(NSInteger type) {
            if (type == 1) {
                weakSelf.canEdit = YES;
            }else if (type == 2)
            {
                weakSelf.canEdit = NO;
            }else
            {
                if (weakSelf.upLoadModel.userName.length==0) {
                    [[zHud shareInstance]showMessage:@"用户名必填"];
                    return;
                }
                if (weakSelf.upLoadModel.sex.length==0) {
                    [[zHud shareInstance]showMessage:@"性别必填"];
                    return;
                }
                if (weakSelf.upLoadModel.regLocation.length==0) {
                    [[zHud shareInstance]showMessage:@"公司所在地必填"];
                    return;
                }
                if (weakSelf.upLoadModel.buMen.length==0) {
                    [[zHud shareInstance]showMessage:@"部门必填"];
                    return;
                }
                if ([weakSelf.upLoadModel.email isEqualToString:@"(null)"]) {
                    weakSelf.upLoadModel.email = @"";
                }
                if ([weakSelf.upLoadModel.birth isEqualToString:@"(null)"]) {
                    weakSelf.upLoadModel.birth = @"";
                }
                if (weakSelf.portrait != nil) {
                    weakSelf.upLoadModel.portrait = weakSelf.portrait;
                }
                NSDictionary * dic = [weakSelf.upLoadModel mj_keyValues];
                weakSelf.canEdit = NO;
//                NSLog(@"------%@",dic);
                NSDictionary * upDic = @{
                    @"birth": @"2020-05-16",
                    @"buMen": @"1",
                    @"companyNameFirst": @"北京",
                    @"companyNameSecond": @"真核",
                    @"companyNameThird": @"科技公司",
                    @"companyType": @"0",
                    @"district": @"110000",
                    @"education": @"1",
                    @"email": @"1213@qq.com",
                    @"isShowBirth": @0,
                    @"isShowEducation": @0,
                    @"isShowJobYear": @0,
                    @"isShowMobile": @0,
                    @"jobYear": @"1",
                    @"mobile": @"15516562513",
                    @"nativePlace": @"110000",
                    @"portrait": @"3379",
                    @"post": @"3",
                    @"regLocation": @"110000",
                    @"sex": @"1",
                    @"shiFouGly": @0,
                    @"userDm": @685,
                    @"userId": @744,
                    @"userName": @"Wa"
                };
                
                NSLog(@"正确:%@=错误:%@",upDic,dic);
                
                NSMutableDictionary * tureDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
                if (weakSelf.companyId != nil) {
                [tureDic setObject:weakSelf.companyId forKey:@"suoShuGs"];
                }
                NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kupUserInfo];
                [weakSelf postDataWithUrl:url WithParam:tureDic];
            }
            [weakSelf.persoanTableView reloadData];
        };
        
    }
    return _footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.persoanTableView];
    
    NSString * type = @"sex,education,jobYear,section,rank,companyType";
    NSString * url = [NSString stringWithFormat:@"%@%@?type=%@",kApiPrefix,kgetStudyRank,type];
    
    if ([zEducationRankTypeInfo shareInstance].typesModel.section.count > 0) {
        NSLog(@"类型：%@",[zEducationRankTypeInfo shareInstance].typesModel);
    }else
    {
        [self postDataWithUrl:url WithParam:nil];
    }
    
    NSString * checkCompanyUrl = [NSString stringWithFormat:@"%@%@?name=%@",kApiPrefix,kgetCompanyID,[zEducationRankTypeInfo shareInstance].userInfoModel.suoShuGsName];
    
    [self postDataWithUrl:checkCompanyUrl WithParam:nil];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.persoanTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persoanArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    zcityCell * cell = [zcityCell instanceWithTableView:tableView AndIndexPath:indexPath];
    cell.canEdit = self.canEdit;
    cell.upModel = self.upLoadModel;
    cell.changeModelBack = ^(zUpLoadUserModel * _Nonnull upModel, zPersonalModel * _Nonnull perModel) {
        zPersonalModel * model = weakSelf.persoanArray[perModel.index];
        model.content = perModel.content;
        weakSelf.upLoadModel = upModel;
    };
    zPersonalModel * model = self.persoanArray[indexPath.row];
    cell.persoamModel = model;
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView.canEdit = self.canEdit;;
    return self.headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    self.footView.canEdit = self.canEdit;
    return self.footView;
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kgetStudyRank]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }
    if ([url containsString:kupUserInfo]) {
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }
    if ([url containsString:kgetCompanyID]) {
           [[zHud shareInstance] showMessage:@"无法连接服务器"];
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kgetStudyRank]) {
        
        NSDictionary * dic = data[@"data"];
        zTypesModel * model = [zTypesModel mj_objectWithKeyValues:dic];
        
        //性别
        NSMutableArray * sexArr = [NSMutableArray array];
        [model.sex enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.sex[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [sexArr addObject:sexModel];
        }];
        model.sex = sexArr;
        
        //学历
        NSMutableArray * educationArr = [NSMutableArray array];
        [model.education enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.education[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [educationArr addObject:sexModel];
        }];
        model.education = educationArr;
        
        //职务
        NSMutableArray * rankArr = [NSMutableArray array];
        [model.rank enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.rank[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [rankArr addObject:sexModel];
        }];
        model.rank = rankArr;
        
        //公司类型
        NSMutableArray * companyTypeArr = [NSMutableArray array];
        [model.companyType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.companyType[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [companyTypeArr addObject:sexModel];
        }];
        model.companyType = companyTypeArr;
        
        //工作年限
        NSMutableArray * jobYearArr = [NSMutableArray array];
        [model.jobYear enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.jobYear[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [jobYearArr addObject:sexModel];
        }];
        model.jobYear = jobYearArr;
        
        //部门
        NSMutableArray * sectionArr = [NSMutableArray array];
        [model.section enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = model.section[idx];
            zListTypeModel * sexModel = [zListTypeModel mj_objectWithKeyValues:dic];
            sexModel.select = NO;
            [sectionArr addObject:sexModel];
        }];
        model.section = sectionArr;
        [zEducationRankTypeInfo shareInstance].typesModel = model;
        [[zEducationRankTypeInfo shareInstance] saveTypeInfo];
        return;
    }
    if ([url containsString:kupUserInfo]) {
        NSDictionary * dic = data[@"data"];
         NSString * code = data[@"code"];
        NSString * msg = data[@"code"];
        if ([code integerValue] == 500) {
            [[zHud shareInstance]showMessage:msg];
        }
        NSLog(@"提交信息%@",dic);
    }
    
    if ([url containsString:kgetCompanyID]) {
        NSString * code = data[@"code"];
        NSDictionary * dic = data[@"data"];
        NSDictionary * trueDic = [NSDictionary nullDicToDic:dic];
        
        self.companyId = trueDic[@"id"];
        
        if ([code integerValue] == 0) {
            //验证成功
//            * 已认证的企业，公司名称、企业类型、所在部门、所属职务、管辖地不可修改
        }
        NSLog(@"公司认证信息%@",dic);
    }
}


@end
