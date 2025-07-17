Return-Path: <cgroups+bounces-8750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E32B08BA8
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9372A3AB052
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42C29ACC6;
	Thu, 17 Jul 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwR4nyvN"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AA29AB11;
	Thu, 17 Jul 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751296; cv=none; b=HgCFjshUv5Qa/RiRA9jnUPEp81faNsUS57nOwmvhjGbO/MLfZFvHDGz26r6tE4cF2aUPblyUvRzmi+wSxrJBFgKa3FzFuXRT8aDsgr/dWUffLKIf4u+rIfL2ezbZwMo2s+Mwlp+2TcxCg2rOci+nx5wKl3vYLfzp/yFP3Ir/ytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751296; c=relaxed/simple;
	bh=tp43p0GJ/val1nSF5m1mu7Vex9dTquwznl2UZ8uspK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoWyAJPi3fKGF/CaGWcRAyJT/qkD4GjhM+WaspiIWdxMW8uZCDYBsutLh354TGdlrA1OmW/q9AbM4nCTt24jR5nG3uGddWXFK7lcgPHlN9rV7T7NoIVZYVvh2EOE7QmJjnfmB8qvn3gBre6lWI3+5pfBYqyojPLgCpGG+kQZu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwR4nyvN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752751295; x=1784287295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tp43p0GJ/val1nSF5m1mu7Vex9dTquwznl2UZ8uspK4=;
  b=EwR4nyvNeHbuYyyNO+pOEuSAh3bAHNlnE7h1IHgIkQKfWpVKOMlLyb+a
   uVALtZLqVNpkBqB183dsikh+jOw4eEZajb5FAq59DtVeJgEPQShdC9T6Y
   j2NTD1HKwy7JslSpRueIjg4TWRJJt+jpLeoyv1pmgWaGl9stX+q/+FUO8
   Jk4ePdqotPoali7s5qU40J4VRRZT6hypRq8TMAFMom9NT83sN0P8DxASs
   bbMfzInkYlewk5r7AsX45RBb3DWl8veKsjibPEhOSd3TslRXb4KBqaMH6
   btbavQRw1+9SspYE3ri2LNfX6ek2sAsmBrqPPBKZwsPcMy11Wza68D7Ox
   g==;
X-CSE-ConnectionGUID: QxcB9USMTbWWVcxrf8NyQQ==
X-CSE-MsgGUID: nWbwQ1tfTuycWn2Avlu1XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54738569"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="54738569"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 04:21:34 -0700
X-CSE-ConnectionGUID: j47l8CY8RwOJJZh5UBSNWw==
X-CSE-MsgGUID: lakZtGCVQgGTgHw6kEiKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157158832"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Jul 2025 04:21:29 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucMg3-000DZb-05;
	Thu, 17 Jul 2025 11:21:27 +0000
Date: Thu, 17 Jul 2025 19:20:58 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <202507171936.fGW4muEc-lkp@intel.com>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716202006.3640584-2-youngjun.park@lge.com>

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-memcg-Introduce-infrastructure-for-cgroup-based-swap-priority/20250717-042648
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250716202006.3640584-2-youngjun.park%40lge.com
patch subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250717/202507171936.fGW4muEc-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171936.fGW4muEc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171936.fGW4muEc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:5462:12: warning: variable 'id' is uninitialized when used here [-Wuninitialized]
    5462 |                                 memcg, id, SWAP_PRIORITY_GLOBAL);
         |                                        ^~
   mm/memcontrol.c:5414:8: note: initialize the variable 'id' to silence this warning
    5414 |         u64 id;
         |               ^
         |                = 0
   1 warning generated.


vim +/id +5462 mm/memcontrol.c

  5408	
  5409	#ifdef CONFIG_SWAP_CGROUP_PRIORITY
  5410	static ssize_t swap_cgroup_priority_write(struct kernfs_open_file *of,
  5411						  char *buf, size_t nbytes, loff_t off)
  5412	{
  5413		struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
  5414		u64 id;
  5415		int prio;
  5416		int ret;
  5417		char first_token[32];
  5418		char second_token[32];
  5419		char dummy[2];
  5420		char *stripped_buf;
  5421		int num_parsed;
  5422	
  5423		stripped_buf = strstrip(buf);
  5424		num_parsed = sscanf(stripped_buf, "%31s %31s %1s", first_token,
  5425				    second_token, dummy);
  5426		if (num_parsed == 2) {
  5427			if (strcmp(first_token, "default") == 0) {
  5428				if (strcmp(second_token, "none") == 0)
  5429					ret = apply_swap_cgroup_priority(
  5430						memcg, DEFAULT_ID, SWAP_PRIORITY_GLOBAL);
  5431				else if (strcmp(second_token, "disabled") == 0)
  5432					ret = apply_swap_cgroup_priority(
  5433						memcg, DEFAULT_ID, SWAP_PRIORITY_DISABLE);
  5434				else
  5435					ret = -EINVAL;
  5436			} else {
  5437				ret = kstrtoull(first_token, 10, &id);
  5438				if (ret)
  5439					return -EINVAL;
  5440	
  5441				if (strcmp(second_token, "none") == 0) {
  5442					ret = apply_swap_cgroup_priority(
  5443						memcg, id, SWAP_PRIORITY_GLOBAL);
  5444				} else if (strcmp(second_token, "disabled") == 0) {
  5445					ret = apply_swap_cgroup_priority(
  5446						memcg, id, SWAP_PRIORITY_DISABLE);
  5447				} else {
  5448					ret = kstrtoint(second_token, 10, &prio);
  5449					if (ret)
  5450						return -EINVAL;
  5451					if (prio == -1)
  5452						return -EINVAL;
  5453					else if (prio > SHRT_MAX || prio < SHRT_MIN)
  5454						return -EINVAL;
  5455					ret = apply_swap_cgroup_priority(memcg, id,
  5456									 prio);
  5457				}
  5458			}
  5459		} else if (num_parsed == 1) {
  5460			if (strcmp(first_token, "none") == 0)
  5461				ret = apply_swap_cgroup_priority(
> 5462					memcg, id, SWAP_PRIORITY_GLOBAL);
  5463			else if (strcmp(first_token, "disabled") == 0)
  5464				ret = apply_swap_cgroup_priority(
  5465					memcg, id, SWAP_PRIORITY_DISABLE);
  5466			else
  5467				ret = -EINVAL;
  5468		} else {
  5469			return -EINVAL;
  5470		}
  5471	
  5472		if (ret)
  5473			return ret;
  5474	
  5475		return nbytes;
  5476	}
  5477	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

