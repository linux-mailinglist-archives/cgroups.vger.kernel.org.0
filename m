Return-Path: <cgroups+bounces-2632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC38AB842
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 03:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E01C20AD6
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6767FE;
	Sat, 20 Apr 2024 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwVRYCZ/"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BC5382;
	Sat, 20 Apr 2024 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575668; cv=none; b=CYJ8VsH8eHfR8YaLpT1iH79cVS+GVa5G8lFtDfkQsQJtz8uXQkS/6dS8toEKQYiIQQqB3Ze8iIvy/Tj9degf7HiPKlTV+owoivrr9m4zqT14H7ph8V9f7QQXqT7pdKHnBDs2y7SKzZl0tzLA8sLbbuuXc0A1XOq4zWW3Q9m6DwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575668; c=relaxed/simple;
	bh=410Kx0oMxTCGMb4QZ71+KMm5Q+IVljg4+S/8VtIDnPk=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=smFpAdX4O188nMvmy5HvkYHhUdL4h7zHZdDpGP7UALx5m3JjxT0kmAxrQOY/+6nLvQVmFBdHZpNE3ssm8c94SF85908xbY2bz2VwsS8OLlIaPMHmWejdZo10aydMWeAgaj0FMyZRVUAckCoZmfjxNsDVBnIeUHCom3Z5x9lvj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwVRYCZ/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713575667; x=1745111667;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=410Kx0oMxTCGMb4QZ71+KMm5Q+IVljg4+S/8VtIDnPk=;
  b=nwVRYCZ/o4VgUqRrqCJLXL7JXfRgZAw7dN0XzWOrCHBSD0EVpZNfvzKN
   wvBLRzvcYuj2AcdJ7q1TFq0LdnZqtoephKseTyZzkhPI2HkHn1mCU+CM/
   WYlcR7VUrOHE9a+yEZshp82oPwD8A4OgY2yFKBn0N8pxR773+vhcBVKQW
   UWnZZaljCKkRCMOT8DIgF1m4RBBBm8EC898f87NaLgTNNRoGmbjUPPnxh
   SlpeHgh+qKUX6IrAhu9EYeIsK6lZioWYW46B/gztkKQNu0hnejUELoyvR
   Kn+YH1lmLjHnIml/c9S1cKnDy0MVd1h4b7LfSLq9J/F/oz7+6L1YvzEcV
   g==;
X-CSE-ConnectionGUID: QM1lKIP/TKmjT2Fs2O1wPA==
X-CSE-MsgGUID: /kjhofv6TWuovkNB8KtJ7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12137327"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="12137327"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 18:14:25 -0700
X-CSE-ConnectionGUID: cq7U7DexS0SYqitJLmZQzw==
X-CSE-MsgGUID: AL0n0djzTDCH42Vs1QhaSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23552869"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 19 Apr 2024 18:14:23 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
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
Date: Fri, 19 Apr 2024 20:14:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 19 Apr 2024 17:44:59 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2024-04-19 at 13:55 -0500, Haitao Huang wrote:
>> On Thu, 18 Apr 2024 20:32:14 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> >
>> >
>> > On 16/04/2024 3:20 pm, Haitao Huang wrote:
>> > > From: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > >  In cases EPC pages need be allocated during a page fault and the  
>> cgroup
>> > > usage is near its limit, an asynchronous reclamation needs be  
>> triggered
>> > > to avoid blocking the page fault handling.
>> > >  Create a workqueue, corresponding work item and function  
>> definitions
>> > > for EPC cgroup to support the asynchronous reclamation.
>> > >  In case the workqueue allocation is failed during init, disable  
>> cgroup.
>> >
>> > It's fine and reasonable to disable (SGX EPC) cgroup.  The problem is
>> > "exactly what does this mean" isn't quite clear.
>> >
>> First, this is really some corner case most people don't care: during
>> init, kernel can't even allocate a workqueue object. So I don't think we
>> should write extra code to implement some sophisticated solution. Any
>> solution we come up with may just not work as the way user want or solve
>> the real issue due to the fact such allocation failure even happens at
>> init time.
>
> I think for such boot time failure we can either choose directly  
> BUG_ON(),
> or we try to handle it _nicely_, but not half-way.  My experience is
> adding BUG_ON() should be avoided in general, but it might be acceptable
> during kernel boot.  I will leave it to others.
>
>
> [...]
>
>> >
>> > ..., IIUC you choose a (third) solution that is even one more step  
>> back:
>> >
>> > It just makes try_charge() always succeed, but EPC pages are still
>> > managed in the "per-cgroup" list.
>> >
>> > But this solution, AFAICT, doesn't work.  The reason is when you fail  
>> to
>> > allocate EPC page you will do the global reclaim, but now the global
>> > list is empty.
>> >
>> > Am I missing anything?
>>
>> But when cgroups enabled in config, global reclamation starts from root
>> and reclaim from the whole hierarchy if user may still be able to  
>> create.
>> Just that we don't have async/sync per-cgroup reclaim triggered.
>
> OK.  I missed this as it is in a later patch.
>
>>
>> >
>> > So my thinking is, we have two options:
>> >
>> > 1) Modify the MISC cgroup core code to allow the kernel to disable one
>> > particular resource.  It shouldn't be hard, e.g., we can add a
>> > 'disabled' flag to the 'struct misc_res'.
>> >
>> > Hmm.. wait, after checking, the MISC cgroup won't show any control  
>> files
>> > if the "capacity" of the resource is 0:
>> >
>> > "
>> >   * Miscellaneous resources capacity for the entire machine. 0  
>> capacity
>> >   * means resource is not initialized or not present in the host.
>> > "
>> >
>> > So I really suppose we should go with this route, i.e., by just  
>> setting
>> > the EPC capacity to 0?
>> >
>> > Note misc_cg_try_charge() will fail if capacity is 0, but we can make  
>> it
>> > return success by explicitly check whether SGX cgroup is disabled by
>> > using a helper, e.g., sgx_cgroup_disabled().
>> >
>> > And you always return the root SGX cgroup in sgx_get_current_cg() when
>> > sgx_cgroup_disabled() is true.
>> >
>> > And in sgx_reclaim_pages_global(), you do something like:
>> >
>> > 	static void sgx_reclaim_pages_global(..)
>> > 	{
>> > 	#ifdef CONFIG_CGROUP_MISC
>> > 		if (sgx_cgroup_disabled())
>> > 			sgx_reclaim_pages(&sgx_root_cg.lru);
>> > 		else
>> > 			sgx_cgroup_reclaim_pages(misc_cg_root());
>> > 	#else
>> > 		sgx_reclaim_pages(&sgx_global_list);
>> > 	#endif
>> > 	}
>> >
>> > I am perhaps missing some other spots too but you got the idea.
>> >
>> > At last, after typing those, I believe we should have a separate patch
>> > to handle disable SGX cgroup at initialization time.  And you can even
>> > put this patch _somewhere_ after the patch
>> >
>> > 	"x86/sgx: Implement basic EPC misc cgroup functionality"
>> >
>> > and before this patch.
>> >
>> > It makes sense to have such patch anyway, because with it we can  
>> easily
>> > to add a kernel command line 'sgx_cgroup=disabled" if the user wants  
>> it
>> > disabled (when someone has such requirement in the future).
>> >
>>
>> I think we can add support for "sgx_cgroup=disabled" in future if indeed
>> needed. But just for init failure, no?
>>
>
> It's not about the commandline, which we can add in the future when
> needed.  It's about we need to have a way to handle SGX cgroup being
> disabled at boot time nicely, because we already have a case where we  
> need
> to do so.
>
> Your approach looks half-way to me, and is not future extendible.  If we
> choose to do it, do it right -- that is, we need a way to disable it
> completely in both kernel and userspace so that userspace won't be able  
> to
> see it.

That would need more changes in misc cgroup implementation to support  
sgx-disable. Right now misc does not have separate files for different  
resource types. So we can only block echo "sgx_epc..." to those interface  
files, can't really make files not visible.

Anyway, I see this is really a configuration failure case. And we handle  
it without added complexity and do as much as we can gracefully until  
another fatal error happens. So if we need support disable sgx through  
command line in future, then we can also make this failure handling even  
more graceful at that time. Nothing really is lost IMHO.

Originally we put in BUG_ON() but then we changed to handle it based on  
your feedback. I can put BUG_ON() back if we agree that's more appropriate  
at the moment.

@Dave, @Jarkko, @Michal, your thoughts?

Thanks
Haitao
 

