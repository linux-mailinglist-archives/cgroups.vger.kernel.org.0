Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE351BFCD
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiEEMyD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 08:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiEEMxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 08:53:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D6187;
        Thu,  5 May 2022 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651755013; x=1683291013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A9PXcXkJKXOiPlbiJL9+S1g3O2eDE4FkjAv8/9Dq67g=;
  b=m7jai3T36OY75WFYibDaVdjr0qQkh5wOl6MtJyrjDpy0GNGycZEsFOar
   /dBOLGgUexM0hUngYQfl9cz6/ws1xamE+ETcMHaZdDaU7XeuFVbi385in
   GcLS5oPlMaUrh/BeQZ0jHL6aiLfuWPorXuJsTCB+B1/M3SVRCzv6DeIPY
   gD4rOcg+eS7Oryj9kn7ZA36g2KNTCCJvbHw2OL40aA5fZMJH0F2D27VIt
   9agn6HqRXoc5OSFpNwv3shpzmtS5Zsc8HUEKscCfi/s5SQFA4Fr+iwTeH
   qErsDc1w0/Gh/74GnZiDhgPforyovwM4+dW2/lzhprO/K6mWKiT7AzhZk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267693568"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="267693568"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="585302810"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2022 05:50:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmavn-000CPo-Ur;
        Thu, 05 May 2022 12:50:07 +0000
Date:   Thu, 5 May 2022 20:49:47 +0800
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
Message-ID: <202205052006.qFYTjcyt-lkp@intel.com>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505033814.103256-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.18-rc5 next-20220505]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220505-114028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 107c948d1d3e61d10aee9d0f7c3d81bbee9842af
config: mips-decstation_64_defconfig (https://download.01.org/0day-ci/archive/20220505/202205052006.qFYTjcyt-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f08a35b9798572693a91c6a3d823ed9ae54ef688
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220505-114028
        git checkout f08a35b9798572693a91c6a3d823ed9ae54ef688
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64el-linux-ld: mm/memory.o: in function `__handle_mm_fault':
   memory.c:(.text+0x60a8): undefined reference to `__transparent_hugepage_enabled'
>> mips64el-linux-ld: memory.c:(.text+0x6108): undefined reference to `__transparent_hugepage_enabled'
   mips64el-linux-ld: mm/huge_memory.o: in function `transparent_hugepage_active':
   huge_memory.c:(.text+0x21e4): undefined reference to `__transparent_hugepage_enabled'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
