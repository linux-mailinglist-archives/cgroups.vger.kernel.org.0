Return-Path: <cgroups+bounces-11724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0284C46549
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 12:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01031883139
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83E3090EA;
	Mon, 10 Nov 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IniNfwEt"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59862302743;
	Mon, 10 Nov 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774901; cv=none; b=ARZO4Zq03Q11OQCinLNsLbiUKCiRVLpA0LVCjwXnuPowj17rNzjO6pIVqOzkrnNv/DJ9iWiQs577ENg6am65TyOsbKyeMfrwRSrrUVPtCIA+H765waUZai3d7oUpN/WGioY5+zX8w9BmICfevMmdKqpl5O2gDOWt4cmi6xE8XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774901; c=relaxed/simple;
	bh=omp3BC0nl5OC+y/Q6uZxJQjCYFP23DTOfobjBhZKdmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB/i6F5hymhpoZDjU2cFmakXE21gq5GwmeOkBP5zo5WjRcgQbJEkqdrrMgI3bW+4L+di7syP/5oYHqqP+0rmvtEvfHXpvbKjxgvcCeSVIMg0cE7Vq+8olojBZT4xPPc/lpolSukoraTqqSvgn9brzuY5bsRCvyV/8dTCqQzel5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IniNfwEt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774901; x=1794310901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omp3BC0nl5OC+y/Q6uZxJQjCYFP23DTOfobjBhZKdmU=;
  b=IniNfwEt/UM+/IAon84aA+hRkpt7UklrmASV3GLyi31Svqzfr71KHq7a
   nyrKepKHFgD5BrnjC2Geu/Zlm87NsvnCQ3v7IoWqHXcUHCAuZJEQlnj9p
   LHcCCnzEKC/3jsWtyy1G136iA0lPYu37uNfbbFOyMxPhSZflc48PL3JLF
   c0X3hZ3kca+QlAS2JzkaT8D8evFUOn4+mCPLqxqqlJMHTmPYmnHlm0kg0
   VdgJxw6/qtfbkxJEXa6FSspCUG/NERiBp20IOCSEspZ+S3vG7N4WcOx97
   xUt5fEGnU4umk/38OzOrcma1Qx6HYFIqvlmsX6p/7B7M7aCeoyRAOlK10
   w==;
X-CSE-ConnectionGUID: gtjfaA5mQBu29JBWJyRGvw==
X-CSE-MsgGUID: ogkbtAIZR7KDzODHLVmi0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="87454172"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="87454172"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:41:40 -0800
X-CSE-ConnectionGUID: 10suJJPjRL2utc/Raav2wQ==
X-CSE-MsgGUID: CvnKniDvTh+fgkSSdOvjpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193663550"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Nov 2025 03:41:35 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIQH7-0000MF-1C;
	Mon, 10 Nov 2025 11:41:33 +0000
Date: Mon, 10 Nov 2025 19:40:40 +0800
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
Message-ID: <202511101938.muW3KLKk-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20251109-215033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251109124947.1101520-4-youngjun.park%40lge.com
patch subject: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into swap subsystem
config: s390-randconfig-001-20251110 (https://download.01.org/0day-ci/archive/20251110/202511101938.muW3KLKk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101938.muW3KLKk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101938.muW3KLKk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/page_io.c:29:
   mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
>> mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' declared 'static' but never defined [-Wunused-function]
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/swapfile.c:52:
   mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
   mm/swapfile.c: In function 'swap_alloc_entry':
   mm/swapfile.c:1309:29: error: 'struct swap_info_struct' has no member named 'tier_idx'
      if (swap_tiers_test_off(si->tier_idx, mask))
                                ^~
   In file included from mm/swapfile.c:52:
   mm/swapfile.c: At top level:
>> mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' used but never defined
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/memcontrol.c:71:
   mm/swap_tier.h:71:1: error: expected identifier or '(' before '{' token
    {
    ^
   mm/memcontrol.c: In function 'mem_cgroup_free':
   mm/memcontrol.c:3734:2: error: implicit declaration of function 'swap_tiers_put_mask'; did you mean 'swap_tiers_release'? [-Werror=implicit-function-declaration]
     swap_tiers_put_mask(memcg);
     ^~~~~~~~~~~~~~~~~~~
     swap_tiers_release
   In file included from mm/memcontrol.c:71:
   mm/memcontrol.c: At top level:
>> mm/swap_tier.h:70:19: warning: 'swap_tiers_collect_compare_mask' declared 'static' but never defined [-Wunused-function]
    static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
   Selected by [y]:
   - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y] && OF [=y]


vim +70 mm/swap_tier.h

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
c17fe68325c921 Youngjun Park 2025-11-09 @70  static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

