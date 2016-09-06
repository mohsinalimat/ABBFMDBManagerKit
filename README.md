# ABBFMDBManagerKit

## 使用方法：

### 结合MJExtension解析数据，CoreModel操作表格的方法，实现从解析到存取操作服务

***********

# [MJExtension](https://github.com/CoderMJLee/MJExtension)

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
