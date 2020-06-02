//
//  QuestionTableViewCell.h
//  ZhuangBei
//
//  Created by aa on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionTableViewCell : UITableViewCell

+(QuestionTableViewCell*)creatTableViewCellWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
