Return-Path: <cgroups+bounces-10431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90869B9A1B6
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2513250C8
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B618E377;
	Wed, 24 Sep 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpA0nxVX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893814A9B;
	Wed, 24 Sep 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721807; cv=none; b=uwKwFE2Sa/JqJdoD+S9SyPJ5ckj/P7j9YlLhycfc8o7jMIDtqeaShmaRGxayUKU0Muh+smB/i+tg9ysBexOR4c5IzY75g/Ee0WU3LDV+BANaitj4/OqpUtGVeDbZfuPaOO439yc+5TkTB/GY9/Y1IXy7qCNf8KFW6ofgRsmGr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721807; c=relaxed/simple;
	bh=FVTlGQRfhtupRSo1RZWEmSo3V6SWhG+b4V2VQt6fC2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmc5ww6mhtFQteGZXHdC3bgGXE+u2GW/KJ5HkPMTl9VEwOpnRUK/VN638mjcDl0nKExyOWHANpnWlypE7ntW/k7Ag/GQJv+tiaaUSbc4WtYPUU+nG5okAZsVNJzpAmbEP1yfS8H66bXz+i73WDn92Ehqzo/+Qn2Uyqh6MjPrrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpA0nxVX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758721805; x=1790257805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVTlGQRfhtupRSo1RZWEmSo3V6SWhG+b4V2VQt6fC2M=;
  b=MpA0nxVX0AVggcEdK0w+WqO0AxtIkizAFOvyDu2wPKWqB832K3tWTZdF
   36utLx2OHgl3zqcbY7cm9xv1d2r9p+gGPx4S17cneIfaMQ59sq3nmoSnl
   w6DzmGxRa+5py1kzY7QHJxV9Ugp0qGyUwNQM+SqH+PUTmIHX1Ld0sefiV
   /B+Jnh3owy8VdX/buVWUQys9lgsrntqpFEq6fS9I2pNsnvr27Ucc9keoR
   afCvUOE7bl44g65OpSgcruLM6ulPWAR3EaZnLZiJXbT8nSQJ0UDZUj6MP
   IHhJWzYg8H+Ex+SfTin0emSFMv80Nw4BXefAe+1U7EUd58NqBhhQ+y8Jk
   Q==;
X-CSE-ConnectionGUID: pNsJGS5TQ9W1NGVmpgKH5w==
X-CSE-MsgGUID: kXChP9yRTwWTTOLw2yo8tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60931980"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60931980"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:50:04 -0700
X-CSE-ConnectionGUID: +LyeUF/IR8CAyRI+4elb0g==
X-CSE-MsgGUID: 7NA19qq7SRSo+9WS0jpauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="181051824"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 24 Sep 2025 06:49:59 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1Psa-0004C9-1F;
	Wed, 24 Sep 2025 13:49:56 +0000
Date: Wed, 24 Sep 2025 21:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <202509242123.QwwFy7gc-lkp@intel.com>
References: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250922]
[also build test ERROR on v6.17-rc7]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next rppt-memblock/fixes linus/master v6.17-rc7 v6.17-rc6 v6.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-thp-replace-folio_memcg-with-folio_memcg_charged/20250923-171935
base:   next-20250922
patch link:    https://lore.kernel.org/r/55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg offline
config: riscv-randconfig-001-20250924 (https://download.01.org/0day-ci/archive/20250924/202509242123.QwwFy7gc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509242123.QwwFy7gc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509242123.QwwFy7gc-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/huge_memory.c: In function 'reparent_deferred_split_queue':
>> mm/huge_memory.c:4302:42: error: dereferencing pointer to incomplete type 'struct mem_cgroup'
     struct deferred_split *ds_queue = &memcg->deferred_split_queue;
                                             ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
   Depends on [n]: BINFMT_ELF [=n] && ELF_CORE [=n]
   Selected by [y]:
   - RISCV [=y]


vim +4302 mm/huge_memory.c

  4298	
  4299	void reparent_deferred_split_queue(struct mem_cgroup *memcg)
  4300	{
  4301		struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> 4302		struct deferred_split *ds_queue = &memcg->deferred_split_queue;
  4303		struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
  4304		int nid;
  4305	
  4306		spin_lock_irq(&ds_queue->split_queue_lock);
  4307		spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
  4308	
  4309		if (!ds_queue->split_queue_len)
  4310			goto unlock;
  4311	
  4312		list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
  4313		parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
  4314		ds_queue->split_queue_len = 0;
  4315		/* Mark the ds_queue dead */
  4316		ds_queue->is_dying = true;
  4317	
  4318		for_each_node(nid)
  4319			set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
  4320	
  4321	unlock:
  4322		spin_unlock(&parent_ds_queue->split_queue_lock);
  4323		spin_unlock_irq(&ds_queue->split_queue_lock);
  4324	}
  4325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

