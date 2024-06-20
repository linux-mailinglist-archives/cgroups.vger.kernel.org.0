Return-Path: <cgroups+bounces-3258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DD910B16
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 18:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EED6B24FEB
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18D1B1418;
	Thu, 20 Jun 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQhKw1Ls"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297191AF68A;
	Thu, 20 Jun 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899557; cv=none; b=ENwDMvV+vYGx2esnEbSX9dtyo8QnQFOPTmDvK1Y0VX0WiN7wsZNseEjzijd08yCt7uhB9AH123d0xWiG5CbuN3swJAHDwPp8cwX7uh7PWYPbUq7j21s1xd74cg52MJKTq6pTfI7SYJPSJPFT9b3E7+N2Jd3gQhWO8zIhFIoFDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899557; c=relaxed/simple;
	bh=2SDKW4L6Q15RBL23B70Zucrxs8TmimpdU68R6G9rQX0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=rbsE8jrYGpGb+N6LtZ+eu+BQnOn7EMJ7ouPET/s5yOK0S/FeLWw5Ja1CCCimvr1N6HQm7kJ0AM5rQOwF+rLjxn55pEqL7v2VnAZ5FmtGu0qHNEZ0prqtpFqVxSipUx5aw4eGmPqFeAJAVaOJSFTFsbKCdIbrE8kk0E7i4p8HyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQhKw1Ls; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718899556; x=1750435556;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=2SDKW4L6Q15RBL23B70Zucrxs8TmimpdU68R6G9rQX0=;
  b=RQhKw1LsdVq3CZpldglGUfeckHpEByzOu/3xPh/7KK86d3tDOcZvKYGi
   hVhM6NwSPwCaG3AtqYtqRyLtN6sIC8YD3sC0B9M9RzE5Dew/svi6MGNFW
   W8NqeawYGKBK0PxC42w8aCm5es2ij0niBoph0tuzm7RFFqfLoBkqqUh39
   nrkQu1yM9euBODqcP+F+zsV7UNUGBbp51Gfzcr5NliCHFQCPM/PVp8wkq
   Y2VoPZB6z8Vl9xtklqMoWmf6AtU29d//m3h+XHaia2snPfvSZEd3vhINQ
   zVZmsfmcr9k6fVJ9TVgv/vx8hR3R7IVI5LHeNLBjf9i69bg55EhiC+D/e
   g==;
X-CSE-ConnectionGUID: CJQZLSkVQ4qcz7aOVB4iVA==
X-CSE-MsgGUID: Mv5TwVKaRGKnYsEOL/dSUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15725360"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15725360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:05:41 -0700
X-CSE-ConnectionGUID: NYLIaNUqT4G7hDfBMgCHWA==
X-CSE-MsgGUID: IcQZEVWxSj+fYIlpW4HpRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42749926"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 20 Jun 2024 09:05:37 -0700
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
Subject: Re: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
 <20240617125321.36658-9-haitao.huang@linux.intel.com>
 <ecaab6953b36adb278c98b01f5eb647ff0cc9aab.camel@intel.com>
Date: Thu, 20 Jun 2024 11:05:35 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2pn9nlapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ecaab6953b36adb278c98b01f5eb647ff0cc9aab.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)


On Thu, 20 Jun 2024 08:28:57 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
> On 18/06/2024 12:53 am, Huang, Haitao wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Currently in the EPC page allocation, the kernel simply fails the
>> allocation when the current EPC cgroup fails to charge due to its usage
>> reaching limit.  This is not ideal. When that happens, a better way is
>> to reclaim EPC page(s) from the current EPC cgroup (and/or its
>> descendants) to reduce its usage so the new allocation can succeed.
>>
>> Add the basic building blocks to support per-cgroup reclamation.
>>
>> Currently the kernel only has one place to reclaim EPC pages: the global
>> EPC LRU list.  To support the "per-cgroup" EPC reclaim, maintain an LRU
>> list for each EPC cgroup, and introduce a "cgroup" variant function to
>> reclaim EPC pages from a given EPC cgroup and its descendants.
>>
>> Currently the kernel does the global EPC reclaim in sgx_reclaim_page().
>> It always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16)
>> pages.  Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN
>> pages from the global LRU, and then tries to reclaim these pages at once
>> for better performance.
>>
>> Implement the "cgroup" variant EPC reclaim in a similar way, but keep
>> the implementation simple: 1) change sgx_reclaim_pages() to take an LRU
>> as input, and return the pages that are "scanned" and attempted for
>> reclamation (but not necessarily reclaimed successfully); 2) loop the
>> given EPC cgroup and its descendants and do the new sgx_reclaim_pages()
>> until SGX_NR_TO_SCAN pages are "scanned".
>> This implementation, encapsulated in sgx_cgroup_reclaim_pages(), always
>> tries to reclaim SGX_NR_TO_SCAN pages from the LRU of the given EPC
>> cgroup, and only moves to its descendants when there's no enough
>> reclaimable EPC pages to "scan" in its LRU.  It should be enough for
>> most cases.
>
> [...]
>
>> In other cases, the caller may invoke this function in a
>> loop to ensure enough pages reclaimed for its usage. To ensure all
>> descendant groups scanned in a round-robin fashion in those cases,
>> sgx_cgroup_reclaim_pages() takes in a starting cgroup and returns the
>> next cgroup that the caller can pass in as the new starting cgroup for a
>> subsequent call.
>
>
> AFAICT this part is new, and I believe this "round-robin" thing is just
> for the "global reclaim"?  Or is it also for per-cgroup reclaim where  
> more
> than SGX_NR_TO_SCAN pages needs to be reclaimed?
>
> I wish the changelog should just point out what consumers will use this
> new sgx_cgroup_reclaim_pages(), like:
>
> The sgx_cgroup_reclaim_pages() will be used in three cases:
>
>  1) direct/sync per-cgroup reclaim in try_charge()
>  2) indirect/async per-cgroup reclaim triggered in try_charge()
>  3) global reclaim
>
> And then describe how will they use sgx_cgroup_reclaim_pages():
>
> Both 1) and 2) can result in needing to reclaim more than SGX_NR_TO_SCAN
> pages, in which case we should <fill in how to reclaim>.
>
> For 3), the new global reclaim should try tot match the existing global
> reclaim behaviour, that is to try to treat all EPC pages equally.
> <continue to explain how can sgx_cgroup_reclaim_pages() achieve this.>
>
> With above context, we can justify why to make sgx_cgroup_reclaim_pages()
> in this form.
>
This new part is only to address the issue you raised in this thread:
https://lore.kernel.org/lkml/op.2ndsydgywjvjmi@hhuan26-mobl.amr.corp.intel.com/

Really it has nothing to do whether global, direct/async, per-cgroup  
contexts. They all should use the function the same way. This paragraph  
describes the design and
I thought the above new statements justify the reason we return 'next' so  
it can reclaim into descedant in round-robin fashion?  No sure we need get  
into details of different usages of the functions which are in code  
actually?

I'll address the new global reclamation behavior later when this function  
was actually used for that. And the difference really exists before and  
not because of this change.

>>
>> Note, this simple implementation doesn't _exactly_ mimic the current
>> global EPC reclaim (which always tries to do the actual reclaim in batch
>> of SGX_NR_TO_SCAN pages): when LRUs have less than SGX_NR_TO_SCAN
>> reclaimable pages, the actual reclaim of EPC pages will be split into
>> smaller batches _across_ multiple LRUs with each being smaller than
>> SGX_NR_TO_SCAN pages.
>>
>> A more precise way to mimic the current global EPC reclaim would be to
>> have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
>> _across_ the given EPC cgroup _AND_ its descendants, and then do the
>> actual reclaim in one batch.  But this is unnecessarily complicated at
>> this stage.
>>
>> Alternatively, the current sgx_reclaim_pages() could be changed to
>> return the actual "reclaimed" pages, but not "scanned" pages. However,
>> the reclamation is a lengthy process, forcing a successful reclamation
>> of predetermined number of pages may block the caller for too long. And
>> that may not be acceptable in some synchronous contexts, e.g., in
>> serving an ioctl().
>>
>> With this building block in place, add synchronous reclamation support
>> in sgx_cgroup_try_charge(): trigger a call to
>> sgx_cgroup_reclaim_pages() if the cgroup reaches its limit and the
>> caller allows synchronous reclaim as indicated by s newly added
>> parameter.
>>
>> A later patch will add support for asynchronous reclamation reusing
>> sgx_cgroup_reclaim_pages().
>
> It seems you also should mention the new global reclaim will also use
> this sgx_cgroup_reclaim_pages()?
>
> [...]
>
>> +/**
>> + * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
>> + * @root:	The root of cgroup tree to reclaim from.
>> + * @start:	The descendant cgroup from which to start the tree walking.
>> + *
>> + * This function performs a pre-order walk in the cgroup tree under  
>> the given
>> + * root, starting from the node %start, or from the root if %start is  
>> NULL. The
>> + * function will attempt to reclaim pages at each node until a fixed  
>> number of
>> + * pages (%SGX_NR_TO_SCAN) are attempted for reclamation. No guarantee  
>> of
>> + * success on the actual reclamation process. In extreme cases, if all  
>> pages in
>> + * front of the LRUs are recently accessed, i.e., considered "too  
>> young" to
>> + * reclaim, no page will actually be reclaimed after walking the whole  
>> tree.
>> + *
>> + * In some cases, a caller may want to ensure enough reclamation until  
>> its
>> + * specific need is met. In those cases, the caller should invoke this  
>> function
>> + * in a loop, and at each iteration passes in the same root and the  
>> next node
>> + * returned from the previous call as the new %start.
>> + *
>> + * Return: The next misc cgroup in the subtree to continue the  
>> scanning and
>> + * attempt for more reclamation from this subtree if needed.
>
> [...]
>
>> Caller must
>> + * release the reference if the returned is not used as %start for a  
>> subsequent
>> + * call.
>>
>
> This sentence isn't clear to me.
>
> First of all, release the reference "of what"?  The %start, or the one
> returned by this function?
>

will this be better?
  * Return: A reference to next misc cgroup in the subtree to continue the
  * scanning and attempt for more reclamation from this subtree if needed.
  * Caller must release the returned reference if the returned is not used  
as
  * %start for a subsequent call.

> And is it because of ...
>
>> + */
>> +static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root,  
>> struct misc_cg *start)
>> +{
>> +	struct cgroup_subsys_state *css_root, *pos;
>> +	struct cgroup_subsys_state *next = NULL;
>> +	struct sgx_cgroup *sgx_cg;
>> +	unsigned int cnt = 0;
>> +
>> +	 /* Caller must ensure css_root and start ref's acquired */
>
> ... the caller must acquire the ref of both @css_root and @css_start, and
> ...
yes
>
>> +	css_root = &root->css;
>> +	if (start)
>> +		pos = &start->css;
>> +	else
>> +		pos = css_root;
>> +
>> +	while (cnt < SGX_NR_TO_SCAN) {
>> +		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
>> +		cnt += sgx_reclaim_pages(&sgx_cg->lru);
>> +
>> +		rcu_read_lock();
>> +
>> +		next = css_next_descendant_pre(pos, css_root);
>> +
>> +		if (pos != css_root)
>> +			css_put(pos);
>
> ... the ref is decreased internally?
>

Right.

>> +
>> +		if (!next || !css_tryget(next)) {
>> +			/* We are done if next is NULL or not safe to continue
>> +			 * the walk if next is dead. Return NULL and the caller
>> +			 * determines whether to restart from root.
>> +			 */
>
> Incorrect comment style.
>
Will fix
>> +			rcu_read_unlock();
>> +			return NULL;
>> +		}
>> +
>> +		rcu_read_unlock();
>> +		pos = next;
>
> There's no ref grab here, wouldn't the above ...
>
tryget() done to next

> 		if (pos != css_root)
> 			css_put(pos);
>
> ... decrease the ref w/o having it been increased?
>
>> +	}
>> +
>> +	return css_misc(next);
>
> Here AFAICT the ref isn't increased, but ...
>
We only return next when next && css_tryget(next), otherwise NULL.

> [...]
>
>
>> +/**
>> + * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
>>    * @sgx_cg:	The EPC cgroup to be charged for the page.
>> + * @reclaim:	Whether or not synchronous EPC reclaim is allowed.
>>    * Return:
>>    * * %0 - If successfully charged.
>>    * * -errno - for failures.
>>    */
>> -int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim  
>> reclaim)
>>   {
>> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
>> +	int ret;
>> +	struct misc_cg *cg_next = NULL;
>> +
>> +	for (;;) {
>> +		ret = __sgx_cgroup_try_charge(sgx_cg);
>> +
>> +		if (ret != -EBUSY)
>> +			goto out;
>> +
>> +		if (reclaim == SGX_NO_RECLAIM) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
>> +		cond_resched();
>> +	}
>> +
>> +out:
>> +	if (cg_next != sgx_cg->cg)
>> +		put_misc_cg(cg_next);
>
> ... if I am reading correctly, here you does the put anyway.
>
cg_next ref is increased or it is NULL.
Only puts the last one no longer to be passed back in to  
sgx_cgroup_reclaim_page()

>> +	return ret;
>>   }
>>
>
> And when there are more than SGX_NR_TO_SCAN pages that need to reclaim,
> the above ...

Note, all sgx_cgroup_reclaim_pages() guarantees is scanning SGX_NR_TO_SCAN  
pages.
>
> 	for (;;) {
> 		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
> 	}
>
> ... actually tries to reclaim those pages from @sgx_cg _AND_ it's
> descendants, and tries to do it _EQUALLY_.
>
> Is this desired, or should we always try to reclaim from the @sgx_cg
> first, but only moves to the desendants when the @sgx_cg shouldn't be
> reclaimed anymore?
>

we still reclaim in sgx_cg in first scan and attempt of reclaiming for  
SGX_NR_TOS_CAN pages, but if it turns out that did not satisfy caller  
needs, then caller goes on to reclaim from descendants by passing in  
'next' as starting point.

> Anyway, it's different from the previous behaviour.
>
Again, this is to fix the issue you raised. I consider it improved  
behavior :-)
> [...]
>
>> -static bool sgx_should_reclaim(unsigned long watermark)
>> +static bool sgx_should_reclaim_global(unsigned long watermark)
>>   {
>>   	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
>>   	       !list_empty(&sgx_global_lru.reclaimable);
>>   }
>>
>> +static void sgx_reclaim_pages_global(void)
>> +{
>> +	sgx_reclaim_pages(&sgx_global_lru);
>> +}
>> +
>>   /*
>>    * sgx_reclaim_direct() should be called (without enclave's mutex  
>> held)
>>    * in locations where SGX memory resources might be low and might be
>> @@ -394,8 +405,8 @@ static bool sgx_should_reclaim(unsigned long  
>> watermark)
>>    */
>>   void sgx_reclaim_direct(void)
>>   {
>> -	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> -		sgx_reclaim_pages();
>> +	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
>> +		sgx_reclaim_pages_global();
>>   }
>>
>
> I wish the rename was mentioned in the changelog too.
>
OK

