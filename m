Return-Path: <cgroups+bounces-2717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342E8B5E8C
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF99E1F24AD5
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1951783CB9;
	Mon, 29 Apr 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTuJhVWN"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E3839FF;
	Mon, 29 Apr 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406733; cv=none; b=VfABcwvX9C/jshJ22kfh9AOEIFir39o85Dh9FwwGmkmo2w4YqPI+X+HZFwWyUjmRF7sI8a+QDQ5BGuCJvWri0RE2Yb+6BR8GMGF88q2vKKtG+ajb+zfcZwihJi+ID68yXs5tHtORgqVuAsA+YillFAu1fA3iv2nRYWWWfTcd6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406733; c=relaxed/simple;
	bh=YD/OxqV+lEnK7x1x1U/zl0bii0aWAk483FiEemFo+Fo=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=l7p8Mzsm6+QuH39k4dXlurDGV949xEM5Ewwn0Sa/5o8JFCW3+JtN644803hMFwF9MA9276bIlxclQvUh1I64CMpY1sgqsrk/BrAZ1tJdiiUn3yjkbfbEdByFLb+RfUSTdaHMvz8lQmOwAZFXnX1O1A1bRCrsZm1L89ChDNaEOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTuJhVWN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714406732; x=1745942732;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=YD/OxqV+lEnK7x1x1U/zl0bii0aWAk483FiEemFo+Fo=;
  b=bTuJhVWNhicWyNdQICvu1ORlN1R+rP2ALR8OqJKSDMEVg2/S/R42KPFn
   wE23rVRgpmIF8ggx02W72VqIYpmlYy0EL2YWiGOkS0wtQk26myrCsZ+DX
   L59LIR1fIwOFoOCpIUSUK/2na4gyDmggIx4ODrY85+xGgRa9evkcHRpBD
   r/BuN2hEynxfeCTnckCxcWu+vcmACCBTC2MCGPmbcfdGpkm5wAuLPf9cD
   x5Bh+1J1sjqYPzsnhX7gcnES2Dfn5oIAPwz0rMqzzib/BxrPHVXY8N5d9
   V1o/3lbLjGiucr5MZ5gY5LHlwKHavzvnZ+Wg5G4oWgho6RqRDqNzY6uyY
   g==;
X-CSE-ConnectionGUID: zMC3DCQdQ1OCPDOH8byl1Q==
X-CSE-MsgGUID: FmI4aMRDQuiGHoM3LjzPbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21227659"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="21227659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:05:26 -0700
X-CSE-ConnectionGUID: 67nfouXGRO+tO2l77+282Q==
X-CSE-MsgGUID: Tg2PHMGkRXSTk8vOSprIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30977079"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.99.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 29 Apr 2024 09:05:23 -0700
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
Subject: Re: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-13-haitao.huang@linux.intel.com>
 <524cf9b081d86ae61342fdfc370a3639d0010f94.camel@intel.com>
Date: Mon, 29 Apr 2024 11:05:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mzyy7ktwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <524cf9b081d86ae61342fdfc370a3639d0010f94.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 29 Apr 2024 05:49:13 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> +/*
>> + * Get the per-cgroup or global LRU list that tracks the given  
>> reclaimable page.
>> + */
>>  static inline struct sgx_epc_lru_list *sgx_lru_list(struct  
>> sgx_epc_page *epc_page)
>>  {
>> +#ifdef CONFIG_CGROUP_MISC
>> +	/*
>> +	 * epc_page->sgx_cg here is never NULL during a reclaimable epc_page's
>> +	 * life between sgx_alloc_epc_page() and sgx_free_epc_page():
>> +	 *
>> +	 * In sgx_alloc_epc_page(), epc_page->sgx_cg is set to the return from
>> +	 * sgx_get_current_cg() which is the misc cgroup of the current task,  
>> or
>> +	 * the root by default even if the misc cgroup is disabled by kernel
>> +	 * command line.
>> +	 *
>> +	 * epc_page->sgx_cg is only unset by sgx_free_epc_page().
>> +	 *
>> +	 * This function is never used before sgx_alloc_epc_page() or after
>> +	 * sgx_free_epc_page().
>> +	 */
>> +	return &epc_page->sgx_cg->lru;
>> +#else
>>  	return &sgx_global_lru;
>> +#endif
>>  }
>>
>>  /*
>> @@ -42,7 +63,8 @@ static inline struct sgx_epc_lru_list  
>> *sgx_lru_list(struct sgx_epc_page *epc_pag
>>   */
>>  static inline bool sgx_can_reclaim(void)
>>  {
>> -	return !list_empty(&sgx_global_lru.reclaimable);
>> +	return !sgx_cgroup_lru_empty(misc_cg_root()) ||
>> +	       !list_empty(&sgx_global_lru.reclaimable);
>>  }
>
> Shouldn't this be:
>
> 	if (IS_ENABLED(CONFIG_CGROUP_MISC))
> 		return !sgx_cgroup_lru_empty(misc_cg_root());
> 	else
> 		return !list_empty(&sgx_global_lru.reclaimable);
> ?
>
> In this way, it is consistent with the sgx_reclaim_pages_global() below.
>

I changed to this way because sgx_cgroup_lru_empty() is now defined in  
both KConfig cases.
And it seems better to minimize use of the KConfig variables based on  
earlier feedback (some are yours).
Don't really have strong preference here. So let me know one way of the  
other.

>>
>>  static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
>> @@ -404,7 +426,10 @@ static bool sgx_should_reclaim(unsigned long  
>> watermark)
>>
>>  static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>>  {
>> -	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>> +	if (IS_ENABLED(CONFIG_CGROUP_MISC))
>> +		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
>> +	else
>> +		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>>  }
>>
>>  /*
>> @@ -414,6 +439,14 @@ static void sgx_reclaim_pages_global(struct  
>> mm_struct *charge_mm)
>>   */
>>  void sgx_reclaim_direct(void)
>>  {
>> +	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
>> +
>> +	/* Make sure there are some free pages at cgroup level */
>> +	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg)) {
>> +		sgx_cgroup_reclaim_pages(misc_from_sgx(sgx_cg), current->mm);
>> +		sgx_put_cg(sgx_cg);
>> +	}
>
> Empty line.
>

Sure

>> +	/* Make sure there are some free pages at global level */
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>
> Looking at the code, to me sgx_should_reclaim() is a little bit vague
> because from the name we don't know whether it interally checks the
> current cgroup or the global.  
> It's better to rename to sgx_should_reclaim_global().
>
> Ditto for sgx_can_reclaim() -> sgx_can_reclaim_global().
>
> And I think you can do the renaming in the previous patch, because in the
> changelog of your previous patch, it seems you have called out the two
> functions are for global reclaim.
>

ok

Thanks
Haitao

