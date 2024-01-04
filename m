Return-Path: <cgroups+bounces-1081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78338248E9
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3581F25976
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38E2C1A0;
	Thu,  4 Jan 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8rn86If"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356542C190;
	Thu,  4 Jan 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704396043; x=1735932043;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=xvPUVXYQQThwTZkVnmYpRPy3ntpcXeAERqkI35DRWDs=;
  b=D8rn86IfzMkKzzo7WC3Fdrz4oRjaLlGeqAMeNTAHC/0ZqZ8Qh58pKw8v
   fllNNfoBQAnh/goSDASJHL76fhL/JDVGvaolCi6EwxIRz1MmawAL70cCf
   m//n6KBcFI790zzXdwxGK1XAzqO9WqC0ijAncW4yVWJnbLxr7q0K289GK
   8wcKcchJbzFbgavz7OCqERo+0P2idUuKZb3GyBes3odr2XeUkCuYfnvoW
   IGyKBKgjiV7GFGNzVOpt1g6A8p8y+e4wq4iKyT1volIx0JhqNn9roJdDD
   c3HNTS4SkkO6dlBT23lZ2NnRTN/tijgjzRCfr1RmjEMhWPHmh5qth3OCU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4712077"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4712077"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="22603517"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Jan 2024 11:20:39 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
 <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>,
 "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
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
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <mmcdj5ulscoxyofetdgmygytd2dnjusnoj3ypix2plnwp7nbks@bqesmrpmsca7>
Date: Thu, 04 Jan 2024 13:20:38 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g1eoojxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <mmcdj5ulscoxyofetdgmygytd2dnjusnoj3ypix2plnwp7nbks@bqesmrpmsca7>
User-Agent: Opera Mail/1.0 (Win32)

Hi Michal,

On Thu, 04 Jan 2024 06:38:41 -0600, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> Hello.
>
> On Mon, Dec 18, 2023 at 03:24:40PM -0600, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> Thanks for raising this. Actually my understanding the above discussi=
on  =

>> was
>> mainly about not doing reclaiming by killing enclaves, i.e., I assume=
d
>> "reclaiming" within that context only meant for that particular kind.=

>>
>> As Mikko pointed out, without reclaiming per-cgroup, the max limit of=
  =

>> each
>> cgroup needs to accommodate the peak usage of enclaves within that  =

>> cgroup.
>> That may be inconvenient for practical usage and limits could be forc=
ed  =

>> to
>> be set larger than necessary to run enclaves performantly. For exampl=
e,  =

>> we
>> can observe following undesired consequences comparing a system with =
 =

>> current
>> kernel loaded with enclaves whose total peak usage is greater than th=
e  =

>> EPC
>> capacity.
>>
>> 1) If a user wants to load the same exact enclaves but in separate  =

>> cgroups,
>> then the sum of cgroup limits must be higher than the capacity and th=
e
>> system will end up doing the same old global reclaiming as it is  =

>> currently
>> doing. Cgroup is not useful at all for isolating EPC consumptions.
>
> That is the use of limits to prevent a runaway cgroup smothering the
> system. Overcommited values in such a config are fine because the more=

> simultaneous runaways, the less likely.
> The peak consumption is on the fair expense of others (some efficiency=
)
> and the limit contains the runaway (hence the isolation).
>

This makes sense to me in theory. Mikko, Chris Y/Bo Z, your thoughts on =
 =

whether this is good enough for your intended usages?

>> 2) To isolate impact of usage of each cgroup on other cgroups and yet=
  =

>> still
>> being able to load each enclave, the user basically has to carefully =
 =

>> plan to
>> ensure the sum of cgroup max limits, i.e., the sum of peak usage of
>> enclaves, is not reaching over the capacity. That means no  =

>> over-commiting
>> allowed and the same system may not be able to load as many enclaves =
as  =

>> with
>> current kernel.
>
> Another "config layout" of limits is to achieve partitioning (sum =3D=3D=

> capacity). That is perfect isolation but it naturally goes against
> efficient utilization. The way other controllers approach this trade-o=
ff
> is with weights (cpu, io) or protections (memory). I'm afraid misc
> controller is not ready for this.
>
> My opinion is to start with the simple limits (first patches) and thin=
k
> of prioritization/guarantee mechanism based on real cases.
>

We moved away from using mem like custom controller with (low, high, max=
)  =

to misc controller. But if we need add those down the road, then the  =

interface needs be changed. So my concern on this route would be whether=
  =

misc would allow any of those extensions. On the other hand, it might tu=
rn  =

out less complex just doing the reclamation per cgroup.

Thanks a lot for your comments and they are really helpful!

Haitao


