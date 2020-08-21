//
//  AppDelegate.h
//  WebchatDemo
//
//  Created by EliteCRM on 2020/8/19.
//  Copyright © 2020 EliteCRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;


@end

