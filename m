Return-Path: <cgroups+bounces-558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA867F939C
	for <lists+cgroups@lfdr.de>; Sun, 26 Nov 2023 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D593B20DD3
	for <lists+cgroups@lfdr.de>; Sun, 26 Nov 2023 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6BAD529;
	Sun, 26 Nov 2023 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKAJ0/3F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CD85;
	Sun, 26 Nov 2023 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701014550; x=1732550550;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=EReFqfVgYNOrty8zXOm3hVHtJMOHGEjFtGOu59g9hJg=;
  b=SKAJ0/3F+CrCzNEGakJcr98RMi5266kZfN89Dqwo9/ot/y09Ykw64534
   O4SWvxlvuN4RSl0Y7Qf9m65EKqNo9ZTFx9Bolqvtd58clyl88XWLC8fSm
   OG2i9Mgn3lTXShew+W/YMWPRDXLMJ48h5fIskJArzYNlPcs+BxxOKmBXr
   OFKl8Tlw0dk+kAMArFlX9OvWZAM+q9Pb2LVlLpTt7pGL2PiZv3snNdtzp
   Qmsu1HF3evK+l0AWnP10RBuhqBAoxjfNUyCOYd50s0ujqoL4zmz0RpIRV
   oj5MnyIvP3K7iOy3/xTJ06m0xu/TZ/bkTl+GeokXvkYW/uEgAbYBLDbEO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391445169"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="391445169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 08:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="16077213"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.112.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Nov 2023 08:02:02 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
 <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d9ad4bac3ac51fe2e8d14931054f681a8264622c.camel@intel.com>
Date: Mon, 27 Nov 2023 00:01:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2e0xhigjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d9ad4bac3ac51fe2e8d14931054f681a8264622c.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 20 Nov 2023 11:16:42 +0800, Huang, Kai <kai.huang@intel.com> wrote:

>> > >
>> >
>> > That's true. I was thinking no need to have them done in separate  
>> calls.
>> > The caller has to check the return value for epc_cg instance first,  
>> then
>> > check result of try_charge. But there is really only one caller,
>> > sgx_alloc_epc_page() below, so I don't have strong opinions now.
>> >
>> > With them separate, the checks will look like this:
>> > if (epc_cg = sgx_get_current_epc_cg()) // NULL means cgroup disabled,
>> > should continue for allocation
>> > {
>> > 	if (ret =  sgx_epc_cgroup_try_charge())
>> > 		return ret
>> > }
>> > // continue...
>> >
>> > I can go either way.
>
> Let's keep this aligned with other _try_charge() variants: return 'int'  
> to
> indicate whether the charge is done or not.
>

Fine with me if no objections from maintainers.

>> >
>> > >
>> > > > > >  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool  
>> reclaim)
>> > > > > >  {
>> > > > > >  	struct sgx_epc_page *page;
>> > > > > > +	struct sgx_epc_cgroup *epc_cg;
>> > > > > > +
>> > > > > > +	epc_cg = sgx_epc_cgroup_try_charge();
>> > > > > > +	if (IS_ERR(epc_cg))
>> > > > > > +		return ERR_CAST(epc_cg);
>> > > > > >
>> > > > > >  	for ( ; ; ) {
>> > > > > >  		page = __sgx_alloc_epc_page();
>> > > > > > @@ -580,10 +587,21 @@ struct sgx_epc_page  
>> *sgx_alloc_epc_page(void
>> > > > > > *owner, bool reclaim)
>> > > > > >  			break;
>> > > > > >  		}
>> > > > > >
>> > > > > > +		/*
>> > > > > > +		 * Need to do a global reclamation if cgroup was not full  
>> but
>> > > > free
>> > > > > > +		 * physical pages run out, causing __sgx_alloc_epc_page()  
>> to
>> > > > fail.
>> > > > > > +		 */
>> > > > > >  		sgx_reclaim_pages();
>> > > > >
>> > > > > What's the final behaviour?  IIUC it should be reclaiming from  
>> the
>> > > > > *current* EPC
>> > > > > cgroup?  If so shouldn't we just pass the @epc_cg to it here?
>> > > > >
>> > > > > I think we can make this patch as "structure" patch w/o actually
>> > > > having
>> > > > > EPC
>> > > > > cgroup enabled, i.e., sgx_get_current_epc_cg() always return  
>> NULL.
>> > > > >
>> > > > > And we can have one patch to change sgx_reclaim_pages() to take  
>> the
>> > > > > 'struct
>> > > > > sgx_epc_lru_list *' as argument:
>> > > > >
>> > > > > 	void sgx_reclaim_pages_lru(struct sgx_epc_lru_list * lru)
>> > > > > 	{
>> > > > > 		...
>> > > > > 	}
>> > > > >
>> > > > > Then here we can have something like:
>> > > > >
>> > > > > 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
>> > > > > 	{
>> > > > > 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :
>> > > > > &sgx_global_lru;
>> > > > >
>> > > > > 		sgx_reclaim_pages_lru(lru);
>> > > > > 	}
>> > > > >
>> > > > > Makes sense?
>> > > > >

The reason we 'isolate' first then do real 'reclaim' is that the actual  
reclaim is expensive and especially for eblock, etrack, etc.

>> > > >
>> > > > This is purely global reclamation. No cgroup involved.
>> > >
>> > > Again why?  Here you are allocating one EPC page for enclave in a
>> > > particular EPC
>> > > cgroup.  When that fails, shouldn't you try only to reclaim from the
>> > > *current*
>> > > EPC cgroup?  Or at least you should try to reclaim from the  
>> *current*
>> > > EPC cgroup
>> > > first?
>> > >
>> >
>> > Later sgx_epc_cg_try_charge will take a 'reclaim' flag, if true,  
>> cgroup
>> > reclaims synchronously, otherwise in background and returns -EBUSY in
>> > that case. This function also returns if no valid epc_cg pointer
>> > returned.
>> >
>> > All reclamation for *current* cgroup is done in  
>> sgx_epc_cg_try_charge().
>
> This is fine, but I believe my question above is about where to reclaim  
> when
> "allocation" fails,  but not "try charge" fails.
>
I mean "will be done" :-) Currently no reclaim in try_charge.

> And for "reclaim for current cgroup when charge fails", I don't think  
> its even
> necessary in this initial implementation of EPC cgroup.  You can just  
> fail the
> allocation when charge fails (reaching the limit).  Trying to reclaim  
> when limit
> is hit can be done later.
>

Yes. It is done later.

> Please see Dave and Michal's replies here:
>
> https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com/#t
> https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3/
>
>> >
>> > So, by reaching to this point,  a valid epc_cg pointer was returned,
>> > that means allocation is allowed for the cgroup (it has reclaimed if
>> > necessary, and its usage is not above limit after charging).
>
> I found memory cgroup uses different logic -- allocation first and then  
> charge:
>
> For instance:
>
> static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> {
> 	......
>
>         folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>         if (!folio)
>                 goto oom;
>        if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>                 goto oom_free_page;
> 	
> 	......    }
>
> Why EPC needs to "charge first" and "then allocate"?
>

EPC allocation can involve reclaiming which is more expensive than regular  
RAM reclamation. Also misc only has max hard limit.
Thanks
Haitao
>> >
>> > But the system level free count may be low (e.g., limits of all  
>> cgroups
>> > may add up to be more than capacity). so we need to do a global
>> > reclamation here, which may involve reclaiming a few pages (from  
>> current
>> > or other groups) so the system can be at a performant state with  
>> minimal
>> > free count. (current behavior of ksgxd).
>> >
>> I should have sticked to the orignial comment added in code. Actually
>> __sgx_alloc_epc_page() can fail if system runs out of EPC. That's the
>> really reason for global reclaim.
>
> I don't see how this can work.  With EPC cgroup likely all EPC pages  
> will go to
> the individual LRU of each cgroup, and the sgx_global_lru will basically  
> empty.
> How can you reclaim from the sgx_global_lru?

Currently, nothing in cgroup LRU, all EPCs pages are in global list.

