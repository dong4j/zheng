package com.zheng.api.rpc.service.impl;

import com.zheng.api.rpc.api.ApiService;
import com.zheng.cms.rpc.api.CmsArticleService;
import com.zheng.cms.rpc.api.CmsCategoryService;
import com.zheng.cms.rpc.api.CmsCommentService;
import com.zheng.cms.rpc.api.CmsTagService;
import com.zheng.upms.rpc.api.UpmsApiService;
import com.zheng.upms.rpc.api.UpmsOrganizationService;
import com.zheng.upms.rpc.api.UpmsPermissionService;
import com.zheng.upms.rpc.api.UpmsRoleService;
import com.zheng.upms.rpc.api.UpmsSystemService;
import com.zheng.upms.rpc.api.UpmsUserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 实现ApiService接口
 * Created by shuzheng on 2017/2/19.
 */
public class ApiServiceImpl implements ApiService {

    private static final Logger logger = LoggerFactory.getLogger(ApiServiceImpl.class);

    @Autowired
    private UpmsSystemService upmsSystemService;

    @Autowired
    private UpmsOrganizationService upmsOrganizationService;

    @Autowired
    private UpmsUserService upmsUserService;

    @Autowired
    private UpmsRoleService upmsRoleService;

    @Autowired
    private UpmsPermissionService upmsPermissionService;

    @Autowired
    private UpmsApiService upmsApiService;

    @Autowired
    private CmsArticleService cmsArticleService;

    @Autowired
    private CmsCategoryService cmsCategoryService;

    @Autowired
    private CmsCommentService cmsCommentService;

    @Autowired
    private CmsTagService cmsTagService;

    @Override
    public String hello(String name) {
        return "hello," + name + "!";
    }

}
