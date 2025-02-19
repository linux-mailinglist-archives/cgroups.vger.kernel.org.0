Return-Path: <cgroups+bounces-6599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D30ABA3B127
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 06:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3717A43EC
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707E1B87E4;
	Wed, 19 Feb 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TduXOAre"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F91B86CC
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944688; cv=none; b=qQmLQ39tVnaMn2BQeWLqYc6K90q+21iOuBTYzpFh7LMRPV0mla1d1IVN99KLjDFfi1nHQmCttre9fmmL11+SJhmLm2brbTHOYcrJmY5d99sUm5SsJxHZo2DBe4t6QP3587jep+7021O3F+izBJ7mSJ4/NgRTDHZkxZEwNs08hZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944688; c=relaxed/simple;
	bh=1jBB5gCn5yEdD3tr6XbtIWqBXsKnT9h7exQ03iJAmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYjTVqRRrYp3n4hwQMGbiHiysGF8gcxLymvcE8aIM6o4WG5uBcXc2GIGVQ0WoFNtmyn4YCt9b/gzlIN5XkMmF8cISL0NXck41wVV+zdQduFmH7U8unkpmVWR6GoGxNADUD0qYyJOLYweWyBdulYnHYWEtDhOYAWWY/3yPX26jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TduXOAre; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944687; x=1771480687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1jBB5gCn5yEdD3tr6XbtIWqBXsKnT9h7exQ03iJAmRQ=;
  b=TduXOArexblVPuTUIz2dxNeGsOO0E4/QfmKey26WGPpSkRPdg05jH1UY
   7ZenytDYeHh78alHiGJ0NgFdGo7bid7mNjhnWxDKjvfzeaVn7mEWZlNx5
   pfXz95xVoWa4HsrmlBlQZyssDWnMMiEQ9DdQEbhAP/j/mnWSFR6LS7wYk
   RdkO/7cUOfNCvZYGCTnd7T0YtOAV3l7VDEOoyc11wXDa4nlwa/sPyUCGl
   3q2PQOeYP19z1KPF8k4cRbQjnv9gPsHFKGu6aLsqip+ZCFST/sAAoYmKj
   P4sI1wfp1AMMLJkOUFRGkG3n0JDINZsBP/IRkkpbNNhnAH9HohshRs+Zo
   A==;
X-CSE-ConnectionGUID: Rg2ZPHhRRv6d0tXZVo+uig==
X-CSE-MsgGUID: lIs78jJVTW+yHMEji/rBGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40682108"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40682108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:58:07 -0800
X-CSE-ConnectionGUID: Qf0mqyrGRCCE6Y87G2KWLQ==
X-CSE-MsgGUID: wB5EM/NSTXqDYKzau+Iccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="114351431"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 Feb 2025 21:58:03 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkd5s-0001IF-0F;
	Wed, 19 Feb 2025 05:58:00 +0000
Date: Wed, 19 Feb 2025 13:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
	tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 02/11] cgroup: add level of indirection for cgroup_rstat
 struct
Message-ID: <202502191307.zqD101Gp-lkp@intel.com>
References: <20250218031448.46951-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-3-inwardvessel@gmail.com>

Hi JP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.14-rc3 next-20250218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn/cgroup-move-rstat-pointers-into-struct-of-their-own/20250218-111725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250218031448.46951-3-inwardvessel%40gmail.com
patch subject: [PATCH 02/11] cgroup: add level of indirection for cgroup_rstat struct
config: arc-randconfig-002-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191307.zqD101Gp-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191307.zqD101Gp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191307.zqD101Gp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/rstat.c:416: warning: Function parameter or struct member 'rstat' not described in '__cgroup_rstat_flush_release'
>> kernel/cgroup/rstat.c:416: warning: expecting prototype for cgroup_rstat_flush_release(). Prototype was for __cgroup_rstat_flush_release() instead


vim +416 kernel/cgroup/rstat.c

6162cef0f741c7 Tejun Heo              2018-04-26  409  
6162cef0f741c7 Tejun Heo              2018-04-26  410  /**
6162cef0f741c7 Tejun Heo              2018-04-26  411   * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
97a46a66ad7d91 Jesper Dangaard Brouer 2024-04-17  412   * @cgrp: cgroup used by tracepoint
6162cef0f741c7 Tejun Heo              2018-04-26  413   */
3d844899ba042a JP Kobryn              2025-02-17  414  static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat)
0fa294fb1985c0 Tejun Heo              2018-04-26  415  	__releases(&cgroup_rstat_lock)
6162cef0f741c7 Tejun Heo              2018-04-26 @416  {
3d844899ba042a JP Kobryn              2025-02-17  417  	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
3d844899ba042a JP Kobryn              2025-02-17  418  
fc29e04ae1ad4c Jesper Dangaard Brouer 2024-04-16  419  	__cgroup_rstat_unlock(cgrp, -1);
6162cef0f741c7 Tejun Heo              2018-04-26  420  }
6162cef0f741c7 Tejun Heo              2018-04-26  421  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

