Return-Path: <cgroups+bounces-977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE9817C98
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 22:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42FD1C22389
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBEF740A2;
	Mon, 18 Dec 2023 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8Ubogei"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AA42361;
	Mon, 18 Dec 2023 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702934688; x=1734470688;
  h=cc:references:subject:to:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=mqgrmvBtHedkNI0LE/BC0GzzPcNrQtoOXK9vjdIUqhg=;
  b=h8UbogeiEpkYDXFqU7b9QCXDUMy+31Q8LvGGzhz+1GcRdzOaIlqhpaYE
   uhmIlKkoQZ4wLYzm0KUnjTVPPGR7VOIlcobTeji1WYGnK64brPiqOwDe7
   yZe3M83KxDB/kKF+EZ/7cQWXFvnMrUVEKvOWCS4OmZYemnT0BEfyER7UH
   5rgtzl7ky/oQ9ax1zeJJzmYck6xizD7/LPs35fSaueVeQGSBOzLiFNz0i
   3Q1YYa7AwZb1AXdSC2jbeh8wq8Bixq1SlRYeV+xv/IGA0KOueTodnFaK7
   Mr5WWwxGsYJd24+dG7F6rJ2tyhHXP8d8IDJjgcMghQDhcTZAVYYbOC2PF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="9015487"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="9015487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="725479292"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="725479292"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.145.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Dec 2023 13:24:44 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
 <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Date: Mon, 18 Dec 2023 15:24:40 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Sun, 17 Dec 2023 19:44:56 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>> >
>> > The point is, with or w/o this patch, you can only reclaim 16 EPC  
>> pages
>> > in one
>> > function call (as you have said you are going to remove
>> > SGX_NR_TO_SCAN_MAX,
>> > which is a cipher to both of us).  The only difference I can see is,
>> > with this
>> > patch, you can have multiple calls of "isolate" and then call the
>> > "do_reclaim"
>> > once.
>> >
>> > But what's the good of having the "isolate" if the "do_reclaim" can  
>> only
>> > reclaim
>> > 16 pages anyway?
>> >
>> > Back to my last reply, are you afraid of any LRU has less than 16  
>> pages
>> > to
>> > "isolate", therefore you need to loop LRUs of descendants to get 16?
>> > Cause I
>> > really cannot think of any other reason why you are doing this.
>> >
>> >
>>
>> I think I see your point. By capping pages reclaimed per cycle to 16,
>> there is not much difference even if those 16 pages are spread in  
>> separate
>> LRUs . The difference is only significant when we ever raise that cap.  
>> To
>> preserve the current behavior of ewb loops independent on number of LRUs
>> to loop through for each reclaiming cycle, regardless of the exact value
>> of the page cap, I would still think current approach in the patch is
>> reasonable choice.  What do you think?
>
> To me I won't bother to do that.  Having less than 16 pages in one LRU is
> *extremely rare* that should never happen in practice.  It's pointless  
> to make
> such code adjustment at this stage.
>
> Let's focus on enabling functionality first.  When you have some real
> performance issue that is related to this, we can come back then.
>
> Btw, I think you need to step back even further.  IIUC the whole  
> multiple LRU
> thing isn't mandatory in this initial support.
>
> Please (again) take a look at the comments from Dave and Michal:
>
> https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com/#t
> https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3/

Thanks for raising this. Actually my understanding the above discussion  
was mainly about not doing reclaiming by killing enclaves, i.e., I assumed  
"reclaiming" within that context only meant for that particular kind.

As Mikko pointed out, without reclaiming per-cgroup, the max limit of each  
cgroup needs to accommodate the peak usage of enclaves within that cgroup.  
That may be inconvenient for practical usage and limits could be forced to  
be set larger than necessary to run enclaves performantly. For example, we  
can observe following undesired consequences comparing a system with  
current kernel loaded with enclaves whose total peak usage is greater than  
the EPC capacity.

1) If a user wants to load the same exact enclaves but in separate  
cgroups, then the sum of cgroup limits must be higher than the capacity  
and the system will end up doing the same old global reclaiming as it is  
currently doing. Cgroup is not useful at all for isolating EPC  
consumptions.

2) To isolate impact of usage of each cgroup on other cgroups and yet  
still being able to load each enclave, the user basically has to carefully  
plan to ensure the sum of cgroup max limits, i.e., the sum of peak usage  
of enclaves, is not reaching over the capacity. That means no  
over-commiting allowed and the same system may not be able to load as many  
enclaves as with current kernel.

@Dave and @Michal, Your thoughts? Or could you confirm we should not do  
reclaim per cgroup at
all?

If confirmed as desired, then this series can stop at patch 4.

Thanks
Haitao

