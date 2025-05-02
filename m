Return-Path: <cgroups+bounces-7988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE87AA74EA
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A08B3A1EF5
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF72561AA;
	Fri,  2 May 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S66s4R3F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C823A562
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195959; cv=none; b=Yi6LJ4Tls2WQ+J7I4GKEeHDrfMpYPljry2L2X0JP5kyP5TM/1ePJiaV1/+l6MFK1HerrizkKmsXI+lLUbfF1obPDXX8cENY7jwr15KHL8/yOElSWnnXt81oQE1/tdAxhGDgHEnckVPdKetLrpGmWruE5sWIBjRq0StvV03ldvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195959; c=relaxed/simple;
	bh=sMDIVEpmzzZsg8Vw0VMY7gk8A5TS0aYI5ic94kJp8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic19Rje5JVwXVn01+FljQiK6DtdsWGMLLBWWkmAVrADZaAHJTVZFMF4WlgxpQYr5WM4VRK0+mE5v1tmR++X4xPAhIg3xNK3SqCo4U6iWQMEPMx+/pu88YVWps3MNGCKrNiyDn4+noQU0XMmAJoRjxi/Mtwges5zqEiJj8xygBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S66s4R3F; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746195955; x=1777731955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sMDIVEpmzzZsg8Vw0VMY7gk8A5TS0aYI5ic94kJp8rE=;
  b=S66s4R3FKZwIDXHilOgY4qYq4ooY87ynSwQMUDUcdDcZ+twVhlByr8wl
   hAasikzsMWlg2blMNFsB74PXN4eQXEaiDx7fQOQqn7xzKXI/Dq5PzRUb1
   M/9+9mGNZp/t5vz5XIVGmZmWfjCSiAXQTvUjfyKlYD+EXyFhSX/PpTAuW
   cbU/In7N0CWxoE6Ywq80Qo3imDHHH8NcgUTm6++eicyl4SfQVCxGATfJ4
   jKhHcFXTcgXzBRvvz9Sx5MUi/8aSn2MUvpVsVkRWhT2w6Ke16sRLkDZMW
   1zu4B7WoofQZUku7FfqxbMYimh9dqC4MletN0kX3Jsd4o9Y+7ZNc16KAu
   A==;
X-CSE-ConnectionGUID: h6gHiksyRK2TgLhL4Zi/Wg==
X-CSE-MsgGUID: fnSpNd3GSb6hNfg+bY7AJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59261851"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59261851"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:25:54 -0700
X-CSE-ConnectionGUID: nePlqO1UReus5rdz7izWkQ==
X-CSE-MsgGUID: tXIfgF0SRwGLv7DYdsH0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139796751"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 May 2025 07:25:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uArKl-0004nV-0N;
	Fri, 02 May 2025 14:25:47 +0000
Date: Fri, 2 May 2025 22:24:51 +0800
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
Message-ID: <202505022223.9sTn2H1l-lkp@intel.com>
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
[cannot apply to next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/memcg-add-hooks-for-gpu-memcg-charging-uncharging/20250502-123650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250502034046.1625896-4-airlied%40gmail.com
patch subject: [PATCH 3/5] ttm: add initial memcg integration. (v2)
config: arc-randconfig-002-20250502 (https://download.01.org/0day-ci/archive/20250502/202505022223.9sTn2H1l-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250502/202505022223.9sTn2H1l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505022223.9sTn2H1l-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/ttm/tests/ttm_resource_test.c: In function 'ttm_sys_man_free_basic':
>> drivers/gpu/drm/ttm/tests/ttm_resource_test.c:305:39: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     305 |         ttm_resource_alloc(bo, place, &res, NULL);
         |                                       ^~~~
         |                                       |
         |                                       struct ttm_resource **
   In file included from drivers/gpu/drm/ttm/tests/ttm_resource_test.c:5:
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/gpu/drm/ttm/tests/ttm_resource_test.c:305:9: error: too few arguments to function 'ttm_resource_alloc'
     305 |         ttm_resource_alloc(bo, place, &res, NULL);
         |         ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c: In function 'ttm_bo_validate_no_placement_signaled':
>> drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c:545:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     545 |         err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
         |                                             ^~~~~~~~~~~~~
         |                                             |
         |                                             struct ttm_resource **
   In file included from drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c:8:
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c:545:15: error: too few arguments to function 'ttm_resource_alloc'
     545 |         err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c: In function 'ttm_bo_validate_no_placement_not_signaled':
   drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c:606:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     606 |         err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
         |                                             ^~~~~~~~~~~~~
         |                                             |
         |                                             struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c:606:15: error: too few arguments to function 'ttm_resource_alloc'
     606 |         err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c: In function 'ttm_bo_unreserve_basic':
>> drivers/gpu/drm/ttm/tests/ttm_bo_test.c:261:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     261 |         err = ttm_resource_alloc(bo, place, &res1, NULL);
         |                                             ^~~~~
         |                                             |
         |                                             struct ttm_resource **
   In file included from drivers/gpu/drm/ttm/tests/ttm_bo_test.c:13:
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/gpu/drm/ttm/tests/ttm_bo_test.c:261:15: error: too few arguments to function 'ttm_resource_alloc'
     261 |         err = ttm_resource_alloc(bo, place, &res1, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:267:39: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     267 |         ttm_resource_alloc(bo, place, &res2, NULL);
         |                                       ^~~~~
         |                                       |
         |                                       struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:267:9: error: too few arguments to function 'ttm_resource_alloc'
     267 |         ttm_resource_alloc(bo, place, &res2, NULL);
         |         ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c: In function 'ttm_bo_unreserve_pinned':
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:303:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     303 |         err = ttm_resource_alloc(bo, place, &res1, NULL);
         |                                             ^~~~~
         |                                             |
         |                                             struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:303:15: error: too few arguments to function 'ttm_resource_alloc'
     303 |         err = ttm_resource_alloc(bo, place, &res1, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:308:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     308 |         err = ttm_resource_alloc(bo, place, &res2, NULL);
         |                                             ^~~~~
         |                                             |
         |                                             struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:308:15: error: too few arguments to function 'ttm_resource_alloc'
     308 |         err = ttm_resource_alloc(bo, place, &res2, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c: In function 'ttm_bo_unreserve_bulk':
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:358:46: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     358 |         err = ttm_resource_alloc(bo1, place, &res1, NULL);
         |                                              ^~~~~
         |                                              |
         |                                              struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:358:15: error: too few arguments to function 'ttm_resource_alloc'
     358 |         err = ttm_resource_alloc(bo1, place, &res1, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:366:46: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     366 |         err = ttm_resource_alloc(bo2, place, &res2, NULL);
         |                                              ^~~~~
         |                                              |
         |                                              struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:366:15: error: too few arguments to function 'ttm_resource_alloc'
     366 |         err = ttm_resource_alloc(bo2, place, &res2, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c: In function 'ttm_bo_put_basic':
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:404:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     404 |         err = ttm_resource_alloc(bo, place, &res, NULL);
         |                                             ^~~~
         |                                             |
         |                                             struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:404:15: error: too few arguments to function 'ttm_resource_alloc'
     404 |         err = ttm_resource_alloc(bo, place, &res, NULL);
         |               ^~~~~~~~~~~~~~~~~~
   include/drm/ttm/ttm_resource.h:448:5: note: declared here
     448 | int ttm_resource_alloc(struct ttm_buffer_object *bo,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c: In function 'ttm_bo_pin_unpin_resource':
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:521:45: error: passing argument 3 of 'ttm_resource_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     521 |         err = ttm_resource_alloc(bo, place, &res, NULL);
         |                                             ^~~~
         |                                             |
         |                                             struct ttm_resource **
   include/drm/ttm/ttm_resource.h:450:50: note: expected 'struct ttm_operation_ctx *' but argument is of type 'struct ttm_resource **'
     450 |                        struct ttm_operation_ctx *ctx,


vim +/ttm_resource_alloc +305 drivers/gpu/drm/ttm/tests/ttm_resource_test.c

9afc1e0aa4851e Karolina Stolarek 2023-11-29  288  
9afc1e0aa4851e Karolina Stolarek 2023-11-29  289  static void ttm_sys_man_free_basic(struct kunit *test)
9afc1e0aa4851e Karolina Stolarek 2023-11-29  290  {
9afc1e0aa4851e Karolina Stolarek 2023-11-29  291  	struct ttm_resource_test_priv *priv = test->priv;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  292  	struct ttm_resource_manager *man;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  293  	struct ttm_buffer_object *bo;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  294  	struct ttm_place *place;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  295  	struct ttm_resource *res;
07430fa5248964 Karolina Stolarek 2024-06-12  296  	u32 mem_type = TTM_PL_SYSTEM;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  297  
9afc1e0aa4851e Karolina Stolarek 2023-11-29  298  	ttm_init_test_mocks(test, priv, mem_type, 0);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  299  	bo = priv->bo;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  300  	place = priv->place;
9afc1e0aa4851e Karolina Stolarek 2023-11-29  301  
9afc1e0aa4851e Karolina Stolarek 2023-11-29  302  	res = kunit_kzalloc(test, sizeof(*res), GFP_KERNEL);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  303  	KUNIT_ASSERT_NOT_NULL(test, res);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  304  
2b624a2c18656e Maarten Lankhorst 2024-12-04 @305  	ttm_resource_alloc(bo, place, &res, NULL);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  306  
9afc1e0aa4851e Karolina Stolarek 2023-11-29  307  	man = ttm_manager_type(priv->devs->ttm_dev, mem_type);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  308  	man->func->free(man, res);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  309  
9afc1e0aa4851e Karolina Stolarek 2023-11-29  310  	KUNIT_ASSERT_TRUE(test, list_empty(&man->lru[bo->priority]));
9afc1e0aa4851e Karolina Stolarek 2023-11-29  311  	KUNIT_ASSERT_EQ(test, man->usage, 0);
9afc1e0aa4851e Karolina Stolarek 2023-11-29  312  }
9afc1e0aa4851e Karolina Stolarek 2023-11-29  313  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

