//
//  Header.h
//  haha
//
//  Created by 李晓伟 on 17/2/24.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - 内网
//#define URL @"http://192.168.0.113:8080"

#pragma mark - 外网
#define URL @"http://47.105.60.120:8080/" 

#pragma mark - 登录
#define URL_DengLU_ (URL@"/Challane/challane/challaneUser/userLogin?")

#pragma mark - 查询点数
#define URL_ChaXunShengYuDianShu (URL@"/Challane/challane/challaneFile/queryByCount?")

#pragma mark - 提交 意见反馈
#define URL_TiJiao_YiJian_GanKui (URL@"/Challane/challane/challaneFile/addOpinion?")

#pragma mark - 支付宝秘钥
#define URL_ZhiFuBao_MiYao (URL@"/Challane/challane/challaneFile/getOrderInfo?")

#pragma mark - 获取支付订单号
#define URL_HuoQu_ZhiFu_DianHao (URL@"/Challane/challane/challaneFile/orderNo?")

#pragma mark - 上传图片
#define URL_ShangChuanTuPian (URL@"/Challane/challane/challaneFile/uploadMedias?")

#pragma mark - 新建签名列表
#define URL_HuoQu_XinJianQianMing_LieBiao (URL@"/Challane/challane/challaneFile/selectFile?")

#pragma mark - 文件上传
#define  URL_WenJianShangChun (URL@"/Challane/challane/challaneFile/pdftojpg?")

#pragma mark - 模板签名 - 获取模板
#define URL_HuoQu_MuBan (URL@"/Challane/challane/challaneFile/templet?")

#pragma mark - 身份认证成功后
#define  URL_ShenFen_RenZheng_ChengGong (URL@"/Challane/idcart/idcartAdd?")

#pragma mark - 获取通讯录列表
#define URL_TongXunLu_LieBie (URL@"/Challane/challane/challaneUser/friendlist?")

#pragma mark - 搜索联系人
#define URL_TongXunLu_LieBiao_SouSuo (URL@"/Challane/challane/challaneUser/unionidSelect?")


#pragma mark - 添加联系人
#define URL_TianJiaLianXiRen (URL@"/Challane/challane/challaneUser/friendAdd?")

#pragma mark - 修改联系人
#define URL_XiuGai_LianXiRen (URL@"/Challane/challane/challaneUser/unionidUpdate?")

#pragma mark - 删除联系人
#define URL_ShanChuLianXiRen (URL@"/Challane/challane/challaneUser/unioniddel?")

#endif /* Header_h */
