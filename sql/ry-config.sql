/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.8.128
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : 192.168.8.128:13306
 Source Schema         : ry-config

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 06/05/2022 21:14:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', '# spring:\n#   main:\n#     allow-circular-references: true\n#     allow-bean-definition-overriding: true\n#   autoconfigure:\n#     exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n#   # mvc:\n#   #   pathmatch:\n#   #     matching-strategy: ant_path_matcher\n#   cloud:\n#     sentinel:\n#       filter:\n#         # sentinel 在 springboot 2.6.x 不兼容问题的处理\n#         enabled: false\n\n# # feign 配置\n# feign:\n#   sentinel:\n#     enabled: true\n#   okhttp:\n#     enabled: true\n#   httpclient:\n#     enabled: false\n#   client:\n#     config:\n#       default:\n#         connectTimeout: 10000\n#         readTimeout: 10000\n#   compression:\n#     request:\n#       enabled: true\n#     response:\n#       enabled: true\n\n# # 暴露监控端点\n# management:\n#   endpoints:\n#     web:\n#       exposure:\n#         include: \'*\'\n\n\n\n# 自定义jwt key\njwt:\n tokenHeader: Authorization #JWT存储的请求头\n secret: mySecret #JWT加解密使用的密钥\n expiration:  604800 #JWT的超期限时间(60*60*24)\n tokenHead: Bearer  #JWT负载中拿到开头', '619a0d02a353d0f9372bb6bee80901ec', '2020-05-20 12:00:00', '2022-04-19 14:18:29', 'nacos', '192.168.8.1', '', '', '通用配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (2, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: ruoyi-auth\n          uri: lb://ruoyi-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: ruoyi-gen\n          uri: lb://ruoyi-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: ruoyi-job\n          uri: lb://ruoyi-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: ruoyi-system\n          uri: lb://ruoyi-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: ruoyi-file\n          uri: lb://ruoyi-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n        # test\n        - id: ruoyi-test\n          uri: lb://ruoyi-test\n          predicates:\n            - Path=/test/**\n          \n          \n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n      - /test/**\n', '18ec1170044c3892037a61e8eeff3480', '2020-05-14 14:17:55', '2022-03-22 09:24:01', 'nacos', '192.168.8.1', '', '', '网关模块', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (3, 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', 'spring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n', '1c2f249c29a5141bbca14867e62eca69', '2020-11-20 00:00:00', '2022-03-22 07:04:11', 'nacos', '192.168.8.1', '', '', '认证中心', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (4, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '# spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: ruoyi\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 若依服务状态监控\r\n', 'd8997d0707a2fd5d9fc4e8409da38129', '2020-11-20 00:00:00', '2020-12-21 16:28:07', NULL, '0:0:0:0:0:0:0:1', '', '', '监控中心', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (5, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://192.168.8.128:13306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 123456\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 127.0.0.1:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By ruoyi\n  licenseUrl: https://ruoyi.vip', 'a2e644aad6f812c79fa3e4cb776305de', '2020-11-20 00:00:00', '2022-04-17 08:36:56', 'nacos', '192.168.8.1', '', '', '系统模块', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (6, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '# spring配置\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource: \r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: ruoyi\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.ruoyi.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n', '8c79f64a4cca9b821a03dc8b27a2d8eb', '2020-11-20 00:00:00', '2021-01-26 10:36:45', NULL, '0:0:0:0:0:0:0:1', '', '', '代码生成', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (7, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '# spring配置\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n', 'd6dfade9a2c93c463ae857cd503cb172', '2020-11-20 00:00:00', '2021-01-26 10:36:04', NULL, '0:0:0:0:0:0:0:1', '', '', '定时任务', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (8, 'ruoyi-file-dev.yml', 'DEFAULT_GROUP', '# 本地文件上传    \r\nfile:\r\n    domain: http://127.0.0.1:9300\r\n    path: D:/ruoyi/uploadPath\r\n    prefix: /statics\r\n\r\n# FastDFS配置\r\nfdfs:\r\n  domain: http://8.129.231.12\r\n  soTimeout: 3000\r\n  connectTimeout: 2000\r\n  trackerList: 8.129.231.12:22122\r\n\r\n# Minio配置\r\nminio:\r\n  url: http://8.129.231.12:9000\r\n  accessKey: minioadmin\r\n  secretKey: minioadmin\r\n  bucketName: test', '5382b93f3d8059d6068c0501fdd41195', '2020-11-20 00:00:00', '2020-12-21 21:01:59', NULL, '0:0:0:0:0:0:0:1', '', '', '文件服务', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (9, 'sentinel-ruoyi-gateway', 'DEFAULT_GROUP', '[\r\n    {\r\n        \"resource\": \"ruoyi-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '9f3a3069261598f74220bc47958ec252', '2020-11-20 00:00:00', '2020-11-20 00:00:00', NULL, '0:0:0:0:0:0:0:1', '', '', '限流策略', 'null', 'null', 'json', 'null');
INSERT INTO `config_info` VALUES (10, 'ruoyi-test-dev.yml', 'DEFAULT_GROUP', 'spring:\n  data:\n    mongodb:\n      # name 用户名 pass 密码 如果配置多个地址 ip之间用\',\'隔开\n      # uri: mongodb://name:pass@192.168.8.128:27017/test\n      # 这是没有账号密码的 \n      uri: mongodb://192.168.8.128:27017/test', 'e15741e3a2e2cdc40dd5a8d6b355334a', '2022-03-22 02:51:42', '2022-03-22 08:20:29', 'nacos', '192.168.8.1', '', '', '代码生成', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (11, 'mall-system-dev.yml', 'DEFAULT_GROUP', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis-plus:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n mapperLocations: classpath:mapper/**/*.xml\n global-config:\n  db-config:\n    # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n   logic-delete-field: delFlag \n   logic-delete-value: \'1\' # 逻辑已删除值(默认为 1)\n   logic-not-delete-value: \'0\' # 逻辑未删除值(默认为 0)\n configuration:\n  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n\n# 自定义jwt key\njwt:\n tokenHeader: Authorization #JWT存储的请求头\n secret: mySecret #JWT加解密使用的密钥\n expiration:  604800 #JWT的超期限时间(60*60*24)\n tokenHead: Bearer  #JWT负载中拿到开头\n', '34935924c54a3a1ebb27d6e586a8f660', '2022-04-16 11:04:16', '2022-04-18 14:56:07', 'nacos', '192.168.8.1', '', '', '系统模块', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (12, 'mall-auth-dev.yml', 'DEFAULT_GROUP', '#', '01abfc750a0c942167651c40d088531d', '2022-04-18 14:48:11', '2022-04-18 14:48:55', 'nacos', '192.168.8.1', '', '', '系统模块', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (13, 'mall-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # test\n        - id: mall-system\n          uri: lb://mall-system\n          predicates:\n            - Path=/mall/system/**\n        - id: mall-auth\n          uri: lb://mall-auth\n          predicates:\n            - Path=/mall/auth/**\n          \n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /mall/auth/login\n', '0d6505a02ed290719772fcdab80d2a41', '2022-04-19 14:01:29', '2022-04-19 14:55:09', 'nacos', '192.168.8.1', '', '', '网关模块', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 13, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://192.168.8.128:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 123456\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 127.0.0.1:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By ruoyi\n  licenseUrl: https://ruoyi.vip', '36f83002570d821fa3348b27e66b057d', '2022-04-16 11:04:15', '2022-04-16 11:04:16', NULL, '192.168.8.1', 'I', '');
INSERT INTO `his_config_info` VALUES (11, 14, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://192.168.8.128:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 123456\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 127.0.0.1:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By ruoyi\n  licenseUrl: https://ruoyi.vip', '36f83002570d821fa3348b27e66b057d', '2022-04-16 11:05:45', '2022-04-16 11:05:45', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 15, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 123456\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 192.168.8.128:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n', '37cde9fd45d420454c5391f0f95e8e38', '2022-04-16 11:25:58', '2022-04-16 11:25:58', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 16, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n\n        \n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 192.168.8.128:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n', '5b13b1c3c5b5866a157f9a8011b52e51', '2022-04-16 11:27:19', '2022-04-16 11:27:20', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 17, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n', 'c9063e779d8b50d6afc274ca6f1ff897', '2022-04-16 11:35:26', '2022-04-16 11:35:27', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 18, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n', 'c9063e779d8b50d6afc274ca6f1ff897', '2022-04-16 12:07:44', '2022-04-16 12:07:45', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 19, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis-plus:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n mapperLocations: classpath:mapper/**/*.xml\n global-config:\n  db-config:\n    # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n   logic-delete-field: delFlag \n   logic-delete-value: \'1\' # 逻辑已删除值(默认为 1)\n   logic-not-delete-value: \'0\' # 逻辑未删除值(默认为 0)\n', '1286c0085f33045805db908cb2b52f42', '2022-04-16 15:11:04', '2022-04-16 15:11:05', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 20, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring: \n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://192.168.8.128:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 123456\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n      # seata: true    # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      ruoyi-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: 127.0.0.1:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: 192.168.8.128:8848\n      namespace:\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By ruoyi\n  licenseUrl: https://ruoyi.vip', '36f83002570d821fa3348b27e66b057d', '2022-04-17 08:36:55', '2022-04-17 08:36:56', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 21, 'mall-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis-plus:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n mapperLocations: classpath:mapper/**/*.xml\n global-config:\n  db-config:\n    # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n   logic-delete-field: delFlag \n   logic-delete-value: \'1\' # 逻辑已删除值(默认为 1)\n   logic-not-delete-value: \'0\' # 逻辑未删除值(默认为 0)\n configuration:\n  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl', 'ae0d21637cd62a212725060ee10a2426', '2022-04-18 14:48:11', '2022-04-18 14:48:11', NULL, '192.168.8.1', 'I', '');
INSERT INTO `his_config_info` VALUES (12, 22, 'mall-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis-plus:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n mapperLocations: classpath:mapper/**/*.xml\n global-config:\n  db-config:\n    # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n   logic-delete-field: delFlag \n   logic-delete-value: \'1\' # 逻辑已删除值(默认为 1)\n   logic-not-delete-value: \'0\' # 逻辑未删除值(默认为 0)\n configuration:\n  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl', 'ae0d21637cd62a212725060ee10a2426', '2022-04-18 14:48:54', '2022-04-18 14:48:55', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 23, 'mall-system-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n datasource:\n  url: jdbc:mysql://192.168.8.128:13306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8\n  username: root\n  password: 123456\n  driver-class-name: com.mysql.cj.jdbc.Driver\n  hikari:\n   # minimum-idle最小空闲数\n   minimum-idle: 5\n   # maximum-pool-size链接池最大数量\n   maximum-pool-size: 15\n   # max-lifetime最大时长，配置为0则是永久不过期\n   max-lifetime: 0\n\n\n\n\n# mybatis配置\nmybatis-plus:\n    # 搜索指定包别名\n    # typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n mapperLocations: classpath:mapper/**/*.xml\n global-config:\n  db-config:\n    # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n   logic-delete-field: delFlag \n   logic-delete-value: \'1\' # 逻辑已删除值(默认为 1)\n   logic-not-delete-value: \'0\' # 逻辑未删除值(默认为 0)\n configuration:\n  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl', 'ae0d21637cd62a212725060ee10a2426', '2022-04-18 14:56:06', '2022-04-18 14:56:07', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 24, 'application-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  main:\n    allow-circular-references: true\n    allow-bean-definition-overriding: true\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n  cloud:\n    sentinel:\n      filter:\n        # sentinel 在 springboot 2.6.x 不兼容问题的处理\n        enabled: false\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n', 'e6a8dafc6fcec97f777836bea3ed5028', '2022-04-18 15:02:01', '2022-04-18 15:02:01', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 25, 'application-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  main:\n    allow-circular-references: true\n    allow-bean-definition-overriding: true\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n  cloud:\n    sentinel:\n      filter:\n        # sentinel 在 springboot 2.6.x 不兼容问题的处理\n        enabled: false\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\n\n# 自定义jwt key\njwt:\n tokenHeader: Authorization #JWT存储的请求头\n secret: mySecret #JWT加解密使用的密钥\n expiration:  604800 #JWT的超期限时间(60*60*24)\n tokenHead: Bearer  #JWT负载中拿到开头', '7bd5dea484b8fc0a336fc27fe566e2bf', '2022-04-18 15:35:32', '2022-04-18 15:35:33', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 26, 'mall-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: ruoyi-auth\n          uri: lb://ruoyi-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: ruoyi-gen\n          uri: lb://ruoyi-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: ruoyi-job\n          uri: lb://ruoyi-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: ruoyi-system\n          uri: lb://ruoyi-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: ruoyi-file\n          uri: lb://ruoyi-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n        # test\n        - id: ruoyi-test\n          uri: lb://ruoyi-test\n          predicates:\n            - Path=/test/**\n          \n          \n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n      - /test/**\n', '18ec1170044c3892037a61e8eeff3480', '2022-04-19 14:01:29', '2022-04-19 14:01:29', NULL, '192.168.8.1', 'I', '');
INSERT INTO `his_config_info` VALUES (13, 27, 'mall-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: 192.168.8.128\n    port: 6379\n    password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: ruoyi-auth\n          uri: lb://ruoyi-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: ruoyi-gen\n          uri: lb://ruoyi-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: ruoyi-job\n          uri: lb://ruoyi-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: ruoyi-system\n          uri: lb://ruoyi-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: ruoyi-file\n          uri: lb://ruoyi-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n        # test\n        - id: ruoyi-test\n          uri: lb://ruoyi-test\n          predicates:\n            - Path=/test/**\n          \n          \n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n      - /test/**\n', '18ec1170044c3892037a61e8eeff3480', '2022-04-19 14:06:35', '2022-04-19 14:06:36', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 28, 'application-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  main:\n    allow-circular-references: true\n    allow-bean-definition-overriding: true\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  # mvc:\n  #   pathmatch:\n  #     matching-strategy: ant_path_matcher\n  cloud:\n    sentinel:\n      filter:\n        # sentinel 在 springboot 2.6.x 不兼容问题的处理\n        enabled: false\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\n\n# 自定义jwt key\njwt:\n tokenHeader: Authorization #JWT存储的请求头\n secret: mySecret #JWT加解密使用的密钥\n expiration:  604800 #JWT的超期限时间(60*60*24)\n tokenHead: Bearer  #JWT负载中拿到开头', '95131781386a3e9024a95d96b627df90', '2022-04-19 14:18:29', '2022-04-19 14:18:29', 'nacos', '192.168.8.1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 29, 'mall-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # test\n        - id: mall-system\n          uri: lb://mall-system\n          predicates:\n            - Path=/mall/system/**\n          \n          \n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /mall/auth/login\n', 'db688e55df178ed432322c525885844a', '2022-04-19 14:55:09', '2022-04-19 14:55:09', 'nacos', '192.168.8.1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
