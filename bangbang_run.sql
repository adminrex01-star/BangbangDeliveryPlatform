/*
 Navicat Premium Dump SQL

 Source Server         : bangbang_run
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : bangbang_run

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 17/06/2026 02:40:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单唯一标识',
  `publisher_id` bigint UNSIGNED NOT NULL COMMENT '发布者用户ID',
  `runner_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '接单员ID（未接单时为NULL）',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务描述',
  `pickup_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pickup_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取货码',
  `destination` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '目的地',
  `deadline` datetime NOT NULL COMMENT '截止时间',
  `reward` decimal(10, 2) NOT NULL COMMENT '悬赏金额（跑腿费）',
  `publish_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态：0-待接单，1-进行中，2-已完成，3-已取消',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_publisher_id`(`publisher_id` ASC) USING BTREE,
  INDEX `idx_runner_id`(`runner_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_publish_time`(`publish_time` ASC) USING BTREE,
  INDEX `idx_order_status_reward`(`status` ASC, `reward` ASC) USING BTREE,
  CONSTRAINT `fk_order_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_order_runner` FOREIGN KEY (`runner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 391 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '跑腿订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (201, 1, 5, '取快递', '南门快递站', 'A123', '12号楼302', '2026-04-12 18:00:00', 8.00, '2026-04-11 10:00:00', 3, NULL);
INSERT INTO `order` VALUES (202, 2, 5, '食堂代购', '二食堂', NULL, '15号楼205', '2026-04-11 13:00:00', 5.00, '2026-04-11 11:00:00', 1, '2026-06-14 23:15:32');
INSERT INTO `order` VALUES (203, 3, 13, '打印取件', '北门打印店', 'P456', '逸夫楼505', '2026-04-12 10:00:00', 10.00, '2026-04-11 12:00:00', 2, '2026-04-11 15:00:00');
INSERT INTO `order` VALUES (204, 4, NULL, '买药', '校医院', NULL, '7号楼101', '2026-04-11 15:30:00', 12.00, '2026-04-11 08:00:00', 3, NULL);
INSERT INTO `order` VALUES (205, 5, 18, '还充电宝', '图书馆', 'B023', '无需送回', '2026-04-11 20:00:00', 3.00, '2026-04-11 14:00:00', 2, '2026-06-17 01:43:18');
INSERT INTO `order` VALUES (291, 8, NULL, '取快递，中通，箱子较重', '南门快递站', '3-2-1008', '12号楼302宿舍', '2026-06-15 01:04:07', 8.00, '2026-04-11 09:23:15', 0, NULL);
INSERT INTO `order` VALUES (292, 10, NULL, '食堂打包黄焖鸡米饭，微辣多加土豆', '二食堂一楼黄焖鸡窗口', NULL, '15号楼205', '2026-04-11 13:00:00', 5.00, '2026-04-11 10:15:42', 3, NULL);
INSERT INTO `order` VALUES (293, 11, NULL, '取论文并装订，共3本', '北门打印店', 'P12345', '逸夫楼A座505', '2026-04-12 10:00:00', 10.00, '2026-04-11 11:05:33', 3, NULL);
INSERT INTO `order` VALUES (294, 12, NULL, '买感冒药（感康+润喉糖）', '校医院药房', NULL, '7号楼101', '2026-04-11 15:30:00', 12.00, '2026-04-11 08:40:10', 3, NULL);
INSERT INTO `order` VALUES (295, 14, NULL, '归还怪兽充电宝', '图书馆二楼借还柜', 'B023', '无需送回', '2026-04-11 20:00:00', 3.00, '2026-04-11 14:22:01', 3, NULL);
INSERT INTO `order` VALUES (296, 15, NULL, '买5斤新鲜草莓', '校门口水果摊', NULL, '研究生公寓B栋201', '2026-04-12 12:00:00', 6.00, '2026-04-11 16:18:55', 3, NULL);
INSERT INTO `order` VALUES (297, 16, NULL, '搬一箱书上楼', '图书馆一楼大厅', NULL, '第二教学楼310', '2026-04-11 17:45:00', 7.00, '2026-04-11 10:30:22', 3, NULL);
INSERT INTO `order` VALUES (298, 17, NULL, '取干洗外套两件', '干洗店（西门）', '凭手机号取', '19号楼612', '2026-04-12 14:00:00', 5.00, '2026-04-11 12:07:44', 3, NULL);
INSERT INTO `order` VALUES (299, 19, NULL, '代排队买限量手办', '校内潮玩店', NULL, '不用送，拍视频证明', '2026-04-13 09:00:00', 30.00, '2026-04-11 18:50:03', 3, NULL);
INSERT INTO `order` VALUES (300, 20, NULL, '送文件到教务处盖章后带回', '学生活动中心210', NULL, '行政楼306（教务处）', '2026-04-11 16:00:00', 15.00, '2026-04-11 09:05:19', 3, NULL);
INSERT INTO `order` VALUES (301, 23, 5, '取韵达快递，包裹不大', '菜鸟驿站', '6-3-2211', '8号楼404', '2026-04-11 19:00:00', 8.00, '2026-04-11 13:20:33', 2, '2026-06-16 01:29:42');
INSERT INTO `order` VALUES (302, 25, 9, '买牛肉面（二两，不要香菜）', '一食堂二楼牛肉面窗口', NULL, '10号楼505', '2026-04-11 12:40:00', 4.00, '2026-04-11 11:40:15', 1, NULL);
INSERT INTO `order` VALUES (303, 27, 13, '超市代购：可乐2瓶、薯片1包、面包1袋', '校内超市', NULL, '3号楼202', '2026-04-11 14:00:00', 6.00, '2026-04-11 10:55:28', 1, NULL);
INSERT INTO `order` VALUES (304, 29, 18, '取实验室样本（-20度冰箱）送至生科院', '实验楼C座303', NULL, '生科院主楼201', '2026-04-11 16:30:00', 12.00, '2026-04-11 09:30:47', 1, NULL);
INSERT INTO `order` VALUES (305, 31, 21, '归还街电充电宝', '西门超市入口', 'X037', '无', '2026-04-11 15:00:00', 3.00, '2026-04-11 13:15:22', 1, NULL);
INSERT INTO `order` VALUES (306, 33, 22, '取现金500元（卡尾号1234）', '建设银行ATM（南门）', NULL, '11号楼301', '2026-04-11 18:00:00', 8.00, '2026-04-11 14:50:11', 1, NULL);
INSERT INTO `order` VALUES (307, 34, 24, '图书馆占靠窗位置并看包到17点', '图书馆三楼东区', NULL, '图书馆三楼东区', '2026-04-11 17:00:00', 10.00, '2026-04-11 08:15:09', 1, NULL);
INSERT INTO `order` VALUES (308, 36, 26, '取无法开机的电脑（联想小新）送修', '13号楼402', NULL, '电脑维修店（北门）', '2026-04-12 20:00:00', 20.00, '2026-04-11 12:45:33', 1, NULL);
INSERT INTO `order` VALUES (309, 38, 28, '帮遛柯基一小时（操场）', '15号楼楼下', NULL, '操场草坪', '2026-04-11 17:30:00', 15.00, '2026-04-11 15:20:44', 1, NULL);
INSERT INTO `order` VALUES (310, 39, 30, '开综测证明盖章后送到学生活动中心', '学院办公楼205', NULL, '学生活动中心前台', '2026-04-11 16:20:00', 6.00, '2026-04-11 10:05:12', 1, NULL);
INSERT INTO `order` VALUES (311, 1, 32, '取圆通快递（鞋盒大小）', '近邻宝快递柜', 'A231', '6号楼205', '2026-04-10 18:00:00', 5.00, '2026-04-10 14:20:33', 2, '2026-04-10 17:35:21');
INSERT INTO `order` VALUES (312, 2, 35, '买珍珠奶茶和椰果奶茶各一杯', '蜜雪冰城（校内店）', NULL, '4号楼501', '2026-04-10 15:30:00', 4.00, '2026-04-10 12:45:55', 2, '2026-04-10 15:20:10');
INSERT INTO `order` VALUES (313, 3, 37, '取书籍包裹并寄到省外', '9号楼215', NULL, '邮政快递点', '2026-04-09 18:30:00', 10.00, '2026-04-09 10:00:00', 2, '2026-04-09 17:50:30');
INSERT INTO `order` VALUES (314, 4, 40, '买香蕉一把、苹果4个', '校门口水果店', NULL, '16号楼309', '2026-04-09 12:00:00', 5.00, '2026-04-09 09:15:22', 2, '2026-04-09 11:45:17');
INSERT INTO `order` VALUES (315, 5, 1, '取干洗羽绒服', '干洗店（南门）', '凭手机号后四位', '2号楼602', '2026-04-08 14:00:00', 6.00, '2026-04-08 11:30:44', 2, '2026-04-08 13:50:29');
INSERT INTO `order` VALUES (316, 6, 2, '搬桶装水到5楼', '水站（东门）', NULL, '17号楼503', '2026-04-08 11:00:00', 8.00, '2026-04-08 09:20:15', 2, '2026-04-08 10:55:03');
INSERT INTO `order` VALUES (317, 7, 4, '代上高数课（周二3-4节）并签到', '第二教学楼203', NULL, '无需送东西', '2026-04-07 11:40:00', 20.00, '2026-04-07 08:00:33', 2, '2026-04-07 11:45:22');
INSERT INTO `order` VALUES (318, 9, 5, '取成绩单送到教务处', '学生公寓18号楼101', NULL, '行政楼306', '2026-04-07 16:00:00', 12.00, '2026-04-07 13:20:47', 2, '2026-04-07 15:40:11');
INSERT INTO `order` VALUES (319, 13, 9, '买创可贴和碘伏棉签', '校医院药房', NULL, '5号楼207', '2026-04-06 20:00:00', 4.00, '2026-04-06 18:15:29', 2, '2026-04-06 19:50:08');
INSERT INTO `order` VALUES (320, 18, 13, '代排队买两杯网红奶茶', '商场内奶茶店（校外）', NULL, '带回校内东门', '2026-04-06 15:30:00', 15.00, '2026-04-06 12:10:55', 2, '2026-04-06 15:25:33');
INSERT INTO `order` VALUES (321, 21, 18, '取中通快递，生活用品', '中通快递点', 'ZT1122', '4号楼207', '2026-04-11 15:00:00', 6.00, '2026-04-10 09:00:00', 2, '2026-04-11 14:30:00');
INSERT INTO `order` VALUES (322, 22, 21, '食堂代买：两份黄焖鸡米饭', '二食堂一楼', NULL, '7号楼305', '2026-04-10 13:00:00', 5.00, '2026-04-10 11:00:00', 2, '2026-04-10 12:45:00');
INSERT INTO `order` VALUES (323, 24, 22, '打印取件：论文3份', '打印店（北门）', 'P3456', '逸夫楼B座201', '2026-04-10 16:00:00', 8.00, '2026-04-10 10:30:00', 2, '2026-04-10 15:50:00');
INSERT INTO `order` VALUES (324, 26, 24, '帮买药：布洛芬一盒', '校医院', NULL, '15号楼109', '2026-04-09 20:00:00', 5.00, '2026-04-09 18:00:00', 2, '2026-04-09 19:30:00');
INSERT INTO `order` VALUES (325, 28, 26, '代还充电宝（来电）', '图书馆二楼', 'L8899', '无', '2026-04-09 22:00:00', 3.00, '2026-04-09 20:15:00', 2, '2026-04-09 21:45:00');
INSERT INTO `order` VALUES (326, 30, 28, '取干洗衣服（羽绒服）', '干洗店（西门）', '凭手机号后四位', '8号楼402', '2026-04-08 14:00:00', 6.00, '2026-04-08 11:00:00', 2, '2026-04-08 13:50:00');
INSERT INTO `order` VALUES (327, 32, 30, '帮搬桶装水（1桶）', '水站', NULL, '12号楼601', '2026-04-08 11:30:00', 5.00, '2026-04-08 09:30:00', 2, '2026-04-08 11:20:00');
INSERT INTO `order` VALUES (328, 35, 32, '代取现金300元', '建设银行ATM', NULL, '5号楼203', '2026-04-07 18:00:00', 6.00, '2026-04-07 16:00:00', 2, '2026-04-07 17:45:00');
INSERT INTO `order` VALUES (329, 37, 35, '实验室取样送检', '实验楼A座303', NULL, '生科院分析中心', '2026-04-07 15:00:00', 10.00, '2026-04-07 13:00:00', 2, '2026-04-07 14:45:00');
INSERT INTO `order` VALUES (330, 40, 37, '帮买水果：草莓2斤', '校门口水果摊', NULL, '10号楼206', '2026-04-06 19:00:00', 6.00, '2026-04-06 17:00:00', 2, '2026-04-06 18:50:00');
INSERT INTO `order` VALUES (331, 8, NULL, '取快递但找不到取件码', '顺丰快递点', '丢失', '14号楼205', '2026-04-11 12:00:00', 6.00, '2026-04-10 20:00:00', 3, NULL);
INSERT INTO `order` VALUES (332, 10, NULL, '代买午餐但发布者取消', '食堂', NULL, '1号楼', '2026-04-10 13:00:00', 5.00, '2026-04-10 11:22:33', 3, NULL);
INSERT INTO `order` VALUES (333, 11, 5, '送钥匙但舍友提前回来了', '图书馆', NULL, '宿舍楼', '2026-04-09 18:00:00', 8.00, '2026-04-09 17:00:44', 3, NULL);
INSERT INTO `order` VALUES (334, 12, 9, '还充电宝但自己还了', '教学楼', NULL, '不用送', '2026-04-08 14:00:00', 3.00, '2026-04-08 13:15:55', 3, NULL);
INSERT INTO `order` VALUES (335, 14, 13, '买药但校医院关门', '校医院', NULL, '宿舍', '2026-04-07 19:00:00', 10.00, '2026-04-07 18:30:22', 3, NULL);
INSERT INTO `order` VALUES (336, 15, 18, '修电脑但不需要了', '宿舍', NULL, '维修店', '2026-04-06 15:00:00', 15.00, '2026-04-06 10:45:33', 3, NULL);
INSERT INTO `order` VALUES (337, 16, 21, '遛宠物但宠物生病', '操场', NULL, '宠物医院', '2026-04-05 17:00:00', 15.00, '2026-04-05 16:20:44', 3, NULL);
INSERT INTO `order` VALUES (338, 17, 22, '开证明但辅导员不在', '学院楼', NULL, '行政楼', '2026-04-04 10:00:00', 6.00, '2026-04-04 08:55:11', 3, NULL);
INSERT INTO `order` VALUES (339, 19, 24, '取快递但快递未到', '快递站', '无效', '宿舍', '2026-04-03 18:00:00', 5.00, '2026-04-03 16:10:55', 3, NULL);
INSERT INTO `order` VALUES (340, 20, 26, '食堂代购但发布者取消', '食堂', NULL, '宿舍', '2026-04-02 12:00:00', 4.00, '2026-04-02 11:20:22', 3, NULL);
INSERT INTO `order` VALUES (341, 8, NULL, '取快递，中通，箱子较重', '南门快递站', '3-2-1008', '12号楼302宿舍', '2026-04-12 18:00:00', 8.00, '2026-04-11 09:23:15', 3, NULL);
INSERT INTO `order` VALUES (342, 10, NULL, '食堂打包黄焖鸡米饭，微辣多加土豆', '二食堂一楼黄焖鸡窗口', NULL, '15号楼205', '2026-04-11 13:00:00', 5.00, '2026-04-11 10:15:42', 3, NULL);
INSERT INTO `order` VALUES (343, 11, NULL, '取论文并装订，共3本', '北门打印店', 'P12345', '逸夫楼A座505', '2026-04-12 10:00:00', 10.00, '2026-04-11 11:05:33', 3, NULL);
INSERT INTO `order` VALUES (344, 12, NULL, '买感冒药（感康+润喉糖）', '校医院药房', NULL, '7号楼101', '2026-04-11 15:30:00', 12.00, '2026-04-11 08:40:10', 3, NULL);
INSERT INTO `order` VALUES (345, 14, NULL, '归还怪兽充电宝', '图书馆二楼借还柜', 'B023', '无需送回', '2026-04-11 20:00:00', 3.00, '2026-04-11 14:22:01', 3, NULL);
INSERT INTO `order` VALUES (346, 15, NULL, '买5斤新鲜草莓', '校门口水果摊', NULL, '研究生公寓B栋201', '2026-04-12 12:00:00', 6.00, '2026-04-11 16:18:55', 3, NULL);
INSERT INTO `order` VALUES (347, 16, NULL, '搬一箱书上楼', '图书馆一楼大厅', NULL, '第二教学楼310', '2026-04-11 17:45:00', 7.00, '2026-04-11 10:30:22', 3, NULL);
INSERT INTO `order` VALUES (348, 17, NULL, '取干洗外套两件', '干洗店（西门）', '凭手机号取', '19号楼612', '2026-04-12 14:00:00', 5.00, '2026-04-11 12:07:44', 3, NULL);
INSERT INTO `order` VALUES (349, 19, NULL, '代排队买限量手办', '校内潮玩店', NULL, '不用送，拍视频证明', '2026-04-13 09:00:00', 30.00, '2026-04-11 18:50:03', 3, NULL);
INSERT INTO `order` VALUES (350, 20, NULL, '送文件到教务处盖章后带回', '学生活动中心210', NULL, '行政楼306（教务处）', '2026-04-11 16:00:00', 15.00, '2026-04-11 09:05:19', 3, NULL);
INSERT INTO `order` VALUES (351, 23, 5, '取韵达快递，包裹不大', '菜鸟驿站', '6-3-2211', '8号楼404', '2026-04-11 19:00:00', 8.00, '2026-04-11 13:20:33', 1, NULL);
INSERT INTO `order` VALUES (352, 25, 9, '买牛肉面（二两，不要香菜）', '一食堂二楼牛肉面窗口', NULL, '10号楼505', '2026-04-11 12:40:00', 4.00, '2026-04-11 11:40:15', 1, NULL);
INSERT INTO `order` VALUES (353, 27, 13, '超市代购：可乐2瓶、薯片1包、面包1袋', '校内超市', NULL, '3号楼202', '2026-04-11 14:00:00', 6.00, '2026-04-11 10:55:28', 1, NULL);
INSERT INTO `order` VALUES (354, 29, 18, '取实验室样本（-20度冰箱）送至生科院', '实验楼C座303', NULL, '生科院主楼201', '2026-04-11 16:30:00', 12.00, '2026-04-11 09:30:47', 1, NULL);
INSERT INTO `order` VALUES (355, 31, 21, '归还街电充电宝', '西门超市入口', 'X037', '无', '2026-04-11 15:00:00', 3.00, '2026-04-11 13:15:22', 1, NULL);
INSERT INTO `order` VALUES (356, 33, 22, '取现金500元（卡尾号1234）', '建设银行ATM（南门）', NULL, '11号楼301', '2026-04-11 18:00:00', 8.00, '2026-04-11 14:50:11', 1, NULL);
INSERT INTO `order` VALUES (357, 34, 24, '图书馆占靠窗位置并看包到17点', '图书馆三楼东区', NULL, '图书馆三楼东区', '2026-04-11 17:00:00', 10.00, '2026-04-11 08:15:09', 1, NULL);
INSERT INTO `order` VALUES (358, 36, 26, '取无法开机的电脑（联想小新）送修', '13号楼402', NULL, '电脑维修店（北门）', '2026-04-12 20:00:00', 20.00, '2026-04-11 12:45:33', 1, NULL);
INSERT INTO `order` VALUES (359, 38, 28, '帮遛柯基一小时（操场）', '15号楼楼下', NULL, '操场草坪', '2026-04-11 17:30:00', 15.00, '2026-04-11 15:20:44', 1, NULL);
INSERT INTO `order` VALUES (360, 39, 30, '开综测证明盖章后送到学生活动中心', '学院办公楼205', NULL, '学生活动中心前台', '2026-04-11 16:20:00', 6.00, '2026-04-11 10:05:12', 1, NULL);
INSERT INTO `order` VALUES (361, 1, 32, '取圆通快递（鞋盒大小）', '近邻宝快递柜', 'A231', '6号楼205', '2026-04-10 18:00:00', 5.00, '2026-04-10 14:20:33', 2, '2026-04-10 17:35:21');
INSERT INTO `order` VALUES (362, 2, 35, '买珍珠奶茶和椰果奶茶各一杯', '蜜雪冰城（校内店）', NULL, '4号楼501', '2026-04-10 15:30:00', 4.00, '2026-04-10 12:45:55', 2, '2026-04-10 15:20:10');
INSERT INTO `order` VALUES (363, 3, 37, '取书籍包裹并寄到省外', '9号楼215', NULL, '邮政快递点', '2026-04-09 18:30:00', 10.00, '2026-04-09 10:00:00', 2, '2026-04-09 17:50:30');
INSERT INTO `order` VALUES (364, 4, 40, '买香蕉一把、苹果4个', '校门口水果店', NULL, '16号楼309', '2026-04-09 12:00:00', 5.00, '2026-04-09 09:15:22', 2, '2026-04-09 11:45:17');
INSERT INTO `order` VALUES (365, 5, 1, '取干洗羽绒服', '干洗店（南门）', '凭手机号后四位', '2号楼602', '2026-04-08 14:00:00', 6.00, '2026-04-08 11:30:44', 2, '2026-04-08 13:50:29');
INSERT INTO `order` VALUES (366, 6, 2, '搬桶装水到5楼', '水站（东门）', NULL, '17号楼503', '2026-04-08 11:00:00', 8.00, '2026-04-08 09:20:15', 2, '2026-04-08 10:55:03');
INSERT INTO `order` VALUES (367, 7, 4, '代上高数课（周二3-4节）并签到', '第二教学楼203', NULL, '无需送东西', '2026-04-07 11:40:00', 20.00, '2026-04-07 08:00:33', 2, '2026-04-07 11:45:22');
INSERT INTO `order` VALUES (368, 9, 5, '取成绩单送到教务处', '学生公寓18号楼101', NULL, '行政楼306', '2026-04-07 16:00:00', 12.00, '2026-04-07 13:20:47', 2, '2026-04-07 15:40:11');
INSERT INTO `order` VALUES (369, 13, 9, '买创可贴和碘伏棉签', '校医院药房', NULL, '5号楼207', '2026-04-06 20:00:00', 4.00, '2026-04-06 18:15:29', 2, '2026-04-06 19:50:08');
INSERT INTO `order` VALUES (370, 18, 13, '代排队买两杯网红奶茶', '商场内奶茶店（校外）', NULL, '带回校内东门', '2026-04-06 15:30:00', 15.00, '2026-04-06 12:10:55', 2, '2026-04-06 15:25:33');
INSERT INTO `order` VALUES (371, 21, 18, '取中通快递，生活用品', '中通快递点', 'ZT1122', '4号楼207', '2026-04-11 15:00:00', 6.00, '2026-04-10 09:00:00', 2, '2026-04-11 14:30:00');
INSERT INTO `order` VALUES (372, 22, 21, '食堂代买：两份黄焖鸡米饭', '二食堂一楼', NULL, '7号楼305', '2026-04-10 13:00:00', 5.00, '2026-04-10 11:00:00', 2, '2026-04-10 12:45:00');
INSERT INTO `order` VALUES (373, 24, 22, '打印取件：论文3份', '打印店（北门）', 'P3456', '逸夫楼B座201', '2026-04-10 16:00:00', 8.00, '2026-04-10 10:30:00', 2, '2026-04-10 15:50:00');
INSERT INTO `order` VALUES (374, 26, 24, '帮买药：布洛芬一盒', '校医院', NULL, '15号楼109', '2026-04-09 20:00:00', 5.00, '2026-04-09 18:00:00', 2, '2026-04-09 19:30:00');
INSERT INTO `order` VALUES (375, 28, 26, '代还充电宝（来电）', '图书馆二楼', 'L8899', '无', '2026-04-09 22:00:00', 3.00, '2026-04-09 20:15:00', 2, '2026-04-09 21:45:00');
INSERT INTO `order` VALUES (376, 30, 28, '取干洗衣服（羽绒服）', '干洗店（西门）', '凭手机号后四位', '8号楼402', '2026-04-08 14:00:00', 6.00, '2026-04-08 11:00:00', 2, '2026-04-08 13:50:00');
INSERT INTO `order` VALUES (377, 32, 30, '帮搬桶装水（1桶）', '水站', NULL, '12号楼601', '2026-04-08 11:30:00', 5.00, '2026-04-08 09:30:00', 2, '2026-04-08 11:20:00');
INSERT INTO `order` VALUES (378, 35, 32, '代取现金300元', '建设银行ATM', NULL, '5号楼203', '2026-04-07 18:00:00', 6.00, '2026-04-07 16:00:00', 2, '2026-04-07 17:45:00');
INSERT INTO `order` VALUES (379, 37, 35, '实验室取样送检', '实验楼A座303', NULL, '生科院分析中心', '2026-04-07 15:00:00', 10.00, '2026-04-07 13:00:00', 2, '2026-04-07 14:45:00');
INSERT INTO `order` VALUES (380, 40, 37, '帮买水果：草莓2斤', '校门口水果摊', NULL, '10号楼206', '2026-04-06 19:00:00', 6.00, '2026-04-06 17:00:00', 2, '2026-04-06 18:50:00');
INSERT INTO `order` VALUES (381, 8, NULL, '取快递但找不到取件码', '顺丰快递点', '丢失', '14号楼205', '2026-04-11 12:00:00', 6.00, '2026-04-10 20:00:00', 3, NULL);
INSERT INTO `order` VALUES (382, 10, NULL, '代买午餐但发布者取消', '食堂', NULL, '1号楼', '2026-04-10 13:00:00', 5.00, '2026-04-10 11:22:33', 3, NULL);
INSERT INTO `order` VALUES (383, 11, 5, '送钥匙但舍友提前回来了', '图书馆', NULL, '宿舍楼', '2026-04-09 18:00:00', 8.00, '2026-04-09 17:00:44', 3, NULL);
INSERT INTO `order` VALUES (384, 12, 9, '还充电宝但自己还了', '教学楼', NULL, '不用送', '2026-04-08 14:00:00', 3.00, '2026-04-08 13:15:55', 3, NULL);
INSERT INTO `order` VALUES (385, 14, 13, '买药但校医院关门', '校医院', NULL, '宿舍', '2026-04-07 19:00:00', 10.00, '2026-04-07 18:30:22', 3, NULL);
INSERT INTO `order` VALUES (386, 15, 18, '修电脑但不需要了', '宿舍', NULL, '维修店', '2026-04-06 15:00:00', 15.00, '2026-04-06 10:45:33', 3, NULL);
INSERT INTO `order` VALUES (387, 16, 21, '遛宠物但宠物生病', '操场', NULL, '宠物医院', '2026-04-05 17:00:00', 15.00, '2026-04-05 16:20:44', 3, NULL);
INSERT INTO `order` VALUES (388, 17, 22, '开证明但辅导员不在', '学院楼', NULL, '行政楼', '2026-04-04 10:00:00', 6.00, '2026-04-04 08:55:11', 3, NULL);
INSERT INTO `order` VALUES (389, 19, 24, '取快递但快递未到', '快递站', '无效', '宿舍', '2026-04-03 18:00:00', 5.00, '2026-04-03 16:10:55', 3, NULL);
INSERT INTO `order` VALUES (390, 20, 26, '食堂代购但发布者取消', '食堂', NULL, '宿舍', '2026-04-02 12:00:00', 4.00, '2026-04-02 11:20:22', 3, NULL);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价唯一标识',
  `order_id` bigint UNSIGNED NOT NULL COMMENT '订单ID',
  `publisher_id` bigint UNSIGNED NOT NULL COMMENT '评价人（发布者）',
  `runner_id` bigint UNSIGNED NOT NULL COMMENT '被评价接单员',
  `rating` tinyint NOT NULL COMMENT '评分：1-5星',
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文字评论',
  `review_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_runner_id`(`runner_id` ASC) USING BTREE,
  INDEX `fk_review_publisher`(`publisher_id` ASC) USING BTREE,
  CONSTRAINT `fk_review_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_review_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_review_runner` FOREIGN KEY (`runner_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单评价' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, 203, 3, 13, 5, '跑腿小哥非常负责，帮我仔细核对实验样本，准时送达，好评！', '2026-04-11 18:30:00');
INSERT INTO `review` VALUES (2, 311, 1, 32, 4, '取快递速度很快，但是箱子稍微有点压痕，不影响使用，总体不错。', '2026-04-10 19:00:00');
INSERT INTO `review` VALUES (3, 312, 2, 35, 5, '奶茶买得很及时，口味完全正确，谢谢！', '2026-04-10 16:00:00');
INSERT INTO `review` VALUES (4, 313, 3, 37, 4, '帮忙寄快递，包装很仔细，价格合理，就是稍微晚了一点。', '2026-04-09 18:30:00');
INSERT INTO `review` VALUES (5, 314, 4, 40, 5, '水果很新鲜，挑的苹果和香蕉都很好，下次还找你。', '2026-04-09 12:30:00');
INSERT INTO `review` VALUES (6, 315, 5, 1, 5, '干洗店取衣服，非常细心，衣服叠得很整齐。', '2026-04-08 14:30:00');
INSERT INTO `review` VALUES (7, 316, 6, 2, 4, '搬水上楼辛苦了，不过稍微有点慢，总体满意。', '2026-04-08 11:30:00');
INSERT INTO `review` VALUES (8, 317, 7, 4, 5, '代签到很顺利，老师没发现，帮大忙了！', '2026-04-07 12:00:00');
INSERT INTO `review` VALUES (9, 318, 9, 5, 5, '成绩单及时送到教务处，办事效率高。', '2026-04-07 16:30:00');
INSERT INTO `review` VALUES (10, 319, 13, 9, 4, '药品买对了，但是包装有点简陋，不影响使用。', '2026-04-06 20:30:00');
INSERT INTO `review` VALUES (11, 320, 18, 13, 5, '网红奶茶排队很久，但跑腿毫无怨言，态度很好。', '2026-04-06 16:00:00');
INSERT INTO `review` VALUES (12, 321, 21, 18, 5, '快递取件迅速，送到宿舍楼下，很满意。', '2026-04-11 15:00:00');
INSERT INTO `review` VALUES (13, 322, 22, 21, 5, '黄焖鸡米饭味道很好，送得也快。', '2026-04-10 13:30:00');
INSERT INTO `review` VALUES (14, 323, 24, 22, 4, '论文打印装订质量不错，就是有一页有点歪，不影响阅读。', '2026-04-10 16:30:00');
INSERT INTO `review` VALUES (15, 324, 26, 24, 5, '买药很及时，还提醒我按时吃药，暖心。', '2026-04-09 20:00:00');
INSERT INTO `review` VALUES (16, 325, 28, 26, 5, '还充电宝很顺利，效率高。', '2026-04-09 22:30:00');
INSERT INTO `review` VALUES (17, 326, 30, 28, 5, '干洗衣服取回，干净整洁，好评。', '2026-04-08 14:30:00');
INSERT INTO `review` VALUES (18, 327, 32, 30, 4, '搬水上楼，速度可以，但是稍微有点水洒出来，不严重。', '2026-04-08 11:50:00');
INSERT INTO `review` VALUES (19, 328, 35, 32, 5, '代取现金，安全送到，非常可靠。', '2026-04-07 18:30:00');
INSERT INTO `review` VALUES (20, 329, 37, 35, 5, '实验室取样送检，过程规范，数据准确。', '2026-04-07 15:30:00');
INSERT INTO `review` VALUES (21, 330, 40, 37, 5, '草莓很新鲜，分量足，下次还找你买水果。', '2026-04-06 19:30:00');
INSERT INTO `review` VALUES (22, 361, 1, 32, 5, '第二次合作了，依然很满意，快递包装完好。', '2026-04-11 14:00:00');
INSERT INTO `review` VALUES (23, 362, 2, 35, 4, '奶茶味道对，但稍微有点洒出来，希望注意。', '2026-04-10 16:00:00');
INSERT INTO `review` VALUES (24, 363, 3, 37, 5, '寄快递很专业，还帮我省了包装费。', '2026-04-09 18:00:00');
INSERT INTO `review` VALUES (25, 364, 4, 40, 5, '水果新鲜，价格公道，很满意。', '2026-04-09 12:00:00');
INSERT INTO `review` VALUES (26, 365, 5, 1, 5, '干洗店服务一如既往地好。', '2026-04-08 14:00:00');
INSERT INTO `review` VALUES (27, 366, 6, 2, 4, '搬水辛苦了，但是时间比约定晚了20分钟。', '2026-04-08 11:00:00');
INSERT INTO `review` VALUES (28, 367, 7, 4, 5, '代签到很稳，谢谢。', '2026-04-07 12:00:00');
INSERT INTO `review` VALUES (29, 368, 9, 5, 5, '成绩单及时送到，非常靠谱。', '2026-04-07 16:00:00');
INSERT INTO `review` VALUES (30, 369, 13, 9, 5, '药品买得很及时，还帮我看了生产日期。', '2026-04-06 20:00:00');
INSERT INTO `review` VALUES (31, 370, 18, 13, 5, '奶茶味道很棒，排队辛苦啦。', '2026-04-06 16:00:00');
INSERT INTO `review` VALUES (32, 371, 21, 18, 5, '快递取件很快，服务态度好。', '2026-04-11 15:30:00');
INSERT INTO `review` VALUES (33, 372, 22, 21, 5, '黄焖鸡米饭味道好，送得准时。', '2026-04-10 13:00:00');
INSERT INTO `review` VALUES (34, 373, 24, 22, 4, '打印论文，装订不错，但有一页模糊。', '2026-04-10 16:00:00');
INSERT INTO `review` VALUES (35, 374, 26, 24, 5, '买药及时，还提醒我注意事项。', '2026-04-09 19:30:00');
INSERT INTO `review` VALUES (36, 375, 28, 26, 5, '还充电宝，效率很高。', '2026-04-09 22:00:00');
INSERT INTO `review` VALUES (37, 376, 30, 28, 5, '干洗衣服取回，很干净。', '2026-04-08 14:00:00');
INSERT INTO `review` VALUES (38, 377, 32, 30, 4, '搬水稍慢，但态度好。', '2026-04-08 11:30:00');
INSERT INTO `review` VALUES (39, 378, 35, 32, 5, '取现金安全快捷。', '2026-04-07 18:00:00');
INSERT INTO `review` VALUES (40, 379, 37, 35, 5, '实验室样本送检，非常专业。', '2026-04-07 15:00:00');
INSERT INTO `review` VALUES (41, 380, 40, 37, 5, '草莓很甜，分量足，好评。', '2026-04-06 19:00:00');
INSERT INTO `review` VALUES (43, 202, 2, 9, 5, '测试触发器', '2026-06-14 23:38:14');

-- ----------------------------
-- Table structure for runner_auth
-- ----------------------------
DROP TABLE IF EXISTS `runner_auth`;
CREATE TABLE `runner_auth`  (
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户ID，与user表一对一',
  `id_card_no` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `id_card_front_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证正面照URL',
  `id_card_back_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证反面照URL',
  `handheld_photo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手持证件照URL',
  `audit_status` tinyint NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-通过，2-拒绝',
  `wallet_balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '钱包余额',
  `avg_rating` decimal(2, 1) NOT NULL DEFAULT 0.0 COMMENT '平均评分',
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `fk_runner_auth_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '接单员实名认证信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of runner_auth
-- ----------------------------
INSERT INTO `runner_auth` VALUES (1, '410115201203310001', 'https://example.com/idcard/1_front.jpg', 'https://example.com/idcard/1_back.jpg', 'https://example.com/handheld/1.jpg', 1, 200.00, 4.8);
INSERT INTO `runner_auth` VALUES (2, '410116201304010002', 'https://example.com/idcard/2_front.jpg', 'https://example.com/idcard/2_back.jpg', 'https://example.com/handheld/2.jpg', 1, 125.50, 4.6);
INSERT INTO `runner_auth` VALUES (3, '410117201405020003', 'https://example.com/idcard/3_front.jpg', 'https://example.com/idcard/3_back.jpg', 'https://example.com/handheld/3.jpg', 0, 0.00, 0.0);
INSERT INTO `runner_auth` VALUES (4, '410118201506030004', 'https://example.com/idcard/4_front.jpg', 'https://example.com/idcard/4_back.jpg', 'https://example.com/handheld/4.jpg', 1, 340.00, 4.9);
INSERT INTO `runner_auth` VALUES (5, '410101199505154321', 'https://example.com/idcard/5_front.jpg', 'https://example.com/idcard/5_back.jpg', 'https://example.com/handheld/5.jpg', 1, 158.00, 4.7);
INSERT INTO `runner_auth` VALUES (6, '410119201607040005', 'https://example.com/idcard/6_front.jpg', 'https://example.com/idcard/6_back.jpg', 'https://example.com/handheld/6.jpg', 1, 67.80, 4.5);
INSERT INTO `runner_auth` VALUES (7, '410120201708050006', 'https://example.com/idcard/7_front.jpg', 'https://example.com/idcard/7_back.jpg', 'https://example.com/handheld/7.jpg', 2, 0.00, 0.0);
INSERT INTO `runner_auth` VALUES (9, '410102199812126789', 'https://example.com/idcard/9_front.jpg', 'https://example.com/idcard/9_back.jpg', 'https://example.com/handheld/9.jpg', 1, 95.50, 4.7);
INSERT INTO `runner_auth` VALUES (13, '410103200003034567', 'https://example.com/idcard/13_front.jpg', 'https://example.com/idcard/13_back.jpg', 'https://example.com/handheld/13.jpg', 1, 230.00, 4.9);
INSERT INTO `runner_auth` VALUES (18, '410104200110155678', 'https://example.com/idcard/18_front.jpg', 'https://example.com/idcard/18_back.jpg', 'https://example.com/handheld/18.jpg', 1, 316.20, 4.8);
INSERT INTO `runner_auth` VALUES (21, '410105200205207890', 'https://example.com/idcard/21_front.jpg', 'https://example.com/idcard/21_back.jpg', 'https://example.com/handheld/21.jpg', 1, 67.30, 4.6);
INSERT INTO `runner_auth` VALUES (22, '410106200303228901', 'https://example.com/idcard/22_front.jpg', 'https://example.com/idcard/22_back.jpg', 'https://example.com/handheld/22.jpg', 1, 124.00, 4.4);
INSERT INTO `runner_auth` VALUES (24, '410107200407239012', 'https://example.com/idcard/24_front.jpg', 'https://example.com/idcard/24_back.jpg', 'https://example.com/handheld/24.jpg', 1, 45.80, 4.9);
INSERT INTO `runner_auth` VALUES (26, '410108200508240123', 'https://example.com/idcard/26_front.jpg', 'https://example.com/idcard/26_back.jpg', 'https://example.com/handheld/26.jpg', 1, 198.00, 4.7);
INSERT INTO `runner_auth` VALUES (28, '410109200609251234', 'https://example.com/idcard/28_front.jpg', 'https://example.com/idcard/28_back.jpg', 'https://example.com/handheld/28.jpg', 1, 302.50, 4.8);
INSERT INTO `runner_auth` VALUES (30, '410110200710262345', 'https://example.com/idcard/30_front.jpg', 'https://example.com/idcard/30_back.jpg', 'https://example.com/handheld/30.jpg', 1, 77.20, 4.5);
INSERT INTO `runner_auth` VALUES (32, '410111200811272456', 'https://example.com/idcard/32_front.jpg', 'https://example.com/idcard/32_back.jpg', 'https://example.com/handheld/32.jpg', 1, 186.00, 4.6);
INSERT INTO `runner_auth` VALUES (35, '410112200912282567', 'https://example.com/idcard/35_front.jpg', 'https://example.com/idcard/35_back.jpg', 'https://example.com/handheld/35.jpg', 1, 55.30, 4.7);
INSERT INTO `runner_auth` VALUES (37, '410113201001292678', 'https://example.com/idcard/37_front.jpg', 'https://example.com/idcard/37_back.jpg', 'https://example.com/handheld/37.jpg', 1, 410.00, 4.9);
INSERT INTO `runner_auth` VALUES (40, '410114201102302789', 'https://example.com/idcard/40_front.jpg', 'https://example.com/idcard/40_back.jpg', 'https://example.com/handheld/40.jpg', 1, 99.90, 4.5);

-- ----------------------------
-- Table structure for runner_tag
-- ----------------------------
DROP TABLE IF EXISTS `runner_tag`;
CREATE TABLE `runner_tag`  (
  `runner_id` bigint UNSIGNED NOT NULL COMMENT '接单员ID',
  `tag_id` bigint UNSIGNED NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`runner_id`, `tag_id`) USING BTREE,
  INDEX `fk_runner_tag_tag`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `fk_runner_tag_runner` FOREIGN KEY (`runner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_runner_tag_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '接单员所拥有的服务标签' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of runner_tag
-- ----------------------------
INSERT INTO `runner_tag` VALUES (1, 1);
INSERT INTO `runner_tag` VALUES (9, 1);
INSERT INTO `runner_tag` VALUES (28, 1);
INSERT INTO `runner_tag` VALUES (1, 2);
INSERT INTO `runner_tag` VALUES (9, 2);
INSERT INTO `runner_tag` VALUES (30, 2);
INSERT INTO `runner_tag` VALUES (2, 3);
INSERT INTO `runner_tag` VALUES (9, 3);
INSERT INTO `runner_tag` VALUES (32, 3);
INSERT INTO `runner_tag` VALUES (6, 4);
INSERT INTO `runner_tag` VALUES (13, 4);
INSERT INTO `runner_tag` VALUES (28, 4);
INSERT INTO `runner_tag` VALUES (1, 5);
INSERT INTO `runner_tag` VALUES (2, 5);
INSERT INTO `runner_tag` VALUES (13, 5);
INSERT INTO `runner_tag` VALUES (30, 5);
INSERT INTO `runner_tag` VALUES (3, 6);
INSERT INTO `runner_tag` VALUES (13, 6);
INSERT INTO `runner_tag` VALUES (32, 6);
INSERT INTO `runner_tag` VALUES (3, 7);
INSERT INTO `runner_tag` VALUES (18, 7);
INSERT INTO `runner_tag` VALUES (35, 7);
INSERT INTO `runner_tag` VALUES (4, 8);
INSERT INTO `runner_tag` VALUES (18, 8);
INSERT INTO `runner_tag` VALUES (30, 8);
INSERT INTO `runner_tag` VALUES (5, 9);
INSERT INTO `runner_tag` VALUES (18, 9);
INSERT INTO `runner_tag` VALUES (35, 9);
INSERT INTO `runner_tag` VALUES (5, 10);
INSERT INTO `runner_tag` VALUES (21, 10);
INSERT INTO `runner_tag` VALUES (5, 11);
INSERT INTO `runner_tag` VALUES (21, 11);
INSERT INTO `runner_tag` VALUES (35, 11);
INSERT INTO `runner_tag` VALUES (6, 12);
INSERT INTO `runner_tag` VALUES (21, 12);
INSERT INTO `runner_tag` VALUES (37, 12);
INSERT INTO `runner_tag` VALUES (6, 13);
INSERT INTO `runner_tag` VALUES (22, 13);
INSERT INTO `runner_tag` VALUES (4, 14);
INSERT INTO `runner_tag` VALUES (22, 14);
INSERT INTO `runner_tag` VALUES (37, 14);
INSERT INTO `runner_tag` VALUES (7, 15);
INSERT INTO `runner_tag` VALUES (22, 15);
INSERT INTO `runner_tag` VALUES (2, 16);
INSERT INTO `runner_tag` VALUES (24, 16);
INSERT INTO `runner_tag` VALUES (37, 16);
INSERT INTO `runner_tag` VALUES (3, 17);
INSERT INTO `runner_tag` VALUES (24, 17);
INSERT INTO `runner_tag` VALUES (40, 17);
INSERT INTO `runner_tag` VALUES (7, 18);
INSERT INTO `runner_tag` VALUES (26, 18);
INSERT INTO `runner_tag` VALUES (40, 18);
INSERT INTO `runner_tag` VALUES (4, 19);
INSERT INTO `runner_tag` VALUES (26, 19);
INSERT INTO `runner_tag` VALUES (26, 20);
INSERT INTO `runner_tag` VALUES (40, 20);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签唯一标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名称，如“代取快递”',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '服务标签' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, '快递取件', '代取快递站包裹，送至宿舍楼下或指定地点');
INSERT INTO `tag` VALUES (2, '食堂代购', '代买食堂饭菜，可指定窗口和菜品');
INSERT INTO `tag` VALUES (3, '文件急送', '紧急文件/资料同城速递，优先处理');
INSERT INTO `tag` VALUES (4, '超市代买', '代购校内超市或周边便利店商品');
INSERT INTO `tag` VALUES (5, '打印取件', '代取打印店文档，可要求装订');
INSERT INTO `tag` VALUES (6, '图书馆占座', '代占图书馆座位，需提前沟通位置偏好');
INSERT INTO `tag` VALUES (7, '代上课签到', '代签到、答到（仅限大课，不违规前提下）');
INSERT INTO `tag` VALUES (8, '药店买药', '代买常用药品，需提供药品名或图片');
INSERT INTO `tag` VALUES (9, '水果代购', '代买新鲜水果，可指定品种和重量');
INSERT INTO `tag` VALUES (10, '实验室取样', '代送实验样本至指定实验室或办公楼');
INSERT INTO `tag` VALUES (11, '宿舍搬迁', '帮助搬运小件行李、书籍等');
INSERT INTO `tag` VALUES (12, '取干洗衣服', '代取干洗店送洗衣物');
INSERT INTO `tag` VALUES (13, '代寄快递', '帮忙打包寄件，填写快递单');
INSERT INTO `tag` VALUES (14, '帮取现金', '代去ATM取现金（需信任）');
INSERT INTO `tag` VALUES (15, '代还充电宝', '归还共享充电宝至附近机柜');
INSERT INTO `tag` VALUES (16, '代修电脑', '帮忙送修电脑或取回维修设备');
INSERT INTO `tag` VALUES (17, '代排队', '代排队购买限量商品、活动入场等');
INSERT INTO `tag` VALUES (18, '帮遛宠物', '短期帮忙遛狗、喂猫等（仅限校内）');
INSERT INTO `tag` VALUES (19, '代开证明', '代去行政楼/学院盖章、取证明文件');
INSERT INTO `tag` VALUES (20, '帮搬饮用水', '帮忙搬运桶装水上楼');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户唯一标识',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `register_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `account_status` tinyint NOT NULL DEFAULT 1 COMMENT '账号状态：1-正常，0-禁用',
  `is_runner` tinyint NOT NULL DEFAULT 0 COMMENT '是否为接单员：1-是，0-否',
  `balance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '用户余额（用于发布订单）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `uk_student_id`(`student_id` ASC) USING BTREE,
  INDEX `idx_is_runner`(`is_runner` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户基本信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '13800138001', '20240001', '张三', 'http://example.com/avatar1.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (2, '13800138002', '20240002', '李四', 'http://example.com/avatar2.jpg', '2026-04-11 13:48:45', 1, 1, 95.00);
INSERT INTO `user` VALUES (3, '13800138003', '20240003', '王五', 'http://example.com/avatar3.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (4, '13800138004', '20240004', '赵六', 'http://example.com/avatar4.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (5, '13800138005', '20240005', '陈七', 'http://example.com/avatar5.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (6, '13800138006', '20240006', '林八', 'http://example.com/avatar6.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (7, '13800138007', '20240007', '黄九', 'http://example.com/avatar7.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (8, '13800138008', '20240008', '周十', 'http://example.com/avatar8.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (9, '13800138009', '20240009', '吴一', 'http://example.com/avatar9.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (10, '13800138010', '20240010', '郑二', 'http://example.com/avatar10.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (11, '13800138011', '20240011', '孙三', 'http://example.com/avatar11.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (12, '13800138012', '20240012', '李四光', 'http://example.com/avatar12.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (13, '13800138013', '20240013', '王思聪', 'http://example.com/avatar13.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (14, '13800138014', '20240014', '赵丽颖', 'http://example.com/avatar14.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (15, '13800138015', '20240015', '陈奕迅', 'http://example.com/avatar15.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (16, '13800138016', '20240016', '林俊杰', 'http://example.com/avatar16.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (17, '13800138017', '20240017', '周杰伦', 'http://example.com/avatar17.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (18, '13800138018', '20240018', '吴彦祖', 'http://example.com/avatar18.jpg', '2026-04-11 13:48:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (19, '13800138019', '20240019', '张学友', 'http://example.com/avatar19.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (20, '13800138020', '20240020', '刘德华', 'http://example.com/avatar20.jpg', '2026-04-11 13:48:45', 1, 0, 0.00);
INSERT INTO `user` VALUES (21, '13812340001', '202410001', '张明', 'https://example.com/avatar/zhangming.jpg', '2025-10-15 10:23:00', 1, 1, 0.00);
INSERT INTO `user` VALUES (22, '13912340002', '202410002', '李芳', 'https://example.com/avatar/lifang.jpg', '2025-11-02 14:50:12', 1, 1, 0.00);
INSERT INTO `user` VALUES (23, '15012340003', '202410003', '王磊', 'https://example.com/avatar/wanglei.jpg', '2025-12-20 09:15:33', 1, 0, 0.00);
INSERT INTO `user` VALUES (24, '15112340004', '202410004', '赵丽颖', 'https://example.com/avatar/zhaoliying.jpg', '2025-09-05 18:40:22', 1, 1, 0.00);
INSERT INTO `user` VALUES (25, '15212340005', '202410005', '陈浩', 'https://example.com/avatar/chenhao.jpg', '2025-08-11 07:55:01', 1, 0, 0.00);
INSERT INTO `user` VALUES (26, '15312340006', '202410006', '周敏', 'https://example.com/avatar/zhoumin.jpg', '2025-12-01 20:30:45', 1, 1, 0.00);
INSERT INTO `user` VALUES (27, '15512340007', '202410007', '吴杰', 'https://example.com/avatar/wujie.jpg', '2025-10-28 12:12:12', 0, 0, 0.00);
INSERT INTO `user` VALUES (28, '15612340008', '202410008', '郑爽', 'https://example.com/avatar/zhengshuang.jpg', '2025-11-19 16:05:30', 1, 1, 0.00);
INSERT INTO `user` VALUES (29, '15712340009', '202410009', '林晨', 'https://example.com/avatar/linichen.jpg', '2025-09-22 08:48:00', 1, 0, 0.00);
INSERT INTO `user` VALUES (30, '15812340010', '202410010', '郭峰', 'https://example.com/avatar/guofeng.jpg', '2025-07-30 22:15:47', 1, 1, 0.00);
INSERT INTO `user` VALUES (31, '15912340011', '202410011', '唐雅', 'https://example.com/avatar/tangya.jpg', '2025-12-05 11:20:34', 1, 0, 0.00);
INSERT INTO `user` VALUES (32, '17612340012', '202410012', '孙阳', 'https://example.com/avatar/sunyang.jpg', '2025-10-10 13:45:22', 1, 1, 0.00);
INSERT INTO `user` VALUES (33, '17712340013', '202410013', '朱莉', 'https://example.com/avatar/zhuli.jpg', '2025-08-19 19:00:00', 1, 0, 0.00);
INSERT INTO `user` VALUES (34, '17812340014', '202410014', '沈梦', 'https://example.com/avatar/shenmeng.jpg', '2025-11-28 06:30:55', 0, 0, 0.00);
INSERT INTO `user` VALUES (35, '18012340015', '202410015', '韩梅', 'https://example.com/avatar/hanmei.jpg', '2025-09-14 15:10:10', 1, 1, 0.00);
INSERT INTO `user` VALUES (36, '18112340016', '202410016', '崔健', 'https://example.com/avatar/cuijian.jpg', '2025-12-18 23:59:59', 1, 0, 0.00);
INSERT INTO `user` VALUES (37, '18212340017', '202410017', '贾玲', 'https://example.com/avatar/jialing.jpg', '2025-10-25 17:22:33', 1, 1, 0.00);
INSERT INTO `user` VALUES (38, '18312340018', '202410018', '宋阳', 'https://example.com/avatar/songyang.jpg', '2025-08-02 04:45:12', 1, 0, 0.00);
INSERT INTO `user` VALUES (39, '18412340019', '202410019', '白杨', 'https://example.com/avatar/baiyang.jpg', '2025-11-11 21:18:44', 1, 0, 0.00);
INSERT INTO `user` VALUES (40, '18512340020', '202410020', '欧阳雪', 'https://example.com/avatar/ouyangxue.jpg', '2025-12-25 12:00:00', 1, 1, 0.00);

-- ----------------------------
-- View structure for v_order_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_order_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_order_detail` AS select `o`.`id` AS `订单编号`,`o`.`description` AS `任务描述`,`o`.`reward` AS `悬赏金额`,(case `o`.`status` when 0 then '待接单' when 1 then '进行中' when 2 then '已完成' when 3 then '已取消' end) AS `订单状态`,`o`.`deadline` AS `截止时间`,`o`.`publish_time` AS `发布时间`,`o`.`complete_time` AS `完成时间`,`p`.`name` AS `发布者姓名`,`p`.`phone` AS `发布者手机号`,`r`.`name` AS `接单员姓名`,`r`.`phone` AS `接单员手机号`,`rev`.`rating` AS `评价评分`,`rev`.`comment` AS `评价内容` from (((`order` `o` left join `user` `p` on((`o`.`publisher_id` = `p`.`id`))) left join `user` `r` on((`o`.`runner_id` = `r`.`id`))) left join `review` `rev` on((`o`.`id` = `rev`.`order_id`)));

-- ----------------------------
-- View structure for v_runner_performance
-- ----------------------------
DROP VIEW IF EXISTS `v_runner_performance`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_runner_performance` AS select `u`.`id` AS `runner_id`,`u`.`name` AS `runner_name`,`u`.`phone` AS `phone`,`ra`.`avg_rating` AS `avg_rating`,`ra`.`wallet_balance` AS `wallet_balance`,count(`o`.`id`) AS `total_completed_orders`,ifnull(sum(`o`.`reward`),0) AS `total_earnings` from ((`user` `u` join `runner_auth` `ra` on((`u`.`id` = `ra`.`user_id`))) left join `order` `o` on(((`u`.`id` = `o`.`runner_id`) and (`o`.`status` = 2)))) where (`u`.`is_runner` = 1) group by `u`.`id`,`u`.`name`,`u`.`phone`,`ra`.`avg_rating`,`ra`.`wallet_balance`;

-- ----------------------------
-- Procedure structure for accept_order
-- ----------------------------
DROP PROCEDURE IF EXISTS `accept_order`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_order`(
    IN p_order_id BIGINT UNSIGNED,
    IN p_runner_id BIGINT UNSIGNED,
    OUT p_result VARCHAR(100)
)
BEGIN
    DECLARE v_publisher_id BIGINT UNSIGNED;
    DECLARE v_reward DECIMAL(10,2);
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_status TINYINT;

    -- 查询订单信息
    SELECT publisher_id, reward, status 
    INTO v_publisher_id, v_reward, v_status
    FROM `order` WHERE id = p_order_id;

    -- 判断订单状态是否为待接单(0)
    IF v_status != 0 THEN
        SET p_result = '订单状态不是待接单，无法接单';
    ELSE
        -- 查询发布者余额
        SELECT balance INTO v_balance FROM user WHERE id = v_publisher_id;
        -- 判断余额是否足够支付悬赏金额
        IF v_balance >= v_reward THEN
            -- 扣发布者余额
            UPDATE user SET balance = balance - v_reward WHERE id = v_publisher_id;
            -- 更新订单：设置接单员、状态变为进行中
            UPDATE `order` SET runner_id = p_runner_id, status = 1 WHERE id = p_order_id;
            SET p_result = '接单成功';
        ELSE
            SET p_result = '余额不足，无法下单';
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for complete_order_and_settle
-- ----------------------------
DROP PROCEDURE IF EXISTS `complete_order_and_settle`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `complete_order_and_settle`(
    IN p_order_id BIGINT UNSIGNED
)
BEGIN
    -- 所有 DECLARE 必须放在最前面
    DECLARE v_runner_id BIGINT UNSIGNED;
    DECLARE v_reward DECIMAL(10,2);
    DECLARE v_current_status TINYINT;

    -- 获取订单信息
    SELECT runner_id, reward, status 
    INTO v_runner_id, v_reward, v_current_status
    FROM `order`
    WHERE id = p_order_id;

    -- 业务逻辑判断
    IF v_runner_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '订单尚未被接单，无法完成';
    END IF;

    IF v_current_status != 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '订单状态不是进行中，无法完成';
    END IF;

    -- 多表操作
    UPDATE `order`
    SET status = 2, complete_time = NOW()
    WHERE id = p_order_id;

    UPDATE runner_auth
    SET wallet_balance = wallet_balance + v_reward
    WHERE user_id = v_runner_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for complete_order_and_settle_with_tx
-- ----------------------------
DROP PROCEDURE IF EXISTS `complete_order_and_settle_with_tx`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `complete_order_and_settle_with_tx`(IN p_order_id BIGINT UNSIGNED)
BEGIN
    DECLARE v_runner_id BIGINT UNSIGNED;
    DECLARE v_reward DECIMAL(10,2);
    DECLARE v_current_status TINYINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT runner_id, reward, status 
    INTO v_runner_id, v_reward, v_current_status
    FROM `order`
    WHERE id = p_order_id;

    IF v_runner_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '订单尚未被接单，无法完成';
    END IF;

    IF v_current_status != 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '订单状态不是进行中，无法完成';
    END IF;

    UPDATE `order`
    SET status = 2, complete_time = NOW()
    WHERE id = p_order_id;

    UPDATE runner_auth
    SET wallet_balance = wallet_balance + v_reward
    WHERE user_id = v_runner_id;

    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for get_runner_avg_rating
-- ----------------------------
DROP FUNCTION IF EXISTS `get_runner_avg_rating`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_runner_avg_rating`(runner_id_param BIGINT UNSIGNED) RETURNS decimal(2,1)
    DETERMINISTIC
BEGIN
    DECLARE avg_rating_val DECIMAL(2,1);
    -- 从runner_auth表获取平均评分，如果不存在则返回0.0
    SELECT ROUND(AVG(rating), 1) INTO avg_rating_val
    FROM review
    WHERE runner_id = runner_id_param;
    -- 若没有评价记录，则为NULL，转为0.0
    IF avg_rating_val IS NULL THEN
        SET avg_rating_val = 0.0;
    END IF;
    RETURN avg_rating_val;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for test_rollback
-- ----------------------------
DROP PROCEDURE IF EXISTS `test_rollback`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_rollback`(IN p_order_id BIGINT UNSIGNED)
BEGIN
    -- 声明错误处理：发生任何SQL异常时回滚并重新抛出错误
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- 第一步：更新订单状态为2
    UPDATE `order`
    SET status = 2, complete_time = NOW()
    WHERE id = p_order_id;

    -- 第二步：故意制造一个错误（向不存在的表插入数据）
    INSERT INTO not_exist_table VALUES (1);

    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for expire_pending_orders
-- ----------------------------
DROP EVENT IF EXISTS `expire_pending_orders`;
delimiter ;;
CREATE EVENT `expire_pending_orders`
ON SCHEDULE
EVERY '1' DAY STARTS '2026-06-15 02:00:00'
DO BEGIN
    UPDATE `order`
    SET status = 3
    WHERE status = 0 AND deadline < NOW();
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table review
-- ----------------------------
DROP TRIGGER IF EXISTS `after_review_insert`;
delimiter ;;
CREATE TRIGGER `after_review_insert` AFTER INSERT ON `review` FOR EACH ROW BEGIN
    DECLARE new_avg DECIMAL(2,1);
    -- 计算该接单员所有评价的平均分
    SELECT ROUND(AVG(rating), 1) INTO new_avg
    FROM review
    WHERE runner_id = NEW.runner_id;
    -- 更新runner_auth的avg_rating
    UPDATE runner_auth
    SET avg_rating = new_avg
    WHERE user_id = NEW.runner_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
