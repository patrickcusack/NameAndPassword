//
//  ADRToolBoxLogger.h
//  EditorTools
//
//  Created by Patrick Cusack on 8/1/15.
//
//

#import <Foundation/Foundation.h>

@protocol PCLoggerProtocol <NSObject>
+ (void)addString:(NSString*)info;
@optional
- (void)logInfo:(NSString*)info;
@end

@interface PCLogger : NSObject <PCLoggerProtocol>
+ (PCLogger*)LoggerWithPath:(NSString*)path;
- (instancetype)initWithPath:(NSString*)path;
+ (void)addString:(NSString*)info;
- (void)addString:(NSString*)info;
- (void)logInfo:(NSString*)info;
@end
