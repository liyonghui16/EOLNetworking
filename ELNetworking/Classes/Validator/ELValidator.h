//
//  ELValidator.h
//  WWTCYW
//
//  Created by Ens Livan on 2017/12/8.
//  Copyright © 2017年 com.sxtw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELValidateItem : NSObject

@property (nonatomic, copy) NSString *regex;
@property (nonatomic, copy) NSString *targetObj;
@property (nonatomic, copy) NSString *errorMsg;

@end

@interface ELValidator : NSObject

@property (nonatomic, strong, readonly) NSMutableArray <ELValidateItem *> *validateItems;
@property (nonatomic, assign, readonly) BOOL result;
@property (nonatomic, copy, readonly) NSString *errorMsg;

- (ELValidator *)verify;

//
- (void)validateEmptyString:(NSString *)string;
- (void)validateEmptyString:(NSString *)string tip:(NSString *)tip;
- (void)validateEmail:(NSString *)email;
- (void)validatePhoneNumber:(NSString *)phoneNumber;
- (void)validateIDCardNumber:(NSString *)IDCardNumber;

@end
