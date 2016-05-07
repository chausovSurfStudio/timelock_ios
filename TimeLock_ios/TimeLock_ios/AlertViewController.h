//
//  AlertViewController.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 27.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//
//  Класс всплывающих сообщений

#import "TLNetworkManager.h"

@interface AlertViewController : UIViewController

+ (instancetype)sharedInstance;

@property (nonatomic) BOOL showAfterClose;
@property (nonatomic) BOOL isActive;

//сообщения об ошибках (параметр hide - скрывать ли сообщение автоматически)
- (void)showErrorAlert:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)hide;

//сообщения об хороших результатах
- (void)showInfoAlert:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)hide;

// показ сообщения из под навбара
- (void)showInfoBasketAlert:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)hide;

//скрыть сообщение с задержкой delay
- (void)hideAlert:(BOOL)animation delay:(CGFloat)delay;

//показ сообщение об ошибке с текстом по коду ошибки
- (void)showErrorAlertWithErrorCode:(HTTPStatusCode)statucCode animation:(BOOL)animation autoHide:(BOOL)hide;

@end