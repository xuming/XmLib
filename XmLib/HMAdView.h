//
//  HMAdView.h
//  HimeLib
//
//  Created by  on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/ADBannerView.h>
#import "GADBannerView.h"

typedef enum
{
    ADViewTypeAuto=0 ,
    ADViewTypeIAD=1,
    ADViewTypeADMob=2
    
} HMADViewType;

/**自定义广告对象

- 同时支持Admob和iAd
- 根据时区不同自动选择使用那个广告

*/
@interface HMAdView : UIView<ADBannerViewDelegate>{

}

///iAd广告条
@property (nonatomic,retain) ADBannerView * iAdView;
///adMob广告条
@property(retain) GADBannerView * iGAdView;

@property(nonatomic,assign) HMADViewType adType;
///使用admob时必须指定rootViewController
@property (nonatomic, assign) UIViewController *rootViewController;
///admob adUnitID 使用admob时必须指定
@property(nonatomic,retain) NSString *  adMobAdUnitID;
///是否测试模式
@property(nonatomic,assign) BOOL testing;

@property(nonatomic,retain) NSMutableArray * testDevices;

///处理广告
- (void)disposeAds: (BOOL)forkids;
- (void)addTestDevice:(NSString *)deviceId;
@end
