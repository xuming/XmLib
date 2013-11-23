//
//  AvPlayerLooper.m
//  HimeLib
//
//  Created by  on 12-7-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AvPlayerLooper.h"
@implementation AvPlayerLooper
@synthesize player=__player;
@synthesize fileNameQueue;
@synthesize delegate;

- (id)initWithFileNameQueue:(NSArray*)queue {
    if ((self = [super init])) {
        self.fileNameQueue = queue;
        index = 0;
        //[self play:index];
    }
    return self;
}



- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)_player successfully:(BOOL)flag {
    if (index < fileNameQueue.count) {
        [self play:index];
    } else {
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(AvPlayerLooperDidFinishPlaying:successfully:)]) {
            [self.delegate AvPlayerLooperDidFinishPlaying:_player successfully:flag];
        }
        //reached end of queue
    }
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)_player error:(NSError *)error
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(AvPlayerLooperDidFinishPlaying:successfully:)]) {
        [self.delegate AvPlayerLooperDidFinishPlaying:_player successfully:false];
    }
}

- (void)play:(int)i {
    //NSURL *url=[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:[fileNameQueue objectAtIndex:i] ofType:nil]];
    NSURL *url=[[NSURL alloc] initFileURLWithPath:[fileNameQueue objectAtIndex:i]];
    
    AVAudioPlayer * nplayer=[[AVAudioPlayer alloc] 
                             initWithContentsOfURL:url error:nil];
   
    self.player = nplayer;
    
  
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play]; 
    index=i+1;
}

- (void)stop {
    if (self.player.playing) [self.player stop];
}

- (void)dealloc {
    self.fileNameQueue = nil;
    self.player = nil;        
   
}

@end

