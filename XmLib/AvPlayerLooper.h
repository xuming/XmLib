//
//  AvPlayerLooper.h
//  HimeLib
//
//  Created by  on 12-7-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



@protocol AvPlayerLooperDelegate <NSObject>
@optional
- (void)AvPlayerLooperDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;

@end


@interface AvPlayerLooper : NSObject <AVAudioPlayerDelegate> {
    //AVAudioPlayer* player;
    //NSArray* fileNameQueue;
    int index;
}
@property(nonatomic,strong) id<AvPlayerLooperDelegate> delegate;
@property (nonatomic, retain) AVAudioPlayer* player;
@property (nonatomic, retain) NSArray* fileNameQueue;

- (id)initWithFileNameQueue:(NSArray*)queue;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
- (void)play:(int)i;
- (void)stop;


@end