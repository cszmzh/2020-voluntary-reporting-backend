/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云DB
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 39.106.196.52:3306
 Source Schema         : application

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 26/06/2020 15:07:56
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
BEGIN;
INSERT INTO `hibernate_sequence` VALUES (42);
COMMIT;

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `major_id` smallint(2) NOT NULL COMMENT '专业编号',
  `major_name` varchar(8) NOT NULL COMMENT '专业名称',
  PRIMARY KEY (`major_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of major
-- ----------------------------
BEGIN;
INSERT INTO `major` VALUES (1, '计算机科学与技术');
INSERT INTO `major` VALUES (2, '信息安全');
INSERT INTO `major` VALUES (3, '物联网工程');
INSERT INTO `major` VALUES (4, '大数据');
INSERT INTO `major` VALUES (5, '中加');
COMMIT;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `org_id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT '组织编号',
  `org_name` varchar(20) NOT NULL COMMENT '组织名称',
  `branch_name` varchar(20) DEFAULT NULL COMMENT '分支组织名称',
  PRIMARY KEY (`org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization
-- ----------------------------
BEGIN;
INSERT INTO `organization` VALUES (1, '团委', '组织部');
INSERT INTO `organization` VALUES (2, '团委', '宣传部');
INSERT INTO `organization` VALUES (3, '团委', '心协');
INSERT INTO `organization` VALUES (4, '团委', '青协');
INSERT INTO `organization` VALUES (5, '学生会', '办公室');
INSERT INTO `organization` VALUES (6, '学生会', '学习部');
INSERT INTO `organization` VALUES (7, '学生会', '宣传部');
INSERT INTO `organization` VALUES (8, '学生会', '文艺部');
INSERT INTO `organization` VALUES (9, '学生会', '体育部');
INSERT INTO `organization` VALUES (10, '学生会', '外联部');
INSERT INTO `organization` VALUES (11, '学生会', '自管会');
INSERT INTO `organization` VALUES (12, '科技协会', '科技协会');
INSERT INTO `organization` VALUES (13, '勤工助学中心', '管理部');
INSERT INTO `organization` VALUES (14, '勤工助学中心', '活动部');
INSERT INTO `organization` VALUES (15, '勤工助学中心', '助贷部');
INSERT INTO `organization` VALUES (16, '勤工助学中心', '外联部');
INSERT INTO `organization` VALUES (17, '新闻中心', '摄影协会');
INSERT INTO `organization` VALUES (18, '新闻中心', '新媒体部');
INSERT INTO `organization` VALUES (19, '新闻中心', '记者团');
COMMIT;

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `report_id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT '志愿编号',
  `student_id` int(8) NOT NULL COMMENT '学生学号',
  `vol_first` smallint(2) NOT NULL COMMENT '组织编号1',
  `vol_second` smallint(2) DEFAULT NULL COMMENT '组织编号2',
  `reason_first` varchar(200) NOT NULL,
  `reason_second` varchar(200) DEFAULT NULL,
  `is_dispensing` smallint(1) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`report_id`) USING BTREE,
  UNIQUE KEY `student_id` (`student_id`) USING BTREE,
  KEY `vol_first` (`vol_first`) USING BTREE,
  KEY `vol_second` (`vol_second`) USING BTREE,
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`vol_first`) REFERENCES `organization` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`vol_second`) REFERENCES `organization` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_ibfk_3` FOREIGN KEY (`student_id`) REFERENCES `student` (`stu_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of report
-- ----------------------------
BEGIN;
INSERT INTO `report` VALUES (1, 20185589, 1, 8, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-21 16:30:03', '2020-04-12 19:00:41', NULL);
INSERT INTO `report` VALUES (2, 20195582, 3, 6, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 0, '2020-04-21 16:30:05', '2020-04-15 20:59:09', NULL);
INSERT INTO `report` VALUES (3, 20195562, 3, 5, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-23 15:06:08', '2020-04-16 18:29:57', '非常好');
INSERT INTO `report` VALUES (4, 20195547, 6, 3, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 0, '2020-04-23 15:06:14', '2020-04-16 20:12:01', '这个同学面试很优秀');
INSERT INTO `report` VALUES (5, 20195510, 7, 2, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 0, '2020-04-21 16:30:07', '2020-04-16 20:16:35', NULL);
INSERT INTO `report` VALUES (6, 20190001, 8, 1, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学a!!', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-21 16:30:08', '2020-04-17 20:04:44', '这个学生很好');
INSERT INTO `report` VALUES (7, 20190003, 3, 4, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-06-02 20:07:39', '2020-04-17 20:22:33', '我觉得这个学生不错');
INSERT INTO `report` VALUES (8, 20190005, 6, 3, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-06-02 20:33:10', '2020-04-17 20:24:02', '');
INSERT INTO `report` VALUES (9, 20190007, 8, 9, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-21 16:30:10', '2020-04-17 20:24:57', NULL);
INSERT INTO `report` VALUES (10, 20190008, 11, 13, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 0, '2020-04-21 16:30:12', '2020-04-17 20:25:11', NULL);
INSERT INTO `report` VALUES (11, 20190009, 12, 17, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-23 15:06:17', '2020-04-17 20:25:27', '不错的同学');
INSERT INTO `report` VALUES (12, 20190010, 14, 1, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-05-03 16:27:41', '2020-04-17 20:25:48', '');
INSERT INTO `report` VALUES (13, 20190011, 9, 18, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-05-02 10:10:04', '2020-04-17 20:26:17', '');
INSERT INTO `report` VALUES (14, 20190012, 18, 10, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-21 16:30:16', '2020-04-17 20:26:40', '');
INSERT INTO `report` VALUES (15, 20195516, 16, NULL, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', NULL, 1, '2020-05-03 17:00:50', '2020-04-21 14:56:56', '哈哈哈');
INSERT INTO `report` VALUES (16, 20195517, 12, 3, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-23 15:07:36', '2020-04-21 15:48:09', NULL);
INSERT INTO `report` VALUES (17, 20195566, 12, 4, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 0, '2020-04-23 15:07:37', '2020-04-21 16:35:15', '很好');
INSERT INTO `report` VALUES (18, 20196000, 18, NULL, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', NULL, 1, '2020-04-23 15:07:40', '2020-04-23 15:04:30', '印象深刻');
INSERT INTO `report` VALUES (19, 20196001, 9, 12, '很想加入', '很想加入', 0, '2020-04-23 15:09:37', '2020-04-23 15:09:37', NULL);
INSERT INTO `report` VALUES (20, 20196002, 15, 15, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-23 15:16:31', '2020-04-23 15:16:05', '好');
INSERT INTO `report` VALUES (21, 20196003, 8, 2, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学', 1, '2020-05-20 18:41:25', '2020-04-23 15:17:17', '');
INSERT INTO `report` VALUES (22, 20196004, 18, 16, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', 1, '2020-04-23 15:17:37', '2020-04-23 15:17:37', NULL);
INSERT INTO `report` VALUES (23, 20196005, 13, NULL, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\r\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', NULL, 0, '2020-04-23 15:18:01', '2020-04-23 15:18:01', NULL);
INSERT INTO `report` VALUES (24, 20196006, 16, NULL, '您好，我是来自某某系某专业的谁，我希望自己能够有机zd会加入到校学生会，为部门做出一点贡献，为学院同学的大学生活增一份精彩，也为自己的大学生活镌刻一份独特的难忘记忆。\n学生会是我们参版与自我管理的方式，是我们在大学生活中学会承担的一堂课，这里不仅是一个组织，更是把所有学院同学凝聚一起的港湾。在这里我们将想法付诸实践，让更多的心声得到倾听，把更多的欢乐传递给每一个同学。', NULL, 0, '2020-04-23 15:21:39', '2020-04-23 15:21:39', '');
INSERT INTO `report` VALUES (26, 20196677, 12, NULL, '特别想加入啊', NULL, 0, '2020-05-01 18:08:38', '2020-04-23 21:23:34', '');
INSERT INTO `report` VALUES (28, 20191123, 1, 1, '发财树', '大是大非', 1, '2020-05-25 16:34:22', '2020-05-07 20:39:24', '没资格');
INSERT INTO `report` VALUES (29, 20200001, 12, NULL, '123', NULL, 1, '2020-05-15 16:26:44', '2020-05-07 20:46:56', '');
INSERT INTO `report` VALUES (30, 20190002, 12, NULL, '123', NULL, 1, '2020-05-07 20:47:53', '2020-05-07 20:47:53', NULL);
INSERT INTO `report` VALUES (31, 20190059, 12, NULL, '123', NULL, 0, '2020-05-27 11:31:03', '2020-05-07 21:21:28', '');
INSERT INTO `report` VALUES (32, 20190123, 13, 15, '想', '很想', 1, '2020-05-27 11:25:07', '2020-05-27 11:25:07', NULL);
INSERT INTO `report` VALUES (34, 20191231, 3, NULL, '是', NULL, 0, '2020-06-02 20:35:36', '2020-06-02 20:35:36', NULL);
INSERT INTO `report` VALUES (35, 20195254, 5, NULL, '123456', NULL, 1, '2020-06-06 17:33:49', '2020-06-06 17:33:49', NULL);
INSERT INTO `report` VALUES (36, 20198888, 1, 8, '是的', '刚刚', 1, '2020-06-11 10:57:01', '2020-06-11 10:57:01', NULL);
INSERT INTO `report` VALUES (41, 20192222, 5, NULL, '111', NULL, 1, '2020-06-21 18:32:27', '2020-06-21 18:32:27', NULL);
COMMIT;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_id` int(8) NOT NULL COMMENT '学生学号',
  `stu_name` varchar(8) NOT NULL COMMENT '学生姓名',
  `stu_major` smallint(2) NOT NULL COMMENT '学生所属专业 用1位整形数字表示',
  `stu_class` smallint(2) NOT NULL COMMENT '学生班级 用1位整形数字表示',
  `stu_phone` varchar(11) NOT NULL COMMENT '联系方式',
  `stu_qq` varchar(11) DEFAULT NULL,
  `stu_status` varchar(10) DEFAULT '未被录取',
  `org_id` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`stu_id`) USING BTREE,
  KEY `stu_major` (`stu_major`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`stu_major`) REFERENCES `major` (`major_id`) ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
BEGIN;
INSERT INTO `student` VALUES (20185589, '张思', 5, 2, '13615000254', '29985986', '未被录取', NULL);
INSERT INTO `student` VALUES (20190001, '张嘉懿', 1, 1, '13852002315', '615489565', '一志愿录取', 8);
INSERT INTO `student` VALUES (20190002, 'xhh', 1, 1, '13980000000', '1200000000', '一志愿录取', 12);
INSERT INTO `student` VALUES (20190003, '吴春芳', 5, 1, '18930560223', '354892113', '未被录取', NULL);
INSERT INTO `student` VALUES (20190005, '刘晓芒', 3, 2, '13564856021', '874445621', '未被录取', NULL);
INSERT INTO `student` VALUES (20190007, '东方舞', 2, 1, '15633021548', '463008214', '未被录取', NULL);
INSERT INTO `student` VALUES (20190008, '叶洪成', 3, 4, '13488502146', '664802214', '未被录取', NULL);
INSERT INTO `student` VALUES (20190009, '吴娟', 3, 2, '18819452236', '1320054687', '未被录取', NULL);
INSERT INTO `student` VALUES (20190010, '王缓缓', 4, 3, '15323196020', '1357981420', '未被录取', NULL);
INSERT INTO `student` VALUES (20190011, '杨宏文', 4, 2, '15102589655', '564981120', '二志愿录取', 18);
INSERT INTO `student` VALUES (20190012, '董文芳', 2, 1, '13849512003', '654897782', '一志愿录取', 18);
INSERT INTO `student` VALUES (20190059, 'xhh', 1, 3, '13980000000', '1200000000', '未被录取', NULL);
INSERT INTO `student` VALUES (20190123, '啊强', 4, 4, '13244477788', '123456', '未被录取', NULL);
INSERT INTO `student` VALUES (20191123, '苏文强', 1, 1, '19124339303', '1120110098', '未被录取', NULL);
INSERT INTO `student` VALUES (20191231, '刘天帆', 1, 1, '13800138000', '79234234', '未被录取', NULL);
INSERT INTO `student` VALUES (20192222, '111', 1, 1, '15817718191', '11111111111', '一志愿录取', 5);
INSERT INTO `student` VALUES (20195254, 'xhh', 1, 1, '13980000000', '1200000000', '一志愿录取', 5);
INSERT INTO `student` VALUES (20195510, '林浩', 3, 1, '18955123045', '201955423', '未被录取', NULL);
INSERT INTO `student` VALUES (20195516, '史蒂夫', 1, 1, '13564852013', '651987561', '未被录取', NULL);
INSERT INTO `student` VALUES (20195517, '赵贺', 2, 4, '15030940632', '342693958', '二志愿录取', 3);
INSERT INTO `student` VALUES (20195547, '程咬金', 4, 4, '13546620135', '123456789', '二志愿录取', 3);
INSERT INTO `student` VALUES (20195562, '林进', 2, 3, '13689745000', '562000315', '一志愿录取', 3);
INSERT INTO `student` VALUES (20195566, '满天星', 4, 1, '13487950233', '796331025', '一志愿录取', 12);
INSERT INTO `student` VALUES (20195582, '王五', 5, 4, '13800138000', '100005620', '未被录取', NULL);
INSERT INTO `student` VALUES (20196000, '赵家村', 1, 4, '15653320124', '45628596', '一志愿录取', 18);
INSERT INTO `student` VALUES (20196001, '陈迎泽', 1, 1, '13798502146', '13485201332', '二志愿录取', 12);
INSERT INTO `student` VALUES (20196002, '蔡壮保', 4, 2, '13894756482', '864312980', '一志愿录取', 15);
INSERT INTO `student` VALUES (20196003, '魏皑虎', 5, 3, '18752014630', '798221354', '一志愿录取', 8);
INSERT INTO `student` VALUES (20196004, '周卓浩', 3, 2, '13754985263', '1348520163', '二志愿录取', 16);
INSERT INTO `student` VALUES (20196005, '罗天正', 4, 1, '15369874520', '1125483321', '未被录取', NULL);
INSERT INTO `student` VALUES (20196006, '肖海英', 1, 1, '15323196020', '13485201332', '未被录取', NULL);
INSERT INTO `student` VALUES (20196677, '刘芳', 5, 2, '13894756481', '1234568520', '未被录取', NULL);
INSERT INTO `student` VALUES (20198888, '谢谢', 1, 1, '13255566665', '8885454665', '二志愿录取', 8);
INSERT INTO `student` VALUES (20200001, 'xhh', 1, 1, '13980000000', '1200000000', '未被录取', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(12) NOT NULL COMMENT '用户名',
  `user_password` varchar(15) NOT NULL COMMENT '密码',
  `org_id` smallint(2) NOT NULL,
  `user_status` smallint(1) NOT NULL COMMENT '用户权限 1为管理员 2为超级管理员',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `user_name` (`user_name`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'xueshenghui', 'xueshenghui', 5, 1, '2020-04-21 17:07:31');
INSERT INTO `user` VALUES (2, 'tuanwei', 'tuanwei', 1, 1, '2020-04-21 17:07:14');
INSERT INTO `user` VALUES (3, 'superadmin', 'lxr5201314', 1, 2, '2020-04-21 17:06:41');
INSERT INTO `user` VALUES (4, 'kexie', 'kexie', 12, 1, '2020-04-21 17:07:52');
INSERT INTO `user` VALUES (5, 'zhuxue', 'zhuxue', 13, 1, '2020-04-21 17:08:06');
INSERT INTO `user` VALUES (6, 'xinwen', 'xinwen', 17, 1, '2020-04-21 17:08:23');
COMMIT;

-- ----------------------------
-- View structure for data_view
-- ----------------------------
DROP VIEW IF EXISTS `data_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `data_view` AS select count(0) AS `total_report`,sum((`a`.`org_first` = '团委')) AS `tuanwei_first`,sum((`a`.`org_second` = '团委')) AS `tuanwei_second`,sum((`a`.`org_first` = '学生会')) AS `xueshenghui_first`,sum((`a`.`org_second` = '学生会')) AS `xueshenghui_second`,sum((`a`.`org_first` = '科技协会')) AS `kexie_first`,sum((`a`.`org_second` = '科技协会')) AS `kexie_second`,sum((`a`.`org_first` = '勤工助学中心')) AS `zhuxue_first`,sum((`a`.`org_second` = '勤工助学中心')) AS `zhuxue_second`,sum((`a`.`org_first` = '新闻中心')) AS `xinwen_first`,sum((`a`.`org_second` = '勤工助学中心')) AS `xinwen_second` from `report_view` `a`;

-- ----------------------------
-- View structure for report_view
-- ----------------------------
DROP VIEW IF EXISTS `report_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `report_view` AS select `a`.`stu_id` AS `stu_id`,`a`.`stu_name` AS `stu_name`,`b`.`major_name` AS `major_name`,`a`.`stu_class` AS `stu_class`,`a`.`stu_phone` AS `stu_phone`,`a`.`stu_qq` AS `stu_qq`,`d`.`org_name` AS `org_first`,`d`.`branch_name` AS `bra_first`,`e`.`org_name` AS `org_second`,`e`.`branch_name` AS `bra_second`,`c`.`reason_first` AS `reason_first`,`c`.`reason_second` AS `reason_second`,`c`.`is_dispensing` AS `is_dispensing`,`a`.`stu_status` AS `stu_status`,`c`.`update_time` AS `update_time`,`c`.`create_time` AS `create_time`,`c`.`remark` AS `remark` from ((((`student` `a` left join `major` `b` on((`a`.`stu_major` = `b`.`major_id`))) left join `report` `c` on((`a`.`stu_id` = `c`.`student_id`))) left join `organization` `d` on((`c`.`vol_first` = `d`.`org_id`))) left join `organization` `e` on((`c`.`vol_second` = `e`.`org_id`)));

SET FOREIGN_KEY_CHECKS = 1;
