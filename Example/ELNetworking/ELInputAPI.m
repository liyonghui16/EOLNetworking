//
//  ELInputAPI.m
//  ELNetworking_Example
//
//  Created by Ens Livan on 2018/1/19.
//  Copyright © 2018年 liyonghui16. All rights reserved.
//

#import "ELInputAPI.h"

@interface ELInputAPI ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *code;

@end

@implementation ELInputAPI

- (instancetype)initWithPhone:(NSString *)phone ID:(NSString *)ID code:(NSString *)code {
    self = [super init];
    if (self) {
        _phone = phone;
        _ID = ID;
        _code = code;
    }
    return self;
}

- (NSString *)APIMethodName {
    return @"testInputApi.html";
}

- (NSDictionary *)APIParams {
    return @{
             @"phone": self.phone ?: @"",
             @"ID": self.ID ?: @"",
             @"code": self.code ?: @"",
             };
}

- (ELValidator *)validateAPI:(ELBaseAPI *)api requestParams:(NSDictionary *)reqP {
    ELValidator *validator = [[ELValidator alloc] init];
    [validator validatePhoneNumber:self.phone tip:@"请输入电话"];
    [validator validateIDCardNumber:self.ID];
    [validator validateEmptyString:self.code tip:@"验证码不能为空"];
    return validator.verify;
}

@end
