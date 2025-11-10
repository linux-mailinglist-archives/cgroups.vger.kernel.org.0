Return-Path: <cgroups+bounces-11726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FAC4686A
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 13:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE2914EB3AF
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052330FF1D;
	Mon, 10 Nov 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQICwdgv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AE30BF59;
	Mon, 10 Nov 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776765; cv=none; b=cxq4XembnqxQnF8j636G8guiZ5uIfr70p1hd/XyVREsZVOraBuij1iexToRAzXh+4KY5B3hxu4bXfGXEdZYODE6+TqPeWySuAS8C/Lar4rKs/UHOAhaVZ1dEE5i/V1RzmxA9AMGGzj4O/NFl7OIBxuZwYgRAyDK8TaT7/5H8Mts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776765; c=relaxed/simple;
	bh=7baM59UhgLs3PzSYxMxfS0Nqh+LcBS+GPLi8CsvzC/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzrqHJ9Fxd6/1JLRHPZ4Vwo3ekpSQcFfu4eYuZ0ICgv2OxMkCmnsxeUMuGHE5zF1/r0SNG5Dq6YRqkxa8RGZHbfatSLMzY2bCNKxFhlWYnoDuNmv/9xMxnuCp6T7rpKK+tzdRTL5Mp3/V96nAdHYLtAkrJjsHBrCa3bXWzTAWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQICwdgv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776764; x=1794312764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7baM59UhgLs3PzSYxMxfS0Nqh+LcBS+GPLi8CsvzC/w=;
  b=AQICwdgvvOfQQrJ+dIuTFnziWQJ7hjgJtuSfneqFWMLgDPs0uGR2j525
   lN6QuzV8MD6tmf2FUn9nHHUOQhhnle8+wblWo/7RiangAdO87W6dWDF6n
   rJZacWvScKSfbHezNfci6DciGdKtcJrBmwmldZVJxXgxesDa4S3aV22DF
   rLRZ9Zte4TNdLXAmfKID5RXNHdzZuuL3aMgDFh8F/38Fwz3FLH7nO6aEA
   neRMeBL/0YF/tJyAyHo7hpJlUA/MmKnJlC5naxoKuzOiLLmR+HWmHNDyp
   05BM35aB3qLChGdG8M0IJDVC4l8N1BN2gFdKdpG3Pp9wNS/WkdgoY6yy5
   Q==;
X-CSE-ConnectionGUID: Q3hs3ptIREGZ+y43NHxb7g==
X-CSE-MsgGUID: 1fMCF16mTXy6d4gzp1EZMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64524598"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64524598"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:12:43 -0800
X-CSE-ConnectionGUID: FSWuZslwQh+TRlCS3ZmSZA==
X-CSE-MsgGUID: WnKB7LmvS+yM8IUXxmgQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187966765"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Nov 2025 04:12:39 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIQlA-0000Or-2S;
	Mon, 10 Nov 2025 12:12:36 +0000
Date: Mon, 10 Nov 2025 20:12:34 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisl@kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, youngjun.park@lge.com, gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: Re: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into
 swap subsystem
Message-ID: <202511102053.StJy9JAB-lkp@intel.com>
References: <20251109124947.1101520-4-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109124947.1101520-4-youngjun.park@lge.com>

Hi Youngjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20251109-215033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251109124947.1101520-4-youngjun.park%40lge.com
patch subject: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into swap subsystem
config: s390-randconfig-001-20251110 (https://download.01.org/0day-ci/archive/20251110/202511102053.StJy9JAB-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511102053.StJy9JAB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511102053.StJy9JAB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/page_io.c:29:
>> mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
   mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' declared 'static' but never defined [-Wunused-function]
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/swapfile.c:52:
>> mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
   mm/swapfile.c: In function 'swap_alloc_entry':
>> mm/swapfile.c:1309:29: error: 'struct swap_info_struct' has no member named 'tier_idx'
      if (swap_tiers_test_off(si->tier_idx, mask))
                                ^~
   In file included from mm/swapfile.c:52:
   mm/swapfile.c: At top level:
   mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' used but never defined
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/memcontrol.c:71:
>> mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
   mm/memcontrol.c: In function 'mem_cgroup_free':
>> mm/memcontrol.c:3734:2: error: implicit declaration of function 'swap_tiers_put_mask'; did you mean 'swap_tiers_release'? [-Werror=implicit-function-declaration]
     swap_tiers_put_mask(memcg);
     ^~~~~~~~~~~~~~~~~~~
     swap_tiers_release
   In file included from mm/memcontrol.c:71:
   mm/memcontrol.c: At top level:
   mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' declared 'static' but never defined [-Wunused-function]
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
   Selected by [y]:
   - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y] && OF [=y]


vim +71 mm/swap_tier.h

c17fe68325c921 Youngjun Park 2025-11-09  41  
c17fe68325c921 Youngjun Park 2025-11-09  42  void swap_tiers_init(void);
c17fe68325c921 Youngjun Park 2025-11-09  43  int swap_tiers_add(struct tiers_desc desc[], int nr);
c17fe68325c921 Youngjun Park 2025-11-09  44  int swap_tiers_remove(struct tiers_desc desc[], int nr);
c17fe68325c921 Youngjun Park 2025-11-09  45  ssize_t swap_tiers_show_sysfs(char *buf);
c17fe68325c921 Youngjun Park 2025-11-09  46  void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg);
c17fe68325c921 Youngjun Park 2025-11-09  47  void swap_tiers_assign(struct swap_info_struct *swp);
c17fe68325c921 Youngjun Park 2025-11-09  48  void swap_tiers_release(struct swap_info_struct *swp);
c17fe68325c921 Youngjun Park 2025-11-09  49  int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgroup *memcg);
c17fe68325c921 Youngjun Park 2025-11-09  50  void swap_tiers_put_mask(struct mem_cgroup *memcg);
c17fe68325c921 Youngjun Park 2025-11-09  51  static inline bool swap_tiers_test_off(int tier_idx, int mask)
c17fe68325c921 Youngjun Park 2025-11-09  52  {
c17fe68325c921 Youngjun Park 2025-11-09  53  	return TIER_MASK(tier_idx, TIER_OFF_MASK) & mask;
c17fe68325c921 Youngjun Park 2025-11-09  54  }
c17fe68325c921 Youngjun Park 2025-11-09  55  int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
c17fe68325c921 Youngjun Park 2025-11-09  56  #else
c17fe68325c921 Youngjun Park 2025-11-09  57  static inline void swap_tiers_init(void)
c17fe68325c921 Youngjun Park 2025-11-09  58  {
c17fe68325c921 Youngjun Park 2025-11-09  59  }
c17fe68325c921 Youngjun Park 2025-11-09  60  static inline void swap_tiers_assign(struct swap_info_struct *swp)
c17fe68325c921 Youngjun Park 2025-11-09  61  {
c17fe68325c921 Youngjun Park 2025-11-09  62  }
c17fe68325c921 Youngjun Park 2025-11-09  63  static inline void swap_tiers_release(struct swap_info_struct *swp)
c17fe68325c921 Youngjun Park 2025-11-09  64  {
c17fe68325c921 Youngjun Park 2025-11-09  65  }
c17fe68325c921 Youngjun Park 2025-11-09  66  static inline bool swap_tiers_test_off(int tier_off_mask, int mask)
c17fe68325c921 Youngjun Park 2025-11-09  67  {
c17fe68325c921 Youngjun Park 2025-11-09  68  	return false;
c17fe68325c921 Youngjun Park 2025-11-09  69  }
c17fe68325c921 Youngjun Park 2025-11-09  70  static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
c17fe68325c921 Youngjun Park 2025-11-09 @71  {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

