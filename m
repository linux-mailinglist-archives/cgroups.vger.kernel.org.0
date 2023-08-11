Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C77790A2
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjHKNSq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHKNSp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 09:18:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F018E;
        Fri, 11 Aug 2023 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759925; x=1723295925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LZExdhkOrTYKPjUezsTjpMDrT0pVuYd3aBLIrKl/gtg=;
  b=XWxaR1Nl5ZoMrhAmCanUMkycMZS9xRKpbMrtk2YWkWj7jMwqdhkUj2Vx
   VQ2u+5VuDbrFfboRN61IwB6P7OUPwkwBYn3TembxeKgSbWbQpHFY6t+5k
   w9RbhbzeoyWnAM+C9pZKBNfGGNYJHZopLrEF+GD6RgvpBu4al1WvG/wdu
   NMJhqrW0QcqAOlpFm1KvRNo2uFVhGnY4U7KaLuHtbhED8hJe9TkBPm9Dk
   f9zDkuhKZS4MuVZrC0SE6k+anu9smLbIg8Hat4mtK557jY2D3CXaSdFmH
   GOAH9ZLOJ1tFVyiVRYOHw2n1+dy70g9Z4igz/4mKm7G1obQXnruag58jk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356636632"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356636632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762194819"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="762194819"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2023 06:18:42 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUS2M-0007o0-0A;
        Fri, 11 Aug 2023 13:18:42 +0000
Date:   Fri, 11 Aug 2023 21:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li kunyu <kunyu@nfschina.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] cgroup: cgroup: =?utf-8?Q?Remo?=
 =?utf-8?B?dmUgdW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from ret
Message-ID: <202308112134.cHq2KhFM-lkp@intel.com>
References: <20230813014734.2916-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813014734.2916-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: nios2-randconfig-r031-20230811 (https://download.01.org/0day-ci/archive/20230811/202308112134.cHq2KhFM-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112134.cHq2KhFM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112134.cHq2KhFM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'delegate_show':
>> kernel/cgroup/cgroup.c:7000:15: warning: 'ret' is used uninitialized [-Wuninitialized]
    7000 |         ret = show_delegatable_files(cgroup_base_files, buf + ret,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    7001 |                                      PAGE_SIZE - ret, NULL);
         |                                      ~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6998:17: note: 'ret' was declared here
    6998 |         ssize_t ret;
         |                 ^~~


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
