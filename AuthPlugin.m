/*

File: AuthPlugin.m

Abstract: Plugin and Mechanism subclasses specific to this project

Version: 1.0

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Computer, Inc. ("Apple") in consideration of your agreement to the
following terms, and your use, installation, modification or
redistribution of this Apple software constitutes acceptance of these
terms.  If you do not agree with these terms, please do not use,
install, modify or redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software. 
Neither the name, trademarks, service marks or logos of Apple Computer,
Inc. may be used to endorse or promote products derived from the Apple
Software without specific prior written permission from Apple.  Except
as expressly stated in this notice, no other rights or licenses, express
or implied, are granted by Apple herein, including but not limited to
any patent rights that may be infringed by your derivative works or by
other works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright � 2006 Apple Computer, Inc., All Rights Reserved

*/

#import "AuthPlugin.h"
//#import "PCNPLogger.h"
#import "os/log.h"

@implementation EXAuthPlugin

-(id)mechanism:(AuthorizationMechanismId)mechanismId engineRef:(AuthorizationEngineRef)inEngine
{
//    [[PCNPLogger sharedLogger] logInfo:[NSString stringWithFormat:@"%s %d %s", __FUNCTION__, __LINE__, __FILE__]];
    os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_DEBUG, "mechanism");
    
	if (!strcmp(mechanismId, "invoke"))
	{
		// for the invoke mechanism return a instance of the AuthPluginMechanism
		return [[EXAuthPluginMechanism alloc] initWithPlugin:self engineRef:inEngine];
	}
	
    return nil;
}
@end

@implementation EXAuthPluginMechanism

- (OSStatus)invoke
{
//    [[PCNPLogger sharedLogger] logInfo:[NSString stringWithFormat:@"%s %d %s", __FUNCTION__, __LINE__, __FILE__]];
    os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_DEBUG, "invoke");
    
	if (mNameAndPassword == nil)
	{
		mNameAndPassword = [[EXNameAndPassword alloc] initWithCallbacks: [mPluginRef engineCallback] andEngineRef: mEngineRef];
	}

	if (mNameAndPassword)
	{
		[mNameAndPassword displayView];
	}
	
	return noErr;
}

- (void)dealloc
{
//    [[PCNPLogger sharedLogger] logInfo:[NSString stringWithFormat:@"%s %d %s", __FUNCTION__, __LINE__, __FILE__]];
    os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_DEBUG, "dealloc");
    
	if (mNameAndPassword)
	{
		[mNameAndPassword release];
	}
	
	[super dealloc];
}

@end
