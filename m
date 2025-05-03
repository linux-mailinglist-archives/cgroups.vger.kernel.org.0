Return-Path: <cgroups+bounces-8002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA42AA7E04
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 04:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69C03B01BA
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014C128816;
	Sat,  3 May 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er9JIusP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F9145A18
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238258; cv=none; b=pgpFkF5Ru5CfdOIt0lbWvnmbCMnAlrjjWjq64Kj72QDbu1pFjoLlDl+NAiMMmn7jLt++vpGCm9qB9Um08subJVv0qTTdGQXCIQiyen7FTyuOJ/kKen+83XDIaM7TweIOYYzUFyVWy2v4BizEDlqr/relUJbn9WO6c4p+70wwdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238258; c=relaxed/simple;
	bh=suGJnGTvTVJcrRwlDbdnRQ8llVaUDsm44ybcEgCTxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO3rAj/XDzjbz1HglucWh2S89khwwD01oYCCYE3R9rR6J65/W+ZCrtNicKj3yo3NyCsjkqNh8EJytXDCQ4ZBeFeiQ7+aGpIdxDxtqJzPfMwPyxH1DUxKPvxhyjC3bqyL3aSEITEjxjv5FHWL79altebWJvVyvYPGDeOURGYaPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Er9JIusP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746238257; x=1777774257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suGJnGTvTVJcrRwlDbdnRQ8llVaUDsm44ybcEgCTxmE=;
  b=Er9JIusP9dfRWVnkeJXyahW5c/J2Q/fCyzMUvCqjAQ5xv1KWgcB4hjMJ
   UxdftVgH3DryWSF7mRiSRnU0NXg4QyVNc5S7R2MCl7aEMIbdRXACqeS5S
   9XgaXgOhQWPfRFzevAmSBqgruZLpCB3wNmAjBM37Gm/tj5NfvNoX+QklU
   XTK9oFSunyvQuaZQEjg+9ZqkFX+z2gTyIoM+wD2WchP15xejr4t2EYxeL
   mTcSb9ykM3na5fC/YcVY4Ov++Ai/g5dP8FSicNTcbMjDy4jkNIG9XzbDB
   /lskZNfJGSqtRDtQ2m8nOXViCdt0+GjWBXLeS3kB9uff16vr0s4bJs1Fh
   w==;
X-CSE-ConnectionGUID: CrjD6ZqITUa2ERLKvbVZcQ==
X-CSE-MsgGUID: sMwuIsckRq+O3Nrf89z9Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48069430"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48069430"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 19:10:56 -0700
X-CSE-ConnectionGUID: hmB4nToNTA6onfnAFvsS2w==
X-CSE-MsgGUID: an6spcJaTHymrNjFkKKbng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="135105192"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 May 2025 19:10:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uB2L1-0005A1-20;
	Sat, 03 May 2025 02:10:47 +0000
Date: Sat, 3 May 2025 10:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [PATCH 3/5] ttm: add initial memcg integration. (v2)
Message-ID: <202505030927.6cZ0SdOU-lkp@intel.com>
References: <20250502034046.1625896-4-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502034046.1625896-4-airlied@gmail.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.15-rc4]
[cannot apply to drm-misc/drm-misc-next drm-tip/drm-tip next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/memcg-add-hooks-for-gpu-memcg-charging-uncharging/20250502-123650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250502034046.1625896-4-airlied%40gmail.com
patch subject: [PATCH 3/5] ttm: add initial memcg integration. (v2)
config: s390-randconfig-001-20250503 (https://download.01.org/0day-ci/archive/20250503/202505030927.6cZ0SdOU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250503/202505030927.6cZ0SdOU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505030927.6cZ0SdOU-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/gpu/drm/ttm/ttm_resource.o: in function `ttm_resource_free':
>> drivers/gpu/drm/ttm/ttm_resource.c:443: undefined reference to `mem_cgroup_uncharge_gpu'
   s390-linux-ld: drivers/gpu/drm/ttm/ttm_resource.o: in function `ttm_resource_alloc':
   drivers/gpu/drm/ttm/ttm_resource.c:408: undefined reference to `mem_cgroup_uncharge_gpu'
>> s390-linux-ld: drivers/gpu/drm/ttm/ttm_resource.c:400: undefined reference to `mem_cgroup_charge_gpu'


vim +443 drivers/gpu/drm/ttm/ttm_resource.c

   374	
   375	int ttm_resource_alloc(struct ttm_buffer_object *bo,
   376			       const struct ttm_place *place,
   377			       struct ttm_operation_ctx *ctx,
   378			       struct ttm_resource **res_ptr,
   379			       struct dmem_cgroup_pool_state **ret_limit_pool)
   380	{
   381		struct ttm_resource_manager *man =
   382			ttm_manager_type(bo->bdev, place->mem_type);
   383		struct dmem_cgroup_pool_state *pool = NULL;
   384		struct mem_cgroup *memcg = NULL;
   385		int ret;
   386	
   387		if (man->cg) {
   388			ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
   389			if (ret)
   390				return ret;
   391		}
   392	
   393		if ((place->mem_type == TTM_PL_SYSTEM || place->mem_type == TTM_PL_TT) &&
   394		    ctx->account_op && bo->memcg) {
   395			memcg = bo->memcg;
   396			gfp_t gfp_flags = GFP_USER;
   397			if (ctx->gfp_retry_mayfail)
   398				gfp_flags |= __GFP_RETRY_MAYFAIL;
   399	
 > 400			if (!mem_cgroup_charge_gpu(memcg, bo->base.size >> PAGE_SHIFT, gfp_flags))
   401				return -ENOMEM;
   402		}
   403		ret = man->func->alloc(man, bo, place, res_ptr);
   404		if (ret) {
   405			if (pool)
   406				dmem_cgroup_uncharge(pool, bo->base.size);
   407			if (memcg)
   408				mem_cgroup_uncharge_gpu(memcg, bo->base.size >> PAGE_SHIFT);
   409			return ret;
   410		}
   411	
   412		(*res_ptr)->memcg = memcg;
   413		(*res_ptr)->css = pool;
   414	
   415		spin_lock(&bo->bdev->lru_lock);
   416		ttm_resource_add_bulk_move(*res_ptr, bo);
   417		spin_unlock(&bo->bdev->lru_lock);
   418		return 0;
   419	}
   420	EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_resource_alloc);
   421	
   422	void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res)
   423	{
   424		struct ttm_resource_manager *man;
   425		struct dmem_cgroup_pool_state *pool;
   426		struct mem_cgroup *memcg;
   427	
   428		if (!*res)
   429			return;
   430	
   431		spin_lock(&bo->bdev->lru_lock);
   432		ttm_resource_del_bulk_move(*res, bo);
   433		spin_unlock(&bo->bdev->lru_lock);
   434	
   435		pool = (*res)->css;
   436		memcg = (*res)->memcg;
   437		man = ttm_manager_type(bo->bdev, (*res)->mem_type);
   438		man->func->free(man, *res);
   439		*res = NULL;
   440		if (man->cg)
   441			dmem_cgroup_uncharge(pool, bo->base.size);
   442		if (memcg)
 > 443			mem_cgroup_uncharge_gpu(memcg, bo->base.size >> PAGE_SHIFT);
   444	}
   445	EXPORT_SYMBOL(ttm_resource_free);
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

