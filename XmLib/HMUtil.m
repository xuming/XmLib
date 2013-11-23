//
//  HMUtil.m
//  iSmart
//
//  Created by simon on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HMUtil.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netdb.h>
#import <arpa/inet.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <UIKIT/UIAlert.h>
//#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation HMUtil


+(void) playSystemSound:(NSString *) name ofType:(NSString * ) oftype
{
    SystemSoundID mySound;
    //Get path of VICTORY.WAV <-- the sound file in your bundle
    NSString* soundPath = [[NSBundle mainBundle] pathForResource:name ofType:oftype];
    //If the file is in the bundle
    if (soundPath) {
        //Create a file URL with this path
        NSURL* soundURL = [NSURL fileURLWithPath:soundPath];
        
        //Register sound file located at that URL as a system sound
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &mySound);
        
        if (err != kAudioServicesNoError) {
            NSLog(@"Could not load %@, error code: %d", soundURL, (int)err);
        }
        AudioServicesPlaySystemSound(mySound);
    }
}


+(void)ShowAlert:(NSString *)message withTitle:(NSString *)title
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil)  otherButtonTitles:nil, nil];
    [alert show];
   
}

+(NSString *) GetIpByDomain:(NSString *) domain;
{
    
    struct hostent *remoteHostEnt = gethostbyname([domain cStringUsingEncoding:NSASCIIStringEncoding]);
    if (remoteHostEnt==nil) {
        return nil;
    }
    // Get address info from host entry
    if(remoteHostEnt->h_addr_list==nil)
    {
        return nil;
    }
    struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
    
    // Convert numeric addr to ASCII string
    char * sRemoteAddress=inet_ntoa(*remoteInAddr);
    return   [NSString stringWithCString:sRemoteAddress encoding:NSASCIIStringEncoding];

}

+ (BOOL) isConnectedToNetwork
{
    
    //NSString * strAddress=[NSString  stringWithString:@"192.168.1.160"];
    // Create zero addy
    struct sockaddr_in address;
    
    
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    //address.sin_addr.s_addr = inet_addr([strAddress UTF8String]);  // 把字符串的地址转换为机器可识别的网络地址
    
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
+(NSString *)getAppVersion
{
    return [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}
+(NSString *)getDisplayName
{
    return [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
}
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];// bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end

@implementation NSString(UUID)
+(NSString *)stringWithUUID
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

@end 


@implementation UILabel (dynamicSizeMeWidth)

-(void)resizeToStretch{
    float width = [self expectedWidth];
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

-(float)expectedWidth{
    [self setNumberOfLines:1];
    
    CGSize maximumLabelSize = CGSizeMake(9999,self.frame.size.height);
    
   
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font] 
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]]; 
    return expectedLabelSize.width;
}

- (void)adjustHeight {
    
    if (self.text == nil) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, 0);
        return;
    }
    
    CGSize aSize = self.bounds.size;
    CGSize tmpSize = CGRectInfinite.size;
    tmpSize.width = aSize.width;
    
    tmpSize = [self.text sizeWithFont:self.font constrainedToSize:tmpSize];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, aSize.width, tmpSize.height);
}

@end

