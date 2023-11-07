Return-Path: <cgroups+bounces-210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0667E32CF
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD8E1C20365
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEE1873;
	Tue,  7 Nov 2023 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7Zux7xE"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073320EB
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 02:09:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877010A;
	Mon,  6 Nov 2023 18:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699322991; x=1730858991;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=ZHhrLsAbY+01aibkrj3PgqbaJGRt7ZXSmtweYn7WIYc=;
  b=Q7Zux7xEXzW/9zVxdKq/1PfgbTLRqa+utCLA87Yv5qrWCRgHHEoATaLU
   5czn346oHl2vcKDJGQaZvNp1tjTBcAR0oMDsk5qUeYVid/zk4g4TzgBK4
   7iO4YJj6aimdVjyXhHr5hdKvZzJG7I6eJd1aEZRlEqwuwG/xpmevs8gY+
   eEUPZv4k1JRdJ36jXO1p+O/YOs099xW3s2AhpPE5BLWcLRjbm507FyNWA
   Qz3N5L6bm194Ksef+gaSuHqeDaqukkGac+npVa/nDGFKSzLdJirjq60ij
   GMbXc1yFPxihmUKAdCgkExPP961ch3aEpajoMyHsdXjPQuuJ0hFebjE1A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475652929"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475652929"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 18:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766148743"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="766148743"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.50.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Nov 2023 18:08:44 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Huang,
 Kai" <kai.huang@intel.com>, "Haitao Huang" <haitao.huang@linux.intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "Christopherson,, Sean" <seanjc@google.com>, "Zhang, Bo"
 <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
 <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Mon, 06 Nov 2023 20:08:43 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 06 Nov 2023 19:16:30 -0600, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> On Mon, 06 Nov 2023 16:18:30 -0600, Huang, Kai <kai.huang@intel.com>  
> wrote:
>
>>>
>>> > > +/**
>>> > > + * sgx_epc_cgroup_try_charge() - hierarchically try to charge a  
>>> single
>>> > > EPC page
>>> > > + *
>>> > > + * Returns EPC cgroup or NULL on success, -errno on failure.
>>> > > + */
>>> > > +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
>>> > > +{
>>> > > +	struct sgx_epc_cgroup *epc_cg;
>>> > > +	int ret;
>>> > > +
>>> > > +	if (sgx_epc_cgroup_disabled())
>>> > > +		return NULL;
>>> > > +
>>> > > +	epc_cg = sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
>>> > > +	ret = misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,  
>>> PAGE_SIZE);
>>> > > +
>>> > > +	if (!ret) {
>>> > > +		/* No epc_cg returned, release ref from get_current_misc_cg() */
>>> > > +		put_misc_cg(epc_cg->cg);
>>> > > +		return ERR_PTR(-ENOMEM);
>>> >
>>> > misc_cg_try_charge() returns 0 when successfully charged, no?
>>>
>>> Right. I really made some mess in rebasing :-(
>>>
>>> >
>>> > > +	}
>>> > > +
>>> > > +	/* Ref released in sgx_epc_cgroup_uncharge() */
>>> > > +	return epc_cg;
>>> > > +}
>>> >
>>> > IMHO the above _try_charge() returning a pointer of EPC cgroup is a
>>> > little bit
>>> > odd, because it doesn't match the existing misc_cg_try_charge() which
>>> > returns
>>> > whether the charge is successful or not.  sev_misc_cg_try_charge()
>>> > matches
>>> > misc_cg_try_charge() too.
>>> >
>>> > I think it's better to split "getting EPC cgroup" part out as a  
>>> separate
>>> > helper,
>>> > and make this _try_charge() match existing pattern:
>>> >
>>> > 	struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
>>> > 	{
>>> > 		if (sgx_epc_cgroup_disabled())
>>> > 			return NULL;
>>> > 	
>>> > 		return sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
>>> > 	}
>>> >
>>> > 	int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>>> > 	{
>>> > 		if (!epc_cg)
>>> > 			return -EINVAL;
>>> > 	
>>> > 		return misc_cg_try_charge(epc_cg->cg);
>>> > 	}
>>> >
>>> > Having sgx_get_current_epc_cg() also makes the caller easier to read,
>>> > because we
>>> > can immediately know we are going to charge the *current* EPC cgroup,
>>> > but not
>>> > some cgroup hidden within sgx_epc_cgroup_try_charge().
>>> >
>>>
>>> Actually, unlike other misc controllers, we need charge and get the  
>>> epc_cg
>>> reference at the same time.
>>
>> Can you elaborate?
>>
>> And in practice you always call sgx_epc_cgroup_try_charge() right after
>> sgx_get_current_epc_cg() anyway.  The only difference is the whole  
>> thing is done
>> in one function or in separate functions.
>>
>> [...]
>>
>
> That's true. I was thinking no need to have them done in separate calls.  
> The caller has to check the return value for epc_cg instance first, then  
> check result of try_charge. But there is really only one caller,  
> sgx_alloc_epc_page() below, so I don't have strong opinions now.
>
> With them separate, the checks will look like this:
> if (epc_cg = sgx_get_current_epc_cg()) // NULL means cgroup disabled,  
> should continue for allocation
> {
> 	if (ret =  sgx_epc_cgroup_try_charge())
> 		return ret
> }
> // continue...
>
> I can go either way.
>
>>
>>> > >  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>>> > >  {
>>> > >  	struct sgx_epc_page *page;
>>> > > +	struct sgx_epc_cgroup *epc_cg;
>>> > > +
>>> > > +	epc_cg = sgx_epc_cgroup_try_charge();
>>> > > +	if (IS_ERR(epc_cg))
>>> > > +		return ERR_CAST(epc_cg);
>>> > >
>>> > >  	for ( ; ; ) {
>>> > >  		page = __sgx_alloc_epc_page();
>>> > > @@ -580,10 +587,21 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
>>> > > *owner, bool reclaim)
>>> > >  			break;
>>> > >  		}
>>> > >
>>> > > +		/*
>>> > > +		 * Need to do a global reclamation if cgroup was not full but  
>>> free
>>> > > +		 * physical pages run out, causing __sgx_alloc_epc_page() to  
>>> fail.
>>> > > +		 */
>>> > >  		sgx_reclaim_pages();
>>> >
>>> > What's the final behaviour?  IIUC it should be reclaiming from the
>>> > *current* EPC
>>> > cgroup?  If so shouldn't we just pass the @epc_cg to it here?
>>> >
>>> > I think we can make this patch as "structure" patch w/o actually  
>>> having
>>> > EPC
>>> > cgroup enabled, i.e., sgx_get_current_epc_cg() always return NULL.
>>> >
>>> > And we can have one patch to change sgx_reclaim_pages() to take the
>>> > 'struct
>>> > sgx_epc_lru_list *' as argument:
>>> >
>>> > 	void sgx_reclaim_pages_lru(struct sgx_epc_lru_list * lru)
>>> > 	{
>>> > 		...
>>> > 	}
>>> >
>>> > Then here we can have something like:
>>> >
>>> > 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
>>> > 	{
>>> > 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :
>>> > &sgx_global_lru;
>>> >
>>> > 		sgx_reclaim_pages_lru(lru);
>>> > 	}
>>> >
>>> > Makes sense?
>>> >
>>>
>>> This is purely global reclamation. No cgroup involved.
>>
>> Again why?  Here you are allocating one EPC page for enclave in a  
>> particular EPC
>> cgroup.  When that fails, shouldn't you try only to reclaim from the  
>> *current*
>> EPC cgroup?  Or at least you should try to reclaim from the *current*  
>> EPC cgroup
>> first?
>>
>
> Later sgx_epc_cg_try_charge will take a 'reclaim' flag, if true, cgroup  
> reclaims synchronously, otherwise in background and returns -EBUSY in  
> that case. This function also returns if no valid epc_cg pointer  
> returned.
>
> All reclamation for *current* cgroup is done in sgx_epc_cg_try_charge().
>
> So, by reaching to this point,  a valid epc_cg pointer was returned,  
> that means allocation is allowed for the cgroup (it has reclaimed if  
> necessary, and its usage is not above limit after charging).
>
> But the system level free count may be low (e.g., limits of all cgroups  
> may add up to be more than capacity). so we need to do a global  
> reclamation here, which may involve reclaiming a few pages (from current  
> or other groups) so the system can be at a performant state with minimal  
> free count. (current behavior of ksgxd).
>
I should have sticked to the orignial comment added in code. Actually  
__sgx_alloc_epc_page() can fail if system runs out of EPC. That's the  
really reason for global reclaim. The free count enforcement is near the  
end of this method after should_reclaim() check.

Haitao

