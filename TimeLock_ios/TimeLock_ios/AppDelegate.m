//
//  AppDelegate.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "AppDelegate.h"
#import "Const.h"
#import "TLUtils.h"
#import "TLNetworkManager+Authorization.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "TLMainViewController.h"
#import "TLProfileViewController.h"
#import "TLCheckinsViewController.h"
#import "TLLaunchLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UITabBarController *tabsController = (id)_window.rootViewController;
    [self initTabBarController:tabsController];
    
    [[TLNetworkManager sharedNetworkManager] startMonitoring];
    [self configureNotification];
    if ([TLUtils checkExistenceNotEmptyStringObjectForKey:@"email"] && [TLUtils checkExistenceNotEmptyStringObjectForKey:@"password"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:needRelogin object:nil userInfo:nil];
        });
    } else {
        [self openLaunchLoginScreen];
    }
    
    return YES;
}

- (void)initTabBarController:(UITabBarController *)tabBarController {
    _mainNavigationController       = tabBarController.viewControllers[0];
    _checkinsNavigationController   = tabBarController.viewControllers[1];
    _profileNavigationController    = tabBarController.viewControllers[2];
    
    [_mainNavigationController      pushViewController:[[TLMainViewController alloc] init]  animated:NO];
    [_checkinsNavigationController  pushViewController:[[TLCheckinsViewController alloc] init] animated:NO];
    [_profileNavigationController   pushViewController:[[TLProfileViewController alloc] init]  animated:NO];
}

- (void)configureNotification {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:needRelogin object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        @strongify(self)
        [TLUtils setObjectToUserSettings:needRelogin forKey:needRelogin];
        [TLNetworkManager sharedNetworkManager].manualErrorShowing = NO;
        [[TLNetworkManager sharedNetworkManager] authorizationRequestParam:nil completion:^(BOOL success, id object) {
            [TLUtils setObjectToUserSettings:nil forKey:needRelogin];
            if(!success && [object isKindOfClass:[NSError class]]) {
                [self openLaunchLoginScreen];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:needRepeatRequest object:nil userInfo:nil];
            }
        }];
     }];
}

- (void)openLaunchLoginScreen {
    TLLaunchLoginViewController *loginVC = [[TLLaunchLoginViewController alloc] init];
    UIViewController *oldRootController = self.window.rootViewController;
    self.window.rootViewController = loginVC;
    [loginVC setCompletion:^{
        self.window.rootViewController = oldRootController;
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "chausov.TimeLock_ios" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TimeLock_ios" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TimeLock_ios.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
