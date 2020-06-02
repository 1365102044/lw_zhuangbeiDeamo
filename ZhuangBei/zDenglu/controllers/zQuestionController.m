//
//  zQuestionController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zQuestionController.h"
#import "QuestionHeaderView.h"
#import "AnswerCell.h"
#import "MJExtension.h"
#import "QuestionModel.h"
#import "AnswerModel.h"
#import "QuestionFootView.h"

static NSString * quekey = @"questionId";
static NSString * ansList = @"optionList";
static NSString * anskey = @"optionId";
static NSString * recordId = @"recordId";

@interface zQuestionController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * questionTableView;
@property(strong,nonatomic)QuestionFootView * footView;

@property(strong,nonatomic)NSMutableArray * QuestionModelArray;
@property(strong,nonatomic)NSMutableArray * AnswerArray;//存放答案的数组
@property(strong,nonatomic)NSMutableArray * AnsQuestionIDArray;//用于答案数组判断是否已有本问题答案
@property(strong,nonatomic)NSMutableDictionary * ansDic;//答案字典
@property(strong,nonatomic)NSString * recordId;//考试记录id
@end

@implementation zQuestionController

-(NSMutableArray*)QuestionModelArray
{
    if (!_QuestionModelArray) {
        _QuestionModelArray = [NSMutableArray array];
    }
    return _QuestionModelArray;
}
-(NSMutableArray*)AnsQuestionIDArray
{
    if (!_AnsQuestionIDArray) {
        _AnsQuestionIDArray = [NSMutableArray array];
    }
    return _AnsQuestionIDArray;
}

-(NSMutableArray*)AnswerArray
{
    if (!_AnswerArray) {
        _AnswerArray = [NSMutableArray array];
    }
    return _AnswerArray;
}

-(NSMutableDictionary*)ansDic
{
    if (!_ansDic) {
        _ansDic = [NSMutableDictionary dictionary];
        [_ansDic setObject:@"" forKey:quekey];
    }
    return _ansDic;
}

-(UITableView*)questionTableView
{
    if (!_questionTableView) {
        _questionTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _questionTableView.backgroundColor = [UIColor clearColor];
        _questionTableView.delegate = self;
        _questionTableView.dataSource = self;
        _questionTableView.estimatedRowHeight = 100;
        _questionTableView.showsVerticalScrollIndicator = NO;
        _questionTableView.rowHeight = UITableViewAutomaticDimension;
        _questionTableView.sectionHeaderHeight =UITableViewAutomaticDimension;
        _questionTableView.estimatedSectionHeaderHeight = 2;
        _questionTableView.estimatedSectionFooterHeight = 2;
        _questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _questionTableView;
}

-(QuestionFootView*)footView
{
    if (!_footView) {
        __weak typeof(self)weakSelf = self;
        _footView = [[QuestionFootView alloc]init];
        _footView.addAnswerBack = ^{
            if (weakSelf.AnswerArray.count>0) {
                NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kAnswer];
                
                //                NSDictionary * dic = @{@"questionList":weakSelf.AnswerArray};
                //                NSString * json = [weakSelf.AnswerArray jsonString];
                //                [weakSelf getData:NO url:url withParam:];
                [weakSelf postDataWithUrl:url WithParam:weakSelf.AnswerArray];
            }
        };
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.questionTableView];
    [self.view addSubview:self.footView];
    [self updateViewConstraintsForView];
    [self getQuestions];
}


//获取题目
-(void)getQuestions{
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kQuestion];
    [self getDataurl:url withParam:@{}];
}

//答题成功后再次请求通过注册接口

-(void)sendPassRegister
{
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kPassRegister];
    [self postDataWithUrl:url WithParam:self.userDic];
}


-(void)updateViewConstraintsForView
{
    [self.questionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-kWidthFlot(50));
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        make.height.mas_equalTo(kWidthFlot(50));
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.QuestionModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QuestionModel * question =  self.QuestionModelArray[section];
    return question.optionList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCell * answerCell = [AnswerCell creatTableViewCellWithTableView:tableView AndIndexPath:indexPath];
    QuestionModel * question =  self.QuestionModelArray[indexPath.section];
    answerCell.answerModel = question.optionList[indexPath.row];
    __weak typeof(self)weakSelf = self;
    answerCell.upDataSelectAnswerBack = ^(AnswerModel * _Nonnull ansModel) {
        
        QuestionModel * Mquestion =  weakSelf.QuestionModelArray[ansModel.QuestionIndex];
        AnswerModel * Model = Mquestion.optionList[ansModel.AnswerIndex];
        [weakSelf.ansDic setObject:Mquestion.questionId forKey:quekey];
        [weakSelf.ansDic setObject:weakSelf.recordId forKey:recordId];
        NSMutableArray * ansArr = [NSMutableArray array];
        NSMutableDictionary * ansDic = [NSMutableDictionary dictionary];
        [ansDic setObject:Model.optionId forKey:anskey];
        [ansArr addObject:ansDic];
        [weakSelf.ansDic setObject:ansArr forKey:ansList];
        
        //判断答案数组中是否有此选项，如果有，不做处理，没有则添加
        //根据 questionId 进行判断
        //如果答案数组中有questionId 更改当前id下的答案
        //如果答案数组中无questionId 添加当前答案到数组中
        //
        
        NSMutableArray * newAnswerArray = [NSMutableArray array];
        [newAnswerArray addObjectsFromArray:self.AnswerArray];
        //两个数组，防止遍历报错
        if (weakSelf.AnswerArray.count>0) {
            for (NSDictionary * dic in weakSelf.AnswerArray) {
                NSString * questionId = dic[quekey];
                //如果有此问题的答案
                //                NSLog(@"%@--%@--%@",questionId,Mquestion.questionId,weakSelf.AnsQuestionIDArray);
                if ([weakSelf.AnsQuestionIDArray containsObject:Mquestion.questionId]) {
                    if ([questionId isEqualToString:Mquestion.questionId]) {
                        //如果有此问题答案，更改 先移除 后添加
                        [newAnswerArray removeObject:dic];
                        NSArray * ansA = dic[ansList];
                        for (NSDictionary * ans in ansA) {
                            NSString * optionId = ans[anskey];
                            if ([optionId isEqualToString:Model.optionId]) {
                                //如果已经选中了
                                Model.ISCHOSE = YES;
                                [newAnswerArray addObject:weakSelf.ansDic];
                            }else
                            {
                                //未选中 先清零 再设置选中状态
                                [Mquestion.optionList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    AnswerModel * ansmodel = Mquestion.optionList[idx];
                                    ansmodel.ISCHOSE = NO;
                                }];
                                Model.ISCHOSE = YES;
                                [newAnswerArray addObject:weakSelf.ansDic];
                                //清空当前缓存
                                weakSelf.ansDic = nil;
                            }
                        }
                    }
                }
                else
                {
                    //如果没有当前此问题答案，添加
                    [weakSelf.AnsQuestionIDArray addObject:Mquestion.questionId];
                    Model.ISCHOSE = YES;
                    [newAnswerArray addObject:weakSelf.ansDic];
                    //清空当前缓存
                    weakSelf.ansDic = nil;
                }
            }
            weakSelf.AnswerArray = newAnswerArray;
        }else
        {
            //添加到答案数组
            [weakSelf.AnsQuestionIDArray addObject:Mquestion.questionId];
            Model.ISCHOSE = YES;
            [weakSelf.AnswerArray addObject:weakSelf.ansDic];
            //清空当前缓存
            weakSelf.ansDic = nil;
        }
        NSLog(@"当前的答案数组是%@",weakSelf.AnswerArray);
        [weakSelf.questionTableView reloadSection:Model.QuestionIndex withRowAnimation:UITableViewRowAnimationNone];
        
    };
    return answerCell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionHeaderView * headerView = [[QuestionHeaderView alloc]init];
    QuestionModel * question =  self.QuestionModelArray[section];
    headerView.questionModel = question;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kQuestion]) {
        [[zHud shareInstance]showMessage:@"获取试卷失败"];
        return;
    }
    if ([url containsString:kAnswer]) {
        [[zHud shareInstance]showMessage:@"请求超时"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kQuestion]) {
        NSDictionary * dic = data;
        //        NSLog(@"获取试卷成功%@",dic);
        //        [[zHud shareInstance]showMessage:@"获取试卷成功"];
        [self.QuestionModelArray removeAllObjects];
        [self.AnswerArray removeAllObjects];
        [self.AnsQuestionIDArray removeAllObjects];
        NSDictionary * cache = dic[@"data"][@"questionnaireCache"];
        NSString * recordid = cache[@"recordId"];
        self.recordId = recordid;
        NSArray * questionArray = dic[@"data"][@"questionList"][@"danxt"];
        [questionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = questionArray[idx];
            QuestionModel * model = [QuestionModel mj_objectWithKeyValues:dic];
            model.QuestionIndex = idx;
            NSArray * answer = model.optionList;
            NSMutableArray * answersModelArray = [NSMutableArray array];
            [answer enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                NSDictionary * ansDic = [answer objectAtIndex:jdx];
                AnswerModel * answerModel = [AnswerModel mj_objectWithKeyValues:ansDic];
                answerModel.QuestionIndex = model.QuestionIndex;
                answerModel.AnswerIndex = jdx;
                [answersModelArray addObject:answerModel];
            }];
            model.optionList = answersModelArray;
            [self.QuestionModelArray addObject:model];
        }];
        [self.questionTableView reloadData];
    }
    
    if ([url containsString:kAnswer])
    {
        NSDictionary * dic = data;
        NSDictionary * data = dic[@"data"];
        NSString *  isPassed = data[@"isPassed"];
        if ([isPassed integerValue]==1) {
            //答题通过进入 再次调用通过注册接口
            [self sendPassRegister];
        }else
        {
            [[zHud shareInstance]showMessage:@"答题失败请重新作答"];
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
            .LeeContent(@"回答错误\n请重新作答")
            .LeeCancelAction(@"取消", ^{
                // 点击事件Block
                [self.navigationController popViewControllerAnimated:YES];
                [[zHud shareInstance]showMessage:@"注册失败"];
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
                [self getQuestions];
            })
            .LeeShow();
        }
    }
    if ([url containsString:kPassRegister]) {
        NSDictionary * dic = data;
        NSString * msg = dic[@"msg"];
//        NSString * code = dic[@"code"];
        NSString * type = dic[@"data"][@"type"];
        if (type!=nil && [type integerValue] == 0) {
            //注册成功 进入首页
            [[zHud shareInstance]showMessage:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }else
        {
            [[zHud shareInstance]showMessage:msg];
        }
    }
}


@end
