Return-Path: <cgroups+bounces-2328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00108992C9
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 03:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F63A1C212C9
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C779E3;
	Fri,  5 Apr 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZoun0fb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688377484;
	Fri,  5 Apr 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280250; cv=none; b=HzJLi26Wm3FYExf0logFNP9YfAUMkI3J80h9bYa1mB4jEx5b+YFPokSYwt8XpliMvU+zgqSyiSoPjDi9Im+BDdG2axaftX9xj/wVV/sxI9nIAQgBHlu0YtxE6CTS/Ug9UbWT37AP0IWpXmhIE0ltDFnP1bO9Tx2AF04txFAaRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280250; c=relaxed/simple;
	bh=YPKRHv6WFnAfzv/nKxhMpe/XbVnWjOcVceGiSzSnzE0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=ItBKDK22sKNsBj/zN2f82gXmOQdwe4LWgF30BdXkDoEuBcp7chnFemxeK67HUkGe34PRN9PiOx/Npoi10bSmzIoqZTiXS/Vw94UEy06wj68Pbz5Wld+lsIJQEnOXPFHtRj4uq61kcAB1aNGE1S4BBryZYrjA+LHqt46TSU5eDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZoun0fb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712280248; x=1743816248;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=YPKRHv6WFnAfzv/nKxhMpe/XbVnWjOcVceGiSzSnzE0=;
  b=HZoun0fby8ankw/6XPWx0MybN/Ubg4LFPkhZWVZYrsddCSaJKwZRXeVk
   QX9BZdrWAmPJ5+5RbZPXlK0JAGtHerbR3ak3a+o+kHOq9Keq0muylKKkf
   lONEhpGqip0N92l5uXKSIoCTg3JJI/EHHJT+0YPWMtbZxRgaBD1Ads15V
   2rSfgjcIsfhiltc+Fw3xaGfHzmKBlniZh7t5y1Jv0I5V42yBRbUKy3pRE
   nbETb2+yUzwNz1Co+Ckb/88MPM3nSPJuupcEzgoqLVuDNm/juj9YZeQ9s
   RyKDO0PFH6DvUta7B4x7lk3s8UVfMnDre1p6MoEtHhRQzdLMcme0iZ58D
   A==;
X-CSE-ConnectionGUID: sl88ShJ2Qka4iE77FH9CUg==
X-CSE-MsgGUID: wGjXPDU3T5iwTBAx3XJCVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11375075"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="11375075"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 18:24:07 -0700
X-CSE-ConnectionGUID: MiigtBY5QreKPX0qKPq2PQ==
X-CSE-MsgGUID: /fQN0YYRRzCf1PIV6CE0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="42163949"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 04 Apr 2024 18:24:05 -0700
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
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-6-haitao.huang@linux.intel.com>
 <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
Date: Thu, 04 Apr 2024 20:24:04 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lqd6eavwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 28 Mar 2024 07:53:45 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright(c) 2022 Intel Corporation.
>
> It's 2024 now.
>
> And looks you need to use C style comment for /* Copyright ... */, after  
> looking
> at some other C files.
>
Ok, will update years and use C style.

>> +
>> +#include <linux/atomic.h>
>> +#include <linux/kernel.h>
>> +#include "epc_cgroup.h"
>> +
>> +/* The root SGX EPC cgroup */
>> +static struct sgx_cgroup sgx_cg_root;
>> +
>> +/**
>> + * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
>> + *
>> + * @sgx_cg:	The EPC cgroup to be charged for the page.
>> + * Return:
>> + * * %0 - If successfully charged.
>> + * * -errno - for failures.
>> + */
>> +int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +{
>> +	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
>> +}
>> +
>> +/**
>> + * sgx_cgroup_uncharge() - uncharge a cgroup for an EPC page
>> + * @sgx_cg:	The charged sgx cgroup
>> + */
>> +void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg)
>> +{
>> +	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
>> +}
>> +
>> +static void sgx_cgroup_free(struct misc_cg *cg)
>> +{
>> +	struct sgx_cgroup *sgx_cg;
>> +
>> +	sgx_cg = sgx_cgroup_from_misc_cg(cg);
>> +	if (!sgx_cg)
>> +		return;
>> +
>> +	kfree(sgx_cg);
>> +}
>> +
>> +static int sgx_cgroup_alloc(struct misc_cg *cg);
>
> Again, this declaration can be removed if you move the below structure  
> ...
>
>> +
>> +const struct misc_res_ops sgx_cgroup_ops = {
>> +	.alloc = sgx_cgroup_alloc,
>> +	.free = sgx_cgroup_free,
>> +};
>> +
>> +static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup  
>> *sgx_cg)
>> +{
>> +	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
>> +	sgx_cg->cg = cg;
>> +}
>> +
>> +static int sgx_cgroup_alloc(struct misc_cg *cg)
>> +{
>> +	struct sgx_cgroup *sgx_cg;
>> +
>> +	sgx_cg = kzalloc(sizeof(*sgx_cg), GFP_KERNEL);
>> +	if (!sgx_cg)
>> +		return -ENOMEM;
>> +
>> +	sgx_cgroup_misc_init(cg, sgx_cg);
>> +
>> +	return 0;
>> +}
>
> ... here.
>

yes, thanks

>> +
>> +void sgx_cgroup_init(void)
>> +{
>> +	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
>> +	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
>> +}
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> new file mode 100644
>> index 000000000000..8f794e23fad6
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -0,0 +1,70 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2022 Intel Corporation. */
>> +#ifndef _SGX_EPC_CGROUP_H_
>> +#define _SGX_EPC_CGROUP_H_
>> +
>> +#include <asm/sgx.h>
>> +#include <linux/cgroup.h>
>> +#include <linux/misc_cgroup.h>
>> +
>> +#include "sgx.h"
>> +
>> +#ifndef CONFIG_CGROUP_SGX_EPC
>
> Nit: add an empty line to make text more breathable.
>

ok

>> +#define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
>> +struct sgx_cgroup;
>> +
>> +static inline struct sgx_cgroup *sgx_get_current_cg(void)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
>> +
>> +static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
>> +
>> +static inline void sgx_cgroup_init(void) { }
>> +#else
>
> Nit: I prefer two empty lines before and after the 'else'.
>

ok

>> +struct sgx_cgroup {
>> +	struct misc_cg *cg;
>> +};
>> +
>> +static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct  
>> misc_cg *cg)
>> +{
>> +	return (struct sgx_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
>> +}
>> +
>> +/**
>> + * sgx_get_current_cg() - get the EPC cgroup of current process.
>> + *
>> + * Returned cgroup has its ref count increased by 1. Caller must call
>> + * sgx_put_cg() to return the reference.
>> + *
>> + * Return: EPC cgroup to which the current task belongs to.
>> + */
>> +static inline struct sgx_cgroup *sgx_get_current_cg(void)
>> +{
>> +	return sgx_cgroup_from_misc_cg(get_current_misc_cg());
>> +}
>
> Again, I _think_ you need to check whether get_current_misc_cg() returns  
> NULL?
>
> Misc cgroup can be disabled by command line even it is on in the Kconfig.
>
> I am not expert on cgroup, so could you check on this?
>

Good catch. Will add NULL check in sgx_cgroup_from_misc_cg()

>> +
>> +/**
>> + * sgx_put_sgx_cg() - Put the EPC cgroup and reduce its ref count.
>> + * @sgx_cg - EPC cgroup to put.
>> + */
>> +static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
>> +{
>> +	if (sgx_cg)
>> +		put_misc_cg(sgx_cg->cg);
>> +}
>> +
>> +int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg);
>> +void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
>> +void sgx_cgroup_init(void);
>> +
>> +#endif
>> +
>> +#endif /* _SGX_EPC_CGROUP_H_ */
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index d219f14365d4..023af54c1beb 100644
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
>> @@ -558,7 +560,16 @@ int sgx_unmark_page_reclaimable(struct  
>> sgx_epc_page *page)
>>   */
>>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim  
>> reclaim)
>>  {
>> +	struct sgx_cgroup *sgx_cg;
>>  	struct sgx_epc_page *page;
>> +	int ret;
>> +
>> +	sgx_cg = sgx_get_current_cg();
>> +	ret = sgx_cgroup_try_charge(sgx_cg);
>> +	if (ret) {
>> +		sgx_put_cg(sgx_cg);
>> +		return ERR_PTR(ret);
>> +	}
>>
>>  	for ( ; ; ) {
>>  		page = __sgx_alloc_epc_page();
>> @@ -567,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, enum sgx_reclaim reclaim)
>>  			break;
>>  		}
>>
>> -		if (list_empty(&sgx_active_page_list))
>> -			return ERR_PTR(-ENOMEM);
>> +		if (list_empty(&sgx_active_page_list)) {
>> +			page = ERR_PTR(-ENOMEM);
>> +			break;
>> +		}
>>
>>  		if (reclaim == SGX_NO_RECLAIM) {
>>  			page = ERR_PTR(-EBUSY);
>> @@ -580,10 +593,24 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, enum sgx_reclaim reclaim)
>>  			break;
>>  		}
>>
>> +		/*
>> +		 * Need to do a global reclamation if cgroup was not full but free
>> +		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
>> +		 */
>
> Again, to me this comment shouldn't be here, because it doesn't add any  
> more
> information.
>
> If you can reach here, you have passed the charge().  In fact, I believe  
> this
> doesn't matter:
> When you fail to allocate, you just need to reclaim.
>
> Now you only have the global reclamation, thus you need to reclaim from  
> it.
>
> Perhaps it is useful when you have per-cgroup LRU list.  In that case  
> you can
> put this comment there.
>

Ok

>>  		sgx_reclaim_pages();
>>  		cond_resched();
>>  	}
>>
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	if (!IS_ERR(page)) {
>> +		WARN_ON_ONCE(page->sgx_cg);
>> +		/* sgx_put_cg() in sgx_free_epc_page() */
>> +		page->sgx_cg = sgx_cg;
>> +	} else {
>> +		sgx_cgroup_uncharge(sgx_cg);
>> +		sgx_put_cg(sgx_cg);
>> +	}
>> +#endif
>
> Again, IMHO having CONFIG_CGROUP_SGX_EPC here is ugly, because it  
> doesn't even
> match the try_charge() above, which doesn't have the  
> CONFIG_CGROUP_SGX_EPC.
>
> If you add a wrapper in "epc_cgroup.h"
>
Agree. but in sgx.h so sgx_epc_page struct is not exposed in epc_cgroup.h.

> static inline void sgx_epc_page_set_cgroup(struct epc_page *epc_page, 
> 					   struct sgx_cgroup *sgx_cg)
> {
> #ifdef CONFIG_CGROUP_SGX_EPC
> 	epc_page->sgx_cg = sgx_cg;
> #endif		
> }
>
> Then I believe the above can be simplified to:
>
> 	if (!IS_ERR(page)) {
> 		sgx_epc_page_set_cgroup(page, sgx_cg);
> 	} else {
> 		sgx_cgroup_uncharge(sgx_cg);
> 		sgx_put_cg(sgx_cg);
> 	}
>
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>  		wake_up(&ksgxd_waitq);
>>
>> @@ -604,6 +631,14 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>>  	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
>>  	struct sgx_numa_node *node = section->node;
>>
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	if (page->sgx_cg) {
>> +		sgx_cgroup_uncharge(page->sgx_cg);
>> +		sgx_put_cg(page->sgx_cg);
>> +		page->sgx_cg = NULL;
>> +	}
>> +#endif
>> +
>
> Similarly, how about adding a wrapper in "epc_cgroup.h"
>
> struct sgx_cgroup *sgx_epc_page_get_cgroup(struct sgx_epc_page *page)
> {
> #ifdef CONFIG_CGROUP_SGX_EPC
> 	return page->sgx_cg;
> #else
> 	return NULL;
> #endif
> }
>
> Then this can be:
>
> 	sgx_cg = sgx_epc_page_get_cgroup(page);
> 	sgx_cgroup_uncharge(sgx_cg);
> 	sgx_put_cg(sgx_cg);
> 	sgx_epc_page_set_cgroup(page, NULL);
>

sure.
>>  	spin_lock(&node->lock);
>>
>>  	page->owner = NULL;
>> @@ -643,6 +678,11 @@ static bool __init sgx_setup_epc_section(u64  
>> phys_addr, u64 size,
>>  		section->pages[i].flags = 0;
>>  		section->pages[i].owner = NULL;
>>  		section->pages[i].poison = 0;
>> +
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +		section->pages[i].sgx_cg = NULL;
>> +#endif
>
> Can use the wrapper too.
>
yes.
> [...]
>
> (Btw, I'll be away for couple of days due to public holiday and will  
> review the
> rest starting from late next week).
Thanks
Haitao

