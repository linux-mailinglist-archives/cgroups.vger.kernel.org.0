Return-Path: <cgroups+bounces-8837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC0B0DE00
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC37AC46C9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC02F0056;
	Tue, 22 Jul 2025 14:09:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFD2ED15C
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193386; cv=none; b=nxkJebU7SMEaa3FtW88+3wxfEptYjFKDBVgs5hENwZQuL8TpyxNGFcBnLd/cRU6EupgyQ33FHY+15jdz8/J43L5dbQ9hiXiJVo7E//ewbAsnjpr66TvZYJz/vpRCpWvob+ckAm32An9K3GHphQiW+V6lYfLyRSNnTNajtLja6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193386; c=relaxed/simple;
	bh=6xQCdPO/kHsh1LWL6WOEJdUPJtG0FLS+QPoPtGb4Wes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2rQ8EzMXINOD6FNUxKHyDmNJY16NQFWcED2i5+3NG8bSLbVVr52jqCZoMlz6XxDEeedGKdGhuMhrR8dH96s5GgpgOgNcWLXIZGABsteQQyj8KMQ90ueXvxBt4uLarzmHfLYm3DtXdLemSjseKy/KpKlQ6yo9Pgvbj2DPgb4wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 22 Jul 2025 23:09:37 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 22 Jul 2025 23:09:37 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: kernel test robot <lkp@intel.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
	oe-kbuild-all@lists.linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aH+boS+lxLapI796@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
 <202507171936.fGW4muEc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507171936.fGW4muEc-lkp@intel.com>

On Thu, Jul 17, 2025 at 07:20:58PM +0800, kernel test robot wrote:
> Hi Youngjun,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 347e9f5043c89695b01e66b3ed111755afcf1911]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-memcg-Introduce-infrastructure-for-cgroup-based-swap-priority/20250717-042648
> base:   347e9f5043c89695b01e66b3ed111755afcf1911
> patch link:    https://lore.kernel.org/r/20250716202006.3640584-2-youngjun.park%40lge.com
> patch subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250717/202507171936.fGW4muEc-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171936.fGW4muEc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507171936.fGW4muEc-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/memcontrol.c:5462:12: warning: variable 'id' is uninitialized when used here [-Wuninitialized]
>     5462 |                                 memcg, id, SWAP_PRIORITY_GLOBAL);
>          |                                        ^~
>    mm/memcontrol.c:5414:8: note: initialize the variable 'id' to silence this warning
>     5414 |         u64 id;
>          |               ^
>          |                = 0
>    1 warning generated.
> 
> 
> vim +/id +5462 mm/memcontrol.c
> 
>   5408	
>   5409	#ifdef CONFIG_SWAP_CGROUP_PRIORITY
>   5410	static ssize_t swap_cgroup_priority_write(struct kernfs_open_file *of,
>   5411						  char *buf, size_t nbytes, loff_t off)
>   5412	{
>   5413		struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>   5414		u64 id;
>   5415		int prio;
>   5416		int ret;
>   5417		char first_token[32];
>   5418		char second_token[32];
>   5419		char dummy[2];
>   5420		char *stripped_buf;
>   5421		int num_parsed;
>   5422	
>   5423		stripped_buf = strstrip(buf);
>   5424		num_parsed = sscanf(stripped_buf, "%31s %31s %1s", first_token,
>   5425				    second_token, dummy);
>   5426		if (num_parsed == 2) {
>   5427			if (strcmp(first_token, "default") == 0) {
>   5428				if (strcmp(second_token, "none") == 0)
>   5429					ret = apply_swap_cgroup_priority(
>   5430						memcg, DEFAULT_ID, SWAP_PRIORITY_GLOBAL);
>   5431				else if (strcmp(second_token, "disabled") == 0)
>   5432					ret = apply_swap_cgroup_priority(
>   5433						memcg, DEFAULT_ID, SWAP_PRIORITY_DISABLE);
>   5434				else
>   5435					ret = -EINVAL;
>   5436			} else {
>   5437				ret = kstrtoull(first_token, 10, &id);
>   5438				if (ret)
>   5439					return -EINVAL;
>   5440	
>   5441				if (strcmp(second_token, "none") == 0) {
>   5442					ret = apply_swap_cgroup_priority(
>   5443						memcg, id, SWAP_PRIORITY_GLOBAL);
>   5444				} else if (strcmp(second_token, "disabled") == 0) {
>   5445					ret = apply_swap_cgroup_priority(
>   5446						memcg, id, SWAP_PRIORITY_DISABLE);
>   5447				} else {
>   5448					ret = kstrtoint(second_token, 10, &prio);
>   5449					if (ret)
>   5450						return -EINVAL;
>   5451					if (prio == -1)
>   5452						return -EINVAL;
>   5453					else if (prio > SHRT_MAX || prio < SHRT_MIN)
>   5454						return -EINVAL;
>   5455					ret = apply_swap_cgroup_priority(memcg, id,
>   5456									 prio);
>   5457				}
>   5458			}
>   5459		} else if (num_parsed == 1) {
>   5460			if (strcmp(first_token, "none") == 0)
>   5461				ret = apply_swap_cgroup_priority(
> > 5462					memcg, id, SWAP_PRIORITY_GLOBAL);
>   5463			else if (strcmp(first_token, "disabled") == 0)
>   5464				ret = apply_swap_cgroup_priority(
>   5465					memcg, id, SWAP_PRIORITY_DISABLE);
>   5466			else
>   5467				ret = -EINVAL;
>   5468		} else {
>   5469			return -EINVAL;
>   5470		}
>   5471	
>   5472		if (ret)
>   5473			return ret;
>   5474	
>   5475		return nbytes;
>   5476	}
>   5477	

This is an initialization bug where the "default" value may not be handled
correctly in certain cases, such as:

  e.g. echo none > memory.swap.priority

I should have checked this more carefully. I will fix the issue and add
a test case in the next patch revision.

Best regards,
Youngjun Park

