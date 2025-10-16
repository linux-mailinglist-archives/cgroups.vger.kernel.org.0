Return-Path: <cgroups+bounces-10831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F5BE5AF6
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1561A6757E
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F22E5B26;
	Thu, 16 Oct 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU0brkBc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD42E1F01;
	Thu, 16 Oct 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653727; cv=none; b=iAA7cv4X0Eb+YLVaa8Gr6n31zQxuxNlRdo9SvbMQaVrriZRmAhLdborEQWfsJ06jqqFV5FxrlolQc3oJJefNFUpXNgO0QTjjpJyW0JEj+fiys6LQfqMWHuSB5Bu/wTkzap5S3wFmgm+L5MHUy1fB53rXDs7z2UxThR1tdHcHq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653727; c=relaxed/simple;
	bh=ciKQIk52+iRfgjCWilAdkX6YNbNDCJyfo9BtEuwQYqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coIomgA/9D2l6X6Fmp69knMt04p/cG30HFXO4dDAPp4h+eLjmg7/EjaBY9XC4569vwhtPqDoY1LcFwzLcP7IGY7uEEA9jQwkVv5l49zmp89xqCkFblYqh0tT7Nid5XhsfBJlJ59CSG9VKy2MXBjXe3CHlZmcBhx24A7dqIsKovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU0brkBc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760653726; x=1792189726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ciKQIk52+iRfgjCWilAdkX6YNbNDCJyfo9BtEuwQYqQ=;
  b=bU0brkBcVi/UuQSMcCxobLlxbuQ9Wy4msCdCg+X+ArFG+xYC16YRQv8s
   vLw4+62ulFfwAqM6k55NFNkz3k29B2HxrgCO5GTL+mKT1QEZ2Sd/tQmj5
   426xncBiIDuP2hMMcDXmbCdhCgcnAR2uuyi1+aBdy4RZVjzl7A+B272kD
   8vwWU0222GHNapAwL4TYbg/YYynz7iK6AOXFwDYSTcnQ73fBSiOcwQzTH
   DYwZ+DbrRtjefP5yyXamxqc1aPRAwtNw5EQ4+a7GWE4538s5GHmq98J3s
   hOU2pcU8CWOi/O3AnG1V9zy1kUFJXgxARLt9m1avh8bC6ePQ6Fi8HWFNJ
   Q==;
X-CSE-ConnectionGUID: soHQ0f4pQjSpEDhpda6WFw==
X-CSE-MsgGUID: e7hCY9d6R2KBbvL/UD6s0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62071723"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62071723"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 15:28:45 -0700
X-CSE-ConnectionGUID: /2MsaDmgTJmh3x2o1fWcuQ==
X-CSE-MsgGUID: 4Xm1/v/rTaScrK/tKgO49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182132113"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Oct 2025 15:28:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9WSd-0005J9-0C;
	Thu, 16 Oct 2025 22:28:39 +0000
Date: Fri, 17 Oct 2025 06:28:31 +0800
From: kernel test robot <lkp@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
	andrii@kernel.org, ast@kernel.org, mkoutny@suse.com,
	yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
Message-ID: <202510170654.s2j4GuCs-lkp@intel.com>
References: <20251015190813.80163-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015190813.80163-2-inwardvessel@gmail.com>

Hi JP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master akpm-mm/mm-everything linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn/memcg-introduce-kfuncs-for-fetching-memcg-stats/20251016-030920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20251015190813.80163-2-inwardvessel%40gmail.com
patch subject: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
config: x86_64-randconfig-121-20251016 (https://download.01.org/0day-ci/archive/20251017/202510170654.s2j4GuCs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170654.s2j4GuCs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170654.s2j4GuCs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/memcontrol.c:4236:52: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4236:52: sparse:    struct task_struct [noderef] __rcu *
   mm/memcontrol.c:4236:52: sparse:    struct task_struct *
>> mm/memcontrol.c:876:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cgroup_subsys_state *css @@     got struct cgroup_subsys_state [noderef] __rcu * @@
   mm/memcontrol.c:876:55: sparse:     expected struct cgroup_subsys_state *css
   mm/memcontrol.c:876:55: sparse:     got struct cgroup_subsys_state [noderef] __rcu *
>> mm/memcontrol.c:876:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cgroup_subsys_state *css @@     got struct cgroup_subsys_state [noderef] __rcu * @@
   mm/memcontrol.c:876:55: sparse:     expected struct cgroup_subsys_state *css
   mm/memcontrol.c:876:55: sparse:     got struct cgroup_subsys_state [noderef] __rcu *
>> mm/memcontrol.c:876:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cgroup_subsys_state *css @@     got struct cgroup_subsys_state [noderef] __rcu * @@
   mm/memcontrol.c:876:55: sparse:     expected struct cgroup_subsys_state *css
   mm/memcontrol.c:876:55: sparse:     got struct cgroup_subsys_state [noderef] __rcu *
>> mm/memcontrol.c:876:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cgroup_subsys_state *css @@     got struct cgroup_subsys_state [noderef] __rcu * @@
   mm/memcontrol.c:876:55: sparse:     expected struct cgroup_subsys_state *css
   mm/memcontrol.c:876:55: sparse:     got struct cgroup_subsys_state [noderef] __rcu *
   mm/memcontrol.c: note: in included file:
   include/linux/memcontrol.h:729:9: sparse: sparse: context imbalance in 'folio_lruvec_lock' - wrong count at exit
   include/linux/memcontrol.h:729:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irq' - wrong count at exit
   include/linux/memcontrol.h:729:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irqsave' - wrong count at exit

vim +876 mm/memcontrol.c

   873	
   874	static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
   875	{
 > 876		return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
   877	}
   878	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

