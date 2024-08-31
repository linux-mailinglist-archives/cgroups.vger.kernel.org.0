Return-Path: <cgroups+bounces-4655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC4967061
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23101C21EFB
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23520175D45;
	Sat, 31 Aug 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ93egrr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5216F0F0
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725093597; cv=none; b=addrDLpVn2qru1tjxd0XrC+Mv8sncB8HDRR+A2l68Xc3l9BDgB9nDus1zuWZr1xtI6jYaeslLrq6Av1Yc/0tVc9NgI37zkwssJOQ7fh7zXrHrDYnoX1PeKIh7FwTy88xaOo+8Gx1bNQeuS9t6G+KxHRJ+jC3HQAsnmNVe5xr3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725093597; c=relaxed/simple;
	bh=vVR49KnwmnGRZgZYBA5+9YsGu1guxGNopWUanH/op4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4bJWJuJ+iGHTXQh+yPru5xq/Ky9a0mvI6nHYP7beezxoupaFIjFAkCzbxYT6cWf/Lo5D3Q3R65SQtHXgIvkkaz1vdKjxZeJTIxy1xbDiPkcURZzTqC7mLuY02WTMEp+thlGa7hhFWdLojLAqzVbExqgsJMQVDs8R7mvm0gg72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ93egrr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725093596; x=1756629596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vVR49KnwmnGRZgZYBA5+9YsGu1guxGNopWUanH/op4Q=;
  b=EZ93egrr+2Zuf34R4s/Ue19sF3tc/Rl9eor4jyBsoztctHOWOx/pO6vD
   5KrJ9LT+s0w4o6PKb8PojYIDcMqOq+0/Bk/0dmbCEFvJQYydAsTZK8hz6
   W56QG3k6mTiAa4C4yAxRPTdrnT7LJt1sYkWReeENcvAr9RWVEggiuDN7h
   EIg+3Bkap/JNfoqXqdCGaRz6dPFv7cBEFSlwoipNW1+hI5TE8ZdnpIaoK
   QFYVRe0zwAhcdrHi0szFIozYk43CJBxFrjKPW5fWN2VzJGC1Kqm9lIdng
   UhO4vujdTr5XxyV50auHpinPnPWQx5W35eJ4I+Ea6wOTr+LknS0w+NyEK
   Q==;
X-CSE-ConnectionGUID: HfkmkR6eRsi/OwytP3AtxA==
X-CSE-MsgGUID: Q19rJzfZTpOFhsrCUfwaDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23872634"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23872634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:39:53 -0700
X-CSE-ConnectionGUID: q9Ym/l4TRoWSTTaTjAxulA==
X-CSE-MsgGUID: zrWPZfBDTp29bEUqBk512g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68529407"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 31 Aug 2024 01:39:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJeA-0002TP-08;
	Sat, 31 Aug 2024 08:39:50 +0000
Date: Sat, 31 Aug 2024 16:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:test 23/31] kernel/cgroup/cpuset-v1.c:163:2: error: call
 to undeclared function 'cpus_read_lock'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202408311651.vwwxEpKn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test
head:   a5ab7b05a3c825f23d74106f3304de7d024cff8a
commit: dd46bd00ab4c00f6126794c6b52fbc87a2c5c389 [23/31] cgroup/cpuset: move relax_domain_level to cpuset-v1.c
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240831/202408311651.vwwxEpKn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 46fe36a4295f05d5d3731762e31fc4e6e99863e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311651.vwwxEpKn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311651.vwwxEpKn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/cgroup/cpuset-v1.c:3:
   In file included from kernel/cgroup/cpuset-internal.h:9:
   In file included from include/linux/cpuset.h:17:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/cgroup/cpuset-v1.c:163:2: error: call to undeclared function 'cpus_read_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     163 |         cpus_read_lock();
         |         ^
   kernel/cgroup/cpuset-v1.c:163:2: note: did you mean 'rcu_read_lock'?
   include/linux/rcupdate.h:834:29: note: 'rcu_read_lock' declared here
     834 | static __always_inline void rcu_read_lock(void)
         |                             ^
>> kernel/cgroup/cpuset-v1.c:178:2: error: call to undeclared function 'cpus_read_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     178 |         cpus_read_unlock();
         |         ^
   5 warnings and 2 errors generated.


vim +/cpus_read_lock +163 kernel/cgroup/cpuset-v1.c

   155	
   156	int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
   157				    s64 val)
   158	{
   159		struct cpuset *cs = css_cs(css);
   160		cpuset_filetype_t type = cft->private;
   161		int retval = -ENODEV;
   162	
 > 163		cpus_read_lock();
   164		cpuset_lock();
   165		if (!is_cpuset_online(cs))
   166			goto out_unlock;
   167	
   168		switch (type) {
   169		case FILE_SCHED_RELAX_DOMAIN_LEVEL:
   170			retval = update_relax_domain_level(cs, val);
   171			break;
   172		default:
   173			retval = -EINVAL;
   174			break;
   175		}
   176	out_unlock:
   177		cpuset_unlock();
 > 178		cpus_read_unlock();
   179		return retval;
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

