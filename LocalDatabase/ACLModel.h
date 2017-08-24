//
//  ACLModel.h
//  LocalDatabase
//
//  Created by YaSha_Tom on 2017/8/23.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <Realm/Realm.h>

@interface ACLModel : RLMObject

@property NSString *systemSn;
@property NSInteger permissionValue;
@property NSString *moduleSn;

@end
