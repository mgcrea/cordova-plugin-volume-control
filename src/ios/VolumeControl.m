/********* VolumeControl.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>

@interface VolumeControl : CDVPlugin {
  // Member variables go here.
}

- (void)toggleMute:(CDVInvokedUrlCommand*)command;
- (void)setVolume:(CDVInvokedUrlCommand*)command;
@end

@implementation VolumeControl

- (void)toggleMute:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    DLog(@"toggleMute", volume);

    Class avSystemControllerClass = NSClassFromString(@"AVSystemController");
    id avSystemControllerInstance = [avSystemControllerClass performSelector:@selector(sharedAVSystemController)];

    NSInvocation *privateInvocation = [NSInvocation invocationWithMethodSignature:
                                      [avSystemControllerClass instanceMethodSignatureForSelector:
                                       @selector(toggleActiveCategoryMuted)]];
    [privateInvocation setTarget:avSystemControllerInstance];
    [privateInvocation setSelector:@selector(toggleActiveCategoryMuted)];
    [privateInvocation invoke];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setVolume:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    float volume = [[command argumentAtIndex:0] floatValue];
    DLog(@"setVolume: [%f]", volume);

    Class avSystemControllerClass = NSClassFromString(@"AVSystemController");
    id avSystemControllerInstance = [avSystemControllerClass performSelector:@selector(sharedAVSystemController)];

    NSInvocation *privateInvocation = [NSInvocation invocationWithMethodSignature:
                                     [avSystemControllerClass instanceMethodSignatureForSelector:
                                      @selector(setActiveCategoryVolumeTo:)]];
    [privateInvocation setTarget:avSystemControllerInstance];
    [privateInvocation setSelector:@selector(setActiveCategoryVolumeTo:)];
    [privateInvocation setArgument:&volume atIndex:2];
    [privateInvocation invoke];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
