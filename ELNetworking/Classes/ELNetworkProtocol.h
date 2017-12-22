//
//  ELNetworkProtocol.h
//  ELNetworking
//
//  Created by 李涌辉 on 2016/10/23.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import "ELNetworkProtocol.h"
#import "ELNetworkConfig.h"

@class ELBaseAPI;
@class ELResponse;
@class ELValidator;

@protocol APIConfig <NSObject>

- (NSString *)APIMethodName;

@optional
- (NSDictionary *)APIParams;
//
- (NSString *)APIDomain;
- (ELRequestType)requestType;

@end

@protocol ELCacheDelegate <NSObject>
- (ELCachePolicy)cachePolicy;

@optional
- (NSTimeInterval)cacheTime;
@end

@protocol ELAPIValidator <NSObject>
- (ELValidator *)validateAPI:(ELBaseAPI *)api requestParams:(NSDictionary *)reqP;
//- (BOOL)validateAPI:(ELBaseAPI *)api response:(ELResponse *)response;
@end

@protocol ELAPIInterceptor <NSObject>

@optional
- (void)willCompletedRequestWithResponse:(ELResponse *)response;
- (void)didCompletedRequestWithResponse:(ELResponse *)response;
@end

@protocol ELAPIService <NSObject>

@property (nonatomic, copy, readonly) NSString *commonDomain;
@property (nonatomic, assign, readonly) ELRequestType commonRequestType;
@property (nonatomic, copy, readonly) NSString *pageIndexKey;
@property (nonatomic, copy, readonly) NSString *pageSizeKey;

- (BOOL)shouldCallApi:(ELBaseAPI *)api;
- (ELResponse *)recombineResponseWithApi:(ELBaseAPI *)api resposeObject:(id)responseObject code:(NSInteger)code;

@end

@protocol ELUserAuth <NSObject>
@end
/* ELNetworkProtocal_h */
