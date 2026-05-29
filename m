Return-Path: <cgroups+bounces-16415-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEuMEWRVGWrTvQgAu9opvQ
	(envelope-from <cgroups+bounces-16415-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 10:59:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F805FFA13
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851D8323CE10
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97E3C5546;
	Fri, 29 May 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGtlxaml"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B63BB69F;
	Fri, 29 May 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044487; cv=none; b=SI3jm9wK9OTbLmqcTC72LXFHKWuVxVdRSw3mdkOpxIKgfubLZYiqS2Ogk5nT+EqYO2+h7awbla8Ge3R0SL9su+1TyfuO/pZQDl0iR4APzq5PkuGKrf/yzd9oC3xZyhDt9ZgcVswsBmIg33cUmT/SJR/oriyEmdpR8HZhg8bEu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044487; c=relaxed/simple;
	bh=6AWLmlUtfnCHN56YA869w6PKgs0+gUIV71eS29nK1aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1fPjMOgNL7/ZjQXsnB8G9DIufUEeeMLX6yUh8tG2kxNgaDgGhoaPV0HHQDoEqJ9YBmFkYIvgzxHRncuYSSUtaY+WYQUU+92mvahp54VZ4GXbGommmVJsCOCpivDBsdOLZLof8iER2rmmP4buhtm7kbPCupdyozrpNT5fHdiK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGtlxaml; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780044484; x=1811580484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6AWLmlUtfnCHN56YA869w6PKgs0+gUIV71eS29nK1aI=;
  b=nGtlxamld/Izw09QfZpIb/yIOpfcwUABcHo7czeNd2MEgKLp1TU/T1hB
   DLaWsCGChfpvr1TZnqZaxVt56+UoOdSC3Fwke+YmaxzBpL7VFepb+7muW
   6GnSs2RBD08OMP6han3s+yp2yk2gtbWNT37s9y+kzg51/GY7qDKwYFkcQ
   Oj8QuBgGtIlhMfyBRy5vMTy50NwEu5QkNUkGcjtsmfrk1FeoHCsBj1KoV
   KsXcFYm/ROy/2waW0ku6PWnqSsoTd7LT9esyuQBGsGe6Iixd65RsaOda1
   a56zy7XpOGqGDki6hIMzFdW75IiNBnNwcUxGu6qpUgKZtV4uFxHS90GZC
   w==;
X-CSE-ConnectionGUID: NPvJPQA4TvC3KhP4cRSxhA==
X-CSE-MsgGUID: wzgBEHJSR/G+oBBHmfNLRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="98310082"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="98310082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:48:04 -0700
X-CSE-ConnectionGUID: FfDdqrpOQKCTSLgvgbJbPg==
X-CSE-MsgGUID: cm7/T7dEQP+9c9ico/Is8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="280915197"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2026 01:47:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSssm-00000000702-1IAn;
	Fri, 29 May 2026 08:47:56 +0000
Date: Fri, 29 May 2026 16:47:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yury Norov <ynorov@nvidia.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
Message-ID: <202605291631.6MATSv6v-lkp@intel.com>
References: <20260528190337.878027-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528190337.878027-1-ynorov@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16415-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,kernel.org,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97F805FFA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yury,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/mm-don-t-allow-empty-relative-nodemask-in-mpol_relative_nodemask/20260529-030835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260528190337.878027-1-ynorov%40nvidia.com
patch subject: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
config: x86_64-buildonly-randconfig-003-20260529 (https://download.01.org/0day-ci/archive/20260529/202605291631.6MATSv6v-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605291631.6MATSv6v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605291631.6MATSv6v-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/mempolicy.c: In function 'mpol_relative_nodemask':
>> mm/mempolicy.c:377:24: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     377 |                 return -EINVAL;
         |                        ^
   mm/mempolicy.c:370:13: note: declared here
     370 | static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
         |             ^~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]


vim +/return +377 mm/mempolicy.c

   369	
   370	static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
   371					   const nodemask_t *rel)
   372	{
   373		unsigned int w = nodes_weight(*rel);
   374		nodemask_t tmp;
   375	
   376		if (w == 0)
 > 377			return -EINVAL;
   378	
   379		nodes_fold(tmp, *orig, w);
   380		nodes_onto(*ret, tmp, *rel);
   381	}
   382	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

