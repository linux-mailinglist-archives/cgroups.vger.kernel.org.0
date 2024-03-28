Return-Path: <cgroups+bounces-2215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5C88F3AE
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B194E1C21A28
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5B849C;
	Thu, 28 Mar 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjIohUff"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA832BA4D;
	Thu, 28 Mar 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585485; cv=none; b=Q3UW/lxh/792+NGzw73mNnh4t4gxvx7piUgPujgSEAuhpmcufxseHfzMRJwU6MobNk6DFNF6goAJaqT18ZDIVoDBHV1xI3kem0fvUI0K/ZXCNIJuRVnWUzsPKBdY/QSRp32JEo0EI999MrNDHfqolvPZ8N7SUMZYG0zSEjCh/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585485; c=relaxed/simple;
	bh=LTT3O9BblMVJnEDnyDTWBOO9zWxonJBv0EFHX9G/6vU=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=f7s9adMB3qt49dhq+yYllUw0cFHF5WYaEZEwjP50zKvT+0aAc14Eznv4rbeD3lBm5ZtXQodTlDWTUhZfl8sqq3URtC66FFMdI4RgwZxuBeYxxqz7VnlBHS1wxO93F1BSzt3BB9Ej/fPxfKxnDtIpEbFCv0bx0pDBZrCvTUvOQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjIohUff; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585484; x=1743121484;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LTT3O9BblMVJnEDnyDTWBOO9zWxonJBv0EFHX9G/6vU=;
  b=VjIohUffZHgy4WRynx9uJbeSUWAJF17MaJMnNFhX+QO28+Rv3arvHZ8K
   Plzn6Tofx3EfghQ+veQO1c5OHM+KTbISwm8juh62pZ1GQLvzMfQGcq/Q6
   lmD3vMY309kjbZJ9eQ4ocCnNDM1dBS+dJRr1sBv5oV+9qv7y4baXYpOo2
   WvA13/GKP2pkVY+GjfzueSbZQWWAxfQGNjoFtTiuxf3fpaSvRMb5RdWjX
   4MJBvz/Bay9eVYTDf6DBuF8wXlT6VNGmSzcqY5IVS/avL/6EKvanEHoji
   6CZ6CBBt+GX5wFwVBXPy1SV/wFXWO951BuDQn/Y8YxWRr9V/ATaylwyIy
   Q==;
X-CSE-ConnectionGUID: 2CAmkv2dR2Sp6G1sBEOyqA==
X-CSE-MsgGUID: IgYcyXy1Qt+MJ5oeG5xYrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6850708"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6850708"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="20985192"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Mar 2024 17:24:41 -0700
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
 <op.2jhao6nzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <bf21f955c1b56ef836ad03bc42d522b6d020edbf.camel@intel.com>
 <op.2jj67xqlwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aaaa54ed-7fd7-404c-853f-90f2e32ae004@intel.com>
Date: Wed, 27 Mar 2024 19:24:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lbh28nuwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <aaaa54ed-7fd7-404c-853f-90f2e32ae004@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 22 Feb 2024 16:24:47 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 23/02/2024 9:12 am, Haitao Huang wrote:
>> On Wed, 21 Feb 2024 04:48:58 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>>> On Wed, 2024-02-21 at 00:23 -0600, Haitao Huang wrote:
>>>> StartHi Kai
>>>> On Tue, 20 Feb 2024 03:52:39 -0600, Huang, Kai <kai.huang@intel.com>  
>>>> wrote:
>>>> [...]
>>>> >
>>>> > So you introduced the work/workqueue here but there's no place which
>>>> > actually
>>>> > queues the work.  IMHO you can either:
>>>> >
>>>> > 1) move relevant code change here; or
>>>> > 2) focus on introducing core functions to reclaim certain pages  
>>>> from a
>>>> > given EPC
>>>> > cgroup w/o workqueue and introduce the work/workqueue in later  
>>>> patch.
>>>> >
>>>> > Makes sense?
>>>> >
>>>>
>>>> Starting in v7, I was trying to split the big patch, #10 in v6 as you  
>>>> and
>>>> others suggested. My thought process was to put infrastructure needed  
>>>> for
>>>> per-cgroup reclaim in the front, then turn on per-cgroup reclaim in  
>>>> [v9
>>>> 13/15] in the end.
>>>
>>> That's reasonable for sure.
>>>
>>  Thanks for the confirmation :-)
>>
>>>>
>>>> Before that, all reclaimables are tracked in the global LRU so really
>>>> there is no "reclaim certain pages from a  given EPC cgroup w/o  
>>>> workqueue"
>>>> or reclaim through workqueue before that point, as suggested in #2.  
>>>> This
>>>> patch puts down the implementation for both flows but neither used  
>>>> yet, as
>>>> stated in the commit message.
>>>
>>> I know it's not used yet.  The point is how to split patches to make  
>>> them more
>>> self-contain and easy to review.
>>  I would think this patch already self-contained in that all are  
>> implementation of cgroup reclamation building blocks utilized later.  
>> But I'll try to follow your suggestions below to split further (would  
>> prefer not to merge in general unless there is strong reasons).
>>
>>>
>>> For #2, sorry for not being explicit -- I meant it seems it's more  
>>> reasonable to
>>> split in this way:
>>>
>>> Patch 1)
>>>   a). change to sgx_reclaim_pages();
>>  I'll still prefer this to be a separate patch. It is self-contained  
>> IMHO.
>> We were splitting the original patch because it was too big. I don't  
>> want to merge back unless there is a strong reason.
>>
>>>   b). introduce sgx_epc_cgroup_reclaim_pages();
>>  Ok.
>
> If I got you right, I believe you want to have a cgroup variant function  
> following the same behaviour of the one for global reclaim, i.e., the  
> _current_ sgx_reclaim_pages(), which always tries to scan and reclaim  
> SGX_NR_TO_SCAN pages each time.
>
> And this cgroup variant function, sgx_epc_cgroup_reclaim_pages(), tries  
> to scan and reclaim SGX_NR_TO_SCAN pages each time "_across_ the cgroup  
> and all the descendants".
>
> And you want to implement sgx_epc_cgroup_reclaim_pages() in this way due  
> to WHATEVER reasons.
>
> In that case, the change to sgx_reclaim_pages() and the introduce of  
> sgx_epc_cgroup_reclaim_pages() should really be together because they  
> are completely tied together in terms of implementation.
>
> In this way you can just explain clearly in _ONE_ patch why you choose  
> this implementation, and for reviewer it's also easier to review because  
> we can just discuss in one patch.
>
> Makes sense?
>
>>
>>>   c). introduce sgx_epc_cgroup_reclaim_work_func() (use a better  
>>> name),     which just takes an EPC cgroup as input w/o involving any  
>>> work/workqueue.
>>  This is for the workqueue use only. So I think it'd be better be with  
>> patch #2 below?
>
> There are multiple levels of logic here IMHO:
>
>    1. a) and b) above focus on "each reclaim" a given EPC cgroup
>    2. c) is about a loop of above to bring given cgroup's usage to limit
>    3. workqueue is one (probably best) way to do c) in async way
>    4. the logic where 1) (direct reclaim) and 3) (indirect) are triggered
>
> To me, it's clear 1) should be in one patch as stated above.
>
> Also, to me 3) and 4) are better to be together since they give you a  
> clear view on how the direct/indirect reclaim are triggered.
>
> 2) could be flexible depending on how you see it.  If you prefer viewing  
> it from low-level implementation of reclaiming pages from cgroup, then  
> it's also OK to be together with 1).  If you want to treat it as a part  
> of _async_ way of bring down usage to limit, then _MAYBE_ it's also OK  
> to be with 3) and 4).
>
> But to me 2) can be together with 1) or even a separate patch because  
> it's still kinda of low-level reclaiming details.  3) and 4) shouldn't  
> contain such detail but should focus on how direct/indirect reclaim is  
> done.

I incorporated most of your suggestions, and think it'd be better discuss  
this with actual code.

So I'm sending out v10, and just quickly summarize what I did to address  
this particular issue here.

I pretty much follow above suggestions and end up with two patches:

1) a) and b) above  plus direct reclaim triggered in try_charge() so  
reviewers can see at lease one use of the sgx_cgroup_reclaim_pages(),  
which is the basic building block.

2) All async related: c) above, workqueue, indirect triggered in  
try_charge() which queues the work.

Please review v10 and if you think the triggering parts need be separated  
then I'll separate.

Additionally, after more experimentation, I simplified sgx_reclaim_pages()  
by removing the pointer for *nr_to_scan as you suggested, but returning  
pages collected for isolation (attempted for reclaim) instead of pages  
actually reclaimed. I found performance is acceptable with this approach.

Thanks again for your review.
Haitao

