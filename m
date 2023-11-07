Return-Path: <cgroups+bounces-209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308647E328D
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C7D1C2083F
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DEE17C3;
	Tue,  7 Nov 2023 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSoiFFUv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED78184E
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 01:16:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10801BF;
	Mon,  6 Nov 2023 17:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699319796; x=1730855796;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=MDXh+A4zL9HW9l/AyyMH+wCbad2DITke0bugqK13VVk=;
  b=NSoiFFUvCAdml96wsN3aWb16whu4SwsK5kb6k9249dQMltZSVGyiLNmU
   TmZHG17933YkFT1HmBpXjZyMbmNcjHnAP28y5QuXYkNrsSszMzFuNXyJX
   BRwya3YJxEMp3d+UtzS1ZINPROkNtqTCfEldoh7zVEVa2QSqdMJJ+eY/j
   1kQRj06mGiVqbciZGjxHBEjDqiGQ6lzY3pgW7EGj3qd/4ycKZMigUaDh6
   yUFhKmLy9eWz58ijb/RLmDV4Jxz6yAVokn0q9dwdsCL7Lt4zEK6ngL101
   9gW+HC+p9xnDmfmTOMvytCdGPaFKrGxVrwfroDQmn4rlLgAlk22pKX3ga
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2402898"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2402898"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 17:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762495599"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762495599"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.50.175])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Nov 2023 17:16:31 -0800
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
 Kai" <kai.huang@intel.com>
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
Date: Mon, 06 Nov 2023 19:16:30 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 06 Nov 2023 16:18:30 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>>
>> > > +/**
>> > > + * sgx_epc_cgroup_try_charge() - hierarchically try to charge a  
>> single
>> > > EPC page
>> > > + *
>> > > + * Returns EPC cgroup or NULL on success, -errno on failure.
>> > > + */
>> > > +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
>> > > +{
>> > > +	struct sgx_epc_cgroup *epc_cg;
>> > > +	int ret;
>> > > +
>> > > +	if (sgx_epc_cgroup_disabled())
>> > > +		return NULL;
>> > > +
>> > > +	epc_cg = sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
>> > > +	ret = misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,  
>> PAGE_SIZE);
>> > > +
>> > > +	if (!ret) {
>> > > +		/* No epc_cg returned, release ref from get_current_misc_cg() */
>> > > +		put_misc_cg(epc_cg->cg);
>> > > +		return ERR_PTR(-ENOMEM);
>> >
>> > misc_cg_try_charge() returns 0 when successfully charged, no?
>>
>> Right. I really made some mess in rebasing :-(
>>
>> >
>> > > +	}
>> > > +
>> > > +	/* Ref released in sgx_epc_cgroup_uncharge() */
>> > > +	return epc_cg;
>> > > +}
>> >
>> > IMHO the above _try_charge() returning a pointer of EPC cgroup is a
>> > little bit
>> > odd, because it doesn't match the existing misc_cg_try_charge() which
>> > returns
>> > whether the charge is successful or not.  sev_misc_cg_try_charge()
>> > matches
>> > misc_cg_try_charge() too.
>> >
>> > I think it's better to split "getting EPC cgroup" part out as a  
>> separate
>> > helper,
>> > and make this _try_charge() match existing pattern:
>> >
>> > 	struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
>> > 	{
>> > 		if (sgx_epc_cgroup_disabled())
>> > 			return NULL;
>> > 	
>> > 		return sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
>> > 	}
>> >
>> > 	int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>> > 	{
>> > 		if (!epc_cg)
>> > 			return -EINVAL;
>> > 	
>> > 		return misc_cg_try_charge(epc_cg->cg);
>> > 	}
>> >
>> > Having sgx_get_current_epc_cg() also makes the caller easier to read,
>> > because we
>> > can immediately know we are going to charge the *current* EPC cgroup,
>> > but not
>> > some cgroup hidden within sgx_epc_cgroup_try_charge().
>> >
>>
>> Actually, unlike other misc controllers, we need charge and get the  
>> epc_cg
>> reference at the same time.
>
> Can you elaborate?
>
> And in practice you always call sgx_epc_cgroup_try_charge() right after
> sgx_get_current_epc_cg() anyway.  The only difference is the whole thing  
> is done
> in one function or in separate functions.
>
> [...]
>

That's true. I was thinking no need to have them done in separate calls.  
The caller has to check the return value for epc_cg instance first, then  
check result of try_charge. But there is really only one caller,  
sgx_alloc_epc_page() below, so I don't have strong opinions now.

With them separate, the checks will look like this:
if (epc_cg = sgx_get_current_epc_cg()) // NULL means cgroup disabled,  
should continue for allocation
{
	if (ret =  sgx_epc_cgroup_try_charge())
		return ret
}
// continue...

I can go either way.

>
>> > >  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>> > >  {
>> > >  	struct sgx_epc_page *page;
>> > > +	struct sgx_epc_cgroup *epc_cg;
>> > > +
>> > > +	epc_cg = sgx_epc_cgroup_try_charge();
>> > > +	if (IS_ERR(epc_cg))
>> > > +		return ERR_CAST(epc_cg);
>> > >
>> > >  	for ( ; ; ) {
>> > >  		page = __sgx_alloc_epc_page();
>> > > @@ -580,10 +587,21 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
>> > > *owner, bool reclaim)
>> > >  			break;
>> > >  		}
>> > >
>> > > +		/*
>> > > +		 * Need to do a global reclamation if cgroup was not full but  
>> free
>> > > +		 * physical pages run out, causing __sgx_alloc_epc_page() to  
>> fail.
>> > > +		 */
>> > >  		sgx_reclaim_pages();
>> >
>> > What's the final behaviour?  IIUC it should be reclaiming from the
>> > *current* EPC
>> > cgroup?  If so shouldn't we just pass the @epc_cg to it here?
>> >
>> > I think we can make this patch as "structure" patch w/o actually  
>> having
>> > EPC
>> > cgroup enabled, i.e., sgx_get_current_epc_cg() always return NULL.
>> >
>> > And we can have one patch to change sgx_reclaim_pages() to take the
>> > 'struct
>> > sgx_epc_lru_list *' as argument:
>> >
>> > 	void sgx_reclaim_pages_lru(struct sgx_epc_lru_list * lru)
>> > 	{
>> > 		...
>> > 	}
>> >
>> > Then here we can have something like:
>> >
>> > 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
>> > 	{
>> > 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :
>> > &sgx_global_lru;
>> >
>> > 		sgx_reclaim_pages_lru(lru);
>> > 	}
>> >
>> > Makes sense?
>> >
>>
>> This is purely global reclamation. No cgroup involved.
>
> Again why?  Here you are allocating one EPC page for enclave in a  
> particular EPC
> cgroup.  When that fails, shouldn't you try only to reclaim from the  
> *current*
> EPC cgroup?  Or at least you should try to reclaim from the *current*  
> EPC cgroup
> first?
>

Later sgx_epc_cg_try_charge will take a 'reclaim' flag, if true, cgroup  
reclaims synchronously, otherwise in background and returns -EBUSY in that  
case. This function also returns if no valid epc_cg pointer returned.

All reclamation for *current* cgroup is done in sgx_epc_cg_try_charge().

So, by reaching to this point,  a valid epc_cg pointer was returned, that  
means allocation is allowed for the cgroup (it has reclaimed if necessary,  
and its usage is not above limit after charging).

But the system level free count may be low (e.g., limits of all cgroups  
may add up to be more than capacity). so we need to do a global  
reclamation here, which may involve reclaiming a few pages (from current  
or other groups) so the system can be at a performant state with minimal  
free count. (current behavior of ksgxd).

Note this patch does not do per-cgroup reclamation. If we had stopped with  
this patch without next patches, cgroups will only block allocation by  
returning invalid epc_cg pointer (-ENOMEM) from sgx_epc_cg_try_charge().  
Reclamation only happens when cgroup is not full but system level free  
count is below threshold.

>> You can see it
>> later in changes in patch 10/12. For now I just make a comment there but
>> no real changes. Cgroup reclamation will be done as part of _try_charge
>> call.
>>
>> > >  		cond_resched();
>> > >  	}
>> > >
>> > > +	if (!IS_ERR(page)) {
>> > > +		WARN_ON_ONCE(page->epc_cg);
>> > > +		page->epc_cg = epc_cg;
>> > > +	} else {
>> > > +		sgx_epc_cgroup_uncharge(epc_cg);
>> > > +	}
>> > > +
>> > >  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> > >  		wake_up(&ksgxd_waitq);
>> > >
>> > > @@ -604,6 +622,11 @@ void sgx_free_epc_page(struct sgx_epc_page  
>> *page)
>> > >  	struct sgx_epc_section *section =  
>> &sgx_epc_sections[page->section];
>> > >  	struct sgx_numa_node *node = section->node;
>> > >
>> > > +	if (page->epc_cg) {
>> > > +		sgx_epc_cgroup_uncharge(page->epc_cg);
>> > > +		page->epc_cg = NULL;
>> > > +	}
>> > > +
>> > >  	spin_lock(&node->lock);
>> > >
>> > >  	page->owner = NULL;
>> > > @@ -643,6 +666,7 @@ static bool __init sgx_setup_epc_section(u64
>> > > phys_addr, u64 size,
>> > >  		section->pages[i].flags = 0;
>> > >  		section->pages[i].owner = NULL;
>> > >  		section->pages[i].poison = 0;
>> > > +		section->pages[i].epc_cg = NULL;
>> > >  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>> > >  	}
>> > >
>> > > @@ -787,6 +811,7 @@ static void __init  
>> arch_update_sysfs_visibility(int
>> > > nid) {}
>> > >  static bool __init sgx_page_cache_init(void)
>> > >  {
>> > >  	u32 eax, ebx, ecx, edx, type;
>> > > +	u64 capacity = 0;
>> > >  	u64 pa, size;
>> > >  	int nid;
>> > >  	int i;
>> > > @@ -837,6 +862,7 @@ static bool __init sgx_page_cache_init(void)
>> > >
>> > >  		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
>> > >  		sgx_numa_nodes[nid].size += size;
>> > > +		capacity += size;
>> > >
>> > >  		sgx_nr_epc_sections++;
>> > >  	}
>> > > @@ -846,6 +872,8 @@ static bool __init sgx_page_cache_init(void)
>> > >  		return false;
>> > >  	}
>> > >
>> > > +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
>
> Hmm.. I think this is why MISC_CG_RES_SGX_EPC is needed when
> !CONFIG_CGROUP_SGX_EPC.

right, that was it :-)

>
>> > > +
>> > >  	return true;
>> > >  }
>> >
>> > I would separate setting up capacity as a separate patch.
>>
>> I thought about that, but again it was only 3-4 lines all in this  
>> function
>> and it's also necessary part of basic setup for misc controller...
>
> Fine.  Anyway it depends on what things you want to do on this patch.  
> It's fine
> to include the capacity if this patch is some "structure" patch that  
> shows the
> high level flow of how EPC cgroup works.

Ok, I'll keep this way for now unless any objections.

Thanks
Haitao

