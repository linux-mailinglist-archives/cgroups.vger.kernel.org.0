Return-Path: <cgroups+bounces-12593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CBCD7470
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EE03047905
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14232D0D0;
	Mon, 22 Dec 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nafX/XMc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDB3314C0;
	Mon, 22 Dec 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441962; cv=none; b=T5uWi8zOoDHuLJ5+wEjKyUewG2YlDaykB59e2bOkMgxPyQLJD8QEfLpzNU3JwuBGMHT/lT5KH95osyMJg3BP8MTab23D723WAVv2FrAd9T8MxKouFfcGMMWNVipJkQ9Z4pSoB+Ynze4w4ZD63G78z5MYi0zGy9DNr7RL9UmRTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441962; c=relaxed/simple;
	bh=dQ/s5g4Ian6ioHx/lf1wibw3buSKQJjac3nIOVr/Irw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMuwjkw99PefMcFoHBu1TsFd3IAZOSS+ZIeUEZtFtksRC2XLjXn+C5gWbD5vG6aSYKc58NjLpLfdCrt154djHb2F/0Wzqu8n59+XL4AWfvxqVAHgNSRjbnyEEVTi/Vsm7Ke58J9SyROHmo7ViiZsHrLWTFKLlz175BrHlGGfZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nafX/XMc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766441959; x=1797977959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQ/s5g4Ian6ioHx/lf1wibw3buSKQJjac3nIOVr/Irw=;
  b=nafX/XMcjWTZvpx12UIJdqTTiBF0JJsyOYtxXYtTzBAQHzQayhn0xnHW
   +7fwn6qbiRm+U45j2tO4nxsYywU8v/jwsB4Vq8wSN8gz7tnPdUbVfqLt+
   GZ7glPH7ClJln6VTH+9+uDwZlrJ1k2HXVIUodoRzJSxFDjXnF4J+6+2ir
   Vt/imhwLO4CNHpceoi4oiomj6PdFl/xAY6IliXqgbkuzI23t0+WZKJdUl
   8IMEJ9wyQm6t28PtHYUmKxDRsR0dkxU2PDSmxNmo9iyR4FeeJLmjfU1vp
   mWNhz4OZs+D2kNOgBexw++yF/iLQf2PjXCZXYEsAE8YmcoBcrIZDGwCRm
   w==;
X-CSE-ConnectionGUID: PEERPJnYTQqfBPVMFzHS4w==
X-CSE-MsgGUID: r9i05d3hQ2Sy1s8d8ft+BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79017619"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="79017619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 14:19:17 -0800
X-CSE-ConnectionGUID: 8ZdtjugMTpaUyreTt9B8MA==
X-CSE-MsgGUID: w98j602qRNi2vVHfzDgBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="230287947"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Dec 2025 14:19:13 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXoFC-000000001Ap-13Vn;
	Mon, 22 Dec 2025 22:19:10 +0000
Date: Tue, 23 Dec 2025 06:18:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, akpm@linux-foundation.org,
	gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org,
	Bing Jiao <bingjiao@google.com>
Subject: Re: [PATCH v2 1/2] mm/vmscan: respect mems_effective in
 demote_folio_list()
Message-ID: <202512230655.QvO6dmjt-lkp@intel.com>
References: <20251221233635.3761887-2-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221233635.3761887-2-bingjiao@google.com>

Hi Bing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tj-cgroup/for-next linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bing-Jiao/mm-vmscan-respect-mems_effective-in-demote_folio_list/20251222-074143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251221233635.3761887-2-bingjiao%40google.com
patch subject: [PATCH v2 1/2] mm/vmscan: respect mems_effective in demote_folio_list()
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251223/202512230655.QvO6dmjt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230655.QvO6dmjt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230655.QvO6dmjt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bpf.h:32,
                    from include/linux/security.h:35,
                    from include/linux/perf_event.h:53,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:96,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:61,
                    from kernel/sched/rq-offsets.c:5:
   include/linux/memcontrol.h: In function 'mem_cgroup_filter_mems_allowed':
>> include/linux/memcontrol.h:1824:1: warning: no return statement in function returning non-void [-Wreturn-type]
    1824 | }
         | ^
--
   In file included from include/linux/bpf.h:32,
                    from include/linux/security.h:35,
                    from include/linux/perf_event.h:53,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:96,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:61,
                    from kernel/sched/rq-offsets.c:5:
   include/linux/memcontrol.h: In function 'mem_cgroup_filter_mems_allowed':
>> include/linux/memcontrol.h:1824:1: warning: no return statement in function returning non-void [-Wreturn-type]
    1824 | }
         | ^


vim +1824 include/linux/memcontrol.h

  1820	
  1821	static inline bool mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg,
  1822							  nodemask_t *mask)
  1823	{
> 1824	}
  1825	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

