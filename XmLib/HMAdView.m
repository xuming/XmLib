//
//  HMAdView.m
//  HimeLib
//
//  Created by  on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HMAdView.h"
#import <iad/ADBannerView.h>
#import "GADBannerView.h"
#import "GADAdMobExtras.h"
#import "HMUtil.h"
@implementation HMAdView
@synthesize iAdView;
@synthesize iGAdView;
@synthesize rootViewController=_rootViewController;
@synthesize adMobAdUnitID=_adMobAdUnitID;
@synthesize adType=_adType;
@synthesize testing=_testing;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _adMobAdUnitID=@"a14f98c67f3d5ce";
        _testing=NO;
    }
    return self;
}

- (void)disposeAds: (BOOL)forkids {
    
    BOOL is_iAdON = NO;
    BOOL is_adMobON = NO;
    switch (_adType) {
       
        case ADViewTypeIAD:
            is_iAdON=YES;
            break;
            
        case ADViewTypeADMob:
            is_adMobON=YES;
            break;
        default:
            
            break;
    }
    
    //如果没指定使用那个广告服务,则自动匹配
    if (!(is_iAdON ||is_adMobON)) {
        //分析设备可显示哪一家广告
        if(DEVICE_IS_IPAD) {
            is_adMobON = YES;
            if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.2f) {
                //为iPad 4.2之后的系统显示iAd广告
                //如果是北美国时间或太平洋时间，则假想是美国用户
                //2010.12 英国，法国
                //2011.1  德国
                //2011.?  日本
                if([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location== 0
                   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location== 0
                   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/"].location== 0
                   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Tokyo"].location== 0)
                {
                    is_adMobON = NO;
                }
            }
        }
        else if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0f) {
            //如果是北美国时间或太平洋时间，则假想是美国用户
            //2010.12 英国，法国
            //2011.1  德国
            //2011.?  日本
            if([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location== 0
               || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location== 0
               || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/"].location== 0
               || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Tokyo"].location== 0)
            {
                is_adMobON = NO;
            }
            else
                is_adMobON = YES;
        }
        else
            is_adMobON = YES;  
        
        if(!is_adMobON)
        {
            //随机显示iAD和adMob
            if(arc4random()  %2 ==0)
            {
                is_iAdON = YES;
            }else
            {
                is_adMobON=YES;
            }
        }
    }
   
    
    
    
    
    //检测购买(这个为程序内购买了“去除广告”功能的把广告清除或是不显示，removeAdPurchased是个变量，本文未讨论)
    //if(removeAdPurchased) {
    //    is_adMobON = NO;
    //    is_iAdON = NO;
    //}
    
    //打开广告
    if(is_adMobON || is_iAdON) {
        if(is_adMobON) {
            //启用AdMob
            if(!iGAdView) {
                
                
                CGSize sizeToRequest;
                if(DEVICE_IS_IPAD)
                    sizeToRequest =  kGADAdSizeLeaderboard.size;
                else
                    sizeToRequest = kGADAdSizeBanner.size;
                
                GADBannerView* bannerView_ = [[GADBannerView alloc]
                                              initWithFrame:CGRectMake(0.0,
                                                                       0.0,
                                                                       sizeToRequest.width,
                                                                       sizeToRequest.height)];
                
                // 指定广告的“单元标识符”，也就是您的 AdMob 发布商 ID。
                bannerView_.adUnitID =_adMobAdUnitID; //MY_BANNER_UNIT_ID;
                
                // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController 
                // 并将其添加至视图层级结构。
                
                bannerView_.rootViewController =_rootViewController;
                [self addSubview:bannerView_];
                
                GADRequest *request = [GADRequest request];
                if (forkids)
                {
                    
           
                                               
                    
                    GADAdMobExtras *extras = [[GADAdMobExtras alloc] init];
                    extras.additionalParameters =
                    [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     @"1", @"tag_for_child_directed_treatment",
                     nil];
                    
                    [request registerAdNetworkExtras:extras];
                  

                }
                // Make the request for a test ad. Put in an identifier for the simulator as
                // well as any devices you want to receive test ads.
                //request.testDevices =
                //[NSArray arrayWithObjects:
                // GAD_SIMULATOR_ID,
                // @"1ae0eaaae8062f767c915571e26ed374",
                 
                 // TODO: Add your device/simulator test identifiers here. They are
                 // printed to the console when the app is launched.
                // nil];
                
                request.testing=_testing;
                self.iGAdView=bannerView_;
                
                
                
                // 启动一般性请求并在其中加载广告。
                [bannerView_ loadRequest:request];
               
                
                
            }
        }
        else {
            //启用iAd
            if(!iAdView) {
                iAdView= [[ADBannerView alloc]   initWithFrame:CGRectZero];
                 
                //iAdView.requiredContentSizeIdentifiers= [NSSet setWithObject: ADBannerContentSizeIdentifierPortrait];
                //iAdView.currentContentSizeIdentifier= ADBannerContentSizeIdentifierPortrait;
          
                /*CGSize sizeToRequest= [ADBannerView sizeFromBannerContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
                
                iAdView.frame = CGRectMake(0, 0, sizeToRequest.width, sizeToRequest.height);
                */
                
                iAdView.delegate = self;
                [self addSubview:iAdView];
                iAdView.hidden= YES; //暂时不显示广告框，收到广告后再显示出来
            }
        }
    }
    else{
        //关闭广告
        if(iGAdView) {
            //关闭AdMob
            [iGAdView removeFromSuperview];
            //[iGAdView release];
            self.iGAdView = nil;
        }
        else if(iAdView) {
            //关闭iAd(bannerIsVisible是个变量，用于标识iAd广告是否已经显示内容，可不用)
            //if(bannerIsVisible) 
            {
                [UIView beginAnimations:@"animateAdBannerOff"context:NULL];
                if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location== 0)
                    iAdView.frame = CGRectOffset(iAdView.frame, 0, 66);
                else
                    iAdView.frame = CGRectOffset(iAdView.frame, 0, 50);
                
                [UIView commitAnimations];
                //bannerIsVisible= NO;
                iAdView.hidden = YES;
            }
            
            
            [iAdView removeFromSuperview];
           
            iAdView = nil;
        }
    }
}


#pragma mark ADBannerView Delegate

// 广告读取过程中出现错误
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError * )error{
    // 切换ADBannerView表示状态，显示→隐藏
    // adView.frame = CGRectOffset(adView.frame, 0, self.view.frame.size.height);
}

// 成功读取广告
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    // 切换ADBannerView表示状态，隐藏→显示
    // adView.frame = CGRectOffset(adView.frame, 0, self.view.frame.size.height - adView.frame.size.height);
    banner.hidden=NO;
}

// 用户点击广告是响应，返回值BOOL指定广告是否打开
// 参数willLeaveApplication是指是否用其他的程序打开该广告
// 一般在该函数内让当前View停止，以及准备全画面表示广告
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    NSLog(@"bannerViewActionShouldBegin:willLeaveApplication: is called.");
    return YES;
}

// 全画面的广告表示完了后，调用该接口
// 该接口被调用之后，当前程序一般会作为后台程序运行
// 该接口中需要回复之前被中断的处理（如果有的话）
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"bannerViewActionDidFinish: is called.");
}

@end
