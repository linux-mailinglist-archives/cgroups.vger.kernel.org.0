Return-Path: <cgroups+bounces-6796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655EA4CF72
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CC53AC9ED
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025EA1F30BB;
	Mon,  3 Mar 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pjz8meHM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DA20EB
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045800; cv=none; b=DbbAAQe9wYQx3C2V8/AN4X2kaKxT5JqkcKnCfvFnGtFh9P93SvtmiipNhnZf85peTQSmLdjMCu6mf8FiP+WjGWUUlPf7q23KVu4zYKdZ08sS56ili/TGK78zZqb/VQpBT/eZeNuJQeRpxh6pSaKhoKJZ1HRFmd9GBfsHkh+YaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045800; c=relaxed/simple;
	bh=K3FhoAM4dvvrocFt48dCZynzxMocKl8lREc+96zHmfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1xQxxJ6nKmB9shlTAJ6LIguLkoWJdmr9jpepbIFeY0ez1LfmFZNP0YXZyo+f6E3jAFlIpXulVwiUFTznZ+0gS4tmO1YEBV1pNnuH7n30EtERUaiy1wf3IaIZ5P0qCT3Jsux7F5VxjF6RwjkA7DDfLA+1z+Q1ZjLiu2XKNqyhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pjz8meHM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741045799; x=1772581799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3FhoAM4dvvrocFt48dCZynzxMocKl8lREc+96zHmfc=;
  b=Pjz8meHMq1jr/Fs+QOa+McWoDaczv7q0QlBoy+9iyJE3SDQBFlHCTSvq
   tUoYZk3Q25oOXlpoeXr92z5fnHylYDLL35WP5cimNu0FXxrpGSqxYzwW4
   z8K/0t2fFV8oRMIdPAM/DVABGvqvZ5kPXAQGq0j6yZewGMTYBKT0r2rws
   ymJ92XLv45h2nq2hWVQVXBlfjRWn7l2Rx/z0hTwnBYDLKjyf9ldp6uFYn
   Liilo3N8N+r1VH4Znv294/of+3IrC4VuZYccR/+elsn3QgrogIfIv/rSy
   OoO5FoCDFbrLKuJmL8ifmOnLZ9En0Q7QUkASEssVf21Yp2W7VOhoz6iIr
   w==;
X-CSE-ConnectionGUID: jKJ1v7stSpiPjlM0YxuMCA==
X-CSE-MsgGUID: NVnV/C4aSLC8MpuJ2BEZ3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44753113"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="44753113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:49:59 -0800
X-CSE-ConnectionGUID: YdKTn2byS8ymABZe5hCEjw==
X-CSE-MsgGUID: KSdTLPbiSiC9v+yVVIXetw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123143615"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2025 15:49:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpFXl-000J3C-0H;
	Mon, 03 Mar 2025 23:49:53 +0000
Date: Tue, 4 Mar 2025 07:49:07 +0800
From: kernel test robot <lkp@intel.com>
To: inwardvessel <inwardvessel@gmail.com>, tj@kernel.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <202503040736.kEeH1wt6-lkp@intel.com>
References: <20250227215543.49928-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-4-inwardvessel@gmail.com>

Hi inwardvessel,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.14-rc5]
[cannot apply to tj-cgroup/for-next next-20250303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/inwardvessel/cgroup-move-cgroup_rstat-from-cgroup-to-cgroup_subsys_state/20250228-055819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250227215543.49928-4-inwardvessel%40gmail.com
patch subject: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250304/202503040736.kEeH1wt6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040736.kEeH1wt6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503040736.kEeH1wt6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/loongarch/include/asm/bug.h:61,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   kernel/cgroup/rstat.c: In function 'cgroup_rstat_flush_locked':
>> include/linux/lockdep.h:252:61: error: 'lock' is a pointer; did you mean to use '->'?
     252 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:285:9: note: in expansion of macro 'lockdep_assert'
     285 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:285:24: note: in expansion of macro 'lockdep_is_held'
     285 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   kernel/cgroup/rstat.c:339:9: note: in expansion of macro 'lockdep_assert_held'
     339 |         lockdep_assert_held(&lock);
         |         ^~~~~~~~~~~~~~~~~~~


vim +252 include/linux/lockdep.h

f607c668577481 Peter Zijlstra 2009-07-20  251  
f8319483f57f1c Peter Zijlstra 2016-11-30 @252  #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)
f8319483f57f1c Peter Zijlstra 2016-11-30  253  #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
f607c668577481 Peter Zijlstra 2009-07-20  254  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

