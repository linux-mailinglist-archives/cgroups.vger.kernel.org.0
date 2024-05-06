Return-Path: <cgroups+bounces-2800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE18BD446
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07C81F220E3
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC9158A14;
	Mon,  6 May 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCAaN023"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8315749A;
	Mon,  6 May 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018456; cv=none; b=CjPDtZCYLEYUTo0y5v5wVXdR2z8y6+n8S5C8g0WZT5hypZbH3fJvFoU2urkOzxb0YFpkX2aKNeuG8JyJztMYj0XXY8EUzF7hq2TspsRNwiVBzEmKI0mU8wmRJYxUZ9kKDtVbz0Kf9N2RmnNHjWijkGsQGoETgzTkFC+aaSV6abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018456; c=relaxed/simple;
	bh=f/Nm6vtJRqqBh671P2U5uIyh+8sXlTcjJTL36SePe5o=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=inz/QdOja4y6sGgR75Z167ovnzERj0gKr2mCT0Canmxpr4hzySGdsX8wIIr1lVLGKibiiDiD5p2e1V8AnMs/hYw0AZA0zksqjn2aMp4R7tdJ8c7TYG5ANg+HFQAmcpy/a0AocrozcGKotOClbxuZfUzpvD9WvSiTlMrsJCfuCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCAaN023; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715018455; x=1746554455;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=f/Nm6vtJRqqBh671P2U5uIyh+8sXlTcjJTL36SePe5o=;
  b=HCAaN023BetsvyD6zH7S4D+oSVNfUk4tgMvpQJpksnHytwuu+dHDRpN5
   7pOKRDeg0zkUVC6xUO58Bd37StUeZCt1RreHrApVlBNAgh+NilB8cKTPc
   Pfb/Eq+zgBw2DQfRoo3F/QIvXDHTITl7u0QIVsSxHXtbMPiYv5fXUwmk9
   rtoOGaNEu9ar7v7AcmQLG99uw4v4Ph2A38oWTSEK4tb5nmJTvLjv8WD4W
   ojaypF45LmB7AklAefMoXgmqeBRJ+DJlw10tScJ3dpnoLCL/5kUuqy2ow
   jjsQu4Jh7wJkCBCsAqlkijNjY7tHZF2EXlSr1/xc+9TeAqVBA/IBkP5Rj
   w==;
X-CSE-ConnectionGUID: +jQyBe01Sd+OYnZPOsiD6A==
X-CSE-MsgGUID: hBOc87VzR9Ct7w0JLjpnug==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="36162882"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="36162882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 11:00:53 -0700
X-CSE-ConnectionGUID: xgWPnwH2RBWiuXwZjTJ2WQ==
X-CSE-MsgGUID: 3pKBw7FwQkyMaaNdVXJC3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59417151"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.210.0])
  by smtpauth.intel.com with ESMTP/TLS/AES256-SHA; 06 May 2024 11:00:48 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Huang, Kai" <kai.huang@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v13 11/14] x86/sgx: Abstract check for global reclaimable
 pages
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
 <20240430195108.5676-12-haitao.huang@linux.intel.com>
 <3eb37a6d-ff52-41b0-8f74-d9d049e6ce05@intel.com>
Date: Mon, 06 May 2024 13:00:46 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2nc2zkpywjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <3eb37a6d-ff52-41b0-8f74-d9d049e6ce05@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Kai
Sorry there seems to be some delay in receiving my emails.

On Thu, 02 May 2024 18:23:06 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 1/05/2024 7:51 am, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>  For the global reclaimer to determine if any page available for
>> reclamation at the global level, it currently only checks for emptiness
>> of the global LRU. That will be inadequate when pages are tracked in
>> multiple LRUs, one per cgroup. For this purpose, create a new helper,
>> sgx_can_reclaim_global(), to abstract this check. Currently it only
>> checks the global LRU, later will check emptiness of LRUs of all cgroups
>> when per-cgroup tracking is turned on.
>>  Replace all the checks for emptiness of the global LRU,
>> list_empty(&sgx_global_lru.reclaimable), with calls to
>> sgx_can_reclaim_global().
>>  Rename sgx_should_reclaim() to sgx_should_reclaim_global() as it is  
>> used
>> to check if a global reclamation should be performed.
>>  Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>
> Free free to add:
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
>

Thanks

> One thing below:
>
> [...]
>
>> -static bool sgx_should_reclaim(unsigned long watermark)
>> +static bool sgx_should_reclaim_global(unsigned long watermark)
>>   {
>>   	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
>> -	       !list_empty(&sgx_global_lru.reclaimable);
>> +		sgx_can_reclaim_global();
>>   }
>>     static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>> @@ -405,7 +413,7 @@ static void sgx_reclaim_pages_global(struct  
>> mm_struct *charge_mm)
>>    */
>>   void sgx_reclaim_direct(void)
>>   {
>> -	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> +	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
>>   		sgx_reclaim_pages_global(current->mm);
>>   }
>>
>
> Hmm.. Sorry for not pointing out in the previous version.
>
> Perhaps it makes more sense to do the rename in the patch ...
>
>    x86/sgx: Add basic EPC reclamation flow for cgroup
>
> ... where we have actually introduced the concept of per-cgroup reclaim,  
> and we literally have below change in that patch:
>
>   void sgx_reclaim_direct(void)
>   {
>   	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages();
> +		sgx_reclaim_pages_global();
>   }
>
> So in that patch, the sgx_should_reclaim() literally just means we  
> should do gloabl reclaim, but not the per-cgruop reclaim.  Thus, perhaps  
> we just do the renaming here together with the new  
> sgx_reclaim_pages_global().
>
> If there's a new version needed, please move the renaming to that patch?
>
Will do

BR
Haitao

