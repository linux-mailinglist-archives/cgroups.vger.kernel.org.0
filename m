Return-Path: <cgroups+bounces-2649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC1D8AD1BB
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE70286CAF
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B8153816;
	Mon, 22 Apr 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2WK9qIZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16A153805;
	Mon, 22 Apr 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802650; cv=none; b=gfX2zeA7HR9tI5MufyabFApEW9Asu6vpOGNqPgsHemCZ0j4kzgMez9YS5rRoNhngnhJxxaLTt3oLpFHJyQBnD+BrAitq62xSnmtBVaqQ9u5XDnPu9igAtdV6s5LR7t5kryqeSPxgk+VAQQJs/ooYs4eXsHzBVlXI+pSR0BXqnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802650; c=relaxed/simple;
	bh=CHj5J2SiKW93Q/oMEtlJw3ktWz2ajC1KqAP798B8a1w=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=I9ZsN54PcuPXZVNyjy5+7XNUNEmHxEF1eOlcvT0loVM4SXd74NiHsCcVwCgZe/U8efoubzxns2dLi0XSZqCMPHgdBjLiVxZfgEygGeVcdPgwphPkq9TBrbKFN1jj8IT8xiwUN/htIjUoDulKY+4q0LBdEK93WWG0gl3mc4BSCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2WK9qIZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713802649; x=1745338649;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=CHj5J2SiKW93Q/oMEtlJw3ktWz2ajC1KqAP798B8a1w=;
  b=T2WK9qIZ4lxUPkCGeU9xHKbd17/MzD+VX6F4c+MZj5wb4urWuRgWpLYu
   N847rAtDh2U3Rdl+dRU+Ukhjv0iD+bcPvoaO0tFiVgfTKsBQ7Y2wSexp9
   4qEMSxrvlH10NogSRLujOHB1jhjs00+0osnG3h7rE2sqcuOeWSQzjJVDg
   3tNPcxC3ylp5TP/o/M8AVu7aDFqaacoZTy/99wMPImSv/QjiD0WHnWug/
   ArbjiZzHCJR7G34LMbBo8Plr416PCIIevqCqJx3Vf6ZdeAoseSMd6EXO0
   0zZdV2igtnrg2q9/atRues5+ERCfmvlwKQ7BFMO/qlG20tsaN3NYIMqkw
   Q==;
X-CSE-ConnectionGUID: kvKBkooqRTaI0ypV09lAMg==
X-CSE-MsgGUID: rqtCjlEzTeGImVIthpdarw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31841215"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="31841215"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:17:27 -0700
X-CSE-ConnectionGUID: 33tcsd0TR5eTtVLq8D5tJg==
X-CSE-MsgGUID: P8l2lfn/QteslRZxuP55ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24582524"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 22 Apr 2024 09:17:24 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org"
 <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
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
 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
Date: Mon, 22 Apr 2024 11:17:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Sun, 21 Apr 2024 19:22:27 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2024-04-19 at 20:14 -0500, Haitao Huang wrote:
>> > > I think we can add support for "sgx_cgroup=disabled" in future if  
>> indeed
>> > > needed. But just for init failure, no?
>> > >
>> >
>> > It's not about the commandline, which we can add in the future when
>> > needed.  It's about we need to have a way to handle SGX cgroup being
>> > disabled at boot time nicely, because we already have a case where we 
>> > need
>> > to do so.
>> >
>> > Your approach looks half-way to me, and is not future extendible.  If  
>> we
>> > choose to do it, do it right -- that is, we need a way to disable it
>> > completely in both kernel and userspace so that userspace won't be  
>> able> to
>> > see it.
>>
>> That would need more changes in misc cgroup implementation to support 
>> sgx-disable. Right now misc does not have separate files for different 
>> resource types. So we can only block echo "sgx_epc..." to those  
>> interfacefiles, can't really make files not visible.
>
> "won't be able to see" I mean "only for SGX EPC resource", but not the
> control files for the entire MISC cgroup.
>
> I replied at the beginning of the previous reply:
>
> "
> Given SGX EPC is just one type of MISC cgroup resources, we cannot just
> disable MISC cgroup as a whole.
> "
>
Sorry I missed this point. below.

> You just need to set the SGX EPC "capacity" to 0 to disable SGX EPC.  See
> the comment of @misc_res_capacity:
>
>  * Miscellaneous resources capacity for the entire machine. 0 capacity
>  * means resource is not initialized or not present in the host.
>

IIUC I don't think the situation we have is either of those cases. For our  
case, resource is inited and present on the host but we have allocation  
error for sgx cgroup infra.

> And "blocking echo sgx_epc ... to those control files" is already
> sufficient for the purpose of not exposing SGX EPC to userspace, correct?
>
> E.g., if SGX cgroup is enabled, you can see below when you read "max":
>
>  # cat /sys/fs/cgroup/my_group/misc.max
>  # <resource1> <max1>
>    sgx_epc ...
>    ...
>
> Otherwise you won't be able to see "sgx_epc":
>
>  # cat /sys/fs/cgroup/my_group/misc.max
>  # <resource1> <max1>
>    ...
>
> And when you try to write the "max" for "sgx_epc", you will hit error:
>
>  # echo "sgx_epc 100" > /sys/fs/cgroup/my_group/misc.max
>  # ... echo: write error: Invalid argument
>
> The above applies to all the control files.  To me this is pretty much
> means "SGX EPC is disabled" or "not supported" for userspace.
>
You are right, capacity == 0 does block echoing max and users see an error  
if they do that. But 1) doubt you literately wanted "SGX EPC is disabled"  
and make it unsupported in this case, 2) even if we accept this is "sgx  
cgroup disabled" I don't see how it is much better user experience than  
current solution or really helps user better.

Also to implement this approach, as you mentioned, we need workaround the  
fact that misc_try_charge() fails when capacity set to zero, and adding  
code to return root always? So it seems like more workaround code to just  
make it work for a failing case no one really care much and end result is  
not really much better IMHO.

Thanks
Haitao
 

