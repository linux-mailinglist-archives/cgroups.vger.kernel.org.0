Return-Path: <cgroups+bounces-8838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC0B0DE32
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3258A176074
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9E2EA73D;
	Tue, 22 Jul 2025 14:12:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502602EE991
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193523; cv=none; b=D74nWfj6OPHRhALQnjtoQhpc7rxsM4BkDpxhSvb32Uhl+oH0k2Wik11bRz4qJ4fTadRlL2GiHXi2pOnqAJPWtA172Aob60wB72fvoDeIh+yi71XQ6fz3Dgp7uQmpfWZ4A8B2I+8S78bmIcKiwwxx+RvNtVGxUmmlVvuquooj0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193523; c=relaxed/simple;
	bh=pOb28YT3I88URBLEOKsZfLmqlPfdOnLdcPXoPQa2tuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJdPWfXxRVDpXr0gGggw4yg6tsBi6OVQT2AcNUcGXW0f9sp2GV9aUMNHw/lJlAx+aHPYy7ntcy3g/Ng2aj9psW4HqhsUZ72EAdpRlAXWSCDi/ktbnUOQ7hQDdZeHI4t87j4qTUxNM9bDTqGWOA1xZYOzTy59AYPVvBG/E6/exPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 22 Jul 2025 23:11:58 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 22 Jul 2025 23:11:58 +0900
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
Message-ID: <aH+cLtTrQtt8qaRz@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
 <202507190037.RCDNmMsJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507190037.RCDNmMsJ-lkp@intel.com>

On Sat, Jul 19, 2025 at 01:08:46AM +0800, kernel test robot wrote:
> Hi Youngjun,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 347e9f5043c89695b01e66b3ed111755afcf1911]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-memcg-Introduce-infrastructure-for-cgroup-based-swap-priority/20250717-042648
> base:   347e9f5043c89695b01e66b3ed111755afcf1911
> patch link:    https://lore.kernel.org/r/20250716202006.3640584-2-youngjun.park%40lge.com
> patch subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
> config: sparc64-randconfig-r054-20250718 (https://download.01.org/0day-ci/archive/20250719/202507190037.RCDNmMsJ-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190037.RCDNmMsJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507190037.RCDNmMsJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/rbtree.h:24,
>                     from include/linux/mm_types.h:11,
>                     from include/linux/mmzone.h:22,
>                     from include/linux/swap.h:7,
>                     from mm/swap_cgroup_priority.c:16:
>    mm/swap_cgroup_priority.c: In function 'get_swap_cgroup_priority':
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/rcupdate.h:532:17: note: in definition of macro '__rcu_dereference_check'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                 ^
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/rcupdate.h:532:38: note: in definition of macro '__rcu_dereference_check'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                      ^
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
>    In file included from <command-line>:
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/compiler_types.h:518:27: note: in definition of macro '__unqual_scalar_typeof'
>      518 |                 _Generic((x),                                           \
>          |                           ^
>    include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
>       50 |         __READ_ONCE(x);                                                 \
>          |         ^~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
>    In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:390,
>                     from include/linux/export.h:5,
>                     from include/linux/linkage.h:7,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/swap.h:5:
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
>       44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>          |                                                                         ^
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
> >> mm/swap_cgroup_priority.c:115:37: error: invalid use of undefined type 'struct mem_cgroup'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                                     ^~
>    include/linux/rcupdate.h:535:19: note: in definition of macro '__rcu_dereference_check'
>      535 |         ((typeof(*p) __force __kernel *)(local)); \
>          |                   ^
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:115:16: note: in expansion of macro 'rcu_dereference'
>      115 |         return rcu_dereference(memcg->swap_priority);
>          |                ^~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c: In function 'show_swap_cgroup_priority':
>    mm/swap_cgroup_priority.c:186:30: error: invalid use of undefined type 'struct mem_cgroup'
>      186 |         swap_priority = memcg->swap_priority;
>          |                              ^~
>    mm/swap_cgroup_priority.c: In function 'swap_alloc_cgroup_priority':
>    mm/swap_cgroup_priority.c:285:26: error: invalid use of undefined type 'struct mem_cgroup'
>      285 |                 if (memcg->swap_priority != swap_priority)
>          |                          ^~
>    mm/swap_cgroup_priority.c: In function 'apply_swap_cgroup_priority':
>    mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                                              ^~
>    include/linux/rcupdate.h:532:17: note: in definition of macro '__rcu_dereference_check'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                 ^
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                         ^~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                                              ^~
>    include/linux/rcupdate.h:532:38: note: in definition of macro '__rcu_dereference_check'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                      ^
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                         ^~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                                              ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:25: note: in expansion of macro 'rcu_dereference'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                         ^~~~~~~~~~~~~~~
>    mm/swap_cgroup_priority.c:638:46: error: invalid use of undefined type 'struct mem_cgroup'
>      638 |         swap_priority = rcu_dereference(memcg->swap_priority);
>          |                                              ^~
>    include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
>      548 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
>      568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:532:50: note: in expansion of macro 'READ_ONCE'
>      532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          |                                                  ^~~~~~~~~
>    include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
>      680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/rcupdate.h:752:28: note: in expansion of macro 'rcu_dereference_check'
>      752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
> 
> 
> vim +115 mm/swap_cgroup_priority.c
> 
>   > 16	#include <linux/swap.h>
>     17	#include <linux/rcupdate.h>
>     18	#include <linux/memcontrol.h>
>     19	#include <linux/plist.h>
>     20	#include "swap.h"
>     21	#include "swap_cgroup_priority.h"
>     22	#include "memcontrol-v1.h"
>     23	
>     24	static LIST_HEAD(swap_cgroup_priority_list);
>     25	
>     26	/*
>     27	 * struct swap_cgroup_priority
>     28	 *
>     29	 * This structure is RCU protected. Its lifecycle is determined by its
>     30	 * owning memcg or when its 'distance' reaches zero. The 'distance' field
>     31	 * tracks priority differences from global swap. If zero, and its default_prio
>     32	 * follows global swap priority(SWAP_PRIORITY_GLOBAL), the object is destroyed.
>     33	 *
>     34	 * pnode - Array of pointers to swap device priority nodes.
>     35	 * owner - The owning memory cgroup.
>     36	 * rcu - RCU free callback.
>     37	 * link - Global linked list entry.
>     38	 * least_priority - Current lowest priority.
>     39	 * distance - Priority differences from global swap priority.
>     40	 * default_prio - Default priority for this cgroup.
>     41	 * plist - Priority list head.
>     42	 */
>     43	struct swap_cgroup_priority {
>     44		struct swap_cgroup_priority_pnode *pnode[MAX_SWAPFILES];
>     45		struct mem_cgroup *owner;
>     46	
>     47		union {
>     48			struct rcu_head rcu;
>     49			struct list_head link;
>     50		};
>     51	
>     52		int least_priority;
>     53		s8 distance;
>     54		int default_prio;
>     55		struct plist_head plist[];
>     56	};
>     57	
>     58	/*
>     59	 * struct swap_cgroup_priority_pnode
>     60	 *
>     61	 * This structure represents a priority node for a specific swap device
>     62	 * within a cgroup.
>     63	 *
>     64	 * swap - Pointer to the associated swap device.
>     65	 * id - Unique identifier for the swap device.
>     66	 * prio - Configured priority for this device.
>     67	 * avail_lists - Connections to various priority lists.
>     68	 */
>     69	struct swap_cgroup_priority_pnode {
>     70		struct swap_info_struct *swap;
>     71		u64 id;
>     72		signed short prio;
>     73		struct plist_node avail_lists[];
>     74	};
>     75	
>     76	/*
>     77	 * Even with a zero distance, a swap device isn't assigned if it doesn't
>     78	 * meet global swap priority conditions; thus, we don't clear it.
>     79	 */
>     80	static bool should_clear_swap_cgroup_priority(
>     81		struct swap_cgroup_priority *swap_priority)
>     82	{
>     83		WARN_ON_ONCE(swap_priority->distance < 0 ||
>     84			swap_priority->distance > MAX_SWAPFILES);
>     85	
>     86		if (swap_priority->distance == 0 &&
>     87		    swap_priority->default_prio == SWAP_PRIORITY_GLOBAL)
>     88			return true;
>     89	
>     90		return false;
>     91	}
>     92	
>     93	/*
>     94	 * swapdev_id
>     95	 *
>     96	 * A unique identifier for a swap device.
>     97	 *
>     98	 * This ID ensures stable identification for users and crucial synchronization
>     99	 * for swap cgroup priority settings. It provides a reliable reference even if
>    100	 * device paths or numbers change.
>    101	 */
>    102	static atomic64_t swapdev_id_counter;
>    103	
>    104	void get_swapdev_id(struct swap_info_struct *si)
>    105	{
>    106		si->id = atomic64_inc_return(&swapdev_id_counter);
>    107	}
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
 
The build dependency should have been CONFIG_MEMCG instead of CONFIG_CGROUP.
Apologies for overlooking this. I will update the dependency and verify
in the next patch version.

Best regards,
Youngjun Park

