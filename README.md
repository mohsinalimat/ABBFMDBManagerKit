# ABBFMDBManagerKit

## 使用方法：

### 结合MJExtension解析数据，CoreModel操作表格的方法，实现从解析到存取操作服务

***********

# [MJExtension](https://github.com/CoderMJLee/MJExtension)

### 解析数据<--->模型：

[MJExtension](https://github.com/CoderMJLee/MJExtension)  
 安装：pod 'MJExtension'
     
     
- MJExtension是一套字典和模型之间互相转换的超轻量级框架
* `JSON` --> `Model`、`Core Data Model`
* `JSONString` --> `Model`、`Core Data Model`
* `Model`、`Core Data Model` --> `JSON`
* `JSON Array` --> `Model Array`、`Core Data Model Array`
* `JSONString` --> `Model Array`、`Core Data Model Array`
* `Model Array`、`Core Data Model Array` --> `JSON Array`
* Coding all properties of model in one line code.
    * 只需要一行代码，就能实现模型的所有属性进行Coding（归档和解档）

相关功能：

* 【最简单的字典转模型】<a id="JSON_Model"></a> The most simple JSON -> Model
* 【JSON字符串转模型】<a id="JSONString_Model"></a> JSONString -> Model
* 【模型中嵌套模型】<a id="Model_contains_model"></a> Model contains model
* 【模型中的属性名和字典中的key不相同(或者需要多级映射)】<a id="Model_name_JSON_key_mapping"></a> Model name - JSON key mapping
* 【将一个字典数组转成模型数组】<a id="JSON_array_model_array"></a> JSON array -> model array
* 【将一个模型转成字典】<a id="Model_JSON"></a> Model -> JSON
* 【将一个模型数组转成字典数组】<a id="Model_array_JSON_array"></a> Model array -> JSON array
* 【统一转换属性名（比如驼峰转下划线）】<a id="Camel_underline"></a> Camel -> underline
* 【过滤字典的值（比如字符串日期处理为NSDate、字符串nil处理为@""）】<a id="NSString_NSDate"></a> NSString -> NSDate, nil -> @""

#  [CoreModel](https://github.com/CharlinFeng/CoreModel)

### 多层嵌套模型存取，增删改查，图片存取

下载：[CoreModel](https://github.com/CharlinFeng/CoreModel)
      
* 全自动创表
* 调试模式与非调试模式
* 全部子线程运行 + Block回调，性能卓越！
* 模型字段检查，全自动增加字段
* 基本模型 + 单条数据插入
* 基本模型 + 批量数据插入
* 基本模型 + 单条数据修改
* 基本模型 + 批量数据修改
* 基本模型 + 单条数据保存
* 基本模型 + 条件删除
* 基本模型 + 条件查询
* 基本模型 + 清空表数据
* 属性为单模型级联：数据插入（级联模型请一定要全部是CoreModel的子类！）


# 使用方法

## 创建模型：

        //  Person.h

        #import <Foundation/Foundation.h>
        #import "CoreModel.h"
        #import "House.h"
        #import "clothes.h"

        //人
        @interface Person : CoreModel
        @property (strong,nonatomic) NSString *name;
        @property (nonatomic,assign) NSInteger age;
        @property (strong,nonatomic) House *house;
        @property (strong,nonatomic) NSArray *clothes;

        @end

        //  Person.m
        @implementation Person
        +(NSDictionary *)statementForNSArrayProperties{
        return @{@"clothes":NSStringFromClass([clothes class])};
        }

        //房屋
        @interface House : CoreModel
        @property (strong,nonatomic) NSString* address;
        @end

        //衣服
        @interface clothes : CoreModel
        @property (strong,nonatomic) NSString *name;
        @property (strong,nonatomic) NSString *color;

## 创建控制器：

        #import "CommonVC.h"
        @interface ViewController : CommonVC
        @end


        //  ViewController.m

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







