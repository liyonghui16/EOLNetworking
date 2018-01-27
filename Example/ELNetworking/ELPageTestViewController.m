//
//  ELPageTestViewController.m
//  ELNetworking_Example
//
//  Created by Ens Livan on 2018/1/27.
//  Copyright © 2018年 liyonghui16. All rights reserved.
//

#import "ELPageTestViewController.h"
#import "ELTestAPI.h"

@interface ELPageTestViewController () <ELBaseAPIDelegate>

@property (nonatomic, strong) ELTestAPI *api;
@property (nonatomic, strong) UIButton *first;
@property (nonatomic, strong) UIButton *next;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ELPageTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.api = [[ELTestAPI alloc] init];
    self.api.dataReceiver = self;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.hidesWhenStopped = YES;
    [self.view addSubview:self.indicator];
}

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response {
    self.first.hidden = NO;
    self.next.hidden = NO;
    [self.indicator stopAnimating];
    NSLog(@"\n\n%@\n\n", response.message);
}

- (IBAction)loadFirst:(id)sender {
    self.first = sender;
    [self.api requestFirstPage];
    self.first.hidden = YES;
    self.indicator.frame = self.first.frame;
    [self.indicator startAnimating];
}

- (IBAction)loadNext:(id)sender {
    self.next = sender;
    [self.api requestNextPage];
    self.next.hidden = YES;
    self.indicator.frame = self.next.frame;
    [self.indicator startAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
