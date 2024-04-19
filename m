Return-Path: <cgroups+bounces-2626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB088AB4E2
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8763281792
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF413B780;
	Fri, 19 Apr 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmJZlG+W"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FB130A5B;
	Fri, 19 Apr 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550522; cv=none; b=qKnZhRyworv6VzW3WT1dDQbOwaRTcQJVseNiHRW7SNRo0cbAqc3DqKgZHVQ4O1BaPMHVM9+H7ILtivSDs6QSGcyx1aUj4oKmdcYfMSOn1oyEiMJipAyprQ3Iq9d8xz+zvEqy+3dg689HzXMQzqTQ1M12jbp10khC/1+61nGflKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550522; c=relaxed/simple;
	bh=1CyKF1CDwhvwSPePXcZXWSY7Imlj5i23kiKngwm8hiQ=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=RgMFd/vb9CwHlbBK4ml/JRM0df7L7a89UXwhKnaNtqAXzvYIBz51A5uSBFDp4664WfowIz4i16m17gyGeU0hM/3suOoD1oRIa5yh6rC5lf6OT/uhWDaJOnGfBCTkKW0sTv89Z1INGgGduDU5kEBny6MOo7z+U2s9uCyJ1ne0ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmJZlG+W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713550521; x=1745086521;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=1CyKF1CDwhvwSPePXcZXWSY7Imlj5i23kiKngwm8hiQ=;
  b=nmJZlG+WUzJjvCp9vnw+oZEmGwHczXMZx/YJJvgrA5qbHPyAmn8JErXF
   Ckud7T5DY58gFaEKJqYCUIp2KEwwLU+/3a5O2DZ2sisNP/KINRMyZUSdv
   7EdzDjFWgSAq5Mhu2DnvIuJxQOnvEayX1KAw0m98Dkgxq3HAWdH6TVUu7
   1vomP8Qv1FvU4Jjjl9p4QnqSb+tiv01nTTdWcy/QE9jxZwcIvhrxfnaJn
   HWhQvNlqfOkgYY0Tlv4famw7ikm5pXTWvv7/RTuI0nX3ocfUQDLAQkH+m
   S2XwCxyzQZp6GEZrmkzqSiyMw2j3kmh/FcOsdbNJALJVZvifqWZBMfQsJ
   Q==;
X-CSE-ConnectionGUID: 0SLKGfn9RB+l3luNlFwbXQ==
X-CSE-MsgGUID: PBNnP44MTAyjeU+tHMfqRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9036514"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9036514"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 11:15:21 -0700
X-CSE-ConnectionGUID: 2PG7nB6VSgOCK/hIYTgz7w==
X-CSE-MsgGUID: J22koZ0gQO+BhjwRLbK9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23419118"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 19 Apr 2024 11:15:17 -0700
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
 <op.2mf3ykfswjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d401e7a1-44fa-44b6-9c6e-c0abdabd5111@intel.com>
Date: Fri, 19 Apr 2024 13:15:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mhmbqapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d401e7a1-44fa-44b6-9c6e-c0abdabd5111@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 18 Apr 2024 18:29:53 -0500, Huang, Kai <kai.huang@intel.com> wrote:


>>>>
>>>> --- /dev/null
>>>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>>>> @@ -0,0 +1,72 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef _SGX_EPC_CGROUP_H_
>>>> +#define _SGX_EPC_CGROUP_H_
>>>> +
>>>> +#include <asm/sgx.h>
>>>
>>> I don't see why you need <asm/sgx.h> here.  Also, ...
>>>
>>>> +#include <linux/cgroup.h>
>>>> +#include <linux/misc_cgroup.h>
>>>> +
>>>> +#include "sgx.h"
>>>
>>> ... "sgx.h" already includes <asm/sgx.h>
>>>
>>> [...]
>>>
>> right
>>
>>>>
>>>> +static inline struct sgx_cgroup *sgx_get_current_cg(void)
>>>> +{
>>>> +    /* get_current_misc_cg() never returns NULL when Kconfig enabled  
>>>> */
>>>> +    return sgx_cgroup_from_misc_cg(get_current_misc_cg());
>>>> +}
>>>
>>> I spent some time looking into this.  And yes if I was reading code
>>> correctly the get_current_misc_cg() should never return NULL when  
>>> Kconfig
>>> is on.
>>>
>>> I typed my analysis below in [*].  And it would be helpful if any  
>>> cgroup
>>> expert can have a second eye on this.
>>>
>>> [...]
>>>
>> Thanks for checking this and I did similar and agree with the  
>> conclusion. I think this is confirmed also by Michal's description  
>> AFAICT:
>> "
>> The current implementation creates root css object (see cgroup_init(),
>> cgroup_ssid_enabled() check is after cgroup_init_subsys()).
>> I.e. it will look like all tasks are members of root cgroup wrt given
>> controller permanently and controller attribute files won't exist."
>
> After looking I believe we can even disable MISC cgroup at runtime for a  
> particular cgroup (haven't actually verified on real machine, though):
>
>   # echo "-misc" > /sys/fs/cgroup/my_group/cgroup.subtree_control
>
My test confirms this is does not cause NULL cgroup for the tasks.
It actually works the same way as commandline disable except for that this  
only disables misc in subtree and does not show any misc.* files or allow  
creating such files in the subtree.

> And if you look at the MISC cgroup core code, many functions actually  
> handle a NULL css, e.g., misc_cg_try_charge():
>
> 	int misc_cg_try_charge(enum misc_res_type type,
> 				struct misc_cg *cg, u64 amount)
> 	{
> 		...
>
>          	if (!(valid_type(type) && cg &&
> 				READ_ONCE(misc_res_capacity[type])))
>                  	return -EINVAL;
>
> 		...
> 	}
>
> That's why I am still a little bit worried about this.  And it's better  
> to have cgroup expert(s) to confirm here.
>

I think it's just being defensive as this function is public API called by  
other parts of kernel. Documentation of task_get_css() says it always  
returns a valid css. This function is used by get_current_misc_cg() to get  
the css refernce.


/**
  * task_get_css - find and get the css for (task, subsys)
  * @task: the target task
  * @subsys_id: the target subsystem ID
  *
  * Find the css for the (@task, @subsys_id) combination, increment a
  * reference on and return it.  This function is guaranteed to return a
  * valid css.  The returned css may already have been offlined.
  */
static inline struct cgroup_subsys_state *
task_get_css(struct task_struct *task, int subsys_id)


If you look at the code of this function, you will see it does not check  
NULL either for task_css().

So I think we are pretty sure here it's confirmed by this documentation  
and testing.
Thanks
Haitao

