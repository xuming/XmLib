//
//  ManagerFile.m
//  iTheate
//
//  Created by  on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "ManagerFile.h"

@implementation ManagerFile

///wirte file to [approot]/document
+(void)writeFile:(NSString *)file withFileName:(NSString *) filename;
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径   
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    //获取文件路径
    [fileManager removeItemAtPath:filename error:nil];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[file dataUsingEncoding:NSUTF8StringEncoding]];
    //将其他数据添加到缓冲中
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];
   
}

+(void)writeFile:(NSData *)data withDataFileName:(NSString *) filename;
{
    //创建文件管理器
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];

    NSError * err;
    
    [data writeToFile:path options:NSDataWritingFileProtectionNone error:&err];
    
}

///readfile from [approot]/document
+(NSString *)readFile:(NSString *) filename;
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径   
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData *reader = [NSData dataWithContentsOfFile:path];
    NSString *content=[[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];

    return content ;
}
///readfile from [approot]/document
+(NSData *)readFileData:(NSString *) filename;
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径   
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData *reader = [NSData dataWithContentsOfFile:path];
    
    return reader ;
}
///is file exist in [approot]/[appname.app] or [approot]/document
+(BOOL) fileExists:(NSString *) filename;
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径   
    //获取文档路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    
    //NSHomeDirectory() 应用程序根目录
    //获取应用程序包目录
    NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    return [fileManager fileExistsAtPath:path2]||[fileManager fileExistsAtPath:path];

}
///从应用程序包目录货根目录查找并获取文件名,优先查找Document目录
+(NSString *)getFileByFileName:(NSString *) filename;
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径   
    //获取文档路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    
    if ([fileManager fileExistsAtPath:path]) {
        return path;
    }

    
    
  
    //获取应用程序包目录
    NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    if ([fileManager fileExistsAtPath:path2]) {
        return path2;
    }
   
   
    
        
   
   
    return nil;
}
@end



