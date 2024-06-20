Return-Path: <cgroups+bounces-3255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227791093F
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E3B282959
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBB1AED46;
	Thu, 20 Jun 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvYHalRk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA561ACE94;
	Thu, 20 Jun 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895980; cv=none; b=OV8uV3KgXVeCArdduEKiljyf8NrzYh9q5E2lSQG0q2Idz4SLgCbqCSa4PAy7ZMQ6OKAMgWLUavMBVKR4hLdws82OqeZR3amwWxMEL/zgi5VL9xYWNhlyJEUT7/Haj0WLIbdzcYAQfBaU+c9ruItAqHsNXmAKh34T0ZacfDrc7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895980; c=relaxed/simple;
	bh=YMjxy9vaE1KytWRfKe6XwDIAw8hvH4WTzthOWlszNQw=;
	h=Content-Type:Cc:References:Subject:To:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Rtvz3DFEeXtVIFDW/BNk0mHwDwzJdMVIj1sNgz6lg7ke8Jv7nlXsqqTDuVjlqvGRWHlfyvcadQnXCnUAwq5zGBrn+slksmsQqUO6RZCO1BCqVweKAfz7w+G2ZmeXoQe89oSO3goK7cAtC2Tighq2HHNFy2yFgSgayHKJgM93y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvYHalRk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718895978; x=1750431978;
  h=cc:references:subject:to:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=YMjxy9vaE1KytWRfKe6XwDIAw8hvH4WTzthOWlszNQw=;
  b=FvYHalRk7tlJq5WVBUBxVzZrC0WMhset6RWC9/ZWjg/48OOVGKUCDlYR
   oJX6RcGg3Vl5coYnUou8yg6tq6wxk9BcJcWIkWyDtusw90MSC5NqffpKR
   AE0ScQ9HfWBN5AS/JdxP9w3XDrebPHdMc3jrNEVePoBiDEZI98rqHYCPo
   jtZP7zydsI61m+EbFFdzbWXccvr04hQt+FmvziNXe5SYNLahDsNZkCF7Q
   s+cgIHn/UP1E2P8O1KGMQN3u0q0Z+IA4dKOszTQZFnFyqMn61DiqMB9DE
   38E30MKPs63ffuU2KrML98+9fcnEfooWBWEeZ34qiP5dS6mp9akA8CGbL
   Q==;
X-CSE-ConnectionGUID: uMTRBxaIQ0qs/7BjCFxMcw==
X-CSE-MsgGUID: J47cT53/SqqTq5MKhj6uYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15638295"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15638295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:06:09 -0700
X-CSE-ConnectionGUID: 2Pb005JOS7W6cHlxUuLmfA==
X-CSE-MsgGUID: 1vVoXDbkQJWXynBKyogt0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42375870"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 20 Jun 2024 08:06:05 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
 <20240617125321.36658-13-haitao.huang@linux.intel.com>
 <103f18636f0d65e3bcb0ca5f1008c0c7df0bdfd7.camel@intel.com>
Subject: Re: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
To: "chenridong@huawei.com" <chenridong@huawei.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
 <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
 <kai.huang@intel.com>
Date: Thu, 20 Jun 2024 10:06:01 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2pn6wbdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <103f18636f0d65e3bcb0ca5f1008c0c7df0bdfd7.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Kai

On Thu, 20 Jun 2024 05:30:16 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
> On 18/06/2024 12:53 am, Huang, Haitao wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Previous patches have implemented all infrastructure needed for
>> per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
>> pages are still tracked in the global LRU as sgx_epc_page_lru() always
>> returns reference to the global LRU.
>>
>> Change sgx_epc_page_lru() to return the LRU of the cgroup in which the
>> given EPC page is allocated.
>>
>> This makes all EPC pages tracked in per-cgroup LRUs and the global
>> reclaimer (ksgxd) will not be able to reclaim any pages from the global
>> LRU. However, in cases of over-committing, i.e., the sum of cgroup
>> limits greater than the total capacity, cgroups may never reclaim but
>> the total usage can still be near the capacity. Therefore a global
>> reclamation is still needed in those cases and it should be performed
>> from the root cgroup.
>>
>> Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
>> when cgroup is enabled. Similar to sgx_cgroup_reclaim_pages(), return
>> the next cgroup so callers can use it as the new starting node for next
>> round of reclamation if needed.
>>
>> Also update sgx_can_reclaim_global(), to check emptiness of LRUs of all
>> cgroups when EPC cgroup is enabled, otherwise only check the global LRU.
>>
>> Finally, change sgx_reclaim_direct(), to check and ensure there are free
>> pages at cgroup level so forward progress can be made by the caller.
>
> Reading above, it's not clear how the _new_ global reclaim works with
> multiple LRUs.
>
> E.g., the current global reclaim essentially treats all EPC pages equally
> when scanning those pages.  From the above, I don't see how this is
> achieved in the new global reclaim.
>
> The changelog should:
>
> 1) describe the how does existing global reclaim work, and then describe
> how to achieve the same beahviour in the new global reclaim which works
> with multiple LRUs;
>
> 2) If there's any behaviour difference between the "existing" vs the  
> "new"
> global reclaim, the changelog should point out the difference, and  
> explain
> why such difference is OK.

Sure I can explain. here is what I plan to add for v16:

Note the original global reclaimer has
only one LRU and always scans and reclaims from the head of this global
LRU. The new global reclaimer always starts the scanning from the root
node, only moves down to its descendants if more reclamation is needed
or the root node does not have SGX_NR_TO_SCAN (16) pages in the LRU.
This makes the enclave pages in the root node more likely being
reclaimed if they are not frequently used (not 'young'). Unless we track
pages in one LRU again, we can not really match exactly the same
behavior of the original global reclaimer. And one-LRU approach would
make per-cgroup reclamation scanning and reclaiming too complex.  On the
other hand, this design is acceptable for following reasons:

1) For all purposes of using cgroups, enclaves will need live in
      non-root (leaf for cgroup v2) nodes where limits can be enforced
      per-cgroup.
2) Global reclamation now only happens in situation mentioned above when
      a lower level cgroup not at its limit can't allocate due to over
      commit at global level.
3) The pages in root being slightly penalized are not busily used
      anyway.
4) In cases that multiple rounds of reclamation is needed, the caller of
      sgx_reclaim_page_global() can still recall for reclaiming in 'next'
      descendant in round robin way, each round scans for SGX_NR_SCAN pages
      from the head of 'next' cgroup's LRU.


>
>>
>> With these changes, the global reclamation and per-cgroup reclamation
>> both work properly with all pages tracked in per-cgroup LRUs.
>>
>
> [...]
>
>>
>> -static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>> +static struct misc_cg *sgx_reclaim_pages_global(struct misc_cg  
>> *next_cg,
>> +						struct mm_struct *charge_mm)
>>   {
>> +	if (IS_ENABLED(CONFIG_CGROUP_MISC))
>> +		return sgx_cgroup_reclaim_pages(misc_cg_root(), next_cg, charge_mm);
>> +
>>   	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>> +	return NULL;
>>   }
>>
>>   /*
>> @@ -414,12 +443,35 @@ static void sgx_reclaim_pages_global(struct  
>> mm_struct *charge_mm)
>>    */
>>   void sgx_reclaim_direct(void)
>>   {
>> +	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
>> +	struct misc_cg *cg = misc_from_sgx(sgx_cg);
>
> From below @sgx_cg could be NULL.  It's not immediately clear whether  
> calling
> misc_from_sgx(sgx_cg) unconditionally is safe here.
>
> Leave the initiaization of @cg to a later phase where @sgx_cg is
> guaranteed not being NULL, or initialize @cg to NULL here and update  
> later.
>

Ok

>> +	struct misc_cg *next_cg = NULL;
>> +
>> +	/*
>> +	 * Make sure there are some free pages at both cgroup and global  
>> levels.
>> +	 * In both cases, only make one attempt of reclamation to avoid  
>> lengthy
>> +	 * block on the caller.
>> +	 */
>> +	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg))
>> +		next_cg = sgx_cgroup_reclaim_pages(cg, next_cg, current->mm);
>
> I don't quite follow the logic.
>
> First of all, sgx_cgroup_reclaim_pages() isn't called in a loop, so why
> not just do:
>
> 	next_cg = sgx_cgroup_reclaim_pages(cg, NULL, current->mm);
>

Okay, I can replace it with NULL. I thought it was convenient to grep all  
such calls to see if they are used consistently.

> And what is the point of set @next_cg here, since ...
>
>
>> +
>> +	if (next_cg != cg)
>> +		put_misc_cg(next_cg);
>> +
>> +	next_cg = NULL;
>
> ... here @next_cg is reset to NULL ?
>
> Looks the only reason is you need to do ...
>
> 	put_misc_cg(next_cg);
>
> ... above?
>

yes

> This piece of code appears repeatedly in this file.  Is there any way we
> can get rid of it?
>

sgx_cgroup_reclaim_pages() returns 'next' in case caller needs to run it  
in loop. In this case, no.

I could create a thin wrapper for this case, but since there is only one  
such case, I did not fee it's worth the extra layer.

>>   	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
>> -		sgx_reclaim_pages_global(current->mm);
>> +		next_cg = sgx_reclaim_pages_global(next_cg, current->mm);
>
> And this doesn't seems "global reclaim" at all?
>
> Because it essentially equals to:
>
> 	next_cg = sgx_reclaim_pages_global(NULL, current->mm);
>
> which always reclaims from the ROOT.
>
> So each call to sgx_reclaim_direct() will always reclaim from the ROOT --
> any other LRUs in the hierarchy will unlikely to get any chance to be
> reclaimed.

No, the current cgroup is always checked and called to reclaim if needed.
Global reclaim only happens when system-wide water mark SGX_NR_LOW_PAGES  
is violated.

>
>> +
>> +	if (next_cg != misc_cg_root())
>> +		put_misc_cg(next_cg);
>> +
>> +	sgx_put_cg(sgx_cg);
>>   }
>>
>>   static int ksgxd(void *p)
>>   {
>> +	struct misc_cg *next_cg = NULL;
>> +
>>   	set_freezable();
>>
>>   	/*
>> @@ -437,11 +489,15 @@ static int ksgxd(void *p)
>>   				     kthread_should_stop() ||
>>   				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
>>
>> -		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
>> +		while (!kthread_should_stop() &&  
>> sgx_should_reclaim_global(SGX_NR_HIGH_PAGES)) {
>>   			/* Indirect reclaim, no mm to charge, so NULL: */
>> -			sgx_reclaim_pages_global(NULL);
>> +			next_cg = sgx_reclaim_pages_global(next_cg, NULL);
>> +			cond_resched();
>
> Should the 'put_misc_cg(next_cg)' be done within the while() loop but not
> below?

No, whenever there is a loop, we want to reclaim in round robin way.

>> +		}
>>
>> -		cond_resched();
>> +		if (next_cg != misc_cg_root())
>> +			put_misc_cg(next_cg);
>> +		next_cg = NULL;
>
> Again, it doesn't seems "global reclaim" here, since you always restart
> from the ROOT once the target pages have been reclaimed.
>
> AFAICT it's completely different from the existing global reclaim.
>
Hopefully adding comments mentioned above clarifies this.

>>   	}
>>
>>   	return 0;
>> @@ -583,6 +639,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page  
>> *page)
>>    */
>>   struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim  
>> reclaim)
>>   {
>> +	struct misc_cg *next_cg = NULL;
>>   	struct sgx_cgroup *sgx_cg;
>>   	struct sgx_epc_page *page;
>>   	int ret;
>> @@ -616,10 +673,19 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, enum sgx_reclaim reclaim)
>>   			break;
>>   		}
>>
>> -		sgx_reclaim_pages_global(current->mm);
>> +		/*
>> +		 * At this point, the usage within this cgroup is under its
>> +		 * limit but there is no physical page left for allocation.
>> +		 * Perform a global reclaim to get some pages released from any
>> +		 * cgroup with reclaimable pages.
>> +		 */
>> +		next_cg = sgx_reclaim_pages_global(next_cg, current->mm);
>>   		cond_resched();
>>   	}
>
> Ditto IIUC.
>
>

