//
//  ManagerFile.h
//  iTheate
//
//  Created by  on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerFile : NSObject
{
    
}
+(void)writeFile:(NSString *)file withFileName:(NSString *) filename;
+(void)writeFile:(NSData *)data withDataFileName:(NSString *) filename;

+(NSString *)readFile:(NSString *) filename;
+(NSData *)readFileData:(NSString *) filename;
+(BOOL) fileExists:(NSString *) filename;
+(NSString *)getFileByFileName:(NSString *) filename;
@end
