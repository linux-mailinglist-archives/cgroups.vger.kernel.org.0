Return-Path: <cgroups+bounces-1801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B285FF30
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A25B25EB9
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B8153BEF;
	Thu, 22 Feb 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+GpiTg5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9719478;
	Thu, 22 Feb 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622450; cv=none; b=d+3W7qMKNnb3vH5oDwNttQrJUjnatd95um9YigSU1FuRSNjJfyhGnIKEDRB6jrWmh+MmQl6G110njp6+wTDSG97rZ42WOmTDX1AYRg2P/gtAxJ9z+pFdLmHcpTcqyFZH1RF+dQeSO/czVfyh73Aay3Y1+TtWUGoQ/SYdpcloYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622450; c=relaxed/simple;
	bh=tFbfNPZA+03qEJrO/W2/DwnCMP36XNB72UEAWEXa9b4=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=SEaxnegbnB1yA6gJfcsosL9lHxW8ECLC5eOQT6kUldjA4nkjIoIlJxcBD/J0Lo6ND1jF+kdReLbMJTObgfD13JNb5lOijDa4He5ITYOYEvdoSVfaA2LkFKDKRCKcpCFtYptXpAN4gjMu5/1DmSiascqP4UBroapRHVnYnaRDN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+GpiTg5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708622449; x=1740158449;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=tFbfNPZA+03qEJrO/W2/DwnCMP36XNB72UEAWEXa9b4=;
  b=N+GpiTg532mCBUn14UGEF6i9/PZbwi4aRo3cjZeBgBYsBEOgH3yWHXJQ
   7e5MjK4ejx3H8pTEUpeV3Yh010snOuxLmIPSuXTk2zS9sU2mbzp5gSdx0
   UjNR+KPguuydEMJrF5wCGdvWMQUS/+Gh1EAI603ebyVnx9YIF1RTdGZBl
   xUqv9F9/gp10She2kaCDc27qsF57/CLCX+CNKmdBEZ4ls1ate3M1nPbEP
   QO4Qw0E0E36keOldvNX9r7UxcNlUizypBdo31yQjxCKtvFm74EIgG9P4J
   vdvlZ7z4xLxCoiSHzEqmUfXDuMifgdmW50TbkPV0uz7cXjNYorwri71yQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3016210"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3016210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5495059"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 09:20:38 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org"
 <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
 <op.2jhbnui0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d4aacbea13f0ff03ad94c31a4735746aedd009ba.camel@intel.com>
Date: Thu, 22 Feb 2024 11:20:37 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jjzsnz0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d4aacbea13f0ff03ad94c31a4735746aedd009ba.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 21 Feb 2024 05:00:27 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2024-02-21 at 00:44 -0600, Haitao Huang wrote:
>> [...]
>> >
>> > Here the @nr_to_scan is reduced by the number of pages that are
>> > isolated, but
>> > not actually reclaimed (which is reflected by @cnt).
>> >
>> > IIUC, looks you want to make this function do "each cycle" as what you
>> > mentioned
>> > in the v8 [1]:
>> >
>> > 	I tested with that approach and found we can only target number of
>> > pages
>> > 	attempted to reclaim not pages actually reclaimed due to the
>> > uncertainty
>> > 	of how long it takes to reclaim pages. Besides targeting number of
>> > 	scanned pages for each cycle is also what the ksgxd does.
>> >
>> > 	If we target actual number of pages, sometimes it just takes too  
>> long.
>> > I
>> > 	saw more timeouts with the default time limit when running parallel
>> > 	selftests.
>> >
>> > I am not sure what does "sometimes it just takes too long" mean, but
>> > what I am
>> > thinking is you are trying to do some perfect but yet complicated code
>> > here.
>>
>> I think what I observed was that the try_charge() would block too long
>> before getting chance of schedule() to yield, causing more timeouts than
>> necessary.
>> I'll do some re-test to be sure.
>
> Looks this is a valid information that can be used to justify whatever  
> you are
> implementing in the EPC cgroup reclaiming function(s).
>
I'll add some comments. Was assuming this is just following the old design  
as ksgxd.
There were some comments at the beginning of  
sgx_epc_cgrooup_reclaim_page().
         /*
          * Attempting to reclaim only a few pages will often fail and is
          * inefficient, while reclaiming a huge number of pages can result  
in
          * soft lockups due to holding various locks for an extended  
duration.
          */
         unsigned int nr_to_scan = SGX_NR_TO_SCAN;

I think it can be improved to emphasize we only "attempt" to finish  
scanning fixed number of pages for reclamation, not enforce number of  
pages successfully reclaimed.

>>
>> >
>> > For instance, I don't think selftest reflect the real workload, and I
>> > believe
>> > adjusting the limit of a given EPC cgroup shouldn't be a frequent
>> > operation,
>> > thus it is acceptable to use some easy-maintain code but less perfect
>> > code.
>> >
>> > Here I still think having @nr_to_scan as a pointer is  
>> over-complicated.
>> > For
>> > example, we can still let sgx_reclaim_pages() to always scan
>> > SGX_NR_TO_SCAN
>> > pages, but give up when there's enough pages reclaimed or when the EPC
>> > cgroup
>> > and its descendants have been looped:
>> >
>> > unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
>> > {
>> > 	unsigned int cnt = 0;
>> > 	...
>> >
>> > 	css_for_each_descendant_pre(pos, css_root) {
>> > 		...
>> > 		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
>> > 		cnt += sgx_reclaim_pages(&epc_cg->lru);
>> >
>> > 		if (cnt >= SGX_NR_TO_SCAN)
>> > 			break;
>> > 	}
>> >
>> > 	...
>> > 	return cnt;
>> > }
>> >
>> > Yeah it may reclaim more than SGX_NR_TO_SCAN when the loop actually
>> > reaches any
>> > descendants, but that should be rare and we don't care that much, do  
>> we?
>> >
>> I assume you meant @cnt here to be number of pages actually reclaimed.
>
> Yes.
>
>> This could cause  sgx_epc_cgroup_reclaim_pages() block too long as @cnt
>> may always be zero (all pages are too young) and you have to loop all
>> descendants.
>
> I am not sure whether this is a valid point.
>
> For example, your change in patch 10 "x86/sgx: Add EPC reclamation in  
> cgroup
> try_charge()" already loops all descendants in below code:
>
> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
> +			return -ENOMEM;
>

I meant looping all descendants for reclamation which is expensive and we  
want to avoid. Not just checking emptiness of LRUs.

> Anyway, I can see all these can be justification to your  
> design/implementation.
> My point is please put these justification in changelog/comments so that  
> we can
> actually understand.
>
Yes, will add clarifying comments.
Thanks

