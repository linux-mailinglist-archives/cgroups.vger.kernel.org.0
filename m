Return-Path: <cgroups+bounces-4724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC796E418
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 22:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E351C20B26
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BB1993B5;
	Thu,  5 Sep 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DslEQ/Vj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9513D638;
	Thu,  5 Sep 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568205; cv=none; b=aqpWNWRy4mxA3QNlgRMfNhANphVLPizIe7lHADo1ZdgbRq5Vq+WAkoxmDx10/wtIdFGt5SRelB1pqQ+CTeKC7ofPydTTTnn3vcvK9Vcy1OoXcDvsQwDFlqTJmVtNEg+Nv3vckrnqNBGXLkCDdYmKPMZBxSo3wBRE07L5zp96UH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568205; c=relaxed/simple;
	bh=dOaaWXnpAep/fcrnY3blbZqV6QssNr8BcJX8tx4Sc8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2d0PnEeZe0D1TT0k9gKqRSNiDwN99Fri8y5rZsBiyoZNGdghybohfmKoxAAqCwiRNP1hKgGvj4Ei/3zR/jprvQYtcSv7OmXxfXuAhFQClCvqfvblzgtqtQCYAn4OKx9BHVIFqhzIcaOy0HJhcyhItqdmhSpHeX+Z4tOKGPtuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DslEQ/Vj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725568204; x=1757104204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dOaaWXnpAep/fcrnY3blbZqV6QssNr8BcJX8tx4Sc8o=;
  b=DslEQ/VjFldZg+xVkLZWksonU4iyZIV6iMVspUd/WPvP3LqJeVtRqacU
   JSN8vTv/WsLlAPvJU4H5gt9EqkKfrAg8ckV8110aUEFSfq4HK9KDukdwR
   9Quphq+By0v79lYM7GgyWrUaCgRvHZoLFt+A3YH91YtBWQBdKA/w4qwGl
   hMNSMrwXZ0xvLLThKkgyDj5gA8UmulEqsItA7Ja40dypdy2uy14pHBEUD
   WppDeumSG7FwsVI0f88YxntFl+vGsOKEvrCRbIuOvbnjND78mxCwKeA5i
   tlvK2U6RHeGkQ3Eg6SAtnVo8R4P/bPaeeggsXplsjRBl+1TH2qktaH1ta
   Q==;
X-CSE-ConnectionGUID: UmvJs1vDQISQV2SO0kr/SA==
X-CSE-MsgGUID: vR02LomEQdGA6j3SplRGxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24458455"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24458455"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:21:13 -0700
X-CSE-ConnectionGUID: RshIxymYTJC2+ySq2w1gfA==
X-CSE-MsgGUID: VBrzC3xzROqAPfB0/CbGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65976414"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Sep 2024 13:21:09 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smIyY-000AHf-3A;
	Thu, 05 Sep 2024 20:21:06 +0000
Date: Fri, 6 Sep 2024 04:20:21 +0800
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
Message-ID: <202409060400.Z4B69Z8T-lkp@intel.com>
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
[also build test WARNING on axboe-block/for-next akpm-mm/mm-everything linus/master v6.11-rc6 next-20240905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/cgroup-rstat-Avoid-flushing-if-there-is-an-ongoing-root-flush/20240905-034221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/172547884995.206112.808619042206173396.stgit%40firesoul
patch subject: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing root flush
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240906/202409060400.Z4B69Z8T-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409060400.Z4B69Z8T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409060400.Z4B69Z8T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:321: warning: Function parameter or struct member 'strict' not described in 'cgroup_rstat_trylock_flusher'


vim +321 kernel/cgroup/rstat.c

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
 > 321	{
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
   339			old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
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

