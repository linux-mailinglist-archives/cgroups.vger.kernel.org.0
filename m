Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A242B78E409
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 02:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbjHaAlq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Aug 2023 20:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHaAlm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Aug 2023 20:41:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F3CCF;
        Wed, 30 Aug 2023 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693442499; x=1724978499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0Kpa3glzmhOit+Gfb9EdvlhhILV82Bjg5COBTCvIV4=;
  b=fOeIwm49maEVtyfdf+ter0TurPRe4CWb4FSupeODdTz5RUZRFVZ3DQx8
   72albatUQFdQUHI+WzwsnLvInQgtBo7eE+ho2XCG3vXCeNoN6MJYYsSqV
   0zoLasynUp7xtwRWy0qPKo43wVegbi58uEtEiaqoBmD+45O6ZRUH6dkCt
   n/iN/ZEUpnHkqMZNVVXJfSbjVwg+nsDn0gbn5GykEUCBy7/bMBHSC2r5W
   C6EvC4In22qODZ1iu/eE7EK92/TJx7zNQk1WndhTltIo9xKtigoSCHjol
   MO/eDG4TEnVEFDvokNfzAN6oMnzCksJCr4WXOzQNIK4RQKqkJu1+AQR15
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462160105"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="462160105"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 17:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774290764"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="774290764"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 17:41:35 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbVkd-000APv-0I;
        Thu, 31 Aug 2023 00:41:35 +0000
Date:   Thu, 31 Aug 2023 08:40:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v3 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <202308310858.19VshX68-lkp@intel.com>
References: <20230830175335.1536008-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830175335.1536008-5-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master next-20230830]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-properly-name-and-document-unified-stats-flushing/20230831-015518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230830175335.1536008-5-yosryahmed%40google.com
patch subject: [PATCH v3 4/4] mm: memcg: use non-unified stats flushing for userspace reads
config: m68k-randconfig-r016-20230831 (https://download.01.org/0day-ci/archive/20230831/202308310858.19VshX68-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308310858.19VshX68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308310858.19VshX68-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:667:6: warning: no previous prototype for 'mem_cgroup_user_flush_stats' [-Wmissing-prototypes]
     667 | void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mem_cgroup_user_flush_stats +667 mm/memcontrol.c

   658	
   659	/*
   660	 * mem_cgroup_user_flush_stats - do a stats flush for a user read
   661	 * @memcg: memory cgroup to flush
   662	 *
   663	 * Flush the subtree of @memcg. A mutex is used for userspace readers to gate
   664	 * the global rstat spinlock. This protects in-kernel flushers from userspace
   665	 * readers hogging the lock.
   666	 */
 > 667	void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
   668	{
   669		mutex_lock(&stats_user_flush_mutex);
   670		do_stats_flush(memcg);
   671		mutex_unlock(&stats_user_flush_mutex);
   672	}
   673	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
