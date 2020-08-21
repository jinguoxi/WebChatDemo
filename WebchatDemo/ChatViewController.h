//
//  ViewController.h
//  WebchatDemo
//
//  Created by EliteCRM on 2020/8/19.
//  Copyright © 2020 EliteCRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
+ (instancetype)getInstance : (NSString *) url;
+ (instancetype)getInstance : (NSString *) url force :(int) force;
@end

