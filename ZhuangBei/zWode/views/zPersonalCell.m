//
//  zPersonalCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPersonalCell.h"
#import "LoginTextField.h"


@interface zPersonalCell ()
@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)LoginTextField * inputTextFild;

@property(strong,nonatomic)UIView * lineView;
@end

@implementation zPersonalCell

+(zPersonalCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zPersonalCell";
    zPersonalCell * cell = [[zPersonalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.font = kFont(18);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(LoginTextField*)inputTextFild
{
    if (!_inputTextFild) {
        _inputTextFild = [[LoginTextField alloc]init];
        _inputTextFild.icon = [UIImage imageNamed:@"blank"];
        _inputTextFild.keyboardType = UIKeyboardTypeDefault;
        _inputTextFild.maxLength = 11;
//        _inputTextFild.myPlaceHolder = @"请输入姓名";
    }
    return _inputTextFild;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#FCF9FC"];
    }
    return _lineView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.inputTextFild];
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
        make.bottom.mas_equalTo(kWidthFlot(10));
    }];
    [self.inputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(25));
        make.bottom.mas_equalTo(kWidthFlot(10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
