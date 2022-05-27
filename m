Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2D535BD1
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiE0Iq2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbiE0Iq0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 04:46:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643A634F;
        Fri, 27 May 2022 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653641184; x=1685177184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YKsDt6Azr1nuJYOFtdAXGL2S2Sin9T2sVAVbgDSU0NU=;
  b=beP3AtmtB4KM6G0F/tZYeOujB4JSO2CwTjFG/ThpBlg+PGvg5EuBT+UB
   hWymzH6aLXOuILPwQURejQabiq8HZxWPpP87MtskaFJJdj9dKYggNodIi
   02WPksD25103WGrZdwjcxb1EzV+XJkxVmLBHLtOhO5tsDiktA+BELh0pr
   BCLdho5MBZxnyNi9VliDkCj9rJr97JSz0bURFovs2z8n0hGwT4UVScnyY
   XwCP8icRfvI9uEwbOHZ3BwlyT4OiZ1ZQyimhmTfCNieRd+QLn283LtXFE
   bzl32ySlHWuqkpi1IKnZqZX8BRhHMkwPA84Gpu0CLeP3WbZLGBIVyGQvr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335073627"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335073627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718795000"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2022 01:46:22 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuVbx-0004aE-Ml;
        Fri, 27 May 2022 08:46:21 +0000
Date:   Fri, 27 May 2022 16:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
Message-ID: <202205271657.MRX54zi5-lkp@intel.com>
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hongchen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongchen-Zhang/cgroup-wait-for-css-offline-when-rmdir/20220527-104105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220527/202205271657.MRX54zi5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9cd51af8f62de826ed76ffb6a63dce3d14926a03
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongchen-Zhang/cgroup-wait-for-css-offline-when-rmdir/20220527-104105
        git checkout 9cd51af8f62de826ed76ffb6a63dce3d14926a03
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:3024:6: warning: no previous prototype for 'cgroup_wait_css_offline' [-Wmissing-prototypes]
    3024 | void cgroup_wait_css_offline(struct cgroup *cgrp)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/cgroup_wait_css_offline +3024 kernel/cgroup/cgroup.c

  3022	
  3023	/* wait all cgrp's csses become offlined */
> 3024	void cgroup_wait_css_offline(struct cgroup *cgrp)
  3025	{
  3026		struct cgroup_subsys *ss;
  3027		int ssid;
  3028	
  3029		lockdep_assert_held(&cgroup_mutex);
  3030		for_each_subsys(ss, ssid) {
  3031			struct cgroup_subsys_state *css = cgroup_css(cgrp, ss);
  3032			DEFINE_WAIT(wait);
  3033	
  3034			if (!css || !percpu_ref_is_dying(&css->refcnt))
  3035				continue;
  3036	
  3037			prepare_to_wait(&cgrp->offline_waitq, &wait,
  3038					TASK_UNINTERRUPTIBLE);
  3039	
  3040			mutex_unlock(&cgroup_mutex);
  3041			schedule();
  3042			finish_wait(&cgrp->offline_waitq, &wait);
  3043	
  3044			mutex_lock(&cgroup_mutex);
  3045		}
  3046	}
  3047	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
