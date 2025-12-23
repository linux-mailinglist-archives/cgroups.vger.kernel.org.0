Return-Path: <cgroups+bounces-12598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A3CD7AF6
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 02:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712633012256
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B734AAE4;
	Tue, 23 Dec 2025 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsAZfz7w"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8334A79B;
	Tue, 23 Dec 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454058; cv=none; b=DAKo+FGI8ETkAd5hG8Pieuk0i6Be+Y4RoVgrl1qWE/238rwHjV0So9D+TqPXhLwuh3lKSKSSbacf3RcTwU3mLGyYMdX2tIZeVfxE52iBQ6wpXj+f5qObrsvGP9oFG7+TPImunq3L7+AkgW9CE6WUJsGYCJgZmsx4x/vUbdfMifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454058; c=relaxed/simple;
	bh=p8QndN5AyrEGYCocKeThKwfhP7p3sqHksByq85sFU24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or+IaZXjDgeXAsaCbEpd0SpgUWSHJyQlNmyL08x4iSlcHQkVWdfX3lHmG74V9FQEx5BtEcUJSpQp8f7cJ1xHmIy1IwruCoUUvfMdgUOV+qKZpMaUUrxTooT44hmdDBVCg9f2QFW1/ViXXKCZQ8Rf1jWXwmdkWgBXDa7qqxVGjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsAZfz7w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766454057; x=1797990057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p8QndN5AyrEGYCocKeThKwfhP7p3sqHksByq85sFU24=;
  b=dsAZfz7wLQoygcigKybUHZXfiCgDjKOmmETOmCYaHLeDr+zSCNHPUBXo
   3DMtIq2NKJ/SJhkUmmax/PKjlFBngVS7tpvA4p1YvuQO+xS7Xd01mGcVh
   XCcTdYaa58+qw7sIPuYrjIlEQBrpi54UHRlAsKQlRDN+kvo/pzfzV0TuV
   qdoohBIwyCR5dmkuPDA/M4HZRvHLTn5hDjG++zFufLdLJYTrM5YfM0ZAg
   jAmYJj6FkJEfOH2rRKnHJP6ZOAMgCmNQjJNOdGE1Dl5HDvpGaiWT9RJRr
   xl9ZyIDmMJxywNhl2ad2kRvAygL3A5dCS/5xC16Ll7d+442nEIVdyn9nk
   Q==;
X-CSE-ConnectionGUID: 4C8nY8VTTYK3Tsj/KcR6Yg==
X-CSE-MsgGUID: NNvNZYu8TC+dy7fGL8+nFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="90966472"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="90966472"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 17:40:56 -0800
X-CSE-ConnectionGUID: HH3KO3ruSFaqe8T5HyubLA==
X-CSE-MsgGUID: zy40TVviR8+wEyDh/5xXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199966668"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 Dec 2025 17:40:50 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXrOK-000000001Ij-25Ic;
	Tue, 23 Dec 2025 01:40:48 +0000
Date: Tue, 23 Dec 2025 09:40:39 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
	vbabka@suse.cz
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
	glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
	mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
	shakeel.butt@linux.dev, surenb@google.com,
	vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
	harry.yoo@oracle.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Message-ID: <202512231042.EEBUajQY-lkp@intel.com>
References: <20251222110843.980347-8-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222110843.980347-8-harry.yoo@oracle.com>

Hi Harry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Harry-Yoo/mm-slab-use-unsigned-long-for-orig_size-to-ensure-proper-metadata-align/20251222-191144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251222110843.980347-8-harry.yoo%40oracle.com
patch subject: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext array from leftover
config: x86_64-buildonly-randconfig-001-20251223 (https://download.01.org/0day-ci/archive/20251223/202512231042.EEBUajQY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512231042.EEBUajQY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512231042.EEBUajQY-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/slub.c:2140:33: error: passing 'union codetag_ref' to parameter of incompatible type 'union codetag_ref *'; take the address with &
    2140 |                 if (unlikely(is_codetag_empty(ext->ref))) {
         |                                               ^~~~~~~~
         |                                               &
   include/linux/compiler.h:47:41: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                                           ^
   include/linux/compiler.h:32:34: note: expanded from macro '__branch_check__'
      32 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                                       ^
   include/linux/alloc_tag.h:52:56: note: passing argument to parameter 'ref' here
      52 | static inline bool is_codetag_empty(union codetag_ref *ref)
         |                                                        ^
   mm/slub.c:2140:33: error: passing 'union codetag_ref' to parameter of incompatible type 'union codetag_ref *'; take the address with &
    2140 |                 if (unlikely(is_codetag_empty(ext->ref))) {
         |                                               ^~~~~~~~
         |                                               &
   include/linux/compiler.h:47:68: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                                                                      ^
   include/linux/compiler.h:34:19: note: expanded from macro '__branch_check__'
      34 |                                              expect, is_constant);      \
         |                                                      ^~~~~~~~~~~
   include/linux/alloc_tag.h:52:56: note: passing argument to parameter 'ref' here
      52 | static inline bool is_codetag_empty(union codetag_ref *ref)
         |                                                        ^
>> mm/slub.c:2326:16: error: use of undeclared identifier 'MEMCG_DATA_OBJEXTS'
    2326 |                         obj_exts |= MEMCG_DATA_OBJEXTS;
         |                                     ^
   3 errors generated.


vim +/MEMCG_DATA_OBJEXTS +2326 mm/slub.c

  2302	
  2303	/*
  2304	 * Try to allocate slabobj_ext array from unused space.
  2305	 * This function must be called on a freshly allocated slab to prevent
  2306	 * concurrency problems.
  2307	 */
  2308	static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
  2309	{
  2310		void *addr;
  2311		unsigned long obj_exts;
  2312	
  2313		if (!need_slab_obj_exts(s))
  2314			return;
  2315	
  2316		if (obj_exts_fit_within_slab_leftover(s, slab)) {
  2317			addr = slab_address(slab) + obj_exts_offset_in_slab(s, slab);
  2318			addr = kasan_reset_tag(addr);
  2319			obj_exts = (unsigned long)addr;
  2320	
  2321			get_slab_obj_exts(obj_exts);
  2322			memset(addr, 0, obj_exts_size_in_slab(slab));
  2323			put_slab_obj_exts(obj_exts);
  2324	
  2325			if (IS_ENABLED(CONFIG_MEMCG))
> 2326				obj_exts |= MEMCG_DATA_OBJEXTS;
  2327			slab->obj_exts = obj_exts;
  2328			slab_set_stride(slab, sizeof(struct slabobj_ext));
  2329		}
  2330	}
  2331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

