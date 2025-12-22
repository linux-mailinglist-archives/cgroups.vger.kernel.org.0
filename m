Return-Path: <cgroups+bounces-12594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802BCD776D
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 00:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21688302D5ED
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A4335572;
	Mon, 22 Dec 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr2UDou9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885C3176EB;
	Mon, 22 Dec 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446675; cv=none; b=nFa0Oxjr1/JK5K1yPmmsZdONvfKnPzPob2/KJ6YDAV8TDMrYiFxZRdJqhE+WaHy58ZHcGgznNUgFp+TlKx5ltHA3mynxDEKWsiI2mT9w7OLorzlEkJRqesdp1t7mOMXgdWw6V16dBOvMS0N039e8HswRaBP8fdJVI0ptBU/eCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446675; c=relaxed/simple;
	bh=FnuE/O9HxUgy9+sc5bMXa0KAmbMJC+TFTgxYzciborU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyWxYgAzvveUwMKqOTCMKSZi/yumKisDsA198y8mEu3Uor87eHlMg9HvY9tLET9AZ851u41gFJnzofptXjxLKrEtdWyPO2HK4qxCYoLk7xUDSULf6dqErHkLjZxpISoXHluZpWZUpUTS6K+v0cf/Q4RhTDb0ZN+KIPPaxYJf2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr2UDou9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766446674; x=1797982674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FnuE/O9HxUgy9+sc5bMXa0KAmbMJC+TFTgxYzciborU=;
  b=mr2UDou9CryXBRBA4+/2d+AonhVV08+YPuaVjGorxfktIaH9DBoUTZqS
   UFE4+2JO5C4A3x9DySfGI/2LAjVEJ84Yw5IRvIE+uYKzBEse5QvZkVh80
   t/sJDoSposqlqc47zADW/8bfL1LynmZdtTJv/ZTszoZtlLnJz4sU+AHHR
   gGNWWazb5UY+DNX/qOXxmj9uqBksqyMSK8tzOg5cQYe9gv6dwXEntjWwP
   owyjsaab0Eim4Z2LWjfgeZ8YC881lzLsYltjoyJMarmhiaOucK2+nD582
   xOkcRg274xc02gMLkphVfk6CCWLLDLoAfcL/Ozr6xUkmmvjb2g3pRW0Zd
   A==;
X-CSE-ConnectionGUID: 0f4O8fxGRyOf7Gq5nMgqsg==
X-CSE-MsgGUID: ai4apUsxRIC0PYg+1zksOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68285669"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68285669"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 15:37:49 -0800
X-CSE-ConnectionGUID: /7rmrmvcQjykLlDXEdLJnQ==
X-CSE-MsgGUID: KqFvZ5MLSmaJFSgmmnDnWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199945998"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 Dec 2025 15:37:43 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXpTB-000000001Dx-40xf;
	Mon, 22 Dec 2025 23:37:41 +0000
Date: Tue, 23 Dec 2025 07:36:46 +0800
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
Subject: Re: [PATCH V4 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <202512230850.bBE4pAZ5-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20251223 (https://download.01.org/0day-ci/archive/20251223/202512230850.bBE4pAZ5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230850.bBE4pAZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230850.bBE4pAZ5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:2056:33: error: passing 'union codetag_ref' to parameter of incompatible type 'union codetag_ref *'; take the address with &
    2056 |                 if (unlikely(is_codetag_empty(ext->ref)))
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
>> mm/slub.c:2056:33: error: passing 'union codetag_ref' to parameter of incompatible type 'union codetag_ref *'; take the address with &
    2056 |                 if (unlikely(is_codetag_empty(ext->ref)))
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
   2 errors generated.


vim +2056 mm/slub.c

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

