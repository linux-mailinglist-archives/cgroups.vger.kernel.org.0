Return-Path: <cgroups+bounces-1798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1C85FE22
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C30A1F25F10
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251714901A;
	Thu, 22 Feb 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyIHEU2U"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C028370;
	Thu, 22 Feb 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619717; cv=none; b=jVw1nWiBUplsgVHoxQP6ObAskh45bgV2spngDF5sLQUfHtTqhbyuUc6q0LqqJY3Oc7dQ6zoonRjEao0oWtEk0oojLU/W4jJC40M97ouQoy1wMlRtbXbuheRzsglW+BpqsFrZHluJ2ZLbmGgsrwEUnwwypcXpVyfsYUuj9NZXoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619717; c=relaxed/simple;
	bh=TyM+PSIQuTmbImhNTqtGDXOnOnzxJNTlXsqylnrhBGg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=dpJmQSmdUjsPYNAPZmPDuSfqp4iRQymHpFh17Jxh1ONaALbJTEjCqoP6TRbFFObEJl6Qf9E8baBg0kfyg+M6swB+9Sz+FZVjoYb5u1/yaHHW0g6e7kuDE0QCdaAuYOm0PRH4vc6C8mMsB4ttnbb1atj8vO0roa+lcOmjB8q1RYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyIHEU2U; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708619716; x=1740155716;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=TyM+PSIQuTmbImhNTqtGDXOnOnzxJNTlXsqylnrhBGg=;
  b=DyIHEU2U7jDOrICuMeKEL0bd2QTBYcYqFkdEC3Qtp0zwjQnWDgPqQawt
   Wtup1JsfVv1uOaiOpzgMPMUI7bQ0vwJpRlBndoD8ngafo5f1eZzsew9mh
   JPF98Qh8BxTpH4MrPdmsY5tY2nazoR2MLbOw/dyocnS/9Xnl4gOP61uh5
   aUPhp2c+fWLIKECwYQSdZTFxpZLPr3np0S50AqCUGFJAoRws2OjjdONrh
   cUjDGEyxFuroHCTwCgyuZysiAy/hjX/Zg4rmPJNDHcHK1BTW79oha1eJf
   Ia0YoyFjlIG5ghB2/mbqwR0K7rP9pddFFnRr6uc3rpchY2akFrvEIttUN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="5808526"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5808526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5746505"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 08:35:13 -0800
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
Subject: Re: [PATCH v9 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages()
 for global reclaimer
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-13-haitao.huang@linux.intel.com>
 <7a70ad00ce4d79977753d1c4ed748a395cc5057e.camel@intel.com>
Date: Thu, 22 Feb 2024 10:35:12 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jjxoypzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <7a70ad00ce4d79977753d1c4ed748a395cc5057e.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 21 Feb 2024 05:10:36 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> When cgroup is enabled, all reclaimable pages will be tracked in cgroup
>> LRUs. The global reclaimer needs to start reclamation from the root
>> cgroup. Expose the top level cgroup reclamation function so the global
>> reclaimer can reuse it.
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V8:
>> - Remove unneeded breaks in function declarations. (Jarkko)
>>
>> V7:
>> - Split this out from the big patch, #10 in V6. (Dave, Kai)
>> ---
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.h | 7 +++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> index abf74fdb12b4..6e31f8727b8a 100644
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -96,7 +96,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
>>   * @indirect:   In ksgxd or EPC cgroup work queue context.
>>   * Return:	Number of pages reclaimed.
>>   */
>> -static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root,  
>> bool indirect)
>> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool  
>> indirect)
>>  {
>>  	/*
>>  	 * Attempting to reclaim only a few pages will often fail and is
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> index d061cd807b45..5b3e8e1b8630 100644
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -31,6 +31,11 @@ static inline int sgx_epc_cgroup_try_charge(struct  
>> sgx_epc_cgroup *epc_cg, bool
>>  static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup  
>> *epc_cg) { }
>>
>>  static inline void sgx_epc_cgroup_init(void) { }
>> +
>> +static inline unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg  
>> *root, bool indirect)
>> +{
>> +	return 0;
>> +}
>>  #else
>>  struct sgx_epc_cgroup {
>>  	struct misc_cg *cg;
>> @@ -69,6 +74,8 @@ static inline void sgx_put_epc_cg(struct  
>> sgx_epc_cgroup *epc_cg)
>>  int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool  
>> reclaim);
>>  void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
>>  bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
>> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool  
>> indirect);
>> +
>>  void sgx_epc_cgroup_init(void);
>>
>>  #endif
>
> I'd just prefer to merge patch such like this to the one that actually  
> uses the
> exposed function.  It's just couple of LOC and we don't deserve to read  
> these
> repeated changelog and move back and forth between patches during review.
>
>
IIRC, Jarkko prefers exposing functions first in separate patch. Jarkko,  
right?

Also I found your definition/expectation of self-contained patches is just  
confusing or too constrained at least. I usually review each patch  
separately without back and forth and then review them together to see if  
they all make sense in terms of breakdown. My minimal  expectation is  
that  a patch should not depend on future changes and should not break  
current state of function. and

For this one I thought the idea was you verify if the API exposed make  
sense without looking at how it is used in future. Then when you review  
the usage patch, you see if the usage is reasonable.

I would really hesitate to merge patches at this point unless we all have  
an agreement and have good/strong reasons or there is a hard rule about  
this.

Thanks
Haitao

