//
//  UIViewController+ProgressHUD.h
//
//  Created by Chris Miles on 26/07/11.
//  Copyright 2011 Chris Miles.
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

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIViewController ( ProgressHUD )

- (MBProgressHUD *)currentProgressHUD;

- (void)showProgressHUDOverWindowWithMessage:(NSString *)message animated:(BOOL)animated;
- (void)showProgressHUDWithMessage:(NSString *)message inView:(UIView *)parentView animated:(BOOL)animated;

- (void)updateProgressHUDForSuccessMessage:(NSString *)message;
- (void)updateProgressHUDForErrorMessage:(NSString *)message;
- (void)updateProgressHUDForErrorMessage:(NSString *)message dismissAfter:(NSTimeInterval)seconds;

- (void)dismissHUDAnimated:(BOOL)animated;

@end
