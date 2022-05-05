Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488651C4DF
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiEEQOw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381875AbiEEQOu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 12:14:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599701D30B;
        Thu,  5 May 2022 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651767060; x=1683303060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1eGeIh+xMiBRTxqWkXlfYujous1v8oMKzohvreSWsN8=;
  b=FNMAdsi+bg+d8+nosUfVJUoMrzCP+ZwWMIIQ38Sis9BZBryE1ITu1E24
   /F8BHqZsOr/ZDTPD3/safwHP+4+KVD6dds7ponxMCg40eon1sCWXVL/25
   MgLPGzhmn4F/GvSULHgWYJsczT5Tn68ITVnCmq9TG4Os63l3rJxWGULVq
   TqWTOrlj2Pa0QGs7LQUDgdYRrl0hzbogNCb1PQhwlzeDoN5ItvVN+6t4/
   Ql8gC/WlZLP03T/ZV2OodXeDhsnXV6P3g0XvSGZUMRTFlXriAQQH6p7tK
   ObfP/5DoCeyQ3wW46OXSGOvS7iwwOSAM3ZuwhUkRueHfCEKQJJY8iOCeX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331155509"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="331155509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="665035013"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2022 09:10:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nme3s-000CXj-Ac;
        Thu, 05 May 2022 16:10:40 +0000
Date:   Fri, 6 May 2022 00:09:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        willy@infradead.org, shy828301@gmail.com
Cc:     kbuild-all@lists.01.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <202205052327.RldmheYL-lkp@intel.com>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505033814.103256-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.18-rc5]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220505-114028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 107c948d1d3e61d10aee9d0f7c3d81bbee9842af
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220505/202205052327.RldmheYL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f08a35b9798572693a91c6a3d823ed9ae54ef688
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220505-114028
        git checkout f08a35b9798572693a91c6a3d823ed9ae54ef688
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/huge_memory.c: note: in included file (through include/linux/mm.h):
>> include/linux/huge_mm.h:272:43: sparse: sparse: marked inline, but without a definition
   mm/huge_memory.c: note: in included file:
>> include/linux/khugepaged.h:30:36: sparse: sparse: marked inline, but without a definition
   include/linux/khugepaged.h:31:38: sparse: sparse: marked inline, but without a definition
--
   mm/memory.c:1024:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1752:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1800:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2302:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2558:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2847:9: sparse: sparse: context imbalance in 'wp_page_copy' - different lock contexts for basic block
   mm/memory.c:3185:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3248:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c: note: in included file (through include/linux/mm.h):
>> include/linux/huge_mm.h:272:43: sparse: sparse: marked inline, but without a definition
>> include/linux/huge_mm.h:272:43: sparse: sparse: marked inline, but without a definition
--
   mm/shmem.c: note: in included file:
>> include/linux/khugepaged.h:30:36: sparse: sparse: marked inline, but without a definition
   include/linux/khugepaged.h:31:38: sparse: sparse: marked inline, but without a definition
>> include/linux/khugepaged.h:30:36: sparse: sparse: marked inline, but without a definition
   include/linux/khugepaged.h:31:38: sparse: sparse: marked inline, but without a definition

vim +272 include/linux/huge_mm.h

   263	
   264	static inline struct list_head *page_deferred_list(struct page *page)
   265	{
   266		/*
   267		 * Global or memcg deferred list in the second tail pages is
   268		 * occupied by compound_head.
   269		 */
   270		return &page[2].deferred_list;
   271	}
 > 272	inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma);
   273	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
