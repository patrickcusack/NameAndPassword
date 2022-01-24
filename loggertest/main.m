//
//  main.m
//  loggertest
//
//  Created by Patrick Cusack on 1/24/22.
//

#import <Foundation/Foundation.h>
#import "PCNPLogger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[PCNPLogger sharedLogger] logInfo:[NSString stringWithFormat:@"%s %d %s", __FUNCTION__, __LINE__, __FILE__]];
    }
    return 0;
}
