//
//  PCNPLogger.h
//  NameAndPassword
//
//  Created by Patrick Cusack on 1/24/22.
//

#import <Foundation/Foundation.h>
#import "PCLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCNPLogger : PCLogger
+ (PCNPLogger*)sharedLogger;
@end

NS_ASSUME_NONNULL_END
