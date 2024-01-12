Return-Path: <cgroups+bounces-1132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515382C43F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972201C21B1B
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEBA1B5B2;
	Fri, 12 Jan 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmrZENUA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978341B5A9;
	Fri, 12 Jan 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705079237; x=1736615237;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=lVmLUUBkp05h2vMdn58ewf7e0YEyAXxfLddo9iW6Lgw=;
  b=bmrZENUAMQ0inyns7F+XJ9Q7m+RHtjHaUwYqgmfoAXFUHzZq5vwkcdYq
   o7DDELLD+5s6rqUx+UsL/MgVyOKqw6WYbhgqAke5aX3Gi8XGjkPrcccUL
   LxkBQJm42C8W+zYixd2D7rgDj34LAnobUxgqxwAMyAnmunXzduvZrnd00
   N2CbP6yj6YPTr+RJX30CoRY6PJDRxRYPIZfWQs8h//sNuXYva8pkLkBBn
   vGkR9t0oMLYccEdu8/caP4EB5PhRnp+ILXnokR9nZ82+aLk+7VGMp3wl/
   MNcY6DDFDiNJfaB+7MTXICQUgRCIAl4YAcMsgzKWm8hKtKEKhlLjCt37/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12589161"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="12589161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 09:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="817129066"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="817129066"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.177.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 12 Jan 2024 09:07:13 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
 <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
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
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
Date: Fri, 12 Jan 2024 11:07:09 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2hf1t7sywjvjmi@hhuan26-mobl.amr.corp.intel.com>
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

I have done some rethinking about this and realize this does save quite  
some significant work: without breaking out isolation part from  
sgx_reclaim_pages(), I can remove the changes to use a list for isolated  
pages, and no need to introduce "state" such as RECLAIM_IN_PROGRESS. About  
1/3 of changes for per-cgroup reclamation will be gone.

So I think I'll go this route now. The only downside may be performance if  
a enclave spreads its pages in different cgroups and even that is minimum  
impact as we limit reclamation to 16 pages a time. Let me know if someone  
feel strongly we need dealt with that and see some other potential issues  
I may have missed.

Thanks

Haitao

