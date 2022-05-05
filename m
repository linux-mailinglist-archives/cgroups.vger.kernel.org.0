Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1E51C0D9
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379784AbiEENgs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379779AbiEENg3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 09:36:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209256FBD;
        Thu,  5 May 2022 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651757531; x=1683293531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0n9xKziNJR4TEkk9TsrLeTOHao554U8zzlo+fCxG4Ow=;
  b=HUV3jhWcDBoqOh5Gdqgx7j6ITYlNWOhwFs2Pz03YC9FfbkWBqUM/IMHd
   I8d5FhPJB/w2gX9wFIhD4si6lJv2JqdWwWzO12PvENxAcVbSCfdfF33X/
   f1zDWgj6WzoQ2YkQaMVhJHWr+YAYLTObpFLaYUT8lFw+M1qZZ3OeeRnie
   0m2DbKL5jkKBX5c7zXK/1GR6hJPR8gw4zKpea7/PBF5IbjGnsYVAgY8bA
   hwxI2DePHP+kjJTxfY3BfEJMAkSc8LQGwpr5rjKytdZACHFdw3j4dPcGm
   FjQojIZD7bUpSvF/Ka+X12bXXTBxdQllAn0d3ceF5ynRdSTbralTwaJuZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250093963"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="250093963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 06:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="537334824"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2022 06:32:07 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmbaQ-000CQy-Eo;
        Thu, 05 May 2022 13:32:06 +0000
Date:   Thu, 5 May 2022 21:31:19 +0800
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
Message-ID: <202205052101.TsTEcZoc-lkp@intel.com>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505033814.103256-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220505/202205052101.TsTEcZoc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f08a35b9798572693a91c6a3d823ed9ae54ef688
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-memcg-support-control-THP-behaviour-in-cgroup/20220505-114028
        git checkout f08a35b9798572693a91c6a3d823ed9ae54ef688
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: mm/memory.o: in function `__handle_mm_fault':
>> memory.c:(.text+0xc6f9): undefined reference to `__transparent_hugepage_enabled'
>> ld: memory.c:(.text+0xc751): undefined reference to `__transparent_hugepage_enabled'
   ld: mm/huge_memory.o: in function `transparent_hugepage_active':
>> huge_memory.c:(.text+0x6351): undefined reference to `__transparent_hugepage_enabled'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
