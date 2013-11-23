//
//  HMUtil.h
//  iSmart
//
//  Created by simon on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKIT/UILabel.h>

/*
 *  System Versioning Preprocessor Macros
 */ 

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#ifndef DEVICE_IS_IPAD
#define DEVICE_IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#endif
#ifndef DEVICE_IS_IPHONE
#define DEVICE_IS_IPHONE  (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
#endif

@interface HMUtil : NSObject {
}
+(void) playSystemSound:(NSString *) name ofType:(NSString * ) oftype;
+(void) ShowAlert:(NSString*)message withTitle:(NSString*)title;    
+(NSString *) GetIpByDomain:(NSString *) domain;
+ (BOOL) isConnectedToNetwork;
+(NSString * ) getAppVersion;
+(NSString*) getDisplayName;
+(UIColor*)colorFromHexString:(NSString *)hexString;
@end

@interface NSString (UUID)
+ (NSString*) stringWithUUID  ;
@end


@interface  UILabel (autosize)
-(void)resizeToStretch;
-(float)expectedWidth;
- (void)adjustHeight;
@end
