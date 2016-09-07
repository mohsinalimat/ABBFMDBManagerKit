//
//  Person.h
//  ABBFMDBManager
//
//  Created by beyondsoft-聂小波 on 16/9/6.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreModel.h"
#import "House.h"
#import "clothes.h"

@interface Person : CoreModel
@property (strong,nonatomic) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (strong,nonatomic) House *house;
@property (strong,nonatomic) NSArray *clothes;

@end
