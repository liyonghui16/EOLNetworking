//
//  ELViewController.m
//  ELNetworking
//
//  Created by liyonghui16 on 12/21/2017.
//  Copyright (c) 2017 liyonghui16. All rights reserved.
//

#import "ELViewController.h"
#import "ELTestAPI.h"
#import <ELNetworking/ELBatchRequest.h>

@interface ELViewController () <ELBatchRequestDelegate>

@property (nonatomic, strong) UIButton *api;
@property (nonatomic, strong) UIButton *apis;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ELViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.hidesWhenStopped = YES;
    [self.view addSubview:self.indicator];
    
}

- (IBAction)apiRequest:(id)sender {
    self.api = sender;
    ELTestAPI *api = [[ELTestAPI alloc] init];
    api.dataReceiver = self;
    [api requestData];
    self.api.hidden = YES;
    self.indicator.frame = self.api.frame;
    [self.indicator startAnimating];
}

- (IBAction)apisRequest:(id)sender {
    self.apis = sender;
    ELTestAPI *api1 = [[ELTestAPI alloc] init];
    ELTestAPI *api2 = [[ELTestAPI alloc] init];
    ELTestAPI *api3 = [[ELTestAPI alloc] init];
    ELTestAPI *api4 = [[ELTestAPI alloc] init];
    ELTestAPI *api5 = [[ELTestAPI alloc] init];
    ELBatchRequest *batchReq = [[ELBatchRequest alloc] initWithBatchAPIs:@[api1, api2, api3, api4, api5]];
    batchReq.delegate = self;
    [batchReq requestData];
    self.apis.hidden = YES;
    self.indicator.frame = self.apis.frame;
    [self.indicator startAnimating];
}

- (void)batchRequestFinished {
    self.apis.hidden = NO;
    [self.indicator stopAnimating];
}

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response {
    NSLog(@"%@", response.message);
    self.api.hidden = NO;
    if (api.dataReceiver == self) {
        [self.indicator stopAnimating];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
