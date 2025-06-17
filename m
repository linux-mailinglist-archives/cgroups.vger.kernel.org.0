Return-Path: <cgroups+bounces-8560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0DDADCD3F
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FE1164207
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CC2E719F;
	Tue, 17 Jun 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9okf8T8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97C4A3E;
	Tue, 17 Jun 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167158; cv=none; b=g+WOqKVOUnucQlaek8kUHmfL/7Gc84l73XY5Ap7H7ttRrm+s718cBRtWr52spvqMBn+Gs74grNaYUgAfjieewrW9gnPmhdKKxodCVO4EGNtV6jevZd4WsKmor3r6fBhXXWfMqopNsSQJb2fz8023sMmf3F8tIGxYLVEtx0KwZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167158; c=relaxed/simple;
	bh=eh8viEGAV28ATzr3c9fmVwCL5U5uu4w7at/swAkPuFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV9ZcjtGFY4Q+I2nk12OmUFWWoiUudA432UUa0Cu/or1rINXyLrsfG+zlOevhtzFEvOGTzd9Jnppb4wjIKL5zcRXFqrH19Qb44pgYCwQ1SWosp3QZkY61BFVUlzeQEpy5naZre2ldAoedqArXQkbUkxD8jlTCJYKtLIG3z5in+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9okf8T8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750167156; x=1781703156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eh8viEGAV28ATzr3c9fmVwCL5U5uu4w7at/swAkPuFM=;
  b=l9okf8T8KSHpA8qPE+VK2ujQctKBgpvKgRMgsrPPZgYPrlIVTB/i4/HF
   8LnX6xf5szjHFuHy1uj8du7gDhf6W75QUeZ0IxBw/ZYtPNDcX6gmKyyJk
   oVmOmf1peB9F24q3x91bocGvIIQ3Hn36xjJsR8wF4FpMm827c33Kk+49X
   GXiuyF2LT6g8QeylquEdpyREu+KAAaaeav9rAp6jLixrYiRkeH9tDM/FF
   73O2jSuVaV7vAmFGqFqFkdamcc9EPH+vWTbzqG7axn//Lb25RnojUHDyT
   MZ17MhpoouD3W90n5VNXgikFDe4JR1lZfrYM+36ytk24NkvY5TV3tye0w
   A==;
X-CSE-ConnectionGUID: HEqu41+6S5yedCQQIZyCGQ==
X-CSE-MsgGUID: qJpVg4GtTxqC7p11emaoZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56154387"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="56154387"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 06:32:36 -0700
X-CSE-ConnectionGUID: Bl1IqfEQTzKSNnUl84zDtQ==
X-CSE-MsgGUID: FHLnVg/iQkymF4EeZibAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149147833"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Jun 2025 06:32:34 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRWQR-000G1q-36;
	Tue, 17 Jun 2025 13:32:31 +0000
Date: Tue, 17 Jun 2025 21:32:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <202506172158.OEJ5qjT6-lkp@intel.com>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>

Hi Bertrand,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on linus/master v6.16-rc2 next-20250617]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bertrand-Wlodarczyk/cgroup-rstat-change-cgroup_base_stat-to-atomic/20250617-183242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250617102644.752201-2-bertrand.wlodarczyk%40intel.com
patch subject: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
config: arc-randconfig-001-20250617 (https://download.01.org/0day-ci/archive/20250617/202506172158.OEJ5qjT6-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506172158.OEJ5qjT6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506172158.OEJ5qjT6-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/rstat.c: In function 'css_rstat_init':
   kernel/cgroup/rstat.c:415:55: warning: variable 'rstatbc' set but not used [-Wunused-but-set-variable]
     415 |                         struct cgroup_rstat_base_cpu *rstatbc;
         |                                                       ^~~~~~~
   kernel/cgroup/rstat.c: In function 'root_cgroup_cputime':
>> kernel/cgroup/rstat.c:629:42: error: passing argument 2 of 'atomic64_add' from incompatible pointer type [-Werror=incompatible-pointer-types]
     629 |                 atomic64_add(sys + user, &cputime->sum_exec_runtime);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:67,
                    from include/linux/thread_info.h:27,
                    from include/linux/sched.h:14,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   include/linux/atomic/atomic-instrumented.h:1680:33: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
    1680 | atomic64_add(s64 i, atomic64_t *v)
         |                     ~~~~~~~~~~~~^
   In file included from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:2209,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   kernel/cgroup/rstat.c: In function 'cgroup_base_stat_cputime_show':
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:677:9: note: in expansion of macro 'do_div'
     677 |         do_div(utime, NSEC_PER_USEC);
         |         ^~~~~~
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:681:9: note: in expansion of macro 'do_div'
     681 |         do_div(stime, NSEC_PER_USEC);
         |         ^~~~~~
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:685:9: note: in expansion of macro 'do_div'
     685 |         do_div(ntime, NSEC_PER_USEC);
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +/atomic64_add +629 kernel/cgroup/rstat.c

   599	
   600	/*
   601	 * compute the cputime for the root cgroup by getting the per cpu data
   602	 * at a global level, then categorizing the fields in a manner consistent
   603	 * with how it is done by __cgroup_account_cputime_field for each bit of
   604	 * cpu time attributed to a cgroup.
   605	 */
   606	static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
   607	{
   608		struct atomic_task_cputime *cputime = &bstat->cputime;
   609		int i;
   610	
   611		memset(bstat, 0, sizeof(*bstat));
   612		for_each_possible_cpu(i) {
   613			struct kernel_cpustat kcpustat;
   614			u64 *cpustat = kcpustat.cpustat;
   615			u64 user = 0;
   616			u64 sys = 0;
   617	
   618			kcpustat_cpu_fetch(&kcpustat, i);
   619	
   620			user += cpustat[CPUTIME_USER];
   621			user += cpustat[CPUTIME_NICE];
   622			atomic64_add(user, &cputime->utime);
   623	
   624			sys += cpustat[CPUTIME_SYSTEM];
   625			sys += cpustat[CPUTIME_IRQ];
   626			sys += cpustat[CPUTIME_SOFTIRQ];
   627			atomic64_add(sys, &cputime->stime);
   628	
 > 629			atomic64_add(sys + user, &cputime->sum_exec_runtime);
   630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

