//
//  zcityCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zcityCell.h"
#import "editTextField.h"
#import "zCityCollectionCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "phoneNumCheck.h"
#import "UITextField+maxLength.h"
#import "SelectedListView.h"
#import "SelectedListModel.h"
#import "zEducationRankTypeInfo.h"
#import "BLDatePickerView.h"
#import "zListTypeModel.h"
#import "zCityCollectionHeaderView.h"

@interface zcityCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BLDatePickerViewDelegate>

@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)editTextField * inputTextFild;

@property(strong,nonatomic)UICollectionView * cityCollectView;
@property(strong,nonatomic)UIView * lineView;
@property(strong,nonatomic)UITextField * textField;
@property(strong,nonatomic)UITextField * textField1;
@property(strong,nonatomic)UITextField * textField2;
@property(strong,nonatomic)NSString * InputTextString;

@property (nonatomic, strong) BLDatePickerView *datePickerView;

@property(strong,nonatomic)NSMutableArray * sexArray;
@property(strong,nonatomic)NSMutableArray * cityArray;
@property(strong,nonatomic)NSMutableArray * eduArray;
@property(strong,nonatomic)NSMutableArray * yearsArray;
@property(strong,nonatomic)NSMutableArray * comArray;
@property(strong,nonatomic)NSMutableArray * bumenArray;
@property(strong,nonatomic)NSMutableArray * zhiwuArray;

@property(strong,nonatomic)NSMutableArray * myCityArray;

@property(assign,nonatomic)BOOL selectAll;
@end
@implementation zcityCell

+(zcityCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zPersonalCell";
    zcityCell * cell = [[zcityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSMutableArray*)sexArray
{
    if (!_sexArray) {
        _sexArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.sex enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.sex[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_sexArray addObject:selModel];
        }];
    }
    return _sexArray;
}

-(NSMutableArray*)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx  == 0) {
            }else
            {
                zListTypeModel * model = [zEducationRankTypeInfo shareInstance].citys[idx];
                SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
                [_cityArray addObject:selModel];
            }
        }];
    }
    return _cityArray;
}

-(NSMutableArray*)eduArray
{
    if (!_eduArray) {
        _eduArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.education enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.education[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_eduArray addObject:selModel];
        }];
    }
    return _eduArray;
}
-(NSMutableArray*)yearsArray
{
    if (!_yearsArray) {
        _yearsArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.jobYear enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.jobYear[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_yearsArray addObject:selModel];
        }];
    }
    return _yearsArray;
}

-(NSMutableArray*)comArray
{
    if (!_comArray) {
        _comArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.companyType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.companyType[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_comArray addObject:selModel];
        }];
    }
    return _comArray;
}

-(NSMutableArray*)bumenArray
{
    if (!_bumenArray) {
        _bumenArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.section enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.section[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_bumenArray addObject:selModel];
        }];
    }
    return _bumenArray;
}

-(NSMutableArray*)zhiwuArray
{
    if (!_zhiwuArray) {
        _zhiwuArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.rank enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.rank[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_zhiwuArray addObject:selModel];
        }];
    }
    return _zhiwuArray;
}

-(NSMutableArray*)myCityArray
{
    if (!_myCityArray) {
        _myCityArray = [NSMutableArray array];
    }
    return _myCityArray;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        CGFloat fontsize =  kWidthFlot(16);
        _nameLabel.font = kFont(fontsize);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(editTextField*)inputTextFild
{
    if (!_inputTextFild) {
        __weak typeof(self)weakSelf = self;
        _inputTextFild = [[editTextField alloc]init];
        _inputTextFild.canTap = NO;
        _inputTextFild.icon = [UIImage imageNamed:@"blank"];
        _inputTextFild.keyboardType = UIKeyboardTypeDefault;
        _inputTextFild.textAlignment = NSTextAlignmentRight;
        _inputTextFild.delegate = self;
        _inputTextFild.tapBack = ^{
            [weakSelf inputClick];
        };
        _inputTextFild.eyesTapBack = ^(NSInteger show) {
            [weakSelf showChange:show];
        };
    }
    return _inputTextFild;
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
        [_cityCollectView registerClass:[zCityCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"zCityCollectionHeaderView"];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
    }
    return _cityCollectView;
}

- (BLDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[BLDatePickerView alloc] init];
        _datePickerView.pickViewDelegate = self;
        NSDate *date = [NSDate date];
        NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [forMatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [forMatter stringFromDate:date];
        NSLog(@"dateStr =  %@",dateStr);
        NSArray * array = [dateStr componentsSeparatedByString:@"-"];
        NSString * year = array[0];
        NSString * month = array[1];
        NSString * day = array[2];
        NSInteger yearintger = [year integerValue];
        NSInteger monthintger = [month integerValue];
        NSInteger dayinteger = [day integerValue];
        [_datePickerView bl_setUpDefaultDateWithYear:yearintger month:monthintger day:dayinteger];
        _datePickerView.topViewBackgroundColor = [UIColor colorWithHexString:@"#3F50B5"];
        /** 可设置的属性 */
//         /** 标题大小 */
//        @property (nonatomic, strong)UIFont  *titleFont;
//        /** 选择器背景颜色 */
//        @property (nonatomic, strong)UIColor *pickViewBackgroundColor;
//        /** 选择器头部视图颜色 */
//        @property (nonatomic, strong)UIColor *topViewBackgroundColor;
//        /** 取消按钮颜色 */
//        @property (nonatomic, strong)UIColor *cancelButtonColor;
//        /** 确定按钮颜色 */
//        @property (nonatomic, strong)UIColor *sureButtonColor;
//        /** 设置背景透明度 0~1 */
//        @property (nonatomic, assign)CGFloat backGAlpha;
        
    }
    return _datePickerView;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    }
    return _lineView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectAll = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.inputTextFild];
        [self.contentView addSubview:self.cityCollectView];
        [self.contentView addSubview:self.lineView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(25));
    }];
    [self.inputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
//        make.width.mas_equalTo(kWidthFlot(150));
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(25));
    }];

    [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(1)).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(1));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.persoamModel.city.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zCityCollectionCell" forIndexPath:indexPath];
    cell.backColor = [UIColor colorWithHexString:@"#EFEFEF"];
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    cell.model = typeModel;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    zCityCollectionHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"zCityCollectionHeaderView" forIndexPath:indexPath];
    header.selectAllTap = ^(BOOL selectAll) {
        weakSelf.selectAll = selectAll;
        
        if (selectAll) {
            [weakSelf.myCityArray removeAllObjects];
            [weakSelf.persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                zListTypeModel * typeModel = weakSelf.persoamModel.city[idx];
                typeModel.select = YES;
                [weakSelf.myCityArray addObject:typeModel];
            }];
        }else
        {
            [weakSelf.persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                zListTypeModel * typeModel = weakSelf.persoamModel.city[idx];
                typeModel.select = NO;
            }];
        }
        __block NSString * cityStr = @"";
        [self.myCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                zListTypeModel * typeModel = self.myCityArray[idx];
                if (cityStr.length>0) {
                    cityStr = [NSString stringWithFormat:@"%@,%@",cityStr,typeModel.typeId];
        //            [cityStr appendFormat:@",%@", typeModel.typeId];
                }else
                {
                    cityStr = [NSString stringWithFormat:@"%@",typeModel.typeId];
                }
            }];
            NSLog(@"==============%@",cityStr);
            if (self.changeModelBack) {
                weakSelf.upModel.district = cityStr;
                weakSelf.changeModelBack(weakSelf.upModel,weakSelf.persoamModel);
            }
        [weakSelf.cityCollectView reloadData];
    };
    header.canEdit = _canEdit;
    header.selectAll = self.selectAll;
    return header;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    return [self stringSize:typeModel.name];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.canEdit) {
        return CGSizeMake(SCREEN_WIDTH, kWidthFlot(44));
    }else
    {
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
    
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
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    typeModel.select = !typeModel.select;
    if ([self.myCityArray containsObject:typeModel]) {
        self.selectAll = NO;
        [self.myCityArray removeObject:typeModel];
    }else
    {
        [self.myCityArray addObject:typeModel];
    }
    __block NSString * cityStr = @"";
    [self.myCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        zListTypeModel * typeModel = self.myCityArray[idx];
        if (cityStr.length>0) {
            cityStr = [NSString stringWithFormat:@"%@,%@",cityStr,typeModel.typeId];
//            [cityStr appendFormat:@",%@", typeModel.typeId];
        }else
        {
            cityStr = [NSString stringWithFormat:@"%@",typeModel.typeId];
        }
    }];
    NSLog(@"==============%@",cityStr);
    if (self.changeModelBack) {
        _upModel.district = cityStr;
        self.changeModelBack(_upModel,_persoamModel);
    }
    [self.cityCollectView reloadData];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

-(void)setPersoamModel:(zPersonalModel *)persoamModel
{
    [self.myCityArray removeAllObjects];
    [persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        zListTypeModel * model = persoamModel.city[idx];
        if (model.select) {
            [self.myCityArray addObject:model];
        }
    }];
    _persoamModel = persoamModel;
    self.nameLabel.text = persoamModel.name;
    self.inputTextFild.canShow = persoamModel.canShow;
    self.inputTextFild.text = persoamModel.content;
    [self.inputTextFild setNeedsLayout];
    [self.inputTextFild layoutIfNeeded];
    
//    if ([persoamModel.name isEqualToString:@"手机号码"]) {
//        if (persoamModel.content.length == 11) {
//            NSString *numberString = [persoamModel.content stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//            self.inputTextFild.text = numberString;
//        }
//    }else
//    {
        
//    }
    if (persoamModel.city.count>0) {
        [self.cityCollectView reloadData];
        [self.cityCollectView layoutIfNeeded];
        CGFloat height = self.cityCollectView.collectionViewLayout.collectionViewContentSize.height;

        [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priorityHigh();
        }];
    }
    
    if ([_persoamModel.name containsString:@"姓名"]) {
        [self changeMyUpModel:nil];
        return;
    }
    
    if ([_persoamModel.name containsString:@"性别"]) {
        
        [self.sexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.sexArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"手机号码"]) {
        self.inputTextFild.Show = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowMobile;
        [self changeMyUpModel:nil];
        return;
    }
    if ([_persoamModel.name containsString:@"出生日期"]) {
        self.inputTextFild.Show = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowBirth;
        [self changeMyUpModel:nil];
        return;
    }
    if ([_persoamModel.name containsString:@"E-mail"]) {
        [self changeMyUpModel:nil];
        return;
    }
    
    if ([_persoamModel.name containsString:@"籍贯"]) {
        
        [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.cityArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"学历"]) {
        self.inputTextFild.Show = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowEducation;
        [self.eduArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.eduArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"工作年限"]) {
        self.inputTextFild.Show = [zEducationRankTypeInfo shareInstance].userInfoModel.isShowJobYear;
        [self.yearsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.yearsArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"公司名称"]) {
        NSString * firstName = [zEducationRankTypeInfo shareInstance].userInfoModel.companyNameFirst;
        NSString * secondName = [zEducationRankTypeInfo shareInstance].userInfoModel.companyNameSecond;
        NSString * thirdName = [zEducationRankTypeInfo shareInstance].userInfoModel.companyNameThird;
        self.upModel.companyNameFirst = firstName;
        self.upModel.companyNameSecond = secondName;
        self.upModel.companyNameThird = thirdName;
        self.inputTextFild.text = [NSString stringWithFormat:@"%@%@%@",firstName,secondName,thirdName];
        
        [self changeMyUpModel:nil];
        return;
    }
    if ([_persoamModel.name containsString:@"公司类型"]) {
        [self.comArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.comArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"公司所在省份"]) {
        [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.cityArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"部门"]) {
        [self.bumenArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.bumenArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"职务"]) {
        [self.zhiwuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectedListModel * selModel = self.zhiwuArray[idx];
            if ([_persoamModel.content isEqualToString:selModel.sid]) {
                //取出性别
                self.inputTextFild.text = selModel.title;
                [self changeMyUpModel:selModel];
            }
        }];
        return;
    }
    if ([_persoamModel.name containsString:@"管辖地"]) {
//        zListTypeModel * typeModel = self.persoamModel.city
        [_persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * guanxia = [zEducationRankTypeInfo shareInstance].userInfoModel.district;
            zListTypeModel * selModel = _persoamModel.city[idx];
            if ([guanxia containsString:selModel.typeId]) {
                //取出性别
                selModel.select = YES;
            }
        }];
        [self changeMyUpModel:nil];
        return;
    }
}
-(void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    if (canEdit) {
        //输入框有点击事件
        self.inputTextFild.canTap = YES;
        self.cityCollectView.allowsSelection = YES;
    }else
    {
        //输入框无点击事件
        self.inputTextFild.canTap = NO;
        self.cityCollectView.allowsSelection = NO;
    }
}


-(void)inputClick
{
    NSLog(@"点击输入框:%@",_persoamModel.name);
    __weak typeof(self)weakSelf = self;
    self.InputTextString = @"";
    if ([_persoamModel.name containsString:@"姓名"]) {
        [LEEAlert alert].config
        .LeeTitle(@"修改姓名")
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField = textField;
            
        })
        .LeeCancelAction(@"取消", ^{
            // 点击事件Block
        })
        .LeeAction(@"确认", ^{
            // 点击事件Block
            if (weakSelf.textField.text.length>0) {
                weakSelf.inputTextFild.text = weakSelf.textField.text;
                [weakSelf changeMyUpModel:nil];
            }
        })
        .LeeShow();
        return;
    }
    
    if ([_persoamModel.name containsString:@"手机号"]) {
        [LEEAlert alert].config
        .LeeTitle(@"修改手机号")
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField = textField;
            weakSelf.textField.keyboardType = UIKeyboardTypeNumberPad;
        })
        .LeeCancelAction(@"取消", ^{
            // 点击事件Block
        })
        .LeeAction(@"确认", ^{
            // 点击事件Block
            if (weakSelf.textField.text.length>0) {
                BOOL rightNum = [phoneNumCheck validateMobile:weakSelf.textField.text];
                if (rightNum) {
                    weakSelf.inputTextFild.text = weakSelf.textField.text;
                    [weakSelf changeMyUpModel:nil];
                }else
                {
                    [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
                    
                }
            }
        })
        .LeeShow();
        return;
    }
    if ([_persoamModel.name containsString:@"出生日期"])
    {
        [self.datePickerView bl_show];
        return;
    }
    
    if ([_persoamModel.name containsString:@"E-mail"]) {
        [LEEAlert alert].config
        .LeeTitle(@"修改邮箱")
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField = textField;
        })
        .LeeCancelAction(@"取消", ^{
            // 点击事件Block
        })
        .LeeAction(@"确认", ^{
            // 点击事件Block
            if (weakSelf.textField.text.length>0) {
                weakSelf.inputTextFild.text = weakSelf.textField.text;
                [weakSelf changeMyUpModel:nil];
            }
        })
        .LeeShow();
        return;
    }
    if ([_persoamModel.name containsString:@"公司名称"]) {
        [LEEAlert alert].config
        .LeeTitle(@"修改公司名称")
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField = textField;
            textField.maxLength = 4;
            weakSelf.textField.placeholder = @"行政区域：例如北京";
        })
        .LeeAddContent(^(UILabel *label) {
            
            label.text = @"行政区域，长度不超过4个汉字";
            label.textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
            label.textAlignment = NSTextAlignmentRight;
        })
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField1 = textField;
            textField.maxLength = 5;
            weakSelf.textField1.placeholder = @"公司简称：例如贞和";
        })
        .LeeAddContent(^(UILabel *label) {
            
            label.text = @"公司名称，长度不超过5个汉字";
            label.textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
            label.textAlignment = NSTextAlignmentRight;
        })
        .LeeAddTextField(^(UITextField * _Nonnull textField) {
            weakSelf.textField2 = textField;
            weakSelf.textField2.placeholder = @"行业类型：例如科技有限公司";
        })
        .LeeCancelAction(@"取消",nil)
        .LeeAction(@"确认", ^{
        })
        .leeShouldActionClickClose(^(NSInteger index){
            // 是否可以关闭回调, 当即将关闭时会被调用 根据返回值决定是否执行关闭处理
            // 这里演示了与输入框非空校验结合的例子

                NSString * chengshi =  weakSelf.textField.text;
                NSString * jiancheng =  weakSelf.textField1.text;
                NSString * leixing =  weakSelf.textField2.text;
                if (chengshi.length == 0) {
                    if (index==0) {
                        return YES;
                    }
                    return NO;
                }
                if (jiancheng.length == 0) {
                    if (index==0) {
                        return YES;
                    }
                    return NO;
                }
                if (leixing.length == 0) {
                    if (index==0) {
                        return YES;
                    }
                    return NO;
                }
                if (index == 0) {
                    return YES;
                }
                weakSelf.upModel.companyNameFirst = chengshi;
                weakSelf.upModel.companyNameSecond = jiancheng;
                weakSelf.upModel.companyNameThird = leixing;
                weakSelf.inputTextFild.text = [NSString stringWithFormat:@"%@%@%@",chengshi,jiancheng,leixing];
                [weakSelf changeMyUpModel:nil];
                return YES;
        })
        
        .LeeShow();
        return;
    }
    if ([_persoamModel.name containsString:@"性别"]) {
        
        [self showSingleListWithTitl:@"选择性别" AndArray:self.sexArray];
        return;
    }
    if ([_persoamModel.name containsString:@"籍贯"]) {
        
        [self showSingleListWithTitl:@"选择籍贯" AndArray:self.cityArray];
        return;
    }
    if ([_persoamModel.name containsString:@"学历"]) {
        
        [self showSingleListWithTitl:@"选择学历" AndArray:self.eduArray];
        return;
    }
    if ([_persoamModel.name containsString:@"工作年限"]) {
        
        [self showSingleListWithTitl:@"选择工作年限" AndArray:self.yearsArray];
        return;
    }
    if ([_persoamModel.name containsString:@"公司类型"]) {
        
        [self showSingleListWithTitl:@"选择公司类型" AndArray:self.comArray];
        return;
    }
    if ([_persoamModel.name containsString:@"公司所在省份"]) {
        
        [self showSingleListWithTitl:@"选择公司所省份" AndArray:self.cityArray];
        return;
    }
    if ([_persoamModel.name containsString:@"部门"]) {
        
        [self showSingleListWithTitl:@"选择部门" AndArray:self.bumenArray];
        return;
    }
    if ([_persoamModel.name containsString:@"职务"]) {
        
        [self showSingleListWithTitl:@"选择职务" AndArray:self.zhiwuArray];
        return;
    }
}

-(void)showSingleListWithTitl:(NSString*)title AndArray:(NSArray*)array
{
    __weak typeof(self) weakSelf = self;
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        
        [LEEAlert closeWithCompletionBlock:^{
            SelectedListModel * model = array[0];
            weakSelf.inputTextFild.text = model.title;
            [weakSelf changeMyUpModel:model];
        }];
        
    };
    
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    #ifdef __IPHONE_13_0
    .LeeUserInterfaceStyle(UIUserInterfaceStyleLight)
    #endif
    .LeeShow();
    
    view.array = array;
}

-(void)setUpModel:(zUpLoadUserModel *)upModel
{
    _upModel = upModel;
}

-(void)changeMyUpModel:(SelectedListModel*)selModel{
    
    _persoamModel.content = self.inputTextFild.text;
    
    if ([_persoamModel.name containsString:@"姓名"]) {
        _upModel.userName = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"性别"]) {
        //
        _upModel.sex = [NSString stringWithFormat:@"%@",selModel.sid];
//        if ([self.inputTextFild.text isEqualToString:@"男"]) {
//
//        }
//        if ([self.inputTextFild.text isEqualToString:@"女"]) {
//            _upModel.sex = [NSString stringWithFormat:@"%ld",(long)selModel.sid];
//        }
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"手机号"]) {
        _upModel.mobile = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"出生日期"]) {
        _upModel.birth = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"E-mail"]) {
        _upModel.email = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"公司名称"]) {
//        _upModel.suoShuGsName = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    
    if ([_persoamModel.name containsString:@"籍贯"]) {
        // 籍贯传id
        _upModel.nativePlace = [NSString stringWithFormat:@"%@",selModel.sid];
//        _upModel.nativePlace = self.inputTextFild.text;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"学历"]) {
        //学历传id
//        _upModel.education = self.inputTextFild.text;
        _upModel.education = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"工作年限"]) {
//        _upModel.jobYear = self.inputTextFild.text;
        _upModel.jobYear = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"公司类型"]) {
        //公司类型字段未知
        _upModel.companyType = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"公司所在省份"]){
        //公司所在地，传id
//        _upModel.regLocation = self.inputTextFild.text;
        _upModel.regLocation = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"部门"]) {
        //传 id
//        _upModel.buMen = self.inputTextFild.text;
        _upModel.buMen = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    
    if ([_persoamModel.name containsString:@"职务"]) {
        //传id
//        _upModel.post = self.inputTextFild.text;
        _upModel.post = [NSString stringWithFormat:@"%@",selModel.sid];
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    
    if ([_persoamModel.name containsString:@"管辖地"]) {
        //管辖地 传 id 用逗号隔开
        if ([self.inputTextFild.text isEqualToString:@"请选择"]) {
            _upModel.district = @"";
        }else
        {
            _upModel.district = self.inputTextFild.text;
        }
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
        
}

-(void)showChange:(NSInteger)sow
{
    
    if ([_persoamModel.name containsString:@"手机号"]) {
        [zEducationRankTypeInfo shareInstance].userInfoModel.isShowMobile = sow;
        _upModel.isShowMobile = sow;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"出生日期"]) {
        [zEducationRankTypeInfo shareInstance].userInfoModel.isShowBirth = sow;
        _upModel.isShowBirth = sow;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"学历"]) {
        [zEducationRankTypeInfo shareInstance].userInfoModel.isShowEducation = sow;
        _upModel.isShowEducation = sow;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
    if ([_persoamModel.name containsString:@"工作年限"]) {
        [zEducationRankTypeInfo shareInstance].userInfoModel.isShowJobYear = sow;
        _upModel.isShowJobYear = sow;
        if (self.changeModelBack) {
            self.changeModelBack(_upModel,_persoamModel);
        }
        return;
    }
}

- (void)bl_selectedDateResultWithYear:(NSString *)year
                                month:(NSString *)month
                                  day:(NSString *)day{
    self.inputTextFild.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    [self changeMyUpModel:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}
@end
