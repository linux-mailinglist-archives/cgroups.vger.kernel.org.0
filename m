Return-Path: <cgroups+bounces-1815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC7860386
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9088B1C22B1D
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728126AFBE;
	Thu, 22 Feb 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cga+BYXO"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345F433DF;
	Thu, 22 Feb 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632772; cv=none; b=Q5aBLw9iwMAC/kxoXhNvecCgntiyUKKcsb104GZgtScSReLAzfZtn318BcTUQPAlLbyyx5MzQHWNRlNrD9E3e2B+XDCesWwEOG2IQJepCs0QKR0FXY05R4CrhGmVz0lJ2X30DKgpx41Ql9/WnMoHx/egebsiCi86bsdk2m5LqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632772; c=relaxed/simple;
	bh=i8/u9xhPU2lVCjj/SHrUZmjD2lyuTsv1TsWEngjmYRk=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=rfrlDofyp/mkIErePG12MuA8k5n9dG5iAauWVrbjvcg5ViZslpfsjLAoUA0Y2oFAjJUUfKJHtA2WU95YZOHWpgACFsOQxRqNi3nLw0/892LkptL6XbAgoz/r+nRby5vnCsIN5KHI7RhtwnNMLAaeoS0fxhHC1noXInR1yCFiO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cga+BYXO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708632771; x=1740168771;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=i8/u9xhPU2lVCjj/SHrUZmjD2lyuTsv1TsWEngjmYRk=;
  b=cga+BYXO6JyaSDEOh3kCbUiDKDXCSnAP4DBTFJm2X2/HrtE7WuE+y5Cm
   5eUl2Gmz2iZ6GMshFYwGQZlKK1zLmorBXgUn26TRZb2K453Xpew5KFlO0
   ZWTGz2jf171H+tPYuvklXb/CymTrTS0p++pxWvp1fnzTpfPG5+GjxEj7D
   1rRXlqu9ugNPK63OAunlWUg+8S3TmiLIkUuFAaQ4R3t5KO47k0n5YTmuD
   WxDGbk1pgPGVEP1Mxs8K7EekPgrIYVd2thc1asrWL/EqD1SYVWxAf+JhT
   qU3gwJuGEkEOhCRcd3uoCe+oBAiNJkAbb+gE/60/ez15066ohCOJvXcPE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3043840"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3043840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5591460"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Feb 2024 12:12:46 -0800
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
Date: Thu, 22 Feb 2024 14:12:45 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jj67xqlwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <bf21f955c1b56ef836ad03bc42d522b6d020edbf.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 21 Feb 2024 04:48:58 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2024-02-21 at 00:23 -0600, Haitao Huang wrote:
>> StartHi Kai
>> On Tue, 20 Feb 2024 03:52:39 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>> [...]
>> >
>> > So you introduced the work/workqueue here but there's no place which
>> > actually
>> > queues the work.  IMHO you can either:
>> >
>> > 1) move relevant code change here; or
>> > 2) focus on introducing core functions to reclaim certain pages from a
>> > given EPC
>> > cgroup w/o workqueue and introduce the work/workqueue in later patch.
>> >
>> > Makes sense?
>> >
>>
>> Starting in v7, I was trying to split the big patch, #10 in v6 as you  
>> and
>> others suggested. My thought process was to put infrastructure needed  
>> for
>> per-cgroup reclaim in the front, then turn on per-cgroup reclaim in [v9
>> 13/15] in the end.
>
> That's reasonable for sure.
>

Thanks for the confirmation :-)

>>
>> Before that, all reclaimables are tracked in the global LRU so really
>> there is no "reclaim certain pages from a  given EPC cgroup w/o  
>> workqueue"
>> or reclaim through workqueue before that point, as suggested in #2. This
>> patch puts down the implementation for both flows but neither used yet,  
>> as
>> stated in the commit message.
>
> I know it's not used yet.  The point is how to split patches to make  
> them more
> self-contain and easy to review.

I would think this patch already self-contained in that all are  
implementation of cgroup reclamation building blocks utilized later. But  
I'll try to follow your suggestions below to split further (would prefer  
not to merge in general unless there is strong reasons).

>
> For #2, sorry for not being explicit -- I meant it seems it's more  
> reasonable to
> split in this way:
>
> Patch 1)
>   a). change to sgx_reclaim_pages();

I'll still prefer this to be a separate patch. It is self-contained IMHO.
We were splitting the original patch because it was too big. I don't want  
to merge back unless there is a strong reason.

>   b). introduce sgx_epc_cgroup_reclaim_pages();

Ok.

>   c). introduce sgx_epc_cgroup_reclaim_work_func() (use a better name), 
>      which just takes an EPC cgroup as input w/o involving any  
> work/workqueue.

This is for the workqueue use only. So I think it'd be better be with  
patch #2 below?

>
> These functions are all related to how to implement reclaiming pages  
> from a
> given EPC cgroup, and they are logically related in terms of  
> implementation thus
> it's easier to be reviewed together.
>

This is pretty much the current patch + sgx_reclaim_pages() - workqueue.

> Then you just need to justify the design/implementation in  
> changelog/comments.
>

How about just do b) in patch #1, and state the new function is the  
building block and will be used for both direct and indirect reclamation?

> Patch 2)
>   - Introduce work/workqueue, and implement the logic to queue the work.
>
> Now we all know there's a function to reclaim pages for a given EPC  
> cgroup, then
> we can focus on when that is called, either directly or indirectly.
> 	

The try_charge() function will do both actually.
For indirect, it queue the work to the wq. For direct it just calls  
sgx_epc_cgroup_reclaim_pages().
That part is already in separate (I think self-contained) patch [v9,  
10/15].

So for this patch, I'll add  sgx_epc_cgroup_reclaim_work_func() and  
introduce work/workqueue so later work can be queued?

>>
>> #1 would force me go back and merge the patches again.
>
> I don't think so.  I am not asking to put all things together, but only  
> asking
> to split in better way (that I see).
>

Okay.

> You mentioned some function is "Scheduled by sgx_epc_cgroup_try_charge()  
> to
> reclaim pages", but I am not seeing any code doing that in this patch.   
> This
> needs fixing, either by moving relevant code here, or removing these  
> not-done-
> yet comments.
>

Yes. The comments will be fixed.

> For instance (I am just giving an example), if after review we found the
> queue_work() shouldn't be done in try_charge(), you will need to go back  
> to this
> patch and remove these comments.
>
> That's not the best way.  Each patch needs to be self-contained.
>
>>
>> Sorry I feel kind of lost on this whole thing by now. It seems so random
>> to me. Is there hard rules on this?
>
> See above.  I am only offering my opinion on how to split patches in  
> better way.
>

To be honest, the part I'm feeling most confusing is this  
self-contained-ness. It seems depend on how you look at things.

>>
>> I was hoping these statements would help reviewers on the flow of the
>> patches.
>>
>> At the end of [v9 04/15]:
>>
>> For now, the EPC cgroup simply blocks additional EPC allocation in
>> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
>> still tracked in the global active list, only reclaimed by the global
>> reclaimer when the total free page count is lower than a threshold.
>>
>> Later patches will reorganize the tracking and reclamation code in the
>> global reclaimer and implement per-cgroup tracking and reclaiming.
>>
>> At the end of [v9 06/15]:
>>
>> Next patches will first get the cgroup reclamation flow ready while
>> keeping pages tracked in the global LRU and reclaimed by ksgxd before we
>> make the switch in the end for sgx_lru_list() to return per-cgroup
>> LRU.
>>
>> At the end of [v9 08/15]:
>>
>> Both synchronous and asynchronous flows invoke the same top level  
>> reclaim
>> function, and will be triggered later by sgx_epc_cgroup_try_charge()
>> when usage of the cgroup is at or near its limit.
>>
>> At the end of [v9 10/15]:
>> Note at this point, all reclaimable EPC pages are still tracked in the
>> global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
>> is activated yet.
>
> They are useful in the changelog in each patch I suppose, but to me we  
> are
> discussing different things.
>
> I found one pain in the review is I have to jump back and forth many  
> times among
> multiple patches to see whether one patch is reasonable.  That's why I  
> am asking
> whether there's better way to split patches so that each patch can be  
> self-
> contained logically in someway and easier to review.
>

I appreciate very much your time and effort on providing detailed review.  
You have been very helpful.
If you think it makes sense, I'll split this patch into 2 with stated  
modifications above.

Thanks
Haitao

