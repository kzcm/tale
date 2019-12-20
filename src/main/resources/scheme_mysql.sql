-- mysql 版本的 sql 语句

-- date 2019/12/20
-- 删除了 COMMIT TRANSACTION;PRAGMA foreign_keys = on; 和 INTEGER 和 其他 mysql 不支持的字段


-- 表：t_attach
DROP TABLE IF EXISTS t_attach;
CREATE TABLE t_attach (id BIGINT(12) PRIMARY KEY AUTO_INCREMENT NOT NULL, fname VARCHAR (100) NOT NULL, ftype VARCHAR (50), fkey VARCHAR (100) NOT NULL, author_id BIGINT(12) NOT NULL, created BIGINT(12) NOT NULL);

-- 表：t_comments
DROP TABLE IF EXISTS t_comments;
CREATE TABLE t_comments (coid BIGINT(12) PRIMARY KEY AUTO_INCREMENT NOT NULL, cid BIGINT(12)  NOT NULL, created BIGINT(12) NOT NULL, author VARCHAR (200) NOT NULL, author_id BIGINT(12) , owner_id BIGINT(12) , mail VARCHAR (200) NOT NULL, url VARCHAR (200), ip VARCHAR (64), agent VARCHAR (200), content TEXT NOT NULL, TYPE VARCHAR (16), STATUS VARCHAR (16), parent BIGINT(12) );

-- 表：t_contents
DROP TABLE IF EXISTS t_contents;

CREATE TABLE t_contents ( cid BIGINT(12) PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE, title VARCHAR (255) NOT NULL, slug VARCHAR (255)  UNIQUE, thumb_img VARCHAR(255), created BIGINT(12) NOT NULL, modified BIGINT(12), content TEXT, author_id BIGINT(12) NOT NULL, TYPE VARCHAR (16) NOT NULL, STATUS VARCHAR (16) NOT NULL, fmt_type VARCHAR (16) DEFAULT 'markdown', tags VARCHAR (200), categories VARCHAR (200), hits BIGINT(12) , comments_num BIGINT(12)  , allow_comment BIGINT(12)  DEFAULT 1, allow_ping BIGINT(12) , allow_feed BIGINT(12)  );
INSERT INTO t_contents (cid, title, slug, created, modified, content, author_id, TYPE, STATUS, tags, categories, hits, comments_num, allow_comment, allow_ping, allow_feed) VALUES (1, '关于', 'about', 1487853610, 1487872488, '### Hello World

这是我的关于页面

### 当然还有其他

具体你来写点什么吧', 1, 'page', 'publish', NULL, NULL, 0, 0, 1, 1, 1);
INSERT INTO t_contents (cid, title, slug, created, modified, content, author_id, TYPE, STATUS, tags, categories, hits, comments_num, allow_comment, allow_ping, allow_feed) VALUES (2, '第一篇文章', NULL, 1487861184, 1487872798, '## Hello  World.

> 第一篇文章总得写点儿什么?...

----------


<!--more-->

```java
public static void main(String[] args){
    System.out.println(\"Hello Tale.\");
}
```', 1, 'post', 'publish', '', '默认分类', 10, 0, 1, 1, 1);

INSERT INTO t_contents (allow_feed,allow_ping,allow_comment,comments_num,hits,
categories,tags,fmt_type,STATUS,TYPE,author_id,content,modified,created,thumb_img,slug,title,cid) VALUES (
NULL,1,1,0,0,NULL,NULL,'markdown','publish','page',1,'## 友情链接

- :lock: [王爵的技术博客]()
- :lock: [cyang.tech]()
- :lock: [Bakumon''s Blog]()

## 链接须知

> 请确定贵站可以稳定运营
> 原创博客优先，技术类博客优先，设计、视觉类博客优先
> 经常过来访问和评论，眼熟的

备注：默认申请友情链接均为内页（当前页面）

## 基本信息

                网站名称：Tale博客
                网站地址：https://tale.biezhi.me

请在当页通过评论来申请友链，其他地方不予回复

暂时先这样，同时欢迎互换友链，这个页面留言即可。 ^_^

还有，我会不定时对无法访问的网址进行清理，请保证自己的链接长期有效。',1505643888,1505643727,NULL,'links','友情链接',3);

-- 表：t_logs
DROP TABLE IF EXISTS t_logs;
CREATE TABLE t_logs (id BIGINT(12) PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL, `action` VARCHAR (100) NOT NULL, DATA VARCHAR (2000), author_id BIGINT(12) NOT NULL, ip VARCHAR (20), created BIGINT(12) NOT NULL);

-- 表：t_metas
DROP TABLE IF EXISTS t_metas;
CREATE TABLE t_metas (MID BIGINT(12) PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL, NAME VARCHAR (200) NOT NULL, slug VARCHAR (200), TYPE VARCHAR (32) NOT NULL, description VARCHAR (255), sort BIGINT(12) , parent BIGINT(12) );
INSERT INTO t_metas (MID, NAME, slug, TYPE, description, sort, parent) VALUES (1, '默认分类', NULL, 'category', NULL, 0, 0);

-- 表：t_options
DROP TABLE IF EXISTS t_options;
CREATE TABLE t_options (NAME VARCHAR (100) PRIMARY KEY UNIQUE NOT NULL, VALUE TEXT, description VARCHAR (255));
INSERT INTO t_options (NAME, VALUE, description) VALUES ('site_title', 'Tale博客系统', '');
INSERT INTO t_options (NAME, VALUE, description) VALUES ('social_weibo', '', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('social_zhihu', '', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('social_github', '', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('social_twitter', '', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('allow_install', 'false', '是否允许重新安装博客');
INSERT INTO t_options (NAME, VALUE, description) VALUES ('allow_comment_audit', 'true', '评论需要审核');
INSERT INTO t_options (NAME, VALUE, description) VALUES ('site_theme', 'default', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('site_keywords', '博客系统,Blade框架,Tale', NULL);
INSERT INTO t_options (NAME, VALUE, description) VALUES ('site_description', '博客系统,Blade框架,Tale', NULL);

-- 表：t_relationships
DROP TABLE IF EXISTS t_relationships;
CREATE TABLE t_relationships (cid BIGINT(12) NOT NULL, MID BIGINT(12) NOT NULL);

INSERT INTO t_relationships(cid, MID) VALUES(2, 1);

-- 表：t_users
DROP TABLE IF EXISTS t_users;
CREATE TABLE t_users (uid BIGINT(12) PRIMARY KEY UNIQUE NOT NULL, username VARCHAR (64) UNIQUE NOT NULL, PASSWORD VARCHAR (64) NOT NULL, email VARCHAR (100), home_url VARCHAR (255), screen_name VARCHAR (100), created BIGINT(12) NOT NULL, activated BIGINT(12), logged BIGINT(12), group_name VARCHAR (16));

-- COMMIT TRANSACTION;
-- PRAGMA foreign_keys = on;
