//
//  NSApplication+SheetBlocks.m
//
//  Copyright (c) 2013 Rico Becker, KF Interactive
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSApplication+SheetBlocks.h"


@implementation NSApplication (SheetBlocks)

#define kDidEndBlock @"didEndBlock"
#define kDidDismissBlock @"didDismissBlock"
#define kContextInfo @"contextInfo"


void KFBeginAlertSheet(NSString *title, NSString *defaultButton, NSString *alternateButton, NSString *otherButton, NSWindow *docWindow, KFSheetDidEndBlock didEndBlock, KFSheetDidDismissBlock didDismissBlock, void *contextInfo, NSString *msgFormat)
{
    NSMutableDictionary *contextInfoParameter = [NSMutableDictionary new];
    
    if (didEndBlock != nil)
    {
        contextInfoParameter[kDidEndBlock] = didEndBlock;
    }
    
    if (didDismissBlock != nil)
    {
        contextInfoParameter[kDidDismissBlock] = didDismissBlock;
    }
    
    if (contextInfo != nil)
    {
        contextInfoParameter[kContextInfo] = (__bridge id)(contextInfo);
    }
    
    NSBeginAlertSheet(title, defaultButton, alternateButton, otherButton, docWindow, NSApp, @selector(kf_sheet:didEndWithCode:context:), @selector(kf_sheet:didDismissWithCode:context:), (__bridge_retained void *)(contextInfoParameter), msgFormat,nil);
}


void KFBeginInformationalAlertSheet(NSString *title, NSString *defaultButton, NSString *alternateButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, KFSheetDidEndBlock didEndBlock, KFSheetDidDismissBlock didDismissBlock, void *contextInfo, NSString *msgFormat)
{
    NSMutableDictionary *contextInfoParameter = [NSMutableDictionary new];
    
    if (didEndBlock != nil)
    {
        contextInfoParameter[kDidEndBlock] = didEndBlock;
    }
    
    if (didDismissBlock != nil)
    {
        contextInfoParameter[kDidDismissBlock] = didDismissBlock;
    }
    
    if (contextInfo != nil)
    {
        contextInfoParameter[kContextInfo] = (__bridge id)(contextInfo);
    }
    NSBeginInformationalAlertSheet(title, defaultButton, alternateButton, otherButton, docWindow, NSApp, @selector(kf_sheet:didEndWithCode:context:), @selector(kf_sheet:didDismissWithCode:context:), (__bridge void *)(contextInfoParameter), msgFormat, nil);
}


void KFBeginCriticalAlertSheet(NSString *title, NSString *defaultButton, NSString *alternateButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, KFSheetDidEndBlock didEndBlock, KFSheetDidDismissBlock didDismissBlock, void *contextInfo, NSString *msgFormat)
{
    NSMutableDictionary *contextInfoParameter = [NSMutableDictionary new];
    
    if (didEndBlock != nil)
    {
        contextInfoParameter[kDidEndBlock] = didEndBlock;
    }
    
    if (didDismissBlock != nil)
    {
        contextInfoParameter[kDidDismissBlock] = didDismissBlock;
    }
    
    if (contextInfo != nil)
    {
        contextInfoParameter[kContextInfo] = (__bridge id)(contextInfo);
    }
    NSBeginCriticalAlertSheet(title, defaultButton, alternateButton, otherButton, docWindow, NSApp, @selector(kf_sheet:didEndWithCode:context:), @selector(kf_sheet:didDismissWithCode:context:), (__bridge void *)(contextInfoParameter), msgFormat, nil);
}


#pragma mark - Internal Selectors


- (void)kf_sheet:(NSPanel *)panel didEndWithCode:(NSInteger)code context:(void *)context
{
    NSDictionary *parameters = (__bridge NSDictionary *)(context);
    KFSheetDidEndBlock didEndBlock = [parameters objectForKey:kDidEndBlock];
    void *contextInfo = (__bridge  void *)([parameters objectForKey:kContextInfo]);
    
    if (didEndBlock != nil)
    {
        didEndBlock(contextInfo, code);
    }
}


- (void)kf_sheet:(NSPanel *)panel didDismissWithCode:(NSInteger)code context:(void *)context
{
    NSDictionary *parameters = (__bridge_transfer NSDictionary *)context;
    KFSheetDidDismissBlock didDismissBlock = [parameters objectForKey:kDidDismissBlock];
    void *contextInfo = (__bridge void *)([parameters objectForKey:kContextInfo]);
    
    if (didDismissBlock != nil)
    {
        didDismissBlock(contextInfo, code);
    }
}


@end
