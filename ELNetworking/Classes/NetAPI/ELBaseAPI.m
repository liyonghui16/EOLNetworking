//
//  ELBaseAPI.m
//  ELNetworking
//
//  Created by 李涌辉 on 16/8/7.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import "ELBaseAPI.h"
#import "ELCache.h"
#import "ELPagingAPI.h"
#import "ELServiceManager.h"

@interface ELBaseAPI ()

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong, readwrite) NSDictionary *rawData;

@end

@implementation ELBaseAPI

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(APIConfig)]) {
            self.child = (id<APIConfig>)self;
        }else {
            NSAssert(NO, @"子类必须实现APIConfig协议");
        }
        if ([self conformsToProtocol:@protocol(ELAPIValidator)]) {
            self.validator = (id<ELAPIValidator>)self;
        }
        if ([self conformsToProtocol:@protocol(ELCacheDelegate)]) {
            self.cacheDelegate = (id<ELCacheDelegate>)self;
        }
        if ([self conformsToProtocol:@protocol(ELAPIInterceptor)]) {
            self.interceptor = (id<ELAPIInterceptor>)self;
        }
    }
    return self;
}

- (void)requestData {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    id<ELAPIService> service = [ELServiceManager sharedManager].service;
    NSAssert(service, @"You must register a service for ELNetwork!");
    NSString *domain = service.commonDomain;

    if ([self.child respondsToSelector:@selector(APIDomain)]) {
        domain = [self.child APIDomain];
    }
    ELRequestType reqType = service.commonRequestType;
    if ([self.child respondsToSelector:@selector(requestType)]) {
        reqType = [self.child requestType];
    }
    NSString *methodName = [self.child APIMethodName];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //分页api参数
    if ([self isKindOfClass:[ELPagingAPI class]]) {
        NSMutableDictionary *pagingParams = [NSMutableDictionary dictionary];
        ELPagingAPI *pagingAPI = (ELPagingAPI *)self;
        [pagingParams setObject:@(pagingAPI.pageIndex) forKey:@"pageNum"];
        [pagingParams setObject:@(pagingAPI.pageSize) forKey:@"pageSize"];
        [params addEntriesFromDictionary:pagingParams];
    }
    // api参数
    if ([self.child respondsToSelector:@selector(APIParams)]) {
        [params addEntriesFromDictionary:self.child.APIParams];
    }
    // user相关参数
    if ([self.child conformsToProtocol:@protocol(ELUserAuth)]) {
        [params addEntriesFromDictionary:[self specialParams]];
    }
    
    // 参数验证 如果验证失败则不发起请求
    if ([self conformsToProtocol:@protocol(ELAPIValidator)]) {
        ELValidator *validator = [self.validator validateAPI:self requestParams:params];
        if (!validator.result) {
            ELResponse *response = [[ELResponse alloc] initWithData:@{@"errmsg": validator.errorMsg, @"errcode": @1} error:nil responseCode:0];
            [self.dataReceiver api:self finishedWithResponse:response];
            response = nil;
            ELLog(@"参数校验失败！取消请求 API :%@\n 错误信息 : %@", self, validator.errorMsg);
            return;
        }
    }
    // 判断缓存
    ELCacheObject *cacheObj = [[ELCache sharedInstance] fetchCacheWithKey:NSStringFromClass([self class]) params:params cachePolicy:[self.cacheDelegate cachePolicy]];
    // 缓存存在并且没有失效 
    if (cacheObj && ![cacheObj isOutDateWithCachePolicy:[self.cacheDelegate cachePolicy]]) {
        self.isLoading = NO;
        if ([self.dataReceiver respondsToSelector:@selector(api:finishedWithResponse:)]) {
            [self.dataReceiver api:self finishedWithResponse:cacheObj.response];
        }
//        [self completeRequestWithResponse:cacheObj.response params:params];
        return;
    }
    // 请求前的log
    [self willRequestWithDomain:domain params:params];
    
    [[ELNetwork sharedNetwork] startRequestWithMethodType:reqType domain:domain methodName:methodName params:params completionHandle:^(ELResponse *response, NSDictionary *rawData) {
        self.rawData = rawData;
        self.isLoading = NO;
        // 拦截器
        if ([self.interceptor respondsToSelector:@selector(willCompletedRequestWithResponse:)]) {
            [self.interceptor willCompletedRequestWithResponse:response];
        }
        //
        if ([self.dataReceiver respondsToSelector:@selector(api:finishedWithResponse:)]) {
            [self.dataReceiver api:self finishedWithResponse:response];
        }
        //
        if ([self.interceptor respondsToSelector:@selector(didCompletedRequestWithResponse:)]) {
            [self.interceptor didCompletedRequestWithResponse:response];
        }
        [self completeRequestWithResponse:response params:params];
    }];
}

/**
 请求前的log 便于调试

 @param domain 接口域名
 */
- (void)willRequestWithDomain:(NSString *)domain params:(NSDictionary *)params {
    ELLog(@"%@开始请求", NSStringFromClass([self class]));
//    ELLog(@"请求域名 : %@", domain.length ? domain : @"--");
    ELLog(@"请求地址 : %@", [self.child APIMethodName]);
    if (params.count) {
        ELLog(@"请求参数 : %@", params);
    }
}

- (void)completeRequestWithResponse:(ELResponse *)response params:(NSDictionary *)params {
    if (response.success) {
        ELLog(@"%@请求成功!", NSStringFromClass([self class]));
        [[ELCache sharedInstance] saveCacheWithResponse:response key:NSStringFromClass([self class]) params:params cachePolicy:[self.cacheDelegate cachePolicy]];
    } else {
        ELLog(@"\n%@请求失败 \n 错误信息 : %@ \nhttp响应码 : %ld \nerrorCode : %ld", NSStringFromClass([self class]), response.message, (unsigned long)response.code, (long)response.errorCode);
    }
}

/**
 公共参数 比如版本号、签名字符串等等

 @return 公共参数
 */
- (NSDictionary *)commonParams {
    return @{};
}

/**
 特殊参数 比如用户的id

 @return 与用户相关的接口需要的额外参数
 */
- (NSDictionary *)specialParams {
    return @{};
}

@end
