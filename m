Return-Path: <cgroups+bounces-2326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DD898CF4
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D6F2844AB
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC6712DD9E;
	Thu,  4 Apr 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W86xt4Gu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489971C6BC;
	Thu,  4 Apr 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250325; cv=none; b=mpxDaK26in4F41S3NqbA8nzTJj6rFqTYCSTSKuUzUZzDo4abz/0NLmIIsj5TmEGvccYGYxw7FdjPSJn23xcRudqw4SG8147WJ2AEVGjZ9WW24rZ5Si3bR2Fp9PTiSuhU2+ACAvJ8Y0C/cmsDJF/zSXtGKAxDNZZaHkhnbhX1dJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250325; c=relaxed/simple;
	bh=aiZSbGzOG/4RlCwdBiEVdFCJ3+wpRJZPZc+8td5FrsU=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=tJQLJgu8eaiaNY4n4qMcufUCtgGXGNVO7Y0igij1rMbZmqgHp8PnJPygoPlOAjzfCPGCPEBVxrmYSlMaSz8rKDRnkstFWIkeOPs1bmQcvUE8MuRcwkaC62gjaL0FlqgFD/o3230zt87UOi5UaD5kqfE33cRhXbt0LMUzcb0ahQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W86xt4Gu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712250324; x=1743786324;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=aiZSbGzOG/4RlCwdBiEVdFCJ3+wpRJZPZc+8td5FrsU=;
  b=W86xt4GuE4PI3ch5pZ9GWoTPiwl+1vt4qpmOi31h2kbpR3+TTU/sEAPP
   nFGIDb3nxUbOS/4bRONsbkRM1kLK1nbZ7sp+UUvo1yRWCoVWGpALmT3ar
   7ElWUAybD643I/xTa7GnLnqCLbwhgasEE3sm6fvLmRx/BmajUwkxk4Gpr
   10ckR+NVZXoGhHLPqMjuVsnjZ6K++LdXb1STcoiVNO2Eg4CJB2orHXo64
   G9Sf0VXRwb52FsV9bhIom9MoQ8Lox6yhiXJ2A5KABGRIkLxsS4+OfYSSd
   VqOl3zeSwO3AwbV/GfnQ5FtR5qHWUg+4SliaVdW5K4eP/uIzDMQJ8l1RS
   Q==;
X-CSE-ConnectionGUID: Ozqd3EzJQwedHJahMOCh1A==
X-CSE-MsgGUID: a6VuIc/NTym6dPRJhoyvnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7395670"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7395670"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:05:18 -0700
X-CSE-ConnectionGUID: SAPJm0r9QnWxZ5K63C5Ymw==
X-CSE-MsgGUID: 6eg6zFrEQSy1mdPMNzjoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23348713"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.247.65.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 04 Apr 2024 10:05:05 -0700
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
Subject: Re: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-9-haitao.huang@linux.intel.com>
 <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
Date: Thu, 04 Apr 2024 12:05:00 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Kai,
Thanks for your suggestions. I'll adopt most of it as it.
Minor details below.

On Wed, 03 Apr 2024 08:08:28 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2024-03-27 at 17:22 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> When a cgroup usage reaches its limit, and it is to be charged, i.e.,
>> sgx_cgroup_try_charge() called for new allocations, the cgroup needs to
>> reclaim pages from its LRU or LRUs of its descendants to make room for
>> any new allocations. This patch adds the basic building block for the
>> per-cgroup reclamation flow and use it for synchronous reclamation in
>> sgx_cgroup_try_charge().
>
> It's better to firstly mention _why_ we need this first:
>
> Currently in the EPC page allocation, the kernel simply fails the  
> allocation
> when the current EPC cgroup fails to charge due to its usage reaching  
> limit.
> This is not ideal.  When that happens, a better way is to reclaim EPC  
> page(s)
> from the current EPC cgroup (and/or its descendants) to reduce its usage  
> so the
> new allocation can succeed.
>
> Add the basic building blocks to support the per-cgroup reclamation flow  
> ...
>

ok

>>
>> First, modify sgx_reclaim_pages() to let callers to pass in the LRU from
>> which pages are reclaimed, so it can be reused by both the global and
>> cgroup reclaimers. Also return the number of pages attempted, so a
>> cgroup reclaimer can use it to track reclamation progress from its
>> descendants.
>
> IMHO you are jumping too fast to the implementation details.  Better to  
> have
> some more background:
>
> "
> Currently the kernel only has one place to reclaim EPC pages: the global  
> EPC LRU
> list.  To support the "per-cgroup" EPC reclaim, maintain an LRU list for  
> each
> EPC cgroup, and introduce a "cgroup" variant function to reclaim EPC  
> page(s)
> from a given EPC cgroup (and its descendants).
> "
>

ok

>>
>> For the global reclaimer, replace all call sites of sgx_reclaim_pages()
>> with calls to a newly created wrapper, sgx_reclaim_pages_global(), which
>> just calls sgx_reclaim_pages() with the global LRU passed in.
>>
>> For cgroup reclamation, implement a basic reclamation flow, encapsulated
>> in the top-level function, sgx_cgroup_reclaim_pages(). It performs a
>> pre-order walk on a given cgroup subtree, and calls sgx_reclaim_pages()
>> at each node passing in the LRU of that node. It keeps track of total
>> attempted pages and stops the walk if desired number of pages are
>> attempted.
>
> Then it's time to jump to implementation details:
>
> "
> Currently the kernel does the global EPC reclaim in sgx_reclaim_page().   
> It
> always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16) pages.
> Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN pages from  
> the
> global LRU, and then tries to reclaim these pages at once for better
> performance.
>
> Use similar way to implement the "cgroup" variant EPC reclaim, but keep  
> the
> implementation simple: 1) change sgx_reclaim_pages() to take an LRU as  
> input,
> and return the pages that are "scanned" (but not actually reclaimed); 2)  
> loop
> the given EPC cgroup and its descendants and do the new  
> sgx_reclaim_pages()
> until SGX_NR_TO_SCAN pages are "scanned".
>
> This implementation always tries to reclaim SGX_NR_TO_SCAN pages from  
> the LRU of
> the given EPC cgroup, and only moves to its descendants when there's no  
> enough
> reclaimable EPC pages to "scan" in its LRU.  It should be enough for  
> most cases.
> "
>

ok

> Then I think it's better to explain why "alternatives" are not chosen:
>
> "
> Note, this simple implementation doesn't _exactly_ mimic the current  
> global EPC
> reclaim (which always tries to do the actual reclaim in batch of  
> SGX_NR_TO_SCAN
> pages): when LRUs have less than SGX_NR_TO_SCAN reclaimable pages, the  
> actual
> reclaim of EPC pages will be split into smaller batches _across_  
> multiple LRUs
> with each being smaller than SGX_NR_TO_SCAN pages.
>
> A more precise way to mimic the current global EPC reclaim would be to  
> have a
> new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages _across_  
> the
> given EPC cgroup _AND_ its descendants, and then do the actual reclaim  
> in one
> batch.  But this is unnecessarily complicated at this stage.
>
> Alternatively, the current sgx_reclaim_pages() could be changed to  
> return the
> actual "reclaimed" pages, but not "scanned" pages.  However this  
> solution also
> has cons: <CONS>
> "
>
> <CONS>:
>
> I recall you mentioned "unable to control latency of each reclaim" etc,  
> but IIUC
> one could be:
>
> This approach may result in higher chance of "reclaiming EPC pages from
> descendants but not the root/given EPC cgorup", e.g., when all EPC pages  
> in the
> root EPC cgroup are all young while these in its descendants are not.   
> This may
> not be desired.
>
> Makes sense?
>

Agree with the flow.
The con is that this function may block too long that is unacceptable for  
some callers like synchronous flow which only needs some minimal (e.g.,  
one page to pass try_charge()) to make forward progress. Convention is to  
call this function loops to ensure caller's condition is met, i.e., the  
way the original sgx_reclaim_pages() is called in existing code.

>>
>> Finally, pass a parameter to sgx_cgroup_try_charge() to indicate whether
>> a synchronous reclamation is allowed. If the caller allows and cgroup
>> usage is at its limit, trigger the synchronous reclamation by calling
>> sgx_cgroup_reclaim_pages() in a loop with cond_resched() in between
>> iterations.
>
> This isn't needed IMHO as you can easily see in the code, and there's no  
> "design
> choices" here.
>
> General rule: focus on explaining "why", and "design choices", but not
> implementation details, which can be seen in the code.
>
>>
>> A later patch will add support for asynchronous reclamation reusing
>> sgx_cgroup_reclaim_pages().
>
> Please also mention why "leaving asynchronous reclamation to later  
> patch(es)" is
> fine.  E.g., it won't break anything I suppose.
>

Right. Pages are still in the global list at the moment and only global  
reclaiming is active until the "turn on" patch. Separating out is really  
just for the purpose of review IMHO.

> (That being said, as mentioned in previous version, I _think_ it's  
> better to
> have one patch to implement the "cgroup" variant EPC reclaim function,  
> and
> another patch to use it: both "sync" and "async" way.  But for the sake  
> of
> moving forward, I am fine with the current way if nothing is broken.)
>
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V10:
>> - Simplify the signature by removing a pointer to nr_to_scan (Kai)
>> - Return pages attempted instead of reclaimed as it is really what the
>> cgroup caller needs to track progress. This further simplifies the  
>> design.
>> - Merge patch for exposing sgx_reclaim_pages() with basic synchronous
>> reclamation. (Kai)
>
> (As mentioned above, I am not sure I suggested this but anyway...)
>

Sorry above did not characterize your suggestion accurately.
I'll keep the sync reclaim flow in for now unless strong objections.

>> - Shorten names for EPC cgroup functions. (Jarkko)
>> - Fix/add comments to justify the design (Kai)
>> - Separate out a helper for for addressing single iteration of the loop
>> in sgx_cgroup_try_charge(). (Jarkko)
>>
>> V9:
>> - Add comments for static variables. (Jarkko)
>>
>> V8:
>> - Use width of 80 characters in text paragraphs. (Jarkko)
>> - Remove alignment for substructure variables. (Jarkko)
>>
>> V7:
>> - Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC  
>> reclaim
>> function". Do not split the top level function (Kai)
>> - Dropped patches 7 and 8 of V6.
>> - Split this out from the big patch, #10 in V6. (Dave, Kai)
>> ---
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 127 ++++++++++++++++++++++++++-
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |   5 +-
>>  arch/x86/kernel/cpu/sgx/main.c       |  45 ++++++----
>>  arch/x86/kernel/cpu/sgx/sgx.h        |   1 +
>>  4 files changed, 156 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> index a1dd43c195b2..f7a487a29ed1 100644
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -9,16 +9,136 @@
>>  static struct sgx_cgroup sgx_cg_root;
>>
>>  /**
>> - * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
>> + * sgx_cgroup_lru_empty() - check if a cgroup tree has no pages on its  
>> LRUs
>> + * @root:	Root of the tree to check
>> + *
>> + * Used to avoid livelocks due to a cgroup having a non-zero charge  
>> count but
>> + * no pages on its LRUs, e.g. due to a dead enclave waiting to be  
>> released or
>> + * because all pages in the cgroup are unreclaimable.
>
> I don't think this comment (the paragraph starting from "Used") should  
> be here,
> but should be put to the code where it applies.
>  Comment what this function does instead.
>

Ok. I can drop it if no objections from others.
This was in from the beginning and I saw couple of other examples in  
existing code that explains expected usage. So I thought we were supposed  
to do that.

>> + *
>> + * Return: %true if all cgroups under the specified root have empty  
>> LRU lists.
>> + */
>> +static bool sgx_cgroup_lru_empty(struct misc_cg *root)
>> +{
>> +	struct cgroup_subsys_state *css_root;
>> +	struct cgroup_subsys_state *pos;
>> +	struct sgx_cgroup *sgx_cg;
>> +	bool ret = true;
>> +
>> +	/*
>> +	 * Caller ensure css_root ref acquired
>> +	 */
>
> 	/* The caller must ensure ... */
>

ok

>> +	css_root = &root->css;
>> +
>> +	rcu_read_lock();
>> +	css_for_each_descendant_pre(pos, css_root) {
>> +		if (!css_tryget(pos))
>> +			break;
>> +
>> +		rcu_read_unlock();
>> +
>> +		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
>> +
>> +		spin_lock(&sgx_cg->lru.lock);
>> +		ret = list_empty(&sgx_cg->lru.reclaimable);
>> +		spin_unlock(&sgx_cg->lru.lock);
>> +
>> +		rcu_read_lock();
>> +		css_put(pos);
>> +		if (!ret)
>> +			break;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
>> + * @root:	The root of cgroup tree to reclaim from.
>>   *
>> + * This function performs a pre-order walk in the cgroup tree under  
>> the given
>> + * root, attempting to reclaim pages at each node until a fixed number  
>> of pages
>> + * (%SGX_NR_TO_SCAN) are attempted for reclamation. No guarantee of  
>> success on
>> + * the actual reclamation process. In extreme cases, if all pages in  
>> front of
>> + * the LRUs are recently accessed, i.e., considered "too young" to  
>> reclaim, no
>> + * page will actually be reclaimed after walking the whole tree.
>> + *
>> + * Callers check for the need for reclamation before calling this  
>> function. Some
>> + * callers may run this function in a loop guarded by some criteria for
>> + * triggering reclamation, and call cond_resched() in between  
>> iterations to
>> + * avoid indefinite blocking.
>
> Ditto IMHO the second paragraph isn't necessary.  But anyway.
>

Same as above, I can drop if no objections.

>> + */
>> +static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
>> +{
>> +	struct cgroup_subsys_state *css_root;
>> +	struct cgroup_subsys_state *pos;
>> +	struct sgx_cgroup *sgx_cg;
>> +	unsigned int cnt = 0;
>> +
>> +	 /* Caller ensure css_root ref acquired */
>> +	css_root = &root->css;
>> +
>> +	rcu_read_lock();
>> +	css_for_each_descendant_pre(pos, css_root) {
>> +		if (!css_tryget(pos))
>> +			break;
>> +		rcu_read_unlock();
>> +
>> +		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
>> +		cnt += sgx_reclaim_pages(&sgx_cg->lru);
>> +
>> +		rcu_read_lock();
>> +		css_put(pos);
>> +
>> +		if (cnt >= SGX_NR_TO_SCAN)
>> +			break;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
>> +
>> +static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
>> +{
>> +	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
>> +		return 0;
>> +
>> +	if (sgx_cgroup_lru_empty(epc_cg->cg))
>> +		return -ENOMEM;
>> +
>> +	if (signal_pending(current))
>> +		return -ERESTARTSYS;
>> +
>> +	return -EBUSY;
>> +}
>> +
>> +/**
>> + * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
>>   * @sgx_cg:	The EPC cgroup to be charged for the page.
>> + * @reclaim:	Whether or not synchronous EPC reclaim is allowed.
>>   * Return:
>>   * * %0 - If successfully charged.
>>   * * -errno - for failures.
>>   */
>> -int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim  
>> reclaim)
>>  {
>> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
>> +	int ret;
>> +
>> +	for (;;) {
>> +		ret = __sgx_cgroup_try_charge(sgx_cg);
>> +
>> +		if (ret != -EBUSY)
>> +			return ret;
>> +
>> +		if (reclaim == SGX_NO_RECLAIM)
>> +			return -ENOMEM;
>> +
>> +		sgx_cgroup_reclaim_pages(sgx_cg->cg);
>> +		cond_resched();
>> +	}
>> +
>> +	return 0;
>>  }
>>
>>  /**
>> @@ -50,6 +170,7 @@ const struct misc_res_ops sgx_cgroup_ops = {
>>
>>  static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup  
>> *sgx_cg)
>>  {
>> +	sgx_lru_init(&sgx_cg->lru);
>>  	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
>>  	sgx_cg->cg = cg;
>>  }
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> index 8f794e23fad6..f62dce0cac51 100644
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -20,7 +20,7 @@ static inline struct sgx_cgroup  
>> *sgx_get_current_cg(void)
>>
>>  static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
>>
>> -static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg,  
>> enum sgx_reclaim r)
>
> Is the @r here intentional for shorter typing?
>

yes :-)
Will speel out to make it consistent if that's the concern.

> [...]
>
>> @@ -572,7 +583,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, enum sgx_reclaim reclaim)
>>  	int ret;
>>
>>  	sgx_cg = sgx_get_current_cg();
>> -	ret = sgx_cgroup_try_charge(sgx_cg);
>> +	ret = sgx_cgroup_try_charge(sgx_cg, reclaim);
>>  	if (ret) {
>>  		sgx_put_cg(sgx_cg);
>>  		return ERR_PTR(ret);
>> @@ -604,7 +615,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, enum sgx_reclaim reclaim)
>>  		 * Need to do a global reclamation if cgroup was not full but free
>>  		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
>>  		 */
>> -		sgx_reclaim_pages();
>> +		sgx_reclaim_pages_global();
>>  		cond_resched();
>>  	}
>
> I wish we could put the result of discussion around "per-cgroup reclaim"  
> vs
> "global reclaim" when try_charge() succeeds but still fails to allocate  
> to the
> changelog:
>
> https://lore.kernel.org/lkml/a2d633da-6ab8-49d0-bca5-1e9eb7c3fc9a@intel.com/
>
> But perhaps it is just me that thinks this better to be clarified in  
> changelog,
> so up to you.
>

Will add that.

> (btw, looks another reason to split the "cgroup" EPC reclaim function  
> out as a
> separate patch, but again, up to you.)
>
>
Thanks
Haitao

