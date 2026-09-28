# 校园帮帮跑跑腿服务系统 (Campus Bangbang Delivery Platform)

这是一个基于 **Java + MySQL** 的数据库课程设计期末大作业。本项目打通了“界面 -> 业务逻辑 -> 数据库”的完整链路，实现了一个简易的校园跑腿业务管理系统（控制台程序）。

## 🛠️ 技术栈
- **开发语言**: Java (JDK 8+)
- **数据库**: MySQL (8.4+)
- **数据库连接**: JDBC (mysql-connector-j 8.0.33)
- **项目管理**: Maven
- **IDE**: IntelliJ IDEA / Navicat (数据库管理)

## ✨ 核心功能
1. **基础交互（查询与展示）**
   - 用户信息查询：输入学号或手机号，使用 `PreparedStatement` 防SQL注入查询并显示。
   - 动态列表展示：调用预定义的视图，在控制台打印“任务大厅”和“接单员排行榜”。
2. **业务调用（存储过程对接）**
   - 通过 `CallableStatement` 调用数据库存储过程。
   - **接单 (accept_order)**: 检查发布者余额，满足条件则扣款并更新订单状态，否则返回“余额不足，无法下单”。
   - **完成订单并结算 (complete_order_and_settle_with_tx)**: 使用事务保证订单状态更新和接单员钱包余额增加的一致性。
3. **简单的报错处理**
   - 使用标准的 `try-catch` 块包裹数据库操作，捕获外键冲突、连接断开等异常，并输出友好的错误提示而非程序闪退。

## 🗄️ 数据库设计亮点
- **6张数据表**：完整体现了 1:1、1:N、M:N 关系，主外键约束准确。
- **2个视图 (Views)**：
  - `v_order_detail`：订单详情视图（多表连接，简化Java端查询）。
  - `v_runner_performance`：接单员业绩统计视图（聚合统计，提供排行榜数据）。
- **2个存储过程 (Stored Procedures)**：
  - `accept_order`：封装接单动作，包含业务逻辑验证（IF...ELSE）。
  - `complete_order_and_settle_with_tx`：包含事务处理，确保订单完成与资金结算的原子性。
- **1个触发器 (Trigger)**：评价后自动更新接单员的平均评分。

## 🚀 快速开始

### 1. 环境准备
- 确保本地已安装 MySQL 8.0+ 和 JDK 8+。
- 准备好 Maven 环境。

### 2. 数据库初始化
1. 打开 Navicat 或其他 MySQL 客户端。
2. 新建一个数据库（如 `bangbang_run`）。（本数据库纯虚构，使用时按照自己的情况填入数据）
3. 导入项目根目录下的 `bangbang_run.sql` 文件（该文件包含建表、20条测试数据、视图、存储过程和触发器）。

### 3. 修改数据库配置
在 Java 项目中找到数据库连接工具类（或主类中的连接代码），修改为你的本地数据库配置：
```java
String url = "jdbc:mysql://localhost:3306/bangbang_run?useSSL=false&serverTimezone=Asia/Shanghai";
String username = "你的MySQL用户名";
String password = "你的MySQL密码";