//
//  ELTestAPI.m
//  ELNetworking_Example
//
//  Created by Ens Livan on 2017/12/22.
//  Copyright © 2017年 liyonghui16. All rights reserved.
//

#import "ELTestAPI.h"

@implementation ELTestAPI

- (NSString *)APIMethodName {
    return @"/apiv4/Article/GetDataList";
}

- (NSDictionary *)APIParams {
    return @{
             @"category": @"1"
             };
}

@end
