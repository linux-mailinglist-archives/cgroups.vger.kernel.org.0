Return-Path: <cgroups+bounces-4788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D01F9728E0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 07:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1781F23FC9
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 05:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01D167265;
	Tue, 10 Sep 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FarY4f4g"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B44219F3;
	Tue, 10 Sep 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945814; cv=none; b=srMImru+wWQu5Ijgo85YTKgdqN7k6zhsXn00NhbrQ6BxQSmHGAF4xkTgzKRE9+S2Y+k4fwuuUZ96vdgV1EFlAii3MoE/kmqAwQfa98XqlKdIiieN0OSEaJ5iOC42Syl40jlgbt39OrGlniNZrGb59dPmsTpxQ6K37bj5TLa2phM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945814; c=relaxed/simple;
	bh=a1hzRtjTM8om8Av4XmwcgCWu/d6ky3yRduDmqUZhR/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnJ7tUNwGHmPXqw5VlA7y9tvu4gNBbzDhA4tDNXlMr3rN9Ju4hJoRRoyvf6/3y+C6AyhxzdPZ0867FfTgmv2NLr5Be5KQ5RVfl1nwtqgyTsR5U7HuzhVSO3VCAwF0GTLQ+WIV6liMXsZEMyqrBZ2RB/vdroYl1Bn16I4H2FtEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FarY4f4g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725945813; x=1757481813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a1hzRtjTM8om8Av4XmwcgCWu/d6ky3yRduDmqUZhR/w=;
  b=FarY4f4gzXJicStT/hSxIqXnjv3JPWVlZTMYs75sX33xMhvup3Q++R3o
   QdxhAi49dkUXn8boVoT6nbThtMEt/UhA/3OmYDAm8NRrZDN7A+jv0tcvz
   g2O0LsqHr0ZUsJzyBvnKeoXiz1wkFvYR0myLySe4MhFmj2C9ETanDqaMW
   eqHQsswwomf5VcQNeySQhb6C0fmW1LYHE/s26FI7hWmluY3pxMmaRjltZ
   5OMBUEacNVCkvboztaoD3qpeseaxm2gA5FbgnMnd5vzEiyz4kRvrai3dd
   tMT/7pnT0DnSj2CMQEmzmTNNiNCYXNOu5eYEe8Bkh9DUrloB77Vmo80qj
   g==;
X-CSE-ConnectionGUID: DjiHLvIfQ2Kjm6ozqiqfrg==
X-CSE-MsgGUID: TK+fPIwzQ1SB+XKS81wMbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24823092"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24823092"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 22:23:32 -0700
X-CSE-ConnectionGUID: KrswjazATYmJ5BvEBMCQEA==
X-CSE-MsgGUID: twkkzW7bRV2l8dsTZyfdlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66609298"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Sep 2024 22:23:29 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sntLb-00006Y-0e;
	Tue, 10 Sep 2024 05:23:27 +0000
Date: Tue, 10 Sep 2024 13:23:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
	cgroups@vger.kernel.org, yosryahmed@google.com,
	shakeel.butt@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jesper Dangaard Brouer <hawk@kernel.org>,
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
	kernel-team@cloudflare.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
Message-ID: <202409101356.VXPFCu6l-lkp@intel.com>
References: <172547884995.206112.808619042206173396.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172547884995.206112.808619042206173396.stgit@firesoul>

Hi Jesper,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on axboe-block/for-next akpm-mm/mm-everything linus/master v6.11-rc7 next-20240909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/cgroup-rstat-Avoid-flushing-if-there-is-an-ongoing-root-flush/20240905-034221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/172547884995.206112.808619042206173396.stgit%40firesoul
patch subject: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing root flush
config: hexagon-randconfig-r121-20240910 (https://download.01.org/0day-ci/archive/20240910/202409101356.VXPFCu6l-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20240910/202409101356.VXPFCu6l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101356.VXPFCu6l-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/cgroup/rstat.c:339:23: sparse: sparse: Using plain integer as NULL pointer
   kernel/cgroup/rstat.c:87:18: sparse: sparse: context imbalance in 'cgroup_rstat_updated' - different lock contexts for basic block
   kernel/cgroup/rstat.c:75:9: sparse: sparse: context imbalance in 'cgroup_rstat_updated_list' - wrong count at exit
   kernel/cgroup/rstat.c:320:13: sparse: sparse: context imbalance in 'cgroup_rstat_trylock_flusher' - wrong count at exit
   kernel/cgroup/rstat.c:300:34: sparse: sparse: context imbalance in 'cgroup_rstat_unlock_flusher' - unexpected unlock
   kernel/cgroup/rstat.c:373:9: sparse: sparse: context imbalance in 'cgroup_rstat_flush_locked' - different lock contexts for basic block
   kernel/cgroup/rstat.c:447:9: sparse: sparse: context imbalance in 'cgroup_rstat_flush_hold' - wrong count at exit
   kernel/cgroup/rstat.c:457:6: sparse: sparse: context imbalance in 'cgroup_rstat_flush_release' - wrong count at exit

vim +339 kernel/cgroup/rstat.c

   308	
   309	/**
   310	 * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
   311	 * @cgrp: target cgroup
   312	 *
   313	 * Function return value follow trylock semantics. Returning true when lock is
   314	 * obtained. Returning false when not locked and it detected flushing can be
   315	 * skipped as another ongoing flusher is taking care of the flush.
   316	 *
   317	 * For callers that depend on flush completing before returning a strict option
   318	 * is provided.
   319	 */
   320	static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool strict)
   321	{
   322		struct cgroup *ongoing;
   323	
   324		if (strict)
   325			goto lock;
   326	
   327		/*
   328		 * Check if ongoing flusher is already taking care of this.  Descendant
   329		 * check is necessary due to cgroup v1 supporting multiple root's.
   330		 */
   331		ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
   332		if (ongoing && cgroup_is_descendant(cgrp, ongoing))
   333			return false;
   334	
   335		/* Grab right to be ongoing flusher */
   336		if (!ongoing && cgroup_is_root(cgrp)) {
   337			struct cgroup *old;
   338	
 > 339			old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
   340			if (old) {
   341				/* Lost race for being ongoing flusher */
   342				if (cgroup_is_descendant(cgrp, old))
   343					return false;
   344			}
   345			/* Due to lock yield combined with strict mode record ID */
   346			WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
   347		}
   348	lock:
   349		__cgroup_rstat_lock(cgrp, -1);
   350	
   351		return true;
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

