Return-Path: <cgroups+bounces-2720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A898B5FD4
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CC31C21532
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFA8627B;
	Mon, 29 Apr 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyLWtJPU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7C83CBA;
	Mon, 29 Apr 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410879; cv=none; b=AlRho7zv83soi+7+qWZPYXMbApPGsXxq66FpbUKxJ8vkjeAIYR4M7gGDmlV9lLLcIKe5w/1S4VQa4Evh91bdmfY4B5Ptz29sx/JldOjp14FVClT1K5dxfpIuWTr2l8V/xIOdhFpFdEF3E5vZ8YD+gj2SzrrH3k6pgaAEfd3NDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410879; c=relaxed/simple;
	bh=LFhDhAlcTNp4irr48KstARqghe7SJlpdE/8vhdM2+Lc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=oz0WlD34eiygpu9NrqeNXJYkfJmfty4L6iNidmMP1Oa+dkg2EVFfuWE/62F2ht/1xDMFEaem+Lqui7xvAUFLHigPUlng8HKNBSzP1GJCcOzjbuBsT/YT2I9Uc3Rrptshdg9MgkgWuuGMMz9k9NRye3ErlK/O3fBLSwy3svCceAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyLWtJPU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714410877; x=1745946877;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LFhDhAlcTNp4irr48KstARqghe7SJlpdE/8vhdM2+Lc=;
  b=FyLWtJPU78TwnqquYRivTDAgPrE4mRoJyFLRw0/03K5q/ahaA8D/4ptF
   obAYt1M+pitfmlm3vNc7BqgJpkhUbgtjgSaQ42GpJ05YiMWFXtcoLwp+C
   Wyq5mxBmkE4zroAN1iO/oCwewY6nZoUwBFmfrEeAqH+uAh6xpChO316kN
   28eIKxKT5+gHAZ/mZEPm0P0iGxPZDwxmPn30AYpKPYhqRVIV4NRiq316+
   2IGyl6XnypKWA104DvKuBt5ytdvVas9BvOxmVQ294z0pFGxXeTNAtaIJV
   Qc1NKPa11nCL3twyGKKviZyY0kTv+gimpsY5J6nCPNkJaa612D5WSz3rg
   g==;
X-CSE-ConnectionGUID: 8FG4BPvhTqyrKzF0+8H7/g==
X-CSE-MsgGUID: HLMo+Jx2SFW72wI8sYCtLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21236489"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="21236489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:14:37 -0700
X-CSE-ConnectionGUID: 4wZwqHyiSB6OCwBv47OV8A==
X-CSE-MsgGUID: Q9MowttDShiXJc9yKhRJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30972200"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.99.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 29 Apr 2024 10:14:33 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Dave Hansen" <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org"
 <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
 <D0LLZTSVG3BC.8WIRM39WC7UU@kernel.org>
 <f62c29ec-f893-4320-8097-f6b3a372267a@intel.com>
 <D0W3G5GVNMMW.3OCGUH8AYNORY@kernel.org>
 <op.2mzzkowowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0WR9J2AICDK.GM1G85DEHDDF@kernel.org>
Date: Mon, 29 Apr 2024 12:14:31 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mz16ha3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0WR9J2AICDK.GM1G85DEHDDF@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 29 Apr 2024 11:43:05 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Apr 29, 2024 at 7:18 PM EEST, Haitao Huang wrote:
>> Hi Jarkko
>>
>> On Sun, 28 Apr 2024 17:03:17 -0500, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Fri Apr 26, 2024 at 5:28 PM EEST, Dave Hansen wrote:
>> >> On 4/16/24 07:15, Jarkko Sakkinen wrote:
>> >> > On Tue Apr 16, 2024 at 8:42 AM EEST, Huang, Kai wrote:
>> >> > Yes, exactly. I'd take one week break and cycle the kselftest part
>> >> > internally a bit as I said my previous response. I'm sure that  
>> there
>> >> > is experise inside Intel how to implement it properly. I.e. take  
>> some
>> >> > time to find the right person, and wait as long as that person has  
>> a
>> >> > bit of bandwidth to go through the test and suggest modifications.
>> >>
>> >> Folks, I worry that this series is getting bogged down in the  
>> selftests.
>> >>  Yes, selftests are important.  But getting _some_ tests in the  
>> kernel
>> >> is substantially more important than getting perfect tests.
>> >>
>> >> I don't think Haitao needs to "cycle" this back inside Intel.
>> >
>> > The problem with the tests was that they are hard to run anything else
>> > than Ubuntu (and perhaps Debian). It is hopefully now taken care of.
>> > Selftests do not have to be perfect but at minimum they need to be
>> > runnable.
>> >
>> > I need ret-test the latest series because it is possible that I did  
>> not
>> > have right flags (I was travelling few days thus have not done it  
>> yet).
>> >
>> > BR, Jarkko
>> >
>>
>> Let me know if you want me to send v13 before testing or you can just  
>> use
>> the sgx_cg_upstream_v12_plus branch in my repo.
>>
>> Also thanks for the "Reviewed-by" tags for other patches. But I've not  
>> got
>> "Reviewed-by" from you for patches #8-12 (not sure I missed). Could you  
>> go
>> through those alsoe when you get chance?
>
> So, I compiled v12 branch. Was the only difference in selftests?
>
> I can just copy them to the device.
>
> BR, Jarkko
>
The only other functional change is using BUG_ON() when workqueue  
allocation fails in sgx_cgroup_init(). It should not affect testing  
results.

Thanks
Haitao
 

