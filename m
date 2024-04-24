Return-Path: <cgroups+bounces-2684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3E8AFD4A
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 02:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EEF1C21D78
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 00:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96047FF;
	Wed, 24 Apr 2024 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/6SaNRk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A33363;
	Wed, 24 Apr 2024 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918382; cv=none; b=TwGwNi8wQoeg2OIoS81mmYeYdM39onANQTomWDiYNIEVZ+U+chXDRE2wBevWOjr6hXimW7uksks//n1aMvkCP6syU91xQciGrrioCdiQmrgM6EkiQ1NYY0Yu9uz5qkmMx8kWDkOA6U8HEynuX20/VRc5I4KShfY7Hlu7xEvTVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918382; c=relaxed/simple;
	bh=AuZge035jK1lr9CSiJ18H/bDqMTgmAXL4Ovt7rRbaQ0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=BXQJz2HIlYGBpi4qANJTxXN94hi/sI6mFmvUJYYA8qnFDaMM996c6m+niEeCS08NEoQGGRgQEi98uR7HJJflMOzrJQolK9XP8sVdO8lwQGhtpxmLkAUDgcBYfdz/geh6dh22d2m95OoPanFiP8LUF3/A35CNWFRNhEOe2SZmqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/6SaNRk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713918382; x=1745454382;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=AuZge035jK1lr9CSiJ18H/bDqMTgmAXL4Ovt7rRbaQ0=;
  b=T/6SaNRkjqgAydMTYixO/4Oil0/UKIZCx4pIBRxO+7I08afc/BQHI1mu
   gxv421xYl+LeTOjniWaqLq+TT3SAx+D40iJshjPMpytYosI+zBmIKeZ25
   5IZNqu6vMuP8VkEQym1CTkJbi+b8S5NfOccSZXu/KfLDyp+SowoRJ6Bg/
   O2BySMXadL2yhteJKB9bw+stZ/JaP2lMdBd+fvT7lmMlQhBKlej5snSG1
   ih9xHQQa8HDRgZ6bHOnN0/thSB5tBe7ZpBvxfgL+wwHOsdV7ByFDWKYJE
   MKHBCPw/OW6YIkP45gsww4J1semuIGHlFaWpSp89hXo6YY/50eYkMoulD
   g==;
X-CSE-ConnectionGUID: 6DJ6IAprQvOiRIUBjY/B6A==
X-CSE-MsgGUID: vRDgYvBgQXGmjOO8GlHWoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9638452"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9638452"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 17:26:22 -0700
X-CSE-ConnectionGUID: rW7drRa6RP+lp5kZnVykDA==
X-CSE-MsgGUID: Lr/lQ9SdSdyaE/UKq7ut8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24581795"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 23 Apr 2024 17:26:17 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-10-haitao.huang@linux.intel.com>
 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
 <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <914371bd0673870c03e5f4c37db5a2a08fc50aa4.camel@intel.com>
 <op.2momr8oewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <be1b1198e05a91b16677acf4037cd52519273529.camel@intel.com>
 <op.2motdpw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <bdae9afa3e1dd40fbaaf47ad720a57050dda0e72.camel@intel.com>
Date: Tue, 23 Apr 2024 19:26:15 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mph51towjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <bdae9afa3e1dd40fbaaf47ad720a57050dda0e72.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 23 Apr 2024 17:13:15 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Tue, 2024-04-23 at 10:30 -0500, Haitao Huang wrote:
>> > > It's a workaround because you use the capacity==0 but it does not  
>> really
>> > > mean to disable the misc cgroup for specific resource IIUC.
>> >
>> > Please read the comment around @misc_res_capacity again:
>> >
>> >   * Miscellaneous resources capacity for the entire machine. 0  
>> capacity
>> >   * means resource is not initialized or not present in the host.
>> >
>>
>> I mentioned this in earlier email. I think this means no SGX EPC. It  
>> doesnot mean sgx epc cgroup not enabled. That's also consistent with the 
>> behavior try_charge() fails if capacity is zero.
>
> OK. To me the "capacity" is purely the concept of cgroup, so it must be
> interpreted within the scope of "cgroup".  If cgroup, in our case, SGX
> cgroup, is disabled, then whether "leaving the capacity to reflect the
> presence of hardware resource" doesn't really matter.
> So what you are saying is that, the kernel must initialize the capacity  
> of
> some MISC resource once it is added as valid type.  
> And you must initialize the "capacity" even MISC cgroup is disabled
> entirely by kernel commandline, in which case, IIUC, misc.capacity is not
> even going to show in the /fs.
>
> If this is your point, then your patch:
>
> 	cgroup/misc: Add SGX EPC resource type
>
> is already broken, because you added the new type w/o initializing the
> capacity.
>
> Please fix that up.
>
>>
>> > >
>> > > There is explicit way for user to disable misc without setting  
>> capacity> > to
>> > > zero.
>> >
>> > Which way are you talking about?
>>
>> Echo "-misc" to cgroup.subtree_control at root level for example still 
>> shows non-zero sgx_epc capacity.
>
> I guess "having to disable all MISC resources just in order to disable  
> SGX
> EPC cgroup" is a brilliant idea.
>
> You can easily disable the entire MISC cgroup by commandline for that
> purpose if that's acceptable.
>
> And I have no idea why "still showing non-zero EPC capacity" is important
> if SGX cgroup cannot be supported at all.
>

Okay, all I'm trying to say is we should care about consistency in code  
and don't want SGX do something different. Mixing "disable" with  
"capacity==0" causes inconsistencies AFAICS:

1) The try_charge() API currently returns error when capacity is zero. So  
it appears not to mean that the cgroup is disabled otherwise it should  
return success.

2) The current explicit way ("-misc") to disable misc still shows non-zero  
entries in misc.capacity. (At least for v2 cgroup, it does when I tested).  
Maybe this is not important but I just don't feel good about this  
inconsistency.

For now I'll just do BUG_ON() unless there are more strong opinions one  
way or the other.

BR
Haitao

