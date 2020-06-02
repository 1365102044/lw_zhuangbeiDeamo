//
//  QuestionTableViewCell.m
//  ZhuangBei
//
//  Created by aa on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell

+(QuestionTableViewCell*)creatTableViewCellWithTableView:(UITableView *)tableView AndIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString * CellID = [NSString stringWithFormat:@"AnswerCell%ld__%ld",indexPath.section,indexPath.row];
    QuestionTableViewCell * cell = [[QuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
