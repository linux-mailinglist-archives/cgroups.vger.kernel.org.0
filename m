Return-Path: <cgroups+bounces-8269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A2ABD948
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E020D1887B69
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640D241CBA;
	Tue, 20 May 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDHyVBIe"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B622D7AE;
	Tue, 20 May 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747543; cv=none; b=exZ18/dQU4/GWGxNdCuHm/aY/uh4IA0u5Oy5tFdqqXLUPW+JEsWsbrqmpxyw+1kit5YVyp7qfSZZ+jSBc1bLqH+HXbhvgrVBh0FIZbFl7Mrnc3luUiJw4jU4XDAKZBARhElOW6XkJpDP4Rvc+Ox4HVa881pmrXQRh1VkfD/W+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747543; c=relaxed/simple;
	bh=v+iza7MvoJ83MFy1z6F9QmgY8oCEYCu8KydWZP3roLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdH0wEMXm1DIGu1ZeODwpb+5ndW0B1MU4pwZS+HqoKGcnTkufOiPV+hmfHzGTxcUa91ogV+zeGsxLhwXpRYn3Q3wbQU6IkwvKszC5XAjZWsr3oiNkYOGQrD0zvavb4ezVYh53+7dMMftj/fisl4UMwmM2V30SMaJQtDHF9Of4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDHyVBIe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747747542; x=1779283542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+iza7MvoJ83MFy1z6F9QmgY8oCEYCu8KydWZP3roLU=;
  b=nDHyVBIeZxFfU4IyacdLYhGbXdLbv+6Oj+bDAl9VVk817nAGJPWLg+aC
   GnGG6V2PKUL4oeQkrESk1ycKLMTqBLFTfPh9utiOQeECBbAhKr7+sWaya
   9/gMM9w/GyBr0HNWN0SD11ugNr5EFGU8Qctjo+j0sGypdj+v8kiU6sVUa
   65JOuH2G90k9jcfszbJiKzDWLwCsHp+32HANtRaANk/lndCoJvM18kajK
   LWo2lz1AzuYKp5ixqIhHfIzd6eOfvZdUltRJhC6sb/y87AuecQ+QSwIV6
   2bJte604RSRgmsBmf+7iq9j/Y/m/4AqJmbnQ+Nr3uQ7bgNTEBXT6/r2H4
   w==;
X-CSE-ConnectionGUID: eGjV86fhRr2IX/fkB7OjLA==
X-CSE-MsgGUID: 5rpzE28OSC+3jcaT6p47rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="72195729"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72195729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 06:25:41 -0700
X-CSE-ConnectionGUID: ek/mB6MSQB2kFQKQzpEx3A==
X-CSE-MsgGUID: 1cnDf9sPQSeAPKPAyY3ZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170704892"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 06:25:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHMyO-000McC-2L;
	Tue, 20 May 2025 13:25:36 +0000
Date: Tue, 20 May 2025 21:25:05 +0800
From: kernel test robot <lkp@intel.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, tj@kernel.org,
	hannes@cmpxchg.org, longman@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev, Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
Message-ID: <202505202112.tmU9BTzA-lkp@intel.com>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>

Hi Zhongkun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongkun-He/cpuset-introduce-non-blocking-cpuset-mems-setting-option/20250520-111737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250520031552.1931598-1-hezhongkun.hzk%40bytedance.com
patch subject: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
config: s390-randconfig-002-20250520 (https://download.01.org/0day-ci/archive/20250520/202505202112.tmU9BTzA-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505202112.tmU9BTzA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505202112.tmU9BTzA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cpuset.c:3246:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3246 |                 bool skip_migrate_once = false;
         |                 ^
   1 warning generated.


vim +3246 kernel/cgroup/cpuset.c

  3215	
  3216	/*
  3217	 * Common handling for a write to a "cpus" or "mems" file.
  3218	 */
  3219	ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
  3220					    char *buf, size_t nbytes, loff_t off)
  3221	{
  3222		struct cpuset *cs = css_cs(of_css(of));
  3223		struct cpuset *trialcs;
  3224		int retval = -ENODEV;
  3225	
  3226		buf = strstrip(buf);
  3227		cpus_read_lock();
  3228		mutex_lock(&cpuset_mutex);
  3229		if (!is_cpuset_online(cs))
  3230			goto out_unlock;
  3231	
  3232		trialcs = alloc_trial_cpuset(cs);
  3233		if (!trialcs) {
  3234			retval = -ENOMEM;
  3235			goto out_unlock;
  3236		}
  3237	
  3238		switch (of_cft(of)->private) {
  3239		case FILE_CPULIST:
  3240			retval = update_cpumask(cs, trialcs, buf);
  3241			break;
  3242		case FILE_EXCLUSIVE_CPULIST:
  3243			retval = update_exclusive_cpumask(cs, trialcs, buf);
  3244			break;
  3245		case FILE_MEMLIST:
> 3246			bool skip_migrate_once = false;
  3247	
  3248			if ((of->file->f_flags & O_NONBLOCK) &&
  3249				is_memory_migrate(cs) &&
  3250				!cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 0))
  3251				skip_migrate_once = true;
  3252	
  3253			retval = update_nodemask(cs, trialcs, buf);
  3254	
  3255			/* Restore the migrate flag */
  3256			if (skip_migrate_once)
  3257				cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 1);
  3258			break;
  3259		default:
  3260			retval = -EINVAL;
  3261			break;
  3262		}
  3263	
  3264		free_cpuset(trialcs);
  3265		if (force_sd_rebuild)
  3266			rebuild_sched_domains_locked();
  3267	out_unlock:
  3268		mutex_unlock(&cpuset_mutex);
  3269		cpus_read_unlock();
  3270		flush_workqueue(cpuset_migrate_mm_wq);
  3271		return retval ?: nbytes;
  3272	}
  3273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

