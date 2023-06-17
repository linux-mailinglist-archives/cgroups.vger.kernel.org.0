Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C79733FD6
	for <lists+cgroups@lfdr.de>; Sat, 17 Jun 2023 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjFQJNd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jun 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJNb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jun 2023 05:13:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FC2688;
        Sat, 17 Jun 2023 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686993209; x=1718529209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=08QS7Gwvov/7c+f5JerWj3mbiwURUQm6js4XGT9n+oU=;
  b=YfwItNUBuyL7qZzmGdkxau4myAAsuMw2NQvGMzksBQx3oB8PpJdd8KMD
   gl5SFhVXPeq2gnZKWZDQbFqh/Xpbtgi56QzD5j5AFoIcdcx93xlSu46yG
   5pt4/uaPTlumZ+Jc+osQaAibE3UV0EMSI06/ZuugxdTrzwiux+nf7/2EM
   btbgMXYUnFF2WOsU6gP86oVwHeMjO3PJXEf+L2pDvJjQ56KQDl3aO3bsF
   pzbiclo3zI+d0yIz02mu5JhQ6PfBekSjQW5ANmSUS3vjiDjTG3XlDAtKt
   +gFDzGMKW/JqKOLTo55jUjYfB6qZYBEHLobcBlLAucFu2SorzQmgRzU1j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425317279"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="425317279"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 02:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="887374515"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="887374515"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2023 02:13:26 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qARzp-0002Zf-2S;
        Sat, 17 Jun 2023 09:13:25 +0000
Date:   Sat, 17 Jun 2023 17:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com
Subject: Re: [PATCH] memcg: remove unneeded header files
Message-ID: <202306171649.O90yt13M-lkp@intel.com>
References: <20230617072658.1826560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617072658.1826560-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Miaohe,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.4-rc6 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/memcg-remove-unneeded-header-files/20230617-152922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230617072658.1826560-1-linmiaohe%40huawei.com
patch subject: [PATCH] memcg: remove unneeded header files
config: nios2-randconfig-r004-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171649.O90yt13M-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171649.O90yt13M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171649.O90yt13M-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memcontrol.c: In function 'mem_cgroup_css_offline':
>> mm/memcontrol.c:5447:9: error: implicit declaration of function 'wb_memcg_offline' [-Werror=implicit-function-declaration]
    5447 |         wb_memcg_offline(memcg);
         |         ^~~~~~~~~~~~~~~~
   mm/memcontrol.c: In function 'mem_cgroup_move_account':
>> mm/memcontrol.c:5788:29: error: implicit declaration of function 'mapping_can_writeback'; did you mean 'mapping_map_writable'? [-Werror=implicit-function-declaration]
    5788 |                         if (mapping_can_writeback(mapping)) {
         |                             ^~~~~~~~~~~~~~~~~~~~~
         |                             mapping_map_writable
   cc1: some warnings being treated as errors


vim +/wb_memcg_offline +5447 mm/memcontrol.c

8cdea7c0545426 Balbir Singh      2008-02-07  5424  
eb95419b023aba Tejun Heo         2013-08-08  5425  static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
df878fb04dea04 KAMEZAWA Hiroyuki 2008-02-07  5426  {
eb95419b023aba Tejun Heo         2013-08-08  5427  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
3bc942f372af38 Tejun Heo         2013-11-22  5428  	struct mem_cgroup_event *event, *tmp;
79bd9814e5ec9a Tejun Heo         2013-11-22  5429  
79bd9814e5ec9a Tejun Heo         2013-11-22  5430  	/*
79bd9814e5ec9a Tejun Heo         2013-11-22  5431  	 * Unregister events and notify userspace.
79bd9814e5ec9a Tejun Heo         2013-11-22  5432  	 * Notify userspace about cgroup removing only after rmdir of cgroup
79bd9814e5ec9a Tejun Heo         2013-11-22  5433  	 * directory to avoid race between userspace and kernelspace.
79bd9814e5ec9a Tejun Heo         2013-11-22  5434  	 */
4ba9515d32bac1 Shakeel Butt      2021-09-02  5435  	spin_lock_irq(&memcg->event_list_lock);
fba94807837850 Tejun Heo         2013-11-22  5436  	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
79bd9814e5ec9a Tejun Heo         2013-11-22  5437  		list_del_init(&event->list);
79bd9814e5ec9a Tejun Heo         2013-11-22  5438  		schedule_work(&event->remove);
79bd9814e5ec9a Tejun Heo         2013-11-22  5439  	}
4ba9515d32bac1 Shakeel Butt      2021-09-02  5440  	spin_unlock_irq(&memcg->event_list_lock);
ec64f51545fffb KAMEZAWA Hiroyuki 2009-04-02  5441  
bf8d5d52ffe89a Roman Gushchin    2018-06-07  5442  	page_counter_set_min(&memcg->memory, 0);
230671533d6463 Roman Gushchin    2018-06-07  5443  	page_counter_set_low(&memcg->memory, 0);
63677c745d63ba Roman Gushchin    2017-09-06  5444  
567e9ab2e614e5 Johannes Weiner   2016-01-20  5445  	memcg_offline_kmem(memcg);
a178015cde6998 Yang Shi          2021-05-04  5446  	reparent_shrinker_deferred(memcg);
52ebea749aaed1 Tejun Heo         2015-05-22 @5447  	wb_memcg_offline(memcg);
e4dde56cd20867 Yu Zhao           2022-12-21  5448  	lru_gen_offline_memcg(memcg);
73f576c04b9410 Johannes Weiner   2016-07-20  5449  
591edfb10a949d Roman Gushchin    2018-10-26  5450  	drain_all_stock(memcg);
591edfb10a949d Roman Gushchin    2018-10-26  5451  
73f576c04b9410 Johannes Weiner   2016-07-20  5452  	mem_cgroup_id_put(memcg);
df878fb04dea04 KAMEZAWA Hiroyuki 2008-02-07  5453  }
df878fb04dea04 KAMEZAWA Hiroyuki 2008-02-07  5454  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
