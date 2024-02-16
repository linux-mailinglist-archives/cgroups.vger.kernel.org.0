Return-Path: <cgroups+bounces-1679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3D85881E
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 22:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D05B218D4
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3A145FFE;
	Fri, 16 Feb 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz/5jP5i"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7A136658;
	Fri, 16 Feb 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119521; cv=none; b=OEPEleSo96R/2QlSSz4EUVDEYe3UIvU4a+GJKEqE6jtbkxSD/0A0loutrPla7IW74Up+mZp3A8t6NPWaMAmDsZyLsOgoLm2Of1bgZI+rGtPjRU23f9mm7PsA8SAhU2VWsoNZCkZlAA5F9B+HUrrgtX9iHpFnwKzUyVetcXKyZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119521; c=relaxed/simple;
	bh=/03tnYSZHlsXQ79nRDv6eIA74CKPn0RoZElqyfXPpq0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=XcjYOwpRjByC6M/G+Lvbsivsmg4kbUIOMB1eIC4Hpk2TvlxtH9kEUVQDk3qjqHi3UIhc20oRRPcP/1DfDDETXYhCrFpNMIXok5env5LEMFily/nOFDr+AgQIgm5dFiGlRHqmdFZpTroggnjhxmFBCqOsXqJPgPz4bZ+H5cFgoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz/5jP5i; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119519; x=1739655519;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=/03tnYSZHlsXQ79nRDv6eIA74CKPn0RoZElqyfXPpq0=;
  b=Jz/5jP5iADifMxbcEZmEZdFyVbIzuNWzuy9EjyDW70qfNvE+z9UPNxzI
   9Rfg1AwdWwC3QKwnJU+e+k7Bn1UWs23y8WzNeO0VnUjS7YKmAY3nGv/p9
   NardYOQxoE0C1IDdVA/9ndaXGOIVo6FeMQp+ssuz4WJMMNAbZPOQ2EHVf
   xeIKpLi8BXChUHbFt5LSnZYuYF+3QYTkG3WWFpBwRULXH1AQ06zPkLwlu
   zJRCHaskskgh79qF2SB24SYlu5gBbRoILO+3nCV0PEN2Ksfmd0e+2X/93
   nm+B75CqFS4nOb1eFzcIMyYYGJXZDwFIGiLDx7/N9TmMKNXpKQdvfhvsr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13657967"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13657967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:38:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8548746"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 16 Feb 2024 13:38:34 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Dave Hansen" <dave.hansen@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-10-haitao.huang@linux.intel.com>
 <a5bd910b-3148-47ec-9280-561cfe6c16df@intel.com>
Date: Fri, 16 Feb 2024 15:38:32 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2i87qioawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <a5bd910b-3148-47ec-9280-561cfe6c16df@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 16 Feb 2024 09:15:59 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 2/5/24 13:06, Haitao Huang wrote:
>> @@ -414,7 +416,7 @@ static void sgx_reclaim_pages_global(void)
>>  void sgx_reclaim_direct(void)
>>  {
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> -		sgx_reclaim_pages_global();
>> +		sgx_reclaim_pages_global(false);
>>  }
>>
>>  static int ksgxd(void *p)
>> @@ -437,7 +439,7 @@ static int ksgxd(void *p)
>>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
>>
>>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
>> -			sgx_reclaim_pages_global();
>> +			sgx_reclaim_pages_global(true);
>>
>>  		cond_resched();
>>  	}
>
> First, I'm never a fan of random true/false or 0/1 arguments to
> functions like this.  You end up having to go look at the called
> function to make any sense of it.  You can either do an enum, or some
> construct like this:
>
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES)) {
> 			bool indirect = true;
> 			sgx_reclaim_pages_global(indirect);
> 		}
>
> Yeah, it takes a few more lines but it saves you having to comment the
> thing.
>
> Does this 'indirect' change any behavior other than whether it does a
> search for an mm to find a place to charge the backing storage?

No.

> Instead of passing a flag around, why not just pass the mm?
>
There is no need to pass in mm. We could just check if current->mm == NULL  
for the need of doing the search in the enclave mm list.

But you had a concern [1] that the purpose was not clear hence suggested  
current_is_ksgxd().

Would it be OK if we replace current_is_ksgxd() with (current->flags &  
PF_KTHREAD)? That would express the real intent of checking if calling  
context is not in a user context.

> This refactoring out of 'indirect' or passing the mm around really wants
> to be in its own patch anyway.
>
Looks like I could do:
1) refactoring of 'indirect' value/enum suggested above. This seems the  
most straightforward without depending on any assumptions of other kernel  
code.
2) replace  current_is_ksgxd() with current->mm == NULL. This assumes  
kthreads has no mm.
3) replace current_is_ksgxd() with current->flags & PF_KTHREAD. This is  
direct use of the flag PF_KTHREAD, so it should be better than #2?

Any preference or further thoughts?

Thanks
Haitao

[1]  
https://lore.kernel.org/linux-sgx/9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com/

