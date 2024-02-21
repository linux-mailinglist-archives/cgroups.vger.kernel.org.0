Return-Path: <cgroups+bounces-1718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A635F85D093
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 07:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DCA1F248AF
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63892E400;
	Wed, 21 Feb 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeQ75TrV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC5365;
	Wed, 21 Feb 2024 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497857; cv=none; b=Yj+52fwNqIc3tpUawDcKt0q42zrgOwEtqLDE0+FMzmalt7WTEglrcF6Q2XfsJ1qiozWkriu07k+3GPDXKLkkCVsTHYMQX0p7tbx/zDQ9i2d6ZsW5i4o25tMNJgc9W5BPCzwJEn5fqZdFsncxqLAzKQg7Oxb0uCDsNUFoNqqIYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497857; c=relaxed/simple;
	bh=gcTfRJcyu7EKTTNdfnjRMCGaCfa/5yqWcmgCca0fnbo=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=ulaBJKmN5L0sK/W9U9bMdL0vlPrCwggnxPqzN9/0R5nPFye9FI6mBQuUsECFKTVjC13lczdvhUE72GjOV1Ib4PDa8bIFq5HMxOaQlDizhCahA4nrgdisAn4DqcvYAZcP3alfVlMwzrhNNUb1fcgH5hbGpCkSmOrVWHieAeuQDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeQ75TrV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708497855; x=1740033855;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=gcTfRJcyu7EKTTNdfnjRMCGaCfa/5yqWcmgCca0fnbo=;
  b=BeQ75TrVDHMIWFF+aL7AvjF3oy2mwMvFI4FqpQwVtl9piZesAgyxyXRG
   CpRLpBCw1sy3+BXCn+3X6YqRkJtes3RU0jhuv1Dtr2m4MdLrB47XCNaU1
   /kQF9NeStymtRQr76til1mcvqvLK9LNul1gVBvZj+FrdwEyaDwaeGVipx
   XiagXg+HzW52i146jHl2wNi2RTbooBManBdaNYwhSSdZB7wu4dEy3sRcF
   dPwBuDnWpyvBq+VvioI/vmv0NWgx2JnkjAfhSWZYkgR9aqCC96deIDe3J
   YMaVETnTM5s6qoKK6KqlIuGVqXIQsFGa+PnsOS2uF/KnfN4UfSlz2p/wW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2502856"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2502856"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5395563"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 20 Feb 2024 22:44:12 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
Date: Wed, 21 Feb 2024 00:44:08 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jhbnui0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

[...]
>
> Here the @nr_to_scan is reduced by the number of pages that are  
> isolated, but
> not actually reclaimed (which is reflected by @cnt).
>
> IIUC, looks you want to make this function do "each cycle" as what you  
> mentioned
> in the v8 [1]:
>
> 	I tested with that approach and found we can only target number of
> pages
> 	attempted to reclaim not pages actually reclaimed due to the
> uncertainty
> 	of how long it takes to reclaim pages. Besides targeting number of
> 	scanned pages for each cycle is also what the ksgxd does.
>
> 	If we target actual number of pages, sometimes it just takes too long.
> I
> 	saw more timeouts with the default time limit when running parallel
> 	selftests.
>
> I am not sure what does "sometimes it just takes too long" mean, but  
> what I am
> thinking is you are trying to do some perfect but yet complicated code  
> here.

I think what I observed was that the try_charge() would block too long  
before getting chance of schedule() to yield, causing more timeouts than  
necessary.
I'll do some re-test to be sure.

>
> For instance, I don't think selftest reflect the real workload, and I  
> believe
> adjusting the limit of a given EPC cgroup shouldn't be a frequent  
> operation,
> thus it is acceptable to use some easy-maintain code but less perfect  
> code.
>
> Here I still think having @nr_to_scan as a pointer is over-complicated.   
> For
> example, we can still let sgx_reclaim_pages() to always scan  
> SGX_NR_TO_SCAN
> pages, but give up when there's enough pages reclaimed or when the EPC  
> cgroup
> and its descendants have been looped:
>
> unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
> {
> 	unsigned int cnt = 0;
> 	...
>
> 	css_for_each_descendant_pre(pos, css_root) {
> 		...
> 		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> 		cnt += sgx_reclaim_pages(&epc_cg->lru);
>
> 		if (cnt >= SGX_NR_TO_SCAN)
> 			break;
> 	}
>
> 	...
> 	return cnt;
> }
>
> Yeah it may reclaim more than SGX_NR_TO_SCAN when the loop actually  
> reaches any
> descendants, but that should be rare and we don't care that much, do we?
>
I assume you meant @cnt here to be number of pages actually reclaimed.  
This could cause  sgx_epc_cgroup_reclaim_pages() block too long as @cnt  
may always be zero (all pages are too young) and you have to loop all  
descendants.

Thanks

Haitao

