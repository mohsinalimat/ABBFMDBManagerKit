//
//  Person.m
//  ABBFMDBManager
//
//  Created by beyondsoft-聂小波 on 16/9/6.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "Person.h"
#import "House.h"
@implementation Person

+(NSDictionary *)statementForNSArrayProperties{
    return @{@"clothes":NSStringFromClass([clothes class])};
}

@end
