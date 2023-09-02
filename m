Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCF790966
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjIBTng (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjIBTng (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 15:43:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B828EE6A;
        Sat,  2 Sep 2023 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693683811; x=1725219811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9vo+M2L7/MeOyDeQ/8iCmxYZrv+WsA2IvXTKmHiP14=;
  b=jV7cTCYyXWXLfxAZVj2idhK8LrtZe/XYmMhFYr/tAL93k0a0pU6rAwD1
   6Re1A/LWtXaaW9Qzc7/99CiGJObhW0NAgCXtthfmri1W+fs/RSL4H/PVQ
   mibBikCrmEmWJFExAhGMLampOF8GZgg/wh0hdNH6had7hSFHvD6zUDMD0
   02xhX+YCtHAq6GbUqZcWn/0N09E5qdDUGO6v9aI54u1OhkFZrKx+OX237
   DOW2DqDAuHabpt82eEYKp0w3U1nppd55DIMLVVvMoFfiGotz6Z7W7m1Oh
   bRVfF+7Vy3fREW2GQef5DjMFJXku85A+JyIMF/FPR3ukVORYubfZRSusV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="462762161"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="462762161"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 12:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="863909206"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="863909206"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2023 12:43:28 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcWWk-0002Yy-1d;
        Sat, 02 Sep 2023 19:43:26 +0000
Date:   Sun, 3 Sep 2023 03:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.6-fixes] cgroup: Put
 cgroup_local_stat_show() inside CONFIG_CGROUP_SCHED
Message-ID: <202309030303.qSTfRgZC-lkp@intel.com>
References: <ZPNX-jZAZbebizXA@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPNX-jZAZbebizXA@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230831]
[cannot apply to linus/master v6.5 v6.5-rc7 v6.5-rc6 v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/cgroup-Put-cgroup_local_stat_show-inside-CONFIG_CGROUP_SCHED/20230902-234358
base:   next-20230831
patch link:    https://lore.kernel.org/r/ZPNX-jZAZbebizXA%40slm.duckdns.org
patch subject: [PATCH cgroup/for-6.6-fixes] cgroup: Put cgroup_local_stat_show() inside CONFIG_CGROUP_SCHED
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230903/202309030303.qSTfRgZC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309030303.qSTfRgZC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309030303.qSTfRgZC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:503:36: warning: 'cgroup_tryget_css' defined but not used [-Wunused-function]
     503 | static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
         |                                    ^~~~~~~~~~~~~~~~~


vim +/cgroup_tryget_css +503 kernel/cgroup/cgroup.c

42809dd4225b2f kernel/cgroup.c        Tejun Heo 2012-11-19  494  
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  495  /**
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  496   * cgroup_tryget_css - try to get a cgroup's css for the specified subsystem
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  497   * @cgrp: the cgroup of interest
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  498   * @ss: the subsystem of interest
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  499   *
08b2b6fdf6b260 kernel/cgroup/cgroup.c Zhen Lei  2021-05-24  500   * Find and get @cgrp's css associated with @ss.  If the css doesn't exist
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  501   * or is offline, %NULL is returned.
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  502   */
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23 @503  static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  504  						     struct cgroup_subsys *ss)
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  505  {
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  506  	struct cgroup_subsys_state *css;
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  507  
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  508  	rcu_read_lock();
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  509  	css = cgroup_css(cgrp, ss);
a581563f1bef03 kernel/cgroup/cgroup.c Peng Wang 2019-07-03  510  	if (css && !css_tryget_online(css))
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  511  		css = NULL;
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  512  	rcu_read_unlock();
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  513  
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  514  	return css;
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  515  }
d41bf8c9deaed1 kernel/cgroup/cgroup.c Tejun Heo 2017-10-23  516  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
