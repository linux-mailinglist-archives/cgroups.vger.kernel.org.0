Return-Path: <cgroups+bounces-1814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A886007A
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059231C24563
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA46157E7C;
	Thu, 22 Feb 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4mgCP0X"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44515699F;
	Thu, 22 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625375; cv=none; b=tFwPavjgDToVDjfGVdB57mFAtn2fwCTjI4tJbkTRjPU99ZPgFZgSeknkxWDzheRFLdClliQffsy5CJaOyIAFFSu+ctQWJZwH+Xo8GSGLuNLiCIiAwNoblVplYZl/ie0ccvB4Mvi4vyPHJVvnF5pGKR+qpHQ48ei02HOEj0ES/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625375; c=relaxed/simple;
	bh=jk8RlsiT8f/S9Jhz/GgQqUxnZg2BACrAQRRLCql1KoA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=C8k8TA+ZZeR+HVNk0VwpMjFcha+3qhHZTY3ggN7A+YpyGNac0/J1x1hFT8i0uHkGsqb7lj8fIDFAjRbQsDVQ99v8qil/SYlymsGVMiFTWscIi//Dh9pocXM4GlJ8ikNs2XAlezKFUhALSOAG/SoSA6uucWmC3Ifmfb/mTRG/+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4mgCP0X; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708625373; x=1740161373;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=jk8RlsiT8f/S9Jhz/GgQqUxnZg2BACrAQRRLCql1KoA=;
  b=D4mgCP0X7V2BOL6YI2be3QbS+MM7/d61FRsc0R8cp5B7yxS9NstO1bTO
   Dw8YFnwZy0Ig/fhx2dEOYfYpIL0D/UnC6n7t+bP5IsdcZG2o19s6p1J6H
   g1XJZfZD7bB8I9JpBxGs1bdfBQaPYdnWwQ0KOx+5QJEKcoG9czuK8d9Qt
   JuUy/FabbNZNV3U0Fzm6ylKNt1GQksL6YvK9NFeoCrfr4189h5D0X/6hf
   NHKDFOVH9IAoRaHGfHGJyi3/hPMQV/TKtPIScZ2WcQqkGgozTGotZuvxs
   875Gt4fOvUxfvWe74ryVHqmrXKNUvjuWuqxooSwrbq0gsn6+fjfUkdpWk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2981632"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2981632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:09:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="827583578"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="827583578"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 10:09:29 -0800
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
Date: Thu, 22 Feb 2024 12:09:28 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jj11200wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 20 Feb 2024 03:52:39 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>>> +/**
>> + * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs  
>> to reclaim pages
>> + * @root:	Root of the tree to start walking from.
>> + * Return:	Number of pages reclaimed.
>
> Just wondering, do you need to return @cnt given this function is called  
> w/o
> checking the return value?
>
Yes. Will add explicit commenting that we need scan fixed number of pages  
for attempted reclamation.
>> + */
>> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
>> +{
>> +	/*
>> +	 * Attempting to reclaim only a few pages will often fail and is
>> +	 * inefficient, while reclaiming a huge number of pages can result in
>> +	 * soft lockups due to holding various locks for an extended duration.
>> +	 */
>
> Not sure we need this comment, given it's already implied in
> sgx_reclaim_pages().  You cannot pass a value > SGX_NR_TO_SCAN anyway.

Will rework on these comments to make them more meaningful.
>

[other comments/questions addressed in separate email threads]
[...]
>> +
>> +/*
>> + * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the  
>> cgroup
>> + * when the cgroup is at/near its maximum capacity
>> + */
>
> I don't see this being "scheduled by sgx_epc_cgroup_try_charge()" here.   
> Does it
> make more sense to move that code change to this patch for better review?
>

Right. This comment was left-over when I split the old patch.

>> +static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
>> +{
>> +	struct sgx_epc_cgroup *epc_cg;
>> +	u64 cur, max;
>> +
>> +	epc_cg = container_of(work, struct sgx_epc_cgroup, reclaim_work);
>> +
>> +	for (;;) {
>> +		max = sgx_epc_cgroup_max_pages_to_root(epc_cg);
>> +
>> +		/*
>> +		 * Adjust the limit down by one page, the goal is to free up
>> +		 * pages for fault allocations, not to simply obey the limit.
>> +		 * Conditionally decrementing max also means the cur vs. max
>> +		 * check will correctly handle the case where both are zero.
>> +		 */
>> +		if (max)
>> +			max--;
>
> With the below max -= SGX_NR_TO_SCAN/2 staff, do you still need this one?
>

Logically still needed for case max <= SGX_NR_TO_SCAN * 2

>> +
>> +		/*
>> +		 * Unless the limit is extremely low, in which case forcing
>> +		 * reclaim will likely cause thrashing, force the cgroup to
>> +		 * reclaim at least once if it's operating *near* its maximum
>> +		 * limit by adjusting @max down by half the min reclaim size.
>
> OK.  But why choose "SGX_NO_TO_SCAN * 2" as "extremely low"? E.g, could  
> we
> choose SGX_NR_TO_SCAN instead?
> IMHO at least we should at least put a comment to mention this.
>
> And maybe you can have a dedicated macro for that in which way I believe  
> the
> code would be easier to understand?

Good point. I think the value is kind of arbitrary. We consider  
enclaves/cgroups of 64K size are very small. If such a cgroup ever reaches  
the limit, then we don't aggressively reclaim to optimize #PF handling.  
User might as well just raise the limit if it is not performant.

>
>> +		 * This work func is scheduled by sgx_epc_cgroup_try_charge
>
> This has been mentioned in the function comment already.
>
>> +		 * when it cannot directly reclaim due to being in an atomic
>> +		 * context, e.g. EPC allocation in a fault handler.
>
> Why a fault handler is an "atomic context"?  Just say when it cannot  
> directly
> reclaim.
>

Sure.

>> Waiting
>> +		 * to reclaim until the cgroup is actually at its limit is less
>> +		 * performant as it means the faulting task is effectively
>> +		 * blocked until a worker makes its way through the global work
>> +		 * queue.
>> +		 */
>> +		if (max > SGX_NR_TO_SCAN * 2)
>> +			max -= (SGX_NR_TO_SCAN / 2);
>> +
>> +		cur = sgx_epc_cgroup_page_counter_read(epc_cg);
>> +
>> +		if (cur <= max || sgx_epc_cgroup_lru_empty(epc_cg->cg))
>> +			break;
>> +
>> +		/* Keep reclaiming until above condition is met. */
>> +		sgx_epc_cgroup_reclaim_pages(epc_cg->cg);
>
> Also, each loop here calls sgx_epc_cgroup_max_pages_to_root() and
> sgx_epc_cgroup_lru_empty(), both loop the given EPC cgroup and  
> descendants.  If
> we still make sgx_reclaim_pages() always scan SGX_NR_TO_SCAN pages,  
> seems we can
> reduce the number of loops here?
>

[We already scan SGX_NR_TO_SCAN pages for the cgroup at the level of  
sgx_epc_cgroup_reclaim_pages().]

I think you mean that we keep scanning and reclaiming until at least  
SGX_NR_TO_SCAN pages are reclaimed as your code suggested above. We  
probably can make that a version for this background thread for  
optimization. But sgx_epc_cgroup_max_pages_to_root() and  
sgx_epc_cgroup_lru_empty() are not that bad unless we had very deep and  
wide cgroup trees. So would you agree we defer this optimization for later?


>> +	}
>> +}
>> +
>> +/**
>> + * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC  
>> page
>>   * @epc_cg:	The EPC cgroup to be charged for the page.
>>   * Return:
>>   * * %0 - If successfully charged.
>> @@ -38,6 +209,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
>>  	if (!epc_cg)
>>  		return;
>>
>> +	cancel_work_sync(&epc_cg->reclaim_work);
>>  	kfree(epc_cg);
>>  }
>>
>> @@ -50,6 +222,8 @@ const struct misc_res_ops sgx_epc_cgroup_ops = {
>>
>>  static void sgx_epc_misc_init(struct misc_cg *cg, struct  
>> sgx_epc_cgroup *epc_cg)
>>  {
>> +	sgx_lru_init(&epc_cg->lru);
>> +	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
>>  	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
>>  	epc_cg->cg = cg;
>>  }
>> @@ -69,6 +243,11 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
>>
>>  void sgx_epc_cgroup_init(void)
>>  {
>> +	sgx_epc_cg_wq = alloc_workqueue("sgx_epc_cg_wq",
>> +					WQ_UNBOUND | WQ_FREEZABLE,
>> +					WQ_UNBOUND_MAX_ACTIVE);
>> +	BUG_ON(!sgx_epc_cg_wq);
>
> You cannot BUG_ON() simply due to unable to allocate a workqueue.  You  
> can use
> some way to mark EPC cgroup as disabled but keep going.  Static key is  
> one way
> although we cannot re-enable it at runtime.
>
>
Okay, I'll disable and print a log.

[...]
[workqueue related discussion in separate email]

Thanks
Haitao

