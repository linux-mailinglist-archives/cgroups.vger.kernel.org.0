Return-Path: <cgroups+bounces-6236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E854AA158C0
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 21:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380D53A92F6
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B021AA1E4;
	Fri, 17 Jan 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqp5+8YH"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929D1A2391
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147577; cv=none; b=ssLUwBzf3RKqE2Z6js0L1kwp3+lDVWi0pd4HIMC3jKt9Yy3dFg0O/z4yExjVjri1Lsf8I7pGTGYC5AEoKZU7wiom7bgPt0dFY3SPn04AN5dPVodKZObE4mlpnSpj+rKKMpaVkKxRg/C0CevyWWdeGd3jgDNR6PP0uuxDkaFF3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147577; c=relaxed/simple;
	bh=8N31mkICNMaZGX1xA/Vd/HyWcF58vG1N27H8FmDaDxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KJKlEp4dqt4h+FbaofObydQdKNE5/NkO8aDWNF5GEdY8+7QFqCfho+HdpexqfgP+BuHjKOJ+PSTR2O1WM8EwlN1ma220b7s0WVuQXXcOUwQnsTZHFz5W5RoBr3XLKUt8iNPlk/duFHQKVAIAvWYrMnH7ZDENbMrDM2iEhK0rzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqp5+8YH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737147575; x=1768683575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8N31mkICNMaZGX1xA/Vd/HyWcF58vG1N27H8FmDaDxs=;
  b=iqp5+8YHnsahptEM8uJxYwSRj7qjVOmmWqUoPCnxpuElot2b7il8ZLtp
   X3quLZA+UR+YUmlFp5boxQdVxc67Ye4kjVt9if5+QwfnWLiny5luKiIyl
   Grvzo/N4jPZBNSATjyF0ECFGVJzNdgwtsMXqvxrIyyQfZy0Yfi7HJHhJD
   vfD7NB/NRJFtrCFWhKtVkoUHDYYoUXsOJ+CcbXnrgRGenLMFMwsWXfS1E
   DE3GDfKzOPXru5XpYSV3HVR/adW4yRZ6KCCU+AdTZ22kmU7+AW4tVsaws
   2Y/FGIehm07hLikcK6UZ4tCfF2zv2VLPyE7lJimKRBrsE2UdoGslfpas/
   A==;
X-CSE-ConnectionGUID: 3otAW8mkT1C++rhi/p3C0g==
X-CSE-MsgGUID: +VWW4Lo0QhCusbD2K2yEkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37504476"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37504476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:59:35 -0800
X-CSE-ConnectionGUID: u6wRFbVRRMSF/VS3IZs4vw==
X-CSE-MsgGUID: +CodYcH1STuecpuxqTMMew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="105756177"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jan 2025 12:59:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYtRD-000ThO-0G;
	Fri, 17 Jan 2025 20:59:31 +0000
Date: Sat, 18 Jan 2025 04:59:29 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-next 5/5] kernel/cgroup/cpuset-v1.c:397:11: error:
 call to undeclared function 'cgroup_path_ns_locked'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202501180416.VoUpllWu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
head:   03a12b026323247a320495fed3719d39cffdbe9b
commit: 03a12b026323247a320495fed3719d39cffdbe9b [5/5] cgroup/cpuset: Move procfs cpuset attribute under cgroup-v1.c
config: powerpc64-randconfig-002-20250118 (https://download.01.org/0day-ci/archive/20250118/202501180416.VoUpllWu-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501180416.VoUpllWu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501180416.VoUpllWu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/cgroup/cpuset-v1.c:3:
   In file included from kernel/cgroup/cpuset-internal.h:6:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/cgroup/cpuset-v1.c:397:11: error: call to undeclared function 'cgroup_path_ns_locked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     397 |         retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
         |                  ^
   kernel/cgroup/cpuset-v1.c:397:11: note: did you mean 'cgroup_path_ns'?
   include/linux/cgroup.h:786:5: note: 'cgroup_path_ns' declared here
     786 | int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
         |     ^
   4 warnings and 1 error generated.


vim +/cgroup_path_ns_locked +397 kernel/cgroup/cpuset-v1.c

   375	
   376	#ifdef CONFIG_PROC_PID_CPUSET
   377	/*
   378	 * proc_cpuset_show()
   379	 *  - Print tasks cpuset path into seq_file.
   380	 *  - Used for /proc/<pid>/cpuset.
   381	 */
   382	int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
   383			     struct pid *pid, struct task_struct *tsk)
   384	{
   385		char *buf;
   386		struct cgroup_subsys_state *css;
   387		int retval;
   388	
   389		retval = -ENOMEM;
   390		buf = kmalloc(PATH_MAX, GFP_KERNEL);
   391		if (!buf)
   392			goto out;
   393	
   394		rcu_read_lock();
   395		spin_lock_irq(&css_set_lock);
   396		css = task_css(tsk, cpuset_cgrp_id);
 > 397		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
   398					       current->nsproxy->cgroup_ns);
   399		spin_unlock_irq(&css_set_lock);
   400		rcu_read_unlock();
   401	
   402		if (retval == -E2BIG)
   403			retval = -ENAMETOOLONG;
   404		if (retval < 0)
   405			goto out_free;
   406		seq_puts(m, buf);
   407		seq_putc(m, '\n');
   408		retval = 0;
   409	out_free:
   410		kfree(buf);
   411	out:
   412		return retval;
   413	}
   414	#endif /* CONFIG_PROC_PID_CPUSET */
   415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

