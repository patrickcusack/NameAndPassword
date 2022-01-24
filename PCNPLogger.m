//
//  PCNPLogger.m
//  NameAndPassword
//
//  Created by Patrick Cusack on 1/24/22.
//

#import "PCNPLogger.h"


@implementation PCNPLogger

+ (PCNPLogger*)sharedLogger{
    
    static PCNPLogger * _logger;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _logger = [[PCNPLogger alloc] initWithPath:@"/Users/Shared/pnlog.txt"];
    });
    
    return _logger;
}

@end
