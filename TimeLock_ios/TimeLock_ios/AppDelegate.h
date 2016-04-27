//
//  AppDelegate.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readwrite, strong) UINavigationController *mainNavigationController;
@property (nonatomic, readwrite, strong) UINavigationController *checkinsNavigationController;
@property (nonatomic, readwrite, strong) UINavigationController *profileNavigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

