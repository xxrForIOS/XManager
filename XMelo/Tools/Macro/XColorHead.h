//
//  XColorHead.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#ifndef XColorHead_h
#define XColorHead_h


#pragma mark- COLOR
#define kColorRGB(r,g,b)    [UIColor colorWithRed:(CGFloat) r/255.0 green:(CGFloat) g/255.0 blue:(CGFloat) b/255 alpha:1]
#define kColorRandom        [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
#define kColorHex(h)        [UIColor colorWithRed:((float)((h&0xFF0000)>>16))/255.0 green:((float)((h&0xFF00)>>8))/255.0 blue:((float)(h&0xFF))/255.0 alpha:1]

#define kColorIceBlue       kColorRGB(169, 255, 255)
#define kColorIceBlue1      kColorRGB(35, 177, 200)

#define kColor_yanzhi       kColorRGB(157,41,50)            //胭脂
#define kColor_yabai        kColorRGB(239,222,176)          //牙白
#define kColor_zhuqing      kColorRGB(120,146,98)           //竹青
#define kColor_dai          kColorRGB(73,65,102)            //黛
#define kColor_qiuxiangqi   kColorRGB(217,182,18)           //秋香气
#define kColor_chabai       kColorRGB(243,248,241)          //茶白
#define kColor_dianqing     kColorRGB(23,124,176)           //靛青
#define kColor_yaqing       kColorRGB(66,75,80)             //鸦青
#define kColor_tan          kColorRGB(179,109,97)           //檀
#define kColor_chi          kColorRGB(195,39,43)            //赤
#define kColor_wan          kColorRGB(169,129,117)          //绾
#define kColor_shuiqing     kColorRGB(212,242,232)          //水绿
#define kColor_yan          kColorRGB(255,51,0)             //炎
#define kColor_li           kColorRGB(118,102,77)           //黎
#define kColor_aiqing       kColorRGB(163,226,197)          //艾青
#define kColor_dailan       kColorRGB(65,80,101)            //黛蓝
#define kColor_yuebai       kColorRGB(215,236,241)          //月白
#define kColor_feise        kColorRGB(237,87,254)           //妃色
#define kColor_tuose        kColorRGB(168,132,98)           //妃色

#endif /* XColorHead_h */
