//
//  Header.h
//  haha
//
//  Created by 李晓伟 on 17/2/24.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - 外网
//#define URL @"http://api.meiweiyun.cn/"

#define URL @"http://stock.meiweiyun.cn/"

// 图片地址
//http://fileservice.meiweiyun.cn

#pragma mark - 登录接口
#define URL_DengLU (URL@"api/AppIndex/Login?")

#pragma mark - 首页 获取店铺名称
#define URL_DianPu_Name (URL@"api/AppIndex/ShopName?")

#pragma mark - 首页 获取角色信息
#define URL_JueSe_Name (URL@"api/AppIndex/RoleName?")

#pragma mark - 首页 获取出入库金额
#define URL_ChuRuKu_JinE (URL@"api/AppIndex/getTodayMoney?")

#pragma mark - 采购订单 商品大类
#define URL_Dingda_DaLei (URL@"api/SwhMaterial/getSwhMPTypeList?")

#pragma mark - 采购订单 商品小类
#define URL_DingDa_XiaoLei (URL@"api/SwhMaterial/getSwhMTypeList?")

#pragma mark - 采购订单 商品名称
#define URL_DingDa_Name (URL@"api/SwhMaterial/getSwhMaterialListName?")

#pragma mark - 采购订单 - 原料详情
#define URL_DingDan_Y_XiangQing (URL@"api/SwhMaterial/getSwhmaterial?")

#pragma mark - 采购订单 订单内容详情
#define  URL_CaiGouDing_DingDan_Neirong (URL@"api/SwhOrderApply/getOrderApplydetailList?")

#pragma mark - 采购订单添加 
#define URL_CaiGouDingDan_TianJia (URL@"api/SwhOrderApply/AddOrderApplyDetail?")

#pragma mark - 采购订单 - 提交订单 审核
#define URL_Caigou_Dingdan_TiJiao (URL@"api/SwhOrderApply/AddOrderApply?")

#pragma mark - 采购订单 - 提交 订单详情
#define URL_TiJiao_DingDan_XiangQing (URL@"api/SwhOrderApply/SubmitApplydetail?")

#pragma mark - 物料入库 - 入库列表
#define URL_WuLiao_RuKu_List (URL@"api/SwhOrderApply/getOrderList?")

#pragma mark - 物料预警
#define URL_WuLiao_YuJing (URL@"api/SwhMaterial/MaterialOverList?")

#pragma mark - 物料入库
#define URL_FenDan_MingXi (URL@"api/SwhOrderApply/getSwhOrderApplydetailList?")

#pragma mark - 入库明细
#define URL_RuKuMingXi (URL@"api/SwhOrderApply/getOrderApplyNotCheck?")

#pragma mark - 整单入库
#define  URL_ZhengDan_RuKuYm (URL@"api/SwhOrderApply/AddZDOrderStorage?")

#pragma mark - 库房列表
#define  URL_KufangLieBiao (URL@"api/SwhWarehouse/getSwhWarehouseList?")

#pragma mark - 物料盘点
#define URL_WuLiao_PanDian (URL@"api/SwhOrderCheck/getSwhOrderCheckList?")

#pragma mark - 订单审核 
#define URL_DingDan_ShenHe (URL@"api/SwhOrderApply/getOrderApplyListChecking?")


#pragma mark - 物料退货  添加退货详情
#define URL_TUIHUO_TianJiaTuiHuo (URL@"api/SwhOrderRefunds/AddOrderApplyDetail?")

#pragma mark - 删除采购订单 购物车列表数据
#define URL_Detele_CaiGouDingDai_GouWUChe_LieBiao (URL@"api/SwhOrderApply/DeleteOrderApplyDetail?")

#pragma mark - 入库  已通过审核 主表
#define URL_CaiGou_YiTongGuoShenHe_ZhuBiao (URL@"api/SwhOrderApply/getOrderApply?")

#pragma mark - 入库 已通过审核 列表
#define URL_CaiGOu_YITongGuoShenHe_LieBiao (URL@"api/SwhOrderApply/getOrderApplyCheckedDetail?")

#pragma mark - 整单入库 详情添加
#define URL_ZhengDan_RuKU_TianJia_XiangQing (URL@"api/SwhOrderApply/SubmitZDOrderStoragedetail?")

#pragma mark - 分单入库  添加详情
#define URL_FenDanRuKu_TianJia_XiangQing (URL@"api/SwhOrderApply/SubmitOrderStoragedetail?")


#pragma mark - 未通过审核 - 页面 列表
#define URL_WeiTongGuoShenHe_YeMian_LieBiao (URL@"api/SwhOrderApply/getOrderApplyNotCheckDetail?")

#pragma mark - 库区
#define URL_KuQU_JieKou (URL@"api/SwhWarehouse/getSwhWarehouseList?")

#pragma mark - 获取供应商 列表
#define URL_GongYIngShang_LieBiao (URL@"api/SwhSupplier/getSupplierTypes?")

#pragma mark - 获取供应商 名称列表
#define URL_GongYIngshang_Name (URL@"api/SwhSupplier/getSupplierName?")

#pragma mark - 获取供应商结算 列表
#define URL_GongYingShangJieSuan (URL@"api/SwhSupplier/getSupplierList?")

#define mark - 入库主表 保存
#define URL_RuKuZhuBiao_BaoCun (URL@"api/SwhOrderApply/SumbitStorageByWhole?")

#pragma mark - 采购订单审核 - 入库
#define URL_CaiGouDingDan_ShenHe_RuKu_LieBiao (URL@"api/SwhOrderApply/getOrderApply?")

#pragma mark - 签字入库 
#define URL_QianZiRuKu (URL@"api/SwhOrderApply/Sign?")


#pragma mark - 出库 原料名称 确认按钮
#define URL_ChuKu_YuanLiaoMIngCheng_QuRen (URL@"api/SwhOrderInside/Addswhorderinside?")

#pragma mark - 出库 - 批量上传 领料
#define URL_ChuKU_LingLiao_PiLiang (URL@"api/SwhOrderInside/AddList?")

#pragma mark - 领料出库  购物车数据
#define URL_ChuKU_GouWuChe_SHUJU (URL@"api/SwhOrderInside/getSwhOrderinsidedetailList?")

#pragma mark - 领料出库 获取管理员 人名
#define URL_HuoquGuanLi_Name (URL@"api/Selmanager/getManagerList?")

#pragma mark - 领料出库  获取单个库存详情
#define URL_HuoQuDanGe_XiangQing (URL@"api/SwhOrderApply/getMaterialInfo?")

#pragma mark - 物料出库  退货订单
#define URL_WuLiaoChuKU_TuoHuoDingDan (URL@"api/SwhOrderRefunds/getSwhOrderApplyList?")

#pragma mark - 报损单列表
#define URL_BaoSun_LieBiao (URL@"api/SwhOrderLossRate/getDetailList?")

#pragma mark - 获取签名图片
#define  URL_Huoqu_QianMing_TuPian (URL@"api/SwhOrderApply/getSignImage?")

#pragma mark - 订单审核 - 允许采购
#define URL_DingDanShenHe_YunXuCaiGou (URL@"api/SwhOrderApply/SubmitOrderApplyChecked?")

#pragma mark - 入库 未通过审核列表
#define URL_RUKU_WeiTongGuoShenHeLEIBIAO (URL@"api/SwhOrderApply/getOrderApplyNotCheckDetail?")

#pragma mark - 获取计量单位列表
#define JILIANGDANWEI_LieBiao (URL@"api/SwhMaterial/getUnitList?")

#pragma mark - 根据管理员id获取库房列表
#define URL_GuanLiYuan_HuoQu_KUFANGLIEBIAO (URL@"api/Selmanager/getWarehouseListByManager?")

#pragma mark - 领料出库 签字
#define URL_LingLiaoChuKu_QianZi_URL (URL@"api/SwhOrderInside/SumbitShopCart?")

#pragma mark - 整单未提交
#define URL_Zhengdan_weiTiJiao (URL@"api/SwhOrderApply/getZDSwhOrderApplydetailList?")

#pragma mark - 订单审核 - 退货单列表
#define URL_DingdanShenHE_TuiHuoLieBiao (URL@"api/SwhOrderRefunds/getOrderList1?")

#pragma mark - 退货审核 - 退货详情 主表
#define URL_TuiHuoShenHe_XiangQing_ZhuBiao (URL@"api/SwhOrderRefunds/getOrder2?")

#pragma mark - 退货审核 - 退货详情  列表
#define URL_TuiHuoShenHe_TuiHuo_xiangQing_LieBiao (URL@"api/SwhOrderRefunds/getDetaiListCheck?")

#pragma mark - 退货审核 - 点击原料名称 获取 单个原料信息
#define URL_THSH_DianJiYuanLiaoMingCheng (URL@"api/SwhOrderRefunds/getMaterialDetai?")

#pragma mark - 订单 ID 生成
#define  URL_DingDan_ShengCheng (URL@"api/AppIndex/CreateOrderID?")

#pragma mark - 获取入库数量 和金额
#define URL_HuoQuRukuShuLiangHE_JinE (URL@"api/SwhOrderApply/getStorageCountAndMoney?")

#pragma mark - 出库 领料出库 领料详情
#define URL_ChuKu_LingLiao_XiangQing (URL@"api/SwhOrderInside/getOrderInside?")

#pragma mark - 出库  领料出库 领料详情列表
#define URL_ChuKu_LingLiao_XiangQingLieBiao (URL@"api/SwhOrderInside/getSwhOrderinsidedetailList?")

#pragma mark - 入库 选择结账方式
#define URL_JieZhangFangShi_HuoQu (URL@"api/SwhSupplier/getPaymentMode?")

#pragma mark - 物料退货 - 点击原料 添加退货单
#define URL_WuLiaoTuiHuo_DianJiYuanLiao_TianJia_TuoHuoDan (URL@"api/SwhOrderRefunds/AddOrderApplyDetail?")

#pragma mark - 物料出库 点击购物车 - 购物车列表
#define URL_DianJiGouWUCHe_LieBiao (URL@"api/SwhOrderRefunds/getDetaiList1?")

#pragma mark - 物料出库 点击购物车  批量提交 数据
#define URL_WuliaoChuKu_DianJiGouWuChe_PiLiangTIJIaoShuJu (URL@"api/SwhOrderRefunds/SubmitDetailList?")

#pragma mark - 出库 提交主表 保存
#define URL_ChuKUTIjiao_ZhuBiao_BaoCui (URL@"api/SwhOrderRefunds/SumbitShopCart?")

#pragma mark - 出库 - 退货详情 主表
#define URL_ChuKU_TuiHuo_XiangQing_ZhuBiao (URL@"api/SwhOrderRefunds/getOrder1?")

#pragma mark - 出库 - 退货详情 列表信息
#define URL_ChuKu_TuiHuo_XInaqing_Liebiao (URL@"api/SwhOrderRefunds/getDetaiList2?")

#pragma mark - 订单审核 退货审核  允许退货
#define URL_DingDanShenHe_YunXu_TuiHuo_ZHUBIao (URL@"api/SwhOrderRefunds/SubmitOrderCheckYes?")

#pragma mark - 订单审核 退货审核 允许退货 列表
#define URL_DingDanShenHe_yunXun_TuiHuo_LieBiao (URL@"api/SwhOrderRefunds/SubmitDetailCheck?")

#pragma mark - 订单审核  无需审核
#define URL_DingDanShenHe_WuXuShenHe (URL@"api/SwhOrderRefunds/SubmitOrderCheckNo?")

#pragma mark - 订单审核  允许退货 订单详情
#define URL_DIngDanShenHe_YunXuTuiHuo_Ding_XIangQing (URL@"api/SwhOrderRefunds/getOrderCheckedYes?")

#pragma mark - 物料退货 退货单
#define URL_WuLiaoTuiHuo_TuoHuiDan_LieBiao (URL@"api/SwhOrderRefunds/getOrderListChecked?")

#pragma mark - 退货单签字
#define URL_TuiHuoDan_qianZi (URL@"api/SwhOrderRefunds/Sign?")

#pragma mark - 物料报损 - 点击原料 - 材料信息
#define URL_WuLiaoBaoSun_DianJiYuanLiao_CaiLiaoXinXi (URL@"api/SwhOrderLossRate/getMaterialInfo?")

#pragma mark - 获取报损单金额
#define URL_BaoSunDan_JinE (URL@"api/SwhOrderLossRate/getMoneySumBudget?")

#pragma mark - 物料报损 - 点击原料 - 确认
#define URL_WuLiaoBaoSun_YuanLiao_QueRen (URL@"api/SwhOrderLossRate/AddDetail?")

#pragma mark - 物料报损 - 点击购物车 
#define URL_WULIAOBAOSUN_DIANJIGOUWUCHE (URL@"api/SwhOrderLossRate/getDetailBeforeSave?")

#pragma mark - 物料报损 - 点击购物车  批量提交
#define URL_WuLiaoBaoSun_DianJiGouWuChe_PiLiangTiJiao (URL@"api/SwhOrderLossRate/SubmitDetailList?")

#pragma mark - 物料报损 - 提交报损主表
#define URL_WuLiaoBaoSun_ZhuBiao_TiJiao (URL@"api/SwhOrderLossRate/SumbitShopCart?")

#pragma mark - 订单审核 - 报损 - 列表
#define URL_DingDanShenHe_BaoSun_LieBiao (URL@"api/SwhOrderLossRate/getListChecking?")

#pragma mark - 订单审核 - 报损单显示主表
#define URL_DIngDan_ShenHE_BaoSunDan_ZhuBiao (URL@"api/SwhOrderLossRate/getOrderChecking?")

#pragma mark - 订单审核 报损订单列表
#define URL_DingDanShenHe_BaoSunDIngDan_LIeBiao (URL@"api/SwhOrderLossRate/getDetailSave?")

#pragma mark - 订单审核  允许报损
#define URL_YunXu_BaoSun (URL@"api/SwhOrderLossRate/SubmitChecked?")

#pragma mark - 订单审核  无需报损
#define URL_WuXu_BaoSun (URL@"api/SwhOrderLossRate/SubmitNotCheck?")

#pragma mark - 盘点列表 
#define URL_PanDianLieBiao (URL@"api/SwhOrderCheck/getCheckList?")

#pragma mark - 盘点 - 添加盘点 - 选择原料列表
#define URL_PanDian_TianJia_XuanZeYuanLiao_LieBiao (URL@"api/SwhOrderCheck/getSearchList2?")

#pragma mark - 盘点 - 获取角色列表
#define URL_PanDian_HuoQu_JueSeLieBiao (URL@"api/Selmanager/getRoleList?")

#pragma mark - 根据角色获取管理员
#define URL_PanDian_HuoQuGuanLiYuan (URL@"api/Selmanager/getManagerByRole?")

#pragma mark - 盘点 -  待盘点 - 主表
#define URL_PanDian_DaiPanDian_zhuBiao (URL@"api/SwhOrderCheck/getOrderCheck?")

#pragma mark - 盘点 - 待盘点- 列表
#define URL_PanDian_DaiPanDian_LieBiao (URL@"api/SwhOrderCheck/getOrderCheckDetail?")

#pragma mark - 盘点 - 提交主表
#define URL_PanDian_TiJiao_ZhuBiao (URL@"api/SwhOrderCheck/AddSwhOrderCheck?")

#pragma mark - 盘点 待盘点列表 - 详情
#define URL_PanDian_DaiPaiDian_lieBiao_Xiangqing (URL@"api/SwhOrderCheck/getOrderCheckDetailWithUnit?")

#pragma mark - 首页 搜索
#define URL_ShouYe_SouSuo (URL@"api/AppIndex/Search?")

#pragma mark - 盘点 - 提交盘点单 主表
#define URL_PanDian_TiJiao_ZhuBiao (URL@"api/SwhOrderCheck/AddSwhOrderCheck?")

#pragma mark - 供应商 获取供应商结算总额
#define URL_GongYingShang_HuoquGOngYingshangJieSuan_Zonge (URL@"api/SwhSupplier/getSupplierTotal?")

#pragma mark - 供应商 供应商结算 列表
#define URL_GongYingShang_jiesuan_Gongyingshang_Liebiao (URL@"api/SwhSupplier/getSupplierTotalList?")

#pragma mark - 供应商 名称 - 本期付款
#define URL_Gongyingshang_Gongyingshang_mingCheng_FuKuan_URL (URL@"api/SwhSupplier/getOrderApplyTotal?")

#pragma mark - 供应商名称 - 进货单
#define URL_GongYingShang_MingCheng_JinHuoDan (URL@"api/SwhSupplier/getOrderApply?")

#pragma mark - 供应商名称 - 退货单
#define URL_GongYingShangMingCheng_TuiHuoDan (URL@"api/SwhSupplier/getOrderRefunds?")

#pragma mark - 供应商名称 - 付款单
#define URL_GongYingShang_mingCheng_FuKuan_Dan (URL@"api/SwhSupplier/getSupplierPayment?")

#pragma mark - 供应商名称 - 退货订单 - 详情
#define URL_GongYingShang_MingCheng_TuiHuoDingDan_XiangQing (URL@"api/SwhSupplier/getOrderRefunds?")

#pragma mark - 供应商结算 - 付款 - 结账
#define URL_GongYingShan_JieSuan_FuKuan_JieZhang (URL@"api/SwhSupplier/getSupplierPaymode?")

#pragma mark - 供应商结算 - 付款 - 提交
#define URL_GongYIngShangJieSuan_FuKuan_TiJiao (URL@"api/SwhSupplier/Payment?")

#pragma mark - 供应商结算 - 获取付款单结束列表
#define URL_GongYingShang_Jiesuan_JieShu_LieBiao_ZhuBiao (URL@"api/SwhSupplier/getSupplierPaymentByID?")

#pragma mark - 供应商结算 - 供应商名称 获取全部数据列表
#define URL_GongYingshang_Jiesuan_GongYingShangMingCheng_HuoQuQuanBu_Liebiao (URL@"api/SwhSupplier/getSupplierMoneyDetail_All?")

#pragma mark - 首页 订单 - 订单列表
#define URL_ShouYe_dingDan_LieBiao (URL@"api/IndexOrderApply/getOrderList?")

#pragma mark - 首页  订单 - 订单进度列表
#define URL_DingDan_DingDangLieBiao_JinDu (URL@"api/IndexOrderApply/getProgress?")

#pragma mark - 订单 领料调拨单
#define URL_DingDan_LingLiaoDiaoBoDan (URL@"api/IndexOrderInside/getOrderList?")

#pragma mark - 订单 - 报损单
#define URL_DingDan_BaoSunDan (URL@"api/IndexOrderLossRate/getOrderList?")

#pragma mark - 订单 - 报损单进度
#define URL_DingDan_BaoSuanDan_JinDu (URL@"api/IndexOrderLossRate/getProgress?")

#pragma mark - 订单 - 退货订单
#define URL_DingDan_TuiHuoDingDan (URL@"api/IndexOrderRefunds/getOrderList?")

#pragma mark - 订单 - 退货订单流程
#define URL_TUiHuoDingDan_LiuCheng (URL@"api/IndexOrderRefunds/getProgress?")

#pragma mark - 订单 - 盘点单
#define URL_DingDan_PanDianDan (URL@"api/IndexOrderCheck/getOrderList?")

#pragma mark - 订单 - 盘底单进度
#define URL_DingDan_PanDian_Jindu (URL@"api/IndexOrderCheck/getProgress")

#pragma mark - 统计 - 采购入库统计 - 入库总额
#define URL_TongJi_RUKuZongE (URL@"api/IndexOrderApply/getTotal?")

#pragma mark - 统计 - 采购入库统计 - 列表 - 主表
#define URL_TongJi_LieBiao_ZhuBiao (URL@"api/IndexOrderApply/getListByTime?")

#pragma mark - 统计 采购入库 - 搜索
#define URL_Tongji_CaiGOuRuKu_SouSuo (URL@"api/IndexOrderApply/getListBySearch?")

#pragma mark - 获取全部供应商名称
#define URL_GOngyingshangmingcheng (URL@"api/SwhSupplier/getSimpleList?")

#pragma mark - 统计 - 出库统计总额
#define URL_TongJi_ChuKuTongJi_ZongE (URL@"api/IndexOrderAutoOutSide/getTotal?")

#pragma mark - 统计 - 出库统计总表
#define URL_TongJi_ChuKu_HuiZong_ZhuBiao (URL@"api/IndexOrderAutoOutSide/getListByTime?")

#pragma mark - 统计 - 出库统计搜索提交
#define URL_TongJi_ChuKuSouSuo_TiJiao (URL@"api/IndexOrderAutoOutSide/getListBySearch?")

#pragma mark - 统计 - 出库统计领料总表
#define URL_TongJi_ChuKu_Lingliao_Zongbiao (URL@"api/IndexOrderInside/getListByTime?")

#pragma mark - 统计 - 出库统计退货总表
#define URL_TongJi_ChuKu_TuiHui_ZongBiao (URL@"api/IndexOrderRefunds/getListByTime?")

#pragma mark - 统计 - 出库统计报损总表
#define URL_TongJi_BaoSun_ZongBiao (URL@"api/IndexOrderLossRate/getListByTime?")

#pragma mark - 统计 - 耗损统计总表
#define URL_TongJi_HaoSun_TongJi_BiaoBiao (URL@"api/IndexOrderLossRate/getListByTime?")

#pragma mark - 统计 - 耗损统计总额
#define URL_HaoSun_TongJi_ZongE (URL@"api/IndexOrderLossRate/getTotal?")

#pragma mark - 统计 耗损搜索提交
#define URL_HaoSun_TongJi_SouSuo_TiJiao (URL@"api/IndexOrderLossRate/getListBySearch?")

#pragma mark - 统计 盘点统计总额
#define URL_PandianTongJi_ZongE (URL@"api/IndexOrderCheck/getTotal?")

#pragma mark - 统计 盘点统计总表
#define URL_PandianTongJi_ZongBiao (URL@"api/IndexOrderCheck/getListByTime?")

#pragma mark - 统计搜索提交
#define URL_TongJiSouSuoTiJiao (URL@"api/IndexOrderCheck/getListBySearch?")

#pragma mark- 修改密码
#define URL_xiugaimima (URL@"api/Selmanager/ModifyPwd?")

#pragma mrk - 获取体验账号密码
#define URL_Huo_Qu_TiYan_ZhangHao_MiMa (URL@"api/AppIndex/getTestUser?")

#pragma mark - 订单 - 出库单修改
#define URL_DingDan_ChuKuDan_XiuGai (URL@"api/IndexOrderAutoOutSide/getOrderList?")

#pragma mark - 采购订单 - 统一提交订单购物车信息
#define URL_CaiGouDingDan_TongYi_DingDan_GouWuChe (URL@"api/SwhOrderApply/SumbitShopCart?")

#pragma  mark - 采购入库 统一提交
#define URL_CaiGouRuKu_TongyiTiJiao (URL@"api/SwhOrderApply/SumbitStorageByWhole?")

#pragma mark - 采购入库 - 修改 - 获取供应商名称
#define URL_CaiGouRuKu_HuoQu_GongYIngSHangMingCheng_XiuGai (URL@"api/SwhSupplier/getSupplierName?")

#pragma mark - 获取商家管理员
#define URL_HuoQuShangJia_GuanLiYuan (URL@"api/Selmanager/getManagerByWarehouse?")

#pragma mark - 供应商结算 - 供应商名称详情获取总欠金额 
#define URL_GongYIngshangJieSuan_GongYingShangMingChengZongQianJInE (URL@"api/SwhSupplier/getSupplierName?")

#pragma mark - 物料预警 - 搜索
#define URL_WuLiaoYuJing_SouSuo (URL@"api/SwhMaterial/MaterialOverListSearch?")

#pragma mark - 统计 库存统计- 金额
#define URL_TongJi_KuCun_TongJi_JinE (URL@"api/IndexStock/getTotal_Stock?")

#pragma mark - 统计 库存统计 - 列表
#define URL_TongJI_kuCun_Liebiao_SSSSS (URL@"api/IndexStock/getListBySearch_Stock?")

#pragma mark - 统计  - 进销核算统计 - 总额
#define URL_TongJi_JinXiaoHeSuanTongJi_ZongE (URL@"api/IndexStock/getTotalBySearch_ApplyAutoSide?")

#pragma mark - 统计 - 进校核算统计 - 列表 
#define URL_TongJI_JInxiaoHeshuan_LieBiao (URL@"api/IndexStock/getListByTime_ApplyAutoSide?")

#pragma mark - 统计 - 进销核算统计 - 搜索
#define URL_TongJi_JinXiaoHeSuan_SouSuo (URL@"api/IndexStock/getListBySearch_ApplyAutoSide?")

#pragma mark - 物料盘点 - 点击盘点完成
#define URL_WuLiaoPanDian_DianJiPanDianWanCheng (URL@"api/SwhOrderCheck/SaveOrderCheck?")

#pragma mark - 供应商结算搜索
#define URL_GongYingShang_JieSuan_SouSuo (URL@"api/SwhSupplier/getSupplierTotalListBySearch?")

#pragma mark - 物料入库 - 物料入库详情主表
#define URL_WuLiao_RuKu_RuKu_XiangQing_ZhuBiao (URL@"api/SwhOrderApply/getOrderApplyChecked?")

#pragma mark - 物料报损保存完成 - 主表
#define URL_WuLiao_BaoSun_BaoCun_WanCheng_ZhuBiao (URL@"api/SwhOrderLossRate/getOrderSave?")

#pragma mark - 物料报损保存完成 - 列表
#define URL_WuLiao_baoSuan_BaoCun_WanCheng_LieBiao (URL@"api/SwhOrderLossRate/getDetailSave?")

#pragma mark - 领料调拨点进度详情
#define URL_LingLiaoDiaoBo_JinDuXiangQing (URL@"api/IndexOrderInside/getProgress?")

#pragma mark - 根据库房 获取全部材料
#define URL_KuFang_Huoqu_QuanBu_CanLiao (URL@"api/SwhMaterial/getSwhMaterialListNameByType_Warehouse?")

#pragma mark - 查询库存流水
#define URL_ChaXun_KuCun_LiuShui (URL@"api/IndexStock/postListBySearch_StockDetail?")

#pragma mark - 库存统计 查询材料详情
#define URL_KuCun_TongJi_ChaXun_CaiLiao_XiangQing (URL@"api/SwhMaterial/postMaterialDetail?")

#pragma mark - 盘点矫正 获取主表
#define URL_PanDian_JiaoZheng_HuoQu_ZhuBiao (URL@"api/SwhOrderCheck/PostCheckMain?")

#pragma mark - 盘点矫正  详情列表
#define URL_PanDian_JiaoZheng_XiangQing_LieBiao (URL@"api/SwhOrderCheck/PostCheckChild?")

#pragma mark - 获取供应商列表 - 总额
#define URL_HuoQu_GongYingLieBiao_List_ZongE (URL@"api/SwhSupplier/getListByType?")

#pragma mark - 出库统计 - 领料总额
#define URL_ChuKu_TongJi_LingLiaoZongE_Zonge (URL@"api/IndexOrderInside/getTotal?")

#pragma mark - 出库统计 - 退货总额
#define URL_ChuKu_TongJi_TuiHuo_ZongE_ZongE (URL@"api/IndexOrderRefunds/getTotal?")

#pragma mark - 出库统计 - 报损统计列表
#define URL_ChuKuTongJi_BaoSun_TongJi_Liebiao (URL@"api/IndexOrderLossRate/getListByTime_LossRate?")

#pragma mark - 出库统计 - 报损统计- 报损总额
#define URL_ChuKuTongJi_HaoSun_TongJi_BaoSun_ZongE (URL@"api/IndexOrderLossRate/getTotal_LossRate?")

#pragma mark - 整单入库 - 整单保存 - 详情
#define URL_ZhengDan_RuKu_ZhengDan_BaoCun_XiangQing_ZhuBiao (URL@"api/SwhOrderApply/getOrderStorage01?")



#endif /* Header_h */
