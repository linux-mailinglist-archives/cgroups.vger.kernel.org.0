Return-Path: <cgroups+bounces-16416-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGVELFFWGWrTvQgAu9opvQ
	(envelope-from <cgroups+bounces-16416-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:03:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0E5FFAB5
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 051263063026
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E63B776A;
	Fri, 29 May 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMyqNsDw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E083A83BF;
	Fri, 29 May 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045149; cv=none; b=jNOiPbffvKm2BjTnokOklC8hIw8/A0kykQ+GsI2BiTgLf25jWH6oUNralr93kBoM2c0lCA4deoKmXdrdZmALQBEhbOhwv+2/GA4ThYoU39Rdo5BzE3iWcw3jIVJq2VE50IdoKvF93iFuQBkLpiXodjjkjNr5HXULSkj2UrmXEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045149; c=relaxed/simple;
	bh=kT17TFaVMuzhehcDGfOX5jz4/y7vwK9PowtC8aVxbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo2+qTpvN0fTdmzlvFmyT9fQLPzoZVFKpZ/9G7D0+iADfQtOKiHOYaiJxWFnpEwdIwDkYoT//bPykIBNFIpGDYdhL8pyeFaZwDJ8RsSeVeHXcaS2XdYu8iltGqnaqLN6vpCWQqwvR2/DCipsIjrUQtSobupzPDN6frWzr9rEanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMyqNsDw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780045147; x=1811581147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kT17TFaVMuzhehcDGfOX5jz4/y7vwK9PowtC8aVxbbc=;
  b=dMyqNsDwFEtBCTJon41RJVEe7Sr+2cAk4YR2gi0XUSVIoDXjVOmZnHpu
   eqmVGW7JZKaLXxCp3AYRqfs2Oa8b8uuTtOMdwT2+y4oF6JP/ye0NuDiYk
   vY/W6UGTpKR/hsoE7iLlQOJhd90QLMrwOHkLz6wOBNgXBhSYt79VQnZD9
   jG8BB+SVXPSchRo1Wy9l6QQGVS2pvqMDXO0lRsmm0Je+TNmxsdhsj/t/9
   xrvL4sElpmJqXnYgwxWnP7p2SGvj2AEwNO5GP5H0K9lXKib5QQx+9k5Qj
   3FV7wSAvxoLyv44nZ8PHPwel2bk3F5D8Z0szyr4BZrJmHyQWJuX0mds3N
   A==;
X-CSE-ConnectionGUID: C11qOYI1SJWFLKkUPWWtQQ==
X-CSE-MsgGUID: Eesx+9nTTgONgNXPI68RWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80795026"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80795026"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:59:06 -0700
X-CSE-ConnectionGUID: fTjGFbSZTdOevsLtgfQEfA==
X-CSE-MsgGUID: T68RK7tKSXS5sDa6pImfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247740206"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2026 01:59:01 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSt3R-00000000714-14pf;
	Fri, 29 May 2026 08:58:57 +0000
Date: Fri, 29 May 2026 16:58:03 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yury Norov <ynorov@nvidia.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
Message-ID: <202605291609.AR5UEvmT-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16416-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,kernel.org,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9C0E5FFAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yury,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/mm-don-t-allow-empty-relative-nodemask-in-mpol_relative_nodemask/20260529-030835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260528190337.878027-1-ynorov%40nvidia.com
patch subject: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260529/202605291609.AR5UEvmT-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605291609.AR5UEvmT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605291609.AR5UEvmT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/mempolicy.c:377:3: warning: void function 'mpol_relative_nodemask' should not return a value [-Wreturn-mismatch]
     377 |                 return -EINVAL;
         |                 ^      ~~~~~~~
   1 warning generated.


vim +/mpol_relative_nodemask +377 mm/mempolicy.c

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

