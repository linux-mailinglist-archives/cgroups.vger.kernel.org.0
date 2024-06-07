Return-Path: <cgroups+bounces-3127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC5900659
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F041F22C28
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A2196446;
	Fri,  7 Jun 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI+p1fRr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB791D530;
	Fri,  7 Jun 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770203; cv=none; b=eIqVp7e1muHJUhspfRdJSwIH+rsgTPz8bPxrMU1rhcI9M3BAovDXl27zaRgEEdTbDyW24TLW7vSoChLdchTv1kMqrjPvh9uRWs4qyiiwKflKdhsk+Lxb7PWT2cDIU15w05waNmu6eXbrQnzwt0eZNE8j4xUxRQrVGt80FzTvT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770203; c=relaxed/simple;
	bh=IsjGFL0NwnhIQdxK6PsEqSI1jgzkHzKCixEGCzLgbNg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=kl2oik2S65LbLhIVDaPhKftoE0Qj7g90hJR9B8D7c1Y6MnUaZ0SBhf0n+I1zfQzyh+uhAfpsgSkkRSH7gfS5FL9x92OwxxAAruNGlJ1hAlBL0tB4ykMK/WWcnSNSwPjKF2zdItypu7xqqsVo4qTG3V54qbYdyOpdVr4XyOmTm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI+p1fRr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717770201; x=1749306201;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=IsjGFL0NwnhIQdxK6PsEqSI1jgzkHzKCixEGCzLgbNg=;
  b=QI+p1fRrobP31ISeu/5fZh1i3yZi/FfFBc/AhYCuIva3Ku3N3JHkUOkG
   /ZZvAys296dafKw5OBi6BJWtSqo9OeDU5JLIzcEQ2yuq76qH9XY4eiEFY
   ZdKOy3rO4N02zQDXNMfI83LqKNy8C/mXOvECP7h66ltH3VvIWDy/gBUWk
   ++kZ5HKsQ+cgv+Vu2dDQy3VqwDhn+q0SeYCgQuG3gt8dMDiTdqj7wn2W2
   sM4RsNbukRwxlutQ2vUpR7o8MtenZlhuIcdZ4f2Fh0q6xOovpP+KNcST0
   b3OwxofIpft5Ba0fM2dLET2KKte/HNKTVSyDoLdLexDw5jpeHezSTBLjf
   g==;
X-CSE-ConnectionGUID: XfykR/32StCLPXFpgLo4bg==
X-CSE-MsgGUID: KpEzoOMcRHO9EOSJPeW+aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14233600"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14233600"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 07:23:20 -0700
X-CSE-ConnectionGUID: oDdqg0zxRXauu0ZecMGFfw==
X-CSE-MsgGUID: AWEyKtx7QjyhVFI7OqlLYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38449259"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 07 Jun 2024 07:23:17 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, chenridong
 <chenridong@huawei.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v14 02/14] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-3-haitao.huang@linux.intel.com>
 <eeb1f936-2989-4de0-8353-b2373ce47474@huawei.com>
 <op.2ox8wt11wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <683e88d8-aa34-40c0-a8d5-d7f8f9d4deee@huawei.com>
Date: Fri, 07 Jun 2024 09:23:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2oz17kjnwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <683e88d8-aa34-40c0-a8d5-d7f8f9d4deee@huawei.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 06 Jun 2024 20:53:11 -0500, chenridong <chenridong@huawei.com>  
wrote:

> I think it is better when _misc_cg_res_alloc fails, it just calls  
> _misc_cg_res_free(cg, index)(add index parameter, it means ending of  
> iterator), so it can avoid calling ->free() that do not call ->alloc().
>
> And in misc_cg_free, just call _misc_cg_res_free(cg, MISC_CG_RES_TYPES)   
> to free all.
>
That makes sense now, Will do that.
(BTW you need comment inline :-)
Thanks
Haitao

>
> On 2024/6/6 22:51, Haitao Huang wrote:
>> On Thu, 06 Jun 2024 08:37:31 -0500, chenridong <chenridong@huawei.com>  
>> wrote:
>>
>>>
>>>   If _misc_cg_res_alloc fails, maybe some types do not call ->alloc(),  
>>> but all types ->free() callback >will be called, is that ok?
>>>
>> Not sure I understand. Are you suggesting we ignore failures from  
>> ->alloc() callback in _misc_cg_res_alloc() as it is per-resource, and  
>> have ->free() callback and resource provider of the failing type to  
>> handle the failure internally?
>>
>> IIUC, this failure only happens when a specific subcgroup is created  
>> (memory running out for allocation) so failing that subcgroup as a  
>> whole seems fine to me. Note the root node is static and no  
>> pre-resource callbacks invoked by misc. And resource provider handles  
>> its own allocations for root. In SGX case we too declare a static  
>> object for corresponding root sgx_cgroup struct.
>>
>> Note also misc cgroup (except for setting capacity[res] = 0 at root) is  
>> all or nothing so no mechanism to tell user "this resource does not  
>> work but others are fine in this particular cgroup."
>>
>> Thanks
>> Haitao
>>
>


-- 
Using Opera's mail client: http://www.opera.com/mail/

