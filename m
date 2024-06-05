Return-Path: <cgroups+bounces-3105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A318FD1B8
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C639E1C229C9
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637156477;
	Wed,  5 Jun 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i05QGcAn"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25519D882;
	Wed,  5 Jun 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601611; cv=none; b=HgMVstidtbPOVbcRN/1VeU7fkL8gfGwY23BXRlznR6hj0wvLLQIk3Cjy6D1oAa0efeKGVuUtCuKJpwbNLtOz/7fdsa5KnXUtd/dVXGcZ090jPP7zMgxAbJntc6RgmIDFzuigOF9epcvuUIj9TRFdI3LwzDxJLJd+ue5KlYmaiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601611; c=relaxed/simple;
	bh=6GytrU5w6+5lg5eOj3jMDTc2t7dk1XqZMyo8YPVX0Kg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=i0+Sxcwqegz39H7tdDEbtNoHLFOawfEhR936/7krtqjooQAacozYtMBHI+jsZVKF8bI2agS0ONnYtziHlxG47zx+ejdUCVjXqmRMKGqLwqtGckcBpgCZccUCPI0naaPHsKmlmUob1bsbjebcFg9bgQs9VsGKk9Wf8UBidOldMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i05QGcAn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601610; x=1749137610;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=6GytrU5w6+5lg5eOj3jMDTc2t7dk1XqZMyo8YPVX0Kg=;
  b=i05QGcAnz4nGbGss96sse1v8rcmAeQrDguNRc64hgWdk+Nl0XSuf6Ra7
   h2LFskqQn7XI6kReWo7LccHyMUqmP4XIm3MgxHvy/R+O/GnLEzEkno+lz
   FZI3nN/e9S1Avh+KMDLHmSi/zN9CsRj8/chPIiyYMWtmAhLfFdELDIbso
   y79RPG/wpxIcHGCwfMGC/EU6/bgBsG6djqYnIDwLfz/GkLuHvehWMrPRV
   4Q2Qraken5nAedP6g5m7zg48bzUoRe3BSCf1wc01bfKsGMJVF+FHIxJJG
   9NqDNOVtflXRHZb3SSYdXJWIkzkPElBSxXcj3LCdgunuFSd3rhwnaErP9
   A==;
X-CSE-ConnectionGUID: epyN2NhtQ764cuNWs43+Aw==
X-CSE-MsgGUID: tZRMeRVqSmiKxsJsxklkvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="17161464"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="17161464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:33:29 -0700
X-CSE-ConnectionGUID: pUxwn1/USCW354vROyvRLQ==
X-CSE-MsgGUID: 6ce3Ag8+R3qDB+Xmjf9TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="68781243"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/AES256-SHA; 05 Jun 2024 08:33:27 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
Date: Wed, 05 Jun 2024 10:33:23 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

Hi Jarkko

Thanks for your review.

On Tue, 04 Jun 2024 17:00:34 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Sat Jun 1, 2024 at 1:26 AM EEST, Haitao Huang wrote:
>> With different cgroups, the script starts one or multiple concurrent SGX
>> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
>> test case, which loads an enclave of EPC size equal to the EPC capacity
>> available on the platform. The script checks results against the
>> expectation set for each cgroup and reports success or failure.
>>
>> The script creates 3 different cgroups at the beginning with following
>> expectations:
>>
>> 1) small - intentionally small enough to fail the test loading an
>> enclave of size equal to the capacity.
>> 2) large - large enough to run up to 4 concurrent tests but fail some if
>> more than 4 concurrent tests are run. The script starts 4 expecting at
>> least one test to pass, and then starts 5 expecting at least one test
>> to fail.
>> 3) larger - limit is the same as the capacity, large enough to run lots  
>> of
>> concurrent tests. The script starts 8 of them and expects all pass.
>> Then it reruns the same test with one process randomly killed and
>> usage checked to be zero after all processes exit.
>>
>> The script also includes a test with low mem_cg limit and large sgx_epc
>> limit to verify that the RAM used for per-cgroup reclamation is charged
>> to a proper mem_cg. For this test, it turns off swapping before start,
>> and turns swapping back on afterwards.
>>
>> Add README to document how to run the tests.
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reorg:
>
> void sgx_cgroup_init(void)
> {
> 	struct workqueue_struct *wq;
>
> 	/* eagerly allocate the workqueue: */
> 	wq = alloc_workqueue("sgx_cg_wq", wq_unbound | wq_freezable,  
> wq_unbound_max_active);
> 	if (!wq) {
> 		pr_warn("sgx_cg_wq creation failed\n");
> 		return;

sgx_cgroup_try_charge() expects sgx_cg_wq, so it would break unless we  
check and return 0 which was the initially implemented in v12. But then  
Kai had some concern on that we expose all the interface files to allow  
user to set limits but we don't enforce. To keep it simple we settled down  
back to BUG_ON(). This would only happen rarely and user can add  
command-line to disable SGX if s/he really wants to start kernel in this  
case, just can't do SGX.

Another thought we could just guard queue_work() with a null check for  
sgx_cg_wq, but I thought that's also not good for user as it basically  
disables all async global and per-cgroup reclamation. If user needs run  
SGX in such a case, better have async anyways.

See previous discusion:  
https://lore.kernel.org/linux-sgx/e56216ee4d5f7ef6d97c70f56243a5ddc8dea19d.camel@intel.com/

> 	}
>
> 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
> 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
>
> 	/* Depending on misc state, keep or destory the workqueue: */
> 	if (cgroup_subsys_enabled(misc_cgrp_subsys))
> 		sgx_cg_wq = wq;
> 	else
> 		destroy_workqueue(wq);
> }
>
> BTW, why two previous operations are performed if subsystem is not
> enabled?
>

Note this file is conditionally compiled on CGROUP_MISC KConfig. Even  
though subsystem can be 'disabled' from the command line when CGROUP_MISC  
is on, we still need initialize the misc root node which is static for  
below reason.

All process will be assigned to misc root if misc is disabled and  
get_current_misc_cg() will return the root. So we need initialize ->lru  
and ->reclaim_work for the root sgx cgroup.

> I.e. why not instead:
>
> void sgx_cgroup_init(void)
> {
> 	struct workqueue_struct *wq;
>
> 	/* Eagerly allocate the workqueue: */
> 	wq = alloc_workqueue("sgx_cg_wq", wq_unbound | wq_freezable,  
> wq_unbound_max_active);
> 	if (!wq) {
> 		pr_warn("sgx_cg_wq creation failed\n");
> 		return;
> 	}
>

Same comment as above

> 	if (!cgroup_subsys_enabled(misc_cgrp_subsys)) {
> 		destroy_workqueue(wq);
> 		return;
> 	}
>
> 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
> 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
> 	sgx_cg_wq = wq;
> }
>
> Finally, why this does not have __init?

This was my misunderstanding that __init only applies to the main init  
function. After looking at some actual usages, I tend to agree __init is  
appropriate. Thanks for catching this.

> And neither sgx_cgroup_misc_init().

This one is called when a specific misc cgroup is created (a new  
sub-folder in sysfs paraent in which misc is enabled), by the callback  
sgx_cgroup_alloc(). Not necessarily when subsys init.

>
> The names for these are also somewhat confusing, maybe something like:
>
> * __sgx_cgroups_misc_init()
> * sgx_cgroups_misc_init()
>
> And both with __init.
>
sgx_cgroup_init() is for the whole sgx cgroup support so original name is  
OK?
similar to sgx_drv_init(), sgx_vepc_init()?

I'm fine to rename the other one and add __init for sgx_cgroup().

> I just made a trivial checkpatch run as a final check, and spotted the
> warning on BUG_ON(), and noticed that this can't be right as it is but
> please comment and correct where I might have gotten something wrong.
>

See above

> With "--strict" flag I also catched these:
>
> CHECK: spinlock_t definition without comment
> #1308: FILE: arch/x86/kernel/cpu/sgx/sgx.h:122:
> +	spinlock_t lock;
>
Yes I had a comment but Kai thought it was too obvious and I can't think  
of a better one that's not obvious so I removed:

https://lore.kernel.org/linux-sgx/9ffb02a3344807f2c173fe8c7cb000cd6c7843b6.camel@intel.com/


> CHECK: multiple assignments should be avoided
> #444: FILE: kernel/cgroup/misc.c:450:
> +		parent_cg = cg = &root_cg;
>

This was also suggested by Kai a few versions back:
https://lore.kernel.org/linux-sgx/8f08f0b0f2b04b90d7cdb7b628f16f9080687c43.camel@intel.com/

Thanks
Haitao

