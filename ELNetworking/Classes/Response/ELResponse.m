//
//  ELResponse.m
//  ELNetworking
//
//  Created by 李涌辉 on 16/9/4.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import "ELResponse.h"

@implementation ELResponse

- (instancetype)initWithData:(id)data error:(NSError *)error responseCode:(ELResponseCode)responseCode {
    self = [super init];
    if (self) {
        _data = data[@"data"];
        if (error) {
            _success = NO;
            _message = error.localizedDescription;
            _errorCode = error.code;
        } else {
            _success = [data[@"errcode"] integerValue] == 0 ? YES : NO;
            _message = data[@"errmsg"];
        }
        _code = responseCode;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _data = [aDecoder decodeObjectForKey:@"data"];
        _success = [aDecoder decodeBoolForKey:@"success"];
        _message = [aDecoder decodeObjectForKey:@"message"];
        _errorCode = [aDecoder decodeIntegerForKey:@"errorCode"];
        _code = [aDecoder decodeIntegerForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_data forKey:@"data"];
    [aCoder encodeBool:_success forKey:@"success"];
    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeInteger:_errorCode forKey:@"errorCode"];
    [aCoder encodeInteger:_code forKey:@"code"];
}

@end
