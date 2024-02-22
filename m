Return-Path: <cgroups+bounces-1820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493B8605DD
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 23:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BE81F23DEF
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14141182A3;
	Thu, 22 Feb 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6HTOqcd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222118026;
	Thu, 22 Feb 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642668; cv=none; b=ThVpQHBoBJ6abray9chWwo4kvpMCITQjRt9Z3su7iG0dyZsmWFEcS7U+uznqzm275mRlKhfIAcwizhF0641N0ix1pj6W05rf6sr2FYJ+VzD4DK3yfkjP0zDwPOWlVtBlGPnZkmOIYAGu1qVG5w7JVPzgIfBN6gDo2jj7EzlYRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642668; c=relaxed/simple;
	bh=Y/laIYepz6ZXKfQ07+X8EGPW4ul5yz5v7N3Xbc3MeGI=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=e6FsUkJfItQCCE0iIQsDmK4A/MnA9E8rHT7WoPKO/8DEDaTeXaoE1PrwDFx9fYhq7nQur9USl9NNblbQmp3Eq8wi1VQKUnyGACEw7ZMm1e4N+G/iO+OSFp94WZG+w+8jPIqrUx+JkGWuD23XI793L/ytoPpB+5Ya+b7MnkgI1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6HTOqcd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708642667; x=1740178667;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Y/laIYepz6ZXKfQ07+X8EGPW4ul5yz5v7N3Xbc3MeGI=;
  b=A6HTOqcdt6jm1DFoNihD/yDEuyoD6fv6wHw2ZHJiNo64J2X3BptP1l8F
   gz9BJMdoasGhDfSkMnFoqqKPRNnilkGhdFUnng/D4PK/YRVu3wBGgFRFG
   U5M4z6ACMmKFagWKDscojFQy0asBRnrOklkJdlgNXAgKqDieQ1DZPvSiL
   2pwsQUys6QOfuAkdNeM9qOvBNS1ClI40ZFq10nrAfubvgrSKBbXRkvBMy
   PHxuQifmeKirTO2Nk13oVG8mWPeUzksPc6+pnvWkTbeRJovxo+MhPXBBt
   UQKcVux/tSUWPV23GghYcldJ8yaa4UJ2IchehoAUnC0eXRLjl9UaIa0bE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6737638"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6737638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36680848"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 14:57:41 -0800
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
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
Date: Thu, 22 Feb 2024 16:57:40 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 22 Feb 2024 15:26:05 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 23/02/2024 6:09 am, Haitao Huang wrote:
>> On Wed, 21 Feb 2024 05:06:02 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>>>
>>>> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>>>> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool  
>>>> reclaim)
>>>>  {
>>>> -    return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,  
>>>> PAGE_SIZE);
>>>> +    for (;;) {
>>>> +        if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>>>> +                    PAGE_SIZE))
>>>> +            break;
>>>> +
>>>> +        if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>>>> +            return -ENOMEM;
>>>> +
>>>> +        if (signal_pending(current))
>>>> +            return -ERESTARTSYS;
>>>> +
>>>> +        if (!reclaim) {
>>>> +            queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>>>> +            return -EBUSY;
>>>> +        }
>>>> +
>>>> +        if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
>>>> +            /* All pages were too young to reclaim, try again a  
>>>> little later */
>>>> +            schedule();
>>>> +    }
>>>> +
>>>> +    return 0;
>>>>  }
>>>>
>>>
>>> Seems this code change is 90% similar to the existing code in the
>>> sgx_alloc_epc_page():
>>>
>>>     ...
>>>     for ( ; ; ) {
>>>                 page = __sgx_alloc_epc_page();
>>>                 if (!IS_ERR(page)) {
>>>                         page->owner = owner;
>>>                         break;
>>>                 }
>>>
>>>                 if (list_empty(&sgx_active_page_list))
>>>                         return ERR_PTR(-ENOMEM);
>>>
>>>                 if (!reclaim) {
>>>                         page = ERR_PTR(-EBUSY);
>>>                         break;
>>>                 }
>>>
>>>                 if (signal_pending(current)) {
>>>                         page = ERR_PTR(-ERESTARTSYS);
>>>                         break;
>>>                 }
>>>
>>>                 sgx_reclaim_pages();
>>>                 cond_resched();
>>>         }
>>>     ...
>>>
>>> Is it better to move the logic/code change in try_charge() out to
>>> sgx_alloc_epc_page() to unify them?
>>>
>>> IIUC, the logic is quite similar: When you either failed to allocate  
>>> one page,
>>> or failed to charge one page, you try to reclaim EPC page(s) from the  
>>> current
>>> EPC cgroup, either directly or indirectly.
>>>
>>> No?
>>  Only these lines are the same:
>>                  if (!reclaim) {
>>                          page = ERR_PTR(-EBUSY);
>>                          break;
>>                  }
>>                   if (signal_pending(current)) {
>>                          page = ERR_PTR(-ERESTARTSYS);
>>                          break;
>>                  }
>>  In sgx_alloc_epc_page() we do global reclamation but here we do  
>> per-cgroup reclamation.
>
> But why?  If we failed to allocate, shouldn't we try to reclaim from the  
> _current_ EPC cgroup instead of global?  E.g., I thought one enclave in  
> one EPC cgroup requesting insane amount of EPC shouldn't impact enclaves  
> inside other cgroups?
>
Right. When code reaches to here, we already passed reclaim per cgroup.  
The cgroup may not at or reach limit but system has run out of physical  
EPC.

Thanks
Haitao

