Return-Path: <cgroups+bounces-10307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81377B8C194
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39983585065
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4A1F4621;
	Sat, 20 Sep 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9UA6nkz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C5188A0C;
	Sat, 20 Sep 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354214; cv=none; b=QTBZiWihHp9K8nkiY0aqJ2d6oqpSR7wRv+mNOrcPsBLLX22Beh/rhksKjqU+fas/msNv+WBUycGBYKdGvMHUTQgxWk9kUgQKQCqEpZj1fjlaKM56gS8pouPhQyaCN4gZ8S/I19OrtXeTkXdI2Xh1efQ0na41RFqtBpymE/pf5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354214; c=relaxed/simple;
	bh=kEwh/ekCl/otnpe61Q+7M++Qui9Q62NvcImp583uS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIQWsGYgHRQ0jTQ9x03pi1DFAFYa5F00eMHAulePLw0dgp8VGyfRIdFPNWfAiU824y2sgQVgbH+TNFpCWqSrpHe+IWAiqYU9iDhxrvJjIaRM6TLEInBRRqBa5gs5OOSbwvuygsXSNh8x00O93ePbgMnaGWd8xrlicyTFasYg2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9UA6nkz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758354213; x=1789890213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kEwh/ekCl/otnpe61Q+7M++Qui9Q62NvcImp583uS/s=;
  b=f9UA6nkzE5xE0ibrfRk/qti7srvCUO8aQPu3q3SvhkLMuhtWWNiTs0dK
   /hy1lhaneU9DtdYqBwNCfPNFtYo4IgHyFs3OWnSUEls+HXVAmmLQVLZ+T
   aeOJewzhms9ACi0jm/DxZp059nxqKhggC0XOjL9kBO4j9m+/Z3EBKlvkS
   6CIM7UE0126PGmP7ZLFUgEMn/6Tazl8en7egNZ+rphv+SvWtxdkfOIZyX
   VZoiFt81cyHF0vBm4rz2A3N/Ikg+pcQqn9Z3/ZV7CdCjQAdJpWB63ZJEP
   WmdeIdwhJq4w976FcJRomwaGrRjuDpQt9UUPSaOXl7OMH4q4Og0Er+c+v
   w==;
X-CSE-ConnectionGUID: aR5VbE9ESP6JQ2/tWG7kfA==
X-CSE-MsgGUID: oCfVBuW6R+ehxiw5WF3scw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71798360"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="71798360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 00:43:33 -0700
X-CSE-ConnectionGUID: XhG2d+HRTmeSVCMqd9nXog==
X-CSE-MsgGUID: YTridhCOTma5012IF8a9Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="206968748"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Sep 2025 00:43:27 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzsFh-00058h-0d;
	Sat, 20 Sep 2025 07:43:25 +0000
Date: Sat, 20 Sep 2025 15:43:18 +0800
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <202509201556.QAvYX4v3-lkp@intel.com>
References: <bbe3bf8bfce081fdf0815481b2a0c83b89b095b8.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe3bf8bfce081fdf0815481b2a0c83b89b095b8.1758253018.git.zhengqi.arch@bytedance.com>

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
patch link:    https://lore.kernel.org/r/bbe3bf8bfce081fdf0815481b2a0c83b89b095b8.1758253018.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH 4/4] mm: thp: reparent the split queue during memcg offline
config: x86_64-randconfig-004-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201556.QAvYX4v3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201556.QAvYX4v3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201556.QAvYX4v3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memcontrol.c:3890:2: error: call to undeclared function 'reparent_deferred_split_queue'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3890 |         reparent_deferred_split_queue(memcg);
         |         ^
   1 error generated.


vim +/reparent_deferred_split_queue +3890 mm/memcontrol.c

  3877	
  3878	static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
  3879	{
  3880		struct mem_cgroup *memcg = mem_cgroup_from_css(css);
  3881	
  3882		memcg1_css_offline(memcg);
  3883	
  3884		page_counter_set_min(&memcg->memory, 0);
  3885		page_counter_set_low(&memcg->memory, 0);
  3886	
  3887		zswap_memcg_offline_cleanup(memcg);
  3888	
  3889		memcg_offline_kmem(memcg);
> 3890		reparent_deferred_split_queue(memcg);
  3891		reparent_shrinker_deferred(memcg);
  3892		wb_memcg_offline(memcg);
  3893		lru_gen_offline_memcg(memcg);
  3894	
  3895		drain_all_stock(memcg);
  3896	
  3897		mem_cgroup_id_put(memcg);
  3898	}
  3899	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

