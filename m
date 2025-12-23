Return-Path: <cgroups+bounces-12595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B27CD77A2
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 01:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BD373007B66
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374EBA3F;
	Tue, 23 Dec 2025 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+SbMTFR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CB1367;
	Tue, 23 Dec 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766448594; cv=none; b=Su3x4PKDDQ7KOS8j/y7OKyEzKD/cFMjCycItZQ0xhuR7DQoiiCsSjZ9RpVMbphOW3Q3PO7AZwZLeoZ2lDfEOMJJ6VXhU45b+KOfciNRBl/+LpjloDj3bHYhxkfAKJ56dffY4TK/rKmbSucnbIpSYNIFBFfkdrRgtytAwH2/Ynws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766448594; c=relaxed/simple;
	bh=scb8dq1HBfysrB12FXHWH+apjzmHxbCBklwomg04vvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI0Bl0B3iiUjewc657jg+ig6oGYifVQda9XffHVp/FSsw/yPJndEtsJ2bAXoAnwlGYgpZgJINVpDm1roJ1IpLYPH09NVOqTezZBi3gStDTrUrVhmYG0V/f42vWHtyhrZ3h9296zQgOFnNmOOMrkWYMt2urgPn25htbM+gZz87eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+SbMTFR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766448591; x=1797984591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scb8dq1HBfysrB12FXHWH+apjzmHxbCBklwomg04vvQ=;
  b=n+SbMTFR6D/bZDYdkq7FS6NJx0EsqtOnEiOYrFdi8zxE9pXJ4PVBCZh5
   ovh9HmhVZBO5pj8sR61RgW5+t0RaggJk13Dn5tQoXL2MI8ybcScKqUe3u
   3iXbkudeXPDNGAsbJdpLzLg6b5N0Yr2i6eaENwla4OOE8t5QSDkRTvWf6
   y3A7gPRLR8sSi7r2VXaGUFlQCSAfevHJwQZQjnwaGjStq/XbPWtgAzV6P
   bz1ubKh7RROkW+GM+uwdYYVjKs+MeLivQXjC9/+Ly6E/VVuf80BnbjPa9
   +Kfx8feHGNmduUv/Ty+qc6EnD3gT/v7TgftfAwjFDSO9ZWm5o/u+dfZUW
   Q==;
X-CSE-ConnectionGUID: zneKAgtgSrSeVzqyPyZFoA==
X-CSE-MsgGUID: L/249HGHQFywV15Xs1+PDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68058077"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68058077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 16:09:51 -0800
X-CSE-ConnectionGUID: zNGOi2JSQ5GX20sFnuD9QQ==
X-CSE-MsgGUID: 6sBPvKYiRGuXkiAxOW5low==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199634082"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 22 Dec 2025 16:09:45 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXpyB-000000001FR-0Qwm;
	Tue, 23 Dec 2025 00:09:43 +0000
Date: Tue, 23 Dec 2025 08:08:54 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
	vbabka@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, andreyknvl@gmail.com, cl@gentwo.org,
	dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
	rientjes@google.com, roman.gushchin@linux.dev,
	ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
	vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
	harry.yoo@oracle.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V4 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <202512230727.ktAJv4eA-lkp@intel.com>
References: <20251222110843.980347-5-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222110843.980347-5-harry.yoo@oracle.com>

Hi Harry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Harry-Yoo/mm-slab-use-unsigned-long-for-orig_size-to-ensure-proper-metadata-align/20251222-191144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251222110843.980347-5-harry.yoo%40oracle.com
patch subject: [PATCH V4 4/8] mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
config: parisc-randconfig-002-20251223 (https://download.01.org/0day-ci/archive/20251223/202512230727.ktAJv4eA-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230727.ktAJv4eA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230727.ktAJv4eA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/parisc/include/asm/bug.h:97,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/slub.c:13:
   mm/slub.c: In function 'mark_objexts_empty':
>> mm/slub.c:2056:36: error: incompatible type for argument 1 of 'is_codetag_empty'
      if (unlikely(is_codetag_empty(ext->ref)))
                                    ~~~^~~~~
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   In file included from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:19,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/slub.c:13:
   include/linux/alloc_tag.h:52:56: note: expected 'union codetag_ref *' but argument is of type 'union codetag_ref'
    static inline bool is_codetag_empty(union codetag_ref *ref)
                                        ~~~~~~~~~~~~~~~~~~~^~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +/is_codetag_empty +2056 mm/slub.c

  2042	
  2043	static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
  2044	{
  2045		unsigned long slab_exts;
  2046		struct slab *obj_exts_slab;
  2047	
  2048		obj_exts_slab = virt_to_slab(obj_exts);
  2049		slab_exts = slab_obj_exts(obj_exts_slab);
  2050		if (slab_exts) {
  2051			unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
  2052							 obj_exts_slab, obj_exts);
  2053			struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
  2054							       slab_exts, offs);
  2055	
> 2056			if (unlikely(is_codetag_empty(ext->ref)))
  2057				return;
  2058	
  2059			/* codetag should be NULL here */
  2060			WARN_ON(ext->ref.ct);
  2061			set_codetag_empty(&ext->ref);
  2062		}
  2063	}
  2064	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

