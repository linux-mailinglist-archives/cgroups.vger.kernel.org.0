Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8D532D07
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiEXPNR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiEXPNQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 11:13:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD265FF10;
        Tue, 24 May 2022 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653405195; x=1684941195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jg1seA0b2qfEGPEhi40Q5NR3xfGQVSWmwk8f0MnVPS0=;
  b=fWEieP5FkcOTC1z3dnEqaPpQ/DrBTX8Sjw9munMn9tZ6CInfHFh/mWfT
   yVUaLJLNvYPZAKc4ZuB5GIYXj6IhnJNqoOpkSgJ6f4M34dxkYy1bOqyH6
   VVg+OOa+hR4Nt9/yHyOjF9tND67QWS2mQUm+F0e0zDg8vguy97FM3vSxY
   zAD0Xao1eEFH8jRuU6ZKqOpwSTMGc2/bkoqToWiNiD8W4FfOs6Rt3L0PC
   v0a/x2J32/NXuFkMXhVGITKE8smkzS/gMu01vTeLa4ROxlNDDaDEgLVEy
   rynZxaAcUrOAIeLxTM+Oqp9qcE/KxotdvRB9CbFNtyqeXXAXoVRGVTm4p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="253430707"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="253430707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="577926540"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2022 08:13:13 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntWDg-0002AY-C8;
        Tue, 24 May 2022 15:13:12 +0000
Date:   Tue, 24 May 2022 23:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        Hezhongkun <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] mm: memcontrol: add the mempolicy interface for cgroup
 v2.
Message-ID: <202205242316.8f8rvh3s-lkp@intel.com>
References: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi hezhongkun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18 next-20220524]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/hezhongkun/mm-memcontrol-add-the-mempolicy-interface-for-cgroup-v2/20220524-183922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 143a6252e1b8ab424b4b293512a97cca7295c182
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220524/202205242316.8f8rvh3s-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6adb0a02c27c8811bee9783451ee25155baf490e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hezhongkun/mm-memcontrol-add-the-mempolicy-interface-for-cgroup-v2/20220524-183922
        git checkout 6adb0a02c27c8811bee9783451ee25155baf490e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/mempolicy.c:179:19: warning: no previous prototype for function 'get_cgrp_or_task_policy' [-Wmissing-prototypes]
   struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
                     ^
   mm/mempolicy.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
   ^
   static 
   1 warning generated.


vim +/get_cgrp_or_task_policy +179 mm/mempolicy.c

   178	
 > 179	struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
   180	{
   181		struct mempolicy *pol;
   182		struct mem_cgroup *memcg = mem_cgroup_from_task(p);
   183	
   184		pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
   185		return pol;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
