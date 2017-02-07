//
//  AppDelegate.h
//  MSStoreButton
//
//  Created by Jid Hatami on 2/7/17.
//  Copyright © 2017 Jid Hatami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

