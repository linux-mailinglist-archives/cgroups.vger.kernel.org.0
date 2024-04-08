Return-Path: <cgroups+bounces-2374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4489CB68
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6339728A376
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE1144300;
	Mon,  8 Apr 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhOPm/bj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C014387B;
	Mon,  8 Apr 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599435; cv=none; b=cNCXzb2L0x91A1nH+U9Ta4BdjPhxL56YeM91wC7F4OQSAMr4jtTw6PflRWLHO1u664YZInJPzNEGfv8O3QPknSYaF6f5Q4udPndsBS9IRnq+WVO+McVAPyVChqX4PxecnnB4shUoNNQ9y/3IslUNvJ6IVyqCf1HHUfyFvcaJAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599435; c=relaxed/simple;
	bh=GX/Lh3wGJzt7j/x7mO48SE49shEqGeG5e4dk8QXVA9U=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=UzwyHh1DWKbwegRV9BM0Q8xus6U94O0LS+Vhpacb4EdfSsp22ULP3lYYgnincB1XGWV1XY95f/AAMJ6cjnEHUIunjQYqqw93XnykAl7sIAmHOxceImOMg+txZKtlfzQKPD7DmZzogkHgiVHSMT7voBqiSeCj1H0VhuIDl0gIuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhOPm/bj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712599433; x=1744135433;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=GX/Lh3wGJzt7j/x7mO48SE49shEqGeG5e4dk8QXVA9U=;
  b=dhOPm/bjgQNW7UKswmDng1UG++CRF1tIgOOSMVObTIkGugePmZZCAKUs
   dlRqxdGL78vmvXt3NiIdCqvOBHX4m02N0n1Z3MCXKWbUVOoZerkB9xwpn
   Z3v8q4yg1jC9aZHWn5s9PBTj21GSku/rJJkZf8xiS+aPpxvdAGXmP3CSC
   66DT+3idibGjOcHGb/z306AxLIw+zFsVVNZLhn3oFwrgMEqpzo31B8xBr
   fRZQuPjexASMj4M/302gSqhEVmDOSLrLIB1wYPNyp/QTB1zCqQ/8tL0hD
   yikjj9DThwI6Mm8/aP/5V46oyUQhNrCiJhjsTaN2taX98avREqSeU4DyV
   g==;
X-CSE-ConnectionGUID: J2RE68hWQ/eGpW0wJsmBRw==
X-CSE-MsgGUID: DezQOPxDT2CzT9ix6HKtWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11729550"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11729550"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:03:52 -0700
X-CSE-ConnectionGUID: s15JuGfVRBmiTIqZswlPng==
X-CSE-MsgGUID: APhxGUJBRAqzYowMcziujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19913398"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 08 Apr 2024 11:03:45 -0700
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
Subject: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-13-haitao.huang@linux.intel.com>
 <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
Date: Mon, 08 Apr 2024 13:03:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 08 Apr 2024 07:20:23 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -28,6 +28,10 @@ static inline int sgx_cgroup_try_charge(struct  
>> sgx_cgroup *sgx_cg, enum sgx_recl
>>  static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
>>
>>  static inline void sgx_cgroup_init(void) { }
>> +
>> +static inline void sgx_cgroup_reclaim_pages(struct misc_cg *root,  
>> struct mm_struct *charge_mm)
>> +{
>> +}
>>  #else
>>  struct sgx_cgroup {
>>  	struct misc_cg *cg;
>> @@ -65,6 +69,9 @@ static inline void sgx_put_cg(struct sgx_cgroup  
>> *sgx_cg)
>>
>>  int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim  
>> reclaim);
>>  void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
>> +bool sgx_cgroup_lru_empty(struct misc_cg *root);
>> +bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg);
>> +void sgx_cgroup_reclaim_pages(struct misc_cg *root,  struct mm_struct  
>> *charge_mm);
>
> Seems the decision to choose whether to implement a stub function for  
> some
> function is quite random to me.
>
> My impression is people in general don't like #ifdef in the C file but  
> prefer to
> implementing it in the header in some helper function.
>
> I guess you might want to just implement a stub function for each of the  
> 3
> functions exposed, so that we can eliminate some #ifdefs in the  
> sgx/main.c (see
> below).
>
>>  void sgx_cgroup_init(void);
>>
>>  #endif
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index 7f92455d957d..68f28ff2d5ef 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -34,6 +34,16 @@ static struct sgx_epc_lru_list sgx_global_lru;
>>
>>  static inline struct sgx_epc_lru_list *sgx_lru_list(struct  
>> sgx_epc_page *epc_page)
>>  {
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	if (epc_page->sgx_cg)
>> +		return &epc_page->sgx_cg->lru;
>> +
>> +	/*
>> +	 * This should not happen when cgroup is enabled: Every page belongs
>> +	 * to a cgroup, or the root by default.
>> +	 */
>> +	WARN_ON_ONCE(1);
>
> In the case MISC cgroup is enabled in Kconfig but disabled by command  
> line, I
> think this becomes legal now?
>

I'm not sure actually. Never saw the warning even if I set  
"cgroup_disable=misc" in commandlibe. Tried both v1 and v2. Anyway, I  
think we can remove this warning and we handle the NULL sgx_cg now.

>> +#endif
>>  	return &sgx_global_lru;
>>  }
>>
>> @@ -42,7 +52,11 @@ static inline struct sgx_epc_lru_list  
>> *sgx_lru_list(struct sgx_epc_page *epc_pag
>>   */
>>  static inline bool sgx_can_reclaim(void)
>>  {
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	return !sgx_cgroup_lru_empty(misc_cg_root());
>> +#else
>>  	return !list_empty(&sgx_global_lru.reclaimable);
>> +#endif
>>  }
>>
>
> Here you are using #ifdef  CONFIG_CGRUP_SGX_EPC, but ...
>
>>  static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
>> @@ -404,7 +418,10 @@ static bool sgx_should_reclaim(unsigned long  
>> watermark)
>>
>>  static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>>  {
>> -	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>> +	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
>> +		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
>> +	else
>> +		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>>  }
>
> ... here you are using IS_ENABLED(CONFIG_CGROUP_SGX_EPC).
>
> Any reason they are not consistent?

I was hesitant to expose sgx_global_lru needed for implementing  
sgx_cgroup_lru_empty() stub which would also be a random decision and  
overkill to just remove couple of #ifdefs in short functions.

>
> Also, in the case where MISC cgroup is disabled via commandline, I think  
> it
> won't work, because misc_cg_root() should be NULL in this case while
> IS_ENABLED(CONFIG_CGROUP_SGX_EPC) is true.
>
>>

The misc root cgroup is a static similar to sgx_cg_root. So  
misc_cg_root()  won't be NULL
However, based on how css_misc() was check NULL, I suppose  
sgx_get_current_cg() may be NULL when cgroup is disabled (again not 100%  
sure but we handle it anyway)

>>  /*
>> @@ -414,6 +431,16 @@ static void sgx_reclaim_pages_global(struct  
>> mm_struct *charge_mm)
>>   */
>>  void sgx_reclaim_direct(void)
>>  {
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
>> +
>> +	/* Make sure there are some free pages at cgroup level */
>> +	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg)) {
>> +		sgx_cgroup_reclaim_pages(sgx_cg->cg, current->mm);
>> +		sgx_put_cg(sgx_cg);
>> +	}
>> +#endif
>
> This #ifdef CONFIG_CGROUP_SGX_EPC can be removed if we implement a stub  
> function
> for sgx_cgroup_should_reclaim().
>
Yes.
>> +	/* Make sure there are some free pages at global level */
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>  		sgx_reclaim_pages_global(current->mm);
>>  }
>

Thanks
Haitao

