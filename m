Return-Path: <cgroups+bounces-1694-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1485A736
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929F11C2164D
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5438389;
	Mon, 19 Feb 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqPfRZHw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBB38F83;
	Mon, 19 Feb 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355884; cv=none; b=R+afVvmBCRgH4jjQWVi0cakcqKSNaFo9sGpX7+kKtYkHD7uUITUSsRpO6XQXHX2th+UYHon5iCVjti5cLhdm+f4O9zrfuBLy+TFy/xpZ8oaowfDTgbynXr3oJyVODrY1uptoyBe/rPEFHuRf1+x7Mdrlxqi7PSKyVJ/1KS7fvQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355884; c=relaxed/simple;
	bh=ZhWmkh/IIQkwD8dcKNirzjh2xpN1uEDAcdNeim0Gh5E=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=UOb4qfB+/pnFXpkhwLBsMz84d6JiOVvKiUrXO/yozAJJNxJhILPNXr6XaiUlnuaSUJyB+0j/MDYyPH/cDL1XLGCrDyMFEOAy9d0nv/YzZoL3p03cTEZcPv/+AEl2qbK2QgPViHF4E7o3LV0W7/I/YVQ+W2cswFsYaPjlJn9Zpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqPfRZHw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355883; x=1739891883;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=ZhWmkh/IIQkwD8dcKNirzjh2xpN1uEDAcdNeim0Gh5E=;
  b=iqPfRZHwJidugWJHOK72J/yha3xY+BrX28PNDiSyyEP3XkOVYPumHrpl
   a+4CRxzu2X9r/cJ5Wa3cyKsa9y8gnAqKInlqK75IVvTPm0iPOYxVMGLm3
   8KfyS9Ls8+SONLbbrurQZoFR1shwQoaPZJJ3V3iTdAEWyUfUMBrHrproU
   l5pzNOTj/VYo6AaYlTYpmic+rzhBx0Peu4fK1B2GPjelSX7zbj7HYgjgC
   7W4Zxe2bizM2HnvbiEY4tvi2TDgU77jHfbqQb9VvMFRIc6Hj0jJhPQqxu
   9gihgFeIYArPzLiT3IX0DnM2CHLaln2O7BYXcMKkTdRcdi+oEdrbC+sCG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2548280"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2548280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936303679"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936303679"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 19 Feb 2024 07:12:54 -0800
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
 <op.2i1xkgedwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
Date: Mon, 19 Feb 2024 09:12:51 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jd9vpf0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 13 Feb 2024 19:52:25 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Feb 13, 2024 at 1:15 AM EET, Haitao Huang wrote:
>> Hi Jarkko
>>
>> On Mon, 12 Feb 2024 13:55:46 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
>> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>> >>
>> >> When the EPC usage of a cgroup is near its limit, the cgroup needs to
>> >> reclaim pages used in the same cgroup to make room for new  
>> allocations.
>> >> This is analogous to the behavior that the global reclaimer is  
>> triggered
>> >> when the global usage is close to total available EPC.
>> >>
>> >> Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
>> >> whether synchronous reclaim is allowed or not. And trigger the
>> >> synchronous/asynchronous reclamation flow accordingly.
>> >>
>> >> Note at this point, all reclaimable EPC pages are still tracked in  
>> the
>> >> global LRU and per-cgroup LRUs are empty. So no per-cgroup  
>> reclamation
>> >> is activated yet.
>> >>
>> >> Co-developed-by: Sean Christopherson  
>> <sean.j.christopherson@intel.com>
>> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> >> ---
>> >> V7:
>> >> - Split this out from the big patch, #10 in V6. (Dave, Kai)
>> >> ---
>> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
>> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
>> >>  arch/x86/kernel/cpu/sgx/main.c       |  2 +-
>> >>  3 files changed, 27 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> >> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> >> index d399fda2b55e..abf74fdb12b4 100644
>> >> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> >> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> >> @@ -184,13 +184,35 @@ static void
>> >> sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
>> >>  /**
>> >>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single  
>> EPC
>> >> page
>> >>   * @epc_cg:	The EPC cgroup to be charged for the page.
>> >> + * @reclaim:	Whether or not synchronous reclaim is allowed
>> >>   * Return:
>> >>   * * %0 - If successfully charged.
>> >>   * * -errno - for failures.
>> >>   */
>> >> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>> >> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool
>> >> reclaim)
>> >>  {
>> >> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,  
>> PAGE_SIZE);
>> >> +	for (;;) {
>> >> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>> >> +					PAGE_SIZE))
>> >> +			break;
>> >> +
>> >> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>> >> +			return -ENOMEM;
>> >> + +		if (signal_pending(current))
>> >> +			return -ERESTARTSYS;
>> >> +
>> >> +		if (!reclaim) {
>> >> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>> >> +			return -EBUSY;
>> >> +		}
>> >> +
>> >> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
>> >> +			/* All pages were too young to reclaim, try again a little later  
>> */
>> >> +			schedule();
>> >
>> > This will be total pain to backtrack after a while when something
>> > needs to be changed so there definitely should be inline comments
>> > addressing each branch condition.
>> >
>> > I'd rethink this as:
>> >
>> > 1. Create static __sgx_epc_cgroup_try_charge() for addressing single
>> >    iteration with the new "reclaim" parameter.
>> > 2. Add a new sgx_epc_group_try_charge_reclaim() function.
>> >
>> > There's a bit of redundancy with sgx_epc_cgroup_try_charge() and
>> > sgx_epc_cgroup_try_charge_reclaim() because both have almost the
>> > same loop calling internal __sgx_epc_cgroup_try_charge() with
>> > different parameters. That is totally acceptable.
>> >
>> > Please also add my suggested-by.
>> >
>> > BR, Jarkko
>> >
>> > BR, Jarkko
>> >
>> For #2:
>> The only caller of this function, sgx_alloc_epc_page(), has the same
>> boolean which is passed into this this function.
>
> I know. This would be good opportunity to fix that up. Large patch
> sets should try to make the space for its feature best possible and
> thus also clean up the code base overally.
>
>> If we separate it into sgx_epc_cgroup_try_charge() and
>> sgx_epc_cgroup_try_charge_reclaim(), then the caller has to have the
>> if/else branches. So separation here seems not help?
>
> Of course it does. It makes the code in that location self-documenting
> and easier to remember what it does.
>
> BR, Jarkko
>

Please let me know if this aligns with your suggestion.


static int ___sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
{
         if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
                                         PAGE_SIZE))
                 return 0;

         if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
                 return -ENOMEM;

         if (signal_pending(current))
                 return -ERESTARTSYS;

         return -EBUSY;
}

/**
  * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single page
  * @epc_cg:     The EPC cgroup to be charged for the page.
  *
  * Try to reclaim pages in the background if the group reaches its limit  
and
  * there are reclaimable pages in the group.
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
{
         int ret =  ___sgx_epc_cgroup_try_charge(epc_cg);

         if (ret == -EBUSY)
                 queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);

         return ret;
}

/**
  * sgx_epc_cgroup_try_charge_reclaim() - try to charge cgroup for a single  
page
  * @epc_cg:     The EPC cgroup to be charged for the page.
  *
  * Try to reclaim pages directly if the group reaches its limit and there  
are
  * reclaimable pages in the group.
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
int sgx_epc_cgroup_try_charge_reclaim(struct sgx_epc_cgroup *epc_cg)
{
         int ret;

         for (;;) {
                 ret =  ___sgx_epc_cgroup_try_charge(epc_cg);
                 if (ret != -EBUSY)
                         return ret;

                 if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, current->mm))
                         /* All pages were too young to reclaim, try again  
a little later */
                         schedule();
         }

         return 0;
}

It is a little more involved to remove the boolean for  
sgx_alloc_epc_page() and its callers like sgx_encl_grow(),  
sgx_alloc_va_page(). I'll send a separate patch for comments.

Thanks
Haitao

