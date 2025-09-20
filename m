Return-Path: <cgroups+bounces-10308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C3B8C3D9
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7CA58101D
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED655278761;
	Sat, 20 Sep 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbRAN1iA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826B34BA47;
	Sat, 20 Sep 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356859; cv=none; b=UlZ37aLtlD6+VI12/3/aakAAP8URxaanWx8MeMMx0rZyi6uAzv5rQrkVBBL33QcwneKhCot3otvr1E8Mb7fTFnPwWHSoWsMBBYNSq2tj6lDfNiQ/23bxi24Y0WcI2deVI591ODxZkR8iMWsMdW9RpofTBnPdsVu8r1yhDCIAQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356859; c=relaxed/simple;
	bh=fLmBxl6wqNnu65VPgOguy4Rp6FEVvwYxsWhMiq/CrPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuSNnqPeaMZ/v44Pyf5RevAYrweVTXNTxqbpYpQtXiyLf7R3IeaevDhaQAba0OTACjOVq7GWsz39D6/9c6+A7CS+9ztZtlzsJGVyw6OWqFoN6LFc1NHFeCB3OZYN1dfxKwjSWrHGeNQv3WfozxTVrRbKGVi9YX3EuEoSPU6t4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbRAN1iA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758356858; x=1789892858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLmBxl6wqNnu65VPgOguy4Rp6FEVvwYxsWhMiq/CrPM=;
  b=GbRAN1iAwrSzK8I9V+7/wl4it/mJmbiHvuNeJv96+4R3SJJ6VTD3sKWF
   qQKR4CrKMJgk31DjnU2chrjE7boVemED9cuKiME4Ctc3JOln3alk6QU+d
   srMgoaaV9LldiBDQXRilRwMtsjGv2QMSmrodH3F5NgsJYR4Z1kgqXF+Hq
   KvmDGqvKBNBtK/8YtR0zlQzrFrro55S2+ChDoyTGOglrZ4HH5CQSNm/bf
   R4t4kLaL4ZsjeTibnErZU48Va6VdaIAMz6iqcTAcEa2qVtgQ/dcvvMciT
   J3WthftVEoVSpJkMMYxWJyti5a3DZUc+zNus4STlZeMkUzEOik4bMBXDc
   g==;
X-CSE-ConnectionGUID: bR/LYfzRQTSM8lS/0I1O5g==
X-CSE-MsgGUID: CfY0FifRSPypGLQj1FcQoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="86131663"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="86131663"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 01:27:37 -0700
X-CSE-ConnectionGUID: jgr/78pSTnW+eQNFl3ttBQ==
X-CSE-MsgGUID: nAsLMnuUTEG0Inx+PrPHOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="181284823"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 01:27:32 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzswM-0005Al-0T;
	Sat, 20 Sep 2025 08:27:30 +0000
Date: Sat, 20 Sep 2025 16:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
Message-ID: <202509201640.ikJun7XS-lkp@intel.com>
References: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250918]
[also build test ERROR on v6.17-rc6]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next rppt-memblock/fixes linus/master v6.17-rc6 v6.17-rc5 v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-thp-replace-folio_memcg-with-folio_memcg_charged/20250919-115219
base:   next-20250918
patch link:    https://lore.kernel.org/r/eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its variants
config: x86_64-buildonly-randconfig-001-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201640.ikJun7XS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201640.ikJun7XS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201640.ikJun7XS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/huge_memory.c:1105:24: error: incomplete definition of type 'struct mem_cgroup'
    1105 |         queue = memcg ? &memcg->deferred_split_queue :
         |                          ~~~~~^
   include/linux/mm_types.h:35:8: note: forward declaration of 'struct mem_cgroup'
      35 | struct mem_cgroup;
         |        ^
   mm/huge_memory.c:1119:24: error: incomplete definition of type 'struct mem_cgroup'
    1119 |         queue = memcg ? &memcg->deferred_split_queue :
         |                          ~~~~~^
   include/linux/mm_types.h:35:8: note: forward declaration of 'struct mem_cgroup'
      35 | struct mem_cgroup;
         |        ^
   2 errors generated.


vim +1105 mm/huge_memory.c

  1098	
  1099	static struct deferred_split *folio_split_queue_lock(struct folio *folio)
  1100	{
  1101		struct mem_cgroup *memcg;
  1102		struct deferred_split *queue;
  1103	
  1104		memcg = folio_memcg(folio);
> 1105		queue = memcg ? &memcg->deferred_split_queue :
  1106				&NODE_DATA(folio_nid(folio))->deferred_split_queue;
  1107		spin_lock(&queue->split_queue_lock);
  1108	
  1109		return queue;
  1110	}
  1111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

