Return-Path: <cgroups+bounces-967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE25815061
	for <lists+cgroups@lfdr.de>; Fri, 15 Dec 2023 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15450286E3A
	for <lists+cgroups@lfdr.de>; Fri, 15 Dec 2023 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8128E4185D;
	Fri, 15 Dec 2023 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkidRgrB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A14184B;
	Fri, 15 Dec 2023 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702669794; x=1734205794;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=WojIJ8tfQpeG1nk5JkrHEAkZCsPYyURIVgFsketY5C0=;
  b=JkidRgrBa8QHgnHogC5+Z611GrfrCg9h+Pye9LM1xElleevCjCgvOLE5
   yYiFhjNHLkLS96CM65LFFW9UpgrLZqFdf3VR8EirhwVDuc344N1YGDB1q
   q/JBsW/CWYeaXTIGyjcV3oHwGn354O3Z4LsWcKA63Zc+vDjwfeumUinYE
   enVeC2hCAlzfV6xZArpopN89lfdzZl3aZDKAC3+UL7x2DX0poHMz7JYwF
   HrK7wD7rrOsVw6xnR8o6N6xC/eKx88mwmdDfBZS43PjrEco+3axjsj6vY
   n5Y6mEoLM3p/293i/qGCL75QwCnN2UhB5Oo3oeG6QPivJtORrZ40SzDTa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2143110"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2143110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840774022"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840774022"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.162.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Dec 2023 11:49:51 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
Date: Fri, 15 Dec 2023 13:49:46 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 13 Dec 2023 05:17:11 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-12-11 at 22:04 -0600, Haitao Huang wrote:
>> Hi Kai
>>
>> On Mon, 27 Nov 2023 03:57:03 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Mon, 2023-11-27 at 00:27 +0800, Haitao Huang wrote:
>> > > On Mon, 20 Nov 2023 11:45:46 +0800, Huang, Kai <kai.huang@intel.com>
>> > > wrote:
>> > >
>> > > > On Mon, 2023-10-30 at 11:20 -0700, Haitao Huang wrote:
>> > > > > From: Sean Christopherson <sean.j.christopherson@intel.com>
>> > > > >
>> > > > > To prepare for per-cgroup reclamation, separate the top-level
>> > > reclaim
>> > > > > function, sgx_reclaim_epc_pages(), into two separate functions:
>> > > > >
>> > > > > - sgx_isolate_epc_pages() scans and isolates reclaimable pages  
>> from
>> > > a
>> > > > > given LRU list.
>> > > > > - sgx_do_epc_reclamation() performs the real reclamation for the
>> > > > > already isolated pages.
>> > > > >
>> > > > > Create a new function, sgx_reclaim_epc_pages_global(), calling
>> > > those two
>> > > > > in succession, to replace the original sgx_reclaim_epc_pages().  
>> The
>> > > > > above two functions will serve as building blocks for the
>> > > reclamation
>> > > > > flows in later EPC cgroup implementation.
>> > > > >
>> > > > > sgx_do_epc_reclamation() returns the number of reclaimed pages.  
>> The
>> > > EPC
>> > > > > cgroup will use the result to track reclaiming progress.
>> > > > >
>> > > > > sgx_isolate_epc_pages() returns the additional number of pages  
>> to
>> > > scan
>> > > > > for current epoch of reclamation. The EPC cgroup will use the
>> > > result to
>> > > > > determine if more scanning to be done in LRUs in its children
>> > > groups.
>> > > >
>> > > > This changelog says nothing about "why", but only mentions the
>> > > > "implementation".
>> > > >
>> > > > For instance, assuming we need to reclaim @npages_to_reclaim from  
>> the
>> > > > @epc_cgrp_to_reclaim and its descendants, why cannot we do:
>> > > >
>> > > > 	for_each_cgroup_and_descendants(&epc_cgrp_to_reclaim, &epc_cgrp)  
>> {
>> > > > 		if (npages_to_reclaim <= 0)
>> > > > 			return;
>> > > >
>> > > > 		npages_to_reclaim -= sgx_reclaim_pages_lru(&epc_cgrp->lru,
>> > > > 					npages_to_reclaim);
>> > > > 	}
>> > > >
>> > > > Is there any difference to have "isolate" + "reclaim"?
>> > > >
>> > >
>> > > This is to optimize "reclaim". See how etrack was done in  
>> sgx_encl_ewb.
>> > > Here we just follow the same design as ksgxd for each reclamation  
>> cycle.
>> >
>> > I don't see how did you "follow" ksgxd.  If I am guessing correctly,  
>> you
>> > are
>> > afraid of there might be less than 16 pages in a given EPC cgroup,  
>> thus
>> > w/o
>> > splitting into "isolate" + "reclaim" you might feed the "reclaim" less
>> > than 16
>> > pages, which might cause some performance degrade?
>> >
>> > But is this a common case?  Should we even worry about this?
>> >
>> > I suppose for such new feature we should bring functionality first and
>> > then
>> > optimization if you have real performance data to show.
>> >
>> The concern is not about "reclaim less than 16".
>> I mean this is just refactoring with exactly the same design of ksgxd
>> preserved,
>
> I literally have no idea what you are talking about here.  ksgxd() just  
> calls
> sgx_reclaim_pages(), which tries to reclaim 16 pages at once.
>
>> in that we first isolate as many candidate EPC pages (up  to
>> 16, ignore the unneeded SGX_NR_TO_SCAN_MAX for now), then does the ewb  
>> in
>> one shot without anything else done in between.
>
> Assuming you are referring the implementation of sgx_reclaim_pages(), and
> assuming the "isolate" you mean removing EPC pages from the list (which  
> is
> exactly what the sgx_isolate_epc_pages() in this patch does), what  
> happens to
> the loops of "backing store allocation" and "EBLOCK", before the loop of  
> EWB?Eaten by you?
>

I skipped those as what really matters is to keep ewb loop separate and  
run in one shot for each reclaiming cycle, not dependent on number of  
LRUs.  All those loops in original sgx_reclaim_pages() except the  
"isolate" loop are not dealing with multiple LRUs of cgroups later. That's  
the reason to refactor out only the "isolate" part and loop it through  
cgroup LRUs in later patches.

>
>> As described in original
>> comments for the function sgx_reclaim_pages and sgx_encl_ewb, this is to
>> finish all ewb quickly while minimizing impact of IPI.
>>
>> The way you proposed will work but alters the current design and  
>> behavior
>> if cgroups is enabled and EPCs of an enclave are tracked across multiple
>> LRUs within the descendant cgroups, in that you will have isolation  
>> loop,
>> backing store allocation loop, eblock loop interleaved with the ewb  
>> loop.
>>
>
> I have no idea what you are talking about.
>
> The point is, with or w/o this patch, you can only reclaim 16 EPC pages  
> in one
> function call (as you have said you are going to remove  
> SGX_NR_TO_SCAN_MAX,
> which is a cipher to both of us).  The only difference I can see is,  
> with this
> patch, you can have multiple calls of "isolate" and then call the  
> "do_reclaim"
> once.
>
> But what's the good of having the "isolate" if the "do_reclaim" can only  
> reclaim
> 16 pages anyway?
>
> Back to my last reply, are you afraid of any LRU has less than 16 pages  
> to
> "isolate", therefore you need to loop LRUs of descendants to get 16?   
> Cause I
> really cannot think of any other reason why you are doing this.
>
>

I think I see your point. By capping pages reclaimed per cycle to 16,  
there is not much difference even if those 16 pages are spread in separate  
LRUs . The difference is only significant when we ever raise that cap. To  
preserve the current behavior of ewb loops independent on number of LRUs  
to loop through for each reclaiming cycle, regardless of the exact value  
of the page cap, I would still think current approach in the patch is  
reasonable choice.  What do you think?

Thanks
Haitao

