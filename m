Return-Path: <cgroups+bounces-3231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88F90D048
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639ED1C23BA3
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2B15E5D4;
	Tue, 18 Jun 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W36Ea8PC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CF1534E9;
	Tue, 18 Jun 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715391; cv=none; b=Q3RdNetaCrMo43ADhDbwdxapdyRd8QQF8SuVhECMMkap+LjQhDCHF+7BAXhR7H5jctyXah3m7a/engLP5HkVAjPTNBlQuf4o/hL+Hd9iYJpfALtRYP6cNRUd+MSflgkUSBBQHB+EOd/cyq8MGoRzUf+frkdfrvp2nYUrvWX8xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715391; c=relaxed/simple;
	bh=GQ3HSaUXvewX/fYUurFPaqgoVatJaBnnQo++cKT4X40=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=H2nUAn6fOa5GpFD0ADGmzeOsWoBId9qPLiA2PyNtB1qWttfp5xsaJyFxgYNgfZcKnA/b9NQplH8b+ZUcB/OJX0XAc/IEXSq3uclKNIpoTxsgzJ9m9JN2DS2odwss5U5ZPWh1LUQB7Lx6OVM86mW5H77SDB0H0zGApbG7VnQTqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W36Ea8PC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718715389; x=1750251389;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=GQ3HSaUXvewX/fYUurFPaqgoVatJaBnnQo++cKT4X40=;
  b=W36Ea8PCGytuowwtq3z9yR6OMHBkbVCOwUZW0zEP9sruQqpGnv39F2CM
   f83UFFrDT0gLY57dXWDfU05Z5k/wKTIY9cISb3SJIchEWW6M97HvlvTp0
   5ZzUAjgE3kAU2OdDR/KgSA9F0SMsZMv3IL5NvNq2F75/keze50Qg96bfN
   C6GQmrNEA4pM5oXjBxA/SJOzw7nyz1VOk7b11qM9do5z8qiiOtrPRJfoG
   o64cnhxkcpbGn7gIvjoh1ltBlCG/PzA2Bs7qRS5f7A54vCnCoTpzYQzJ+
   Y0VG31AFknBptWcQXcNdnU3wErn7di5QTEi5o8g8FW4XH4H0gyapMbwFE
   w==;
X-CSE-ConnectionGUID: 2usEaWaKSJOD+8aE84/oxw==
X-CSE-MsgGUID: VekVJrr0SNeHjrpUTuW9zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="40997627"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="40997627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 05:56:28 -0700
X-CSE-ConnectionGUID: cvmDMxXETY+ytE76y3PSMw==
X-CSE-MsgGUID: Nv3E8m/pT6uSA8jDAALgYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46008037"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 18 Jun 2024 05:56:26 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "chenridong@huawei.com" <chenridong@huawei.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
 <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v15 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
 <20240617125321.36658-6-haitao.huang@linux.intel.com>
 <aa686e57fad34041fb941f87c10fb017f048d29f.camel@intel.com>
Date: Tue, 18 Jun 2024 07:56:22 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2pkbj8lbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <aa686e57fad34041fb941f87c10fb017f048d29f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 18 Jun 2024 06:31:09 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> @@ -921,7 +956,8 @@ static int __init sgx_init(void)
>>  	if (!sgx_page_cache_init())
>>  		return -ENOMEM;
>>
>> -	if (!sgx_page_reclaimer_init()) {
>> +	if (!sgx_page_reclaimer_init() || !sgx_cgroup_init()) {
>> +		misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, 0);
>>  		ret = -ENOMEM;
>>  		goto err_page_cache;
>>  	}
>
> This code change is wrong due to two reasons:
>
> 1) If sgx_page_reclaimer_init() was successful, but sgx_cgroup_init()
> failed, you actually need to 'goto err_kthread' because the ksgxd()  
> kernel
> thread is already created and is running.
>
> 2) There are other cases after here that can also result in sgx_init() to
> fail completely, e.g., registering sgx_dev_provision mics device.  We  
> need
> to reset the capacity to 0 for those cases as well.
>
> AFAICT, you need something like:
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c
> b/arch/x86/kernel/cpu/sgx/main.c
> index 27892e57c4ef..46f9c26992a7 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -930,6 +930,10 @@ static int __init sgx_init(void)
>         if (ret)
>                 goto err_kthread;
> +       ret = sgx_cgroup_init();
> +       if (ret)
> +               goto err_provision;
> +
>         /*
>          * Always try to initialize the native *and* KVM drivers.
>          * The KVM driver is less picky than the native one and
> @@ -941,10 +945,12 @@ static int __init sgx_init(void)
>         ret = sgx_drv_init();
>        if (sgx_vepc_init() && ret)
> -               goto err_provision;
> +               goto err_cgroup;
>        return 0;
> +err_cgroup:
> +       /* SGX EPC cgroup cleanup */
>  err_provision:
>         misc_deregister(&sgx_dev_provision);
> @@ -952,6 +958,8 @@ static int __init sgx_init(void)
>         kthread_stop(ksgxd_tsk);
> err_page_cache:
> +       misc_misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, 0);
> +
>         for (i = 0; i < sgx_nr_epc_sections; i++) {
>                 vfree(sgx_epc_sections[i].pages);
>                 memunmap(sgx_epc_sections[i].virt_addr);
>
>
> I put the sgx_cgroup_init() before sgx_drv_init() and sgx_vepc_init(),
> otherwise you will need sgx_drv_cleanup() and sgx_vepc_cleanup()
> respectively when sgx_cgroup_init() fails.
>

Yes, good catch.

> This looks a little bit weird too, though:
>
> Calling misc_misc_cg_set_capacity() to reset capacity to 0 is done at end
> of sgx_init() error path, because the "set capacity" part is done in
> sgx_epc_cache_init().  
> But logically, both "set capacity" and "reset capacity to 0" should be  
> SGX
> EPC cgroup operation, so it's more reasonable to do "set capacity" in
> sgx_cgroup_init() and do "reset to 0" in the
>
> 	/* SGX EPC cgroup cleanup */
>
> as shown above.
>
> Eventually, you will need to do EPC cgroup cleanup anyway, e.g., to free
> the workqueue, so it's odd to have two places to handle EPC cgroup
> cleanup.
>
> I understand the reason "set capacity" part is done in
> sgx_page_cache_init() now is because in that function you can easily get
> the capacity.  But the fact is @sgx_numa_nodes also tracks EPC size for
> each node, so you can also get the total EPC size from @sgx_numa_node in
> sgx_cgroup_init() and set capacity there.
>
> In this case, you can put "reset capacity to 0" and "free workqueue"
> together as the "SGX EPC cgroup cleanup", which is way more clear IMHO.
>
Okay, will  expose @sgx_numa_nodes to epc_cgroup.c and do the calculations  
in sgx_cgroup_init().
Thanks
Haitao

