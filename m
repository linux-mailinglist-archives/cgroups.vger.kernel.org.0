Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3079D63D206
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 10:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiK3Jd1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 04:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiK3JdI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 04:33:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D7C6F807;
        Wed, 30 Nov 2022 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669800728; x=1701336728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8NMhMg/GlHFp78NGqrzlQoHc6LRa4M6Aj6rLosKW8/M=;
  b=Xt6wZuN9weV4u1lEKxzg5ryEhF1a9oALfPtQOEWYuaAPJfIaVk3JHScF
   1J1+EyBd7LDRmMcjeggoM1Sk3FBrHtCM0m+WZhjcx6Tv693LjuhlBXa14
   r7xL8xeU7GsXXAxmrgSBGIrZj8aPwedDq5UdziR/nn4dI1Y4veOS9sOp2
   s0mLP8ZXRDMoqpPgd4UIQukBxZGKTW7ujeooWRfD7ioE5NEBY9mpEXtZj
   xN+Yr93UL/8zCjK9jn9VJDlUtiQvJ4dxmhd48CkbULEhH1US+w9TARaT5
   iB2dpFGQUrm15Wp/NEfQk3HePOAzeC+RWC+uMs4fZM2FbXBXWTAsWMr4Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379630512"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379630512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637930854"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="637930854"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2022 01:31:58 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0JRe-000Aw6-0Z;
        Wed, 30 Nov 2022 09:31:58 +0000
Date:   Wed, 30 Nov 2022 17:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     chengkaitao <pilgrimtao@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com
Cc:     oe-kbuild-all@lists.linux.dev, cgel.zte@gmail.com,
        ran.xiaokai@zte.com.cn, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        pilgrimtao@gmail.com, haolee.swjtu@gmail.com, yuzhao@google.com,
        willy@infradead.org, vasily.averin@linux.dev, vbabka@suse.cz,
        surenb@google.com, sfr@canb.auug.org.au, mcgrof@kernel.org,
        sujiaxun@uniontech.com, feng.tang@intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Message-ID: <202211301736.iH7A4KHf-lkp@intel.com>
References: <20221130070158.44221-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GTyUKzE12jR0F/7I"
Content-Disposition: inline
In-Reply-To: <20221130070158.44221-1-chengkaitao@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--GTyUKzE12jR0F/7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi chengkaitao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/chengkaitao/mm-memcontrol-protect-the-memory-in-cgroup-from-being-oom-killed/20221130-150440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20221130070158.44221-1-chengkaitao%40didiglobal.com
patch subject: [PATCH] mm: memcontrol: protect the memory in cgroup from being oom killed
config: i386-tinyconfig
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d2e2f936cb254b6976abddb53b9f46dfc9c9a134
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review chengkaitao/mm-memcontrol-protect-the-memory-in-cgroup-from-being-oom-killed/20221130-150440
        git checkout d2e2f936cb254b6976abddb53b9f46dfc9c9a134
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   ld: init/do_mounts.o: in function `update_parent_oom_protection':
>> do_mounts.c:(.text+0x5): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: init/do_mounts.o: in function `get_task_eoom_protect':
>> do_mounts.c:(.text+0x6): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: init/do_mounts.o: in function `is_root_oom_protect':
>> do_mounts.c:(.text+0x9): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: init/do_mounts.o: in function `mem_cgroup_scan_tasks_update_eoom':
>> do_mounts.c:(.text+0xc): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `update_parent_oom_protection':
   vma.c:(.text+0x1db): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `get_task_eoom_protect':
   vma.c:(.text+0x1dc): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `is_root_oom_protect':
   vma.c:(.text+0x1df): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `mem_cgroup_scan_tasks_update_eoom':
   vma.c:(.text+0x1e2): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/kernel/setup.o: in function `update_parent_oom_protection':
   setup.c:(.text+0x3): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/setup.o: in function `get_task_eoom_protect':
   setup.c:(.text+0x4): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/kernel/setup.o: in function `is_root_oom_protect':
   setup.c:(.text+0x7): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/kernel/setup.o: in function `mem_cgroup_scan_tasks_update_eoom':
   setup.c:(.text+0xa): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/kernel/e820.o: in function `update_parent_oom_protection':
   e820.c:(.text+0x134): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/e820.o: in function `get_task_eoom_protect':
   e820.c:(.text+0x135): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/kernel/e820.o: in function `is_root_oom_protect':
   e820.c:(.text+0x138): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/kernel/e820.o: in function `mem_cgroup_scan_tasks_update_eoom':
   e820.c:(.text+0x13b): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/kernel/cpu/umwait.o: in function `update_parent_oom_protection':
   umwait.c:(.text+0x2d): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/cpu/umwait.o: in function `get_task_eoom_protect':
   umwait.c:(.text+0x2e): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/kernel/cpu/umwait.o: in function `is_root_oom_protect':
   umwait.c:(.text+0x31): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/kernel/cpu/umwait.o: in function `mem_cgroup_scan_tasks_update_eoom':
   umwait.c:(.text+0x34): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/kernel/reboot.o: in function `update_parent_oom_protection':
   reboot.c:(.text+0x1a): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/reboot.o: in function `get_task_eoom_protect':
   reboot.c:(.text+0x1b): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/kernel/reboot.o: in function `is_root_oom_protect':
   reboot.c:(.text+0x1e): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/kernel/reboot.o: in function `mem_cgroup_scan_tasks_update_eoom':
   reboot.c:(.text+0x21): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/init.o: in function `update_parent_oom_protection':
   init.c:(.text+0x0): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/init.o: in function `get_task_eoom_protect':
   init.c:(.text+0x1): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/init.o: in function `is_root_oom_protect':
   init.c:(.text+0x4): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/init.o: in function `mem_cgroup_scan_tasks_update_eoom':
   init.c:(.text+0x7): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/init_32.o: in function `update_parent_oom_protection':
   init_32.c:(.text+0x0): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/init_32.o: in function `get_task_eoom_protect':
   init_32.c:(.text+0x1): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/init_32.o: in function `is_root_oom_protect':
   init_32.c:(.text+0x4): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/init_32.o: in function `mem_cgroup_scan_tasks_update_eoom':
   init_32.c:(.text+0x7): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/fault.o: in function `update_parent_oom_protection':
   fault.c:(.text+0x8cd): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/fault.o: in function `get_task_eoom_protect':
   fault.c:(.text+0x8ce): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/fault.o: in function `is_root_oom_protect':
   fault.c:(.text+0x8d1): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/fault.o: in function `mem_cgroup_scan_tasks_update_eoom':
   fault.c:(.text+0x8d4): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/ioremap.o: in function `update_parent_oom_protection':
   ioremap.c:(.text+0x25c): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/ioremap.o: in function `get_task_eoom_protect':
   ioremap.c:(.text+0x25d): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/ioremap.o: in function `is_root_oom_protect':
   ioremap.c:(.text+0x260): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/ioremap.o: in function `mem_cgroup_scan_tasks_update_eoom':
   ioremap.c:(.text+0x263): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/pgtable.o: in function `update_parent_oom_protection':
   pgtable.c:(.text+0x4): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/pgtable.o: in function `get_task_eoom_protect':
   pgtable.c:(.text+0x5): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/pgtable.o: in function `is_root_oom_protect':
   pgtable.c:(.text+0x8): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/pgtable.o: in function `mem_cgroup_scan_tasks_update_eoom':
   pgtable.c:(.text+0xb): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: arch/x86/mm/pgtable_32.o: in function `update_parent_oom_protection':
   pgtable_32.c:(.text+0x0): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/pgtable_32.o: in function `get_task_eoom_protect':
   pgtable_32.c:(.text+0x1): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: arch/x86/mm/pgtable_32.o: in function `is_root_oom_protect':
   pgtable_32.c:(.text+0x4): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: arch/x86/mm/pgtable_32.o: in function `mem_cgroup_scan_tasks_update_eoom':
   pgtable_32.c:(.text+0x7): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: kernel/fork.o: in function `update_parent_oom_protection':
   fork.c:(.text+0x5bb): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/fork.o: in function `get_task_eoom_protect':
   fork.c:(.text+0x5bc): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
   ld: kernel/fork.o: in function `is_root_oom_protect':
   fork.c:(.text+0x5bf): multiple definition of `is_root_oom_protect'; init/main.o:main.c:(.text+0x36): first defined here
   ld: kernel/fork.o: in function `mem_cgroup_scan_tasks_update_eoom':
   fork.c:(.text+0x5c2): multiple definition of `mem_cgroup_scan_tasks_update_eoom'; init/main.o:main.c:(.text+0x39): first defined here
   ld: kernel/cpu.o: in function `update_parent_oom_protection':
   cpu.c:(.text+0x161): multiple definition of `update_parent_oom_protection'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/cpu.o: in function `get_task_eoom_protect':
   cpu.c:(.text+0x162): multiple definition of `get_task_eoom_protect'; init/main.o:main.c:(.text+0x33): first defined here
--
   In file included from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/rmap.h:12,
                    from init/main.c:62:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:775:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     775 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/swap.h:9,
                    from mm/shmem.c:36:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4148:13: warning: no previous prototype for 'shmem_init' [-Wmissing-prototypes]
    4148 | void __init shmem_init(void)
         |             ^~~~~~~~~~
   mm/shmem.c:4156:5: warning: no previous prototype for 'shmem_unuse' [-Wmissing-prototypes]
    4156 | int shmem_unuse(unsigned int type)
         |     ^~~~~~~~~~~
   mm/shmem.c:4161:5: warning: no previous prototype for 'shmem_lock' [-Wmissing-prototypes]
    4161 | int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
         |     ^~~~~~~~~~
   mm/shmem.c:4166:6: warning: no previous prototype for 'shmem_unlock_mapping' [-Wmissing-prototypes]
    4166 | void shmem_unlock_mapping(struct address_space *mapping)
         |      ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4171:15: warning: no previous prototype for 'shmem_get_unmapped_area' [-Wmissing-prototypes]
    4171 | unsigned long shmem_get_unmapped_area(struct file *file,
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4179:6: warning: no previous prototype for 'shmem_truncate_range' [-Wmissing-prototypes]
    4179 | void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
         |      ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4239:14: warning: no previous prototype for 'shmem_kernel_file_setup' [-Wmissing-prototypes]
    4239 | struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4250:14: warning: no previous prototype for 'shmem_file_setup' [-Wmissing-prototypes]
    4250 | struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
         |              ^~~~~~~~~~~~~~~~
   mm/shmem.c:4263:14: warning: no previous prototype for 'shmem_file_setup_with_mnt' [-Wmissing-prototypes]
    4263 | struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4274:5: warning: no previous prototype for 'shmem_zero_setup' [-Wmissing-prototypes]
    4274 | int shmem_zero_setup(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~
   mm/shmem.c:4312:14: warning: no previous prototype for 'shmem_read_mapping_page_gfp' [-Wmissing-prototypes]
    4312 | struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/pipe.c:26:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:757:15: warning: no previous prototype for 'account_pipe_buffers' [-Wmissing-prototypes]
     757 | unsigned long account_pipe_buffers(struct user_struct *user,
         |               ^~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:763:6: warning: no previous prototype for 'too_many_pipe_buffers_soft' [-Wmissing-prototypes]
     763 | bool too_many_pipe_buffers_soft(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:770:6: warning: no previous prototype for 'too_many_pipe_buffers_hard' [-Wmissing-prototypes]
     770 | bool too_many_pipe_buffers_hard(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:777:6: warning: no previous prototype for 'pipe_is_unprivileged_user' [-Wmissing-prototypes]
     777 | bool pipe_is_unprivileged_user(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:1253:5: warning: no previous prototype for 'pipe_resize_ring' [-Wmissing-prototypes]
    1253 | int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
         |     ^~~~~~~~~~~~~~~~
--
   In file included from include/net/sock.h:53,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:93,
                    from include/net/addrconf.h:52,
                    from lib/vsprintf.c:40:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1685:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1685 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/swap.h:9,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:8,
                    from arch/x86/entry/vdso/vma.c:24:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/entry/vdso/vma.c:35:19: warning: no previous prototype for 'arch_get_vdso_data' [-Wmissing-prototypes]
      35 | struct vdso_data *arch_get_vdso_data(void *vvar_page)
         |                   ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from kernel/sched/build_policy.c:28:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:45:
   kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]
       9 | static const u64 max_rt_runtime = MAX_BW;
         |                  ^~~~~~~~~~~~~~
--
   In file included from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/memcontrol.h:1228:6: warning: no previous prototype for 'update_parent_oom_protection' [-Wmissing-prototypes]
    1228 | void update_parent_oom_protection(struct mem_cgroup *root,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1243:15: warning: no previous prototype for 'get_task_eoom_protect' [-Wmissing-prototypes]
    1243 | unsigned long get_task_eoom_protect(struct task_struct *p, long points)
         |               ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1248:6: warning: no previous prototype for 'is_root_oom_protect' [-Wmissing-prototypes]
    1248 | bool is_root_oom_protect(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> include/linux/memcontrol.h:1372:5: warning: no previous prototype for 'mem_cgroup_scan_tasks_update_eoom' [-Wmissing-prototypes]
    1372 | int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--GTyUKzE12jR0F/7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.1.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
# CONFIG_CGROUPS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
# CONFIG_TIMERFD is not set
# CONFIG_EVENTFD is not set
# CONFIG_SHMEM is not set
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
# CONFIG_KALLSYMS is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
# CONFIG_X86_FEATURE_NAMES is not set
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
# CONFIG_HPET_TIMER is not set
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
# CONFIG_X86_PAE is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_SCRIPT is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set

#
# GUP_TEST needs to have DEBUG_FS enabled
#
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# CONFIG_SECRETMEM is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
# CONFIG_PCI is not set
# CONFIG_PCCARD is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
# CONFIG_FW_LOADER is not set
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_SRAM is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ECHO is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_MACINTOSH_DRIVERS is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
# CONFIG_I2C is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_MADERA is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TQMX86 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support
# end of Graphics support

# CONFIG_SOUND is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_COMMON_CLK is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
# CONFIG_NVMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_SYSFS is not set
# CONFIG_CONFIGFS_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NLS is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITYFS is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# end of Crypto library routines

# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC64_ROCKSOFT is not set
# CONFIG_CRC_ITU_T is not set
# CONFIG_CRC32 is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
# CONFIG_XZ_DEC is not set
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_IRQ_POLL is not set
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_STACKWALK=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_FS is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
# CONFIG_STACKTRACE is not set
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
# CONFIG_X86_VERBOSE_BOOTUP is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--GTyUKzE12jR0F/7I--
