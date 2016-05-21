//
//  CHRPublishObjData.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishObjData.h"

@implementation CHRPublishObjData

+ (NSArray *)publishDataWithType:(CHRPublishFoodArrType)type{
    NSArray * dataArr = nil;
    switch (type) {
        case CHRPublishFoodGongYi:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"扒" getID:@"112"],[CHRPublishObjGetDic dicGetTittle:@"拔丝" getID:@"113"],[CHRPublishObjGetDic dicGetTittle:@"爆" getID:@"114"],[CHRPublishObjGetDic dicGetTittle:@"糖蘸" getID:@"119"],[CHRPublishObjGetDic dicGetTittle:@"汆" getID:@"123"],[CHRPublishObjGetDic dicGetTittle:@"炖" getID:@"124"],[CHRPublishObjGetDic dicGetTittle:@"烩" getID:@"127"],[CHRPublishObjGetDic dicGetTittle:@"煎" getID:@"129"],[CHRPublishObjGetDic dicGetTittle:@"烤" getID:@"130"],[CHRPublishObjGetDic dicGetTittle:@"酱" getID:@"132"],[CHRPublishObjGetDic dicGetTittle:@"腊" getID:@"133"],[CHRPublishObjGetDic dicGetTittle:@"腌" getID:@"134"],[CHRPublishObjGetDic dicGetTittle:@"冻" getID:@"136"],[CHRPublishObjGetDic dicGetTittle:@"卤" getID:@"138"],[CHRPublishObjGetDic dicGetTittle:@"熏" getID:@"139"],[CHRPublishObjGetDic dicGetTittle:@"炝" getID:@"140"],[CHRPublishObjGetDic dicGetTittle:@"拌" getID:@"141"],[CHRPublishObjGetDic dicGetTittle:@"熘" getID:@"142"],[CHRPublishObjGetDic dicGetTittle:@"焖" getID:@"144"],[CHRPublishObjGetDic dicGetTittle:@"煲" getID:@"147"],[CHRPublishObjGetDic dicGetTittle:@"砂锅" getID:@"148"],[CHRPublishObjGetDic dicGetTittle:@"烧" getID:@"149"],[CHRPublishObjGetDic dicGetTittle:@"炸" getID:@"153"],[CHRPublishObjGetDic dicGetTittle:@"蒸" getID:@"156"],[CHRPublishObjGetDic dicGetTittle:@"炒" getID:@"192"],[CHRPublishObjGetDic dicGetTittle:@"灼" getID:@"193"],[CHRPublishObjGetDic dicGetTittle:@"煮" getID:@"194"],[CHRPublishObjGetDic dicGetTittle:@"烘焙" getID:@"220"],[CHRPublishObjGetDic dicGetTittle:@"微波" getID:@"251"],[CHRPublishObjGetDic dicGetTittle:@"烙" getID:@"252"],[CHRPublishObjGetDic dicGetTittle:@"榨汁" getID:@"253"],[CHRPublishObjGetDic dicGetTittle:@"干锅" getID:@"255"],[CHRPublishObjGetDic dicGetTittle:@"泡" getID:@"256"],[CHRPublishObjGetDic dicGetTittle:@"干瘪" getID:@"260"],[CHRPublishObjGetDic dicGetTittle:@"煨" getID:@"261"],[CHRPublishObjGetDic dicGetTittle:@"焗" getID:@"262"],[CHRPublishObjGetDic dicGetTittle:@"其他" getID:@"259"]];
            break;
        case CHRPublishFoodKouWei:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"咸鲜味" getID:@"160"],[CHRPublishObjGetDic dicGetTittle:@"葱香味" getID:@"162"],[CHRPublishObjGetDic dicGetTittle:@"豆瓣味" getID:@"164"],[CHRPublishObjGetDic dicGetTittle:@"怪味" getID:@"165"],[CHRPublishObjGetDic dicGetTittle:@"果味" getID:@"165"],[CHRPublishObjGetDic dicGetTittle:@"红油味" getID:@"167"],[CHRPublishObjGetDic dicGetTittle:@"家常味" getID:@"168"],[CHRPublishObjGetDic dicGetTittle:@"姜汁味" getID:@"169"],[CHRPublishObjGetDic dicGetTittle:@"酱香味" getID:@"170"],[CHRPublishObjGetDic dicGetTittle:@"椒麻味" getID:@"171"],[CHRPublishObjGetDic dicGetTittle:@"芥末味" getID:@"172"],[CHRPublishObjGetDic dicGetTittle:@"咖喱味" getID:@"173"],[CHRPublishObjGetDic dicGetTittle:@"苦香味" getID:@"174"],[CHRPublishObjGetDic dicGetTittle:@"麻酱味" getID:@"176"],[CHRPublishObjGetDic dicGetTittle:@"麻辣味" getID:@"177"],[CHRPublishObjGetDic dicGetTittle:@"茄汁味" getID:@"179"],[CHRPublishObjGetDic dicGetTittle:@"酸辣味" getID:@"180"],[CHRPublishObjGetDic dicGetTittle:@"酸甜味" getID:@"182"],[CHRPublishObjGetDic dicGetTittle:@"蒜香味" getID:@"183"],[CHRPublishObjGetDic dicGetTittle:@"甜味" getID:@"185"],[CHRPublishObjGetDic dicGetTittle:@"五香味" getID:@"186"],[CHRPublishObjGetDic dicGetTittle:@"香辣味" getID:@"187"],[CHRPublishObjGetDic dicGetTittle:@"鱼香味" getID:@"188"],[CHRPublishObjGetDic dicGetTittle:@"奶香味" getID:@"257"],[CHRPublishObjGetDic dicGetTittle:@"黑椒味" getID:@"264"],[CHRPublishObjGetDic dicGetTittle:@"糊辣味" getID:@"265"],[CHRPublishObjGetDic dicGetTittle:@"酸味" getID:@"266"],[CHRPublishObjGetDic dicGetTittle:@"其他" getID:@"189"]];
            break;
        case CHRPublishFoodNanDu:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"新手尝试" getID:@"1"],[CHRPublishObjGetDic dicGetTittle:@"初级入门" getID:@"2"],[CHRPublishObjGetDic dicGetTittle:@"初中水平" getID:@"3"],[CHRPublishObjGetDic dicGetTittle:@"中级掌勺" getID:@"4"],[CHRPublishObjGetDic dicGetTittle:@"高级厨师" getID:@"5"],[CHRPublishObjGetDic dicGetTittle:@"特级厨师" getID:@"6"]];
            break;
        case CHRPublishFoodZBShijian:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"5分钟" getID:@"1"],[CHRPublishObjGetDic dicGetTittle:@"10分钟" getID:@"2"],[CHRPublishObjGetDic dicGetTittle:@"15分钟" getID:@"3"],[CHRPublishObjGetDic dicGetTittle:@"30分钟" getID:@"4"],[CHRPublishObjGetDic dicGetTittle:@"60分钟" getID:@"5"],[CHRPublishObjGetDic dicGetTittle:@"90分钟" getID:@"6"],[CHRPublishObjGetDic dicGetTittle:@"2小时" getID:@"7"],[CHRPublishObjGetDic dicGetTittle:@"数小时" getID:@"8"],[CHRPublishObjGetDic dicGetTittle:@"一天" getID:@"9"],[CHRPublishObjGetDic dicGetTittle:@"数天" getID:@"10"]];
            break;
        case CHRPublishFoodPRShijian:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"<5分钟" getID:@"1"],[CHRPublishObjGetDic dicGetTittle:@"10分钟" getID:@"2"],[CHRPublishObjGetDic dicGetTittle:@"<15分钟" getID:@"3"],[CHRPublishObjGetDic dicGetTittle:@"<30分钟" getID:@"4"],[CHRPublishObjGetDic dicGetTittle:@"<60分钟" getID:@"5"],[CHRPublishObjGetDic dicGetTittle:@"<90分钟" getID:@"6"],[CHRPublishObjGetDic dicGetTittle:@"<2小时" getID:@"7"],[CHRPublishObjGetDic dicGetTittle:@"<数小时" getID:@"8"],[CHRPublishObjGetDic dicGetTittle:@"<一天" getID:@"9"],[CHRPublishObjGetDic dicGetTittle:@"<数天" getID:@"10"]];
            break;
        case CHRPublishFoodRenShu:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"1人份" getID:@"1"],[CHRPublishObjGetDic dicGetTittle:@"2人份" getID:@"2"],[CHRPublishObjGetDic dicGetTittle:@"3人份" getID:@"3"],[CHRPublishObjGetDic dicGetTittle:@"4人份" getID:@"6"],[CHRPublishObjGetDic dicGetTittle:@"5人份" getID:@"4"],[CHRPublishObjGetDic dicGetTittle:@"未知" getID:@"5"]];
            break;
        case CHRPublishFoodGuiGe:
            dataArr = @[[CHRPublishObjGetDic dicGetTittle:@"克" getID:@"1"],[CHRPublishObjGetDic dicGetTittle:@"毫升" getID:@"2"],[CHRPublishObjGetDic dicGetTittle:@"个" getID:@"3"],[CHRPublishObjGetDic dicGetTittle:@"只" getID:@"4"],[CHRPublishObjGetDic dicGetTittle:@"条" getID:@"5"],[CHRPublishObjGetDic dicGetTittle:@"块" getID:@"6"],[CHRPublishObjGetDic dicGetTittle:@"颗" getID:@"7"],[CHRPublishObjGetDic dicGetTittle:@"勺" getID:@"8"]];
            break;
        default:
            break;
    }
    
    return dataArr;
}



@end
