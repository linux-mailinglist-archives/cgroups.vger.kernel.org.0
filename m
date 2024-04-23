Return-Path: <cgroups+bounces-2674-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609D8AEB22
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D91F220FA
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C413C3E3;
	Tue, 23 Apr 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDgssAaK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A713698B;
	Tue, 23 Apr 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886276; cv=none; b=PMPtwYUpsDwn04I0R3T0Wd9z/NOIF/gnif8Z8TNNxeuGhv/X43FCCx/IId7rgHSLf0KT22/OpwAAklT7LefgWrD8/oXqHH1LXjfJtayWsBcedqP7V0yH/w6wMuszkXxfKiay8YZOZCM40RIRhHc3WY2biWRF7zzsA3O6hZ2N2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886276; c=relaxed/simple;
	bh=BtNEO6lMIphI6XxyY8shoILbPgSyEZ6EIn9zTBj6O7s=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=hc+MaTKNaLXeKi28IQbrkaRDveYCTvwvyY5tk4+tf8vz7KvPkWd7WYrBSWO9W5cX9l5LZ+gLscxRE/syC3hX9C21dKkYau2CYU9NhP2Trs7VzmM1KNmVjmxqXo8LHQJ7EyG1gf6ZaAGspgAzcKciohckw1JW3hc3rLkAdot/Q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDgssAaK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713886271; x=1745422271;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=BtNEO6lMIphI6XxyY8shoILbPgSyEZ6EIn9zTBj6O7s=;
  b=HDgssAaKCd0d4uAbdn5USdIGaBT64J9O90+B+8QNRonmIs0QQ0uYVKGz
   FCi5j09qJAfkMjreEhfkLBv2XlReeNnioMdnWeDlYhGF8r5Z71EN8w6N6
   RbLidc2lqNubO+rURGwGwYfimD1OGSFSd+1Hjg1GkAajMWxJr5IhrlkI2
   mBJcm+P3oK0ViUpn7+i5oqqO2CqGQhw1Lbm56G+3jKLDZGsfkTzBcZMUk
   7dJnGQ0is9iu0VJMSRmS8/gCojF8n+ku3bO/lfMzJv7uvJWauzemqGSs0
   g6Gf4WwdLeVzoom93vYS7eG6J5io5QOPOA540scsTPuapaj8k/yIq+2+8
   g==;
X-CSE-ConnectionGUID: iX6uN4MBShiAe964FFU5Bw==
X-CSE-MsgGUID: rQqQT/xdRaqrSFGSn1PSbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13263417"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13263417"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:30:57 -0700
X-CSE-ConnectionGUID: X1SVaLSnQduHyFJQCL89eA==
X-CSE-MsgGUID: 0gkSmFhLTiCjmxB05KP/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24442745"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 23 Apr 2024 08:30:53 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "tim.c.chen@linux.intel.com"
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
Date: Tue, 23 Apr 2024 10:30:51 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2motdpw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <be1b1198e05a91b16677acf4037cd52519273529.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 23 Apr 2024 09:19:53 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Tue, 2024-04-23 at 08:08 -0500, Haitao Huang wrote:
>> On Mon, 22 Apr 2024 17:16:34 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Mon, 2024-04-22 at 11:17 -0500, Haitao Huang wrote:
>> > > On Sun, 21 Apr 2024 19:22:27 -0500, Huang, Kai <kai.huang@intel.com>
>> > > wrote:
>> > >
>> > > > On Fri, 2024-04-19 at 20:14 -0500, Haitao Huang wrote:
>> > > > > > > I think we can add support for "sgx_cgroup=disabled" in  
>> future
>> > > if
>> > > > > indeed
>> > > > > > > needed. But just for init failure, no?
>> > > > > > >
>> > > > > >
>> > > > > > It's not about the commandline, which we can add in the future
>> > > when
>> > > > > > needed.  It's about we need to have a way to handle SGX cgroup
>> > > being
>> > > > > > disabled at boot time nicely, because we already have a case
>> > > where we
>> > > > > > need
>> > > > > > to do so.
>> > > > > >
>> > > > > > Your approach looks half-way to me, and is not future
>> > > extendible.  If
>> > > > > we
>> > > > > > choose to do it, do it right -- that is, we need a way to  
>> disable
>> > > it
>> > > > > > completely in both kernel and userspace so that userspace  
>> won't be
>> > > > > able> to
>> > > > > > see it.
>> > > > >
>> > > > > That would need more changes in misc cgroup implementation to
>> > > support
>> > > > > sgx-disable. Right now misc does not have separate files for
>> > > different
>> > > > > resource types. So we can only block echo "sgx_epc..." to those
>> > > > > interfacefiles, can't really make files not visible.
>> > > >
>> > > > "won't be able to see" I mean "only for SGX EPC resource", but  
>> not the
>> > > > control files for the entire MISC cgroup.
>> > > >
>> > > > I replied at the beginning of the previous reply:
>> > > >
>> > > > "
>> > > > Given SGX EPC is just one type of MISC cgroup resources, we cannot
>> > > just
>> > > > disable MISC cgroup as a whole.
>> > > > "
>> > > >
>> > > Sorry I missed this point. below.
>> > >
>> > > > You just need to set the SGX EPC "capacity" to 0 to disable SGX  
>> EPC.
>> > > See
>> > > > the comment of @misc_res_capacity:
>> > > >
>> > > >  * Miscellaneous resources capacity for the entire machine. 0  
>> capacity
>> > > >  * means resource is not initialized or not present in the host.
>> > > >
>> > >
>> > > IIUC I don't think the situation we have is either of those cases.  
>> For
>> > > our
>> > > case, resource is inited and present on the host but we have  
>> allocation
>> > > error for sgx cgroup infra.
>> >
>> > You have calculated the "capacity", but later you failed something and
>> > then reset the "capacity" to 0, i.e., cleanup.  What's wrong with  
>> that?
>> >
>> > >
>> > > > And "blocking echo sgx_epc ... to those control files" is already
>> > > > sufficient for the purpose of not exposing SGX EPC to userspace,
>> > > correct?
>> > > >
>> > > > E.g., if SGX cgroup is enabled, you can see below when you read  
>> "max":
>> > > >
>> > > >  # cat /sys/fs/cgroup/my_group/misc.max
>> > > >  # <resource1> <max1>
>> > > >    sgx_epc ...
>> > > >    ...
>> > > >
>> > > > Otherwise you won't be able to see "sgx_epc":
>> > > >
>> > > >  # cat /sys/fs/cgroup/my_group/misc.max
>> > > >  # <resource1> <max1>
>> > > >    ...
>> > > >
>> > > > And when you try to write the "max" for "sgx_epc", you will hit  
>> error:
>> > > >
>> > > >  # echo "sgx_epc 100" > /sys/fs/cgroup/my_group/misc.max
>> > > >  # ... echo: write error: Invalid argument
>> > > >
>> > > > The above applies to all the control files.  To me this is pretty  
>> much
>> > > > means "SGX EPC is disabled" or "not supported" for userspace.
>> > > >
>> > > You are right, capacity == 0 does block echoing max and users see an
>> > > error
>> > > if they do that. But 1) doubt you literately wanted "SGX EPC is
>> > > disabled"
>> > > and make it unsupported in this case,
>> >
>> > I don't understand.  Something failed during SGX cgroup  
>> initialization,
>> > you _literally_ cannot continue to support it.
>> >
>> >
>>
>> Then we should just return -ENOMEM from sgx_init() when sgx cgroup
>> initialization fails?
>> I thought we only disable SGX cgroup support. SGX can still run.
>
> I am not sure how you got this conclusion.  I specifically said something
> failed during SGX "cgroup" initialization, so only SGX "cgroup" needs to
> be disabled, not SGX as a whole.
>
>>
>> > > 2) even if we accept this is "sgx
>> > > cgroup disabled" I don't see how it is much better user experience  
>> than
>> > > current solution or really helps user better.
>> >
>> > In your way, the userspace is still able to see "sgx_epc" in control
>> > files
>> > and is able to update them.  So from userspace's perspective SGX  
>> cgroup
>> > is
>> > enabled, but obviously updating to "max" doesn't have any impact.   
>> This
>> > will confuse userspace.
>> >
>> > >
>>
>> Setting capacity to zero also confuses user space. Some application may
>> rely on this file to know the capacity.
>
>
> Why??
>
> Are you saying before this SGX cgroup patchset those applications cannot
> run?
>
>>
>> > > Also to implement this approach, as you mentioned, we need  
>> workaround
>> > > the
>> > > fact that misc_try_charge() fails when capacity set to zero, and  
>> adding
>> > > code to return root always?
>> >
>> > Why this is a problem?
>> >
>>
>> It changes/overrides the the original meaning of capacity==0: no one can
>> allocate if capacity is zero.
>
> Why??
>
> Are you saying before this series, no one can allocate EPC page?
>
>>
>> > > So it seems like more workaround code to just
>> > > make it work for a failing case no one really care much and end  
>> result
>> > > is
>> > > not really much better IMHO.
>> >
>> > It's not workaround, it's the right thing to do.
>> >
>> > The result is userspace will see it being disabled when kernel  
>> disables
>> > it.
>> >
>> >
>> It's a workaround because you use the capacity==0 but it does not really
>> mean to disable the misc cgroup for specific resource IIUC.
>
> Please read the comment around @misc_res_capacity again:
>
>  * Miscellaneous resources capacity for the entire machine. 0 capacity
>  * means resource is not initialized or not present in the host.
>

I mentioned this in earlier email. I think this means no SGX EPC. It does  
not mean sgx epc cgroup not enabled. That's also consistent with the  
behavior try_charge() fails if capacity is zero.

>>
>> There is explicit way for user to disable misc without setting capacity  
>> to
>> zero.
>
> Which way are you talking about?

Echo "-misc" to cgroup.subtree_control at root level for example still  
shows non-zero sgx_epc capacity.

>
>> So in future if we want really disable sgx_epc cgroup specifically
>> we should not use capacity.  Therefore your approach is not
>> extensible/reusable.
>>
>> Given this is a rare corner case caused by configuration, we can only do
>> as much as possible IMHO, not trying to implement a perfect solution at
>> the moment. Maybe BUG_ON() is more appropriate?
>>
>
> I think I will reply this thread for the last time:
>
> I don't have strong opinion to against using BUG_ON() when you fail to
> allocate workqueue.  If you choose to do this, I'll leave to others.
>
> If you want to "disable SGX cgroup" when you fail to allocate workqueue,
> reset the "capacity" to 0 to disable it.

Unless I hear otherwise, I'll revert to BUG_ON().

Thanks
Haitao

