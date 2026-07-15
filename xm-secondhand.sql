/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : xm-secondhand

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 15/07/2026 12:17:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Contact Name',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Address',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Phone Number',
  `user_id` int NULL DEFAULT NULL COMMENT 'Associated User ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (2, 'acc', 'Geylang, Singapore', '13899775566', 4);
INSERT INTO `address` VALUES (5, 'aaa', 'Geylang, Singapore', '13877668877', 1);
INSERT INTO `address` VALUES (7, 'qwe', 'Geylang, Singapore', '13988776622', 7);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', 'admin', 'http://localhost:9090/files/1711332061088-QQ截图20230330090913.png', 'ADMIN', '13988997799', 'aaa@xm.com');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Fashion');
INSERT INTO `category` VALUES (2, 'Home & Living');
INSERT INTO `category` VALUES (3, 'Laptops & Tablets');
INSERT INTO `category` VALUES (4, 'Electronic devices');
INSERT INTO `category` VALUES (5, 'E-Bikes');
INSERT INTO `category` VALUES (6, 'Bikes');
INSERT INTO `category` VALUES (7, 'Football');
INSERT INTO `category` VALUES (8, 'Basketball');
INSERT INTO `category` VALUES (9, 'Musical Instruments');
INSERT INTO `category` VALUES (10, 'Headphones & Speakers');
INSERT INTO `category` VALUES (11, 'Books');
INSERT INTO `category` VALUES (12, 'Clothes');

-- ----------------------------
-- Table structure for chat_group
-- ----------------------------
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `chat_user_id` int NULL DEFAULT NULL COMMENT '聊天用户ID',
  `user_id` int NULL DEFAULT NULL COMMENT '当前用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group
-- ----------------------------
INSERT INTO `chat_group` VALUES (1, 5, 1);
INSERT INTO `chat_group` VALUES (6, 1, 5);
INSERT INTO `chat_group` VALUES (7, 4, 5);
INSERT INTO `chat_group` VALUES (8, 5, 4);
INSERT INTO `chat_group` VALUES (9, 1, 7);
INSERT INTO `chat_group` VALUES (10, 7, 1);
INSERT INTO `chat_group` VALUES (11, 4, 1);
INSERT INTO `chat_group` VALUES (12, 1, 4);

-- ----------------------------
-- Table structure for chat_info
-- ----------------------------
DROP TABLE IF EXISTS `chat_info`;
CREATE TABLE `chat_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `chat_user_id` int NULL DEFAULT NULL COMMENT '聊天用户ID',
  `user_id` int NULL DEFAULT NULL COMMENT '当前用户ID',
  `text` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '聊天内容',
  `isread` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '否' COMMENT '是否已读',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_info
-- ----------------------------
INSERT INTO `chat_info` VALUES (1, 5, 1, '123', '是', '2026-06-29 09:43:25');
INSERT INTO `chat_info` VALUES (2, 1, 5, '333', '是', '2026-06-29 09:45:43');
INSERT INTO `chat_info` VALUES (3, 5, 1, '333333', '是', '2026-06-29 09:46:20');
INSERT INTO `chat_info` VALUES (4, 1, 5, '1111', '是', '2026-06-29 09:51:47');
INSERT INTO `chat_info` VALUES (5, 5, 1, '2222', '是', '2026-06-29 09:51:49');
INSERT INTO `chat_info` VALUES (6, 1, 5, '33333', '是', '2026-06-29 09:51:51');
INSERT INTO `chat_info` VALUES (7, 5, 1, '4444', '是', '2026-06-29 09:51:53');
INSERT INTO `chat_info` VALUES (8, 1, 5, '2222', '是', '2026-06-29 09:52:05');
INSERT INTO `chat_info` VALUES (9, 5, 1, '3333', '是', '2026-06-29 09:52:06');
INSERT INTO `chat_info` VALUES (10, 1, 5, '1231321', '是', '2026-06-29 10:01:11');
INSERT INTO `chat_info` VALUES (11, 5, 1, '5555', '否', '2026-06-29 10:38:35');
INSERT INTO `chat_info` VALUES (12, 5, 1, '3123213213', '否', '2026-06-29 10:43:53');
INSERT INTO `chat_info` VALUES (13, 5, 1, '3132123213213213123213', '否', '2026-06-29 10:44:05');
INSERT INTO `chat_info` VALUES (14, 5, 1, 'rrqwrqrwq', '否', '2026-06-29 10:44:07');
INSERT INTO `chat_info` VALUES (15, 5, 1, 'eqweqee', '否', '2026-06-29 10:44:09');
INSERT INTO `chat_info` VALUES (16, 5, 1, '66666', '否', '2026-06-29 10:44:48');
INSERT INTO `chat_info` VALUES (17, 5, 1, '7777', '否', '2026-06-29 10:44:51');
INSERT INTO `chat_info` VALUES (18, 5, 1, '8888', '否', '2026-06-29 10:44:53');
INSERT INTO `chat_info` VALUES (19, 1, 7, 'Hello', '是', '2026-06-29 11:15:37');
INSERT INTO `chat_info` VALUES (20, 7, 1, 'Yeah', '是', '2026-06-29 11:15:59');
INSERT INTO `chat_info` VALUES (21, 7, 1, 'What do you need?', '是', '2026-06-29 11:16:04');
INSERT INTO `chat_info` VALUES (22, 1, 7, 'I want to buy a guitar', '是', '2026-06-29 11:16:12');

-- ----------------------------
-- Table structure for circles
-- ----------------------------
DROP TABLE IF EXISTS `circles`;
CREATE TABLE `circles`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '缩略图',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '圈子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of circles
-- ----------------------------
INSERT INTO `circles` VALUES (2, 'http://localhost:9090/files/1710666813454-生活服务.png', 'Home & Living');
INSERT INTO `circles` VALUES (3, 'http://localhost:9090/files/1710753648228-书籍.png', 'Books & Textbooks');
INSERT INTO `circles` VALUES (4, 'http://localhost:9090/files/1710746292837-音乐.png', 'Music');
INSERT INTO `circles` VALUES (5, 'http://localhost:9090/files/1710666820607-鼠标.png', 'Electronics');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int NULL DEFAULT NULL COMMENT '关联ID',
  `user_id` int NULL DEFAULT NULL COMMENT '收藏人ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (55, 9, 5, 'goods');
INSERT INTO `collect` VALUES (57, 9, 6, 'goods');
INSERT INTO `collect` VALUES (58, 8, 2, 'goods');
INSERT INTO `collect` VALUES (61, 5, 2, 'goods');
INSERT INTO `collect` VALUES (62, 13, 1, 'goods');
INSERT INTO `collect` VALUES (63, 19, 7, 'goods');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `user_id` int NULL DEFAULT NULL COMMENT '评论人',
  `pid` int NULL DEFAULT NULL COMMENT '父级ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时间',
  `fid` int NULL DEFAULT NULL COMMENT '关联ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  `root_id` int NULL DEFAULT NULL COMMENT '根节点ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '1111', 1, NULL, '2026-07-05 11:42:58', 18, 'goods', 1);
INSERT INTO `comment` VALUES (4, '444', 1, 1, '2026-07-05 11:43:05', 18, 'goods', 1);
INSERT INTO `comment` VALUES (5, '121123123', 1, NULL, '2026-07-07 11:52:21', 8, 'posts', 5);
INSERT INTO `comment` VALUES (6, '4414213421', 1, NULL, '2026-07-07 11:52:22', 8, 'posts', 6);
INSERT INTO `comment` VALUES (7, '44444', 1, NULL, '2026-07-07 11:52:24', 8, 'posts', 7);
INSERT INTO `comment` VALUES (8, '6666', 1, 7, '2026-07-07 11:52:27', 8, 'posts', 7);
INSERT INTO `comment` VALUES (9, '3333', 1, 8, '2026-07-07 11:52:32', 8, 'posts', 7);
INSERT INTO `comment` VALUES (11, '11111', 1, NULL, '2026-07-08 10:05:42', 2, 'help', 11);
INSERT INTO `comment` VALUES (12, '222', 1, NULL, '2026-07-08 10:07:20', 2, 'help', 12);
INSERT INTO `comment` VALUES (13, '3333', 1, NULL, '2026-07-08 10:07:22', 2, 'help', 13);
INSERT INTO `comment` VALUES (14, '4444', 1, NULL, '2026-07-08 10:07:23', 2, 'help', 14);
INSERT INTO `comment` VALUES (15, '5555', 1, NULL, '2026-07-08 10:07:24', 2, 'help', 15);
INSERT INTO `comment` VALUES (16, '666', 1, NULL, '2026-07-08 10:07:25', 2, 'help', 16);
INSERT INTO `comment` VALUES (17, '1111', 1, NULL, '2026-07-08 10:08:09', 9, 'goods', 17);
INSERT INTO `comment` VALUES (18, '222', 1, NULL, '2026-07-08 10:09:15', 9, 'goods', 18);
INSERT INTO `comment` VALUES (19, '333', 1, NULL, '2026-07-08 10:09:16', 9, 'goods', 19);
INSERT INTO `comment` VALUES (20, '4', 1, NULL, '2026-07-08 10:09:17', 9, 'goods', 20);
INSERT INTO `comment` VALUES (21, '5', 1, NULL, '2026-07-08 10:09:18', 9, 'goods', 21);
INSERT INTO `comment` VALUES (22, '6', 1, NULL, '2026-07-08 10:09:19', 9, 'goods', 22);
INSERT INTO `comment` VALUES (23, '1111', 1, NULL, '2026-07-08 10:16:40', 1, 'help', 23);
INSERT INTO `comment` VALUES (27, '1111', 7, NULL, '2026-07-09 11:26:42', 10, 'posts', 27);
INSERT INTO `comment` VALUES (28, '111', 7, NULL, '2026-07-09 11:27:54', 11, 'posts', 28);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主题',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `reply` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '回复',
  `createtime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `user_id` int NULL DEFAULT NULL COMMENT '提交人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '反馈信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (6, 'Apply for a refund', 'There is a dispute and a refund is required.', NULL, NULL, 'Our platform will intervene within 2 minutes to contact you for handling.', '2026-06-22 16:08:41', 1);
INSERT INTO `feedback` VALUES (7, 'Help needed', 'I need the help of the platform.', NULL, NULL, 'You can contact us at 010-65889988.', '2026-06-22 16:09:30', 1);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详情',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货地址',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上架日期',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类',
  `user_id` int NULL DEFAULT NULL COMMENT '所属用户ID',
  `sale_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上架状态',
  `read_count` int NULL DEFAULT 0 COMMENT '浏览量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '二手商品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (2, 'Insta360 Ace Pro 8K Action Camera with Leica Lens', 1998.00, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2208654990728/O1CN014fxPBV1HFTGmsusBp_!!2208654990728.png\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732191721-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\" width=\"100%\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732176479-微信截图_20240318112155.png', '2026-07-10', '通过', 'Musical Instruments', 4, 'Listed', 11);
INSERT INTO `goods` VALUES (3, 'Sony WH-1000XM4 Over-Ear Wireless Bluetooth Headphones with Active Noise Cancellation', 1999.00, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2214661621088/O1CN01SJ2vWm1JuLmc8Migo_!!2214661621088-0-scmitem1000.jpg\" width=\"100%\"/><br/></p>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732446620-微信截图_20240318112705.png', '2026-07-10', '通过', 'Headphones & Speakers', 4, 'Listed', 5);
INSERT INTO `goods` VALUES (4, 'Genuine 2022 Qatar World Cup Soccer Ball (Size 5) - Professional Match & Training Ball', 40.00, '<p><img src=\"https://img.alicdn.com/imgextra/i1/2616970884/O1CN01SPbEn61IOuwP1G1oE_!!2616970884.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732567587-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732543650-微信截图_20240318112858.png', '2026-07-10', '通过', 'Football', 4, 'Listed', 2);
INSERT INTO `goods` VALUES (5, 'Size 5 Training Soccer Ball - Ideal for Middle School Physical Exams', 199.00, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2193975096/O1CN010RF9HT1nW1HJmulLe_!!2193975096-0-scmitem176000.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732634056-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732630892-微信截图_20240318113020.png', '2026-07-10', '通过', 'Football', 4, 'Listed', 9);
INSERT INTO `goods` VALUES (6, 'Authentic Spalding Size 7 Rubber Basketball - Outdoor, Durable & Anti-Slip (Great for Student Training)', 199.00, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2215726198477/O1CN01uDQHZo2CUWMouy2f0_!!2215726198477.jpg\" width=\"100%\"/><img src=\"https://img.alicdn.com/imgextra/i2/2215726198477/O1CN01suxVZE2CUWHaf2Ms0_!!2215726198477.jpg\" style=\"font-size: 14px;\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732721019-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732691542-微信截图_20240318113120.png', '2026-07-10', '通过', 'Basketball', 4, 'Listed', 7);
INSERT INTO `goods` VALUES (7, 'Master-Grade Handcrafted All-Solid Classical Guitar', 1998.00, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2289123357/O1CN01gFdEtC1afYLPtjh3X_!!2289123357.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732813613-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732810749-微信截图_20240318113309.png', '2026-07-10', '通过', 'Musical Instruments', 4, 'Listed', 3);
INSERT INTO `goods` VALUES (8, 'Professional Bitter Bamboo Flute - Entry-Level Transverse Flute for Beginners, Adults & Kids (Keys C/E/F/G)', 199.00, '<p><img src=\"https://img.alicdn.com/imgextra/i1/2417340146/O1CN01nNji0v1CwugZ4snBM_!!2417340146.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732892032-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710732896200-微信截图_20240318113443.png', '2026-07-10', '通过', 'Musical Instruments', 4, 'Listed', 23);
INSERT INTO `goods` VALUES (9, 'Kepma D1C/A1C Acoustic-Electric Guitar - Entry-Level Wooden Guitar for Beginners, Students, Kids & Adults', 648.00, '<p><img src=\"https://img.alicdn.com/imgextra/i1/850320452/O1CN01Me5Rvy1FD3xMD4EOK_!!850320452.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710732996103-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710733003156-微信截图_20240318113621.png', '2026-07-10', '通过', 'Musical Instruments', 4, 'Listed', 59);
INSERT INTO `goods` VALUES (13, 'High-neck sweater', 199.00, '<div><img src=\"https://img30.360buyimg.com/sku/jfs/t1/99760/24/43651/54323/64e2cde4Fbece5bd3/ac96a198fb27780a.jpg\"/>	</div>\n<div><img src=\"https://img30.360buyimg.com/sku/jfs/t1/189762/23/36644/55229/64e2cde4F8786c6ee/8dadfcf2f1c54a99.jpg\"/>	</div>', 'Geylang, Singapore', 'http://localhost:9090/files/1704875358717-微信截图_20240110162417.png', '2026-07-10', '通过', 'Clothes', 4, 'Listed', 27);
INSERT INTO `goods` VALUES (16, 'Keyboard', 200.00, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2212972276013/O1CN013AucSC1uI0SlSDkvD_!!2212972276013.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710756960569-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710756941461-微信截图_20240318181524.png', '2026-07-12', '通过', 'Electronic devices', 5, 'Listed', 79);
INSERT INTO `goods` VALUES (17, 'Higher Mathematics (Tongji University, 7th Edition) Vol. 1 & 2 - Higher Education Press', 30.00, '<p><img src=\"https://img.alicdn.com/imgextra/i2/101450072/O1CN01QxR1em1CP1Gj2vT4A-101450072.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710756616895-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710756599260-微信截图_20240318180909.png', '2026-07-12', '通过', 'Books', 1, 'Listed', 2);
INSERT INTO `goods` VALUES (18, 'Engineering Mathematics: Linear Algebra (Tongji University, 6th Edition) - Higher Education Press', 28.00, '<p><img src=\"https://img.alicdn.com/imgextra/i3/101450072/O1CN01fT1YYK1CP19H32Ph4-101450072.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1710756841433-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1710756827594-微信截图_20240318180926.png', '2026-07-12', '通过', 'Books', 1, 'Listed', 29);
INSERT INTO `goods` VALUES (19, 'One Hundred Years of Solitude (Official Unabridged Chinese Edition)', 39.60, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2129856610/O1CN01z5eg4C1yhQfDUYBh7-2129856610.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1711418486618-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1711418559078-微信截图_20240326100215.png', '2026-07-14', '通过', 'Books', 1, 'Listed', 18);
INSERT INTO `goods` VALUES (20, 'Bluetooth headphones', 188.00, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2204777365052/O1CN01RNP04i1nBrqfMGoQP_!!2204777365052.jpg\" width=\"100%\"/><img src=\"http://localhost:9090/files/1711682539596-image.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/></p><br/>', 'Geylang, Singapore', 'http://localhost:9090/files/1711682485540-蓝牙耳机.png', '2026-07-15', '通过', 'Headphones & Speakers', 7, 'Listed', 1);

-- ----------------------------
-- Table structure for help
-- ----------------------------
DROP TABLE IF EXISTS `help`;
CREATE TABLE `help`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  `solved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否解决',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '求助信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of help
-- ----------------------------
INSERT INTO `help` VALUES (5, 'I want to buy a second-hand mathematics review guide', 'I\'d like to buy a second-hand math tutoring book. It doesn\'t matter whether it\'s new or old. My budget is within 20 dollar', 'http://localhost:9090/files/1782115362298-1710666500025-高数.jpg', '通过', 1, '2026-06-22 16:02:54', '未解决');
INSERT INTO `help` VALUES (6, 'I want a bicycle for transportation', 'A bicycle for transportation, it needs to be in good condition, about 70% to 80%, and the budget is 100 dollar.', 'http://localhost:9090/files/1782115452464-1709087348366-微信截图_20240228102849.png', '通过', 1, '2026-06-22 16:04:50', '已解决');
INSERT INTO `help` VALUES (7, 'I want a keyboard', 'I want a keyboard like the one in the picture.', 'http://localhost:9090/files/1782116207978-1711592732447-微信截图_20240318181524.png', '通过', 4, '2026-06-22 16:16:53', '未解决');
INSERT INTO `help` VALUES (8, 'I want a model airplane', 'I want a model airplane like the one in the picture', 'http://localhost:9090/files/1782116370547-1711682748613-微信截图_20240329112543.png', '通过', 7, '2026-06-22 16:19:33', '未解决');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int NULL DEFAULT NULL COMMENT '关联ID',
  `user_id` int NULL DEFAULT NULL COMMENT '点赞人ID',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '点赞' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (63, 13, 1, 'goods');
INSERT INTO `likes` VALUES (65, 15, 1, 'goods');
INSERT INTO `likes` VALUES (66, 9, 5, 'goods');
INSERT INTO `likes` VALUES (67, 5, 2, 'goods');
INSERT INTO `likes` VALUES (68, 3, 1, 'goods');
INSERT INTO `likes` VALUES (70, 18, 1, 'goods');
INSERT INTO `likes` VALUES (71, 16, 1, 'goods');
INSERT INTO `likes` VALUES (72, 19, 7, 'goods');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (4, 'Limited-time flash sale of popular second-hand items', 'Limited-time flash sale of popular second-hand items. No returns after expiration.', '2026-06-25 09:52:00', 'admin');
INSERT INTO `notice` VALUES (5, 'Today, the discounted items have been put on display', 'Special offer items are now available. Hurry up and snap them up!', '2026-06-25 09:52:00', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品图片',
  `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下单时间',
  `pay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付单号',
  `pay_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付时间',
  `user_id` int NULL DEFAULT NULL COMMENT '下单人ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货地址',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人名称',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  `sale_id` int NULL DEFAULT NULL COMMENT '卖家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (8, 'Keyboard', 'http://localhost:9090/files/1710756941461-微信截图_20240318181524.png', '17114233143372315334', 2000.00, '2026-06-25 11:21:54', NULL, NULL, 1, 'Geylang, Singapore', '13877668877', NULL, '已完成', 5);
INSERT INTO `orders` VALUES (9, 'Spalding Official Size 7 Outdoor Rubber Basketball', 'http://localhost:9090/files/1710732691542-微信截图_20240318113120.png', '17114242903423672645', 199.00, '2026-06-26 11:38:10', '2026062622001446850502106026', '2026-06-27 10:01:53', 1, 'Geylang, Singapore', '13877668877', NULL, '已完成', 4);
INSERT INTO `orders` VALUES (10, 'Sony WH-1000XM4/XM5 Wireless Noise-Canceling Headphones', 'http://localhost:9090/files/1710732446620-微信截图_20240318112705.png', '17115050080087304878', 1999.00, '2026-06-27 10:03:28', '2026062722001446850502102855', '2026-06-27 10:04:03', 1, 'Geylang, Singapore', '13877668877', NULL, '已完成', 4);
INSERT INTO `orders` VALUES (11, 'One Hundred Years of Solitude (Official Unabridged Chinese Edition)', 'http://localhost:9090/files/1711418559078-微信截图_20240326100215.png', '17116822233431580005', 39.60, '2026-06-29 11:17:03', NULL, NULL, 7, 'Geylang, Singapore', '13988776622', NULL, '已取消', 1);
INSERT INTO `orders` VALUES (12, 'One Hundred Years of Solitude (Official Unabridged Chinese Edition)', 'http://localhost:9090/files/1711418559078-微信截图_20240326100215.png', '17116822380876496406', 39.60, '2026-06-29 11:17:18', '2026062922001446850502119105', '2026-06-29 11:19:01', 7, '北京市朝阳区110号', '13988776622', NULL, '已完成', 1);

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  `circle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '圈子',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `read_count` int NULL DEFAULT 0 COMMENT '浏览量',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (2, 'Sell the second-hand desk', '<p>Used desk for sale, letting it go for cheap.</p><p><br/></p><p>Buy link：<a target=\"_blank\" href=\"http://localhost:8080/front/goodsDetail?id=15\">http://localhost:8080/front/goodsDetail?id=15</a></p>', 'http://localhost:9090/files/1710747156996-微信截图_20240318153220.png', 1, '2026-06-20 15:35:08', 'Home & Living', 'A desk of good quality that doesn\'t take too long to assemble', 8, '通过');
INSERT INTO `posts` VALUES (5, 'Handling of unused clothes hangers', '<p>Letting go of some unused hangers. Selling them cheap, great quality guaranteed. Come check them out!</p><p><br/></p><p>Buy link：<a target=\"_blank\" href=\"http://localhost:8080/front/goodsDetail?id=15\">http://localhost:8080/front/goodsDetail?id=15</a></p>', 'http://localhost:9090/files/1710746994883-微信截图_20240318152948.png', 1, '2026-06-20 15:35:08', 'Home & Living', 'Unused clothes hangers for sale at a low price', 9, '通过');
INSERT INTO `posts` VALUES (6, 'Idle disposal, guitar instruments', '<p>This guitar has top-notch craftsmanship, letting it go for cheap now.</p><p><span style=\"font-size: 14px;\"><br/></span></p><p><span style=\"font-size: 14px;\">Buy link</span>：<a target=\"_blank\" href=\"http://localhost:8080/front/goodsDetail?id=15\">http://localhost:8080/front/goodsDetail?id=15</a></p>', 'http://localhost:9090/files/1710746904876-微信截图_20240318113309.png', 1, '2026-06-20 15:35:08', 'Music', 'The guitar instrument is priced reasonably', 11, '通过');
INSERT INTO `posts` VALUES (7, 'Sell a good book', '<p>This book has been with me for a long time, and now I\'m letting it go for cheap. Fixed price at 20, no haggling please.<br/></p><p><br/></p><p>Buy link：<a target=\"_blank\" href=\"http://localhost:8080/front/goodsDetail?id=15\">http://localhost:8080/front/goodsDetail?id=15</a></p>', 'http://localhost:9090/files/1711509394610-微信截图_20240326100215.png', 1, '2026-06-20 15:35:08', 'Books & Textbooks', 'A great book', 36, '通过');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'aaa', '123', 'aaa', 'http://localhost:9090/files/1711332293317-QQ截图20230330090913.png', 'USER', '13877668877', 'aaa@xm.com', NULL);
INSERT INTO `user` VALUES (2, 'ccc', '123', 'ccc', 'http://localhost:9090/files/1708569481646-3123214.png', 'USER', '13899778866', 'ccc@xm.com', NULL);
INSERT INTO `user` VALUES (3, 'bbb', '123', 'bbb', 'http://localhost:9090/files/1708569474215-QQ截图20230330090332.png', 'USER', '13833558877', 'bbb@xm.com', NULL);
INSERT INTO `user` VALUES (4, 'acc', '123', 'acc', 'http://localhost:9090/files/1706751425887-微信截图_20231213153827.png', 'USER', '13899775566', 'acc@xm.com', NULL);
INSERT INTO `user` VALUES (5, 'www', '123', 'www', 'http://localhost:9090/files/1710757245273-微信截图_20231018172208.png', 'USER', NULL, NULL, NULL);
INSERT INTO `user` VALUES (6, 'ddd', '123', 'ddd', 'http://localhost:9090/files/1710753710955-微信截图_20240318112705.png', 'USER', NULL, NULL, NULL);
INSERT INTO `user` VALUES (7, 'qwe', '123', 'qwe', 'http://localhost:9090/files/1711682114329-1213123213.jpg', 'USER', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
