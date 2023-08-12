Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6871779D54
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 07:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjHLFoJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 01:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLFoI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 01:44:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315AB2D44;
        Fri, 11 Aug 2023 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691819047; x=1723355047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vsrqajthoEmurm5NVfeEuBVx0HE3ai+cd5EQa9FXyeU=;
  b=O11TuYHTxBpvqxfQ8kbsaG2f1S3kIjFEidbn/fH7Y7hAGOkLu3RnoX/4
   xz0/zl4QFfJ+HwLS/PC4RWRvZZhuUJFpoHmcz2l7nFvgHRQ+WTCjZfYU2
   DvaA5U66JMwOXdeVXNDBaUl8FGS7HvdhnkYB6QQ0Q3POIEeWsSjz6RHu7
   IHPIou5ptwnppWmPeZWskjxSe90ynhtVySggyfEwIFEZjspqFnpaWse1i
   1lqDXv4Z473s2+2xeaC5HZaMvi10Tz1Tzmec7OTYOm7JTFT8/OweMvBVB
   TaJd4YwHd0eO/4FyEs1dukdp5KSjkasFGk7EbsIEXPeal/zHmoiBv5Dv4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375515208"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="375515208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 22:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063506269"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="1063506269"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 22:44:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUhPu-0008IK-3D;
        Sat, 12 Aug 2023 05:44:02 +0000
Date:   Sat, 12 Aug 2023 13:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li kunyu <kunyu@nfschina.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] cgroup: cgroup: =?utf-8?Q?Remo?=
 =?utf-8?B?dmUgdW5uZWNlc3Nhcnkg4oCYTlVMTOKAmQ==?= values from res
Message-ID: <202308121338.k2YdCXVR-lkp@intel.com>
References: <20230813015142.3095-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813015142.3095-1-kunyu@nfschina.com>
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

[auto build test WARNING on tj-cgroup/for-next]
[cannot apply to linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/cgroup-cgroup-Remove-unnecessary-NULL-values-from-res/20230811-172322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20230813015142.3095-1-kunyu%40nfschina.com
patch subject: [PATCH] cgroup: cgroup: Remove unnecessary ‘NULL’ values from res
config: x86_64-randconfig-x002-20230812 (https://download.01.org/0day-ci/archive/20230812/202308121338.k2YdCXVR-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121338.k2YdCXVR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121338.k2YdCXVR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:1380:3: warning: variable 'res' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
                   list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:578:7: note: expanded from macro 'list_for_each_entry'
                &pos->member != (head);                                    \
                ^~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:1391:10: note: uninitialized use occurs here
           BUG_ON(!res);
                   ^~~
   include/asm-generic/bug.h:62:45: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                               ^~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   kernel/cgroup/cgroup.c:1380:3: note: remove the condition if it is always true
                   list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
                   ^
   include/linux/list.h:578:7: note: expanded from macro 'list_for_each_entry'
                &pos->member != (head);                                    \
                ^
   kernel/cgroup/cgroup.c:1367:20: note: initialize the variable 'res' to silence this warning
           struct cgroup *res;
                             ^
                              = NULL
   1 warning generated.


vim +1380 kernel/cgroup/cgroup.c

f2e85d574e881f kernel/cgroup.c        Tejun Heo       2014-02-11  1359  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1360  /*
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1361   * look up cgroup associated with current task's cgroup namespace on the
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1362   * specified hierarchy
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1363   */
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1364  static struct cgroup *
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1365  current_cgns_cgroup_from_root(struct cgroup_root *root)
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1366  {
aa6f66ec5ebc27 kernel/cgroup/cgroup.c Li kunyu        2023-08-13  1367  	struct cgroup *res;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1368  	struct css_set *cset;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1369  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1370  	lockdep_assert_held(&css_set_lock);
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1371  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1372  	rcu_read_lock();
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1373  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1374  	cset = current->nsproxy->cgroup_ns->root_cset;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1375  	if (cset == &init_css_set) {
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1376  		res = &root->cgrp;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1377  	} else {
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1378  		struct cgrp_cset_link *link;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1379  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09 @1380  		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1381  			struct cgroup *c = link->cgrp;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1382  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1383  			if (c->root == root) {
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1384  				res = c;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1385  				break;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1386  			}
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1387  		}
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1388  	}
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1389  	rcu_read_unlock();
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1390  
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1391  	BUG_ON(!res);
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1392  	return res;
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1393  }
4f41fc59620fce kernel/cgroup.c        Serge E. Hallyn 2016-05-09  1394  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
