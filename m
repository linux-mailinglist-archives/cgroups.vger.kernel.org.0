Return-Path: <cgroups+bounces-2601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E18AA57E
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FF4B21C27
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7126ACF;
	Thu, 18 Apr 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFjotqBQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AD1E515;
	Thu, 18 Apr 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480086; cv=none; b=RUbMg4qat0pCdK2/SwMolspw/DKfJQpa+BCJAyDh5mBrbybssfH4L5jm57ZUU1VkOo0kfGGPABuieh+sLz+W5dGz6WB5fWmwNSbd6vfdfb/UQmFkdR3Y7utiPicfxodEKr+p0B8coYKkkrFkMZH0WzMp8X1vfLMgsfb3daEin4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480086; c=relaxed/simple;
	bh=A6QaTnewEYxmDUbwpl7M5gyZzcy2ItrDDp4mRUf1hr0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=RwbiNP75lM1GR3RARTN8J+oxRztlxs26YyIDa6EiSMNwXPp13KXlLcR+gZqjc0W4qfcT5mIVZ7ue+ZyU4FAEP3HsEzdq5wUtS4n608+AHiAbk1BPyB2tnjwqegxEx/Nv4ZPNqt6YZmXLZwRpPJnhT9Pmx3ysyRfJKZnDoT53ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFjotqBQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713480084; x=1745016084;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=A6QaTnewEYxmDUbwpl7M5gyZzcy2ItrDDp4mRUf1hr0=;
  b=RFjotqBQzTHndWwPYwZRmU1q+s3BzhY59yO+3xutV0A05j5uVbYgsmbU
   qcqBdpdZiy0oMqVCBn+9k9L31jUsuO/jOPC7cIA9l2WLpbNJwvgFsgN4p
   fFkKA/KgwNrwgv6Ot0kpfuMdkBJJql+TOWeo5pODiikFSJsqhlCYngkJT
   Zn5T6KjBFsAK2IFNQGCn+uHT30Kebe1UqNVrXkW6EGSCYfpj0KRe4Ikvr
   6x2TdbjdzkYp/CHSXbETYAHH8NiXeuT7FitDUFgzdl9sy0AOC2LUyRXNO
   Vg7ESyg1ThlHIAKd/PPPE9E3HEW5DkJ9+wbjzAz/cGDcWqhZp0IjFEtlt
   Q==;
X-CSE-ConnectionGUID: 5livhsPdQMKdiHIQmRmhqg==
X-CSE-MsgGUID: Opu57L+MRAqMXWTAqY9bsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31541404"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31541404"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 15:41:23 -0700
X-CSE-ConnectionGUID: OY64cMoZSF+LN6FitKUziw==
X-CSE-MsgGUID: tBTwEOeXRYGaEZ4R1+ydaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23206320"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 18 Apr 2024 15:41:20 -0700
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
Subject: Re: [PATCH v12 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-6-haitao.huang@linux.intel.com>
 <a5e009636c5144622e0a910a459cd9d05976715e.camel@intel.com>
Date: Thu, 18 Apr 2024 17:41:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mf3ykfswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <a5e009636c5144622e0a910a459cd9d05976715e.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 08:22:06 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2024-04-15 at 20:20 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> SGX Enclave Page Cache (EPC) memory allocations are separate from normal
>> RAM allocations, and are managed solely by the SGX subsystem. The
>> existing cgroup memory controller cannot be used to limit or account for
>> SGX EPC memory, which is a desirable feature in some environments. For
>> instance, within a Kubernetes environment, while a user may specify a
>> particular EPC quota for a pod, the orchestrator requires a mechanism to
>> enforce that the pod's actual runtime EPC usage does not exceed the
>> allocated quota.
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
>> With these changes, the misc cgroup controller enables users to set a  
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
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Tejun Heo <tj@kernel.org>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> I don't see any big issue, so feel free to add:
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
>
Thanks

> Nitpickings below:
>
> [...]
>
>
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright(c) 2022-2024 Intel Corporation. */
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/kernel.h>
>
> It doesn't seem you need the above two here.
>
> Probably they are needed in later patches, in that case we can move to  
> the
> relevant patch(es) that they got used.
>
> However I think it's better to explicitly include <linux/slab.h> since
> kzalloc()/kfree() are used.
>
> Btw, I am not sure whether you want to use <linux/kernel.h> because looks
> it contains a lot of unrelated staff.  Anyway I guess nobody cares.
>

I'll check and remove as needed.

>> +#include "epc_cgroup.h"
>> +
>> +/* The root SGX EPC cgroup */
>> +static struct sgx_cgroup sgx_cg_root;
>
> The comment isn't necessary (sorry didn't notice before), because the  
> code
> is pretty clear saying that IMHO.
>

Was requested by Jarkko:
https://lore.kernel.org/lkml/CYU504RLY7QU.QZY9LWC076NX@suppilovahvero/#t

> [...]
>
>>
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _SGX_EPC_CGROUP_H_
>> +#define _SGX_EPC_CGROUP_H_
>> +
>> +#include <asm/sgx.h>
>
> I don't see why you need <asm/sgx.h> here.  Also, ...
>
>> +#include <linux/cgroup.h>
>> +#include <linux/misc_cgroup.h>
>> +
>> +#include "sgx.h"
>
> ... "sgx.h" already includes <asm/sgx.h>
>
> [...]
>
right

>>
>> +static inline struct sgx_cgroup *sgx_get_current_cg(void)
>> +{
>> +	/* get_current_misc_cg() never returns NULL when Kconfig enabled */
>> +	return sgx_cgroup_from_misc_cg(get_current_misc_cg());
>> +}
>
> I spent some time looking into this.  And yes if I was reading code
> correctly the get_current_misc_cg() should never return NULL when Kconfig
> is on.
>
> I typed my analysis below in [*].  And it would be helpful if any cgroup
> expert can have a second eye on this.
>
> [...]
>
Thanks for checking this and I did similar and agree with the conclusion.  
I think this is confirmed also by Michal's description AFAICT:
"
The current implementation creates root css object (see cgroup_init(),
cgroup_ssid_enabled() check is after cgroup_init_subsys()).
I.e. it will look like all tasks are members of root cgroup wrt given
controller permanently and controller attribute files won't exist."

>
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/highmem.h>
>>  #include <linux/kthread.h>
>>  #include <linux/miscdevice.h>
>> +#include <linux/misc_cgroup.h>
>
> Is this needed?  I believe SGX variants in "epc_cgroup.h" should be  
> enough
> for sgx/main.c?
>
> [...]
>
>
right

> [*] IIUC get_current_misc_cg() should never return NULL when Kconfig is  
> on
yes

[...]
Thanks
Haitao

