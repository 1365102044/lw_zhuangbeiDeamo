//
//  zInterfacedConst.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/
NSString *const kApiPrefix = @"http://39.101.166.209/app/";
NSString *const kApiPrefix_PIC = @"http://39.101.166.209/";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://test.110zhuangbei.com:8105/app/";
NSString *const kApiPrefix_PIC = @"http://test.110zhuangbei.com:8105/";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"http://110zhuangbei.com/app/";
NSString *const kApiPrefix_PIC = @"http://110zhuangbei.com/";
#endif


/**获取验证码
 > **phone** (String)    *手机号*    |   必填
 */
NSString *const kSendVerificationCode = @"sys/user/sendVerificationCode";
/**注册
 > **username**  (String)    *用户名*    |   必填

 > **password**  (String)    *密码*  |   必填

 > **verificationCode**  (String)    *验证码*    |   必填

 > **invatationCode**    (String)    *邀请码*

 > **refreeId**  (int)   *邀请人ID*

 > **nickName**  (String)    *真实姓名*  |   必填
 */

NSString *const kRegister = @"sys/user/userRegister";

/**pass注册 (注册通过后调用此接口)
 > **username**  (String)    *用户名*    |   必填

 > **password**  (String)    *密码*  |   必填

 > **verificationCode**  (String)    *验证码*    |   必填

 > **invatationCode**    (String)    *邀请码*

 > **refreeId**  (int)   *邀请人ID*

 > **nickName**  (String)    *真实姓名*  |   必填
 */

NSString *const kPassRegister = @"sys/user/userRegister?isPassed=1";
/**
 注册答题
 无
 */
NSString *const kQuestion = @"app/questionnaireexamrecord/loadRegisterQuestion";

/**
判断试卷
 questionList: [{     //试题对象数组
     questionId: 试题ID,
     recordId: 考试记录ID,
     optionList: [{      //用户选择的答案
         optionId: 选项ID
     }],
 }]
*/
NSString *const kAnswer = @"app/questionnaireexamrecord/submitExamForRegister";


/**
 合作伙伴
 *经销商管理
 *code = 2
 *typeIds = 2  未知
 *limit = 20 分页
 *page = 1 第一页
 *searchData= HTTP/1.1
 Authorization: login_token_f86c7994-376b-4dce-b1b0-eba703108356     ?token?
 */
NSString *const kbusinessMan = @"app/appgongys/followGsList";

/**
 个人中心
 *GET
 *返回
 {
     "code": 0,
     "msg": "success",
     "data": {
         "inviteNumber": 0, //我的邀请人
         "productNumber": 0,//我关注的货源
         "providerNumber": 0//我的经销商
     }
 }
 */
NSString *const kpersonalBusiness = @"sys/user/findInviteProductProviderOfNumber";

/**
 * 获取我的邀请人列表
 */
NSString * const kuserGetInvitelList = @"app/appqyuser/inviteMemberList?limit=999&page=1";

/**
 个人中心 - 查询学历，职位，部门，企业类型，工作年限等
 *GET
 *type = [@"sex",@"rank"]
 const val mIsNo = "isNo"           //是否
 const val mIsAgree = "shiFouTy"    //是否同意
 const val mIsDefault = "isDefault" //是否为默认分组
 const val mParamsType = "canShuLx" //参数类型
 const val mAgreement = "agreement" //协议

 const val mExamType = "examType"         //试卷类型
 const val mQuestionType = "questionType" //试题类型
 const val mOptionType = "select_option"  //单选题选项

 const val mSex = "sex"               //性别
 const val mDuty = "rank"             //职务：总经理、财务、商务
 const val mPost = "post"             //岗位
 const val mDepartment = "section"    //部门
 const val mRank = "zhiji"            //职级：一级、二级
 const val mNation = "nation"         //民族
 const val mProvince = "province"     //省份
 const val mEducation = "education"   //学历
 const val mYearOfWork = "jobYear"    //工作年限
 const val mMarriageStatus = "marriagestatus" //婚姻状态
 const val mPoliticsStatus = "politicalstatus"//政治面貌

 const val mLevel = "level"       //会员等级
 const val mLevelNum = "levelNum" //Vip人数

 const val mActivityType = "huoDongZt"    //活动状态
 const val mNoticeWayType = "tongZhiFs"   //通知方式
 const val mProductSource = "productSource"//产品来源
 const val mGroupType = "groupTypeId"     //群组分组类型
 const val mTaskType = "taskType"         //任务类型
 const val mTaskStateType = "taskState"   //任务状态
 const val mCompanyType = "companyType"   //企业类型
 const val mNoticeType = "gongGaoLx"      //公告类型
 const val mPoliceType = "policeClassification" //警钟
 *返回
 {"code":0,"msg":"success","data":{"sex":[{"id":1,"name":"性别","type":"sex","code":"0","value":"女","orderNum":0,"remark":null,"delFlag":0,"gysList":null},{"id":2,"name":"性别","type":"sex","code":"1","value":"男","orderNum":1,"remark":null,"delFlag":0,"gysList":null}]}
 }
  */
NSString *const kgetStudyRank = @"sys/dict/findDictMapByType";
 
/**
 个人中心 - 查询城市列表
 *POST
 *返回
 {
     "code": 0,
     "msg": "success",
     "list": {
         "userId": 744,
         "userBh": null,
         "userDm": 685,
         "userName": "Wa",
         "minsummary": null,
         "birth": null,
         "isShowBirth": 0,
         "jobYear": null,
         "isShowJobYear": 0,
         "nativePlace": null,
         "headSet": null,
         "mobile": "15516562513",
         "isShowMobile": 0,
         "email": null,
         "jobName": null,
         "wordShow": null,
         "sex": null,
         "education": null,
         "isShowEducation": 0,
         "nation": null,
         "provinceId": null,
         "provinceName": null,
         "cityId": null,
         "cityName": null,
         "marriagestatus": null,
         "politicalstatus": null,
         "height": null,
         "weight": null,
         "portrait": 3379,
         "chaungJianRq": "2020-04-30 08:00:00",
         "chuangJianR": null,
         "xiuGaiRq": null,
         "xiuGaiR": null,
         "suoShuGs": null,
         "suoShuGsName": null,
         "suoShuGsCompanyType": null,
         "suoShuGsCreditCodeState": null,
         "status": null,
         "post": null,
         "jobId": null,
         "rankDm": null,
         "buMen": null,
         "quanXianDm": null,
         "quanXianMc": null,
         "shiFouGly": 0,
         "followStatus": null,
         "district": null,
         "districtIdList": null,
         "quJson": null,
         "xmJson": null,
         "jyJson": null,
         "gzJson": null,
         "userName2": null,
         "email2": null,
         "mobile2": null,
         "jobName2": null,
         "companyType": null,
         "companyNameFirst": null,
         "companyNameSecond": null,
         "companyNameThird": null,
         "regLocation": null
     },
     "provinceList": [{
         "id": 10000,
         "name": "全国",
         "parentId": 1,
         "createDate": "2020-03-23 14:42:21",
         "checked": false
     }]
 }
 */
NSString *const kgetUserInfo = @"app/appqyuser/qyinfo";


/**
 *提交用户资料
 *参数
 *{
     "birth": "",
     "buMen": "1",
     "companyNameFirst": "北京",
     "companyNameSecond": "真核",
     "companyNameThird": "科技有限公司",
     "district": "110000",  //城市邮编
     "email": "",
     "isShowBirth": 0,  //是否展示生日
     "isShowEducation": 0, //是否展示学历
     "isShowJobYear": 0,  //是否展示工作年限
     "isShowMobile": 0,  //是否展示手机
     "mobile": "15516562514",
     "portrait": "3379",
     "post": "8",
     "regLocation": "110000",// 城市
     "sex": "1", //性别男
     "shiFouGly": 0,
     "userDm": 692,
     "userId": 751,
     "userName": "哇"
 }
 * {
     "birth": "1991-05-12",1
     "buMen": "2",1
     "district": "110000,120000,130000",1
     "education": "1",1
     "email": "",1
     "isShowBirth": 0,1
     "isShowEducation": 0,1
     "isShowJobYear": 0,1
     "isShowMobile": 0,1
     "jobYear": "1",1
     "mobile": "15516562514",1
     "nativePlace": "410000",1
     "portrait": "3379",1
     "post": "7",1
     "regLocation": "110000",1
     "sex": "1",1
     "shiFouGly": 0,1
     "suoShuGs": "617",1
     "suoShuGsName": "北京真核科技有限公司",1
     "userDm": 692,1
     "userId": 751,1
     "userName": "哇"1
 }
 * {
     jobYear = 1;1
     post = 1;1
     mobile = 18526061162;1
     companyType = 0;0
     isShowBirth = 0;1
     userId = 597;1
     sex = 0;1
     regLocation = 120000;1
     suoShuGs = 0;1
     email = 11;1
     district = 120000,130000,110000;1
     userDm = 532;1
     userName = 王阿宁62;1
     birth = 2020-5-15;1
     isShowEducation = 0;1
     isShowJobYear = 0;1
     suoShuGsName = 天津1162科技有限公司;1
     buMen = 1;1
     nativePlace = 110000;1
     shiFouGly = 0;1
     isShowMobile = 0;1
     education = 6;1
     portrait = 6162;1
 }
 *  * 返回
 * {
     "code": 0,
     "msg": "success"
 }
 */

/**
 * 查询企业是否认证
 * 已认证的企业，公司名称、企业类型、所在部门、所属职务、管辖地不可修改
 * POST
 */

NSString *const kupUserInfo = @"app/appqyuser/update";

/**
 *上传图片
 *
 */
NSString *const kupLoadUserImage = @"app/appfujian/upload";

/**
 *上传公司名称获取公司id
 *POST
 *参数
 *name =  "公司名"
 */
NSString *const kgetCompanyID = @"app/appgongys/findOneByName";

/**
 *修改个人简介
 *POST
 *参数
 *{
     "userId": 751,
     "userDm": 692,
     "minsummary": "语句号"
 }
 */
NSString *const changePersonalMin = @"app/appqyuser/update";


/**
 *邀请人详情
 *URL    http://test.110zhuangbei.com:8105/app/app/appqyuser/findOne
 *userId    768
 */

NSString *const getFriendDetail = @"app/appqyuser/findOne";


/**
 *获取分享二维码
 *Url app/appandroidversion/generateApplicationMarketLinkQrCode
 */
NSString *const getShareImage = @"app/appandroidversion/generateInstallationPackageQrCode";
/**
 *货源管理
 *POST
 *无参数
 */
NSString *const kGoodsMangerMenu = @"app/appzhuangbeitype/getTreeToMyAttentionCompanyNew";

/**
 *货源管理
 *code=3&lastNode=&limit=20&zbid=21&page=1
 */
NSString *const kGoodsMangerList = @"app/appgyszblink/listzbGys";

/**
 *查询公司产品
 *POST
 *URL    http://test.110zhuangbei.com:8105/app/app/appgyszblink/listAndroid
 *gysId    418
 limit    20
 page    1
 */
NSString *const kGetCompanyGoodsList = @"app/appgyszblink/listAndroid";

/**
 *经销商管理
 *URL    http://test.110zhuangbei.com:8105/app/app/appzhuangbeitype/getTreeToMyAttentionCompanyNew
 */
NSString *const kGetBusinessManLocationList = @"app/appzhuangbeitype/getTreeToMyAttentionCompanyNew";

/**
 *获取经销商列表
 *URL    http://test.110zhuangbei.com:8105/app/app/appgongys/followGsList?code=2&typeIds=&limit=20&page=1&searchData=
 *typeIds 城市地址 用编号代替
 */
NSString *const kGetMyBusinessManList = @"app/appgongys/followGsList";
/**
 登录
 > **username**  (String)    *用户名*    |   必填
 > **password**  (String)    *密码*      |   必填
 */
NSString *const kLogin = @"sys/login";


/** 平台会员退出*/
NSString *const kExit = @"/exit";

