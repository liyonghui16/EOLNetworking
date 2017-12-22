//
//  ELBaseAPI.h
//  ELNetworking
//
//  Created by 李涌辉 on 16/8/7.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNetwork.h"
#import "ELNetworkProtocol.h"
#import "ELResponse.h"
#import "ELValidator.h"
@class ELBaseAPI;

/**
 *  API协议, 数据请求成功后通过代理方式把数据交付给业务层
 */
@protocol ELBaseAPIDelegate <NSObject>

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response;

@end

@interface ELBaseAPI : NSObject 

@property (nonatomic, weak) id<ELBaseAPIDelegate> dataReceiver;

@property (nonatomic, weak) id<APIConfig> child;

@property (nonatomic, weak) id<ELAPIValidator> validator;

@property (nonatomic, weak) id<ELCacheDelegate> cacheDelegate;

@property (nonatomic, weak) id<ELAPIInterceptor> interceptor;

@property (nonatomic, assign, readonly) BOOL isLoading;
/**
 *  服务器返回的原始数据
 */
@property (nonatomic, strong, readonly) NSDictionary *rawData;

- (void)requestData;

@end
