Return-Path: <cgroups+bounces-2723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B28B6776
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 03:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C391F21190
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875011C33;
	Tue, 30 Apr 2024 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwHpHHcw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59911113;
	Tue, 30 Apr 2024 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440688; cv=none; b=YBWmxEK4+j2Bl/4vrfoPbgMcyZjw3FFWZ6xOGp4NKolB7sxcuJavbM1SvQ0Z6Tmi5tdMB7cLn4hNbkP9ZGorjc0kkvUT4AlQBR0h1LEjr5hNFo/zCd5H7ni8NjLynrOnBsgbNreDFdawPzm1yZDrdtA6IUA/JOg3F+hM7anHhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440688; c=relaxed/simple;
	bh=qKjIDr0gSCslbsaRgOgQsyWYbY2pEVDT1J9XP6b6+os=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=YOV4hKd9odnIScNCD2D4l7gA3HnHS9nEbOtcxdKNfTNeFkJS3O5zfBZU321sYQGH7yzc3P+1QQ3XB2w8c/pgrVsekfDSsRyjvevzHMz+TgVRYShz5GNgju81D76XmE0tyqN+cXaJDa3h6l8vFRO2xuH+5IVKapxYT72lpi3ZN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwHpHHcw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714440687; x=1745976687;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=qKjIDr0gSCslbsaRgOgQsyWYbY2pEVDT1J9XP6b6+os=;
  b=HwHpHHcwN1pY4XH3ydmcBhvf2V8U+rjqrP4g/dDb3aDEOWhtWbd1dT4m
   K5iaotV7UV9ptYo1h85Ohnr5HDI5OSz2CM/XexPQ9/pbGta6v9P8doCN/
   CvCvwpp+SSJfjrFaCjVml+me/aV8eyoBM3Uz83xWXZwIq1v3QIM8Qfjg+
   xbHf+EsPZyBGKOILl6dp3+LFVTM65k67FoVxM8Ez+w9OieA0kRcw4s3aA
   K+2w9DbfpHM7QNCQoCO32hbfUrGMTD3j87XMPlrUW0Tfe/h11sySfm8ga
   pvooxU3o8xmcVdHDtAgENpPMRVZGs1VLdr1EAemJQGd9TNjZdHBp26y1M
   A==;
X-CSE-ConnectionGUID: HqC68nzVR/yAs5WawPyUZA==
X-CSE-MsgGUID: t1PFNj7DQjmo8xCsEXzigA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10002835"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10002835"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:31:26 -0700
X-CSE-ConnectionGUID: VfkDAxQQSUC4TLRF3ROS6Q==
X-CSE-MsgGUID: NTnYZp61RaOTpwE9o4cFJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26158313"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.99.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 29 Apr 2024 18:31:23 -0700
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
Subject: Re: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-13-haitao.huang@linux.intel.com>
 <524cf9b081d86ae61342fdfc370a3639d0010f94.camel@intel.com>
 <op.2mzyy7ktwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <5836260d-600d-4802-9f6a-b0bdb19ddbac@intel.com>
Date: Mon, 29 Apr 2024 20:31:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2m0o6j2bwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <5836260d-600d-4802-9f6a-b0bdb19ddbac@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 29 Apr 2024 17:18:05 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>>>>  /*
>>>> @@ -42,7 +63,8 @@ static inline struct sgx_epc_lru_list  
>>>> *sgx_lru_list(struct sgx_epc_page *epc_pag
>>>>   */
>>>>  static inline bool sgx_can_reclaim(void)
>>>>  {
>>>> -    return !list_empty(&sgx_global_lru.reclaimable);
>>>> +    return !sgx_cgroup_lru_empty(misc_cg_root()) ||
>>>> +           !list_empty(&sgx_global_lru.reclaimable);
>>>>  }
>>>
>>> Shouldn't this be:
>>>
>>>     if (IS_ENABLED(CONFIG_CGROUP_MISC))
>>>         return !sgx_cgroup_lru_empty(misc_cg_root());
>>>     else
>>>         return !list_empty(&sgx_global_lru.reclaimable);
>>> ?
>>>
>>> In this way, it is consistent with the sgx_reclaim_pages_global()  
>>> below.
>>>
>>  I changed to this way because sgx_cgroup_lru_empty() is now defined in  
>> both KConfig cases.
>> And it seems better to minimize use of the KConfig variables based on  
>> earlier feedback (some are yours).
>> Don't really have strong preference here. So let me know one way of the  
>> other.
>>
>
> But IMHO your code could be confusing, e.g., it can be interpreted as:
>
>    The EPC pages can be managed by both the cgroup LRUs and the
>    sgx_global_lru simultaneously at runtime when CONFIG_CGROUP_MISC
>    is on.
>
> Which is not true.
>
> So we should make the code clearly reflect the true behaviour.
>

Ok, I'll change back.
Thanks
Haitao

