Return-Path: <cgroups+bounces-1284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B213B8432CF
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 02:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46141C2408A
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11915AF;
	Wed, 31 Jan 2024 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjXRAQ4o"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C281366;
	Wed, 31 Jan 2024 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664926; cv=none; b=pvLOMNRnLqOmdd6ARrnWZkYOj5Ci8Bxbu4m1sSFAEelFOZI7ziIoj/iH/bgqN2TWzVseF47BYpK3jknOzL678tW38wb1JeMIA5xiX0TslQ/wfQwSSAh3CqVo93+bnh+rbvHfm8u1owDVEpTQ9eMP7R5et2EU3Sk5z7KHrp5/n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664926; c=relaxed/simple;
	bh=z6jD8l1Em8qa7RDF9PSVWG8Ir6YPDxlM6YsVako70uA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=FMIkuFaHyhEoGKFARzMt6nQbKrLuUi06akjfPb04XZqs+DQK7lY4iuojZ8t6hjh8cgHpAto+x4i9UMElQON1vInEfQxIwO3HB2J3upq+SFwzX5/QurJSqjW2/zxIWxdfWfKm/brEcMMjuy3igdn4RSZbvrIkp0aC7BnPYij5xTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjXRAQ4o; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706664925; x=1738200925;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=z6jD8l1Em8qa7RDF9PSVWG8Ir6YPDxlM6YsVako70uA=;
  b=LjXRAQ4oNfnvIjPlT5+suV5SUXzXxxQ18NL167Kc+RMadgMibhIe2I53
   SCkfXDkVErFGGcnH+mRgydExi8EtAaIjFrdG5NQ89ujH4YYIOCz4yHGso
   HQyElbA9T5lcJ8von+4RQKqru11wR23aERv46tqx0j27xQX7Mm6MSKf+V
   UzRsAYoSHjlHlv8WLsDAjQg8YcgbrV7J8Vs/JGjivi7U5OUYqhske33hv
   ZP11JUgboukNdRseW1hx3fWb0loYxZtaBzX6KJp5APzwRGCK1YYI1QBMR
   4i9Crs4B0KPsj4LZNQES4xOOEv9FpuOOnnmK5QDea7ysxAw8o1h+qzspC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407171252"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407171252"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907699187"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907699187"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 30 Jan 2024 17:35:21 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "jarkko@kernel.org" <jarkko@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "Huang, Kai" <kai.huang@intel.com>
Cc: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
 "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
References: <20240130020938.10025-1-haitao.huang@linux.intel.com> <20240130020938.10025-8-haitao.huang@linux.intel.com> <BL1PR11MB5978A8E4B6E1DC4CC0159FD0F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
Date: Tue, 30 Jan 2024 19:35:19 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2id1c5n3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <BL1PR11MB5978A8E4B6E1DC4CC0159FD0F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 30 Jan 2024 09:39:44 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>> + * @lru:	The LRU from which pages are reclaimed.
>> + * @nr_to_scan: Pointer to the target number of pages to scan, must be  
>> less
>> than
>> + *		SGX_NR_TO_SCAN.
>> + * Return:	Number of pages reclaimed.
>>   */
>> -static void sgx_reclaim_pages(void)
>> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned
>> +int *nr_to_scan)
>
> Since the function is now returning the number of reclaimed pages, why  
> do you need to make the @nr_to_scan as pointer?
>
> Cannot the caller just adjust @nr_to_scan when calling this function  
> based on how many pages have reclaimed?
>
> I am not even sure whether you need @nr_to_scan at all because as we  
> discussed I think it's just extremely rare you need to pass "<  
> SGX_NR_TO_SCAN" to this function.
>
> Even if you need, you can always choose to try to reclaim SGX_NR_TO_SCAN  
> pages.
>

I tested with that approach and found we can only target number of pages  
attempted to reclaim not pages actually reclaimed due to the uncertainty  
of how long it takes to reclaim pages. Besides targeting number of scanned  
pages for each cycle is also what the ksgxd does.

If we target actual number of pages, sometimes it just takes too long. I  
saw more timeouts with the default time limit when running parallel  
selftests.

We also need return number of pages actually reclaimed as indication to  
caller whether we actually reclaimed any pages at all. The caller, e.g.,  
sgx_epc_cg_try_charge(), then can decide to schedule() or continue next  
step which usually is allocation of the page.

> [...]
>
>>
>> +static void sgx_reclaim_pages_global(void) {
>> +	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
>> +
>> +	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan); }
>> +
>
> I think this function doesn't look sane at all when you have @nr_to_scan  
> being a pointer?
>

You will see the pointer being used later for cgroup worker.

> I am also not sure whether this function is needed -- if we don't add  
> @nr_to_scan to sgx_reclaim_pages(), then this function is basically:
>
> 	sgx_reclaim_pages(&sgx_global_lru);
>

As indicated in the commit message, this wrapper is getting ready for  
doing global reclamation from root cgroup. You will see it changed later.


Thanks
Haitao

