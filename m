Return-Path: <cgroups+bounces-915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13F80E328
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 05:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F2B1F220FF
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CFC14F;
	Tue, 12 Dec 2023 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORcbUu8I"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C5AC;
	Mon, 11 Dec 2023 20:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702353895; x=1733889895;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=EZsAjnStfKB44Ifyc24Fa9TmkQVR305sJi88MLW8gYM=;
  b=ORcbUu8IYw3kXRv4vtJdOKI2KKJYT8kR7vEOd0KD2lhD0RzOFSs+baOh
   eJoGYlaMiPo8T+cA5es/h4wcKIn7e2a9YJ1NVLMDGTvzE5L6ZofTCCRfv
   HsoXM5dHCvgpTvbbYr7gVx/EqAowFXAkwkzdXbat5KrmKqumWFoUo0hrl
   1ADTPfncaWLlXd8V+gNEcxNnDLOjtRbn4MVRQDFdEExHiCyMfERZmzaPR
   VhPC5w4OxvYbwjsr4/EsJ9vu4el2VppBMtVt5th/49gE8T2k+FbyteqEi
   RE6E7qfEbEJsHZUp/CZdTDMEX5YysdyK01oCASAy8SZAO04Oz/aotdVdv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="385162853"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="385162853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 20:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="14796766"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.162.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 11 Dec 2023 20:04:52 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Huang,
 Kai" <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
Date: Mon, 11 Dec 2023 22:04:48 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Kai

On Mon, 27 Nov 2023 03:57:03 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-11-27 at 00:27 +0800, Haitao Huang wrote:
>> On Mon, 20 Nov 2023 11:45:46 +0800, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Mon, 2023-10-30 at 11:20 -0700, Haitao Huang wrote:
>> > > From: Sean Christopherson <sean.j.christopherson@intel.com>
>> > >
>> > > To prepare for per-cgroup reclamation, separate the top-level  
>> reclaim
>> > > function, sgx_reclaim_epc_pages(), into two separate functions:
>> > >
>> > > - sgx_isolate_epc_pages() scans and isolates reclaimable pages from  
>> a
>> > > given LRU list.
>> > > - sgx_do_epc_reclamation() performs the real reclamation for the
>> > > already isolated pages.
>> > >
>> > > Create a new function, sgx_reclaim_epc_pages_global(), calling  
>> those two
>> > > in succession, to replace the original sgx_reclaim_epc_pages(). The
>> > > above two functions will serve as building blocks for the  
>> reclamation
>> > > flows in later EPC cgroup implementation.
>> > >
>> > > sgx_do_epc_reclamation() returns the number of reclaimed pages. The  
>> EPC
>> > > cgroup will use the result to track reclaiming progress.
>> > >
>> > > sgx_isolate_epc_pages() returns the additional number of pages to  
>> scan
>> > > for current epoch of reclamation. The EPC cgroup will use the  
>> result to
>> > > determine if more scanning to be done in LRUs in its children  
>> groups.
>> >
>> > This changelog says nothing about "why", but only mentions the
>> > "implementation".
>> >
>> > For instance, assuming we need to reclaim @npages_to_reclaim from the
>> > @epc_cgrp_to_reclaim and its descendants, why cannot we do:
>> >
>> > 	for_each_cgroup_and_descendants(&epc_cgrp_to_reclaim, &epc_cgrp) {
>> > 		if (npages_to_reclaim <= 0)
>> > 			return;
>> >
>> > 		npages_to_reclaim -= sgx_reclaim_pages_lru(&epc_cgrp->lru,
>> > 					npages_to_reclaim);
>> > 	}
>> >
>> > Is there any difference to have "isolate" + "reclaim"?
>> >
>>
>> This is to optimize "reclaim". See how etrack was done in sgx_encl_ewb.
>> Here we just follow the same design as ksgxd for each reclamation cycle.
>
> I don't see how did you "follow" ksgxd.  If I am guessing correctly, you  
> are
> afraid of there might be less than 16 pages in a given EPC cgroup, thus  
> w/o
> splitting into "isolate" + "reclaim" you might feed the "reclaim" less  
> than 16
> pages, which might cause some performance degrade?
>
> But is this a common case?  Should we even worry about this?
>
> I suppose for such new feature we should bring functionality first and  
> then
> optimization if you have real performance data to show.
>
The concern is not about "reclaim less than 16".
I mean this is just refactoring with exactly the same design of ksgxd  
preserved, in that we first isolate as many candidate EPC pages (up  to  
16, ignore the unneeded SGX_NR_TO_SCAN_MAX for now), then does the ewb in  
one shot without anything else done in between. As described in original  
comments for the function sgx_reclaim_pages and sgx_encl_ewb, this is to  
finish all ewb quickly while minimizing impact of IPI.

The way you proposed will work but alters the current design and behavior  
if cgroups is enabled and EPCs of an enclave are tracked across multiple  
LRUs within the descendant cgroups, in that you will have isolation loop,  
backing store allocation loop, eblock loop interleaved with the ewb loop.

>>
>> > >
>> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> > > Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > > Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > > Cc: Sean Christopherson <seanjc@google.com>
>> > > ---
>> > >
>> >
>> > [...]
>> >
>> > > +/**
>> > > + * sgx_do_epc_reclamation() - Perform reclamation for isolated EPC
>> > > pages.
>> > > + * @iso:		List of isolated pages for reclamation
>> > > + *
>> > > + * Take a list of EPC pages and reclaim them to the enclave's  
>> private
>> > > shmem files.  Do not
>> > > + * reclaim the pages that have been accessed since the last scan,  
>> and
>> > > move each of those pages
>> > > + * to the tail of its tracking LRU list.
>> > > + *
>> > > + * Limit the number of pages to be processed up to  
>> SGX_NR_TO_SCAN_MAX
>> > > per call in order to
>> > > + * degrade amount of IPI's and ETRACK's potentially required.
>> > > sgx_encl_ewb() does degrade a bit
>> > > + * among the HW threads with three stage EWB pipeline (EWB, ETRACK  
>> +
>> > > EWB and IPI + EWB) but not
>> > > + * sufficiently. Reclaiming one page at a time would also be
>> > > problematic as it would increase
>> > > + * the lock contention too much, which would halt forward progress.
>> >
>> > This is kinda optimization, correct?  Is there any real performance  
>> data
>> > to
>> > justify this?
>>
>> The above sentences were there originally. This optimization was  
>> justified.
>
> I am talking about 16 -> 32.
>
>>
>> > If this optimization is useful, shouldn't we bring this
>> > optimization to the current sgx_reclaim_pages() instead, e.g., just
>> > increase
>> > SGX_NR_TO_SCAN (16) to SGX_NR_TO_SCAN_MAX (32)?
>> >
>>
>> SGX_NR_TO_SCAN_MAX might be designed earlier for other reasons I don't
>> know. Currently it is really the buffer size allocated in
>> sgx_reclaim_pages(). Both cgroup and ksgxd scan 16 pages a time.Maybe we
>> should just use SGX_NR_TO_SCAN. No _MAX needed. The point was to batch
>> reclamation to certain number to minimize impact of EWB pipeline. 16 was
>> the original design.
>>
>
> Please don't leave why you are trying to do this to the reviewers.  If  
> you don't
> know, then just drop this.
>

Fair enough. This was my oversight when doing all the changes and rebase.  
Will drop it.

Thanks
Haitao

