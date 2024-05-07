Return-Path: <cgroups+bounces-2816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250648BD9AC
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 05:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD321F22CA7
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B64C619;
	Tue,  7 May 2024 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jht/WCEf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A62905;
	Tue,  7 May 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052107; cv=none; b=TrmKML+u53hI0J9UUwHE5ZbYrTGEng1VMsvEAe4lyRR+lUKBMszl1pd6J3/nQbjPRqmncDUYc8kuBN33pIqSPAdvQtv0uLW8wEwUFvqgnlm4D4/erDHCjrYUHU1+OzAjcLSFOoFvHkvVSP8biKnGtzIQsAS5VH90EVuZBDPkE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052107; c=relaxed/simple;
	bh=QrF9TwEH0bSyakVTwuwlcAamVHR4GvbvPuF+3SepQ0o=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=usN0Pe94tbd127LvtoIK+OOqzSzZYOSzup6POmHAWTyv3Kt2D6fZHrzpnwAwpmM87OGm8MiZHQx43ut9yHIGURj1ajOYc0tDMjeK1VHXABTawSdo7cLd1sS0cDINyehSWxskT3jokz8+6zto8Po073jEE6hi/KdGFI5RQ1GasmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jht/WCEf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715052106; x=1746588106;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=QrF9TwEH0bSyakVTwuwlcAamVHR4GvbvPuF+3SepQ0o=;
  b=Jht/WCEfXdbbUNEutqNE9egp+9qQIFgkFmub8tplLV97qyT73nWvlgYb
   GU5CwSnc7IkrF5aV55uhb2LGn7tYNDe7kGvIl/axbNdzcL0iyZ/SgLxci
   eOfdU+6SFpFc5XkYolYmS9eMgPD+I1SN1GfghrZ1xKlxc/Yj+ofTuTG0P
   wZXFWX1371wq/ESvEdXB2ArnKK+h8vRZ4wzuXNeGMyGprsyioGkyAFDqs
   aa2iblZBoZ7+skOzqcgQ4LAsB+GcoLs/bubTbjSSeaIqXwo8jE/hBsGgl
   W97iiKoYl3gLAxO1/QGiwfq/kCS8SGmfYZ54lT5xSTELVhtYRK8KmS+H3
   A==;
X-CSE-ConnectionGUID: 0+8hWHR+RBKu97cTbHxrwg==
X-CSE-MsgGUID: dazL67NESOGaL5pv55IJ6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="33327748"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33327748"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 20:21:45 -0700
X-CSE-ConnectionGUID: lLZ22eSTT6Oofk9l6SWAFg==
X-CSE-MsgGUID: MrrfXQK0SI+otFkiSj0D8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28951428"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.210.0])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 06 May 2024 20:21:41 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Huang, Kai" <kai.huang@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v13 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
 <20240430195108.5676-13-haitao.huang@linux.intel.com>
 <966e4afe-b177-4527-80c9-1146d2503c93@intel.com>
Date: Mon, 06 May 2024 22:21:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ndsydgywjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <966e4afe-b177-4527-80c9-1146d2503c93@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 06 May 2024 19:10:42 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 1/05/2024 7:51 am, Haitao Huang wrote:
>>     static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>>   {
>> -	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>> +	if (IS_ENABLED(CONFIG_CGROUP_MISC))
>> +		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
>> +	else
>> +		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>>   }
>>
>
> I think we have a problem here when we do global reclaim starting from  
> the ROOT cgroup:
>
> This function will mostly just only try to reclaim from the ROOT cgroup,  
> but won't reclaim from the descendants.
>
> The reason is the sgx_cgroup_reclaim_pages() will simply return after  
> "scanning" SGX_NR_TO_SCAN (16) pages w/o going to the descendants, and  
> the "scanning" here simply means "removing the EPC page from the  
> cgroup's LRU list".
>
> So as long as the ROOT cgroup LRU contains more than SGX_NR_TO_SCAN (16)  
> pages, effectively sgx_cgroup_reclaim_pages() will just scan and return  
> w/o going into the descendants.  Having 16 EPC pages should be a "almost  
> always true" case I suppose.
>
> When the sgx_reclaim_pages_global() is called again, we will start from  
> the ROOT again.
>
> That means the this doesn't truly reclaim "from global" at all.
>
> IMHO the behaviour of sgx_cgroup_reclaim_pages() is OK for per-cgroup  
> reclaim because I think in this case our intention is we should try best  
> to reclaim from the cgroup, i.e., whether we can reclaim from  
> descendants doesn't matter.
>
> But for global reclaim this doesn't work.
>
> Am I missing anything?
>
Good catch. This is indeed a problem if pages in a higher level cgroup are  
always busy (being 'young').The reclamation loop starting from this group  
may be stuck in only shifting the pages from front to tail in this group  
and never tries to scan & reclaim pages in its descendants.

Though this may not happen often, I think it does require a fix. Will do  
it in v14 :-)

Thanks
Haitao

