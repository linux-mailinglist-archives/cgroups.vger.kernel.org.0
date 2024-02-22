Return-Path: <cgroups+bounces-1800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8885FEC7
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB728A744
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FAC1552EE;
	Thu, 22 Feb 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4bDD6t5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8F1E488;
	Thu, 22 Feb 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621805; cv=none; b=r6H9gydfECnO25NaQwePT2f2ufXYI8y/9vbGEBPRkaFLK+NDtE8m3E/lUko1nZtZldHbqu9cIUPHtpGO+ByI/UAs9W0Ucgf5YO0IrfvKuKHTsLv0Lg1SqvVrwjI3RYI89YB5sQFSwaFhae9uT1sEJB71sGpBtf+d9GD+RMuCE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621805; c=relaxed/simple;
	bh=cd1O8F9z5fM7xYm0JoMaYk2KP84cNakz7hFNs+2d+I8=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=BgG+0WwcBErKZj17W0aHempCo9CZCF2mrQEy8SOUiRKGN9QL8sXQazZnB8et/7XL2gedWgxylD3BanWOYY17LHoaEBWXX25TECWI4JoQw8bQoe1c2+RpLUSmKfnKoZ5ueC7KMjjfBAa+7rewxmJFqsKuPh1RwO8mY7mYVTSWiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4bDD6t5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708621804; x=1740157804;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=cd1O8F9z5fM7xYm0JoMaYk2KP84cNakz7hFNs+2d+I8=;
  b=c4bDD6t59domRcpyQz+xM1ZzTP9Bgof6cjBbxRMv4PHwOhAPet6pLFif
   dg4eIBZfwlDsQWFL3nzrpeCHekuy4Ijb3c7Gbw94TN3HyTD8BpdjCk5Vi
   cboDsUBW+ICuTmTrPDtIsjw3qpPsAHxnIDDOEAoymPvxO8qhd5gwm/4v+
   Qj59VFZJAeGa1mkMF15Q0OSLNcsJX+kqyj4KSozb2T2FpAsUsmoLeFbsQ
   HiO2l9tvEzhQ8dtYRFbGQ3jzmOJjf5VUHbOMaTRiOvQHg+ZlpbKiqi9KH
   6d6szEERmkGbY7Msm63y1cPc4go5TMjSrZHNkJSSjNOyMMVsp9Ac8M1Wt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="20300407"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="20300407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10147290"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 09:09:53 -0800
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
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
Date: Thu, 22 Feb 2024 11:09:52 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 21 Feb 2024 05:06:02 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool  
>> reclaim)
>>  {
>> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
>> +	for (;;) {
>> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>> +					PAGE_SIZE))
>> +			break;
>> +
>> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>> +			return -ENOMEM;
>> +
>> +		if (signal_pending(current))
>> +			return -ERESTARTSYS;
>> +
>> +		if (!reclaim) {
>> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>> +			return -EBUSY;
>> +		}
>> +
>> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
>> +			/* All pages were too young to reclaim, try again a little later */
>> +			schedule();
>> +	}
>> +
>> +	return 0;
>>  }
>>
>
> Seems this code change is 90% similar to the existing code in the
> sgx_alloc_epc_page():
>
> 	...
> 	for ( ; ; ) {
>                 page = __sgx_alloc_epc_page();
>                 if (!IS_ERR(page)) {
>                         page->owner = owner;
>                         break;
>                 }
>
>                 if (list_empty(&sgx_active_page_list))
>                         return ERR_PTR(-ENOMEM);
>
>                 if (!reclaim) {
>                         page = ERR_PTR(-EBUSY);
>                         break;
>                 }
>
>                 if (signal_pending(current)) {
>                         page = ERR_PTR(-ERESTARTSYS);
>                         break;
>                 }
>
>                 sgx_reclaim_pages();
>                 cond_resched();
>         }
> 	...
>
> Is it better to move the logic/code change in try_charge() out to
> sgx_alloc_epc_page() to unify them?
>
> IIUC, the logic is quite similar: When you either failed to allocate one  
> page,
> or failed to charge one page, you try to reclaim EPC page(s) from the  
> current
> EPC cgroup, either directly or indirectly.
>
> No?

Only these lines are the same:
                 if (!reclaim) {
                         page = ERR_PTR(-EBUSY);
                         break;
                 }

                 if (signal_pending(current)) {
                         page = ERR_PTR(-ERESTARTSYS);
                         break;
                 }

In sgx_alloc_epc_page() we do global reclamation but here we do per-cgroup  
reclamation. That's why the logic of other lines is different though they  
look similar due to similar function names. For the global reclamation we  
need consider case in that cgroup is not enabled. Similarly  
list_empty(&sgx_active_page_list) would have to be changed to check root  
cgroup if cgroups enabled otherwise check global LRU.  The (!reclaim) case  
is also different.  So I don't see an obvious good way to abstract those  
to get meaningful savings.

Thanks
Haitao

