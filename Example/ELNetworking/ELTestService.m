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
    return @"http://www.example.com";
}

- (ELRequestType)commonRequestType {
    return ELRequestTypePOST;
}

@end
