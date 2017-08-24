//
//  ViewController.m
//  LocalDatabase
//
//  Created by YaSha_Tom on 2017/8/22.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ViewController.h"
#import "ACLModel.h"
#import <YYModel.h>
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Permissions" ofType:@"plist"];
    
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    [self dataToModel:self.dataArray];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"查询数据" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(resultsEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(60);
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(267, 30));
    }];
    NSLog(@"======%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
}
- (void)resultsEvent{
    RLMResults *results = [ACLModel objectsWhere:@"systemSn = 'assets' AND moduleSn = 'check' AND permissionValue = 0"];
    NSLog(@"======%lu",(unsigned long)results.count);
}
- (void)dataToModel:(NSMutableArray *)arr {
    NSLog(@"_________%@",arr);
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        ACLModel *model = [ACLModel yy_modelWithJSON:dic];
        [mutableArray addObject:model];
    };
    RLMRealm *reamlm = [RLMRealm defaultRealm];
    [reamlm transactionWithBlock:^{
        [reamlm addObjects:[mutableArray copy]];
    }];
    [reamlm beginWriteTransaction];
    [reamlm commitWriteTransaction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
