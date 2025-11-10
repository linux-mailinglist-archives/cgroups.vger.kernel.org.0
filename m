Return-Path: <cgroups+bounces-11734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DCC46E22
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AC4E1836
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA03101C5;
	Mon, 10 Nov 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMOehkiy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38882EBB9C;
	Mon, 10 Nov 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781213; cv=none; b=IXAjw2Z7hf9QcD5GscxwzRJl8v7nLn+nkeS6XcExR6OXb69NrHh0ZcntKfXua4UYWvwPp7uRTX9Gg5JNzzpLZGNJ6XzttHRgHFX49/ovEfsZDjlDwucO+OaAPkgLTVIE2EbAHBRws427Woy4gtowXKMANG2tEwcfov/HhDOhkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781213; c=relaxed/simple;
	bh=gqluEsxLQlbV3vngbeO8V//CEUVe0NkM4sEqKyJqBVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2Uehh2rXRuOqC3SlwuM2b1y6Fu53EDudxeaoB44bPkvs1cTCn3IB1+0QPQV64ttyi5iS3I1WForPfnncxbXGjOYFBEb0Kc2zLqBmtVYl45Xy48uoRjHkaDh2aJ996ARFxeHh6/BZA3nK+TGrCffOlhUv1ZBBRHVCuYpO6Ik6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMOehkiy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762781211; x=1794317211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqluEsxLQlbV3vngbeO8V//CEUVe0NkM4sEqKyJqBVc=;
  b=ZMOehkiyNZMJdT6wlKz1eQlP7EdIaGli/KwkhbSmCQ3BMgsy3w+agHIk
   C0EZgiSvmDOO66ptfkAa+3s3SbbAIRcDwtw5KNV/wR2O3W7c4WWiesCS0
   JKbnCNdSZFtdLMHaN2/9y152apuH/tmLU02/1D765dVUw8O21QPCZTOz8
   GB3H/K33ESwD/Wh7x2kSbzwEmnP17TJ0ZPKsYfJBKWjSDPnn7Lxd9xgB/
   YPE7hWfU5FG2g2uWqDOgQCyAUjmUUms3T8do0PlMcQ3LwdOeeqhEZNtXg
   R8OzmVF+okqZPXqZKqT/5Ii97dihSPcBX6y2rj/aG4vQldLNFuEUTwr83
   w==;
X-CSE-ConnectionGUID: EmQbSs3RTVGKJCJuQ7mtcg==
X-CSE-MsgGUID: 0ytpoQ/8Q/iGDw8Ap7NvEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67436098"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67436098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:26:51 -0800
X-CSE-ConnectionGUID: t+LJONLVQHSZACIPcylDHg==
X-CSE-MsgGUID: TMq45V+1QXibCa/0AnAzug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192932412"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Nov 2025 05:26:45 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIRuu-0000Sp-2q;
	Mon, 10 Nov 2025 13:26:44 +0000
Date: Mon, 10 Nov 2025 21:26:01 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrisl@kernel.org, kasong@tencent.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, youngjun.park@lge.com,
	gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into
 swap subsystem
Message-ID: <202511102100.y6n1mtle-lkp@intel.com>
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
config: riscv-randconfig-001-20251110 (https://download.01.org/0day-ci/archive/20251110/202511102100.y6n1mtle-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511102100.y6n1mtle-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511102100.y6n1mtle-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/page_io.c:29:
>> mm/swap_tier.h:71:1: error: expected identifier or '('
      71 | {
         | ^
   1 error generated.
--
   In file included from mm/swapfile.c:52:
>> mm/swap_tier.h:71:1: error: expected identifier or '('
      71 | {
         | ^
>> mm/swapfile.c:1309:31: error: no member named 'tier_idx' in 'struct swap_info_struct'
    1309 |                 if (swap_tiers_test_off(si->tier_idx, mask))
         |                                         ~~  ^
   2 errors generated.


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

