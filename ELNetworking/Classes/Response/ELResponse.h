//
//  ELResponse.h
//  ELNetworking
//
//  Created by 李涌辉 on 16/9/4.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ELResponseCode) {
    ELResponseCodeSuccess = 200,
    ELResponseCodeNotFound = 404,
    ELResponseCodeTimeout = 408,
    ELResponseCodeErrorRequest = 400,
    ELResponseCodeServeError = 503
};

@interface ELResponse : NSObject <NSCoding>

/**
 *  响应数据
 */
@property (nonatomic, strong, readonly) id data;
/**
 *  响应状态
 */
@property (nonatomic, assign, readonly) BOOL success;
/**
 *  响应信息
 */
@property (nonatomic, copy, readonly) NSString *message;
/**
 *  错误码
 */
@property (nonatomic, assign, readonly) NSInteger errorCode;
/**
 *  HTTP响应状态码
 */
@property (nonatomic, assign, readonly) ELResponseCode code;

- (instancetype)initWithData:(id)data error:(NSError *)error responseCode:(ELResponseCode)responseCode;

@end
