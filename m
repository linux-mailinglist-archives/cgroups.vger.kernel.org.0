Return-Path: <cgroups+bounces-8839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08CB0DE6B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DB8568067
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B32EB5D3;
	Tue, 22 Jul 2025 14:14:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CE2EB5D5
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193660; cv=none; b=V+DfDAjYVb/LFLnKHSyXovJnC+OeT1S5DfmJhz8ZnIxe4nSy2xYxpSO8EGSFyjNLbp9GLW3ZoD23zwSMO6klvTuwmIYGxCvw7VrK2A6kDcX3zurq+s/MsNUfgLae+hbcV8BRQQzPgSYozah/A/4JcRqJOKm9QfPIGVWLsvCE/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193660; c=relaxed/simple;
	bh=YbZj6IAnk6i1IGZYhFj9C06BbWO/yAXaTN7raclAZtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx1ovFLl5G7NVNiiVCA0Gp9s8r3txSfcMRyFNZ+i7TFDraIuK8XGc4i/EVqYmm4BMRScxic8LVmO7XE99k34MzxJbSCls7he9KXVuiezKkIKmfdQViJ6TU+F4ytgpx4l7uf1ToOY4ML5RpoDfAVUp787mZdKiSLa1UkKi394xuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 22 Jul 2025 23:14:16 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 22 Jul 2025 23:14:09 +0900
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
Message-ID: <aH+csQxNcCmQMgZa@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
 <202507212243.Lf8fSo0T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507212243.Lf8fSo0T-lkp@intel.com>

On Mon, Jul 21, 2025 at 11:13:24PM +0800, kernel test robot wrote:
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
> config: loongarch-randconfig-r123-20250721 (https://download.01.org/0day-ci/archive/20250721/202507212243.Lf8fSo0T-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce: (https://download.01.org/0day-ci/archive/20250721/202507212243.Lf8fSo0T-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507212243.Lf8fSo0T-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> mm/swap_cgroup_priority.c:115:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    mm/swap_cgroup_priority.c:115:16: sparse:    struct swap_cgroup_priority [noderef] __rcu *
>    mm/swap_cgroup_priority.c:115:16: sparse:    struct swap_cgroup_priority *
>    mm/swap_cgroup_priority.c:729:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    mm/swap_cgroup_priority.c:729:9: sparse:    struct swap_cgroup_priority [noderef] __rcu *
>    mm/swap_cgroup_priority.c:729:9: sparse:    struct swap_cgroup_priority *
>    mm/swap_cgroup_priority.c:638:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    mm/swap_cgroup_priority.c:638:25: sparse:    struct swap_cgroup_priority [noderef] __rcu *
>    mm/swap_cgroup_priority.c:638:25: sparse:    struct swap_cgroup_priority *
> 
> vim +115 mm/swap_cgroup_priority.c
> 
>    108	
>    109	static struct swap_cgroup_priority *get_swap_cgroup_priority(
>    110		struct mem_cgroup *memcg)
>    111	{
>    112		if (!memcg)
>    113			return NULL;
>    114	
>  > 115		return rcu_dereference(memcg->swap_priority);
>    116	}
>    117	
> 

This part of the code, which retrieves the object, 
is expected to be properly updated in a subsequent patch series. 
Therefore, I believe it's reasonable to leave it as-is for now.

Best Regard,
Youngjun Park

