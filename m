Return-Path: <cgroups+bounces-2675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C698AF2BE
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E0A1F23AF2
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57813C9BE;
	Tue, 23 Apr 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THV9GSZw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD13C687;
	Tue, 23 Apr 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887608; cv=none; b=p9oziASvbxeLGk2YDIJDMCDnPdV4NZ9BLT7NkeY8N+F13dZF4e9IXH/cFPd0oLbtXstCvzDhVTKPnaH9TMsAcnmAU/4gqE1Nc8H/aK76gZq3fcxOSYvglkCd15ekbPsGJo8s/SH3bvE6XIlhWJHCgL1qPpOc/Al74DINeInNTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887608; c=relaxed/simple;
	bh=fh7yjp2tSefFpIVGJP6q+aTlJDI9CIF+XVgZbkGG5Uw=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=ozPnoPVeoQw87vkazA5PebaKeslZpjUYSINnHOZt2+gmONXDy/V7FrCN98wMD7hssEv8HFBLQ3WcF8wXsA8NbUyKuY77b80lFHxwvR+ibqqIUJwQyeD+7lcM8nls72Ixpq+1VVUWJ5jv2KeK/gzCnE44tigv3B6iRstgoXu6wHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THV9GSZw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713887607; x=1745423607;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=fh7yjp2tSefFpIVGJP6q+aTlJDI9CIF+XVgZbkGG5Uw=;
  b=THV9GSZwLoOy6vq8WtKhs17AYyMDzaiLe7THtC8v9Bsl9Fuo8vHgOMZ3
   9KqF+xDiwqjZFK3dF6gAcknJ06OHM4mT5nWbloK6zzm7Usg480i97EBVW
   L/23MD3AL8b+HqqDqTPEWKtRDC0VZpMWgex6AoIwrAhkxwkAYa/9afpVe
   a7ZJxljBbuYSFCyuoOrmNB9ENlPRRyWUgeo5eGUFV8pDVm5mAbOz21sjH
   oTdkTzMOXYJCnDmqI8/Ah9/x2GLfnu4D0596/bD9a1wmQBLTw11JUmXgD
   p2bWqrlsQ2u8ywl9lG8JdoRaiSQxxvsjKm3y76kHmEv6KQ/dFlcydMXIk
   A==;
X-CSE-ConnectionGUID: xwWmg7KkSlKdC9a/nlGT4Q==
X-CSE-MsgGUID: rOJJaTRWTpeBciUCCnXJPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="31975009"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31975009"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:53:27 -0700
X-CSE-ConnectionGUID: g5k+nMEzTKCel3CKajTLvg==
X-CSE-MsgGUID: LZ/fAsciR6yBchxQZb7MlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24408924"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 23 Apr 2024 08:53:23 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Huang, Kai" <kai.huang@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-9-haitao.huang@linux.intel.com>
 <8a9ae08a-c813-442d-9fc3-031a4c984700@intel.com>
Date: Tue, 23 Apr 2024 10:53:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2moue7exwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <8a9ae08a-c813-442d-9fc3-031a4c984700@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 17 Apr 2024 18:51:28 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 16/04/2024 3:20 pm, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>  Currently in the EPC page allocation, the kernel simply fails the
>> allocation when the current EPC cgroup fails to charge due to its usage
>> reaching limit.  This is not ideal. When that happens, a better way is
>> to reclaim EPC page(s) from the current EPC cgroup (and/or its
>> descendants) to reduce its usage so the new allocation can succeed.
>>  Add the basic building blocks to support per-cgroup reclamation.
>>  Currently the kernel only has one place to reclaim EPC pages: the  
>> global
>> EPC LRU list.  To support the "per-cgroup" EPC reclaim, maintain an LRU
>> list for each EPC cgroup, and introduce a "cgroup" variant function to
>> reclaim EPC pages from a given EPC cgroup and its descendants.
>>  Currently the kernel does the global EPC reclaim in sgx_reclaim_page().
>> It always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16)
>> pages.  Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN
>> pages from the global LRU, and then tries to reclaim these pages at once
>> for better performance.
>>  Implement the "cgroup" variant EPC reclaim in a similar way, but keep
>> the implementation simple: 1) change sgx_reclaim_pages() to take an LRU
>> as input, and return the pages that are "scanned" and attempted for
>> reclamation (but not necessarily reclaimed successfully); 2) loop the
>> given EPC cgroup and its descendants and do the new sgx_reclaim_pages()
>> until SGX_NR_TO_SCAN pages are "scanned".
>>  This implementation, encapsulated in sgx_cgroup_reclaim_pages(), always
>> tries to reclaim SGX_NR_TO_SCAN pages from the LRU of the given EPC
>> cgroup, and only moves to its descendants when there's no enough
>> reclaimable EPC pages to "scan" in its LRU.  It should be enough for
>> most cases.
>>  Note, this simple implementation doesn't _exactly_ mimic the current
>> global EPC reclaim (which always tries to do the actual reclaim in batch
>> of SGX_NR_TO_SCAN pages): when LRUs have less than SGX_NR_TO_SCAN
>> reclaimable pages, the actual reclaim of EPC pages will be split into
>> smaller batches _across_ multiple LRUs with each being smaller than
>> SGX_NR_TO_SCAN pages.
>>  A more precise way to mimic the current global EPC reclaim would be to
>> have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
>> _across_ the given EPC cgroup _AND_ its descendants, and then do the
>> actual reclaim in one batch.  But this is unnecessarily complicated at
>> this stage.
>>  Alternatively, the current sgx_reclaim_pages() could be changed to
>> return the actual "reclaimed" pages, but not "scanned" pages. However,
>> the reclamation is a lengthy process, forcing a successful reclamation
>> of predetermined number of pages may block the caller for too long. And
>> that may not be acceptable in some synchronous contexts, e.g., in
>> serving an ioctl().
>>  With this building block in place, add synchronous reclamation support
>> in sgx_cgroup_try_charge(): trigger a call to
>> sgx_cgroup_reclaim_pages() if the cgroup reaches its limit and the
>> caller allows synchronous reclaim as indicated by s newly added
>> parameter.
>>  A later patch will add support for asynchronous reclamation reusing
>> sgx_cgroup_reclaim_pages().
>>  Note all reclaimable EPC pages are still tracked in the global LRU thus
>> no per-cgroup reclamation is actually active at the moment. Per-cgroup
>> tracking and reclamation will be turned on in the end after all
>> necessary infrastructure is in place.
>
> Nit:
>
> "all necessary infrastructures are in place", or, "all necessary  
> building blocks are in place".
>
> ?
>
>>  Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
>

Thanks

> More nitpickings below:
>
> [...]
>
>> -static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
>> +static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg,  
>> enum sgx_reclaim reclaim)
>
> Let's still wrap the text on 80-character basis.
>
> I guess most people are more used to that.
>
> [...]
>
>> -		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
>> -						    struct sgx_epc_page, list);
>> +		epc_page = list_first_entry_or_null(&lru->reclaimable, struct  
>> sgx_epc_page, list);
>
> Ditto.
>

Actually I changed to 100 char width based on comments from Jarkko IIRC.
I don't have personal preference, but will not change back to 80 unless  
Jarkko also agrees.

Thanks
Haitao

