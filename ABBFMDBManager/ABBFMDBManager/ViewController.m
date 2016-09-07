//
//  ViewController.m
//  ABBFMDBManager
//
//  Created by beyondsoft-聂小波 on 16/9/6.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self arrayDicModelSave];
    
    
}

#pragma mark - 数组字典模型存储
- (void)arrayDicModelSave {
    [Person mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"clothes" : @"clothes"
                 };
    }];
    
    NSArray *dateArray =@[ @{
                              @"name" : @"小明",
                              @"age" : @10,
                              @"house" : @{
                                      @"address" : @"大厦路201号"
                                      },
                              @"clothes" : @[ @{@"name" : @"上衣",@"color" : @"蓝色" },@{@"name" : @"裤子",@"color" : @"黄色" }]
                              
                              },
                           
                           @{
                               @"name" : @"小王",
                               @"age" : @15,
                               @"house" : @{
                                       @"address" : @"前程路345号"
                                       },
                               @"clothes" : @[ @{@"name" : @"上衣",@"color" : @"红色" },@{@"name" : @"裤子",@"color" : @"绿色" }]
                               
                               }
                           ,
                           
                           @{
                               @"name" : @"小刚",
                               @"age" : @22,
                               @"house" : @{
                                       @"address" : @"南京东路45号"
                                       },
                               @"clothes" : @[ @{@"name" : @"上衣",@"color" : @"紫色" },@{@"name" : @"裤子",@"color" : @"灰色" }]
                               
                               }

                           ];
    
    //创建所有模型文件空表
    Person *personInit = [[Person alloc] init];
    House *houseInit = [[House alloc] init];
    clothes *clothesInit = [[clothes alloc] init];
    personInit.house = houseInit;
    personInit.clothes = @[clothesInit];
    
    
    //MJ 一行代码解析模型包含模型，包含数组模型解析方法，超赞
    NSArray *personArray = [Person mj_objectArrayWithKeyValuesArray:dateArray];
//    person.hostID = 2;
    NSLog(@"person=%@", personArray);
    

    for (Person *person in personArray) {
        
        [Person save:person resBlock:^(BOOL res) {
            [self show:res];
            
        }];

    }
    //简单举例：查询Person表
    [Person selectWhere:nil groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
        
        NSLog(@"%@",selectResults);
    }];

    /*
     1、已经存储成功（model继承CoreModel），如果继承NSObject就不会存储。
     2、建立三张，子表会自动增加以下三列关联信息：
     
     |hostID|INTEGER|1|0|0
     |pModel|TEXT|1|''|0
     |pid|INTEGER|1|0|0
     
     3、一开始日志打印.aql数据库文件位置：
       ABBFMDBManager[9579:330110] dbPath:/Users/maple/Library/Developer/CoreSimulator/Devices/C4C39C31-7CEA-42A1-AB8E-0A7DEAF2947E/data/Containers/Data/Application/F42EAE75-C138-4DC6-A5ED-EA83E4FF3543/Documents/ABBFMDBManager/ABBFMDBManager.sql
     
     4、用终端查看数据信息（也可以下载安装 Navicat Preminum）：
     
     切换文件位置：
     $ cd /Users/maple/Library/Developer/CoreSimulator/Devices/C4C39C31-7CEA-42A1-AB8E-0A7DEAF2947E/data/Containers/Data/Application/C1C282CC-B940-45BA-896E-FD3D313D0A4B/Documents/ABBFMDBManager/
     
     打开数据库命令：
     $ sqlite3 ABBFMDBManager.sql
     
     查询Person表格字段信息命令：
     sqlite> PRAGMA table_info (Person);
     
     查询Person所有信息命令：
     sqlite> select * from Person;
     
     查询Person  pid = 1所有House表信息命令：
     sqlite> select * from House where pid = 1;
     
     
     */

    
    
}


#pragma mark - 字典模型存储
- (void)dicModelSave {
    [Person mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"clothes" : @"clothes"
                 };
    }];
    
    NSDictionary *dateDic = @{
                              @"name" : @"小明",
                              @"age" : @10,
                              @"house" : @{
                                      @"address" : @"大厦路201号"
                                      },
                              @"clothes" : @[ @{@"name" : @"上衣",@"color" : @"蓝色" },@{@"name" : @"裤子",@"color" : @"黄色" }]
                              
                              };
    
    //创建所有模型文件空表
    Person *personInit = [[Person alloc] init];
    House *houseInit = [[House alloc] init];
    clothes *clothesInit = [[clothes alloc] init];
    personInit.house = houseInit;
    personInit.clothes = @[clothesInit];
    
    
    //MJ 一行代码解析模型包含模型，包含数组模型解析方法，超赞
    Person *person = [Person mj_objectWithKeyValues:dateDic];
    person.hostID = 2;
    NSLog(@"person=%@", person);
    
    
    Person *person2 = [[Person alloc] init];
    person2.hostID = 1;
    person2.name = @"冯成林";
    person2.age = 28;
    person2.house =  person.house;
    person2.clothes =  person.clothes;
    /** Insert */
    
    [Person save:person2 resBlock:^(BOOL res) {
        //        [self show:res];
    }];
    
    //上面解析完成就已经存储成功（model继承CoreModel），如果继承NSObject就不会存储。
    [Person save:person resBlock:^(BOOL res) {
        
        [self show:res];
    }];
    
    [Person selectWhere:nil groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
        
        NSLog(@"%@",selectResults);
    }];
    

}

@end
