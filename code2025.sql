/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : code2025

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 21/10/2025 21:13:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accident
-- ----------------------------
DROP TABLE IF EXISTS `accident`;
CREATE TABLE `accident`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID（唯一标识一条事故记录）',
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '事故级别（对应业务中的“特别重大/重大/较大/一般”，需与业务枚举一致）',
  `happen_time` datetime NOT NULL COMMENT '事故发生时间（精确到时分秒，如“2024-10-21 14:30:00”）',
  `response_time` datetime NULL DEFAULT NULL COMMENT '响应时间（事故发生后首次响应的时间，允许为空表示未记录）',
  `death_count` int(11) NOT NULL DEFAULT 0 COMMENT '死亡人数（默认0，非负整数）',
  `injured_count` int(11) NOT NULL DEFAULT 0 COMMENT '受伤人数（默认0，非负整数）',
  `related_area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联区域（如“生产车间A区”“物流仓库”，描述事故发生地点）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间（数据录入系统的时间，自动填充）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间（数据修改时自动刷新）',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '逻辑删除标识（0=未删除，1=已删除，避免物理删除数据）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_level`(`level`) USING BTREE,
  INDEX `idx_happen_time`(`happen_time`) USING BTREE,
  INDEX `idx_related_area`(`related_area`) USING BTREE,
  INDEX `idx_happen_time_area`(`happen_time`, `related_area`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '事故信息表：存储各类安全事故的核心数据，支撑事故统计、趋势分析等功能' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accident
-- ----------------------------
INSERT INTO `accident` VALUES (1, 'juZLKnq4PS', '2012-09-23 11:23:03', '2003-09-10 06:07:35', 880, 231, 'u9wngl4oYQ', '2015-08-20 15:50:25', '2002-07-05 08:05:35', 33);
INSERT INTO `accident` VALUES (2, '56tea4V9cF', '2010-07-16 16:45:41', '2003-10-03 00:42:52', 865, 674, '4KBDO3ebiK', '2021-01-16 08:12:39', '2022-06-23 04:05:24', 61);
INSERT INTO `accident` VALUES (3, 'y0gRLL87aU', '2024-02-17 23:26:09', '2012-09-15 18:06:47', 684, 130, 'd3PrwyTUk8', '2023-04-20 13:10:23', '2012-11-08 19:04:28', 108);
INSERT INTO `accident` VALUES (4, '7vliJ1Shp4', '2001-08-07 01:50:03', '2005-07-05 22:20:03', 913, 591, 'CEeyoZOVYK', '2021-03-26 05:17:09', '2010-09-26 08:04:42', 43);
INSERT INTO `accident` VALUES (5, 'y2ZDkqgC4k', '2012-08-07 19:55:03', '2009-02-23 00:33:27', 268, 343, 'Jj8rMLvJby', '2016-02-07 21:08:39', '2010-01-06 16:40:33', 98);
INSERT INTO `accident` VALUES (6, 'NJXvA7h8Wr', '2004-10-05 18:10:14', '2006-07-22 04:12:56', 637, 928, 'TFsBXQUIhQ', '2023-10-26 12:05:52', '2010-10-22 17:01:47', 46);
INSERT INTO `accident` VALUES (7, 'HmBmTm7iYI', '2003-08-08 23:08:49', '2020-08-10 13:57:22', 436, 384, '3ONLIxyK9e', '2010-07-08 08:49:48', '2002-04-24 13:44:22', 13);
INSERT INTO `accident` VALUES (8, 'G3uDygBoXf', '2001-04-05 04:57:52', '2005-09-27 22:51:25', 297, 909, 'J3pnrVirB7', '2016-04-09 15:14:29', '2012-03-10 14:02:18', 2);
INSERT INTO `accident` VALUES (9, 'BsbyrUBo0V', '2001-08-11 23:16:03', '2021-02-18 04:58:54', 437, 868, '75IPZqHKyp', '2001-12-05 12:59:39', '2013-04-05 20:09:34', 35);
INSERT INTO `accident` VALUES (10, 'FPWjK0yChz', '2013-11-27 21:14:27', '2008-03-15 06:18:02', 578, 562, 'Eau7SgcYYl', '2012-06-10 07:01:43', '2020-08-19 04:36:57', 79);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员信息\r\n' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'yuanweihua', '123456', 'yuan', '18559151778', '2964966950@qq.com', 'ADMIN');
INSERT INTO `admin` VALUES (2, 'admin', '123456', 'admin', NULL, NULL, 'ADMIN');
INSERT INTO `admin` VALUES (3, 'Sun Rui', 'z6Y4CEPDMB', 'Sun Rui', '74-573-4982', 'sun10@mail.com', 'ADMIN');
INSERT INTO `admin` VALUES (4, 'Cui Xiaoming', 'WxUMVfM19L', 'Cui Xiaoming', '(1865) 44 7654', 'xiaoming1@icloud.com', 'ADMIN');
INSERT INTO `admin` VALUES (5, 'Kwan Wing Fat', 'awlb2h8T6E', 'Kwan Wing Fat', '52-572-4512', 'kwanwf@outlook.com', 'ADMIN');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `Cno` int(11) NOT NULL COMMENT '课程号',
  `Cname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程名称',
  `Ccredit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程学分',
  `Cpno` int(11) NULL DEFAULT NULL COMMENT '课程编号',
  PRIMARY KEY (`Cno`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'Xiang Jialun', 'G6hgySpFzr', 947);
INSERT INTO `course` VALUES (2, 'Miyamoto Tsubasa', '4u6BA0ZARw', 895);
INSERT INTO `course` VALUES (3, 'Julie Sanchez', 'ZpGdWaUPok', 861);
INSERT INTO `course` VALUES (4, 'Yung Wing Sze', 'I5Bc2if6Mo', 611);
INSERT INTO `course` VALUES (5, 'Emily Kim', 'OnHuNHrYOe', 302);
INSERT INTO `course` VALUES (6, 'Wang Lan', 'cHDIS8GvVg', 755);
INSERT INTO `course` VALUES (7, 'Koo Chieh Lun', 'SCoxcOcO6D', 902);
INSERT INTO `course` VALUES (8, 'Sugawara Sakura', 'SodHEbN0T9', 511);
INSERT INTO `course` VALUES (9, 'Sugiyama Yuna', 'Xdt3DyM1Hi', 216);
INSERT INTO `course` VALUES (10, 'Alexander Gonzalez', '21favhOnIn', 792);

-- ----------------------------
-- Table structure for risk_factor
-- ----------------------------
DROP TABLE IF EXISTS `risk_factor`;
CREATE TABLE `risk_factor`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID（唯一标识一条风险因素记录）',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '风险因素名称（如“设备老化”“操作失误”）',
  `probability` decimal(5, 2) NOT NULL COMMENT '发生概率（范围：0.01~1.00，保留2位小数，如0.80表示80%）',
  `impact_level` int(11) NOT NULL COMMENT '影响程度（建议1-5级：1=轻微，2=较小，3=中等，4=较大，5=严重）',
  `related_area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联区域（如“生产车间A区”“仓储中心”，非必选）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间（自动填充当前时间）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间（更新时自动刷新）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE,
  INDEX `idx_related_area`(`related_area`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '风险因素表：用于存储各类安全风险的基础信息，支撑风险矩阵分析功能' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of risk_factor
-- ----------------------------
INSERT INTO `risk_factor` VALUES (1, 'Cheryl Patterson', 870.38, 185, 'toJQr8DD8P', '2016-08-21 19:40:36', '2011-04-15 01:31:28');
INSERT INTO `risk_factor` VALUES (2, 'Saito Hikari', 276.09, 402, 'qu6jQ2CasH', '2016-10-22 20:59:33', '2007-03-09 04:38:01');
INSERT INTO `risk_factor` VALUES (3, 'Cho Hok Yau', 610.96, 197, 'MYXN7EXJb6', '2002-08-21 22:17:17', '2015-09-05 04:49:33');
INSERT INTO `risk_factor` VALUES (4, 'Su Lu', 608.93, 995, 'cH57OP2iaW', '2010-08-07 09:39:57', '2006-05-05 23:44:19');
INSERT INTO `risk_factor` VALUES (5, 'Fujii Riku', 125.36, 166, 'kHT5GL5SVv', '2001-08-28 07:36:17', '2005-01-11 02:47:25');
INSERT INTO `risk_factor` VALUES (6, 'Sugawara Ren', 824.29, 5, 'KxHoRy88yB', '2000-05-18 13:21:35', '2007-01-15 12:45:05');
INSERT INTO `risk_factor` VALUES (7, 'Jason Jenkins', 276.47, 494, 'AgxMrNfyp8', '2001-01-27 20:17:55', '2019-08-13 14:28:09');
INSERT INTO `risk_factor` VALUES (8, 'Ota Mio', 948.92, 239, '5BKXoFjEmk', '2015-01-28 21:24:11', '2001-07-27 07:11:51');
INSERT INTO `risk_factor` VALUES (9, 'Ando Momoka', 364.60, 59, 'fQg8BDHJ4b', '2011-07-06 23:47:10', '2004-04-22 20:12:52');
INSERT INTO `risk_factor` VALUES (10, 'Gu Anqi', 378.66, 391, 'k2Umf5Ohu5', '2017-06-05 04:59:30', '2025-06-04 07:24:35');

-- ----------------------------
-- Table structure for sc
-- ----------------------------
DROP TABLE IF EXISTS `sc`;
CREATE TABLE `sc`  (
  `Sno` int(11) NOT NULL COMMENT '学号',
  `Cno` int(11) NOT NULL COMMENT '课程号',
  `Gread` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '年级',
  `Semester` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学期',
  `Teachingclass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教学班级',
  PRIMARY KEY (`Sno`, `Cno`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sc
-- ----------------------------
INSERT INTO `sc` VALUES (1, 876, 'x0Cu6L5OgR', 'NC7BpWm6iV', '6oIu1EvkVH');
INSERT INTO `sc` VALUES (2, 448, 'nbdkKJuTVK', 'Hk5a0Uz4ka', 'WEsdJzOqEu');
INSERT INTO `sc` VALUES (3, 49, 'xVntpdcF4Z', 'T6U2FgFOMe', 'FzIDZlpLm1');
INSERT INTO `sc` VALUES (4, 4, 'DDoq75h2KU', 'M49B4Spn8T', 'dk3RCKZKJ9');
INSERT INTO `sc` VALUES (5, 110, 'YsZb2JFAh7', 'GanodcuVkO', 'ehhPnIGg05');
INSERT INTO `sc` VALUES (6, 325, 'ZdHmPLON2U', 'fXcSlNkqKK', 'cY4XVhulp5');
INSERT INTO `sc` VALUES (7, 901, 'gDqem66Oxk', 'lhQa1cosKZ', 'T1066Wi4IB');
INSERT INTO `sc` VALUES (8, 791, 'nw2JzHYrdn', 'QqBXB1m1Ai', 'brp9ePtOA9');
INSERT INTO `sc` VALUES (9, 255, 'F9AZTNuvId', 'XFmI5sYXsh', '2GIWF6UKNa');
INSERT INTO `sc` VALUES (10, 577, 'oq9soLr7ou', 'RJFAvMrEof', 'rsgRTjgZen');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `Sno` int(11) NOT NULL COMMENT '学号',
  `Sname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `Ssex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `Sbirthdate` datetime NULL DEFAULT NULL COMMENT '生日',
  `Smajor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`Sno`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'Choi Wai Man', '5wzxKl2hlY', '2010-01-25 15:31:25', 'UVtXaWmPyU');
INSERT INTO `student` VALUES (2, 'Harada Momoe', '3B1uHwGkoC', '2000-04-16 14:19:23', 'hYm6bNndBg');
INSERT INTO `student` VALUES (3, 'William Jimenez', 'JEPN2HdTgC', '2003-04-16 01:19:18', 'fhbU0hMHdV');
INSERT INTO `student` VALUES (4, 'Hashimoto Eita', 'v3kxky7xGH', '2018-07-03 19:46:46', '6qGaTIQKTn');
INSERT INTO `student` VALUES (5, 'Sato Daichi', 'jllKtYu5CI', '2016-06-26 21:02:06', 'RVWwoapfsq');
INSERT INTO `student` VALUES (6, 'Yam Sze Kwan', 'ZlvolEHnYw', '2012-06-04 06:54:46', 'riMKtlAxsz');
INSERT INTO `student` VALUES (7, 'Thomas Murphy', '2zzITzngoL', '2025-09-25 22:31:26', 'Z9Mfn7mFqO');
INSERT INTO `student` VALUES (8, 'Tang Lu', '7RqGecvkov', '2024-09-24 08:20:17', 'dY4iQyopTe');
INSERT INTO `student` VALUES (9, 'Kam Lai Yan', 'cJdX3tSZa5', '2008-02-17 03:22:48', 'N4CwxbYzMQ');
INSERT INTO `student` VALUES (10, 'Nakayama Daichi', 'wPsxYPXETl', '2023-01-22 15:14:42', 'skYsHIjIMb');
INSERT INTO `student` VALUES (11, 'Takagi Akina', 'JHuobuHyMf', '2024-12-04 08:53:45', 'T5wTFs7AGz');
INSERT INTO `student` VALUES (12, 'Zhu Xiaoming', 'qHV7UIKVPH', '2018-04-12 22:22:50', '9JSYX1nTLr');
INSERT INTO `student` VALUES (13, 'Wada Riku', '6GBzKxyy0n', '2004-08-22 10:51:54', 'WJQ90qPEy4');
INSERT INTO `student` VALUES (14, 'Yin Wing Kuen', 'ovFSnXufh1', '2002-01-08 08:16:10', 'HjwQW323MK');
INSERT INTO `student` VALUES (15, 'Lu Anqi', 'a0hG7MKfEa', '2010-09-12 10:15:20', 'HcA3wQQR2m');
INSERT INTO `student` VALUES (16, 'Janet Olson', '5BwEYFR3Pv', '2004-12-22 21:00:21', '7EOGyZ4P1g');
INSERT INTO `student` VALUES (17, 'Kim Fox', 'gfAcWzgWeB', '2024-04-05 18:45:52', 'NHpWfbnGeq');
INSERT INTO `student` VALUES (18, 'Chin Chi Ming', 'UP7G1xIf6T', '2014-08-27 21:28:36', 'GbiEuBIecB');
INSERT INTO `student` VALUES (19, 'Lui Hiu Tung', 'xhpsoFDBRH', '2016-03-11 20:51:30', 'LSsIAI8O5h');
INSERT INTO `student` VALUES (20, 'Yang Zhennan', 'q8nla9Hv7S', '2021-11-27 22:41:04', 'CD6TvmuddI');
INSERT INTO `student` VALUES (21, 'Noguchi Daichi', 'AiVtpMRZ6k', '2011-01-05 22:11:20', 'AOxbxewKh6');
INSERT INTO `student` VALUES (22, 'Peggy Patterson', 'JGSLLDVrgO', '2008-12-06 18:27:17', '12ZjBdKupR');
INSERT INTO `student` VALUES (23, 'Tanaka Kenta', 'Rv9VNEsXIv', '2018-10-21 03:20:38', 'pHtoQ8vAAp');
INSERT INTO `student` VALUES (24, 'Yuen Ting Fung', 'D3nqtdwP97', '2014-06-16 19:26:28', 'UxFmKzsDpv');
INSERT INTO `student` VALUES (25, 'Morita Takuya', 'T9Q5tnng6d', '2017-07-18 12:28:47', 'fKF0rsS5aV');
INSERT INTO `student` VALUES (26, 'Leung Chieh Lun', 'Jim7NUesrf', '2025-08-27 01:50:55', 'qM1ihqpRAD');
INSERT INTO `student` VALUES (27, 'Wu Jialun', 'rseuskTwb0', '2009-12-31 08:39:55', 'PN2bW5KwhY');
INSERT INTO `student` VALUES (28, 'Ikeda Hikari', 'Gxs3vjQwUP', '2025-09-05 06:05:39', 'Z54uRQe53n');
INSERT INTO `student` VALUES (29, 'Jiang Zhennan', '16AbC5dwvG', '2004-08-19 01:58:28', 'LQ1SeOq50A');
INSERT INTO `student` VALUES (30, 'Theresa Burns', 'fSHJSSfeCN', '2017-08-27 06:47:18', 'jcZiB94V6i');
INSERT INTO `student` VALUES (31, 'Fung Sze Yu', 'Rs4lygWbfC', '2024-06-18 13:42:58', 'ghp0pdFHGa');
INSERT INTO `student` VALUES (32, 'Ng Chun Yu', 'Aqmzd5ti1L', '2015-10-21 23:21:51', '5YhrSpizk1');
INSERT INTO `student` VALUES (33, 'Joe Watson', 'L6NPzrTXKg', '2013-12-07 03:58:28', '7lvcPNyuQE');
INSERT INTO `student` VALUES (34, 'Xiong Yunxi', '9LR0GONY0G', '2006-02-15 10:24:19', 'vl36tHergJ');
INSERT INTO `student` VALUES (35, 'Qiu Zitao', 'l7eTX3G683', '2001-10-24 17:01:55', 'wIoynjpNXn');
INSERT INTO `student` VALUES (36, 'Ogawa Hina', 'Scg6ji7jrn', '2012-05-14 01:22:24', 'iLGLwRxAn4');
INSERT INTO `student` VALUES (37, 'Yeow Ming Sze', 'QLYRx5QbbJ', '2017-03-01 23:15:58', 'l6xwYrBfGa');
INSERT INTO `student` VALUES (38, 'Francisco Jimenez', '5KNrOtG3FY', '2001-10-04 11:07:39', 'PnQ7sj5FMQ');
INSERT INTO `student` VALUES (39, 'Scott Long', 'Sszh2ZeTL8', '2024-08-03 15:40:59', 'ZecS5G55Ls');
INSERT INTO `student` VALUES (40, 'Fong Sze Yu', 'QXdwnEWTmM', '2012-09-08 00:42:38', 'xyVEPXht3C');
INSERT INTO `student` VALUES (41, 'Ku Wing Sze', 'vJiWmuURyx', '2001-06-02 02:34:28', 'PfQxoG4OUV');
INSERT INTO `student` VALUES (42, 'Sasaki Kaito', 'YObMcPtT9t', '2022-07-01 22:03:18', 'WJIQ7BWlKM');
INSERT INTO `student` VALUES (43, 'Grace Stevens', '0AmtUQy3tt', '2005-09-08 14:17:40', 'RbinleJJbZ');
INSERT INTO `student` VALUES (44, 'Qin Zhennan', 'e2NiRIBMBz', '2007-06-19 09:58:10', 'IjzJhKkoEd');
INSERT INTO `student` VALUES (45, 'Long Rui', 'ZOshp1Mrub', '2005-09-10 23:05:13', 'Ko8MQu1eVT');
INSERT INTO `student` VALUES (46, 'Takahashi Sakura', 'e3WZZ6nYgH', '2001-09-27 05:55:27', 'cXmhj9Ss3B');
INSERT INTO `student` VALUES (47, 'Hasegawa Riku', 'HK1cH3DPe7', '2001-05-26 12:04:24', 'oVKOaXhwvl');
INSERT INTO `student` VALUES (48, 'Hazel Webb', 'FXdbadlhZz', '2014-10-22 01:25:56', 'zCtPaRFMur');
INSERT INTO `student` VALUES (49, 'Lu Zhiyuan', 'FlrP1zo8Q8', '2024-02-13 15:17:27', '2YU5eapcxD');
INSERT INTO `student` VALUES (50, 'Feng Xiaoming', 'gv9P6iy55R', '2015-11-09 21:55:25', 'NVkylngMbw');
INSERT INTO `student` VALUES (51, 'Arimura Ayato', 'QrhLELkE8j', '2022-08-04 02:05:38', 'ORASPQwqgQ');
INSERT INTO `student` VALUES (52, 'Yuen Chun Yu', 's6S4KvfrIc', '2025-03-07 13:25:38', 'VGS8IPhjFj');
INSERT INTO `student` VALUES (53, 'Yamamoto Kazuma', 'm5zPJC4Qcc', '2010-04-08 13:27:46', 'RHMbCoF5mm');
INSERT INTO `student` VALUES (54, 'Fujita Sara', 'Ytt9XpHUOm', '2009-05-24 02:26:21', '7rCXZDLm1T');
INSERT INTO `student` VALUES (55, 'Mori Yuto', 'Ux42k2zQo8', '2014-01-31 22:56:45', 'PlrQPw6sQS');
INSERT INTO `student` VALUES (56, 'Masuda Momoka', 'AXRJBkbmZV', '2004-11-17 22:16:34', 'XAmJvYxhNP');
INSERT INTO `student` VALUES (57, 'Zhong Ziyi', 'UquemHO0uS', '2006-09-12 11:58:17', 'w0IlJardWF');
INSERT INTO `student` VALUES (58, 'Mildred Weaver', 'LDGDQNLsJY', '2024-10-27 15:55:09', 'ta19kmBgyq');
INSERT INTO `student` VALUES (59, 'Yao Shihan', 'XRcS2Jd8E4', '2005-04-24 08:51:51', '5YcdFqi5C6');
INSERT INTO `student` VALUES (60, 'Nomura Takuya', 'P5R2OUkCtF', '2019-07-12 19:15:38', 'l22eekUW8p');
INSERT INTO `student` VALUES (61, 'Katherine Mitchell', 'adNyZQwUki', '2002-05-17 05:49:03', 'f0L536H74D');
INSERT INTO `student` VALUES (62, 'Tian Anqi', '4u9SLDNwWo', '2006-07-05 08:04:58', 'pAoDW3KmaQ');
INSERT INTO `student` VALUES (63, 'Jamie Foster', 'a5eoNNUw2B', '2025-04-29 06:24:28', '5sBINmrdxQ');
INSERT INTO `student` VALUES (64, 'Fong Tsz Ching', 'YNLVACnQ1g', '2014-10-14 12:17:28', 'PzkR7vehFc');
INSERT INTO `student` VALUES (65, 'Margaret Martin', 'GKfSbk6P0Z', '2011-12-21 19:31:57', 'UmKcRXPY85');
INSERT INTO `student` VALUES (66, 'Barbara Cook', 'FHC0k5SNtH', '2013-10-25 06:25:13', 'pzmyTUqWhO');
INSERT INTO `student` VALUES (67, 'Nakamura Airi', 'UN8FBdkNX1', '2006-10-19 19:37:00', 'ZiFbafxu5Y');
INSERT INTO `student` VALUES (68, 'Fan Yuning', 'qh8LQgfJA6', '2021-12-10 16:59:33', 'E1e1wugKne');
INSERT INTO `student` VALUES (69, 'Gu Shihan', 'MQ5QILqULb', '2015-05-10 01:49:17', 'kU68m7n1VV');
INSERT INTO `student` VALUES (70, 'Thelma Wright', 'mS9TGmibsE', '2002-01-25 13:45:05', '8fyaRt2ZJN');
INSERT INTO `student` VALUES (71, 'Chu Ming Sze', 'vkpfgnZQFR', '2013-11-17 09:16:21', 'IXPODfxppF');
INSERT INTO `student` VALUES (72, 'Ng Wai Yee', 'ziVXN13oTw', '2003-03-21 17:00:40', 'X2ypETGTuG');
INSERT INTO `student` VALUES (73, 'Taniguchi Yamato', 'asHeV6qGyU', '2011-04-05 22:52:17', 'cjtPdlKTZ4');
INSERT INTO `student` VALUES (74, 'Jeff Hunt', 'cFvVeOLyty', '2017-02-10 02:07:51', 'G2TWuZAumi');
INSERT INTO `student` VALUES (75, 'Wong Suk Yee', 'pXCZJtmGGT', '2018-05-21 13:07:14', '1MYdDgJYQp');
INSERT INTO `student` VALUES (76, 'Lois Romero', 'FKj3g6rTG6', '2014-08-11 21:50:35', 'EwQSkQ7LXu');
INSERT INTO `student` VALUES (77, 'Josephine Wagner', 'gIgRUs8zTa', '2013-12-25 15:18:55', 'gs9ltO7Ao9');
INSERT INTO `student` VALUES (78, 'Harada Momoe', '5MAvyT06Ha', '2002-02-16 01:08:53', 'A6IWxt5TBi');
INSERT INTO `student` VALUES (79, 'Chiba Hana', 'SJC9BhVZEn', '2013-12-02 05:34:10', 'tyHdL4V6E6');
INSERT INTO `student` VALUES (80, 'Hsuan Lai Yan', 'YEvua5v0hf', '2016-08-08 20:12:21', 'QLjU0V4UYr');
INSERT INTO `student` VALUES (81, 'Shen Shihan', 'X8q8xCQTcc', '2012-08-04 12:30:51', 'NFe3oTmiyQ');
INSERT INTO `student` VALUES (82, 'Kam Ming', 'omrGQv0lkd', '2013-12-29 04:39:54', '5K2ZITKUdz');
INSERT INTO `student` VALUES (83, 'Mao Ziyi', 'CUlUH2napL', '2005-04-10 11:47:01', 'iTDiGI2SxF');
INSERT INTO `student` VALUES (84, 'Thomas Torres', '5GHjjrcSyc', '2003-02-12 21:38:38', 'rjSavA3LYA');
INSERT INTO `student` VALUES (85, 'Matthew Schmidt', 'doFRAjuCXN', '2015-12-12 03:11:38', 'dNsczjVKxF');
INSERT INTO `student` VALUES (86, 'Iwasaki Yamato', 'Y6J2crUAXS', '2015-04-27 16:26:33', 'Y6adIf2e6E');
INSERT INTO `student` VALUES (87, 'Rosa Brown', 'lNeebMaRds', '2002-06-10 20:12:10', 'av3HZI0Cpm');
INSERT INTO `student` VALUES (88, 'Marie Roberts', 'cmARpw0L7Q', '2005-05-20 09:08:26', 'Mvh25Nl1Bd');
INSERT INTO `student` VALUES (89, 'Cao Rui', 'ItFDfxOlkH', '2006-05-27 06:55:03', 'Vvgml4GIdE');
INSERT INTO `student` VALUES (90, 'Watanabe Hikaru', 'zQU1daT86o', '2000-04-11 06:08:26', 'hbtirmmCLw');
INSERT INTO `student` VALUES (91, 'Sugawara Sara', '2pVFVcT6dD', '2014-06-04 15:16:52', 'e6JmX9JB0e');
INSERT INTO `student` VALUES (92, 'Margaret Cox', 'v7OdZPxM0r', '2005-06-19 01:53:08', 'r8YhBY4QJ5');
INSERT INTO `student` VALUES (93, 'Luis Daniels', 'nhUHn8bzpZ', '2020-05-07 17:33:03', '4B5RhLFeKS');
INSERT INTO `student` VALUES (94, 'Wan Hiu Tung', 'QfhkdmwwUT', '2020-05-01 05:44:12', 'xF5KzYQzQ5');
INSERT INTO `student` VALUES (95, 'Xie Zhiyuan', 'TE4bZw1O9W', '2002-01-28 08:39:27', 'J2uY0iHllB');
INSERT INTO `student` VALUES (96, 'Henry Martinez', '0r9PqttSsW', '2022-02-27 05:37:03', '0C5yLhD5nx');
INSERT INTO `student` VALUES (97, 'Shing Wing Kuen', 'Q8jwLFMyAv', '2001-02-26 23:24:20', '6a7TKCOyXW');
INSERT INTO `student` VALUES (98, 'Nishimura Ren', 'edq9fbAeRd', '2006-08-18 05:54:27', 'xT2k0QGVPm');
INSERT INTO `student` VALUES (99, 'Keith Boyd', 'CtG92mrhnH', '2024-02-21 15:35:49', 'GLgeZzF8FE');
INSERT INTO `student` VALUES (100, 'Anthony Smith', 'GLRyKA6BUz', '2003-12-07 10:28:48', 'lglYglr7f7');
INSERT INTO `student` VALUES (101, 'Yan Ziyi', 'fxZnikHtVK', '2013-06-06 01:51:24', 'OFYUwK9XaZ');
INSERT INTO `student` VALUES (102, 'Hsuan Ling Ling', 'fbtC6Uwkza', '2011-01-16 03:05:44', 'MmcTTVI8Qd');
INSERT INTO `student` VALUES (103, 'Yuan Lan', 'iObA7zuaXQ', '2023-12-07 08:33:34', 'xyqsNwfft5');
INSERT INTO `student` VALUES (104, 'Koyama Kaito', 'sTuNXx9hwx', '2012-01-31 23:04:48', 'uaOaALZjHJ');
INSERT INTO `student` VALUES (105, 'Luis Foster', 'KfHqsvxyaR', '2000-06-19 07:01:29', 'UPQmnam8mD');
INSERT INTO `student` VALUES (106, 'Shing Sze Yu', 'k7bZpGhp3d', '2006-11-09 16:03:42', 'iuvHHYqXjf');
INSERT INTO `student` VALUES (107, 'Sato Aoshi', '5lnaBMSSiC', '2002-05-18 16:44:13', 'EX0G8eiT5W');
INSERT INTO `student` VALUES (108, 'Mui On Na', '8rbufQvQNj', '2023-10-19 20:02:21', 'G5FuQukmJ5');
INSERT INTO `student` VALUES (109, 'Goto Shino', 'zmNii1RgjY', '2006-08-27 13:48:11', 'WrlXB5NqFF');
INSERT INTO `student` VALUES (110, 'Arthur Lewis', 'ahmX8DdV9B', '2003-11-05 08:03:06', 'SzjMlswqNV');
INSERT INTO `student` VALUES (111, 'Ito Yamato', 'QFXo1UW0pm', '2004-05-04 18:19:11', 'p4qZbCUUtm');
INSERT INTO `student` VALUES (112, 'Lok Ming', 'EdRgYXg9r1', '2007-08-24 17:59:55', 'GXwg5Mo3qD');
INSERT INTO `student` VALUES (113, 'Hui Tak Wah', 'MyN2yD6Bej', '2003-09-12 18:06:00', 'JdEfuNVQOd');
INSERT INTO `student` VALUES (114, 'Nicholas Morris', '9vBb9VDwBG', '2002-09-21 12:12:44', 'Z0qMs9aVVV');
INSERT INTO `student` VALUES (115, 'William Evans', 'JhV1bdPJlF', '2023-06-12 08:02:44', '2CtLJ2II1v');
INSERT INTO `student` VALUES (116, 'Ding Jialun', 'yipLS9aI6i', '2012-05-08 17:02:06', 'KAdkc1VXod');
INSERT INTO `student` VALUES (117, 'Dong Xiaoming', 'UcgENvuLUG', '2023-03-15 09:51:54', 'qQQCfUuokD');
INSERT INTO `student` VALUES (118, 'Roy Stevens', 'XSWNjZRr5f', '2011-06-10 16:51:00', 'RE06XQ4P2N');
INSERT INTO `student` VALUES (119, 'Masuda Kazuma', 'UfOxvOkkqW', '2003-06-21 18:20:19', '7IyFgLzKFk');
INSERT INTO `student` VALUES (120, 'Lucille Soto', 'kfBJp0ViKA', '2013-05-21 00:43:54', 'RjeujzB56i');
INSERT INTO `student` VALUES (121, 'Tong Ming Sze', 'SyNezMOrVE', '2025-06-26 20:44:11', 'XfJO2NCUGL');
INSERT INTO `student` VALUES (122, 'Shawn Wilson', 'zK82M0VTYo', '2013-03-21 22:17:55', 'zFgGtdKTl0');
INSERT INTO `student` VALUES (123, 'Fung Chiu Wai', 'e0mZt2xPuJ', '2006-10-08 00:50:37', 'IFBC5hpfSU');
INSERT INTO `student` VALUES (124, 'Kikuchi Airi', 'xtWiSktN3K', '2023-01-17 12:21:22', 'CiKQ9NnbSG');
INSERT INTO `student` VALUES (125, 'Tan Zitao', 'r2LPUWhjd6', '2008-11-13 00:14:21', '0UsesoQQBs');
INSERT INTO `student` VALUES (126, 'Ono Sara', '94cTRCyGvP', '2018-02-01 16:10:55', 'ph2i6wZqRm');
INSERT INTO `student` VALUES (127, 'Nakajima Kenta', 'sWdAJDJwFb', '2010-02-20 16:53:25', '0k7RUpSZzg');
INSERT INTO `student` VALUES (128, 'Chad Dixon', 'ACTSjDXG5L', '2001-12-16 22:49:28', 'taQ54P833Y');
INSERT INTO `student` VALUES (129, 'Koo Wing Sze', 'KPB668VN5F', '2012-06-13 20:06:21', 'jdGjtfPz1y');
INSERT INTO `student` VALUES (130, 'Jia Jialun', 'Ll7pUKFbBZ', '2002-12-29 17:09:55', 'xcDyv66XJz');
INSERT INTO `student` VALUES (131, 'Ng Yu Ling', 'arLzQC2khn', '2000-02-21 14:19:48', 'v6l6AphGrb');
INSERT INTO `student` VALUES (132, 'Wei Lu', 'SUYEaLNrnH', '2006-11-24 04:56:31', 'YlZvN0JzDM');
INSERT INTO `student` VALUES (133, 'Koon Sau Man', '59agZvIGi3', '2024-12-19 01:39:09', 'hRgdSJZ5yI');
INSERT INTO `student` VALUES (134, 'Ralph Reynolds', 'CzhVvVlbBX', '2009-12-21 03:31:49', 'YJcsJb2nL8');
INSERT INTO `student` VALUES (135, 'Fujii Ayato', '2rxfGd83S2', '2009-02-20 10:03:24', 'mq2wradXkZ');
INSERT INTO `student` VALUES (136, 'Kathryn Jimenez', 'cneiv2Psi7', '2011-02-10 10:19:05', 'KvR8utnJyB');
INSERT INTO `student` VALUES (137, 'Maruyama Momoka', 'A69fzZ8joR', '2022-04-15 07:30:09', 'UpcMgNgLVQ');
INSERT INTO `student` VALUES (138, 'Marcus Coleman', 'dmFpQQgniW', '2022-05-18 04:10:22', 'ZhJJ9gbUl5');
INSERT INTO `student` VALUES (139, 'So Wing Suen', 'jYsiCuCpvf', '2022-04-06 22:10:47', '14eSNm1WuA');
INSERT INTO `student` VALUES (140, 'Xue Rui', 'UwdnAxiPnp', '2010-11-14 19:14:14', '3lEIrBSir2');
INSERT INTO `student` VALUES (141, 'Takahashi Aoi', 'kfKJZVWWVl', '2002-10-26 14:19:54', 'cTuu7vqQHI');
INSERT INTO `student` VALUES (142, 'Jamie Gutierrez', 'T8LwNSqGIu', '2024-07-03 08:29:35', '7ENXLUdnms');
INSERT INTO `student` VALUES (143, 'Hao Zhiyuan', '7JpcJ8HHyv', '2003-05-21 14:21:31', 'QRHj8Mx4iP');
INSERT INTO `student` VALUES (144, 'Fujita Kaito', 'MtYripZDoU', '2014-02-11 12:05:17', 'JaGOefbfdk');
INSERT INTO `student` VALUES (145, 'Alan Marshall', 'Yda3l33HjG', '2000-06-09 11:31:15', 'RClY0XGiTK');
INSERT INTO `student` VALUES (146, 'Sakai Hikari', 'vtrDjWU3eW', '2019-07-04 23:41:06', '2t8IbRvbK6');
INSERT INTO `student` VALUES (147, 'Hu Rui', 'anHk1emvQq', '2018-07-25 12:06:31', 'TDMm4ubTO4');
INSERT INTO `student` VALUES (148, 'Pang Tsz Hin', 'sd9f00UaZo', '2004-01-11 18:34:28', 'oNikrYMNPs');
INSERT INTO `student` VALUES (149, 'Tammy Webb', 'zBtzdXVKpB', '2024-02-26 02:23:11', 'u3BRHYQKeo');
INSERT INTO `student` VALUES (150, 'Matsumoto Shino', 'BsRyyz35YS', '2003-04-15 18:23:17', '0fIOR7yWc3');
INSERT INTO `student` VALUES (151, 'Paula Rogers', '37S7IMF1xi', '2014-07-05 00:18:24', 'qiR16fDy9i');
INSERT INTO `student` VALUES (152, 'Gu Lan', 'NVNtLljZNP', '2024-12-04 03:03:24', 'Ki7s3kWPwF');
INSERT INTO `student` VALUES (153, 'Chen Lu', '7jBPKQHKTG', '2016-01-25 20:33:39', 'eHmVBR1n01');
INSERT INTO `student` VALUES (154, 'Chris Ramos', 'AvljK7IsxW', '2009-07-29 07:31:02', 'BSn6zruxfQ');
INSERT INTO `student` VALUES (155, 'Jiang Anqi', 'cc5KzO1LLq', '2024-02-27 11:04:56', 'xobjmdiMcp');
INSERT INTO `student` VALUES (156, 'Lam Siu Wai', 'oIonJjYUgU', '2022-06-20 15:21:51', '1ytYZfYmgU');
INSERT INTO `student` VALUES (157, 'Tammy Rice', 'ZEeucQUzPW', '2001-05-23 21:16:37', 'CvcSV7d01G');
INSERT INTO `student` VALUES (158, 'Hashimoto Tsubasa', '4tZdGr5F8I', '2010-01-15 10:26:13', 'Niwz7MLZxr');
INSERT INTO `student` VALUES (159, 'Morita Minato', 'pBaQQBIMcd', '2025-06-16 11:04:04', 'EfXYMGDN3M');
INSERT INTO `student` VALUES (160, 'Gregory Wood', 'PpDLzFmsZn', '2009-11-19 13:25:29', '91aNQitqrA');
INSERT INTO `student` VALUES (161, 'Kobayashi Mio', 'vepc87cfvt', '2023-08-28 16:03:55', 'HtQbIEnXQN');
INSERT INTO `student` VALUES (162, 'Marjorie Butler', 'LZvkhsvja5', '2024-01-10 01:56:51', 'cKY5rG4jX8');
INSERT INTO `student` VALUES (163, 'Li Lu', 'nMMDkmiNnJ', '2009-11-22 00:37:15', 'q2rz84Yd5w');
INSERT INTO `student` VALUES (164, 'Yau Wing Fat', 'cyZlstASLU', '2000-04-10 21:55:35', 't5ffbZKj66');
INSERT INTO `student` VALUES (165, 'Rosa Soto', '3yZV3uN6Cz', '2023-02-16 15:59:36', '2Fgf6Pqegc');
INSERT INTO `student` VALUES (166, 'Hara Akina', 'Kw5myn9XaY', '2006-02-26 12:14:26', 'DsrqC2SMcQ');
INSERT INTO `student` VALUES (167, 'Fujita Kasumi', '20JtV3JbZ2', '2008-02-26 23:20:05', 'pB356x8tIC');
INSERT INTO `student` VALUES (168, 'Angela Johnson', '81C25JofO7', '2023-02-28 07:09:26', 'jmqosMQi1x');
INSERT INTO `student` VALUES (169, 'Shi Lan', 'qmaCjyl7Ui', '2013-02-25 17:34:48', 'P20cdTJS1T');
INSERT INTO `student` VALUES (170, 'Hu Yunxi', 'ABSHF7jLxv', '2025-09-23 14:40:52', 'CLkuUaaphs');
INSERT INTO `student` VALUES (171, 'Kwong Wing Kuen', 'pa1Bcrjcem', '2025-01-05 23:14:30', 'VxR99YF0Il');
INSERT INTO `student` VALUES (172, 'Ando Airi', 'byVFGm344G', '2023-11-10 12:36:29', 'pmlTMUolLM');
INSERT INTO `student` VALUES (173, 'Shi Jialun', 'yQExsHIKfC', '2024-02-04 12:10:47', 'xYMGHa9ca2');
INSERT INTO `student` VALUES (174, 'Yang Jiehong', 'mkiwVZJ6VR', '2003-04-19 12:18:26', 'od6hR3xIez');
INSERT INTO `student` VALUES (175, 'Danielle Taylor', 'Fgqhv3aB0a', '2012-11-08 00:55:32', 'xW7zVkm7wK');
INSERT INTO `student` VALUES (176, 'Manuel Flores', 'XOca5aCoJv', '2013-06-25 09:06:23', 'flae5Wptpw');
INSERT INTO `student` VALUES (177, 'Chin Wai Lam', 'Igff6DOisJ', '2016-10-25 02:19:07', 'fOZJh6FR4M');
INSERT INTO `student` VALUES (178, 'Manuel Stewart', '18E8VuOEDy', '2021-03-21 13:08:25', 'pwKJgaRUDi');
INSERT INTO `student` VALUES (179, 'Noguchi Ayano', 'b3jPMjmQwg', '2014-02-13 10:03:48', 'fzXfQYGbPM');
INSERT INTO `student` VALUES (180, 'Song Yunxi', 'NN8en8Zywf', '2007-08-13 17:59:32', 'gvtJOexfCW');
INSERT INTO `student` VALUES (181, 'Helen Shaw', 'UVzsDJ1uZj', '2019-03-26 14:22:29', 'xyIGuYcMiz');
INSERT INTO `student` VALUES (182, 'Cui Zhiyuan', 'AdyiJydZlK', '2011-08-14 20:17:50', '78X8xZomI5');
INSERT INTO `student` VALUES (183, 'Wan Wing Sze', 'ujoAgAFewR', '2010-05-15 21:43:49', 'lKs192e1t0');
INSERT INTO `student` VALUES (184, 'Lo Chi Ming', 'ocIPjqye4D', '2016-11-29 21:16:23', 'ADKJzTzOGn');
INSERT INTO `student` VALUES (185, 'Otsuka Hikari', 'IO6ZahLJ2X', '2002-10-26 20:32:07', 'kckj0hkVFQ');
INSERT INTO `student` VALUES (186, 'Marilyn Marshall', 'QUXxqb0Ggn', '2024-01-14 20:56:10', 'CnrWsEUjEr');
INSERT INTO `student` VALUES (187, 'Shannon Ward', 'sk4PoS7356', '2013-10-03 17:23:12', 'bQtlsykMFf');
INSERT INTO `student` VALUES (188, 'Nakano Kaito', 'HNbpAvaAV1', '2016-08-12 11:12:37', 'DY1qRaEc75');
INSERT INTO `student` VALUES (189, 'Wei Lan', 'TSLVkhavOm', '2008-02-28 20:45:54', '7NAHJMsvtU');
INSERT INTO `student` VALUES (190, 'Bernard Tucker', 'USeNMoeqG3', '2013-12-27 10:39:13', 'G5yEalCyfK');
INSERT INTO `student` VALUES (191, 'Man Tsz Ching', 'J0bUvI6H8i', '2011-08-11 09:44:50', 'c8fvroBTRz');
INSERT INTO `student` VALUES (192, 'Taniguchi Yuito', 'pubxXyjmAX', '2021-04-16 07:08:40', 't3pVTngMAO');
INSERT INTO `student` VALUES (193, 'Kwok Chung Yin', 'HG8euPiKXv', '2001-05-10 18:26:12', 'zNexQpqlph');
INSERT INTO `student` VALUES (194, 'Uchida Misaki', 'ljp4rvd9N8', '2007-05-30 22:11:52', 'Ls8vkIopPy');
INSERT INTO `student` VALUES (195, 'Matsumoto Nanami', 'E87dF4iVJY', '2008-04-26 01:28:29', 'A6GWLUUWFl');
INSERT INTO `student` VALUES (196, 'Xu Lan', 'jt05RB5k1Z', '2018-09-06 02:34:49', 'FAunSxECQO');
INSERT INTO `student` VALUES (197, 'Ota Kaito', '8qhN1GnCUO', '2013-03-14 04:36:04', 'LCzHJ0r0oO');
INSERT INTO `student` VALUES (198, 'Ando Shino', 'rEWvpSjkCB', '2023-04-07 14:10:02', 'PMHEchmDtj');
INSERT INTO `student` VALUES (199, 'Tiffany Sullivan', '3YSR1yM9Z9', '2024-04-06 07:17:18', 'ltzAizso2w');
INSERT INTO `student` VALUES (200, 'Qiu Ziyi', 'Su4hfMFrqP', '2017-08-07 05:29:37', 'gEyMzuWTly');
INSERT INTO `student` VALUES (201, 'Yuen Wing Suen', 'Z6pBkfLqjL', '2003-04-06 05:10:28', '7zE3OhokDH');
INSERT INTO `student` VALUES (202, 'Shi Zhiyuan', 'zadkouyE6H', '2019-08-24 11:28:56', 'XPXax4VAQX');
INSERT INTO `student` VALUES (203, 'Janet Boyd', 'xtCjStgTr7', '2024-06-28 12:10:27', 'u5ZmQma5Fo');
INSERT INTO `student` VALUES (204, 'Fong Ting Fung', 'rAITWMi6yJ', '2022-01-30 04:09:27', 'Gux9ogPLro');
INSERT INTO `student` VALUES (205, 'Fu Sze Yu', 'LoXLvHESmE', '2001-05-13 20:33:50', '9NUDNBWDI1');
INSERT INTO `student` VALUES (206, 'Harada Aoi', 'VttNP5e5x8', '2016-11-10 21:27:44', 'GrlSGGispj');
INSERT INTO `student` VALUES (207, 'Tang Lan', 'WF5ChLeHTy', '2000-09-13 15:51:23', 'YUkot0lfxK');
INSERT INTO `student` VALUES (208, 'Miyamoto Yuna', 'iG1KhpMQQs', '2009-09-24 09:57:06', '0Ec1wLPamn');
INSERT INTO `student` VALUES (209, 'Hu Xiuying', '3YTz8QvTGl', '2008-05-28 14:50:15', '6DFlnxWPnu');
INSERT INTO `student` VALUES (210, 'Rosa White', 'NbQkuIgDE8', '2018-08-15 21:04:45', 'zo9139aLE2');
INSERT INTO `student` VALUES (211, 'Wu Fat', 'K8iQdjAN78', '2022-07-11 23:31:47', 'Un0kVpwsx0');
INSERT INTO `student` VALUES (212, 'Wang Xiaoming', 'dzmpCkGszJ', '2017-07-25 22:25:06', 'EMVPsP9Pen');
INSERT INTO `student` VALUES (213, 'Jane Ramos', 'fc5qRX3lkp', '2023-03-04 10:04:24', '1uJdXJRqOP');
INSERT INTO `student` VALUES (214, 'Yin Yunxi', 'TTwP0aRmMB', '2014-05-31 23:33:08', 'FGJWGdpww5');
INSERT INTO `student` VALUES (215, 'Alfred Porter', 'yWPrxoNhOZ', '2010-01-01 07:58:00', 'zRJjkgR7dy');
INSERT INTO `student` VALUES (216, 'Shi Xiuying', 'UmjTlupDGZ', '2020-12-23 19:49:07', 'h6vidHTXKS');
INSERT INTO `student` VALUES (217, 'Han Lan', 'aTpabgkJj0', '2019-12-29 01:35:09', 'SyQGRkl9FZ');
INSERT INTO `student` VALUES (218, 'Sharon Sanchez', 'Qrav5uEn7t', '2000-08-21 12:53:21', 'uIM4pF2mXE');
INSERT INTO `student` VALUES (219, 'Ma Lan', 'WD2uoq05bG', '2012-11-16 03:03:36', 'fjizJyj6vZ');
INSERT INTO `student` VALUES (220, 'Yau Cho Yee', '6zKbOt5kwN', '2024-12-04 12:26:23', 'RGQ45UQ2yr');
INSERT INTO `student` VALUES (221, 'Kobayashi Hazuki', 'sPK5ykOBqX', '2015-06-17 00:31:30', 'YxsQPG6oXn');
INSERT INTO `student` VALUES (222, 'Yip Wai Man', 'MhhOhzl0Lw', '2015-08-22 06:20:49', 'NU1no6r1Sn');
INSERT INTO `student` VALUES (223, 'Taniguchi Yuto', 'W3uNyCnsQW', '2002-04-08 08:14:38', '4bYoiq6DKv');
INSERT INTO `student` VALUES (224, 'Carol Stone', 'QDM4JNq8W4', '2020-02-02 18:39:55', 'KnnPdO5TKM');
INSERT INTO `student` VALUES (225, 'Matsuda Seiko', 'hAnfVGzDsM', '2024-03-08 07:16:32', 'l6J54omTpz');
INSERT INTO `student` VALUES (226, 'Murakami Nanami', 'cNUQD7Zh5J', '2019-07-30 06:59:01', 'xHeE795RmR');
INSERT INTO `student` VALUES (227, 'Okamoto Momoe', 'P1dBolSPBf', '2010-08-10 09:57:16', 'MFSL0TcB10');
INSERT INTO `student` VALUES (228, 'Zeng Anqi', '2vMqBygRrl', '2018-12-21 12:08:16', 'NNVoPMZDfg');
INSERT INTO `student` VALUES (229, 'Chic Hiu Tung', '3CbHgDGuUm', '2021-12-07 11:13:41', 'tdBbQqb91C');
INSERT INTO `student` VALUES (230, 'Ikeda Yota', 'Gux9abEhcT', '2016-08-19 20:03:33', 'gDtKjczkix');
INSERT INTO `student` VALUES (231, 'Tong Hiu Tung', 'TOXTzwcjz4', '2006-10-10 02:28:01', '1hn1Y9f0Mu');
INSERT INTO `student` VALUES (232, 'Marie Griffin', 'CNIqgcN45w', '2013-11-01 14:47:22', 'fRVTggdqrA');
INSERT INTO `student` VALUES (233, 'Ando Aoshi', 'LkfsmH1NBi', '2009-02-05 05:05:23', '9ADPsKQyQ3');
INSERT INTO `student` VALUES (234, 'Zhou Rui', 'Vmq1WGMT1S', '2014-09-14 03:57:59', 'z11Tl2xHF2');
INSERT INTO `student` VALUES (235, 'Leroy Holmes', 'NW6V6dHzZ8', '2019-06-28 21:00:48', 'dx4VdkZ0mw');
INSERT INTO `student` VALUES (236, 'Willie Russell', '8VRNEjP4Vu', '2008-04-24 10:08:49', 'O43jikHPyq');
INSERT INTO `student` VALUES (237, 'Maeda Minato', 'ykAkzPaWEf', '2004-02-08 05:42:53', 'Y6VRfLGqN1');
INSERT INTO `student` VALUES (238, 'Kathleen Richardson', 'TrDVZIfnRQ', '2022-10-29 04:05:41', 'yd3RwP3uf5');
INSERT INTO `student` VALUES (239, 'Peng Rui', 'XjBTQP77JX', '2020-07-08 23:00:10', 'b6f1wuwW24');
INSERT INTO `student` VALUES (240, 'Fong Ming Sze', 'jj7b2gi0Jc', '2002-02-24 02:20:29', '9NCSDXdpGV');
INSERT INTO `student` VALUES (241, 'Matsuda Itsuki', 'YOCVV0RlrH', '2015-02-13 04:21:02', 'wju5wG4GIn');
INSERT INTO `student` VALUES (242, 'Tian Jiehong', 'VVa0f2Bu2d', '2009-04-07 07:38:17', 'HvKwKlVzy0');
INSERT INTO `student` VALUES (243, 'Gu Xiaoming', 'apre6Qwz1F', '2016-11-25 01:40:59', 'H2kqcaQdPk');
INSERT INTO `student` VALUES (244, 'Chang Yuning', 'rfCPfucljW', '2015-05-02 03:55:26', '9bOA6faDqL');
INSERT INTO `student` VALUES (245, 'Mui Fu Shing', 'bn2zQoL274', '2007-09-25 22:47:43', 'NCLOCCQ1CR');
INSERT INTO `student` VALUES (246, 'Yue Lik Sun', 'CUBdwajOyo', '2007-11-30 00:09:49', 'or0AfLpwPR');
INSERT INTO `student` VALUES (247, 'David Richardson', 'f7nklZ3GiC', '2005-05-21 11:10:49', 'sAxLWM9yP0');
INSERT INTO `student` VALUES (248, 'Harada Kaito', 'JktEWmx489', '2010-08-15 12:10:14', 'Sc5k0GGCdE');
INSERT INTO `student` VALUES (249, 'Cynthia Fisher', 'IQChmmIBm4', '2004-09-10 12:06:57', '4kVum37ehl');
INSERT INTO `student` VALUES (250, 'Sakurai Hikari', 'nYasZQTCtC', '2025-08-20 21:35:51', 'VOP58PJrYE');
INSERT INTO `student` VALUES (251, 'Ueno Mio', 'UyLJgDLVEJ', '2006-07-14 05:43:27', 'mNIqig2LVb');
INSERT INTO `student` VALUES (252, 'Yuen Wing Suen', 'rdQCBtFBCR', '2020-11-05 21:10:32', '38PfQDzogk');
INSERT INTO `student` VALUES (253, 'Nomura Rena', 'lPOQhLnX3Y', '2011-12-25 04:15:39', 'TtsTsX19iV');
INSERT INTO `student` VALUES (254, 'Saito Rena', 'RlE6ZNIo8A', '2002-12-18 08:32:36', 'F6jVYQ4GHK');
INSERT INTO `student` VALUES (255, 'Brian Gordon', 'haMl3lYBmJ', '2023-11-25 20:52:26', 'vqFzWVtHXn');
INSERT INTO `student` VALUES (256, 'Arai Ren', 'kXGZhZFozC', '2021-05-14 16:36:23', 'dfeQ6LDTY9');
INSERT INTO `student` VALUES (257, 'Zhao Ziyi', 'u2WXnwEQ3W', '2013-05-05 09:17:43', 'HIQH0JSFXo');
INSERT INTO `student` VALUES (258, 'Yin Anqi', '6Uaq2YmYUh', '2004-11-21 00:28:51', 'Yp1hjynlPG');
INSERT INTO `student` VALUES (259, 'Arimura Daichi', 'AyEjrDZAaJ', '2014-10-23 07:14:24', 'nRGG8OP9lV');
INSERT INTO `student` VALUES (260, 'Ng Yu Ling', '1NS2qFq3mK', '2010-10-26 11:08:58', 'VnCJbACfvT');
INSERT INTO `student` VALUES (261, 'Yokoyama Hazuki', 'LNN1oCpj1Y', '2024-02-03 15:23:21', 'k7odgPG4Vi');
INSERT INTO `student` VALUES (262, 'Takahashi Ren', 'P7ca7Oxi6J', '2022-10-22 11:24:59', 'mNQTHFTeZn');
INSERT INTO `student` VALUES (263, 'Tan Ziyi', 'bPclxLt6s8', '2012-05-28 22:29:42', 'wq1OZ03W14');
INSERT INTO `student` VALUES (264, 'Qian Lan', 'bijIFjBU9n', '2006-04-13 11:03:47', '1lBaSiX1k4');
INSERT INTO `student` VALUES (265, 'Sakai Itsuki', 'O3LbXMs9d1', '2017-08-17 12:03:40', 'pFEbACiDJY');
INSERT INTO `student` VALUES (266, 'Yang Yunxi', 'zGLUiBbMho', '2010-08-10 09:50:58', 'k9zuYfrjMZ');
INSERT INTO `student` VALUES (267, 'Melvin Jordan', 'aGHum79Irg', '2004-02-08 21:00:18', '4bAFwcyPij');
INSERT INTO `student` VALUES (268, 'Clara Bailey', 'FoeG9VHMTy', '2016-05-31 12:53:03', 'BfcCWK8q9z');
INSERT INTO `student` VALUES (269, 'Mo Kwok Yin', 'aUe82SxFQQ', '2022-08-27 08:21:16', 'inBvAZHL6H');
INSERT INTO `student` VALUES (270, 'Hung Hui Mei', 'UUH4WbeQkv', '2017-09-25 06:39:27', '9x12AHRGtA');
INSERT INTO `student` VALUES (271, 'Hu Jiehong', 'lTjUuw8jRz', '2021-06-07 23:53:07', 'ifH3dYNg6t');
INSERT INTO `student` VALUES (272, 'Jonathan Lee', 'RdkrymiaKp', '2009-02-13 01:31:11', 'RsU7gh5Orm');
INSERT INTO `student` VALUES (273, 'Lu Yunxi', 'qYND7LVKoa', '2000-10-20 03:56:55', 'VtMjPqv2nv');
INSERT INTO `student` VALUES (274, 'Ku Chiu Wai', 'N8Ufxt8pcz', '2019-01-15 10:41:00', '94mGN4iHw0');
INSERT INTO `student` VALUES (275, 'Hao Shihan', 'rRyY8d1Iu8', '2000-10-11 16:13:27', 'ouZVMAeRoY');
INSERT INTO `student` VALUES (276, 'Brandon Porter', 'JlE26OCzHP', '2009-12-12 17:15:40', 'EdmSmKdf1G');
INSERT INTO `student` VALUES (277, 'Micheal Price', 'SzpoQVRs4k', '2018-02-23 13:09:08', 'skIRvNmnIY');
INSERT INTO `student` VALUES (278, 'Tang Jiehong', 'ncOapNBLst', '2000-10-01 05:02:31', 'IJ0JSKcQ2u');
INSERT INTO `student` VALUES (279, 'Anna Gibson', 'TkZQJdtYZI', '2006-08-13 17:12:17', '8ZRA3VxXtl');
INSERT INTO `student` VALUES (280, 'Wong Tin Wing', 'r5eZReEpKT', '2012-11-17 22:46:32', '9SXvC0gfYn');
INSERT INTO `student` VALUES (281, 'Sakurai Kaito', 'gQgnaD76sw', '2005-04-24 13:16:55', 'PTUjVZPj7L');
INSERT INTO `student` VALUES (282, 'Hirano Hikaru', 'j82cNEc1tz', '2013-10-13 00:20:10', 'JypugJjNpQ');
INSERT INTO `student` VALUES (283, 'Nomura Momoe', 'M8FjFqhqmM', '2006-03-20 11:16:54', 'oT6HRy3CNS');
INSERT INTO `student` VALUES (284, 'Zeng Jiehong', 'XtPFbYoFQ5', '2002-05-08 13:44:16', 'KraYuRzRn6');
INSERT INTO `student` VALUES (285, 'Gong Zhiyuan', 'Xf0m0kJqrU', '2014-09-04 08:45:31', 'pleBp7vkdF');
INSERT INTO `student` VALUES (286, 'Donna Weaver', '6tYK3g7aO8', '2022-03-14 23:14:00', 'RFSgjAObR7');
INSERT INTO `student` VALUES (287, 'Peter Peterson', 'G6u4KOafem', '2002-02-20 22:45:30', 'elAdR0i8tt');
INSERT INTO `student` VALUES (288, 'Anita Rogers', '3kiKMBT2fs', '2000-02-25 18:41:59', '3aV3wnb1PA');
INSERT INTO `student` VALUES (289, 'Maruyama Hikari', '8R5nLhbjza', '2015-05-01 20:17:45', 'cCw97Y4Krx');
INSERT INTO `student` VALUES (290, 'Ueda Akina', 'J6SYoEslRL', '2005-07-09 08:28:13', '1uVQaZu8s5');
INSERT INTO `student` VALUES (291, 'Morita Yuna', 'hO279xIoPj', '2020-09-06 04:53:47', 'tvLqTXqRm5');
INSERT INTO `student` VALUES (292, 'Kimura Rin', 'xktWNNGz0k', '2017-06-19 08:25:00', 'mxWOsoLQfn');
INSERT INTO `student` VALUES (293, 'Yuen Sze Kwan', 'AClIrX7fx7', '2023-10-21 15:32:42', 'dphy4UAbWv');
INSERT INTO `student` VALUES (294, 'Ueda Sakura', 'KryrBh6la2', '2024-10-07 20:34:32', 'LfC2oTVrEE');
INSERT INTO `student` VALUES (295, 'Anna Hamilton', 'ntOIPcgCy7', '2000-06-29 11:07:32', '8QWZ1OiUar');
INSERT INTO `student` VALUES (296, 'Yung On Na', '1Igt6FKHNM', '2011-05-19 14:29:16', 'Hu1Y4AC6Hd');
INSERT INTO `student` VALUES (297, 'Joanne Kelly', 'JmEv0zc34r', '2011-07-25 22:42:41', 'pkDkEQIKUu');
INSERT INTO `student` VALUES (298, 'Zhou Jiehong', 'rjkqu87cTn', '2017-03-21 15:17:17', 'KDxC2fzrNX');
INSERT INTO `student` VALUES (299, 'Dale Holmes', '5l6PxR6aes', '2012-12-11 22:22:30', 'PIRHsyZeRJ');
INSERT INTO `student` VALUES (300, 'Han Kar Yan', 'NOqM1G1irw', '2007-01-16 11:13:49', 'GkYkwROIU1');
INSERT INTO `student` VALUES (301, 'Gao Yunxi', 'Gw1sd78bwt', '2009-09-16 00:11:29', 'sUHAfj5XUq');
INSERT INTO `student` VALUES (302, 'Hara Riku', 'rHde9UQxyb', '2019-07-20 02:15:39', 'MmtmzJ8xwp');
INSERT INTO `student` VALUES (303, 'Cynthia Grant', 'OzMf1424aB', '2006-12-16 20:10:55', 'dxMxHgjpbW');
INSERT INTO `student` VALUES (304, 'Zhao Zhennan', 'Apmbc2KaEu', '2022-07-02 04:49:38', '2T3pWqXBP8');
INSERT INTO `student` VALUES (305, 'Fujita Ren', '5vuVSzyzY5', '2010-11-13 05:58:16', 'II0QDUbux9');
INSERT INTO `student` VALUES (306, 'Qin Shihan', 'N7DvIfl45K', '2022-04-02 10:34:43', '0w9DoNM8V1');
INSERT INTO `student` VALUES (307, 'Lok Tin Wing', 'IhigiCxr6n', '2010-08-20 08:23:19', 'XF8eBgDxya');
INSERT INTO `student` VALUES (308, 'Ng Sum Wing', 'rknNBdc0FP', '2018-12-18 22:24:16', 'ewd5vRwDR5');
INSERT INTO `student` VALUES (309, 'Matsui Seiko', 'XvWaR7uU0L', '2003-12-03 14:18:43', 'wTf1giXLKm');
INSERT INTO `student` VALUES (310, 'Fu Anqi', 'ywvchJkwNc', '2013-10-17 17:40:39', 'JZrMQkiBcI');
INSERT INTO `student` VALUES (311, 'Maria Williams', '5u4GhhHpKd', '2019-03-08 05:07:59', '8qIGafee8J');
INSERT INTO `student` VALUES (312, 'Tam Ming Sze', '2ykZOBCCi0', '2004-09-01 18:13:25', 'P0948aCYZp');
INSERT INTO `student` VALUES (313, 'Jennifer Martinez', 'xdJ9M4j6ol', '2010-07-30 10:49:03', 'jcKe3FgXua');
INSERT INTO `student` VALUES (314, 'Norman Rose', 'JayKz9N5Sm', '2018-01-04 06:27:30', 'oZisdOVDkD');
INSERT INTO `student` VALUES (315, 'Loui Ka Fai', '2IiB9PMj9P', '2005-07-15 20:25:55', 'g2Dfd6MECZ');
INSERT INTO `student` VALUES (316, 'Xu Xiaoming', 'mwMgbwQ9Sr', '2024-02-08 07:11:25', 'wmM83CaRE2');
INSERT INTO `student` VALUES (317, 'Katherine Clark', '1vei6lmt77', '2012-05-21 17:40:15', 'fDN7axJQJv');
INSERT INTO `student` VALUES (318, 'Li Ziyi', 'tpr33pFYQr', '2014-10-04 14:12:49', '7879gOymJn');
INSERT INTO `student` VALUES (319, 'Chen Ziyi', '0VRkDyKJJ7', '2001-09-25 10:28:57', '0TxAsVMnGz');
INSERT INTO `student` VALUES (320, 'Dawn Sanchez', 'oOEBcRA1qV', '2007-03-21 02:19:41', 'H2MMASplQp');
INSERT INTO `student` VALUES (321, 'Kwok Ka Keung', 'QX567EGA9V', '2003-02-04 08:39:00', '83WwfWi5RX');
INSERT INTO `student` VALUES (322, 'Fang Jialun', 'oywd9qEuPl', '2001-11-17 12:11:18', 'bzrbhcNyMX');
INSERT INTO `student` VALUES (323, 'Bonnie Crawford', 'XD8x2s5NtR', '2007-12-22 17:19:29', 'nEf38Wk6ds');
INSERT INTO `student` VALUES (324, 'Heung Wing Kuen', 'clwVN1vxJQ', '2007-11-08 10:28:33', 'TUUsEL7C5d');
INSERT INTO `student` VALUES (325, 'Ueno Aoshi', 'Xat2pyEmno', '2008-08-06 23:02:58', '7wcB2a5FBo');
INSERT INTO `student` VALUES (326, 'Karen Evans', 'WRV8ALBY5G', '2013-11-09 12:54:54', 'BUKsJuCmCE');
INSERT INTO `student` VALUES (327, 'Harada Daichi', 'pOUkjLjgvQ', '2018-01-12 12:56:15', 'O3paFLPlnM');
INSERT INTO `student` VALUES (328, 'Fan Ching Wan', 'fDrFEzs3Wr', '2022-04-11 09:00:54', 'ABZQjRWPqf');
INSERT INTO `student` VALUES (329, 'Ding Lan', 'hUTUC08RLJ', '2022-01-15 12:46:12', 'bqpQ4U2PAZ');
INSERT INTO `student` VALUES (330, 'Yuen Sai Wing', 'WKmqGBTa5l', '2024-05-13 09:18:32', 'YGg6TfxTWN');
INSERT INTO `student` VALUES (331, 'Chen Rui', 'NJZT20ajc1', '2015-07-11 02:38:37', 'qLV78oMR3c');
INSERT INTO `student` VALUES (332, 'Kondo Hazuki', 'W2eoYGaXXE', '2023-04-03 07:49:28', 'hw18KCjrVY');
INSERT INTO `student` VALUES (333, 'Sharon Mills', 'Z0le8CPH1t', '2025-08-24 19:02:12', '4qBrX6KYnh');
INSERT INTO `student` VALUES (334, 'Yoshida Hikaru', '1tzeCGuW1s', '2000-03-09 15:02:47', 'BcQHn3Kt52');
INSERT INTO `student` VALUES (335, 'Xie Zhennan', 'ocy7Aqir7N', '2017-05-09 20:35:57', 'Rs7ovfo46V');
INSERT INTO `student` VALUES (336, 'Beverly Walker', 'Dg4949fDBp', '2021-01-24 09:27:54', 'rzMQPZAZm6');
INSERT INTO `student` VALUES (337, 'Kwong Chi Ming', 'K4cxUzkTjn', '2018-03-11 07:02:16', '7OG7qOV0lH');
INSERT INTO `student` VALUES (338, 'Mike Herrera', 'A3hAnBOglM', '2005-09-15 08:31:44', 'lsMnklt2No');
INSERT INTO `student` VALUES (339, 'Ye Anqi', 'WvtAdHJRIW', '2023-08-16 21:08:05', 'WIktnpRmDy');
INSERT INTO `student` VALUES (340, 'Luo Shihan', 'hMbEr0qaIu', '2025-09-23 23:48:47', '3Z6NuObpDC');
INSERT INTO `student` VALUES (341, 'Guo Lu', '2eyC9aOvri', '2018-12-19 04:11:11', 'xt69d1KbI8');
INSERT INTO `student` VALUES (342, 'Ti Ka Ling', 'SVH6VWZsfx', '2005-06-06 23:38:20', 'i3y3hrgJ7H');
INSERT INTO `student` VALUES (343, 'Tang Rui', 'ZAPcX1N9BC', '2020-11-21 02:57:42', 'yLbpXhbvD8');
INSERT INTO `student` VALUES (344, 'Yuen Wai San', 'hBWi9ugqqP', '2023-07-17 23:29:47', 'IBlhfXpuml');
INSERT INTO `student` VALUES (345, 'Denise Kelley', 'vhgh9IAUti', '2008-09-09 12:43:09', 'NdWyO73rjD');
INSERT INTO `student` VALUES (346, 'Shirley Evans', 'zQC2OOTkcd', '2022-08-23 21:15:50', '0gt5go6pEW');
INSERT INTO `student` VALUES (347, 'Feng Yunxi', 'BhRBNFIL4t', '2011-08-11 01:35:00', 'FIh1f5xPOs');
INSERT INTO `student` VALUES (348, 'Marcus Warren', 'Oz0pgAKPrG', '2021-12-22 17:41:09', 'yOJDbfwiJO');
INSERT INTO `student` VALUES (349, 'Wong Ka Ling', '0lM4o7ddyg', '2021-03-09 06:27:00', 'SS3eSM1SaZ');
INSERT INTO `student` VALUES (350, 'Tang Jialun', 'ojIRuuX9Kk', '2025-04-14 00:13:59', 'HgJzCUkPZ8');
INSERT INTO `student` VALUES (351, 'Mui Chi Yuen', 'thWZ3taF8q', '2013-01-10 05:19:02', 'xhFGAelhLq');
INSERT INTO `student` VALUES (352, 'Donna Mendez', 'FkaoaERSA2', '2009-04-08 18:04:56', 'RHYj8L2bTu');
INSERT INTO `student` VALUES (353, 'Taniguchi Momoka', 'br8V5nHoDf', '2018-08-17 18:58:59', 'OecCzxJlRz');
INSERT INTO `student` VALUES (354, 'Connie Snyder', '2oBfHR0Q6F', '2021-09-12 15:08:48', 'jjvD36EX2V');
INSERT INTO `student` VALUES (355, 'Tang Lan', 'X30ZdRYshQ', '2007-08-01 04:37:59', 'Fl8jOLqfEb');
INSERT INTO `student` VALUES (356, 'Lok Yun Fat', 'PVsl2HPrfd', '2020-12-20 14:43:30', 'COEFqDN9bT');
INSERT INTO `student` VALUES (357, 'Han Tak Wah', 'Xoi6Iv1Qp2', '2003-11-10 18:16:35', 'n0rotgXJgV');
INSERT INTO `student` VALUES (358, 'Danny Johnson', '6Ff2fHsldq', '2010-07-08 12:56:41', 'U0Xm9kKxzM');
INSERT INTO `student` VALUES (359, 'Paul Woods', 'MRdJ0CV4a4', '2018-08-09 10:01:44', 'x1vnxBTYnJ');
INSERT INTO `student` VALUES (360, 'Tanaka Ren', '8ADqvZ7g5Q', '2011-06-27 02:07:11', 'Wa3lUOCpI6');
INSERT INTO `student` VALUES (361, 'Chung Wing Fat', 'uv83l4c7qV', '2008-08-08 04:00:11', 'mtDEgdrh6W');
INSERT INTO `student` VALUES (362, 'Watanabe Mitsuki', 'KlDxTHmQZ9', '2016-11-18 14:55:18', 'JnJD4ObrBM');
INSERT INTO `student` VALUES (363, 'Lok On Na', 'VFGNPObDps', '2013-05-05 13:53:44', 'b5Oqj9d5lh');
INSERT INTO `student` VALUES (364, 'Shao Yunxi', 'fXFZDP03gr', '2024-08-20 17:52:17', 'AHpxzaNE4z');
INSERT INTO `student` VALUES (365, 'Pan Yunxi', '9uZR4upM0A', '2006-11-20 20:06:03', 'uAPj3ZxcU0');
INSERT INTO `student` VALUES (366, 'Tang Ka Keung', 'rc022X3C6B', '2002-10-30 19:00:19', 'W3oK5KAfTN');
INSERT INTO `student` VALUES (367, 'Hashimoto Daisuke', 'uMKgKIfUSy', '2015-05-14 17:39:07', 'HzPiMBj6Vb');
INSERT INTO `student` VALUES (368, 'Chic Fat', 'BF09Tak1OR', '2023-07-26 14:02:42', 'JHDVTNIWJM');
INSERT INTO `student` VALUES (369, 'Ti Ka Keung', 'gBBFo4btCn', '2005-03-22 22:14:37', 'X9Rnmotvi2');
INSERT INTO `student` VALUES (370, 'Hsuan Wing Sze', 'tByhoHqo4r', '2006-11-26 17:05:21', 'q9VRnN8XiX');
INSERT INTO `student` VALUES (371, 'Roger Wilson', 'VXCKz6uaJj', '2020-09-17 03:57:52', '4QQr4RnLRB');
INSERT INTO `student` VALUES (372, 'Gu Zhennan', 'CZF5p5uc8P', '2018-11-30 05:26:42', '81YPU2WN1X');
INSERT INTO `student` VALUES (373, 'Yokoyama Ikki', 'KWCV1kGkiI', '2023-05-25 12:15:53', 'noD9IvcLMV');
INSERT INTO `student` VALUES (374, 'Liao Zhennan', 'sgk1zJwkiF', '2006-09-24 07:19:34', 'Md6EQb0b0M');
INSERT INTO `student` VALUES (375, 'Chang Lan', 'RZJ2cWaJGg', '2016-02-21 09:50:36', 'z2iPq1sEaZ');
INSERT INTO `student` VALUES (376, 'Cho On Na', 'F1bgaPDqgX', '2009-06-15 20:07:15', 'ZClkULzy3j');
INSERT INTO `student` VALUES (377, 'Qian Shihan', 'NAyzo57ysu', '2011-07-16 16:34:10', 'V7fbWJrnnB');
INSERT INTO `student` VALUES (378, 'Han Ka Ming', 'uNoVQan8Oh', '2006-04-15 11:55:33', '0oY3ZngqZW');
INSERT INTO `student` VALUES (379, 'Chic Ching Wan', 'LXFqeKNtu0', '2016-09-05 20:24:20', 'g4vZFvKfvf');
INSERT INTO `student` VALUES (380, 'Jacob Reyes', '63GxHHp5xz', '2005-04-13 12:34:29', 'a4qbcSU1TI');
INSERT INTO `student` VALUES (381, 'Murakami Mitsuki', 'K3ejLZRaFf', '2012-08-18 17:46:59', 'DDtUazgNdw');
INSERT INTO `student` VALUES (382, 'Ding Lu', 'VWRKTjIFP9', '2001-09-25 06:38:03', 'ZOiYIyj9wE');
INSERT INTO `student` VALUES (383, 'Sun Zhennan', 'bfBwKhRjhT', '2010-06-12 03:32:33', 'iflx1IVBTy');
INSERT INTO `student` VALUES (384, 'Benjamin Martin', 'uzhZQ2m6wQ', '2021-08-26 09:01:52', 'gMGTzHhLe4');
INSERT INTO `student` VALUES (385, 'Imai Eita', 'W1jgA9SbWZ', '2008-02-05 18:13:45', 'MDdT48r8vb');
INSERT INTO `student` VALUES (386, 'Debra Jackson', '4LY93CYtto', '2014-03-05 13:56:01', 'qZDRr4y2RN');
INSERT INTO `student` VALUES (387, 'Micheal Herrera', 'CudNRcmlhr', '2010-08-08 17:55:00', 'qEBND9md0X');
INSERT INTO `student` VALUES (388, 'Chen Xiuying', 'E8mUHAiXKO', '2002-02-07 06:24:52', 'ABZwoGpeKc');
INSERT INTO `student` VALUES (389, 'Nakamori Kasumi', 'PrkeRjtF3D', '2015-09-27 22:33:50', 'GWLyQvqIBS');
INSERT INTO `student` VALUES (390, 'Wong Ka Fai', '6UUKtHyBqD', '2005-03-25 08:56:08', 'BD2PPbtOG7');
INSERT INTO `student` VALUES (391, 'Jane Romero', '3P54zVXY6C', '2004-12-13 06:51:05', 'fxHau2cmKQ');
INSERT INTO `student` VALUES (392, 'Wayne Stewart', 'am5nuZQyoz', '2012-09-12 10:36:28', 'RloDy5wNrZ');
INSERT INTO `student` VALUES (393, 'Paul Cole', '0QvDvjtbZT', '2019-07-04 18:46:18', 'tAuaLca9oC');
INSERT INTO `student` VALUES (394, 'Ma Zhennan', 'x1EP71plYh', '2016-10-04 13:40:58', 'j8eo90Dh5i');
INSERT INTO `student` VALUES (395, 'Mak On Na', 'vR92Iobkvn', '2019-03-18 12:07:23', 'fXsrCo7YTm');
INSERT INTO `student` VALUES (396, 'Sun Jialun', 'Z4peOCq6ti', '2022-10-08 03:21:58', 'EZ9ML0DGOs');
INSERT INTO `student` VALUES (397, 'Wong Yun Fat', '9Gw9kgiE0v', '2020-07-05 15:45:48', 'S2yFnUz2eC');
INSERT INTO `student` VALUES (398, 'Dale Nelson', 'TUJoxEVwVU', '2003-12-01 22:23:30', 'XLJWJuZwhx');
INSERT INTO `student` VALUES (399, 'Danielle Meyer', '8PTk7jsc5s', '2021-08-31 06:18:57', 'mkOc9Ae84m');
INSERT INTO `student` VALUES (400, 'Cheng Kar Yan', 'f06epuQwfm', '2019-10-14 02:08:14', 'rQwKsANNiX');
INSERT INTO `student` VALUES (401, 'Elaine Hunt', 'NGCsSm4IDS', '2018-05-13 08:40:16', 'AcCckY12Ak');
INSERT INTO `student` VALUES (402, 'Zhong Zhennan', 'NQ2n0qVEIG', '2025-02-11 07:31:10', 'BezTvuo012');
INSERT INTO `student` VALUES (403, 'Marcus Howard', 'vooUrSEdB6', '2006-10-15 17:41:40', '9vmf2oocQv');
INSERT INTO `student` VALUES (404, 'Kojima Sakura', 'qC6iftIewm', '2015-07-15 14:30:36', 'hN23f3KDW1');
INSERT INTO `student` VALUES (405, 'Cho Tsz Hin', '1ueKHTJbVT', '2004-09-23 23:19:30', 'kKlTjfKxvG');
INSERT INTO `student` VALUES (406, 'Masuda Kenta', 'UPVhLJuh3o', '2006-05-06 12:30:29', 'Ud4XjrIlk5');
INSERT INTO `student` VALUES (407, 'Ueno Rin', '5FXW674OX6', '2016-01-07 06:31:45', 'm2LlscScT1');
INSERT INTO `student` VALUES (408, 'Hui Ka Ling', '8nrjz7yNW8', '2013-06-10 12:17:24', '3YN6bzK3Om');
INSERT INTO `student` VALUES (409, 'Jeff Bryant', 'qIAS4R1XRg', '2001-09-22 22:44:07', 'BgPAynzQvp');
INSERT INTO `student` VALUES (410, 'Choi Ka Keung', 'FoUoMwlL6G', '2006-05-19 16:47:30', '0fL7nzNvuI');
INSERT INTO `student` VALUES (411, 'Ito Yuna', 'bWks7b3D9S', '2022-05-18 20:47:22', 'dQ8U7F6qb5');
INSERT INTO `student` VALUES (412, 'To Tak Wah', 'CtN8DAB7ZP', '2015-10-19 10:33:23', 'kl0ZP3VrZ8');
INSERT INTO `student` VALUES (413, 'Tam Yu Ling', 'PZLWlWets7', '2024-05-04 17:56:11', 'pnZD9OXnFr');
INSERT INTO `student` VALUES (414, 'Yue Ming', 'jtBkOG3mCo', '2014-05-27 20:41:42', 'wrzc4Vp6ps');
INSERT INTO `student` VALUES (415, 'Eva Reyes', 'YIXYlPk8yt', '2018-11-27 06:17:30', 'TVdwl7JuW8');
INSERT INTO `student` VALUES (416, 'Yung Sau Man', 'WgkNsuBa7r', '2012-10-06 08:49:26', 'Nn5bKXKWw4');
INSERT INTO `student` VALUES (417, 'Crystal Smith', '4LH1xtDr9w', '2017-08-10 22:12:29', '42pYnrLyTQ');
INSERT INTO `student` VALUES (418, 'Dai Sum Wing', 'CVl9R8zU3D', '2010-12-28 04:23:26', '2YupFQqyQT');
INSERT INTO `student` VALUES (419, 'Chin Ka Ming', 'ba65xt68EI', '2023-01-13 13:32:55', 'iGqSs4texC');
INSERT INTO `student` VALUES (420, 'Yoshida Yuto', 'fiNJhiMHV3', '2014-06-05 12:49:32', 'F3yrsgteOi');
INSERT INTO `student` VALUES (421, 'Qin Zhennan', 'nhCcOf7D9h', '2018-08-10 18:27:21', 'oH8ehJT4Sn');
INSERT INTO `student` VALUES (422, 'Bradley Nguyen', 'jyryWMFlby', '2019-07-13 08:52:07', 'Qdyp5zCYJP');
INSERT INTO `student` VALUES (423, 'Meng Lu', 'gnZPVuKhx7', '2009-07-28 16:41:38', 'Gi6Xf55ZKW');
INSERT INTO `student` VALUES (424, 'Sato Minato', 'TOwp7lGiol', '2022-06-26 20:29:48', 'X2i0DkH4Op');
INSERT INTO `student` VALUES (425, 'Kobayashi Kenta', '5E5RVtzSzQ', '2018-10-03 09:28:31', 'IBRWSECvyN');
INSERT INTO `student` VALUES (426, 'Melissa Walker', 'rFGD5wRn3e', '2012-01-04 19:49:22', 'yxLhAeN9Cd');
INSERT INTO `student` VALUES (427, 'Jiang Jiehong', 'CqiDxlGwXS', '2008-03-24 05:21:07', 'bN2Vs1X6Br');
INSERT INTO `student` VALUES (428, 'Gao Lu', 'kHRmWt49ML', '2002-10-01 01:39:01', '8EOrNF4r2a');
INSERT INTO `student` VALUES (429, 'Kato Rin', 'pYdJ8PmpJn', '2011-02-23 23:49:38', 'Lf0UDvwrAs');
INSERT INTO `student` VALUES (430, 'Ye Zhiyuan', 'r9LnRYt8QH', '2004-10-22 14:34:46', 'akpq9lxg9n');
INSERT INTO `student` VALUES (431, 'Tao Wai San', 'bsjFNtyg9N', '2012-11-09 21:24:15', 'IQuY8nrTTO');
INSERT INTO `student` VALUES (432, 'Du Lu', 'uWKrR6yNOR', '2001-03-17 00:56:20', '2aZyeCIyGJ');
INSERT INTO `student` VALUES (433, 'Kobayashi Ryota', 'YJsRXcoGbP', '2008-10-22 22:35:09', '8sPmGkiuUh');
INSERT INTO `student` VALUES (434, 'Li Zhennan', 'OjZzEw71aF', '2016-07-14 21:48:11', 'KxT6qoMUdc');
INSERT INTO `student` VALUES (435, 'Michael Moore', 'q8GU6IGEab', '2022-08-07 11:03:59', 'b4R1Y1IJkA');
INSERT INTO `student` VALUES (436, 'Tong Chi Ming', 'j4V3frNInQ', '2007-04-14 17:32:18', 'UxIyMD4EAS');
INSERT INTO `student` VALUES (437, 'Murakami Ayano', 'l5ArbShWgZ', '2002-11-09 02:09:18', 'PEBT0qSZOz');
INSERT INTO `student` VALUES (438, 'Deng Ziyi', 'EvqIEBleOt', '2018-12-24 14:17:44', 'kHotwEBx4L');
INSERT INTO `student` VALUES (439, 'Eddie Adams', 'kaoDoDUVxM', '2024-11-21 07:14:41', '3T5AdsnQqe');
INSERT INTO `student` VALUES (440, 'Rose Vargas', 'cdxxl2HabA', '2007-04-03 10:46:03', 'oxg3T0eVk1');
INSERT INTO `student` VALUES (441, 'Fung Fu Shing', 'RoB23NghAR', '2004-07-27 21:02:05', 'E3KunmllJo');
INSERT INTO `student` VALUES (442, 'Roger Kennedy', 'C34t1Dk7nH', '2010-03-10 18:03:40', '2Gx2jM9XZX');
INSERT INTO `student` VALUES (443, 'Tam Wing Sze', 'MBYnY8LRgH', '2014-02-02 06:09:15', 'SrRZMGbWmV');
INSERT INTO `student` VALUES (444, 'Ying Ming Sze', 'Y7uPXkOucx', '2025-01-18 06:35:01', 'VgiFluqXOp');
INSERT INTO `student` VALUES (445, 'He Yunxi', 'lvLOPHRtt2', '2019-11-08 09:23:42', 'TN6FvOT3wl');
INSERT INTO `student` VALUES (446, 'Chow Kwok Kuen', 'gagf50Ng3G', '2019-09-23 02:20:38', '09BuSieoza');
INSERT INTO `student` VALUES (447, 'Tan Lu', 'DsAVKWAbuR', '2005-09-02 00:39:24', '6NBw6VDCtR');
INSERT INTO `student` VALUES (448, 'Jane Ruiz', 'r5HnKsVEr6', '2015-07-21 09:20:50', 'WiqUWmsEFU');
INSERT INTO `student` VALUES (449, 'Masuda Seiko', '8Ix7EFMmiZ', '2008-10-11 07:46:07', 'LQ2reEilj5');
INSERT INTO `student` VALUES (450, 'Xie Jialun', 'uqZ9skI9hJ', '2017-12-17 07:26:07', 'W7fGXpDJYa');
INSERT INTO `student` VALUES (451, 'So Tak Wah', 'qc4IKFHeq6', '2012-12-25 12:26:35', 'lXP0WWfp1Q');
INSERT INTO `student` VALUES (452, 'Harada Ayato', 'IhnMW5iEHq', '2006-04-17 18:17:02', 'KAWdeAFstD');
INSERT INTO `student` VALUES (453, 'Gerald Anderson', 'u8Q1S7Ei5g', '2015-06-26 22:00:32', 'cXP30wSGwK');
INSERT INTO `student` VALUES (454, 'Xia Zhennan', 'JnqrfrlOVd', '2022-05-17 21:26:25', 'INTv3BpuGJ');
INSERT INTO `student` VALUES (455, 'Choi Hok Yau', 'FF9GnMHftC', '2002-07-01 14:44:47', 'fnCsnObdRe');
INSERT INTO `student` VALUES (456, 'Shimada Hazuki', '7WlF22zrv3', '2004-07-10 10:59:42', 'RU9x5ABUgZ');
INSERT INTO `student` VALUES (457, 'Gong Xiaoming', 'y4sa2VBFxP', '2008-06-17 04:25:58', 'xYqJ424YtR');
INSERT INTO `student` VALUES (458, 'Suzuki Eita', 'z0D0lLAdPy', '2014-02-07 11:31:39', 'dbOIciBsNc');
INSERT INTO `student` VALUES (459, 'Marjorie Ferguson', 'OGm7XXAjjf', '2018-10-19 10:54:03', 'mjQk0jm0Mp');
INSERT INTO `student` VALUES (460, 'Alan Mills', 'akGDjJkhKq', '2008-04-13 14:20:20', '2iMBZbt3O3');
INSERT INTO `student` VALUES (461, 'Wei Jialun', 'WAFfkEmO1O', '2005-01-26 19:01:17', 'bS7suSVyR3');
INSERT INTO `student` VALUES (462, 'Saito Aoshi', 'Uso5NxQX9L', '2008-06-25 20:41:24', 'ku4pmMnnQV');
INSERT INTO `student` VALUES (463, 'Kwong Ming', 'mwkxvm8tjv', '2007-05-03 23:17:39', '8No9EXNxhY');
INSERT INTO `student` VALUES (464, 'Xiao Anqi', 'OLw0AU2a0j', '2022-08-31 19:09:40', 'JnnWAobaZd');
INSERT INTO `student` VALUES (465, 'Sheh Kwok Wing', 'HQ6IXgnNCu', '2024-08-01 11:17:01', '0iejAtnvuV');
INSERT INTO `student` VALUES (466, 'Inoue Hikaru', 'Ye9aNvuEi3', '2004-02-19 15:29:37', 'Khu4YYbCTh');
INSERT INTO `student` VALUES (467, 'Yang Lan', 'aWJm48M2up', '2005-03-16 11:49:22', 'qYVYSUajkJ');
INSERT INTO `student` VALUES (468, 'Nakagawa Mai', 'hkgtImo1UK', '2013-04-08 21:31:06', '9m4mOQpvtD');
INSERT INTO `student` VALUES (469, 'Cai Yunxi', '7VIi2EjPgH', '2021-02-01 16:19:18', 'dB4QN4xcu7');
INSERT INTO `student` VALUES (470, 'Yue Wing Kuen', 'sa3GqGFjPY', '2006-06-22 20:02:33', 'TyBfOXHq6V');
INSERT INTO `student` VALUES (471, 'Kinoshita Yamato', 'ukrUaVsIuH', '2001-03-01 05:13:43', 'KkolOK0BWn');
INSERT INTO `student` VALUES (472, 'So Wai Man', '7ooA3fXK4P', '2017-05-19 14:50:57', 'NgnpGsAt7d');
INSERT INTO `student` VALUES (473, 'Shi Lan', 'mjGM5oMOBY', '2018-06-10 01:07:52', 'Dopq5cvzIS');
INSERT INTO `student` VALUES (474, 'Qin Lu', 'ay37zSZ7qn', '2005-05-07 09:53:53', 'vBUS19lNE0');
INSERT INTO `student` VALUES (475, 'Carlos Baker', 'wLeSoTng12', '2010-12-02 03:30:27', '5PsF9nzRpl');
INSERT INTO `student` VALUES (476, 'Mo Zitao', '9uHCbNMM6g', '2001-07-24 07:40:11', 'ml8lsxYZXh');
INSERT INTO `student` VALUES (477, 'Tam Chung Yin', '12PdShAeqh', '2007-04-10 16:02:04', 'sJPfoyYUKk');
INSERT INTO `student` VALUES (478, 'Maruyama Yuito', 'yifLTgFYBf', '2005-01-06 22:07:29', 'LOHBAlpWNm');
INSERT INTO `student` VALUES (479, 'Yin Xiaoming', 'O30j40ia1T', '2007-12-18 03:50:37', 'kAYGYfW7XZ');
INSERT INTO `student` VALUES (480, 'Kikuchi Mitsuki', 'qFPCAvvvkO', '2001-05-02 22:57:59', 'eLlfshaC2G');
INSERT INTO `student` VALUES (481, 'Takada Hikari', 'fcJrKN0Kbx', '2013-12-29 04:36:25', 'LoWEfN48Vs');
INSERT INTO `student` VALUES (482, 'Chiang Sau Man', 'O8SVUCj1An', '2025-09-30 12:18:59', 'sDfin1Rzw6');
INSERT INTO `student` VALUES (483, 'Hsuan Wai Lam', 'qRIl0k0NRb', '2013-01-14 03:53:47', 'ckeunKY752');
INSERT INTO `student` VALUES (484, 'Lin Xiuying', 'a6JlAxRlSv', '2007-12-24 06:03:18', '6fpmegCJ9Z');
INSERT INTO `student` VALUES (485, 'Au Sum Wing', 'ZlBtK5Zbd0', '2012-01-23 05:16:16', 'TvWE1iNt3b');
INSERT INTO `student` VALUES (486, 'Shing Fat', '6DTi1aWP0t', '2010-03-23 06:23:31', 'XrlNq2tPBE');
INSERT INTO `student` VALUES (487, 'Ono Ikki', 'tDuwM15TzH', '2005-01-05 04:08:42', 'fhSbxA6k37');
INSERT INTO `student` VALUES (488, 'Curtis Guzman', 'yuyG69HSdZ', '2007-05-10 09:29:07', 'e5BIxZGHPR');
INSERT INTO `student` VALUES (489, 'Shi Zitao', 'sc4PnwYUsQ', '2023-02-20 23:39:36', 'qbVIOwKXeG');
INSERT INTO `student` VALUES (490, 'Gong Zhiyuan', '3Y9VpgO818', '2011-06-04 07:06:20', 'E79yayOicY');
INSERT INTO `student` VALUES (491, 'Curtis Hunt', 'haQc3ouoa9', '2002-11-26 01:29:19', 'B1LEZUpVID');
INSERT INTO `student` VALUES (492, 'Nakano Ikki', 'rNaQRlix5f', '2019-12-20 18:23:34', 'LcJqplVL4l');
INSERT INTO `student` VALUES (493, 'Marvin Murray', '7y8Xupq45d', '2016-08-22 07:13:41', 'cD3Uqi1Y9D');
INSERT INTO `student` VALUES (494, 'Ye Xiuying', 'u36pMuER9O', '2006-04-19 18:57:08', 'JlENUE22H7');
INSERT INTO `student` VALUES (495, 'Wu Chieh Lun', '5NQhTNKrrG', '2025-06-25 11:13:28', 'dGd1OnoOP2');
INSERT INTO `student` VALUES (496, 'Timothy Lewis', 'S0E8VaEm4J', '2011-06-07 21:33:27', '6RkCAwNNtN');
INSERT INTO `student` VALUES (497, 'Deborah Kim', 'Lffih95cbY', '2000-05-25 04:06:44', 'Ne8BuRLrkv');
INSERT INTO `student` VALUES (498, 'Brenda Tran', 'x94KeDmjOR', '2016-03-22 05:17:41', 'vMrMDZoUKi');
INSERT INTO `student` VALUES (499, 'Lau Kwok Yin', 'YhRsNcnvkP', '2010-12-11 20:51:40', 'l7hpo53PVa');
INSERT INTO `student` VALUES (500, 'Rhonda James', 'bPiFjDjHjo', '2008-05-26 06:36:31', 'nNfz0i6KA1');
INSERT INTO `student` VALUES (501, 'Lui Sai Wing', 'FoANEZoAG8', '2007-04-08 00:17:27', 'ATvfdCi9OJ');
INSERT INTO `student` VALUES (502, 'Connie Price', 'c5Fs2s32uk', '2011-10-15 07:12:33', 'XWwlZDhCsn');
INSERT INTO `student` VALUES (503, 'Qiu Lan', 'SyPAu4XaCC', '2009-12-07 09:12:57', 'b5yDArwdpU');
INSERT INTO `student` VALUES (504, 'Hara Nanami', 'xGpCBKVMaC', '2012-04-14 11:02:16', '8WJ6ynu3OX');
INSERT INTO `student` VALUES (505, 'Suzuki Eita', 'bu6By51HqV', '2006-11-22 23:28:00', '3wjCpSnNzy');
INSERT INTO `student` VALUES (506, 'Harada Ayano', '0BbZWY0nlL', '2010-12-13 18:39:03', 'qgsSGjKIgT');
INSERT INTO `student` VALUES (507, 'Matthew Hunter', 'pidRNpmZX0', '2022-06-05 15:16:56', 'U5iCYYGQzq');
INSERT INTO `student` VALUES (508, 'Helen Lewis', '4i07xAjBG3', '2018-03-15 14:30:41', 'X8PHv1gnrE');
INSERT INTO `student` VALUES (509, 'Chin Fu Shing', 'wWDNpN0u46', '2004-01-23 13:08:47', 'spVBUIDI1D');
INSERT INTO `student` VALUES (510, 'Marvin Spencer', 'I7GmlT43zw', '2014-06-10 03:53:17', '1M0MkiaviQ');
INSERT INTO `student` VALUES (511, 'Sakurai Ayano', 'WMV0UNSPKw', '2007-12-06 08:39:02', 'VcUDPMgY6C');
INSERT INTO `student` VALUES (512, 'Au Kwok Wing', '5Pl4qjxoCe', '2018-10-30 22:06:44', 'JuNs5uhNsk');
INSERT INTO `student` VALUES (513, 'Frank Green', 'EOFHXJxMMP', '2004-07-25 07:20:46', 'gnlbEMHeU1');
INSERT INTO `student` VALUES (514, 'Tracy Foster', 'A3dIC2l3R2', '2009-09-19 11:23:58', 'DGVJifWy7I');
INSERT INTO `student` VALUES (515, 'Taniguchi Kenta', 'vxb4zZIR66', '2000-05-01 03:38:52', 'JMAXy0ZxS0');
INSERT INTO `student` VALUES (516, 'Nakamura Ayato', 'Oo3AJLtrYR', '2008-12-03 11:18:13', '9vdIUBD7c9');
INSERT INTO `student` VALUES (517, 'Stephanie Castillo', 'UCLqAMsI1w', '2021-04-08 13:40:40', 'iX9oG70urg');
INSERT INTO `student` VALUES (518, 'Tracy Washington', 'KceLdXc26c', '2008-12-26 20:31:40', '9M8jVolpvd');
INSERT INTO `student` VALUES (519, 'Ruby Boyd', 'BfWATrcxSC', '2018-02-03 23:00:37', 'P3RtfOEnGu');
INSERT INTO `student` VALUES (520, 'Li Rui', 'gQN4N8Oimf', '2018-05-20 17:35:44', '330kX95U2s');
INSERT INTO `student` VALUES (521, 'Mori Ayano', 'YCGqfpVnnc', '2016-03-07 19:31:45', 'WcHUeJoaLy');
INSERT INTO `student` VALUES (522, 'Takeuchi Yuito', '15TztWoTtL', '2010-03-16 08:27:51', '8BflHTylVt');
INSERT INTO `student` VALUES (523, 'Doris Medina', 'enFeKJ44IA', '2019-04-27 18:00:52', 'cYVTjeNu2g');
INSERT INTO `student` VALUES (524, 'Wei Lu', 'tnIR9FPpdW', '2009-07-29 12:04:19', 'wdgm8ybw7K');
INSERT INTO `student` VALUES (525, 'Tong Chieh Lun', 'nALDi001NH', '2014-10-08 06:14:15', 'A3QKiMmqNO');
INSERT INTO `student` VALUES (526, 'Wong Kwok Ming', 'xKrIsqrQvw', '2011-02-25 12:03:58', 'Rw59pLtgk4');
INSERT INTO `student` VALUES (527, 'Judy Peterson', 'm7dCjceNl1', '2000-06-25 16:58:18', 'SzKSylfPRJ');
INSERT INTO `student` VALUES (528, 'Wu Zitao', 'tTanhJbfSY', '2015-07-22 07:45:23', 'Q55DTbUWHT');
INSERT INTO `student` VALUES (529, 'Tang Ka Ming', 'ZUoFPi9yhg', '2020-07-31 00:40:09', 'pZpUEVC7VS');
INSERT INTO `student` VALUES (530, 'Jennifer White', 'VXBFdUFoQN', '2016-06-03 11:10:07', 'oFSDwdXgig');
INSERT INTO `student` VALUES (531, 'Yoshida Ryota', 'P8bwTJtbFp', '2013-09-12 08:24:06', 'w2LXE13dFk');
INSERT INTO `student` VALUES (532, 'Kevin Anderson', 'kYBxwwvCeA', '2025-05-23 00:04:07', 'rewaTjAsJN');
INSERT INTO `student` VALUES (533, 'Billy Roberts', 'I2w3Cc6rSv', '2000-01-08 17:11:16', 'N4fiN94dKn');
INSERT INTO `student` VALUES (534, 'Clara Young', 'ajFqxkbN5H', '2020-02-21 08:32:18', '9MYRigwiby');
INSERT INTO `student` VALUES (535, 'Leroy Jones', 'QqmBsjX2bE', '2000-09-01 11:34:34', 'UUJECkdG3r');
INSERT INTO `student` VALUES (536, 'Carrie Murphy', 'WKv7i5Ihd7', '2017-12-30 01:06:52', 'npAG4sdMqC');
INSERT INTO `student` VALUES (537, 'Yan Anqi', 'aydYXeqJ4v', '2023-07-21 01:35:50', '6CYULl5BHI');
INSERT INTO `student` VALUES (538, 'Miura Momoka', 'Dqesc8iCBl', '2000-08-29 19:21:32', 'gIF3MHNzsr');
INSERT INTO `student` VALUES (539, 'Katherine Wright', 'YddCQxmbKr', '2002-08-05 20:19:35', 'bhvGtCmfVj');
INSERT INTO `student` VALUES (540, 'Lam Tin Lok', '1stZByyeNq', '2019-06-01 03:28:46', 'tO5oUefDkA');
INSERT INTO `student` VALUES (541, 'Yin Zhennan', 'jALqOANN3a', '2024-02-06 07:01:34', 'QFsvZwv4BT');
INSERT INTO `student` VALUES (542, 'Cao Zitao', 'Zn2otFS9R9', '2008-02-05 10:51:29', '1OLAAtyRft');
INSERT INTO `student` VALUES (543, 'Diana Harrison', 'QaOYGRZzpe', '2005-05-20 17:45:26', 'wHBgJHApNn');
INSERT INTO `student` VALUES (544, 'Harada Sara', 'FEptwwl0NR', '2019-08-30 13:21:09', 'KnHdN45VJQ');
INSERT INTO `student` VALUES (545, 'Zhou Lan', '8idaWNdOAf', '2023-01-07 09:47:49', 'QRR8NuqlZB');
INSERT INTO `student` VALUES (546, 'Yu Lan', '3IrwqG6qiA', '2016-01-15 15:09:00', 'bWLnq8Vabf');
INSERT INTO `student` VALUES (547, 'Siu Ling Ling', 'pMi7zw22ob', '2003-09-17 10:40:48', 'F0Yoa6RwLB');
INSERT INTO `student` VALUES (548, 'Sakai Ayato', 'fICG8PfFcF', '2021-11-19 12:01:32', 'Gw29qEyPaD');
INSERT INTO `student` VALUES (549, 'Lok Chi Ming', '0KYaFaXPXo', '2022-12-19 05:14:52', 'FuJ4eegiOn');
INSERT INTO `student` VALUES (550, 'Qin Xiaoming', '5mu2ZcGNXi', '2018-04-28 21:23:22', 'zXK1K0CzZw');
INSERT INTO `student` VALUES (551, 'Yuan Zhennan', '7jmb4TewYu', '2025-02-19 09:28:16', 'Q74dMCm22L');
INSERT INTO `student` VALUES (552, 'Martha Wallace', 'ACIFhpPZtg', '2016-06-24 22:05:07', 'SfsEQhPeLN');
INSERT INTO `student` VALUES (553, 'Li Anqi', 'VIhdpmh2BX', '2015-07-25 15:27:48', 't8PNN0QSa0');
INSERT INTO `student` VALUES (554, 'Xia Zhennan', 'kV6ezqd2HK', '2000-10-17 22:34:18', 'heyvWXj6MV');
INSERT INTO `student` VALUES (555, 'Barry Phillips', '3FuZwWXe2v', '2000-06-26 09:10:34', 'RdzSJMNgea');
INSERT INTO `student` VALUES (556, 'Lin Xiuying', 'vzmdN716aN', '2002-04-28 06:17:33', '7lEdMgdM8i');
INSERT INTO `student` VALUES (557, 'Carmen Payne', 'aqNbRwC0gy', '2013-03-31 11:02:44', 'WAx2POrlrX');
INSERT INTO `student` VALUES (558, 'Bernard Mendoza', 'gnq021CYlT', '2023-11-22 18:30:00', 'yGq5p6T4oU');
INSERT INTO `student` VALUES (559, 'Liu Zhennan', 'yj44FA1uxM', '2019-12-20 09:09:35', 'ORBXRayfGD');
INSERT INTO `student` VALUES (560, 'Fujii Hikaru', 'KhBMAA4jPm', '2004-11-19 23:05:31', 'oakQ83sZrI');
INSERT INTO `student` VALUES (561, 'Kong Yuning', 'g2GNNWEk5L', '2010-05-13 00:33:04', 'XhYqCmliIR');
INSERT INTO `student` VALUES (562, 'Zhao Jialun', '4iNJ0ImdFx', '2015-10-30 03:15:41', 'OqVd9g3MbF');
INSERT INTO `student` VALUES (563, 'Chin Ho Yin', 'ukis3CuX9j', '2009-08-08 04:15:47', 'jlfgx52xTS');
INSERT INTO `student` VALUES (564, 'Connie Coleman', '48Jf0L8A4f', '2023-09-15 06:15:27', 'HyWWhNjuQG');
INSERT INTO `student` VALUES (565, 'Kaneko Mitsuki', 'TvX0p5xTf3', '2005-04-11 05:06:47', '8KUMDRCvym');
INSERT INTO `student` VALUES (566, 'Zhang Ziyi', 'xbiiID0VXC', '2008-07-22 21:57:19', 'tFXTt73G86');
INSERT INTO `student` VALUES (567, 'Sherry Davis', 'BIGmWpAcvJ', '2006-04-06 04:29:27', '2ZMmONdqBi');
INSERT INTO `student` VALUES (568, 'Yeung Sum Wing', 'c86bg1cj2h', '2013-10-10 12:43:01', 'ioTsYcKps1');
INSERT INTO `student` VALUES (569, 'Tanaka Yota', 'MPi41a4NNZ', '2009-07-01 11:00:47', 'ALz6cW0awk');
INSERT INTO `student` VALUES (570, 'Maruyama Kenta', 'G3EtA3K1Ez', '2005-11-02 04:03:29', 'K9Thl3DKeM');
INSERT INTO `student` VALUES (571, 'Su Yunxi', 'Ftqt5YwgAP', '2020-02-20 05:37:15', 'WBvL1b4BqC');
INSERT INTO `student` VALUES (572, 'Kwong Tak Wah', 'EDyinWbYw5', '2022-11-06 17:55:27', 'fhyma4HoPh');
INSERT INTO `student` VALUES (573, 'Yau Ka Keung', 'qRUxRFpopf', '2010-06-17 23:45:53', 'PgPUuQVEZt');
INSERT INTO `student` VALUES (574, 'Ye Yuning', '5o2Tv088QP', '2017-03-05 10:10:31', 'h9D7iJAdPa');
INSERT INTO `student` VALUES (575, 'Wan Wing Kuen', 'Xyyd3VgAqp', '2004-03-20 04:58:15', 'U0o74qMX6J');
INSERT INTO `student` VALUES (576, 'Troy Cook', 'Ufr22SRdv6', '2014-08-20 07:55:14', '2umyDq2YP4');
INSERT INTO `student` VALUES (577, 'Luo Jiehong', 'QDG5UUyP7t', '2001-12-25 07:17:51', 'cVh0itbs5V');
INSERT INTO `student` VALUES (578, 'Gloria Rogers', 'd9E42lPZMV', '2009-02-24 08:43:04', 'XUlfb8P2YB');
INSERT INTO `student` VALUES (579, 'Yung Sau Man', 'iLayHtJxNS', '2004-11-21 18:55:51', 'VDOLKZst0o');
INSERT INTO `student` VALUES (580, 'Fukuda Tsubasa', 'ik3nytUEZR', '2006-05-17 22:14:20', 'u4eqBVGd5B');
INSERT INTO `student` VALUES (581, 'Wong On Kay', 'WIqPfmXw0h', '2018-02-15 13:31:21', 'QgNhl0irmZ');
INSERT INTO `student` VALUES (582, 'Tamura Rin', 'UoREPbA8ym', '2014-01-02 22:20:59', 'nFI4wemZs7');
INSERT INTO `student` VALUES (583, 'Dorothy Barnes', 'l9h7s7S4UV', '2018-03-07 22:04:56', 'u7xnjxrQHg');
INSERT INTO `student` VALUES (584, 'Emma Hayes', 'MGEFpf7HJF', '2025-05-04 22:54:58', 'svFVuhGipo');
INSERT INTO `student` VALUES (585, 'Tong Sum Wing', 'DtQAslXoYn', '2016-01-07 02:01:02', '9HijiKCsqJ');
INSERT INTO `student` VALUES (586, 'Tsang Chi Yuen', 'ZQIP8bdyKS', '2003-01-30 08:59:57', 'xEMG3UDolR');
INSERT INTO `student` VALUES (587, 'Yung Suk Yee', 'tkg2OnoypG', '2025-01-25 22:35:14', 'Odw0dGLtT4');
INSERT INTO `student` VALUES (588, 'Hou Jiehong', 'T4fRhSLSs5', '2023-05-17 13:33:06', 'ynWfL8ZujS');
INSERT INTO `student` VALUES (589, 'Lu Xiuying', 'lDllxpTS4e', '2012-12-19 12:35:14', 'Uq4LovhV7c');
INSERT INTO `student` VALUES (590, 'Cho Tin Lok', 'GRmj4bmPga', '2003-08-18 03:52:33', '9wML507lbD');
INSERT INTO `student` VALUES (591, 'Gerald Lopez', '9Ek4ILa8Hb', '2015-05-01 00:09:20', 'jAUAgCYNOj');
INSERT INTO `student` VALUES (592, 'Sakamoto Akina', 'EAgT6vmD39', '2018-06-13 15:12:03', '1UsxADqrc7');
INSERT INTO `student` VALUES (593, 'Wei Xiaoming', 'xA772ZENTq', '2015-12-01 00:48:45', 'dy4qCzxZOY');
INSERT INTO `student` VALUES (594, 'Yamazaki Ryota', 'H8g3DUPONR', '2016-01-18 03:36:18', 'LFNlKPpjxQ');
INSERT INTO `student` VALUES (595, 'Gao Shihan', 'w7kSsCat0x', '2019-10-20 07:06:24', 'xhcwAyAL96');
INSERT INTO `student` VALUES (596, 'Jane Henderson', 'hm7A43mOOs', '2024-08-16 11:34:03', 'qe1vkNiU7y');
INSERT INTO `student` VALUES (597, 'Kikuchi Yuto', 'IBzMZOxmgF', '2018-11-27 03:12:18', 'GPEw6o6jTw');
INSERT INTO `student` VALUES (598, 'Debbie Aguilar', '6UOwCm9MNK', '2015-09-06 07:25:01', 'h1rYdnYZts');
INSERT INTO `student` VALUES (599, 'Wendy Hayes', 'y91A0WOqpn', '2002-12-24 09:55:30', '6ThX9YxAiN');
INSERT INTO `student` VALUES (600, 'Harry Davis', 'NXFiX9RVBZ', '2003-07-31 04:39:02', 'RrECeAQAYa');
INSERT INTO `student` VALUES (601, 'Tang Lai Yan', '97SHzD3URm', '2001-07-01 01:02:48', 'TJ4yiWS4YM');
INSERT INTO `student` VALUES (602, 'Craig Murray', 'fAhKjXMsAn', '2009-07-28 02:10:03', '7Pp33JriU7');
INSERT INTO `student` VALUES (603, 'Abe Yamato', 'elZEGlP0X5', '2023-08-13 15:24:42', 'fBchTWUTU7');
INSERT INTO `student` VALUES (604, 'Nakamura Sakura', 'KH1qftSRLe', '2011-03-18 03:24:22', 'heyaZrEsvC');
INSERT INTO `student` VALUES (605, 'Ricky Cox', 'PlrI4OJKLr', '2017-03-06 00:34:59', '2Rsq0EInar');
INSERT INTO `student` VALUES (606, 'Ma Zitao', '03XzjyP9uX', '2000-08-19 01:33:34', 'LtFUHHSgte');
INSERT INTO `student` VALUES (607, 'Ishida Rena', 'J3TnG67c0W', '2004-07-22 12:31:09', 'RX6c0yx9zK');
INSERT INTO `student` VALUES (608, 'Ye Anqi', 'L8c0kgPjAS', '2017-11-02 05:28:19', 'kLNrC92SDM');
INSERT INTO `student` VALUES (609, 'Liao Sai Wing', 'ibVzHn8b4G', '2004-12-07 21:48:31', 'G5zmp5S9dE');
INSERT INTO `student` VALUES (610, 'Roger Thompson', 'fhTEn5wyk7', '2018-10-14 04:56:18', 'K98kXJvmyL');
INSERT INTO `student` VALUES (611, 'Kao Lik Sun', '99VlxEOjkX', '2004-07-03 12:11:07', 'TJWVSyp4aA');
INSERT INTO `student` VALUES (612, 'Lok Hiu Tung', 'p18uk0pQhV', '2017-08-11 10:37:49', 'KV2UrxJyXK');
INSERT INTO `student` VALUES (613, 'Xiao Ziyi', 'unsLP5xmG0', '2008-12-28 13:53:58', 'YrqrzNjXob');
INSERT INTO `student` VALUES (614, 'Gao Zitao', 'wXCsERX3VF', '2011-03-09 09:40:25', 'OAvJwardnP');
INSERT INTO `student` VALUES (615, 'Charlotte Salazar', 'mUJQO2P5Uf', '2016-05-11 03:33:38', 'PQ3CcZpATg');
INSERT INTO `student` VALUES (616, 'Sakai Minato', 'y6HBp955DI', '2009-06-05 12:36:04', 'LvyZMiAfyO');
INSERT INTO `student` VALUES (617, 'Takeda Akina', 'W4GwqMVTcc', '2007-05-08 23:22:57', 'Lhve51jmUU');
INSERT INTO `student` VALUES (618, 'Ho Kwok Kuen', 'LC2IkgtJjp', '2002-12-14 16:44:33', 'lh4FwaoWGR');
INSERT INTO `student` VALUES (619, 'Tamura Ryota', 'Cj8xUc0Ivm', '2023-11-01 18:51:55', 'gpT0sG1jKe');
INSERT INTO `student` VALUES (620, 'Chiba Misaki', 'TSuR6DHlxj', '2020-02-28 07:49:57', 'URYYuhQuhg');
INSERT INTO `student` VALUES (621, 'Hasegawa Nanami', 'WgitDU78l0', '2012-10-24 12:05:53', 'y52o72zjKo');
INSERT INTO `student` VALUES (622, 'Cui Zhiyuan', '0s5Mq2Bvhd', '2015-06-08 01:04:28', '3e0zU9iDwd');
INSERT INTO `student` VALUES (623, 'Rebecca Mendez', 'iXQTM4ehhm', '2022-09-26 21:44:49', 'Dg6RqWTATx');
INSERT INTO `student` VALUES (624, 'Aaron Rice', 'CufdtmSwl1', '2013-06-04 04:38:18', 'MUTfz4GwHj');
INSERT INTO `student` VALUES (625, 'Tang Lik Sun', 'oIpf6yyJ6I', '2019-04-28 21:59:19', 'zA5ONwIgzH');
INSERT INTO `student` VALUES (626, 'Han Rui', 'rdhz8jCG0d', '2025-06-23 02:52:41', '8upfVCuzo7');
INSERT INTO `student` VALUES (627, 'Yau Tin Wing', 'WcpZkZsAR8', '2024-12-29 05:43:21', 'jmm358Y9HP');
INSERT INTO `student` VALUES (628, 'Shing Wing Sze', 'AAu3wDcwrZ', '2007-05-03 02:06:35', 'DWfLmwl67G');
INSERT INTO `student` VALUES (629, 'Sakai Mio', 'K65gRdrJdv', '2024-08-15 10:16:56', '6koFLZkMuX');
INSERT INTO `student` VALUES (630, 'Xie Zhiyuan', 'ia6DJVKCRv', '2018-07-01 04:23:31', 'z79i1nzcEF');
INSERT INTO `student` VALUES (631, 'Taniguchi Kazuma', 'BeRh3JRQj4', '2008-11-02 01:21:36', 'JIe77iCbfB');
INSERT INTO `student` VALUES (632, 'Shirley Boyd', 'xmebGsTtUr', '2025-09-11 03:56:37', 'KCz9MCVvxr');
INSERT INTO `student` VALUES (633, 'Fukuda Eita', 'dJrJWOyV4D', '2009-04-11 20:56:19', 'M2XMLAOocx');
INSERT INTO `student` VALUES (634, 'Mak Tak Wah', '4aRlrl8VbQ', '2016-04-12 15:33:58', 'nEechcddeG');
INSERT INTO `student` VALUES (635, 'Lin Lu', '925A7VQ3W2', '2021-03-20 04:08:39', 'acDZUWvpzi');
INSERT INTO `student` VALUES (636, 'Nakamori Kasumi', '6opdBiqayC', '2020-09-29 05:10:55', 'l3qPw345Ov');
INSERT INTO `student` VALUES (637, 'Pauline Rose', 'TrYQprYx1G', '2000-06-02 15:59:54', 'xcNt4KMuYl');
INSERT INTO `student` VALUES (638, 'Ho Sum Wing', '9XSxNkhKWZ', '2015-05-19 07:23:41', 'djJH3zhsY1');
INSERT INTO `student` VALUES (639, 'Xiong Anqi', 'GE9LnFCev6', '2008-07-02 16:34:13', 'x7NVR0HqtN');
INSERT INTO `student` VALUES (640, 'Zhao Xiuying', 'oVEx1O3TuI', '2000-06-24 01:56:43', 'YVlADhJHwe');
INSERT INTO `student` VALUES (641, 'Hirano Mai', 'tQKbneNFMC', '2021-01-23 01:22:23', 'B7N3OOlCF3');
INSERT INTO `student` VALUES (642, 'Lois Boyd', 'qSCpulrzd5', '2011-04-16 12:04:48', 'WVGhPt4mNS');
INSERT INTO `student` VALUES (643, 'Man Hiu Tung', 'AVvlLDyLSl', '2007-07-12 15:46:21', 'wof565nAi6');
INSERT INTO `student` VALUES (644, 'Harada Seiko', 'rcvV6joWlc', '2020-10-22 16:44:46', 'DNDYVYx4FQ');
INSERT INTO `student` VALUES (645, 'Nakayama Hikaru', 'fhFfnTO5kb', '2017-07-04 10:20:11', 'O8aHGJ5Pua');
INSERT INTO `student` VALUES (646, 'Fujita Airi', 'NkEUuThyE0', '2009-02-08 20:05:35', 'NDe7rr9vAI');
INSERT INTO `student` VALUES (647, 'Choi Hiu Tung', 'nWpmFaSY2K', '2005-09-10 09:31:20', '6I8lF0DykR');
INSERT INTO `student` VALUES (648, 'Clarence Roberts', 'wZgPaHHLYY', '2010-08-16 12:35:26', 'gE6qCswzM0');
INSERT INTO `student` VALUES (649, 'Wayne Jackson', 'qYrGgx31r3', '2017-10-09 06:18:30', 'KYZPE2BRWt');
INSERT INTO `student` VALUES (650, 'Du Ziyi', 'DQyZcFfq5X', '2006-12-16 04:31:34', 'tflKWcVF9I');
INSERT INTO `student` VALUES (651, 'Johnny Jordan', 'R4xgZuEFlv', '2012-10-20 17:27:49', 'ITeUuCI0NU');
INSERT INTO `student` VALUES (652, 'Edith Clark', 'wXMOB8WgAZ', '2000-12-05 16:02:00', 'MBCT1pNy0N');
INSERT INTO `student` VALUES (653, 'Deng Xiuying', 'YsTdsZS2hu', '2011-03-05 01:30:59', 'E44SaBz956');
INSERT INTO `student` VALUES (654, 'Yuen On Kay', 'qoWvTJvsed', '2013-07-27 12:45:17', 'Zgc7SjXzoq');
INSERT INTO `student` VALUES (655, 'Hsuan Ka Fai', 'H1Ed26Ljeu', '2024-07-03 14:16:58', 'S28wXuMBAg');
INSERT INTO `student` VALUES (656, 'Yau Wing Kuen', 'wZcvknPnIZ', '2004-04-29 02:21:17', '43GEdsqIoH');
INSERT INTO `student` VALUES (657, 'Ashley Washington', 'FIfpa5U64W', '2004-03-31 08:26:55', 'VAGqg49xUa');
INSERT INTO `student` VALUES (658, 'Liao Fu Shing', '70aEqsyW9q', '2019-08-31 07:07:45', 'LuUB3vo1Ul');
INSERT INTO `student` VALUES (659, 'Curtis Dixon', 'FgFHcQ5KV9', '2010-04-12 16:45:43', 'vBoLrC9z9o');
INSERT INTO `student` VALUES (660, 'Marjorie Graham', 'MahU1JnK0J', '2022-06-28 21:08:44', 'xRhPVmnvZ6');
INSERT INTO `student` VALUES (661, 'Matsui Rin', 'uidvgwg5IA', '2003-01-21 07:07:44', 'Z0AMuXxTiD');
INSERT INTO `student` VALUES (662, 'Chow Ming', '7wVSEcCAbl', '2020-06-26 14:51:02', 'nH9VtYrdOt');
INSERT INTO `student` VALUES (663, 'Ma Shihan', 'EMi4VNcuy8', '2020-11-27 18:38:05', 'kFbrIcpGt4');
INSERT INTO `student` VALUES (664, 'Takagi Kaito', 's8MzlhTIJZ', '2002-08-24 04:21:28', 'k9FnsL6FJJ');
INSERT INTO `student` VALUES (665, 'Carmen Perry', 'ixg76eltz5', '2008-07-31 08:56:00', 'hWI98do3Lq');
INSERT INTO `student` VALUES (666, 'Jack Ross', '5xOEholqGA', '2002-10-10 02:36:33', '40RrOH5ffU');
INSERT INTO `student` VALUES (667, 'Wada Yota', 'kJF1mWPR5U', '2011-12-13 10:18:26', 'DceU1PlZzj');
INSERT INTO `student` VALUES (668, 'Nomura Ikki', '7rq68sBCKw', '2012-01-02 18:41:37', '0YRb50bDaC');
INSERT INTO `student` VALUES (669, 'Donald Harris', 'XK7hanTx7N', '2025-05-09 21:50:36', 'TQpACRpqUV');
INSERT INTO `student` VALUES (670, 'Lo Tak Wah', '3h3DRj5cWp', '2002-04-30 00:23:45', 'aZumYMtkeT');
INSERT INTO `student` VALUES (671, 'Mui Kwok Yin', '5LeGANM5Mz', '2003-03-05 10:36:09', 'Ypbip72xZ2');
INSERT INTO `student` VALUES (672, 'Heung Wing Sze', 'tVso1QxXi1', '2002-05-13 18:22:42', 'PMj5ip6SeU');
INSERT INTO `student` VALUES (673, 'Long Shihan', 'HY14yiqe9x', '2021-11-07 14:59:44', 'npcRRh7y04');
INSERT INTO `student` VALUES (674, 'Richard Castillo', 'Iwp5EAUFX5', '2017-10-07 19:50:17', 'qfCe7O9A9u');
INSERT INTO `student` VALUES (675, 'Marvin Mills', '32HdYCUv8k', '2015-07-21 09:40:35', 'A1tH7PZ6Wl');
INSERT INTO `student` VALUES (676, 'Kathryn Cook', 'GGVrPjfnEy', '2016-06-23 20:54:52', '4WHBSV8XMq');
INSERT INTO `student` VALUES (677, 'Heung Tak Wah', '4yZpoE2DYg', '2023-07-11 09:48:08', 'ajKFzcQROG');
INSERT INTO `student` VALUES (678, 'Choi Ling Ling', 'SRSUpzp0gi', '2024-09-05 09:11:26', 'xzmZU8plXS');
INSERT INTO `student` VALUES (679, 'Chang Lan', 'FlVUd6c5ye', '2004-01-05 09:42:34', 'GMzOY8BDII');
INSERT INTO `student` VALUES (680, 'Zheng Yunxi', '8MD9mV8ayE', '2005-04-09 22:06:44', 'IhcR0cxX0o');
INSERT INTO `student` VALUES (681, 'Sylvia Wagner', 'yL2ZKuJbot', '2009-06-09 17:08:57', 'zcnMn38eH1');
INSERT INTO `student` VALUES (682, 'Earl Payne', 'RsyVj9zRXH', '2025-04-14 19:11:15', 'deFVNbDT3r');
INSERT INTO `student` VALUES (683, 'Murata Hazuki', 'deMkmbtDIX', '2007-01-13 04:57:29', '8G0rKWnKjE');
INSERT INTO `student` VALUES (684, 'Ku Tsz Ching', 'ODlibdhUJA', '2000-12-15 17:08:13', 'EPDG9wkn5D');
INSERT INTO `student` VALUES (685, 'Xu Rui', 'Ajz4m2Q4uZ', '2008-04-21 02:28:09', '4EirIJ6AgO');
INSERT INTO `student` VALUES (686, 'Matsumoto Kenta', '3WoUwDwFa6', '2015-01-31 13:16:53', 'YtqgWseDFY');
INSERT INTO `student` VALUES (687, 'Tracy Porter', 'EZYPAimG6K', '2014-09-01 13:37:45', 'X1T5YDDR7z');
INSERT INTO `student` VALUES (688, 'Zhong Zhennan', 'jp6ZjDiPwB', '2007-05-22 19:54:45', 'gByFjNeQ5o');
INSERT INTO `student` VALUES (689, 'William James', 'JGKZH7LByW', '2010-01-14 14:27:51', 'eJpX0ivp03');
INSERT INTO `student` VALUES (690, 'Cho Ting Fung', 'Mr3jyITvNl', '2006-01-14 06:21:37', 'jdP7ynErCn');
INSERT INTO `student` VALUES (691, 'Tong Tak Wah', 'Xddwqv0akn', '2023-02-18 14:23:46', 'aAmxTvze8H');
INSERT INTO `student` VALUES (692, 'Lo Cho Yee', 'naqcBU34sR', '2004-09-13 10:52:56', 'kKd6ztN95i');
INSERT INTO `student` VALUES (693, 'He Xiuying', '2HarTmiBDo', '2002-10-12 18:46:47', 'wH5ANAtCcp');
INSERT INTO `student` VALUES (694, 'Xia Xiuying', 'akoOeLmPYO', '2010-04-24 13:14:35', 'bDyCl0wVct');
INSERT INTO `student` VALUES (695, 'Long Xiuying', 'WlPO5zCQAC', '2023-01-09 15:45:46', 'oSmDvfY0d1');
INSERT INTO `student` VALUES (696, 'Beverly Howard', 'JwWPRFZsiD', '2003-07-19 22:37:10', 'IwRHComBCi');
INSERT INTO `student` VALUES (697, 'Gu Rui', 'b7doWXRrtG', '2009-05-08 23:29:21', 'J2sf8ezIQx');
INSERT INTO `student` VALUES (698, 'Dong Lan', 'EgSUJUgMTC', '2018-01-11 11:05:46', 'SsiM7lJyoD');
INSERT INTO `student` VALUES (699, 'Ichikawa Riku', 'VpDpESnKDi', '2004-11-09 20:58:53', 'yQZgAyjDc9');
INSERT INTO `student` VALUES (700, 'Takagi Hikari', 'Z4zU3OvSZp', '2020-09-12 11:28:04', 'uy0ZsdSGer');
INSERT INTO `student` VALUES (701, 'Murakami Sara', 'mcFxFw3xQG', '2017-10-30 11:24:09', 'l3JnoJxBre');
INSERT INTO `student` VALUES (702, 'Lin Zhiyuan', 'LCRPFv5dxX', '2015-05-26 23:46:35', 'pKcuOWk4ir');
INSERT INTO `student` VALUES (703, 'Lee Sau Man', 'ajd2oZDEUp', '2003-12-22 14:39:34', 'bpKrQfkzLD');
INSERT INTO `student` VALUES (704, 'Arai Minato', '3H5i69IbRk', '2008-02-13 08:22:09', 'pAbqd9Riw9');
INSERT INTO `student` VALUES (705, 'Matthew Kelley', 'HEfc2nzPjZ', '2010-05-13 18:04:54', '9B6WPryUcm');
INSERT INTO `student` VALUES (706, 'Irene Phillips', 'YzJGy5kmnF', '2013-03-31 19:26:47', 'vjUJDn004M');
INSERT INTO `student` VALUES (707, 'Zhang Jialun', 'xfcaEnKnHe', '2001-01-31 20:46:42', '06OHzDVpbm');
INSERT INTO `student` VALUES (708, 'Hashimoto Sakura', '6JmwU46hcV', '2021-08-06 22:29:48', 'zmg1JnTp7x');
INSERT INTO `student` VALUES (709, 'Takahashi Ikki', '1vfnc80sci', '2018-08-04 17:23:19', 'kmrEVFYNH7');
INSERT INTO `student` VALUES (710, 'Peng Zitao', 'OWcLEoVICB', '2013-08-14 23:45:20', 'xdKMt56YA7');
INSERT INTO `student` VALUES (711, 'Imai Rin', 'ba271OTA5Q', '2022-09-01 19:54:36', 'BWJ5MdQhck');
INSERT INTO `student` VALUES (712, 'Gong Shihan', 'fleCSIpxEN', '2020-10-18 06:19:58', 'qtrbQWQQBX');
INSERT INTO `student` VALUES (713, 'Nathan Shaw', 'DgNiaBUjZL', '2006-09-11 05:37:51', 'dmZ7Winnjm');
INSERT INTO `student` VALUES (714, 'Takahashi Airi', 'c7w9oWd7xL', '2021-03-23 15:09:32', '4f3d2cix92');
INSERT INTO `student` VALUES (715, 'Matsuda Seiko', 'AZVqvWwoub', '2017-02-04 01:18:35', 'befo5HBWgb');
INSERT INTO `student` VALUES (716, 'Huang Jiehong', 'I2AsPcuaMC', '2019-07-10 15:38:11', 'T0087uCAuL');
INSERT INTO `student` VALUES (717, 'Fujiwara Minato', 'YKCQsGAtcR', '2024-03-15 21:21:36', 'dawphrTDJQ');
INSERT INTO `student` VALUES (718, 'Yuen Suk Yee', 'GOd58g5JCn', '2011-05-21 05:01:17', 'a9Fv21di1i');
INSERT INTO `student` VALUES (719, 'Earl Rivera', 'tycJo8Qy3O', '2009-06-30 15:37:51', 'cZYmpdNo6N');
INSERT INTO `student` VALUES (720, 'Lu Zhennan', 'HzUp8uAfr7', '2020-11-19 23:48:15', 'W4xHjoZ7Yo');
INSERT INTO `student` VALUES (721, 'Nakayama Ayano', 'zmVwbfYgGY', '2023-03-28 22:32:13', 'qp0sAIkqt0');
INSERT INTO `student` VALUES (722, 'Yuen On Kay', 'fQtQBopUlO', '2017-07-12 11:48:58', 'V5GKmpYZiH');
INSERT INTO `student` VALUES (723, 'Taniguchi Miu', '99MfwVfemV', '2009-10-02 13:05:44', 'iCj16jiz8E');
INSERT INTO `student` VALUES (724, 'Jerry Fisher', 'MuwtQz9U1L', '2009-03-16 07:23:13', '2HFyydP1Ag');
INSERT INTO `student` VALUES (725, 'Yamada Ayato', 'neIKNmaA3l', '2000-07-10 03:42:28', 'l34SMmP4xz');
INSERT INTO `student` VALUES (726, 'Sano Airi', 'Ai3WkTNGLt', '2022-01-16 19:44:25', '0kcLK9CO0n');
INSERT INTO `student` VALUES (727, 'Che Sau Man', 'u5rFN1K668', '2018-01-22 11:57:06', '3OxRkd65Xn');
INSERT INTO `student` VALUES (728, 'Dong Yunxi', 'ql6bGEWSw6', '2019-03-22 03:21:38', 'N1v55srGrH');
INSERT INTO `student` VALUES (729, 'Fujiwara Hana', 'HXxbvJAyVC', '2009-02-16 10:48:32', '7pbCAM8ybh');
INSERT INTO `student` VALUES (730, 'Kaneko Miu', 'GM4WPSLs3K', '2022-11-22 00:05:23', 'FzbNWMUMZR');
INSERT INTO `student` VALUES (731, 'Shimizu Ayano', 'lKLMxPZKvm', '2015-12-08 04:07:26', '3XLDbR3Dv6');
INSERT INTO `student` VALUES (732, 'Saito Aoshi', 'RuUMdCkHt0', '2024-04-10 12:39:29', 'rpW9nYOh5n');
INSERT INTO `student` VALUES (733, 'Gerald Reed', 'qfsqMTXOX6', '2017-10-24 02:28:57', 'gYFnW3rt1G');
INSERT INTO `student` VALUES (734, 'Zhu Lu', 'yvu9u3ZlAr', '2003-01-02 20:29:10', 'mwXru1vx1u');
INSERT INTO `student` VALUES (735, 'Wendy Ferguson', 'fR2If58ZpS', '2015-07-13 00:23:10', '9fC9BWKtJ6');
INSERT INTO `student` VALUES (736, 'Joseph Roberts', '3ACcT5YTqh', '2016-04-19 03:27:35', 'Xw5A4u96WV');
INSERT INTO `student` VALUES (737, 'Wada Momoka', '02wcfpQ0bU', '2016-06-13 14:09:16', 'VpXII3yEuf');
INSERT INTO `student` VALUES (738, 'He Yunxi', 'qoYc87covQ', '2007-03-08 17:55:27', 'zOAXAVtxbI');
INSERT INTO `student` VALUES (739, 'Ye Ziyi', 'o0xaIcQyIj', '2008-05-21 07:11:16', 'TNrkyuXJuo');
INSERT INTO `student` VALUES (740, 'Elaine Webb', 'Nprnpa3KrR', '2023-12-15 10:36:11', 'ntPvKMaEWZ');
INSERT INTO `student` VALUES (741, 'Kaneko Nanami', 'txHdJYbvOO', '2018-01-29 15:59:34', '4ao9PPHCmT');
INSERT INTO `student` VALUES (742, 'Mao Anqi', 'JD6CRbSUW7', '2005-06-30 22:21:23', '2eNpViPXxY');
INSERT INTO `student` VALUES (743, 'Chiba Misaki', 'BQzexWKizF', '2010-07-26 14:42:32', 'tdJ5xkv894');
INSERT INTO `student` VALUES (744, 'Xiong Zitao', 'zkAgldUA3w', '2016-12-06 02:40:10', 'R0SmOjfhVK');
INSERT INTO `student` VALUES (745, 'Wei Ziyi', '5ri3mr88Th', '2025-05-06 20:58:35', '0WOxMhdsLy');
INSERT INTO `student` VALUES (746, 'Dai Jialun', 'cZpeDKzRRe', '2001-07-22 17:16:30', 'dXtcY5YzmP');
INSERT INTO `student` VALUES (747, 'Siu Ka Ming', 'Cd1E3yLDs6', '2021-03-15 10:31:45', '7enUwbrPAv');
INSERT INTO `student` VALUES (748, 'Douglas Nelson', 'n8TVnfbJI0', '2011-11-15 02:12:59', 'igSMm1krMc');
INSERT INTO `student` VALUES (749, 'Kondo Mai', 'z3TOMA3OcY', '2021-10-01 00:38:55', 'lRXMjroS4W');
INSERT INTO `student` VALUES (750, 'Lai Wai Man', 'iRdQ0Ur924', '2001-02-25 11:11:23', '63CNv3fJZ7');
INSERT INTO `student` VALUES (751, 'Nishimura Rena', 'hk8Vm7zVOi', '2009-02-07 08:06:02', '8Iiyuf7Nff');
INSERT INTO `student` VALUES (752, 'Liang Yuning', '8PAgnU69uV', '2013-06-21 20:02:25', 'tSra68SKTJ');
INSERT INTO `student` VALUES (753, 'Koyama Daisuke', 'GaIcU4bUL4', '2021-12-17 06:32:40', 'Pt2XHxeQcU');
INSERT INTO `student` VALUES (754, 'Ishii Aoshi', 'OHpubhAcQf', '2001-10-29 23:21:48', 'aGo9pmY9WH');
INSERT INTO `student` VALUES (755, 'Yung Ting Fung', 'oKcIfYhChS', '2015-02-03 14:48:21', 'GZDFc6kQ3L');
INSERT INTO `student` VALUES (756, 'Chan Ching Wan', 'qI9v0zVmX5', '2018-03-16 15:52:35', 'H7NePhratp');
INSERT INTO `student` VALUES (757, 'Ng Kwok Ming', 'T8vNjHvpUT', '2020-04-22 20:56:20', 'qkMqbYpH14');
INSERT INTO `student` VALUES (758, 'Ishida Yuna', 'QVe61gz8XV', '2017-01-19 00:29:55', 'VoBMwuq6eH');
INSERT INTO `student` VALUES (759, 'Takeda Tsubasa', 'J0fKYomSLM', '2001-01-02 16:54:51', 'DFgpMhZ8bR');
INSERT INTO `student` VALUES (760, 'Miguel Kelley', 'jLH5nUq5je', '2015-08-02 14:46:52', 'qD3UziZSf1');
INSERT INTO `student` VALUES (761, 'Lok Sai Wing', 'L1kXvJ4GjS', '2022-11-05 08:51:56', 'BWru1cySKe');
INSERT INTO `student` VALUES (762, 'Tin Ming', 'GWISV0mReQ', '2016-09-18 05:06:29', 'Zqz4FBGGFC');
INSERT INTO `student` VALUES (763, 'To Kar Yan', 'xLlzTjKQmF', '2013-11-05 18:32:04', 'GEO6lFOwox');
INSERT INTO `student` VALUES (764, 'Mao Yunxi', '1nHSptaSxH', '2011-01-09 20:57:08', 'peLik2kT9Z');
INSERT INTO `student` VALUES (765, 'Sato Daichi', 'HnDIuHVfo6', '2007-08-01 12:03:46', 'Mxh7biIX5W');
INSERT INTO `student` VALUES (766, 'Ren Lu', 'wPnPj5DULz', '2019-01-10 17:45:55', 'U3p7rzgN0h');
INSERT INTO `student` VALUES (767, 'Jia Lan', 'LVaINB2IiD', '2023-08-22 10:52:19', 'hLzTaQ8zsw');
INSERT INTO `student` VALUES (768, 'Kong Lan', 'Y0XrDdaVve', '2010-09-10 16:12:44', 'vxsVeSZllv');
INSERT INTO `student` VALUES (769, 'Harada Ryota', 'WviFjjF0Va', '2000-04-05 21:38:58', 'G3a5nb3sGl');
INSERT INTO `student` VALUES (770, 'Zheng Lan', 'IfpEfHdhG6', '2011-10-29 17:15:27', 'wEIKH3iSrb');
INSERT INTO `student` VALUES (771, 'Howard Dixon', 'v6VuhBOM4c', '2025-08-13 18:29:21', 'RsQk6BlEPq');
INSERT INTO `student` VALUES (772, 'Danny Weaver', 'zO0w6etiu2', '2007-12-20 02:53:53', 'FFstjBCJMu');
INSERT INTO `student` VALUES (773, 'Nancy Perry', 'yTuH8yrJcc', '2018-04-01 09:49:38', 'a4HJ7wvA9V');
INSERT INTO `student` VALUES (774, 'Rita Washington', 'MCYPbQOXIS', '2022-12-29 10:13:56', '1cXG27VWrG');
INSERT INTO `student` VALUES (775, 'Antonio Harrison', '41EMFfsUb1', '2009-01-09 07:17:35', 'KyDjdoSz62');
INSERT INTO `student` VALUES (776, 'Siu Ka Ling', 'p1q234tyfN', '2016-09-14 12:28:21', 'QvYg9TyggI');
INSERT INTO `student` VALUES (777, 'Nakamura Aoshi', 'sz3zUfvAyq', '2010-07-07 23:01:30', 'wTwmeFVJOu');
INSERT INTO `student` VALUES (778, 'Edwin Simmons', 'dGGifbsSKu', '2024-07-23 17:28:33', 'FkoSxpMKyG');
INSERT INTO `student` VALUES (779, 'Okada Yamato', 'saiX0dpk5W', '2012-05-27 23:22:14', 'BehS2s6Al4');
INSERT INTO `student` VALUES (780, 'April Weaver', 'kMsc8HfGDu', '2015-06-10 16:21:13', 'Z7iLn2JXc5');
INSERT INTO `student` VALUES (781, 'Morita Ryota', 'j0R2x5eHrE', '2018-12-01 06:56:58', 'HDNMvuCDAU');
INSERT INTO `student` VALUES (782, 'Fung Fat', 'DJOM1aVImw', '2000-12-18 03:51:48', 'Pt4F0BX1g1');
INSERT INTO `student` VALUES (783, 'Yuen Sze Yu', '3e3dVcuIgb', '2009-06-28 18:49:48', '5joMs2yFws');
INSERT INTO `student` VALUES (784, 'Sugiyama Yuito', 'kYJUr1XVMj', '2021-12-08 14:41:56', 'xRk2mVraus');
INSERT INTO `student` VALUES (785, 'Tamura Shino', '7hDMLXJ5yE', '2005-04-08 14:37:34', 'uzGfT6vOZE');
INSERT INTO `student` VALUES (786, 'Choi Wai Yee', 'KcAGN99Wfb', '2024-06-25 12:33:31', 'LtfDM3bkUL');
INSERT INTO `student` VALUES (787, 'Yoshida Hikari', 'cAHH1cuh1z', '2023-04-02 13:43:16', 'A4fx6MDX0k');
INSERT INTO `student` VALUES (788, 'Ti Ting Fung', 'F71c86IAdp', '2024-08-15 13:49:40', 'XbXIHQMb6S');
INSERT INTO `student` VALUES (789, 'Wei Yuning', '230aXlOqzv', '2004-08-15 07:40:06', 'HZjrrbhnaF');
INSERT INTO `student` VALUES (790, 'Paula Burns', 'RpRiDfR6bI', '2010-07-29 04:30:26', 'DEvtnIxuU6');
INSERT INTO `student` VALUES (791, 'Kimberly Kelley', 'nKM5Ql4N9i', '2022-12-31 06:30:35', 'SXlG1dgoGD');
INSERT INTO `student` VALUES (792, 'Ying Ling Ling', 'TQzonpb2nX', '2002-07-12 14:09:11', '26N5Lp4wqk');
INSERT INTO `student` VALUES (793, 'Hirano Yuna', 'FJggrhQqYe', '2006-08-02 12:32:15', 'INuJKgOsAY');
INSERT INTO `student` VALUES (794, 'Lisa Chen', 'WRmpGRYfGT', '2001-12-02 21:23:21', 'QjNdQxmBOd');
INSERT INTO `student` VALUES (795, 'Lok Fat', 'nN5tFqte6n', '2004-05-25 21:29:29', 'JsoKow7noh');
INSERT INTO `student` VALUES (796, 'Hasegawa Hana', 'uJevWG8ypu', '2013-10-15 10:40:11', 'U4bLdAOeFa');
INSERT INTO `student` VALUES (797, 'Ando Hikari', 'FBQnWUigCt', '2020-07-04 08:07:52', 'E67AXKIBCu');
INSERT INTO `student` VALUES (798, 'Wan Ka Keung', '8fL4g3nVdj', '2024-09-12 02:05:11', '2m1KLXtXP8');
INSERT INTO `student` VALUES (799, 'Hou Jiehong', 'S5hWf0RnNX', '2018-06-20 00:53:10', 'pRaEpA5nMa');
INSERT INTO `student` VALUES (800, 'Bradley Thomas', 'bO9BNfPE4I', '2003-01-02 21:12:47', 'muQsVcqCW7');
INSERT INTO `student` VALUES (801, 'Xu Zhennan', 'O4ygFxFYYw', '2002-03-01 12:40:28', 'mvBz4HExPJ');
INSERT INTO `student` VALUES (802, 'Au Hok Yau', 'ppA9es7Rul', '2020-07-21 08:01:59', 'mdWyf8HOy3');
INSERT INTO `student` VALUES (803, 'Sugawara Kaito', 'ICfeWILj6P', '2021-11-07 20:48:01', 'aBK3BOqZOp');
INSERT INTO `student` VALUES (804, 'Liao Hiu Tung', 'hqZF3hRRPk', '2010-08-26 11:09:32', 'nO1TlIsfWq');
INSERT INTO `student` VALUES (805, 'Matsuda Momoka', 'TcBwsvStD4', '2014-08-03 11:02:58', 'WV2BxAJfj9');
INSERT INTO `student` VALUES (806, 'Lam Wing Kuen', 'jvnZdJzU6F', '2005-10-06 04:15:50', 'wEHbsktSoH');
INSERT INTO `student` VALUES (807, 'Saito Daichi', '0ABX560vDC', '2009-12-20 05:12:16', 'ekhq8aBNE4');
INSERT INTO `student` VALUES (808, 'Deng Lu', 'YkcankEU0y', '2024-07-08 20:49:14', 'C7DWSdKUY1');
INSERT INTO `student` VALUES (809, 'Arimura Riku', 'eQE4jt6Nlx', '2023-03-02 03:59:03', 'RSFa8EUNM0');
INSERT INTO `student` VALUES (810, 'Song Ziyi', 'wYYWyThxeD', '2020-10-28 05:20:26', 'bY0pqfHkHA');
INSERT INTO `student` VALUES (811, 'Miyamoto Rin', 'xkSIqekupD', '2016-09-13 23:00:12', 'MEcFajfaku');
INSERT INTO `student` VALUES (812, 'Marcus Cooper', '27ubXhSV9o', '2004-08-11 09:31:14', 'FvNK2YdV4f');
INSERT INTO `student` VALUES (813, 'Amy Peterson', 'XtpXhu9aG5', '2000-06-23 07:39:05', 'CjY04nFHdL');
INSERT INTO `student` VALUES (814, 'Tsui Suk Yee', 'kihycReCYk', '2015-03-04 00:23:24', '4RKzR6bDw8');
INSERT INTO `student` VALUES (815, 'Tao Jiehong', 'ClPS3xptjQ', '2005-04-02 18:50:32', 'NkAIhfooQD');
INSERT INTO `student` VALUES (816, 'Sheila Romero', 'CyP6Bl8WQm', '2012-01-18 13:13:38', 'yISK9XPlRz');
INSERT INTO `student` VALUES (817, 'Zhu Jialun', '9Ji0yjceSW', '2002-07-11 11:37:15', 'ekBdpqGQtz');
INSERT INTO `student` VALUES (818, 'Philip Burns', 'd75A91irPt', '2024-10-05 10:24:04', '5IbSKBxKcI');
INSERT INTO `student` VALUES (819, 'Nakamori Momoka', '0j3iv72iTU', '2017-09-25 01:17:34', 'rOkykfyEl7');
INSERT INTO `student` VALUES (820, 'Eric Edwards', '9Ikzvq7nZp', '2007-09-18 19:12:49', 'L3Q0VG2sr0');
INSERT INTO `student` VALUES (821, 'Sasaki Hikari', 'i106cJKltp', '2001-10-21 08:12:51', 'l52T58CL9Z');
INSERT INTO `student` VALUES (822, 'Fujii Sara', 'dHGuBYmBdY', '2009-01-22 01:19:49', 'NMyosdvVD2');
INSERT INTO `student` VALUES (823, 'Ueda Miu', 'tCh713QgUF', '2025-02-18 00:34:33', 'O1aTNW1dXg');
INSERT INTO `student` VALUES (824, 'Mao Zhiyuan', 'MgRtFozTWO', '2022-03-30 16:58:11', 'WJvdb02LxZ');
INSERT INTO `student` VALUES (825, 'Yin Kwok Ming', 'l1IK5fZ0xW', '2003-02-17 11:17:16', 'IaH7tP4AEH');
INSERT INTO `student` VALUES (826, 'Tiffany Nichols', 'T51xBUSF2f', '2020-03-17 13:55:05', 'FcjrzCUaVt');
INSERT INTO `student` VALUES (827, 'Hayashi Kaito', 'bi8zFTPUgL', '2006-09-29 02:24:52', 'lclFpBi9Gr');
INSERT INTO `student` VALUES (828, 'Hou Anqi', 'J8Kp5YfVh6', '2005-10-19 16:26:47', 's4jiy1PZX8');
INSERT INTO `student` VALUES (829, 'Dorothy Nichols', 'mYcnomDtTV', '2011-02-23 05:55:16', 'mLl32GlGgV');
INSERT INTO `student` VALUES (830, 'Saito Ren', 'lS4Ty1KLLR', '2015-02-13 04:52:02', 'TFaPcPA8Z7');
INSERT INTO `student` VALUES (831, 'Chic Ka Ming', 'aA4aM2rAms', '2002-08-07 13:45:44', 'weswy0pOrf');
INSERT INTO `student` VALUES (832, 'Wei Xiaoming', 'VF80UYSlA4', '2014-09-15 23:10:08', 'tzWeAejB9R');
INSERT INTO `student` VALUES (833, 'Kwong Wing Sze', '8w8Xd8XqxQ', '2016-02-27 02:45:42', 'g2pWy9JUKB');
INSERT INTO `student` VALUES (834, 'Kong Jialun', '82gmGNRc3U', '2009-02-11 15:49:58', 'WmgDkIKLod');
INSERT INTO `student` VALUES (835, 'Zhang Yuning', 'Q1QTi9zOb0', '2001-07-17 01:08:29', 'KWITiDpiFH');
INSERT INTO `student` VALUES (836, 'Brandon Bryant', 'r3oDQeni8e', '2015-12-26 09:19:26', 'GcOQ75Bpby');
INSERT INTO `student` VALUES (837, 'Okamoto Hina', 'KSW4VjtCfJ', '2018-05-15 17:28:00', '2W3w5xLUx3');
INSERT INTO `student` VALUES (838, 'Kenneth Parker', 'FWoJKnJC7n', '2012-01-11 19:29:35', 'OdhiF3eLQY');
INSERT INTO `student` VALUES (839, 'Murakami Rena', '46vlkTOBv2', '2009-05-18 17:37:11', '9oreU6DYm4');
INSERT INTO `student` VALUES (840, 'Shi Jialun', 'tcQkUvrw6M', '2012-04-05 19:05:19', 'YnQwIyEG7l');
INSERT INTO `student` VALUES (841, 'Sato Yuto', 'V7neSQkgDg', '2018-12-23 04:19:34', 'TRJC487dBe');
INSERT INTO `student` VALUES (842, 'Siu Fu Shing', '4QftGLSxaY', '2015-10-24 14:34:17', 'GRGQjHbL9j');
INSERT INTO `student` VALUES (843, 'Yam Wing Sze', 'eE3UBNWyta', '2024-07-17 13:42:02', '1Zr0nL0BZ4');
INSERT INTO `student` VALUES (844, 'Sit Sze Yu', 'nKkH17nB7Q', '2001-10-07 20:07:51', 'OidotZiVUX');
INSERT INTO `student` VALUES (845, 'Jia Shihan', 'cLyq2vUF9i', '2016-12-31 04:22:59', '9omukz1f6K');
INSERT INTO `student` VALUES (846, 'Sugawara Itsuki', '1PV8USsdAM', '2014-11-18 18:25:57', 'N8AapxzRoD');
INSERT INTO `student` VALUES (847, 'Marie Mcdonald', 'DIEQqMRgqo', '2020-06-09 12:06:10', 'E22xqPodQS');
INSERT INTO `student` VALUES (848, 'Hu Lu', 'Dglblwtfnb', '2000-06-16 10:45:16', 'OQ5XgrGKgz');
INSERT INTO `student` VALUES (849, 'Leung Kwok Wing', 'vcMQlH8Gbj', '2015-12-07 01:03:55', 'noWcfuwhEq');
INSERT INTO `student` VALUES (850, 'Lillian Boyd', 'DnEx68phWF', '2018-10-25 17:26:28', 'NlO1LVWf6h');
INSERT INTO `student` VALUES (851, 'Fu Yunxi', 'uicAYgJVYb', '2015-02-11 06:09:54', 'fajCcyezN1');
INSERT INTO `student` VALUES (852, 'He Zhennan', 'TKQ2hps1ct', '2022-11-12 10:39:58', 'MVLv03WV4C');
INSERT INTO `student` VALUES (853, 'Yamamoto Yuna', 'M22fqYF9gI', '2019-09-20 02:26:06', 'gcoD88tNZA');
INSERT INTO `student` VALUES (854, 'Deng Zhiyuan', 'XLMzKiooxW', '2024-12-03 19:17:54', 'MeaO53vxVE');
INSERT INTO `student` VALUES (855, 'Tao Wing Sze', '5e5HCM99vY', '2014-08-28 14:57:36', 'HX155UrACV');
INSERT INTO `student` VALUES (856, 'Kato Ryota', 'G1HygLVMcV', '2007-03-19 13:39:31', 'HTEu7xqyt9');
INSERT INTO `student` VALUES (857, 'Hasegawa Miu', 'uUuUKBQlu2', '2003-08-12 22:39:10', '0BRl97M6bD');
INSERT INTO `student` VALUES (858, 'Leung Kwok Yin', '2aOm63ideL', '2019-07-03 12:34:55', 'O1gvNap8rh');
INSERT INTO `student` VALUES (859, 'Ono Aoi', 'vHYnmUwh9U', '2011-06-25 05:26:40', 'Xxfpom1X7b');
INSERT INTO `student` VALUES (860, 'Henry King', 'lQyIZaOhY1', '2000-02-27 09:49:39', 'at06ejrtIJ');
INSERT INTO `student` VALUES (861, 'Tsang Wai Yee', '7jgX0GLNZi', '2001-05-16 13:31:09', 'QTK0gYWtqr');
INSERT INTO `student` VALUES (862, 'Sit Wing Sze', 'jONeyKqTIQ', '2018-05-25 10:46:48', 'hpAnNOMeuR');
INSERT INTO `student` VALUES (863, 'Kono Airi', 'pbXvEcpNBE', '2001-08-04 14:06:29', 'Lc6quv26P4');
INSERT INTO `student` VALUES (864, 'Chiba Misaki', 'RIqkP0xY38', '2020-07-11 05:14:11', 'wvNwKUpwMM');
INSERT INTO `student` VALUES (865, 'Chang Kwok Ming', '98CDUIr2BU', '2002-07-31 06:22:07', 'mHuDJaL213');
INSERT INTO `student` VALUES (866, 'Mo Ming', 'k7tzQ25CyK', '2011-03-24 20:52:51', 'mB8XvfaOZC');
INSERT INTO `student` VALUES (867, 'Lu Xiuying', '2dPLySqbSx', '2017-07-05 10:18:50', 'SxTP6cYk5c');
INSERT INTO `student` VALUES (868, 'Koo Chiu Wai', 'liEqVIFhAn', '2017-11-30 08:30:10', '50qvXEhdYi');
INSERT INTO `student` VALUES (869, 'Sheh Wing Sze', 'gQjown4j0D', '2015-04-13 23:04:44', '2ZpV4IgqRV');
INSERT INTO `student` VALUES (870, 'Yang Rui', 'tIw90cqICI', '2021-01-03 12:44:07', 'yQgE7L2A3W');
INSERT INTO `student` VALUES (871, 'George Alexander', 'lLz4TMHCwa', '2020-02-25 02:03:19', 'e6EmYGeXlN');
INSERT INTO `student` VALUES (872, 'Iwasaki Yuna', 'CKmpWdRz5C', '2014-05-10 06:13:44', 'GvXs61f08G');
INSERT INTO `student` VALUES (873, 'Edith Sanchez', 'a9hjkeRdhg', '2018-12-13 15:01:13', '6BVzxjHTRs');
INSERT INTO `student` VALUES (874, 'Okamoto Mai', 'MoUGDFt9Ae', '2023-04-29 13:19:06', '51hePdY1v9');
INSERT INTO `student` VALUES (875, 'Tracy Wagner', 'uicIZBAmEZ', '2022-03-21 04:22:24', 'cOIvxQ2eRi');
INSERT INTO `student` VALUES (876, 'Lau Lik Sun', 'ziS5eZs0RW', '2000-04-09 18:10:08', 'TkGyOqjxp0');
INSERT INTO `student` VALUES (877, 'Yuen Ka Fai', '81PB8A0eLs', '2020-01-28 15:15:29', 'MvuLQWkTfR');
INSERT INTO `student` VALUES (878, 'Yin Jiehong', 'f3OuHXVTyR', '2010-10-17 03:57:35', 'MNFbQus1jo');
INSERT INTO `student` VALUES (879, 'Ueno Kaito', 'MI28DNpRz7', '2020-02-21 19:06:32', 'd9x7xeyhN2');
INSERT INTO `student` VALUES (880, 'Cao Rui', 'ukNmT4GrAB', '2015-12-03 21:33:25', 'jAjMypbMDp');
INSERT INTO `student` VALUES (881, 'Lo Sai Wing', '58GOVAIl0V', '2017-08-12 23:20:10', 'KiiucRqMCJ');
INSERT INTO `student` VALUES (882, 'Ono Takuya', 'anxKWhSy3S', '2014-11-11 06:02:07', 'e6sk0lfxah');
INSERT INTO `student` VALUES (883, 'Theresa Chavez', '2gMkf0X3N6', '2000-05-21 00:00:13', '7070GkIepH');
INSERT INTO `student` VALUES (884, 'Imai Rin', 'Uvz6tSnwjT', '2023-07-15 06:13:06', 'folRMtXqbt');
INSERT INTO `student` VALUES (885, 'Danielle Young', 'ISpfgrSbiw', '2017-04-29 00:59:02', 'ofHDAzicvM');
INSERT INTO `student` VALUES (886, 'Shao Zitao', 'bQBEjyCty6', '2022-08-09 06:22:49', 'usafhsizCd');
INSERT INTO `student` VALUES (887, 'Taniguchi Ren', 'uuDFZ5FaUn', '2023-03-11 13:10:24', 'j0Shi1b9Q6');
INSERT INTO `student` VALUES (888, 'Sakamoto Misaki', 'RcUORRHcWX', '2002-02-21 23:56:15', 'ttcUoAilCp');
INSERT INTO `student` VALUES (889, 'Siu Wing Sze', 'rETgMpJQPu', '2003-05-02 00:37:25', 'EGhoPRxtEU');
INSERT INTO `student` VALUES (890, 'Wanda Munoz', 'mifyXzJxcd', '2018-06-18 12:50:34', 'x2qYXKN68x');
INSERT INTO `student` VALUES (891, 'Hirano Kasumi', 't4RuHvUOoe', '2003-06-04 03:39:44', 'lnyHh64PNo');
INSERT INTO `student` VALUES (892, 'Zhang Yuning', 'Vjlfo7Et3e', '2019-06-09 09:02:08', 'aM8Wv9is0j');
INSERT INTO `student` VALUES (893, 'He Jialun', 'K31m24d7rR', '2018-12-15 20:47:03', 'bICLjPbjZR');
INSERT INTO `student` VALUES (894, 'Zou Jiehong', 'zUeZZMva5s', '2002-10-25 01:05:39', 'ZFoZy1Yyp6');
INSERT INTO `student` VALUES (895, 'Tong Hok Yau', '4nuw4s6V9J', '2021-09-20 13:53:00', 'ejGSGNgYZs');
INSERT INTO `student` VALUES (896, 'Kikuchi Rena', 'tbnE2CleA8', '2001-05-06 12:25:53', 'SxhRxZdQK7');
INSERT INTO `student` VALUES (897, 'Mok Chi Ming', 'KVOiW6TXNP', '2012-07-15 16:14:35', 'X4fn1oFW44');
INSERT INTO `student` VALUES (898, 'Pauline Ferguson', '6Zh7crCM1l', '2015-07-30 08:04:51', 'D1uQn2dgmB');
INSERT INTO `student` VALUES (899, 'Noguchi Kaito', 'WM5HNnCimD', '2021-04-28 09:27:58', 'b5K61YshhW');
INSERT INTO `student` VALUES (900, 'Lai Wai Lam', 'A4RtQlBri9', '2024-05-09 20:21:51', 'suia4IfQpT');
INSERT INTO `student` VALUES (901, 'Ueda Hana', 'nFhbOThOgj', '2019-09-18 18:55:39', 'nVKa4hGP4i');
INSERT INTO `student` VALUES (902, 'Norman Rodriguez', 'JpYHRsfLGd', '2016-05-18 12:16:01', 'MbgGjuEg4l');
INSERT INTO `student` VALUES (903, 'Koyama Takuya', 'uc8om6fhyc', '2018-07-18 15:57:42', '1GQ5wFSrhb');
INSERT INTO `student` VALUES (904, 'Zeng Rui', 'fPfQb0ndnn', '2008-05-18 14:54:18', 'zX4NUhcpu4');
INSERT INTO `student` VALUES (905, 'Lee Ting Fung', '1Lsv2DSmkh', '2015-04-27 17:48:42', 'ndfsVpW0kR');
INSERT INTO `student` VALUES (906, 'Donald Robinson', 'h3NL4T3XVi', '2020-03-03 01:21:29', 'GBZlNKmpCM');
INSERT INTO `student` VALUES (907, 'Dai Anqi', 'wh9V0KuSPZ', '2006-01-12 20:45:05', 'j2HyJhvSzR');
INSERT INTO `student` VALUES (908, 'Mao Xiuying', '0RMYTCmFaW', '2017-08-02 03:54:42', 'm3FAa5GTvs');
INSERT INTO `student` VALUES (909, 'Kimura Momoe', 'FzK8hV4BRC', '2009-01-28 03:28:30', 'LONvkeiep6');
INSERT INTO `student` VALUES (910, 'Wu Kwok Kuen', 'Co01tMWzHe', '2004-12-19 06:38:30', 'G8PkuPJ6oN');
INSERT INTO `student` VALUES (911, 'Hasegawa Hana', 'dC7jHFkbnA', '2021-04-21 15:05:55', 'kgm3P0M5tU');
INSERT INTO `student` VALUES (912, 'Luo Yuning', 'Kjuf2ngfZu', '2025-01-30 20:44:48', '9XIS8mSh00');
INSERT INTO `student` VALUES (913, 'Ma Yuning', '5C96NbvxG2', '2006-03-29 20:43:55', 'Qw9OMB9QiR');
INSERT INTO `student` VALUES (914, 'Koon Ching Wan', 'TYwPXKtpzv', '2009-07-12 02:05:15', '1qhUXcM6F3');
INSERT INTO `student` VALUES (915, 'Chu Hiu Tung', 'xhhNL6nVeU', '2016-02-07 09:41:15', 'Rlz5IdgW3e');
INSERT INTO `student` VALUES (916, 'Takeuchi Kasumi', 'L2DWOMVMBW', '2025-03-31 23:41:59', 'xefxsErm5X');
INSERT INTO `student` VALUES (917, 'Qiu Jialun', 'mmATiodIZr', '2023-03-22 17:08:58', 'ZA4OmvSUeO');
INSERT INTO `student` VALUES (918, 'Gao Zhennan', 'nmGPwPFDG4', '2016-04-16 04:37:57', 'gUA4sWgzVh');
INSERT INTO `student` VALUES (919, 'Fujiwara Airi', 'A5bNY2IijS', '2016-08-20 23:49:41', 'JA4rftR9gk');
INSERT INTO `student` VALUES (920, 'Hashimoto Hazuki', 'U2l6YRZaVD', '2000-02-14 00:44:15', 'xxJPkWPblI');
INSERT INTO `student` VALUES (921, 'Wu Lu', 'TMfKDPeYTp', '2013-01-08 02:02:57', 'yAztQBCheU');
INSERT INTO `student` VALUES (922, 'Siu Fu Shing', 'wgeCAsG2pE', '2015-07-08 05:22:43', 'ih4dAl4JDj');
INSERT INTO `student` VALUES (923, 'Ti Kwok Ming', 'JThZMFeb2v', '2024-10-02 05:30:50', 'TKfemq2r3N');
INSERT INTO `student` VALUES (924, 'Lok Sze Kwan', 'KdizOVjrfv', '2008-08-20 13:33:09', 'QOqQ75jTjB');
INSERT INTO `student` VALUES (925, 'Randall Shaw', 'Kf5diVpEiI', '2024-06-20 03:34:12', 'rJWMS6d6PT');
INSERT INTO `student` VALUES (926, 'Yoshida Rena', 'JzclQ210PE', '2006-11-14 02:08:20', 'oR6j0Mx9a8');
INSERT INTO `student` VALUES (927, 'Duan Jiehong', 'zfR74mNQPW', '2021-06-16 17:46:13', 'J7xNsSz2tS');
INSERT INTO `student` VALUES (928, 'Shing Kwok Wing', 'GHES8U1o3l', '2014-08-02 05:46:33', 'HbC4Xmomb9');
INSERT INTO `student` VALUES (929, 'Carl Nelson', 'aXGlGUQRyB', '2006-05-08 04:00:17', 'MAVqmbnv5L');
INSERT INTO `student` VALUES (930, 'Choi Chun Yu', 'xwftXeJTwA', '2023-09-21 07:02:11', 'mK56Ovd4pI');
INSERT INTO `student` VALUES (931, 'Rose Turner', 'qgvOhNerV1', '2007-12-04 02:05:43', 'HMvvBrUTOj');
INSERT INTO `student` VALUES (932, 'Martha Johnson', '6Usw19JQjM', '2011-12-10 04:30:00', '4rkhIDGKjI');
INSERT INTO `student` VALUES (933, 'Gu Zhiyuan', '1glFf4mgqI', '2005-02-11 18:27:19', 'wCivMaKLPT');
INSERT INTO `student` VALUES (934, 'Watanabe Mio', 'Z4bPZ3HLjZ', '2011-06-13 15:59:09', 'EHlxwfl60G');
INSERT INTO `student` VALUES (935, 'Carlos Clark', '2yvTfT7oU2', '2022-01-28 18:39:11', '7Z4m75xNSt');
INSERT INTO `student` VALUES (936, 'Ng Ho Yin', 'rK4dLbEGzQ', '2021-05-15 18:39:49', '9uTdqIO8Oj');
INSERT INTO `student` VALUES (937, 'Lo Hiu Tung', 'vMElw52fPx', '2013-01-31 03:25:33', 'yUBfB7W87g');
INSERT INTO `student` VALUES (938, 'Zhang Rui', 'AWMTRTQZbI', '2013-09-02 18:01:10', 'idQKLdISoB');
INSERT INTO `student` VALUES (939, 'Siu Wing Fat', '3woQ8JTf1F', '2003-12-03 09:13:17', '4aWCCu78EV');
INSERT INTO `student` VALUES (940, 'Dale Martinez', 'ArDyvUqiIO', '2022-07-04 01:39:03', 'SfMUdBAp6E');
INSERT INTO `student` VALUES (941, 'Kam Cho Yee', '76RuEtzcqv', '2007-01-29 08:45:55', 'JLa8zJNtEd');
INSERT INTO `student` VALUES (942, 'Sakamoto Miu', 'VeMtnwncsA', '2003-08-18 12:54:21', 'r1C5rcSPXK');
INSERT INTO `student` VALUES (943, 'Shirley Castro', 'KzC9yul4Df', '2000-12-02 18:09:27', 'l1TBfTytso');
INSERT INTO `student` VALUES (944, 'Yin Fu Shing', 'IAqjvrhZWP', '2009-01-19 02:56:32', '9AcQGE2BDG');
INSERT INTO `student` VALUES (945, 'Louis Fisher', 'uii64CW0Yp', '2014-10-17 15:36:35', 'mWUAhOlT6r');
INSERT INTO `student` VALUES (946, 'Murata Kenta', 'RcH1JHygYy', '2021-12-10 04:21:42', 'tGxmVXTdP2');
INSERT INTO `student` VALUES (947, 'Otsuka Aoi', 'scycIH72lz', '2006-07-07 11:11:53', 'XuORV6OUMa');
INSERT INTO `student` VALUES (948, 'Siu Hui Mei', 'y5L22YQKal', '2011-12-22 01:27:57', 'e7mBwPAix0');
INSERT INTO `student` VALUES (949, 'Liao Xiuying', 'fT6rOuVEHa', '2011-11-22 06:34:03', 'zUN6NN4DOL');
INSERT INTO `student` VALUES (950, 'So Sai Wing', 'BukhRQ3tLt', '2004-01-10 02:52:34', 'kQMrKco3s7');
INSERT INTO `student` VALUES (951, 'Yamada Sakura', 'hxqSqMmnIF', '2024-01-04 04:42:40', 'R1gk5vRaTn');
INSERT INTO `student` VALUES (952, 'Paul Olson', 'iZjfmdBJcm', '2002-06-21 01:26:27', 'qU3zqxkvaz');
INSERT INTO `student` VALUES (953, 'Ogawa Momoe', 'I0Wae1e6uh', '2005-05-19 02:28:04', '54pJkpxSjh');
INSERT INTO `student` VALUES (954, 'Iwasaki Hazuki', 'FC6HosMuUE', '2001-11-30 05:10:22', '33SJUuNln3');
INSERT INTO `student` VALUES (955, 'Han Wai Man', '2kS1BqcQJY', '2012-12-04 10:32:16', 'hww6e2BSbp');
INSERT INTO `student` VALUES (956, 'Tin Wing Fat', 'VRyJ6Yj4Tf', '2006-08-18 17:47:24', 'HBLbKnn9qq');
INSERT INTO `student` VALUES (957, 'Chen Yunxi', 'VQknBXFgjX', '2022-07-11 09:33:25', 'biqNM3dR2H');
INSERT INTO `student` VALUES (958, 'Randy Martin', 'm7BQrG5OdZ', '2013-06-27 21:06:00', '0oKd4CczU4');
INSERT INTO `student` VALUES (959, 'Cheng Ziyi', 'NwTDcSqZ9y', '2017-12-29 12:31:13', 'jo5oNp7Z8R');
INSERT INTO `student` VALUES (960, 'Kimura Nanami', '7xdqEjvjLE', '2022-02-02 19:09:47', 'FbpcLvLbS7');
INSERT INTO `student` VALUES (961, 'Tan Anqi', '3tHXwNxenG', '2019-07-14 16:30:58', 'OQhmrrQUYi');
INSERT INTO `student` VALUES (962, 'Barbara Cook', 's3E3SjU9dC', '2007-10-02 06:58:23', 'Oui0KqIq1a');
INSERT INTO `student` VALUES (963, 'Liang Shihan', 'FXN7rq39hK', '2021-04-03 01:33:22', 'gZ8MStxcYU');
INSERT INTO `student` VALUES (964, 'Jesse Torres', 'GwHVlYMbg6', '2010-12-20 13:28:20', 'nZD6GSrN5W');
INSERT INTO `student` VALUES (965, 'Chin Yun Fat', 'L3JmYMvjlc', '2020-09-07 15:03:40', '632WOvFumm');
INSERT INTO `student` VALUES (966, 'Ye Zhiyuan', 'j2JLz8zT2y', '2024-05-02 22:43:55', 'joLQXjGp2V');
INSERT INTO `student` VALUES (967, 'Sasaki Ryota', 'R2C33KMdZK', '2013-12-20 08:16:12', 'PFtsP1g9j7');
INSERT INTO `student` VALUES (968, 'Loui Lai Yan', '0KyuPukvbM', '2007-02-09 20:29:38', 'fcYO8HINNt');
INSERT INTO `student` VALUES (969, 'Arimura Kaito', 'P5AVDUyWwJ', '2023-07-02 05:58:46', '3rPoekeRLM');
INSERT INTO `student` VALUES (970, 'Steven Gomez', 'm3WY6jZnRN', '2001-03-28 12:12:39', 'zdV7gyVuq7');
INSERT INTO `student` VALUES (971, 'Ethel Lee', 'bWO12DKU5U', '2018-10-31 10:02:26', 'V3gs73Vtr3');
INSERT INTO `student` VALUES (972, 'Ng Wai Yee', 'JHCYI1zE0H', '2010-03-04 23:14:22', 'yC3oKFf9nF');
INSERT INTO `student` VALUES (973, 'Han Suk Yee', '0mQFecTEKD', '2005-08-12 13:18:14', 'mhcqFkU5pZ');
INSERT INTO `student` VALUES (974, 'Xiao Xiuying', 'Ck9pjHb1DQ', '2002-08-20 21:59:22', 'CaPTwQYuFY');
INSERT INTO `student` VALUES (975, 'Adam Bennett', 'oezhRL6SIk', '2021-01-20 06:16:57', 't333wEBQbd');
INSERT INTO `student` VALUES (976, 'Lau Ka Man', '3qMTIDpGV6', '2023-07-09 19:00:30', 'g70y7knXHy');
INSERT INTO `student` VALUES (977, 'Zhang Zitao', 'l66Ug2tC3z', '2022-09-23 11:46:11', 'xGxCb14FJp');
INSERT INTO `student` VALUES (978, 'Kudo Ayano', 'anwfAennPx', '2008-09-20 10:22:13', '5SVhglMyXC');
INSERT INTO `student` VALUES (979, 'Kaneko Hina', '3bFoC5pq3b', '2001-08-31 15:33:37', '2iLpz46CH8');
INSERT INTO `student` VALUES (980, 'Siu Sze Kwan', 'bCdzNhWLjT', '2022-06-07 21:49:53', '1hEGkZln6K');
INSERT INTO `student` VALUES (981, 'Kaneko Takuya', 'HxKriRCvod', '2007-05-22 05:07:36', 'o0Cq24vCxI');
INSERT INTO `student` VALUES (982, 'Lillian Flores', 'JYZyCxpN0N', '2017-03-10 13:10:35', 'tZ8AUMShhc');
INSERT INTO `student` VALUES (983, 'Julie Young', 'AXU6Yneq5J', '2014-06-20 07:45:56', 'tN1sHXlDBf');
INSERT INTO `student` VALUES (984, 'Anthony Cox', 'lq40eGtHov', '2015-11-13 19:57:56', 'ttsTzZNR7G');
INSERT INTO `student` VALUES (985, 'Sugawara Ikki', 'tytAdetVVp', '2024-04-26 08:16:53', 'dYseJWTRM4');
INSERT INTO `student` VALUES (986, 'Lo Chi Ming', '1nQoyEVLQt', '2010-08-03 15:33:56', 'Kc8sKD0TSr');
INSERT INTO `student` VALUES (987, 'Liao Xiuying', 'HtaKA2Q6mT', '2017-09-27 07:04:05', '6NE35U9ObP');
INSERT INTO `student` VALUES (988, 'Wu Lu', 'sp93IbRpzZ', '2007-10-26 10:05:28', 'jStv1J5kaA');
INSERT INTO `student` VALUES (989, 'Lai Hui Mei', 'sgZ0AyTFpj', '2012-01-26 05:39:16', 'HR9NHW2BL6');
INSERT INTO `student` VALUES (990, 'Sakamoto Hazuki', 'ZZFSEGC18U', '2010-01-22 22:27:55', 'fF2eB8VQIb');
INSERT INTO `student` VALUES (991, 'Robert Schmidt', '8pzMfICBdn', '2011-05-23 07:15:41', 'aYs9h62YsH');
INSERT INTO `student` VALUES (992, 'Kao Yun Fat', 'aRo6Q4YYtR', '2007-10-16 19:46:18', 'URNjB8t8LE');
INSERT INTO `student` VALUES (993, 'Kwong Wing Sze', '8P3arSa9sM', '2009-06-19 01:27:56', 'kQZkW5sIPq');
INSERT INTO `student` VALUES (994, 'Yao Ziyi', 'gNzYWqLfjV', '2003-04-23 05:35:30', 'QijB1KGhrq');
INSERT INTO `student` VALUES (995, 'Christine Scott', '5iif7P5Yvz', '2021-05-13 00:24:09', 'HKysIWo0jH');
INSERT INTO `student` VALUES (996, 'Roger Gardner', '5GOcbgAtyU', '2013-05-30 13:10:03', '58EeYXee6A');
INSERT INTO `student` VALUES (997, 'Ellen Martin', 'ptb53wrsuO', '2004-01-30 08:24:18', 'S2Vz2QFZ1b');
INSERT INTO `student` VALUES (998, 'Mori Daichi', 'Bv8OP6KSEH', '2003-07-06 02:30:44', 'K8O2g1NSR1');
INSERT INTO `student` VALUES (999, 'Miguel Gutierrez', '2yPXN8Km6e', '2020-04-23 15:36:55', 'PsFDSZdnzU');
INSERT INTO `student` VALUES (1000, 'Takeda Misaki', 'BcuarL3fS7', '2000-10-24 05:05:19', 'GEdaln6ui1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Victoria Murphy', 'uU9fk5Sjjl', 'Victoria Murphy', '90-8961-7215', 'mv10@mail.com', 'HQe3cprl38');
INSERT INTO `user` VALUES (2, 'Pang Chun Yu', 'xhiWFMd6H2', 'Pang Chun Yu', '212-157-3601', 'chunyu8@mail.com', 'BPdG0UrUMf');
INSERT INTO `user` VALUES (3, 'Sakai Kazuma', 'G1m7yhSYlH', 'Sakai Kazuma', '(151) 824 2643', 'sakai05@icloud.com', 'n4XTXcCm8x');
INSERT INTO `user` VALUES (4, 'Fred Cooper', 'Oj93QDLkHm', 'Fred Cooper', '(1223) 72 7741', 'fredcooper@outlook.com', 'ITz4ITjRwC');
INSERT INTO `user` VALUES (5, 'Goto Daisuke', '3j3bFxhtnR', 'Goto Daisuke', '(20) 7929 2360', 'daisgot7@icloud.com', 'n0BbU6c6Xo');

SET FOREIGN_KEY_CHECKS = 1;
