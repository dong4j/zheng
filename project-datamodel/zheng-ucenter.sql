/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/4/26 23:13:39                           */
/*==============================================================*/


/*==============================================================*/
/* Table: ucenter_oauth                                         */
/*==============================================================*/
CREATE TABLE ucenter_oauth
(
  oauth_id INT UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  name     VARCHAR(20) COMMENT '认证方式名称',
  PRIMARY KEY (oauth_id)
);

ALTER TABLE ucenter_oauth
  COMMENT '认证方式表';

/*==============================================================*/
/* Table: ucenter_user                                          */
/*==============================================================*/
CREATE TABLE ucenter_user
(
  user_id         INT UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  password        VARCHAR(32) COMMENT '密码(MD5(密码+盐))',
  salt            VARCHAR(32) COMMENT '盐',
  nickname        VARCHAR(20) COMMENT '昵称',
  sex             TINYINT(4)            DEFAULT 0
  COMMENT '性别(0:未知,1:男,2:女)',
  avatar          VARCHAR(100) COMMENT '头像',
  create_time     TIMESTAMP             DEFAULT CURRENT_TIMESTAMP
  COMMENT '注册时间',
  create_ip       VARCHAR(50) COMMENT '注册IP地址',
  last_login_time TIMESTAMP COMMENT '最后登录时间',
  last_login_ip   VARCHAR(50) COMMENT '最后登录IP地址',
  PRIMARY KEY (user_id)
);

ALTER TABLE ucenter_user
  COMMENT '用户表';

/*==============================================================*/
/* Table: ucenter_user_details                                  */
/*==============================================================*/
CREATE TABLE ucenter_user_details
(
  user_id   INT UNSIGNED NOT NULL
  COMMENT '编号',
  signature VARCHAR(300) COMMENT '个性签名',
  real_name VARCHAR(20) COMMENT '真实姓名',
  birthday  TIMESTAMP COMMENT '出生日期',
  question  VARCHAR(100) COMMENT '帐号安全问题',
  answer    VARCHAR(100) COMMENT '帐号安全答案',
  PRIMARY KEY (user_id)
);

ALTER TABLE ucenter_user_details
  COMMENT '用户详情表';

/*==============================================================*/
/* Table: ucenter_user_log                                      */
/*==============================================================*/
CREATE TABLE ucenter_user_log
(
  user_log_id INT UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  user_id     INT UNSIGNED COMMENT '用户编号',
  content     VARBINARY(100) COMMENT '内容',
  ip          VARCHAR(20) COMMENT '操作IP地址',
  agent       VARBINARY(200) COMMENT '操作环境',
  create_time TIMESTAMP             DEFAULT CURRENT_TIMESTAMP
  COMMENT '操作时间',
  PRIMARY KEY (user_log_id)
);

ALTER TABLE ucenter_user_log
  COMMENT '用户操作日志表';

/*==============================================================*/
/* Table: ucenter_user_oauth                                    */
/*==============================================================*/
CREATE TABLE ucenter_user_oauth
(
  user_oauth_id INT UNSIGNED  NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  user_id       INT UNSIGNED  NOT NULL
  COMMENT '帐号编号',
  oauth_id      INT UNSIGNED  NOT NULL
  COMMENT '认证方式编号',
  open_id       VARBINARY(50) NOT NULL
  COMMENT '第三方ID',
  status        TINYINT(4) UNSIGNED COMMENT '绑定状态(0:解绑,1:绑定)',
  create_time   TIMESTAMP              DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  PRIMARY KEY (user_oauth_id)
);

ALTER TABLE ucenter_user_oauth
  COMMENT '用户认证方式表';

ALTER TABLE ucenter_user_details
  ADD CONSTRAINT FK_Reference_41 FOREIGN KEY (user_id)
REFERENCES ucenter_user (user_id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE ucenter_user_log
  ADD CONSTRAINT FK_Reference_44 FOREIGN KEY (user_id)
REFERENCES ucenter_user (user_id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE ucenter_user_oauth
  ADD CONSTRAINT FK_Reference_42 FOREIGN KEY (user_id)
REFERENCES ucenter_user (user_id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE ucenter_user_oauth
  ADD CONSTRAINT FK_Reference_43 FOREIGN KEY (oauth_id)
REFERENCES ucenter_oauth (oauth_id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

