Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74A9734066
	for <lists+cgroups@lfdr.de>; Sat, 17 Jun 2023 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjFQK7g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jun 2023 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQK7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jun 2023 06:59:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BD10E3;
        Sat, 17 Jun 2023 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686999573; x=1718535573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJgqnncStiZ0O2XKLU6s/eNBp9BMfcDWyAx4Cgh5IGE=;
  b=UYaQFITcF2tXWRcBy7DgeNs1BMQ2CBHnPa73XhzxE3wsvQH/uEfWThWj
   AW7t9fiex/tU96AyEhemZdF+lUvJ8jJZk0YEo/N+BIVJzl3HjnVtflweP
   wO/OrJHEGGJXIwWSQ5WEEHS30z5g1zSTqDrESilc0BqPDpHVJq6lrbRA5
   GVgMpGhU91NieeWdly8HMRvB0/+fRj+BZTKgR2po9RGskdWo/gshnQvIg
   5N1hyzAAs5xsCi5eWkYC63GUPgvJjM0PXprbZXjDJOnY/ujSfpSyp1qK+
   I2Py8uMd27iwTz0rM+BcYxU5qjlO/rH7OMOiuicVTIQ+hUdfiyliSd5bN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="388248449"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="388248449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 03:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="1043377580"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="1043377580"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2023 03:59:30 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qATeT-0002gj-2z;
        Sat, 17 Jun 2023 10:59:29 +0000
Date:   Sat, 17 Jun 2023 18:58:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com
Subject: Re: [PATCH] memcg: remove unneeded header files
Message-ID: <202306171859.y5wGpmlD-lkp@intel.com>
References: <20230617072658.1826560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617072658.1826560-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: hexagon-randconfig-r045-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171859.y5wGpmlD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171859.y5wGpmlD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171859.y5wGpmlD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/memcontrol.c:29:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/memcontrol.c:29:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/memcontrol.c:29:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> mm/memcontrol.c:5447:2: error: call to undeclared function 'wb_memcg_offline'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5447 |         wb_memcg_offline(memcg);
         |         ^
>> mm/memcontrol.c:5788:8: error: call to undeclared function 'mapping_can_writeback'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5788 |                         if (mapping_can_writeback(mapping)) {
         |                             ^
   mm/memcontrol.c:5788:8: note: did you mean 'mapping_map_writable'?
   include/linux/fs.h:545:19: note: 'mapping_map_writable' declared here
     545 | static inline int mapping_map_writable(struct address_space *mapping)
         |                   ^
   6 warnings and 2 errors generated.


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
