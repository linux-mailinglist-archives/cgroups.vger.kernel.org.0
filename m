Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9F51DA88
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442219AbiEFOeI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442195AbiEFOdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 10:33:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B3D68FA3;
        Fri,  6 May 2022 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651847410; x=1683383410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3bQs46ARc9z6IxvGQKAIeVw9c66t2zrtmGP1N90Tss=;
  b=kIlxcGKBxmL8XxzICY8ODoqt39SOIU1lTJf2fwm3FuIJVE0oooGDznnO
   oWtjwc5d1fEMNMC6SPePgk5d6lCIx9KIE0Dh49E+yWN9g5AUCupasuxjD
   w1U76aLwEYMckJcdklun//fIRSnHkqyHTcIujFCj0gLkHg3kiIkIui/kN
   6YIZ8CbwweVEpGO/m6Sg1uUyQCH9euRI7VjJJZtpJ5vUqctcRaDxbgzvG
   e5Kml5gQdYGcPBC5EZlam1VF98PXcImhSxP+FaU5WT1TYZudx6c1iD5s4
   8GFKmLe/M4qP6DO1WmaLv4qgHRq9uq0GZ6UfgRxMJMx5eDgRbuqnooz/i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268376273"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268376273"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 07:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665498808"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2022 07:30:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmyy4-000DY8-89;
        Fri, 06 May 2022 14:30:04 +0000
Date:   Fri, 6 May 2022 22:29:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        willy@infradead.org, shy828301@gmail.com
Cc:     kbuild-all@lists.01.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, hughd@google.com, songmuchun@bytedance.com,
        surenb@google.com, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        william.kucharski@oracle.com, peterx@redhat.com,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v2] mm/memcg: support control THP behaviour in cgroup
Message-ID: <202205062206.5pPA18rP-lkp@intel.com>
References: <20220506031804.437642-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506031804.437642-1-yang.yang29@zte.com.cn>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linux/master linus/master v5.18-rc5 next-20220506]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220506-112100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: s390-randconfig-r013-20220505 (https://download.01.org/0day-ci/archive/20220506/202205062206.5pPA18rP-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/01b750c350f3c12ca3908e94dc4447041ac9d89b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220506-112100
        git checkout 01b750c350f3c12ca3908e94dc4447041ac9d89b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/shmem.o: in function `shmem_zero_setup':
   shmem.c:(.text+0x380): undefined reference to `khugepaged_always'
>> s390-linux-ld: shmem.c:(.text+0x3f2): undefined reference to `khugepaged_req_madv'
   s390-linux-ld: mm/huge_memory.o: in function `do_huge_pmd_anonymous_page':
>> huge_memory.c:(.text+0x3d9c): undefined reference to `khugepaged_always'
>> s390-linux-ld: huge_memory.c:(.text+0x3e2a): undefined reference to `khugepaged_req_madv'
   s390-linux-ld: mm/khugepaged.o: in function `set_recommended_min_free_kbytes':
   khugepaged.c:(.text+0x1d06): undefined reference to `khugepaged_enabled'
   s390-linux-ld: mm/khugepaged.o: in function `hugepage_vma_check.part.0':
   khugepaged.c:(.text+0x24c4): undefined reference to `khugepaged_always'
   s390-linux-ld: mm/khugepaged.o: in function `khugepaged_wait_work':
   khugepaged.c:(.text+0x2da8): undefined reference to `khugepaged_enabled'
>> s390-linux-ld: khugepaged.c:(.text+0x2e94): undefined reference to `khugepaged_enabled'
   s390-linux-ld: mm/khugepaged.o: in function `khugepaged_do_scan':
   khugepaged.c:(.text+0x46e8): undefined reference to `khugepaged_enabled'
   s390-linux-ld: khugepaged.c:(.text+0x482a): undefined reference to `khugepaged_enabled'
   s390-linux-ld: mm/khugepaged.o: in function `khugepaged_enter_vma_merge':
   khugepaged.c:(.text+0x4bb2): undefined reference to `khugepaged_always'
>> s390-linux-ld: khugepaged.c:(.text+0x4c1a): undefined reference to `khugepaged_req_madv'
   s390-linux-ld: mm/khugepaged.o: in function `start_stop_khugepaged':
   khugepaged.c:(.text+0x4eb6): undefined reference to `khugepaged_enabled'
   s390-linux-ld: mm/khugepaged.o: in function `khugepaged_min_free_kbytes_update':
   khugepaged.c:(.text+0x5066): undefined reference to `khugepaged_enabled'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
