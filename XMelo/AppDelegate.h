//
//  AppDelegate.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
<<<<<<< HEAD
#import <IQKeyboardManager.h>
#import "XMeloDelegate.h"
=======
//#import <IQKeyboardManager.h>
>>>>>>> 7ff4b8d953003c37a2214766e8c5d8fed47bb3c2

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end

