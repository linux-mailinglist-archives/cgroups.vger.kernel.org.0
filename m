Return-Path: <cgroups+bounces-193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1C7E2C8A
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FB028163E
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E328E26;
	Mon,  6 Nov 2023 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDFx6a66"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59FDDBB
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 19:00:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F77A2;
	Mon,  6 Nov 2023 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699297199; x=1730833199;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=fMypXWW57+wS4eTIiTkq2O5mctUODXUoOkqQrceHLH8=;
  b=SDFx6a66rAOrQTVwSmmJ6PgLj5jGqQNjWWU8m7Mk3iZ4Pz3wHB/ZLPlv
   3wEhDKM2NDn/HA6958Q/Yo1CmDds3bKR+ADrAK2G+9OgP1I2ByNCfcCE+
   dk7fpGBoNYMBivAUzsaoEfP7GAH45GXrT6UOoK9OkeX1TUFNoD/P21ci8
   A3DlEjJRbCMhrzDOykzEsYiBvZNLFo/c4YooemnOUzMlHcLxuXB2KWfNC
   LoCSMTuMC4k6aq18xLYyd6NBeN2k4m7fcJRVcvIVrFca5BOAqLclx98hj
   RkVx1yIua956I9ukQ5fsQWyxbkfmvd5cw427Zcs4lmXxaWFIOV4s8azBx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="7980508"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="7980508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="832813815"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="832813815"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.50.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Nov 2023 10:59:54 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "linux-sgx@vger.kernel.org"
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
 "Christopherson,, Sean" <seanjc@google.com>, "Zhang, Bo"
 <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
Date: Mon, 06 Nov 2023 12:59:55 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 06 Nov 2023 06:09:45 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-10-30 at 11:20 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Implement support for cgroup control of SGX Enclave Page Cache (EPC)
>> memory using the misc cgroup controller. EPC memory is independent
>> from normal system memory, e.g. must be reserved at boot from RAM and
>> cannot be converted between EPC and normal memory while the system is
>> running. EPC is managed by the SGX subsystem and is not accounted by
>> the memory controller.
>>
>> Much like normal system memory, EPC memory can be overcommitted via
>> virtual memory techniques and pages can be swapped out of the EPC to
>> their backing store (normal system memory, e.g. shmem).  The SGX EPC
>> subsystem is analogous to the memory subsystem and the SGX EPC  
>> controller
>> is in turn analogous to the memory controller; it implements limit and
>> protection models for EPC memory.
>
> Nit:
>
> The above two paragraphs talk about what is EPC and EPC resource control  
> needs
> to be done separately, etc, but IMHO it lacks some background about  
> "why" EPC
> resource control is needed, e.g, from use case's perspective.
>
>>
>> The misc controller provides a mechanism to set a hard limit of EPC
>> usage via the "sgx_epc" resource in "misc.max". The total EPC memory
>> available on the system is reported via the "sgx_epc" resource in
>> "misc.capacity".
>
> Please separate what the current misc cgroup provides, and how this  
> patch is
> going to utilize.
>
> Please describe the changes in imperative mood. E.g, "report total EPC  
> memory
> via ...", instead of "... is reported via ...".
>

Will update

>>
>> This patch was modified from the previous version to only add basic EPC
>> cgroup structure, accounting allocations for cgroup usage
>> (charge/uncharge), setup misc cgroup callbacks, set total EPC capacity.
>
> This isn't changelog material.  Please focus on describing the high  
> level design
> and why you chose such design.
>
>>
>> For now, the EPC cgroup simply blocks additional EPC allocation in
>> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
>> still tracked in the global active list, only reclaimed by the global
>> reclaimer when the total free page count is lower than a threshold.
>>
>> Later patches will reorganize the tracking and reclamation code in the
>> globale reclaimer and implement per-cgroup tracking and reclaiming.
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V6:
>> - Split the original large patch"Limit process EPC usage with misc
>> cgroup controller"  and restructure it (Kai)
>> ---
>>  arch/x86/Kconfig                     |  13 ++++
>>  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 103 +++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  36 ++++++++++
>>  arch/x86/kernel/cpu/sgx/main.c       |  28 ++++++++
>>  arch/x86/kernel/cpu/sgx/sgx.h        |   3 +
>>  6 files changed, 184 insertions(+)
>>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 66bfabae8814..e17c5dc3aea4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1921,6 +1921,19 @@ config X86_SGX
>>
>>  	  If unsure, say N.
>>
>> +config CGROUP_SGX_EPC
>> +	bool "Miscellaneous Cgroup Controller for Enclave Page Cache (EPC)  
>> for Intel SGX"
>> +	depends on X86_SGX && CGROUP_MISC
>> +	help
>> +	  Provides control over the EPC footprint of tasks in a cgroup via
>> +	  the Miscellaneous cgroup controller.
>> +
>> +	  EPC is a subset of regular memory that is usable only by SGX
>> +	  enclaves and is very limited in quantity, e.g. less than 1%
>> +	  of total DRAM.
>> +
>> +	  Say N if unsure.
>> +
>>  config X86_USER_SHADOW_STACK
>>  	bool "X86 userspace shadow stack"
>>  	depends on AS_WRUSS
>> diff --git a/arch/x86/kernel/cpu/sgx/Makefile  
>> b/arch/x86/kernel/cpu/sgx/Makefile
>> index 9c1656779b2a..12901a488da7 100644
>> --- a/arch/x86/kernel/cpu/sgx/Makefile
>> +++ b/arch/x86/kernel/cpu/sgx/Makefile
>> @@ -4,3 +4,4 @@ obj-y += \
>>  	ioctl.o \
>>  	main.o
>>  obj-$(CONFIG_X86_SGX_KVM)	+= virt.o
>> +obj-$(CONFIG_CGROUP_SGX_EPC)	       += epc_cgroup.o
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> new file mode 100644
>> index 000000000000..500627d0563f
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -0,0 +1,103 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright(c) 2022 Intel Corporation.
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/kernel.h>
>> +#include "epc_cgroup.h"
>> +
>> +static inline struct sgx_epc_cgroup  
>> *sgx_epc_cgroup_from_misc_cg(struct misc_cg *cg)
>> +{
>> +	return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
>> +}
>> +
>> +static inline bool sgx_epc_cgroup_disabled(void)
>> +{
>> +	return !cgroup_subsys_enabled(misc_cgrp_subsys);
>
> From below, the root EPC cgroup is dynamically allocated.  Shouldn't it  
> also
> check whether the root EPC cgroup is valid?
>

Good point. I think I'll go with the static instance approach below.

>> +}
>> +
>> +/**
>> + * sgx_epc_cgroup_try_charge() - hierarchically try to charge a single  
>> EPC page
>> + *
>> + * Returns EPC cgroup or NULL on success, -errno on failure.
>> + */
>> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
>> +{
>> +	struct sgx_epc_cgroup *epc_cg;
>> +	int ret;
>> +
>> +	if (sgx_epc_cgroup_disabled())
>> +		return NULL;
>> +
>> +	epc_cg = sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
>> +	ret = misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
>> +
>> +	if (!ret) {
>> +		/* No epc_cg returned, release ref from get_current_misc_cg() */
>> +		put_misc_cg(epc_cg->cg);
>> +		return ERR_PTR(-ENOMEM);
>
> misc_cg_try_charge() returns 0 when successfully charged, no?

Right. I really made some mess in rebasing :-(

>
>> +	}
>> +
>> +	/* Ref released in sgx_epc_cgroup_uncharge() */
>> +	return epc_cg;
>> +}
>
> IMHO the above _try_charge() returning a pointer of EPC cgroup is a  
> little bit
> odd, because it doesn't match the existing misc_cg_try_charge() which  
> returns
> whether the charge is successful or not.  sev_misc_cg_try_charge()  
> matches
> misc_cg_try_charge() too.
>
> I think it's better to split "getting EPC cgroup" part out as a separate  
> helper,
> and make this _try_charge() match existing pattern:
>
> 	struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
> 	{
> 		if (sgx_epc_cgroup_disabled())
> 			return NULL;
> 	
> 		return sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
> 	}
>
> 	int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> 	{
> 		if (!epc_cg)
> 			return -EINVAL;
> 	
> 		return misc_cg_try_charge(epc_cg->cg);
> 	}
>
> Having sgx_get_current_epc_cg() also makes the caller easier to read,  
> because we
> can immediately know we are going to charge the *current* EPC cgroup,  
> but not
> some cgroup hidden within sgx_epc_cgroup_try_charge().
>

Actually, unlike other misc controllers, we need charge and get the epc_cg  
reference at the same time. That's why it was returning the pointer. How  
about rename them sgx_{charge_and_get, uncharge_and_put}_epc_cg()? In  
final version, there is a __sgx_epc_cgroup_try_charge() that wraps  
misc_cg_try_charge().

>> +
>> +/**
>> + * sgx_epc_cgroup_uncharge() - hierarchically uncharge EPC pages
>> + * @epc_cg:	the charged epc cgroup
>> + */
>> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
>> +{
>> +	if (sgx_epc_cgroup_disabled())
>> +		return;
>
> If with above change, check !epc_cg instead.
>
>> +
>> +	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
>> +
>> +	/* Ref got from sgx_epc_cgroup_try_charge() */
>> +	put_misc_cg(epc_cg->cg);
>> +}
>> 	
>> +
>> +static void sgx_epc_cgroup_free(struct misc_cg *cg)
>> +{
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
>> +	if (!epc_cg)
>> +		return;
>> +
>> +	kfree(epc_cg);
>> +}
>> +
>> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
>> +
>> +const struct misc_operations_struct sgx_epc_cgroup_ops = {
>> +	.alloc = sgx_epc_cgroup_alloc,
>> +	.free = sgx_epc_cgroup_free,
>> +};
>> +
>> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
>> +{
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg = kzalloc(sizeof(*epc_cg), GFP_KERNEL);
>> +	if (!epc_cg)
>> +		return -ENOMEM;
>> +
>> +	cg->res[MISC_CG_RES_SGX_EPC].misc_ops = &sgx_epc_cgroup_ops;
>> +	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
>> +	epc_cg->cg = cg;
>> +	return 0;
>> +}
>> +
>> +static int __init sgx_epc_cgroup_init(void)
>> +{
>> +	struct misc_cg *cg;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_SGX))
>> +		return 0;
>> +
>> +	cg = misc_cg_root();
>> +	BUG_ON(!cg);
>
> BUG_ON() will catch some eyeball, but it cannot be NULL in practice IIUC.
>
> I am not sure whether you can just make misc @root_cg visible (instead  
> of having
> the misc_cg_root() helper) and directly use @root_cg here to avoid using  
> the
> BUG().  No opinion here.
>
I can remove BUG_ON(). It should never happen anyways.

>> +
>> +	return sgx_epc_cgroup_alloc(cg);
>
> As mentioned above the memory allocation can fail, in which case EPC  
> cgroup is
> effectively disabled IIUC?
>
> One way is to manually check whether root EPC cgroup is valid in
> sgx_epc_cgroup_disabled().  Alternatively, you can have a static root  
> EPC cgroup
> here:
>
> 	static struct sgx_epc_cgroup root_epc_cg;
>
> In this way you can have a sgx_epc_cgroup_init(&epc_cg), and call it from
> sgx_epc_cgroup_alloc().
>

Yeah, I think that is reasonable.

>> +}
>> +subsys_initcall(sgx_epc_cgroup_init);
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> new file mode 100644
>> index 000000000000..c3abfe82be15
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2022 Intel Corporation. */
>> +#ifndef _INTEL_SGX_EPC_CGROUP_H_
>> +#define _INTEL_SGX_EPC_CGROUP_H_
>> +
>> +#include <asm/sgx.h>
>> +#include <linux/cgroup.h>
>> +#include <linux/list.h>
>> +#include <linux/misc_cgroup.h>
>> +#include <linux/page_counter.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "sgx.h"
>> +
>> +#ifndef CONFIG_CGROUP_SGX_EPC
>> +#define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
>
> Do you need this macro?

I remember I got some compiling error without it but I don't see why it  
should be needed. I'll double check next round. thanks.

>
>> +struct sgx_epc_cgroup;
>> +
>> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup  
>> *epc_cg) { }
>> +#else
>> +struct sgx_epc_cgroup {
>> +	struct misc_cg *cg;
>> +};
>> +
>> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void);
>> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
>> +bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
>
> Why do you need sgx_epc_cgroup_lru_empty() here?
>

leftover from rebasing. Will remove.

>> +
>> +#endif
>> +
>> +#endif /* _INTEL_SGX_EPC_CGROUP_H_ */
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index 166692f2d501..07606f391540 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/highmem.h>
>>  #include <linux/kthread.h>
>>  #include <linux/miscdevice.h>
>> +#include <linux/misc_cgroup.h>
>>  #include <linux/node.h>
>>  #include <linux/pagemap.h>
>>  #include <linux/ratelimit.h>
>> @@ -17,6 +18,7 @@
>>  #include "driver.h"
>>  #include "encl.h"
>>  #include "encls.h"
>> +#include "epc_cgroup.h"
>>
>>  struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
>>  static int sgx_nr_epc_sections;
>> @@ -559,6 +561,11 @@ int sgx_unmark_page_reclaimable(struct  
>> sgx_epc_page *page)
>>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>>  {
>>  	struct sgx_epc_page *page;
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg = sgx_epc_cgroup_try_charge();
>> +	if (IS_ERR(epc_cg))
>> +		return ERR_CAST(epc_cg);
>>
>>  	for ( ; ; ) {
>>  		page = __sgx_alloc_epc_page();
>> @@ -580,10 +587,21 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, bool reclaim)
>>  			break;
>>  		}
>>
>> +		/*
>> +		 * Need to do a global reclamation if cgroup was not full but free
>> +		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
>> +		 */
>>  		sgx_reclaim_pages();
>
> What's the final behaviour?  IIUC it should be reclaiming from the  
> *current* EPC
> cgroup?  If so shouldn't we just pass the @epc_cg to it here?
>
> I think we can make this patch as "structure" patch w/o actually having  
> EPC
> cgroup enabled, i.e., sgx_get_current_epc_cg() always return NULL.
>
> And we can have one patch to change sgx_reclaim_pages() to take the  
> 'struct
> sgx_epc_lru_list *' as argument:
>
> 	void sgx_reclaim_pages_lru(struct sgx_epc_lru_list * lru)
> 	{
> 		...
> 	}
>
> Then here we can have something like:
>
> 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
> 	{
> 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :  
> &sgx_global_lru;
>
> 		sgx_reclaim_pages_lru(lru);
> 	}
>
> Makes sense?
>

This is purely global reclamation. No cgroup involved. You can see it  
later in changes in patch 10/12. For now I just make a comment there but  
no real changes. Cgroup reclamation will be done as part of _try_charge  
call.

>>  		cond_resched();
>>  	}
>>
>> +	if (!IS_ERR(page)) {
>> +		WARN_ON_ONCE(page->epc_cg);
>> +		page->epc_cg = epc_cg;
>> +	} else {
>> +		sgx_epc_cgroup_uncharge(epc_cg);
>> +	}
>> +
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>  		wake_up(&ksgxd_waitq);
>>
>> @@ -604,6 +622,11 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>>  	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
>>  	struct sgx_numa_node *node = section->node;
>>
>> +	if (page->epc_cg) {
>> +		sgx_epc_cgroup_uncharge(page->epc_cg);
>> +		page->epc_cg = NULL;
>> +	}
>> +
>>  	spin_lock(&node->lock);
>>
>>  	page->owner = NULL;
>> @@ -643,6 +666,7 @@ static bool __init sgx_setup_epc_section(u64  
>> phys_addr, u64 size,
>>  		section->pages[i].flags = 0;
>>  		section->pages[i].owner = NULL;
>>  		section->pages[i].poison = 0;
>> +		section->pages[i].epc_cg = NULL;
>>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>>  	}
>>
>> @@ -787,6 +811,7 @@ static void __init arch_update_sysfs_visibility(int  
>> nid) {}
>>  static bool __init sgx_page_cache_init(void)
>>  {
>>  	u32 eax, ebx, ecx, edx, type;
>> +	u64 capacity = 0;
>>  	u64 pa, size;
>>  	int nid;
>>  	int i;
>> @@ -837,6 +862,7 @@ static bool __init sgx_page_cache_init(void)
>>
>>  		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
>>  		sgx_numa_nodes[nid].size += size;
>> +		capacity += size;
>>
>>  		sgx_nr_epc_sections++;
>>  	}
>> @@ -846,6 +872,8 @@ static bool __init sgx_page_cache_init(void)
>>  		return false;
>>  	}
>>
>> +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
>> +
>>  	return true;
>>  }
>
> I would separate setting up capacity as a separate patch.

I thought about that, but again it was only 3-4 lines all in this function  
and it's also necessary part of basic setup for misc controller...

>
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h  
>> b/arch/x86/kernel/cpu/sgx/sgx.h
>> index d2dad21259a8..b1786774b8d2 100644
>> --- a/arch/x86/kernel/cpu/sgx/sgx.h
>> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
>> @@ -29,12 +29,15 @@
>>  /* Pages on free list */
>>  #define SGX_EPC_PAGE_IS_FREE		BIT(1)
>>
>> +struct sgx_epc_cgroup;
>> +
>>  struct sgx_epc_page {
>>  	unsigned int section;
>>  	u16 flags;
>>  	u16 poison;
>>  	struct sgx_encl_page *owner;
>>  	struct list_head list;
>> +	struct sgx_epc_cgroup *epc_cg;
>>  };
>>
>
> Adding @epc_cg unconditionally means even with !CONFIG_CGROUP_SGX_EPC  
> the memory
> is still occupied.  IMHO that would bring non-trivial memory waste as  
> it's 8-
> bytes for each EPC page.
>

Ok, I'll add ifdef

