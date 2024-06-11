Return-Path: <cgroups+bounces-3150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94404903C88
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D669285B8F
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F717C9E5;
	Tue, 11 Jun 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu/MGY9J"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2917C7D7;
	Tue, 11 Jun 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110648; cv=none; b=MryCXVErrDiCR4Dl+pUZmlZXuKWjVRdmnNND1RrznIukuuQveidevleUe7z78MJLHmE1jPqu3FNJ76Ao23S8/MSbc/uFumbsLmvazNreWotJmhjwLPvCygkdZdvDpmG47fx80y/EZULlo23yL9mbJtvph1pmspF6bX7ZOWfmWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110648; c=relaxed/simple;
	bh=PWWDzfSWd9/nnb5y9vXREzc9L1U6HRcjY2NFT0Ig/jc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=F/wlv7t/nw4Pg+ZPrALTGQ0Vuye9t9tN87hsJMO9vS7bmnO0MYr7daAE5Q27lMYvbpaTS9gAZQ39wZEPGdvAUlxiL76WeH/2ZLXy4LilbglRRd0rIm+kEnxgLD3QPBnDGSCCFarBMuDvtyMthlrWSZ7Sx0XCIl4WtZU7NXvX4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu/MGY9J; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718110647; x=1749646647;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=PWWDzfSWd9/nnb5y9vXREzc9L1U6HRcjY2NFT0Ig/jc=;
  b=Hu/MGY9JUVZ7bnAJHD2025Nr+90F9l/VsfQoQZw+pBz4jM8rSMXHtdoo
   nKg9Nur70Z0p1aJ+qOOPYhppE45vrMwF4/WFLsPUcefKIbU7wm0mnhL4N
   abWvQ1V22+2yfWcIxYZQuQtZpt5P1ZNeBFF13wMitfiQpuyoY1ufuD5Ey
   E/ZV2TFssbxzX/t3WV9ETEXigcnPozmbau6LTDQTWoF+wXomgCYhVS8+L
   v0Yr1+1B8H3uzb//pXaN5H3fuPRob5qBXLhmMoAzNu55wZwB0IQ53Ovnb
   It7IL0rnOtKp8eXOLfu4g6NRAEQe1CQX6inSZ2bgGS8HliO2AYbJJdJM9
   Q==;
X-CSE-ConnectionGUID: h4O02/GxRHWqF0L1kkuwvg==
X-CSE-MsgGUID: bAUu1fkzTbeO1m7zbF19HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26219143"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="26219143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:57:25 -0700
X-CSE-ConnectionGUID: NnBFlailT9O0S07Mk3/UCg==
X-CSE-MsgGUID: NGR1aXFPQ6uJAXlJl2f/Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44377196"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 11 Jun 2024 05:57:22 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com"
 <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Huang, Kai" <kai.huang@intel.com>
Cc: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
 "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
 <op.2ox4ccz7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb36980a-2a81-426b-82fb-7f598f7a0037@intel.com>
Date: Tue, 11 Jun 2024 07:57:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2o7cxtg8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <eb36980a-2a81-426b-82fb-7f598f7a0037@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 10 Jun 2024 17:39:53 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -1045,7 +1045,7 @@ static int __init sgx_init(void)
>>        if (!sgx_page_cache_init())
>>            return -ENOMEM;
>>  -    if (!sgx_page_reclaimer_init()) {
>> +    if (!sgx_page_reclaimer_init() || !sgx_cgroup_init()) {
>>            ret = -ENOMEM;
>>            goto err_page_cache;
>>        }
>
> Does it make more sense to move the sgx_cgroup_init() to the  
> sgx_drv_init()?  The SGX cgroup only works for the driver side anyway.  
> In this case, if something went wrong in sgx_cgroup_init(), the  
> sgx_vepc_init() could still have a chance to work.
>

vepc reclamation is not done by cgroup/ksgxd but try_charge() won't work  
if user expecting cgroup to limit vepc allocation. Would it be more  
consistent to just disable vepc, i.e., on system with MISC, sgx/vepc  
always go with cgroup enabled?

> And IIUC we need to reset the "capacity" to 0 if sgx_cgroup_init()  
> fails, no matter it is called inside sgx_drv_init() or sgx_init(),  
> otherwise the "epc" would appear in the cgroup hierarchy as a misc  
> cgroup resource.
>
> Another option is to defer setting the capacity to the point where we  
> have made sure sgx_drv_init() and sgx_cgroup_init() cannot fail.
>

Yes agree we need do this.
> Btw, I plan to review the rest from late of this week or next week  
> because this week I have some other staff needs to be finished first.
>

Sure. Thanks
Haitao

