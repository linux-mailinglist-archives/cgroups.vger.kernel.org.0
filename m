Return-Path: <cgroups+bounces-1220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB11483942A
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F529136C
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C6612E1;
	Tue, 23 Jan 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uluhp6u6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4262A02;
	Tue, 23 Jan 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025886; cv=none; b=BJ68h7z1zsBEvSMzLBrxsqI+nNZPJONFQVFs2VFlUnZwESTta7Qcsb2YrvGWwovh/FaVR787BmX8UE2SfHIVVck9odjziKlVKv+tkwUnkDNb7xHCM1mMgYAtaLcrxvPu4VFbOpsAi4AuFTrk5Pnjb4Ta2zpLHfhA8uBa/IWOQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025886; c=relaxed/simple;
	bh=DZh35DyC6FHYWUcZPRMJlKZaRbb6awdzQL3Ie3ptU0k=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=arCzmObJRATc+sVzNx/nUhR6Sgr0nTBxk7L5lJ2Ja2kvDjdlk8eOLjeILWq0I6uwqLiR9Rrc7O+aLAGY0zOVikAp0VugpdLZ/8PQSgHf0XSbCG6GSE1CyV3Z/d5pVaFicVtvEcLSfF8O+YBCxRiGD9ifuMIb9I4/TVWNq+rwdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uluhp6u6; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706025884; x=1737561884;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=DZh35DyC6FHYWUcZPRMJlKZaRbb6awdzQL3Ie3ptU0k=;
  b=Uluhp6u6LMMbONVY6MmR52EINvo1NVWdnxyYGYeCLPAtJbVEqJZXxnDU
   C4NjPmWqjhrtlx5UhpdMS0JXmbAl1qFrIzXFGg0TvLQmvFF+/d4vpGKjX
   cQVl1Y7KQiCSBDlDDGE7Sh5/FQN4aoNp3/rXXoK9qXkrYeswwG4W9zKv1
   4uJLi93Z04DIGk+2HqgVbcdBVLy244YtDBMUFrQRz63TziQ3wmKTQD7jj
   scRTQ8osNA8IcJuVcpuVIwv/wk8VpBVJS3PvHp40nbT0o8rp2cl4FUBtN
   iMdpwYWS1VYEsT4gCxC63pIc2Mb2z2czEq1A84X5OzOooW8VTPDRmsNq1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="391985955"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391985955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876389590"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="876389590"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 23 Jan 2024 08:04:40 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v7 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-5-haitao.huang@linux.intel.com>
 <CYLIJZZJON62.24BNN310T3B2F@suppilovahvero>
Date: Tue, 23 Jan 2024 10:04:40 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2h0b9dglwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CYLIJZZJON62.24BNN310T3B2F@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 22 Jan 2024 14:25:53 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> SGX Enclave Page Cache (EPC) memory allocations are separate from normal
>> RAM allocations, and are managed solely by the SGX subsystem. The
>> existing cgroup memory controller cannot be used to limit or account for
>> SGX EPC memory, which is a desirable feature in some environments.  For
>> example, in a Kubernates environment, a user can request certain EPC
>> quota for a pod but the orchestrator can not enforce the quota to limit
>> runtime EPC usage of the pod without an EPC cgroup controller.
>>
>> Utilize the misc controller [admin-guide/cgroup-v2.rst, 5-9. Misc] to
>> limit and track EPC allocations per cgroup. Earlier patches have added
>> the "sgx_epc" resource type in the misc cgroup subsystem. Add basic
>> support in SGX driver as the "sgx_epc" resource provider:
>>
>> - Set "capacity" of EPC by calling misc_cg_set_capacity()
>> - Update EPC usage counter, "current", by calling charge and uncharge
>> APIs for EPC allocation and deallocation, respectively.
>> - Setup sgx_epc resource type specific callbacks, which perform
>> initialization and cleanup during cgroup allocation and deallocation,
>> respectively.
>>
>> With these changes, the misc cgroup controller enables user to set a  
>> hard
>> limit for EPC usage in the "misc.max" interface file. It reports current
>> usage in "misc.current", the total EPC memory available in
>> "misc.capacity", and the number of times EPC usage reached the max limit
>> in "misc.events".
>>
>> For now, the EPC cgroup simply blocks additional EPC allocation in
>> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
>> still tracked in the global active list, only reclaimed by the global
>> reclaimer when the total free page count is lower than a threshold.
>>
>> Later patches will reorganize the tracking and reclamation code in the
>> global reclaimer and implement per-cgroup tracking and reclaiming.
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> For consistency sake I'd also add co-developed-by for Kristen. This is
> at least the format suggested by kernel documentation.
>
>> ---
>> V7:
>> - Use a static for root cgroup (Kai)
>> - Wrap epc_cg field in sgx_epc_page struct with #ifdef (Kai)
>> - Correct check for charge API return (Kai)
>> - Start initialization in SGX device driver init (Kai)
>> - Remove unneeded BUG_ON (Kai)
>> - Split  sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)
>>
>> V6:
>> - Split the original large patch"Limit process EPC usage with misc
>> cgroup controller"  and restructure it (Kai)
>> ---
>>  arch/x86/Kconfig                     | 13 +++++
>>  arch/x86/kernel/cpu/sgx/Makefile     |  1 +
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 79 ++++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/sgx/epc_cgroup.h | 73 +++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/sgx/main.c       | 52 +++++++++++++++++-
>>  arch/x86/kernel/cpu/sgx/sgx.h        |  5 ++
>>  include/linux/misc_cgroup.h          |  2 +
>>  7 files changed, 223 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5edec175b9bf..10c3d1d099b2 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1947,6 +1947,19 @@ config X86_SGX
>>
>>  	  If unsure, say N.
>>
>> +config CGROUP_SGX_EPC
>> +	bool "Miscellaneous Cgroup Controller for Enclave Page Cache (EPC)  
>> for Intel SGX"
>> +	depends on X86_SGX && CGROUP_MISC
>> +	help
>> +	  Provides control over the EPC footprint of tasks in a cgroup via
>> +	  the Miscellaneous cgroup controller.
>> +
>> +	  EPC is a subset of regular memory that is usable only by SGX
>> +	  enclaves and is very limited in quantity, e.g. less than 1%
>> +	  of total DRAM.
>> +
>> +	  Say N if unsure.
>> +
>>  config X86_USER_SHADOW_STACK
>>  	bool "X86 userspace shadow stack"
>>  	depends on AS_WRUSS
>> diff --git a/arch/x86/kernel/cpu/sgx/Makefile  
>> b/arch/x86/kernel/cpu/sgx/Makefile
>> index 9c1656779b2a..12901a488da7 100644
>> --- a/arch/x86/kernel/cpu/sgx/Makefile
>> +++ b/arch/x86/kernel/cpu/sgx/Makefile
>> @@ -4,3 +4,4 @@ obj-y += \
>>  	ioctl.o \
>>  	main.o
>>  obj-$(CONFIG_X86_SGX_KVM)	+= virt.o
>> +obj-$(CONFIG_CGROUP_SGX_EPC)	       += epc_cgroup.o
>> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c  
>> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> new file mode 100644
>> index 000000000000..938695816a9e
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright(c) 2022 Intel Corporation.
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/kernel.h>
>> +#include "epc_cgroup.h"
>> +
>> +static struct sgx_epc_cgroup epc_cg_root;
>> +
>> +/**
>> + * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC  
>> page
>> + *
>> + * @epc_cg:	The EPC cgroup to be charged for the page.
>> + * Return:
>> + * * %0 - If successfully charged.
>> + * * -errno - for failures.
>> + */
>> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>> +{
>> +	if (!epc_cg)
>> +		return -EINVAL;
>
> Is there legit flow where the function is called with nil?
>
>> +
>> +	return  misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,  
>> PAGE_SIZE);
>               ~
> 	      extra space
>
>> +}
>> +
>> +/**
>> + * sgx_epc_cgroup_uncharge() - uncharge a cgroup for an EPC page
>> + * @epc_cg:	The charged epc cgroup
>> + */
>> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
>> +{
>> +	if (!epc_cg)
>> +		return;
>
> If there was, this function also should have a return value (i.e. return
> -EINVAL).
>
> This API does not look good tbh.
>
> Perhaps you want to emit error message in both functions? Now there is
> asymmetry that other goes silent and other returns error. I'm neither
> not sure why exactly -EINVAL was picked (does not mean the same that
> I would ultimately oppose picking that).
>
>
Good points.
I'll remove the NULL check for both cases. They should not happen if  
kernel is configured with EPC cgroup. There are separate versions when EPC  
cgroup disabled.

Thanks for your quick response.
Haitao

