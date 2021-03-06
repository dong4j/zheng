package com.zheng.cms.rpc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 服务启动类
 * Created by ZhangShuzheng on 2017/2/3.
 */
public class ZhengCmsRpcServiceApplication {

    private static final Logger logger = LoggerFactory.getLogger(ZhengCmsRpcServiceApplication.class);

    public static void main(String[] args) {
       logger.info(">>>>> zheng-cms-rpc-service 正在启动 <<<<<");
        new ClassPathXmlApplicationContext("classpath:META-INF/spring/*.xml");
       logger.info(">>>>> zheng-cms-rpc-service 启动完成 <<<<<");
    }

}
