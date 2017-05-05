//
//  AppDelegate.h
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/5.
//  Copyright © 2017年 吴朝刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

