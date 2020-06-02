//
//  AnswerCell.h
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerModel.h"
NS_ASSUME_NONNULL_BEGIN



@class AnswerCell;

typedef void(^updataAnsCellSelectTapBack)(AnswerModel*ansModel);

@interface AnswerCell : UITableViewCell

+(AnswerCell*)creatTableViewCellWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)AnswerModel * answerModel;

@property(copy,nonatomic)updataAnsCellSelectTapBack upDataSelectAnswerBack;

@end

NS_ASSUME_NONNULL_END
