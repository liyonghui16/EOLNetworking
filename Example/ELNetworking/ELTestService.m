//
//  ELTestService.m
//  ELNetworking_Example
//
//  Created by Ens Livan on 2017/12/21.
//  Copyright © 2017年 liyonghui16. All rights reserved.
//

#import "ELTestService.h"

@implementation ELTestService

- (NSString *)commonDomain {
    return @"http://mvapi.net";
}

- (NSString *)pageIndexKey {
    return @"pageindex";
}

- (NSString *)pageSizeKey {
    return @"pagesize";
}

- (ELRequestType)commonRequestType {
    return ELRequestTypePOST;
}

- (BOOL)shouldCallApi:(ELBaseAPI *)api {
    return YES;
}

- (BOOL)shouldFinishApi:(ELBaseAPI *)api {
    return YES;
}

- (ELResponse *)recombineResponseWithApi:(ELBaseAPI *)api resposeObject:(id)responseObject code:(NSInteger)code {
    ELResponse *response = [[ELResponse alloc] init];
    response.data = responseObject;
    response.code = code;
    if (code == ELResponseCodeSuccess) {
        response.success = YES;
    }
    return response;
}

@end
