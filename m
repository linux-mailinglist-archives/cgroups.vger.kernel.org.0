Return-Path: <cgroups+bounces-1799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D5385FE28
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365202835C4
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CA153BD4;
	Thu, 22 Feb 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEhdRy3I"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840C150988;
	Thu, 22 Feb 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619774; cv=none; b=g/Ni71y2pVF8pdGVzACDGEdu3WVXQRA0ePrWOa3iX3TEme4YUyyXo7RrRTjl/cRTHW6kITmQJphpX7DmjHbiUCUt522f7EIcDR68AvLiDJiy3UCdcwWKaLdIFrO/XTo9ohmr90317eSB4OcdG1gDTPwYKx6xkNTah5rbtZEzmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619774; c=relaxed/simple;
	bh=cxJ8+Fd+JJ52mfB+2Kj9hre/qIAB+u1cGYn/syKiGTo=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=lnPoXX7iMyw1J3tR64DPuwibbbzGo8olGIt8B+f9+jG+u5buRF+4ivssjFANzmgYSTAPlS9oA00gBAhMZ3oQs+eYk3js7+PP2YDbIgihaCB2MZYz/WZU+rDWl+6kRnfm9KIT3TjkW/V0rgbZWIjBfb9iSkG/hBUI4ovoCQDrXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEhdRy3I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708619773; x=1740155773;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=cxJ8+Fd+JJ52mfB+2Kj9hre/qIAB+u1cGYn/syKiGTo=;
  b=bEhdRy3IvufxpjvYe5xwgLCkHhHbXD751F9RhlQBPIPr2/9AIw9k6u1o
   vzZd73aMo+rIK7iDcCUqsJZI8pbQxnDALfBkfz8APEyE5hTMd8sIw2F1V
   E/25sJ/gnplQRuD2q/RS5brP+/hvJoxYFpMSOVa5l2R1PJFOkXuLIaQGs
   lNZyLRTuQPDI1p2cCP231E3MIdQJBKUVqsB4+CtCKsYlthzQ+uYzNCZBd
   J3NaWEa71jYh2USFReML/7w5jxCD5nWRlxVXuscLNQImruEu3W8cMMX2q
   t1len1M/a14iWYAwR/dvPAGOnmPQixwCTuze0e7Q0fN/W9e3992gpgD1y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="5808658"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5808658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:36:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5746563"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 08:36:09 -0800
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
Subject: Re: [PATCH v9 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-14-haitao.huang@linux.intel.com>
 <87a85645ef1661e54ae6e56f1e47db25c3f8d7af.camel@intel.com>
Date: Thu, 22 Feb 2024 10:36:09 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jjxqjiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <87a85645ef1661e54ae6e56f1e47db25c3f8d7af.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 21 Feb 2024 05:23:00 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Previous patches have implemented all infrastructure needed for
>> per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
>> pages are still tracked in the global LRU as sgx_lru_list() returns hard
>> coded reference to the global LRU.
>>
>> Change sgx_lru_list() to return the LRU of the cgroup in which the given
>> EPC page is allocated.
>>
>> This makes all EPC pages tracked in per-cgroup LRUs and the global
>> reclaimer (ksgxd) will not be able to reclaim any pages from the global
>> LRU. However, in cases of over-committing, i.e., sum of cgroup limits
>> greater than the total capacity, cgroups may never reclaim but the total
>> usage can still be near the capacity. Therefore global reclamation is
>> still needed in those cases and it should reclaim from the root cgroup.
>>
>> Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
>> when cgroup is enabled, otherwise from the global LRU.
>>
>> Similarly, modify sgx_can_reclaim(), to check emptiness of LRUs of all
>> cgroups when EPC cgroup is enabled, otherwise only check the global LRU.
>>
>> With these changes, the global reclamation and per-cgroup reclamation
>> both work properly with all pages tracked in per-cgroup LRUs.
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V7:
>> - Split this out from the big patch, #10 in V6. (Dave, Kai)
>> ---
>>  arch/x86/kernel/cpu/sgx/main.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index 6b0c26cac621..d4265a390ba9 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -34,12 +34,23 @@ static struct sgx_epc_lru_list sgx_global_lru;
>>
>>  static inline struct sgx_epc_lru_list *sgx_lru_list(struct  
>> sgx_epc_page *epc_page)
>>  {
>> +#ifdef CONFIG_CGROUP_SGX_EPC
>> +	if (epc_page->epc_cg)
>> +		return &epc_page->epc_cg->lru;
>> +
>> +	/* This should not happen if kernel is configured correctly */
>> +	WARN_ON_ONCE(1);
>> +#endif
>>  	return &sgx_global_lru;
>>  }
>
> How about when EPC cgroup is enabled, but one enclave doesn't belong to  
> any EPC
> cgroup?  Is it OK to track EPC pages for these enclaves to the root EPC  
> cgroup's
> LRU list together with other enclaves belongs to the root cgroup?
>
>
> This should be a valid case, right?

There is no such case. Each page is in the root by default.

Thanks

Haitao

