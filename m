Return-Path: <cgroups+bounces-2627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89938AB54C
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AE71C20CC9
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10F13118B;
	Fri, 19 Apr 2024 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUrk96bD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA921DA26;
	Fri, 19 Apr 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552938; cv=none; b=mY5X+bi7OA8sQmHdrriWTWhcgPISdQpGzJumYAZXU+R80Ga09dM2wYAUWXufyaZp4/J2vqJCF3WvZ4+rFtI9fmjX7cKy9TadO+LOf+77DIwTMaflM4sHgZ7R5Qs97YtHhKt5GVDOVBqW8ZvLp8C4Uqfe4rDaIZERyCrZeXnnzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552938; c=relaxed/simple;
	bh=UsQKoIdsg1qzhVZohacdD4T7uZAx/ak/IJJH/5oMPrM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=lsIvRfMZ0jPAkAnGP/BF+7Dnh4uawqAn7XR4gY51PsZFrS7sRCHjQgrS47pV4MNpYeN+h+/q4Q/+3M/wlWyCE9QCqDsH1AtXJ0dd9M8i6HHQGSSxZkCZVTMqqoelykL40L2k+HGZ8s+ELYrTMqbt4BKTRxLEAoCYiQR2zhcuaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUrk96bD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713552937; x=1745088937;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=UsQKoIdsg1qzhVZohacdD4T7uZAx/ak/IJJH/5oMPrM=;
  b=fUrk96bD7672VyhyfoHm8O/SSk0JIozx/A9xEyH/aBPodokyMIbaskE1
   ufxGgnr02bi/c2mdOszPs3QXmtdAhtWQcSSh/1PLrpZw3wcHz+QgyghFb
   akyF1aSKpZ5lpR+Xr5sWj0vx+KLQ6cYg/k0ksosEyumA2XnjOmmvjTSCj
   nrD3hSav6urZJbcGh92vN9unkA67K/G1N4fXfwKCaQeOCKyrMK2iwy7f9
   RI0y4YdeNVqDKkqFnp7fEgxjtslahRvJSOYBqFMVQtEaLvD6RLEk9obMJ
   IVcRF7qPZ7T4+KhC1eBHz6C7KkNhq2/uchBmJNLw/8XVb9wNF2tshr+v8
   A==;
X-CSE-ConnectionGUID: PaEPX/0tSPWXK10+Dw+agQ==
X-CSE-MsgGUID: bWLb+TUzTjCSRew8m3xoug==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20309639"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20309639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 11:55:36 -0700
X-CSE-ConnectionGUID: E5Tbv0JuSraAgqoY7losDg==
X-CSE-MsgGUID: DqVHhWN7QCGEpgauAFickQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28226862"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 19 Apr 2024 11:55:33 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Huang, Kai" <kai.huang@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-10-haitao.huang@linux.intel.com>
 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
Date: Fri, 19 Apr 2024 13:55:31 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 18 Apr 2024 20:32:14 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 16/04/2024 3:20 pm, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>  In cases EPC pages need be allocated during a page fault and the cgroup
>> usage is near its limit, an asynchronous reclamation needs be triggered
>> to avoid blocking the page fault handling.
>>  Create a workqueue, corresponding work item and function definitions
>> for EPC cgroup to support the asynchronous reclamation.
>>  In case the workqueue allocation is failed during init, disable cgroup.
>
> It's fine and reasonable to disable (SGX EPC) cgroup.  The problem is  
> "exactly what does this mean" isn't quite clear.
>
First, this is really some corner case most people don't care: during  
init, kernel can't even allocate a workqueue object. So I don't think we  
should write extra code to implement some sophisticated solution. Any  
solution we come up with may just not work as the way user want or solve  
the real issue due to the fact such allocation failure even happens at  
init time.

So IMHO the current solution should be fine and I'll answer some of your  
detailed questions below.

> Given SGX EPC is just one type of MISC cgroup resources, we cannot just  
> disable MISC cgroup as a whole.
>
> So, the first interpretation is we treat the entire MISC_CG_RES_SGX  
> resource type doesn't exist, that is, we just don't show control files  
> in the file system, and all EPC pages are tracked in the global list.
>
> But it might be not straightforward to implement in the SGX driver,  
> i.e., we might need to do more MISC cgroup core code change to make it  
> being able to support disable particular resource at runtime -- I need  
> to double check.
>
> So if that is not something worth to do, we will still need to live with  
> the fact that, the user is still able to create SGX cgroup in the  
> hierarchy and see those control files, and being able to read/write them.
>

Can not reliably predict what will happen. Most likely the ENOMEM will be  
returned by sgx_cgroup_alloc() if reached or other error in the stack if  
not reached to sgx_cgroup_alloc()
  and user fails on creating anything.

But if they do end up creating some cgroups (sgx_cgroup_alloc() and  
everything else  on the call stack passed without failure), everything  
still kind of works for the reason answered below.

> The second interpretation I suppose is, although the SGX cgroup is still  
> seen as supported in userspace, in kernel we just treat it doesn't exist.
>
> Specifically, that means: 1) we always return the root SGX cgroup for  
> any EPC page when allocating a new one; 2) as a result, we still track  
> all EPC pages in a single global list.
>

Current code has similar behavior without extra code.

> But from the code below ...
>
>
>>   static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
>>   {
>>   	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
>> @@ -117,19 +226,28 @@ int sgx_cgroup_try_charge(struct sgx_cgroup  
>> *sgx_cg, enum sgx_reclaim reclaim)
>>   {
>>   	int ret;
>>   +	/* cgroup disabled due to wq allocation failure during  
>> sgx_cgroup_init(). */
>> +	if (!sgx_cg_wq)
>> +		return 0;
>> +
>
> ..., IIUC you choose a (third) solution that is even one more step back:
>
> It just makes try_charge() always succeed, but EPC pages are still  
> managed in the "per-cgroup" list.
>
> But this solution, AFAICT, doesn't work.  The reason is when you fail to  
> allocate EPC page you will do the global reclaim, but now the global  
> list is empty.
>
> Am I missing anything?

But when cgroups enabled in config, global reclamation starts from root  
and reclaim from the whole hierarchy if user may still be able to create.  
Just that we don't have async/sync per-cgroup reclaim triggered.

>
> So my thinking is, we have two options:
>
> 1) Modify the MISC cgroup core code to allow the kernel to disable one  
> particular resource.  It shouldn't be hard, e.g., we can add a  
> 'disabled' flag to the 'struct misc_res'.
>
> Hmm.. wait, after checking, the MISC cgroup won't show any control files  
> if the "capacity" of the resource is 0:
>
> "
>   * Miscellaneous resources capacity for the entire machine. 0 capacity
>   * means resource is not initialized or not present in the host.
> "
>
> So I really suppose we should go with this route, i.e., by just setting  
> the EPC capacity to 0?
>
> Note misc_cg_try_charge() will fail if capacity is 0, but we can make it  
> return success by explicitly check whether SGX cgroup is disabled by  
> using a helper, e.g., sgx_cgroup_disabled().
>
> And you always return the root SGX cgroup in sgx_get_current_cg() when  
> sgx_cgroup_disabled() is true.
>
> And in sgx_reclaim_pages_global(), you do something like:
>
> 	static void sgx_reclaim_pages_global(..)
> 	{
> 	#ifdef CONFIG_CGROUP_MISC
> 		if (sgx_cgroup_disabled())
> 			sgx_reclaim_pages(&sgx_root_cg.lru);
> 		else
> 			sgx_cgroup_reclaim_pages(misc_cg_root());
> 	#else
> 		sgx_reclaim_pages(&sgx_global_list);
> 	#endif
> 	}
>
> I am perhaps missing some other spots too but you got the idea.
>
> At last, after typing those, I believe we should have a separate patch  
> to handle disable SGX cgroup at initialization time.  And you can even  
> put this patch _somewhere_ after the patch
>
> 	"x86/sgx: Implement basic EPC misc cgroup functionality"
>
> and before this patch.
>
> It makes sense to have such patch anyway, because with it we can easily  
> to add a kernel command line 'sgx_cgroup=disabled" if the user wants it  
> disabled (when someone has such requirement in the future).
>

I think we can add support for "sgx_cgroup=disabled" in future if indeed  
needed. But just for init failure, no?

Thanks
Haitao

