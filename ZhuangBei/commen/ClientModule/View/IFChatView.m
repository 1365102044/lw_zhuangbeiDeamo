//
//  IFChatView.m
//  IMDemo
//
//  Created by zhangtongle-Pro on 2018/4/2.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "IFChatView.h"
#import "LWClientHeader.h"
//#import "PPStickerInputView.h"
//#import "PPUtil.h"

@interface IFChatView ()
//<ChatKeyBoardDelegate, ChatKeyBoardDataSource>
//<PPStickerInputViewDelegate>
@property (nonatomic, weak) id delegate;
//@property (nonatomic, strong) PPStickerInputView *inputView;
@property (nonatomic, strong) UIButton *button;
///** 聊天键盘 */
//@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@end

@implementation IFChatView
////检查是否有y发言权限
//- (void)checkUserCanSendmsg:(BOOL)iscan msg:(NSString *)msg;
//{
//    if (!iscan) {
//        [self.inputView setCustomPlainText:msg];
//        self.inputView.userInteractionEnabled = NO;
//    }else{
//
//    }
//
//}
- (instancetype)initWithDelegate:(id<UITableViewDelegate, UITableViewDataSource, IFChatViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [_micButton setMulColor:@[(id)[UIColor colorWithHexString:@"FF6000"].CGColor, (id)[UIColor colorWithHexString:@"FFA414"].CGColor] startPoint:@[@0.0, @0.75]];
//    [_button setMulColor:@[(id)[UIColor colorWithHexString:@"FF6000"].CGColor, (id)[UIColor colorWithHexString:@"FFA414"].CGColor] startPoint:@[@0.0, @0.75]];
    
    
//        CGFloat height = [self.inputView heightThatFits];
//    //    CGFloat minY = CGRectGetHeight(self.view.bounds) - height - PP_SAFEAREAINSETS(self.view).bottom;
//    //    self.inputView.frame = CGRectMake(0, minY, CGRectGetWidth(self.view.bounds), height);
//        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_offset(height);
//        }];
//    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.inputView.mas_top).offset(-5);
//    }];
//    LWLog(@"----------------------%f",height);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATOR_HEIGHT-49) style:UITableViewStylePlain];
    tableView.delegate = _delegate;
    tableView.dataSource = _delegate;
//    tableView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        tableView.backgroundColor = UIColor.whiteColor;
//    tableView.separatorInset = UIEdgeInsetsMake(0, 14, 0, 18);
//    tableView.separatorColor = [UIColor darkGrayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    tableView.layer.masksToBounds = YES;
    tableView.layer.cornerRadius = 8;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView = tableView;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 30;
    

      
      [self addSubview:self.tableView];
      
//    
//    self.chatKeyBoard = [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATOR_HEIGHT)];
//    self.chatKeyBoard.delegate = self;
//    self.chatKeyBoard.dataSource = self;
//    self.chatKeyBoard.associateTableView = self.tableView;
//    [self addSubview:self.chatKeyBoard];
//    self.chatKeyBoard.backgroundColor = UIColor.redColor;
    
    
                                                                           
                                                                           
//    CGFloat height = [self.inputView heightThatFits];
////    CGFloat minY = CGRectGetHeight(self.view.bounds) - height - PP_SAFEAREAINSETS(self.view).bottom;
////    self.inputView.frame = CGRectMake(0, minY, CGRectGetWidth(self.view.bounds), height);
//
//    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).mas_offset(0);
//        make.right.mas_equalTo(self.mas_right).mas_offset(-0);
////        make.top.mas_equalTo(<#name#>.mas_top).mas_offset(<#name#>);
//        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
//        make.height.mas_offset(height);
//        make.height.mas_lessThanOrEqualTo(74);
//    }];
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(0);
//        make.leading.equalTo(self).offset(0);
//        make.trailing.equalTo(self).offset(0);
//        make.bottom.equalTo(self.inputView.mas_top).offset(-5);
//    }];
//                                                                           };
}

//- (PPStickerInputView *)inputView
//{
//    if (!_inputView) {
//        _inputView = [[PPStickerInputView alloc] init];
//        _inputView.delegate = self;
//    }
//    return _inputView;
//}
#pragma mark - Event

- (void)buttonClicked:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(chatViewDidSendText:)]) {
        [_delegate chatViewDidSendText:self.textField.text];
    }
    
    self.textField.text = nil;
    self.button.enabled = NO;
}


//#pragma  mark ---------------- PPStickerInputViewDelegate ------------------
//
//- (void)stickerInputViewDidClickSendButton:(PPStickerInputView *)inputView
//{
//    NSString *plainText = inputView.plainText;
//       if (!plainText.length) {
//           return;
//       }
//       [inputView clearText];
//
//    if (_delegate && [_delegate respondsToSelector:@selector(chatViewDidSendText:)]) {
//        [_delegate chatViewDidSendText:plainText];
//    }
//
//    [self endEditing:YES];
//}




#pragma mark - other
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.chatKeyBoard keyboardDown];
//}

- (void)chatKeyBoardSendText:(NSString *)text;
{
    LWLog(@"********************text:%@",text);
}
#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        themeM.themeStyle = FaceThemeStyleCustomEmoji;
        themeM.themeDecribe = [NSString stringWithFormat:@"f%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}


@end
