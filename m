Return-Path: <cgroups+bounces-16434-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPUPCliLGWosxggAu9opvQ
	(envelope-from <cgroups+bounces-16434-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:49:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EF602774
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8249F3080E73
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA692222565;
	Fri, 29 May 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeNiSrYG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62180230BE9;
	Fri, 29 May 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058901; cv=none; b=frumHOBQcsVLZu5/BVETsszPF7b7u+oenury4MxOm9fAeL64hOoqq6IQ7IDeUDvAtiJgEtAcQlQrw137ol93vSmCCMqnaaQeAgM/44kenVVWE2h2MbXAo6H74CQPDY9xs2NCBhordNos3yBiBUIdjlEA281ROv3GZkkCfn30QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058901; c=relaxed/simple;
	bh=HO1WR6twZag3h0xFdgAKX/czudAafCz+VLFaYqj8tHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBkHUJyfeq4/9YyPy6gb/u3KkkySSSwwQmgK4GfeOZgqIjve/C933+qsxHCPyRiJsxEEWqk2pPkeUTNy6TJVFxtNekGl0URPZ58hvWcLjp3JAhFPecjSp95MA6Nd+EVgYJQFN+63bmAYYCpSf7VsXbJRutcFMdLO8fV/T8K+FpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeNiSrYG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780058901; x=1811594901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HO1WR6twZag3h0xFdgAKX/czudAafCz+VLFaYqj8tHY=;
  b=KeNiSrYGTnccyiKPNdbD2o5msj5UCid/4wK7VKxWXJYLAHCWb0ZBUh0Q
   wBYVNs4Yqmk/Im77vb6Zgq7U4s3x1ge3bd5LYuUsTmruzHtXVkwL5ndqT
   om4fgSXcv0kk3V1kWXktJwvLtOi6XvGiObh4e4y6yU5+Hxon/ZmJgNiIm
   4C+krKgWPcJL7R03dhMyLkH/vj72LYEeN6ETYJYBjaWX35ne1SGrYWd00
   6E2coVT635gmEKiBb8SccwqlrvW5kv/iqbaLLhVkGPDrYzzzQQfYZeUsV
   XwMyyKWHUo74oY4sIPXws1swT9AZ8zdJhernWDm8qZlF2I8rYRWpAyeup
   w==;
X-CSE-ConnectionGUID: 60iPpsI/TJqi2bDv81Xjjw==
X-CSE-MsgGUID: attDDFnGTiSsnSD9E7K9xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81092967"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81092967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:48:20 -0700
X-CSE-ConnectionGUID: U45MxQSeSeayqC7nDdmzOw==
X-CSE-MsgGUID: lttKo//4TxeWrxIwEzQrzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="240294353"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 May 2026 05:48:16 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSwdI-000000007EM-3wbN;
	Fri, 29 May 2026 12:48:12 +0000
Date: Fri, 29 May 2026 20:47:17 +0800
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
Message-ID: <202605292049.eaIv99hr-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16434-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 928EF602774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yury,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/mm-don-t-allow-empty-relative-nodemask-in-mpol_relative_nodemask/20260529-030835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260528190337.878027-1-ynorov%40nvidia.com
patch subject: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
config: sparc64-randconfig-002-20260529 (https://download.01.org/0day-ci/archive/20260529/202605292049.eaIv99hr-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605292049.eaIv99hr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605292049.eaIv99hr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/mempolicy.c: In function 'mpol_relative_nodemask':
>> mm/mempolicy.c:377:10: warning: 'return' with a value, in function returning void
      return -EINVAL;
             ^
   mm/mempolicy.c:370:13: note: declared here
    static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
                ^~~~~~~~~~~~~~~~~~~~~~


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

