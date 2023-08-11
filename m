Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C27790C1
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHKN2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHKN2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 09:28:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034690;
        Fri, 11 Aug 2023 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691760526; x=1723296526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NbxrrXvoiSicJd1C4RwRcvJ2E3Rl98Kr2w0LNsNE+g8=;
  b=dV/8THL08tgrnGu0xeZ06XzvraKbd8PVUFAtLgY033sn32oI/fK3thEn
   hG+hUZAYr2zH2UKOk7r4PnqwJQQexLSu0JS3am8KzXMhsHd3OSXVkCNHI
   GM36NqKd/AYjzSwSWZ9rpqibxKTlZX/CGVUHufBVX0RZyA9bOCjfMy+cA
   uqd75OGstzgXC3N4BDUg6+ymWY50Qbwp0y2reU3lxSruBjW2GlDFmOFsQ
   i8C1tnShXMywjOOZj1ZbiOs49xwFp5DOHOpq/qtnJ/OBwk4m8p/2H6J7O
   e4o2FwXSfK2A8OT35cpe9EizpFN8HurngT+LPxjg0+m4Hec2cGbyT9JIf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369147251"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369147251"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846804187"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="846804187"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2023 06:28:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUSC2-0007oa-1W;
        Fri, 11 Aug 2023 13:28:42 +0000
Date:   Fri, 11 Aug 2023 21:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li kunyu <kunyu@nfschina.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] cgroup: cgroup: =?utf-8?Q?Remo?=
 =?utf-8?B?dmUgdW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from ret
Message-ID: <202308112139.lVjuXYZg-lkp@intel.com>
References: <20230813014734.2916-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813014734.2916-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.5-rc5]
[also build test WARNING on linus/master next-20230809]
[cannot apply to tj-cgroup/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/cgroup-cgroup-Remove-unnecessary-0-values-from-ret/20230811-171814
base:   v6.5-rc5
patch link:    https://lore.kernel.org/r/20230813014734.2916-1-kunyu%40nfschina.com
patch subject: [PATCH] cgroup: cgroup: Remove unnecessary ‘0’ values from ret
config: x86_64-randconfig-r035-20230811 (https://download.01.org/0day-ci/archive/20230811/202308112139.lVjuXYZg-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112139.lVjuXYZg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112139.lVjuXYZg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:7000:56: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           ret = show_delegatable_files(cgroup_base_files, buf + ret,
                                                                 ^~~
   kernel/cgroup/cgroup.c:6998:13: note: initialize the variable 'ret' to silence this warning
           ssize_t ret;
                      ^
                       = 0
   1 warning generated.


vim +/ret +7000 kernel/cgroup/cgroup.c

01ee6cfb1483fe Roman Gushchin 2017-11-06  6992  
01ee6cfb1483fe Roman Gushchin 2017-11-06  6993  static ssize_t delegate_show(struct kobject *kobj, struct kobj_attribute *attr,
01ee6cfb1483fe Roman Gushchin 2017-11-06  6994  			      char *buf)
01ee6cfb1483fe Roman Gushchin 2017-11-06  6995  {
01ee6cfb1483fe Roman Gushchin 2017-11-06  6996  	struct cgroup_subsys *ss;
01ee6cfb1483fe Roman Gushchin 2017-11-06  6997  	int ssid;
3d7f13682faf54 Li kunyu       2023-08-13  6998  	ssize_t ret;
01ee6cfb1483fe Roman Gushchin 2017-11-06  6999  
8a693f7766f9e2 Tejun Heo      2022-09-06 @7000  	ret = show_delegatable_files(cgroup_base_files, buf + ret,
8a693f7766f9e2 Tejun Heo      2022-09-06  7001  				     PAGE_SIZE - ret, NULL);
8a693f7766f9e2 Tejun Heo      2022-09-06  7002  	if (cgroup_psi_enabled())
8a693f7766f9e2 Tejun Heo      2022-09-06  7003  		ret += show_delegatable_files(cgroup_psi_files, buf + ret,
8a693f7766f9e2 Tejun Heo      2022-09-06  7004  					      PAGE_SIZE - ret, NULL);
01ee6cfb1483fe Roman Gushchin 2017-11-06  7005  
01ee6cfb1483fe Roman Gushchin 2017-11-06  7006  	for_each_subsys(ss, ssid)
01ee6cfb1483fe Roman Gushchin 2017-11-06  7007  		ret += show_delegatable_files(ss->dfl_cftypes, buf + ret,
01ee6cfb1483fe Roman Gushchin 2017-11-06  7008  					      PAGE_SIZE - ret,
01ee6cfb1483fe Roman Gushchin 2017-11-06  7009  					      cgroup_subsys_name[ssid]);
01ee6cfb1483fe Roman Gushchin 2017-11-06  7010  
01ee6cfb1483fe Roman Gushchin 2017-11-06  7011  	return ret;
01ee6cfb1483fe Roman Gushchin 2017-11-06  7012  }
01ee6cfb1483fe Roman Gushchin 2017-11-06  7013  static struct kobj_attribute cgroup_delegate_attr = __ATTR_RO(delegate);
01ee6cfb1483fe Roman Gushchin 2017-11-06  7014  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
