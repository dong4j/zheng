/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/4/5 22:18:07                            */
/*==============================================================*/


DROP TABLE IF EXISTS tmp_cms_article;

RENAME TABLE
    cms_article TO tmp_cms_article;

DROP TABLE IF EXISTS cms_book;

DROP TABLE IF EXISTS tmp_cms_category;

RENAME TABLE
    cms_category TO tmp_cms_category;

DROP TABLE IF EXISTS tmp_cms_comment;

RENAME TABLE
    cms_comment TO tmp_cms_comment;

DROP TABLE IF EXISTS tmp_cms_tag;

RENAME TABLE
    cms_tag TO tmp_cms_tag;

DROP TABLE IF EXISTS cms_user;

/*==============================================================*/
/* Table: cms_article                                           */
/*==============================================================*/
CREATE TABLE cms_article
(
  article_id    INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '文章编号',
  topic_id      INT COMMENT '所属专题',
  title         VARCHAR(200)        NOT NULL
  COMMENT '文章标题',
  author        VARCHAR(50)                  DEFAULT NULL
  COMMENT '文章原作者',
  fromurl       VARCHAR(300)                 DEFAULT NULL
  COMMENT '转载来源网址',
  image         VARCHAR(300)                 DEFAULT NULL
  COMMENT '封面图',
  keywords      VARCHAR(100)                 DEFAULT NULL
  COMMENT '关键字',
  description   VARCHAR(500)                 DEFAULT NULL
  COMMENT '简介',
  type          TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '类型(1:普通,2:热门...)',
  allowcomments TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '是否允许评论(0:不允许,1:允许)',
  status        TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '状态(-1:不通过,0未审核,1:通过)',
  content       MEDIUMTEXT COMMENT '内容',
  user_id       INT(10) UNSIGNED    NOT NULL
  COMMENT '发布人id',
  readnumber    INT(10) UNSIGNED    NOT NULL DEFAULT 0
  COMMENT '阅读数量',
  top           INT                 NOT NULL DEFAULT 0
  COMMENT '置顶等级',
  system_id     INT COMMENT '所属系统',
  ctime         BIGINT(20) UNSIGNED NOT NULL
  COMMENT '创建时间',
  orders        BIGINT(20) UNSIGNED NOT NULL
  COMMENT '排序',
  PRIMARY KEY (article_id),
  KEY cms_article_orders (orders)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COMMENT ='文章表';

ALTER TABLE cms_article
  COMMENT '文章表';

INSERT INTO cms_article (article_id, topic_id, title, author, fromurl, image, keywords, description, type, allowcomments, status, content, user_id, readnumber, ctime, orders)
  SELECT
    article_id,
    topic_id,
    title,
    author,
    fromurl,
    image,
    keywords,
    description,
    type,
    allowcomments,
    status,
    content,
    user_id,
    readnumber,
    ctime,
    orders
  FROM tmp_cms_article;

/*==============================================================*/
/* Table: cms_category                                          */
/*==============================================================*/
CREATE TABLE cms_category
(
  category_id INT(10) UNSIGNED     NOT NULL AUTO_INCREMENT
  COMMENT '类目编号',
  pid         INT(10) UNSIGNED COMMENT '上级编号',
  level       TINYINT(4)           NOT NULL
  COMMENT '层级',
  name        VARCHAR(20)          NOT NULL
  COMMENT '名称',
  description VARCHAR(200)                  DEFAULT NULL
  COMMENT '描述',
  icon        VARCHAR(50)                   DEFAULT NULL
  COMMENT '图标',
  type        TINYINT(3)           NOT NULL DEFAULT 1
  COMMENT '类型(1:普通,2:热门...)',
  alias       VARCHAR(20)                   DEFAULT NULL
  COMMENT '别名',
  system_id   INT COMMENT '所属系统',
  ctime       BIGINT(20) UNSIGNED  NOT NULL
  COMMENT '创建时间',
  orders      BIGINT(255) UNSIGNED NOT NULL
  COMMENT '排序',
  PRIMARY KEY (category_id),
  KEY cms_category_orders (orders),
  KEY cms_category_pid (pid),
  KEY cms_category_alias (alias),
  KEY cms_category_level (level)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  COMMENT ='类目表';

ALTER TABLE cms_category
  COMMENT '类目表';

INSERT INTO cms_category (category_id, pid, level, name, description, icon, type, alias, ctime, orders)
  SELECT
    category_id,
    pid,
    level,
    name,
    description,
    icon,
    type,
    alias,
    ctime,
    orders
  FROM tmp_cms_category;

/*==============================================================*/
/* Table: cms_comment                                           */
/*==============================================================*/
CREATE TABLE cms_comment
(
  comment_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  pid        INT(10) UNSIGNED          DEFAULT NULL
  COMMENT '回复楼中楼编号回复楼中楼编号',
  article_id INT(10) UNSIGNED NOT NULL
  COMMENT '文章编号',
  user_id    INT(10) UNSIGNED NOT NULL
  COMMENT '用户编号',
  content    TEXT             NOT NULL
  COMMENT '评论内容',
  status     TINYINT(4)       NOT NULL DEFAULT 1
  COMMENT '状态(-1:不通过,0:未审核,1:通过)',
  ip         VARCHAR(30)               DEFAULT NULL
  COMMENT '评论人ip地址',
  agent      VARCHAR(200)              DEFAULT NULL
  COMMENT '评论人终端信息',
  system_id  INT COMMENT '所属系统',
  ctime      BIGINT(20)       NOT NULL
  COMMENT '创建时间',
  PRIMARY KEY (comment_id),
  KEY cms_comment_article_id (article_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

ALTER TABLE cms_comment
  COMMENT '评论表';

INSERT INTO cms_comment (comment_id, pid, article_id, user_id, content, status, ip, agent, ctime)
  SELECT
    comment_id,
    pid,
    article_id,
    user_id,
    content,
    status,
    ip,
    agent,
    ctime
  FROM tmp_cms_comment;

/*==============================================================*/
/* Table: cms_system                                            */
/*==============================================================*/
CREATE TABLE cms_system
(
  system_id   INT UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '编号',
  name        VARCHAR(20)  NOT NULL
  COMMENT '系统名称',
  code        VARCHAR(20) COMMENT '别名',
  description VARCHAR(300) COMMENT '描述',
  ctime       BIGINT COMMENT '创建时间',
  orders      BIGINT COMMENT '排序',
  PRIMARY KEY (system_id)
);

ALTER TABLE cms_system
  COMMENT '系统管理';

/*==============================================================*/
/* Table: cms_tag                                               */
/*==============================================================*/
CREATE TABLE cms_tag
(
  tag_id      INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '标签编号',
  name        VARCHAR(20)         NOT NULL
  COMMENT '名称',
  description VARCHAR(200)                 DEFAULT NULL
  COMMENT '描述',
  icon        VARCHAR(50)                  DEFAULT NULL
  COMMENT '图标',
  type        TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '类型(1:普通,2:热门...)',
  alias       VARCHAR(20)                  DEFAULT NULL
  COMMENT '别名',
  system_id   INT COMMENT '所属系统',
  ctime       BIGINT(20) UNSIGNED NOT NULL
  COMMENT '创建时间',
  orders      BIGINT(20) UNSIGNED NOT NULL
  COMMENT '排序',
  PRIMARY KEY (tag_id),
  KEY cms_tag_orders (orders),
  KEY cms_tag_alias (alias)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COMMENT ='标签表';

ALTER TABLE cms_tag
  COMMENT '标签表';

INSERT INTO cms_tag (tag_id, name, description, icon, type, alias, ctime, orders)
  SELECT
    tag_id,
    name,
    description,
    icon,
    type,
    alias,
    ctime,
    orders
  FROM tmp_cms_tag;

ALTER TABLE cms_article
  ADD CONSTRAINT FK_Reference_30 FOREIGN KEY (topic_id)
REFERENCES cms_topic (topic_id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE cms_article_category
  ADD CONSTRAINT FK_Reference_7 FOREIGN KEY (category_id)
REFERENCES cms_category (category_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_article_category
  ADD CONSTRAINT FK_Reference_8 FOREIGN KEY (article_id)
REFERENCES cms_article (article_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_article_tag
  ADD CONSTRAINT FK_Reference_3 FOREIGN KEY (article_id)
REFERENCES cms_article (article_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_article_tag
  ADD CONSTRAINT FK_Reference_4 FOREIGN KEY (tag_id)
REFERENCES cms_tag (tag_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_category
  ADD CONSTRAINT FK_Reference_10 FOREIGN KEY (pid)
REFERENCES cms_category (category_id)
  ON DELETE SET NULL
  ON UPDATE RESTRICT;

ALTER TABLE cms_category_tag
  ADD CONSTRAINT FK_Reference_5 FOREIGN KEY (category_id)
REFERENCES cms_category (category_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_category_tag
  ADD CONSTRAINT FK_Reference_6 FOREIGN KEY (tag_id)
REFERENCES cms_tag (tag_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_comment
  ADD CONSTRAINT FK_Reference_1 FOREIGN KEY (article_id)
REFERENCES cms_article (article_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE cms_comment
  ADD CONSTRAINT FK_Reference_2 FOREIGN KEY (pid)
REFERENCES cms_comment (comment_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

