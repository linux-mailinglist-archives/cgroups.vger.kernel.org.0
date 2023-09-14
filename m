Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBC7A0023
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjINJfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjINJfP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 05:35:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303C1BF2;
        Thu, 14 Sep 2023 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694684111; x=1726220111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xv1a0gFVKwM0KgM27I+fvR02P+gkJIUr4CQzjEBt0Mg=;
  b=hiBU4ySwB4KR12n+cWyAhW4Q+o2bX8Yz4FbjQFBppRtZFC+55H0Ekftx
   y+pmjOgbrGucN6kOTeuk/WvDrXfTjWjK/IAa9n5bxBzAqF0aYIK/2padQ
   hgHq11UCfEfw7iLVcir1geMzcaG+LNDGkM70TWzjtpE4McN/V5Vnq6r/6
   +QUoT8Mf3WNUXE+avmVxZ0NOUdQt9NKTIpenQV/eE0tyadNAOcU007LGI
   hARV8Tin6j22JqaPwm1Kl7Vovdp3aECYZXz0kwzEViCt9Rfw84um22cUt
   VvhjNjeJmPGG0gjVj27tMtOAOTJMCJ4uxAWMlSZId65bD80E9YxBHxtxm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409856695"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="409856695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747655958"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="747655958"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2023 02:35:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgika-0001RR-1I;
        Thu, 14 Sep 2023 09:35:04 +0000
Date:   Thu, 14 Sep 2023 17:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] zswap: make shrinking memcg-aware
Message-ID: <202309141736.ABab8fuf-lkp@intel.com>
References: <20230911164024.2541401-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911164024.2541401-2-nphamcs@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.6-rc1 next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/zswap-make-shrinking-memcg-aware/20230912-004147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230911164024.2541401-2-nphamcs%40gmail.com
patch subject: [PATCH 1/2] zswap: make shrinking memcg-aware
config: loongarch-randconfig-001-20230914 (https://download.01.org/0day-ci/archive/20230914/202309141736.ABab8fuf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141736.ABab8fuf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141736.ABab8fuf-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   mm/zswap.c: In function 'zswap_lru_add':
>> mm/zswap.c:320:17: error: implicit declaration of function 'get_mem_cgroup_from_objcg'; did you mean 'get_mem_cgroup_from_mm'? [-Werror=implicit-function-declaration]
     320 |                 get_mem_cgroup_from_objcg(entry->objcg) : NULL;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                 get_mem_cgroup_from_mm
>> mm/zswap.c:320:57: warning: pointer/integer type mismatch in conditional expression
     320 |                 get_mem_cgroup_from_objcg(entry->objcg) : NULL;
         |                                                         ^
   mm/zswap.c: In function 'zswap_lru_del':
   mm/zswap.c:330:57: warning: pointer/integer type mismatch in conditional expression
     330 |                 get_mem_cgroup_from_objcg(entry->objcg) : NULL;
         |                                                         ^
   mm/zswap.c: In function 'shrink_memcg_cb':
   mm/zswap.c:694:80: warning: pointer/integer type mismatch in conditional expression
     694 |                 memcg = entry->objcg ? get_mem_cgroup_from_objcg(entry->objcg) : NULL;
         |                                                                                ^
   mm/zswap.c: In function 'shrink_worker':
>> mm/zswap.c:758:51: error: invalid use of undefined type 'struct mem_cgroup'
     758 |                         css_put(&pool->next_shrink->css);
         |                                                   ^~
   mm/zswap.c: In function 'zswap_pool_destroy':
   mm/zswap.c:906:43: error: invalid use of undefined type 'struct mem_cgroup'
     906 |                 css_put(&pool->next_shrink->css);
         |                                           ^~
   mm/zswap.c: In function 'zswap_store':
>> mm/zswap.c:1298:23: warning: assignment to 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1298 |                 memcg = get_mem_cgroup_from_objcg(objcg);
         |                       ^
   mm/zswap.c:1300:39: error: invalid use of undefined type 'struct mem_cgroup'
    1300 |                         css_put(&memcg->css);
         |                                       ^~
   mm/zswap.c:1303:31: error: invalid use of undefined type 'struct mem_cgroup'
    1303 |                 css_put(&memcg->css);
         |                               ^~
   mm/zswap.c:1349:23: warning: assignment to 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1349 |                 memcg = get_mem_cgroup_from_objcg(objcg);
         |                       ^
   mm/zswap.c:1351:31: error: invalid use of undefined type 'struct mem_cgroup'
    1351 |                 css_put(&memcg->css);
         |                               ^~
   cc1: some warnings being treated as errors


vim +320 mm/zswap.c

   313	
   314	/*********************************
   315	* lru functions
   316	**********************************/
   317	static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
   318	{
   319		struct mem_cgroup *memcg = entry->objcg ?
 > 320			get_mem_cgroup_from_objcg(entry->objcg) : NULL;
   321		bool added = __list_lru_add(list_lru, &entry->lru, entry->nid, memcg);
   322	
   323		mem_cgroup_put(memcg);
   324		return added;
   325	}
   326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
