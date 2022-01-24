//
//  ADRToolBoxLogger.m
//  EditorTools
//
//  Created by Patrick Cusack on 8/1/15.
//
//

#import "PCLogger.h"

@interface PCLogger(){
    NSFileHandle * fileHandle;
    NSString * path;
}

@property (nonatomic, readwrite, retain) NSFileHandle * fileHandle;
@property (nonatomic, readwrite, retain) NSString * path;

@end

@implementation PCLogger
@synthesize fileHandle;
@synthesize path;

+ (PCLogger*)LoggerWithPath:(NSString*)path{
    static PCLogger * _logger;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _logger = [[PCLogger alloc] initWithPath:path];
    });
    
    return _logger;
}

- (instancetype)initWithPath:(NSString*)path
{
    self = [super init];
    if (self) {
        [self setPath:path];
        [self setFileHandle:[self openFileHandle]];
    }
    return self;
}

- (void)dealloc{
    if ([self fileHandle]) {
        [[self fileHandle] closeFile];
    }
    [self setFileHandle:nil];
    [super dealloc];
}

- (NSFileHandle*)openFileHandle{
    
    NSString * logFolder = [[self path] stringByDeletingLastPathComponent];
    NSString * logFilePath = path;
    
    NSFileManager * fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    
    if (![fm fileExistsAtPath:logFolder isDirectory:&isDir]) {
        NSError * e = nil;
        [fm createDirectoryAtPath:logFolder
      withIntermediateDirectories:YES
                       attributes:nil
                            error:&e];
        if (e) {
            NSLog(@"Unable to create log folder.");
            return nil;
        }
    }
    
    if (![fm fileExistsAtPath:logFilePath]) {
        [fm createFileAtPath:logFilePath contents:nil attributes:nil];
    }
    
    NSError * err = nil;
    NSFileHandle * writingHandle = [NSFileHandle fileHandleForWritingToURL:[NSURL fileURLWithPath:logFilePath] error:&err];
    if (err) {
        NSLog(@"%@", [err localizedDescription]);
        return nil;
    }
    [writingHandle seekToEndOfFile];
    return writingHandle;
}

+ (void)addString:(NSString*)info{
    PCLogger * logger  = [PCLogger sharedLogger];
    if (logger) {
        NSDate * currentDate = [NSDate date];
        info = [NSString stringWithFormat:@"%@: %@\n", currentDate, info];
        if ([logger fileHandle]) {
            [[logger fileHandle] writeData:[info dataUsingEncoding:NSASCIIStringEncoding]];
        }
    }
}

- (void)addString:(NSString*)info{
    NSDate * currentDate = [NSDate date];
    info = [NSString stringWithFormat:@"%@: %@\n", currentDate, info];
    if ([self fileHandle]) {
        [[self fileHandle] writeData:[info dataUsingEncoding:NSASCIIStringEncoding]];
    }
}

- (void)logInfo:(NSString*)info{
    NSDate * currentDate = [NSDate date];
    info = [NSString stringWithFormat:@"%@: %@\n", currentDate, info];
    if ([self fileHandle]) {
        [[self fileHandle] writeData:[info dataUsingEncoding:NSASCIIStringEncoding]];
    }
}

@end
