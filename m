Return-Path: <cgroups+bounces-8779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C1B0A919
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865FE7B78E6
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C82E717C;
	Fri, 18 Jul 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4wkBgcN"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DB2E62B8;
	Fri, 18 Jul 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858586; cv=none; b=AH6elLXmo3kITsFepjRI1FxQkXEqnp3oh6rK9G+EXCX79tptCnwd1mezDhW4dNC5ftUKK7idleY15a154rmeI8Vga75u3QkNGa3WwgddxIPH7KL1f6OLMG5FWvO9vDJ51dCGPIUmRITyBJhdZRc7RrErAExR932x0BuGZp0JtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858586; c=relaxed/simple;
	bh=ooxJn1LruN/YvEQn9D12u6VstnqMl47g6HfhdNYMq3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udJqeItC9CdBzi7CvVr2vkTGNGAfNByjuUrXozO4UOQn0QZWXUtbbjKNVjeHeeyVgoMUqwYJwHpRGJMkZUAsfJfUmf6iZ3YTYppgekPvoIu8C0HHei9Bc21bxVQdcC5VQ6R4sSjPyCstWWrH9CN5qWcDVeaWs8RXSpRLOkruFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4wkBgcN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752858584; x=1784394584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ooxJn1LruN/YvEQn9D12u6VstnqMl47g6HfhdNYMq3Y=;
  b=j4wkBgcNqayFwKLxZO0t4gdu+DbjhrNDT1R19Py3/sw+mzbm/g7cXEZr
   bRaRJrnX8LpPwde4teIU0I8460BHBAItxN9Ydjm81ZlJk+lofxNvIFT6J
   bVFtaDwtHte60eXtff58uSrNXzEEeow+HO3/xsT80k+8ZlN0z0X4wKeon
   V0NI/X3I14AmZr5JRQz4TMex7VkPV1iDMdSMLueBSb9B+PhoTYpveGPYa
   BXNEGnPG/YiCBCzuDA1ho9J91jXlJW9dSQPVSirLCdz0ZACoZ7XLZ24Cy
   C6QAKJKqJXHkL8IJDPw9XvADpCmBB9PyMZ2EnfoLOsT3OZcTSwdpwTyyA
   Q==;
X-CSE-ConnectionGUID: Ps/oUl1YSyWNlnuSz05KIA==
X-CSE-MsgGUID: Ll/6XQCQQGSDhIj6vZWlHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55314253"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55314253"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 10:09:43 -0700
X-CSE-ConnectionGUID: Ene6RaO6QquDZSHnOFG6jA==
X-CSE-MsgGUID: EVNguCNxQU2ugcLqigJ96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="163735712"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2025 10:09:38 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucoaV-000EuZ-0P;
	Fri, 18 Jul 2025 17:09:35 +0000
Date: Sat, 19 Jul 2025 01:08:46 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <202507190037.RCDNmMsJ-lkp@intel.com>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716202006.3640584-2-youngjun.park@lge.com>

Hi Youngjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-memcg-Introduce-infrastructure-for-cgroup-based-swap-priority/20250717-042648
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250716202006.3640584-2-youngjun.park%40lge.com
patch subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
config: sparc64-randconfig-r054-20250718 (https://download.01.org/0day-ci/archive/20250719/202507190037.RCDNmMsJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190037.RCDNmMsJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507190037.RCDNmMsJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/swap.h:7,
                    from mm/swap_cgroup_priority.c:16:
   mm/swap_cgroup_priority.c: In function 'get_swap_cgroup_priority':
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/rcupdate.h:532:17: note: in definition of macro '__rcu_dereference_check'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/rcupdate.h:532:38: note: in definition of macro '__rcu_dereference_check'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
   In file included from <command-line>:
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/compiler_types.h:518:27: note: in definition of macro '__unqual_scalar_typeof'
     518 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:390,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:56,
                    from include/linux/swap.h:5:
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
>> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                                     ^~
   include/linux/rcupdate.h:535:19: note: in definition of macro '__rcu_dereference_check'
     535 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
     115 |         return rcu_dereference(memcg->swap_priority);
         |                ^~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c: In function 'show_swap_cgroup_priority':
   mm/swap_cgroup_priority.c:186:30: error: invalid use of undefined type 'struct mem_cgroup'
     186 |         swap_priority = memcg->swap_priority;
         |                              ^~
   mm/swap_cgroup_priority.c: In function 'swap_alloc_cgroup_priority':
   mm/swap_cgroup_priority.c:285:26: error: invalid use of undefined type 'struct mem_cgroup'
     285 |                 if (memcg->swap_priority != swap_priority)
         |                          ^~
   mm/swap_cgroup_priority.c: In function 'apply_swap_cgroup_priority':
   mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                                              ^~
   include/linux/rcupdate.h:532:17: note: in definition of macro '__rcu_dereference_check'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                         ^~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                                              ^~
   include/linux/rcupdate.h:532:38: note: in definition of macro '__rcu_dereference_check'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                         ^~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                                              ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                         ^~~~~~~~~~~~~~~
   mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
     638 |         swap_priority = rcu_dereference(memcg->swap_priority);
         |                                              ^~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)


vim +115 mm/swap_cgroup_priority.c

  > 16	#include <linux/swap.h>
    17	#include <linux/rcupdate.h>
    18	#include <linux/memcontrol.h>
    19	#include <linux/plist.h>
    20	#include "swap.h"
    21	#include "swap_cgroup_priority.h"
    22	#include "memcontrol-v1.h"
    23	
    24	static LIST_HEAD(swap_cgroup_priority_list);
    25	
    26	/*
    27	 * struct swap_cgroup_priority
    28	 *
    29	 * This structure is RCU protected. Its lifecycle is determined by its
    30	 * owning memcg or when its 'distance' reaches zero. The 'distance' field
    31	 * tracks priority differences from global swap. If zero, and its default_prio
    32	 * follows global swap priority(SWAP_PRIORITY_GLOBAL), the object is destroyed.
    33	 *
    34	 * pnode - Array of pointers to swap device priority nodes.
    35	 * owner - The owning memory cgroup.
    36	 * rcu - RCU free callback.
    37	 * link - Global linked list entry.
    38	 * least_priority - Current lowest priority.
    39	 * distance - Priority differences from global swap priority.
    40	 * default_prio - Default priority for this cgroup.
    41	 * plist - Priority list head.
    42	 */
    43	struct swap_cgroup_priority {
    44		struct swap_cgroup_priority_pnode *pnode[MAX_SWAPFILES];
    45		struct mem_cgroup *owner;
    46	
    47		union {
    48			struct rcu_head rcu;
    49			struct list_head link;
    50		};
    51	
    52		int least_priority;
    53		s8 distance;
    54		int default_prio;
    55		struct plist_head plist[];
    56	};
    57	
    58	/*
    59	 * struct swap_cgroup_priority_pnode
    60	 *
    61	 * This structure represents a priority node for a specific swap device
    62	 * within a cgroup.
    63	 *
    64	 * swap - Pointer to the associated swap device.
    65	 * id - Unique identifier for the swap device.
    66	 * prio - Configured priority for this device.
    67	 * avail_lists - Connections to various priority lists.
    68	 */
    69	struct swap_cgroup_priority_pnode {
    70		struct swap_info_struct *swap;
    71		u64 id;
    72		signed short prio;
    73		struct plist_node avail_lists[];
    74	};
    75	
    76	/*
    77	 * Even with a zero distance, a swap device isn't assigned if it doesn't
    78	 * meet global swap priority conditions; thus, we don't clear it.
    79	 */
    80	static bool should_clear_swap_cgroup_priority(
    81		struct swap_cgroup_priority *swap_priority)
    82	{
    83		WARN_ON_ONCE(swap_priority->distance < 0 ||
    84			swap_priority->distance > MAX_SWAPFILES);
    85	
    86		if (swap_priority->distance == 0 &&
    87		    swap_priority->default_prio == SWAP_PRIORITY_GLOBAL)
    88			return true;
    89	
    90		return false;
    91	}
    92	
    93	/*
    94	 * swapdev_id
    95	 *
    96	 * A unique identifier for a swap device.
    97	 *
    98	 * This ID ensures stable identification for users and crucial synchronization
    99	 * for swap cgroup priority settings. It provides a reliable reference even if
   100	 * device paths or numbers change.
   101	 */
   102	static atomic64_t swapdev_id_counter;
   103	
   104	void get_swapdev_id(struct swap_info_struct *si)
   105	{
   106		si->id = atomic64_inc_return(&swapdev_id_counter);
   107	}
   108	
   109	static struct swap_cgroup_priority *get_swap_cgroup_priority(
   110		struct mem_cgroup *memcg)
   111	{
   112		if (!memcg)
   113			return NULL;
   114	
 > 115		return rcu_dereference(memcg->swap_priority);
   116	}
   117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

