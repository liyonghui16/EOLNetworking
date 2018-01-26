//
//  ELInputAPI.h
//  ELNetworking_Example
//
//  Created by Ens Livan on 2018/1/19.
//  Copyright © 2018年 liyonghui16. All rights reserved.
//

#import <EOLNetworking/ELNetworking.h>

@interface ELInputAPI : ELBaseAPI <APIConfig, ELAPIValidator>

- (instancetype)initWithPhone:(NSString *)phone ID:(NSString *)ID code:(NSString *)code;

@end
