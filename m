Return-Path: <cgroups+bounces-1482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D9852255
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 00:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6EF28352A
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 23:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45C4F214;
	Mon, 12 Feb 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7LvsJfA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A64EB5C;
	Mon, 12 Feb 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779752; cv=none; b=NSfzakD2PwpZh3GnrPmCZA2C0e6yN2NA1qTSJ+v5NyzJu3mvhkOsVnD1zXQmUvsJnRqnNKF/nYnHCTWKBR2Tobfm8MTvW+QPiv5vRkaF20sIvGan4LjlWjTnc8H4DSX0Ff4pp7i1ih9pWMRHQ2yEtoOPgvGxRebcTwWWH3VhVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779752; c=relaxed/simple;
	bh=2V5ih+rh+uJ8v7Og2vnvqzcZcn7X0cF6QU3gjcKFHDs=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=hIEM8fCqTLn83H87Y0NW8XhXqSrrgDKeNXUHEOSr6wHjW5sCS9YOQdyCfyzTcmF9W4SORZPhgTDmx1H4CUdgcIyQyiMWvwxqM+aGV3Vd2hts/xInxReaZTfkqwlRmE59wSsrOHdfA3Kh7j335cN5I32yJ++pTdVw/Z5vwNt47ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7LvsJfA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707779752; x=1739315752;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=2V5ih+rh+uJ8v7Og2vnvqzcZcn7X0cF6QU3gjcKFHDs=;
  b=M7LvsJfARDw6F4p+ajzBS3HSK3zm/gYlXaKiXAgOXv2v6deiD7p12dHF
   966KWYiG5eJtj+0t1Ue+VrfO0cyQrOGvgzfqYB9wxBLTNDKyZV9HH6wAe
   KFDyPE3iIPZwg/WnAVEWgg4qitBTPgFKeFpc62EfIpUgN7aZRTByigDBQ
   XevQYO3Ju5lVFw1VIlFbFBwLsSO6sdZ6wM/4SuPPXxk6siIxhAhaCayzh
   4P2auVAQby5hjiC0fyzqifgxlJLBomn98C62RW3ihhgJA2pJ+wM9NLsln
   99aZN793VZU4kk0Os97kDvhvGpna0yI6vCDkgmfJKFhz1+qNISjogAm+t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13173245"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="13173245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7350882"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 12 Feb 2024 15:15:48 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <CZ3D53XFVXAW.25EK0ZBFH3HV2@kernel.org>
Date: Mon, 12 Feb 2024 17:15:42 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2i1xkgedwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CZ3D53XFVXAW.25EK0ZBFH3HV2@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

Hi Jarkko

On Mon, 12 Feb 2024 13:55:46 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> When the EPC usage of a cgroup is near its limit, the cgroup needs to
>> reclaim pages used in the same cgroup to make room for new allocations.
>> This is analogous to the behavior that the global reclaimer is triggered
>> when the global usage is close to total available EPC.
>>
>> Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
>> whether synchronous reclaim is allowed or not. And trigger the
>> synchronous/asynchronous reclamation flow accordingly.
>>
>> Note at this point, all reclaimable EPC pages are still tracked in the
>> global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
>> is activated yet.
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
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
>>  arch/x86/kernel/cpu/sgx/main.c       |  2 +-
>>  3 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> index d399fda2b55e..abf74fdb12b4 100644
>> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -184,13 +184,35 @@ static void  
>> sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
>>  /**
>>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC  
>> page
>>   * @epc_cg:	The EPC cgroup to be charged for the page.
>> + * @reclaim:	Whether or not synchronous reclaim is allowed
>>   * Return:
>>   * * %0 - If successfully charged.
>>   * * -errno - for failures.
>>   */
>> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool  
>> reclaim)
>>  {
>> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
>> +	for (;;) {
>> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>> +					PAGE_SIZE))
>> +			break;
>> +
>> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>> +			return -ENOMEM;
>> + +		if (signal_pending(current))
>> +			return -ERESTARTSYS;
>> +
>> +		if (!reclaim) {
>> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>> +			return -EBUSY;
>> +		}
>> +
>> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
>> +			/* All pages were too young to reclaim, try again a little later */
>> +			schedule();
>
> This will be total pain to backtrack after a while when something
> needs to be changed so there definitely should be inline comments
> addressing each branch condition.
>
> I'd rethink this as:
>
> 1. Create static __sgx_epc_cgroup_try_charge() for addressing single
>    iteration with the new "reclaim" parameter.
> 2. Add a new sgx_epc_group_try_charge_reclaim() function.
>
> There's a bit of redundancy with sgx_epc_cgroup_try_charge() and
> sgx_epc_cgroup_try_charge_reclaim() because both have almost the
> same loop calling internal __sgx_epc_cgroup_try_charge() with
> different parameters. That is totally acceptable.
>
> Please also add my suggested-by.
>
> BR, Jarkko
>
> BR, Jarkko
>
For #2:
The only caller of this function, sgx_alloc_epc_page(), has the same  
boolean which is passed into this this function.

If we separate it into sgx_epc_cgroup_try_charge() and  
sgx_epc_cgroup_try_charge_reclaim(), then the caller has to have the  
if/else branches. So separation here seems not help?


For #1:
If we don't do #2, It seems overkill at the moment for such a short  
function.

How about we add inline comments for each branch for now, and if later  
there are more branches and the function become too long we add  
__sgx_epc_cgroup_try_charge() as you suggested?

Thanks
Haitao

