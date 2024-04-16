Return-Path: <cgroups+bounces-2549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EAE8A77BD
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 00:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9E2839B1
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642582481;
	Tue, 16 Apr 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvUMVHDb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0A1DDEE;
	Tue, 16 Apr 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306101; cv=none; b=QrAKzHnCoIRGa1mal6/54zo4mtZhqrZQ07V3bNKHCtzCYKrpLFHHSUNWwAvohxd1a54OMyhlEdJHhdERKBvv80uL+03zBaWLDnY9aW5i2u0sORaAZf9szxCeV7m+c6s1zZ92JlEL6JA9ui1rh+s4IXCnCYeYLeupwudh6LPQQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306101; c=relaxed/simple;
	bh=M5gQrJN78A1ObpmBenyDDmsu5o4tKBX3ccIZbR0GsnM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=j3RKLO2TyKffpvwCLZXVqHhDewDMG2rl099/GboI2/HXA2YuKLpiYdMPdxMQTj4CvQUlboPw0m6p58YxYzne6A6ZjQq0BG+g+6efrKiGjlIcENlaZj6kQxyIQzBMHMZdezGNleDuJ5haCw0KrtvmfKE3r8UdW3AfOEoWS37VNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvUMVHDb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713306100; x=1744842100;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=M5gQrJN78A1ObpmBenyDDmsu5o4tKBX3ccIZbR0GsnM=;
  b=OvUMVHDbLC8E9OF6yUE/wSYsd7H4Lgbb81ex52C+Jfgk2UYCjkgQFC25
   SbTe29ZTzNjTEIbLNHdJa/IacqjFxUkRxgoxXz+dGB66V4Pu18e0NAID0
   ecdwQOowY0V4m7wu1PaT7oOJL94m3Ji8NpGDsXpmAL+IiM5TBMVFtvR0+
   z+QzkTvwOEHr5bA5Y0tjG4EYGcyuoa1q8zi6yQvprQwB9g0Gh7czSiQ51
   YNm9RTQOtqfrJ8f25HZ7HVi9SRRORZ0jttwGJ6fqdbAnRDgN3mcWe76t7
   R5Rpab+/zjsZCvZDxLG9ZWzZkiELzDdL3UCCSwi0UFLNLheR56Q2Txq5m
   w==;
X-CSE-ConnectionGUID: X9MVg8KRRUK4iKv/ChCIew==
X-CSE-MsgGUID: FD3m712bTyKuSxlJgIM7dQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8904567"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8904567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:21:39 -0700
X-CSE-ConnectionGUID: kj5eQ0swQ3Ke+eceumFYhw==
X-CSE-MsgGUID: rzaBnjEHREi2kf8UZozdjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22816784"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 15:21:29 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao
 Huang" <haitao.huang@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org> <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
 <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
 <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Tue, 16 Apr 2024 17:21:24 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mcdpygvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 17:04:21 -0500, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
> wrote:
>
>> On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
>>> I did declare the configs in the config file but I missed it in my  
>>> patch
>>> as stated earlier. IIUC, that would not cause this error though.
>>>
>>> Maybe I should exit with the skip code if no CGROUP_MISC (no more
>>> CGROUP_SGX_EPC) is configured?
>>
>> OK, so I wanted to do a distro kernel test here, and used the default
>> OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.
>>
>>> tools/testing/selftests$ find . -name README
>>> ./futex/README
>>> ./tc-testing/README
>>> ./net/forwarding/README
>>> ./powerpc/nx-gzip/README
>>> ./ftrace/README
>>> ./arm64/signal/README
>>> ./arm64/fp/README
>>> ./arm64/README
>>> ./zram/README
>>> ./livepatch/README
>>> ./resctrl/README
>>
>> So is there a README because of override timeout parameter? Maybe it
>> should be just set to a high enough value?
>>
>> BR, Jarkko
>>
>
>
>  From the docs, I think we are supposed to use override.
> See:  
> https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftests
>
> Thanks
> Haitao
>

Maybe you are suggesting we add settings file? I can do that.
README also explains what the tests do though. Do you still think they  
should not exist?
I was mostly following resctrl as example.

Thanks
Haitao

