//
//  UIViewController+ProgressHUD.m
//
//  Created by Chris Miles on 26/07/11.
//  Copyright 2011 Chris Miles. All rights reserved.
//
// This code is distributed under the terms and conditions of the MIT license. 

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <objc/runtime.h>
#import "UIViewController+ProgressHUD.h"
#import "MBProgressHUD.h"

static char progresshud_key;	// unique address for associative object key


@implementation UIViewController ( ProgressHUD )

#pragma mark - Progress HUD management

- (MBProgressHUD *)currentProgressHUD
{
    MBProgressHUD *progressHUD = objc_getAssociatedObject(self, &progresshud_key);
    return progressHUD;
}

- (void)showProgressHUDWithMessage:(NSString *)message inView:(UIView *)parentView animated:(BOOL)animated
{
    if ([self currentProgressHUD]) {
	[self dismissHUDAnimated:animated];
    }
    
    if (nil == parentView) {
	// Default to covering the window
	parentView = self.view.window;
    }
    
    MBProgressHUD *progressHUD = [[[MBProgressHUD alloc] initWithView:parentView] autorelease];
    progressHUD.labelText = message;
    progressHUD.removeFromSuperViewOnHide = NO;
    [parentView addSubview:progressHUD];
    [progressHUD show:animated];
    
    // Store as an associative object
    objc_setAssociatedObject(self, &progresshud_key, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showProgressHUDOverWindowWithMessage:(NSString *)message animated:(BOOL)animated
{
    [self showProgressHUDWithMessage:message inView:nil animated:animated];
}

- (void)dismissHUDAnimated:(BOOL)animated
{
    MBProgressHUD *progressHUD = [self currentProgressHUD];
    if (progressHUD) {
	progressHUD.removeFromSuperViewOnHide = YES;
	[progressHUD hide:animated];
	objc_setAssociatedObject(self, &progresshud_key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)updateProgressHUDForErrorMessage:(NSString *)message
{
    if (nil == message || [message length] == 0) {
	message = @"Failed.";
    }

    MBProgressHUD *progressHUD = [self currentProgressHUD];
    if (progressHUD) {
	[progressHUD hide:NO];
	progressHUD.customView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];	// empty view
	progressHUD.mode = MBProgressHUDModeCustomView;
	progressHUD.detailsLabelText = message;
	progressHUD.labelText = @"×";
	progressHUD.labelFont = [UIFont boldSystemFontOfSize:48.0];
	[progressHUD show:NO];
    }
}

- (void)updateProgressHUDForSuccessMessage:(NSString *)message
{
    if (nil == message || [message length] == 0) {
	message = @"";
    }
    
    MBProgressHUD *progressHUD = [self currentProgressHUD];
    if (progressHUD) {
	[progressHUD hide:NO];
	progressHUD.customView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];	// empty view
	progressHUD.mode = MBProgressHUDModeCustomView;
	progressHUD.labelText = message;
	progressHUD.detailsLabelText = @"✔";
	progressHUD.detailsLabelFont = [UIFont boldSystemFontOfSize:48.0];
	progressHUD.removeFromSuperViewOnHide = YES;
	[progressHUD show:NO];
    }
}

@end
