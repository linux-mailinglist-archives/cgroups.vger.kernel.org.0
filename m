Return-Path: <cgroups+bounces-10063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B059B5697C
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E208817A2FD
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096702AD2C;
	Sun, 14 Sep 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sth5r6TB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2835898;
	Sun, 14 Sep 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757858114; cv=none; b=djIihlLon5Xp3ITjA0HwjAVgpw4FkuUpxuGBsQyzYsw+lC/GITPXIwsYdpKKW599YgRxoC1jYRwRXmTVEpCjZJAP13ZUGn/Bsjt+qJJyulR0kbZ/vNV+kouMul4tD5xsWJ/ukQVdgO2vMKBWixiXz15W8lDPWaI+P7zlTYHxins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757858114; c=relaxed/simple;
	bh=yAOoUPFw9dHD3qqCEAFNjt0DzdHHTrnt3LHkQ2Jj9wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbXPP0+zEV94e5QfKgP7kW/VdtG6ShnW16j4eUiTdw4U3lrmvOBiuKBRR57VjXs1aS98pAcDQVfULAGI/sXtKbZB65aeueyUEMIEKG3n5ceVpYRQSHeSGtUv16dwTk2odFC1ttKJ6FNL5CI7KkteGN3wfuaFo8xfL2HJsXSIaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sth5r6TB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757858113; x=1789394113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAOoUPFw9dHD3qqCEAFNjt0DzdHHTrnt3LHkQ2Jj9wU=;
  b=Sth5r6TBzcI7vTV+JRazbBZVq6XSiDOucT+pd/ZDQ9B/t8xa4WY01QJr
   iGOCTTXqfi/jBXLLke2BA+hI0F7B4cJF4rw8cEENOTUEEDnjyjUUH8x44
   gvSIpR3iv24JEkRGByfDeVa+oRjY/Kt5Q1AxU/nRAedVznPT6vcz6gjHf
   NW+S2SpNYhUQ9rvuE9Lsc3osKy3k1L0H0e/F0xqttO3Uw3O/D4TwbdgnX
   BqFz7pviaMjCr2Dyfdws/1D0x2k4R3/UWneL7p7GyF9IGCq16/H/UNpuR
   4wugA+wQq5y4oVotSljYQjHVCXPNIAt1zPmU53Rssii9xAppPjjpnoWKJ
   A==;
X-CSE-ConnectionGUID: RSYS5XYUQbujh5yCGvexbw==
X-CSE-MsgGUID: 3w0bVZRkSHKq1UgXav+2jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60048147"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60048147"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 06:55:13 -0700
X-CSE-ConnectionGUID: wIPbWldqRJqDW6vPQtA66Q==
X-CSE-MsgGUID: ErIUcXNcSKe45ZSx3eHwwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="175200651"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 14 Sep 2025 06:55:09 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxnC6-0002Rw-27;
	Sun, 14 Sep 2025 13:55:06 +0000
Date: Sun, 14 Sep 2025 21:54:25 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, shakeel.butt@linux.dev,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	david@redhat.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2 1/5] memcg: add per-memcg ksm_rmap_items stat
Message-ID: <202509142147.WQI0impC-lkp@intel.com>
References: <20250914180351288rcLuZnPAMUej48nuTc7KV@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914180351288rcLuZnPAMUej48nuTc7KV@zte.com.cn>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tj-cgroup/for-next linus/master v6.17-rc5 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xu-xin16-zte-com-cn/memcg-add-per-memcg-ksm_rmap_items-stat/20250914-181132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250914180351288rcLuZnPAMUej48nuTc7KV%40zte.com.cn
patch subject: [PATCH v2 1/5] memcg: add per-memcg ksm_rmap_items stat
config: parisc-randconfig-001-20250914 (https://download.01.org/0day-ci/archive/20250914/202509142147.WQI0impC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509142147.WQI0impC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509142147.WQI0impC-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/ksm.c: In function 'memcg_stat_ksm_show':
>> mm/ksm.c:3345:2: error: implicit declaration of function 'seq_buf_printf'; did you mean 'seq_bprintf'? [-Werror=implicit-function-declaration]
     seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
     ^~~~~~~~~~~~~~
     seq_bprintf
   cc1: some warnings being treated as errors


vim +3345 mm/ksm.c

  3329	
  3330	/* Show the ksm statistic count at memory.stat under cgroup mountpoint */
  3331	void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
  3332	{
  3333		struct memcg_ksm_stat ksm_stat;
  3334	
  3335		if (mem_cgroup_is_root(memcg)) {
  3336			/* Just use the global counters when root memcg */
  3337			ksm_stat.ksm_rmap_items = ksm_rmap_items;
  3338		} else {
  3339			/* Initialization */
  3340			ksm_stat.ksm_rmap_items = 0;
  3341			/* Summing all processes'ksm statistic items */
  3342			mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
  3343		}
  3344		/* Print memcg ksm statistic items */
> 3345		seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
  3346	}
  3347	#endif
  3348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

