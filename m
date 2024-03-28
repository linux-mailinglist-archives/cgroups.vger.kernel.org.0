Return-Path: <cgroups+bounces-2217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2288F5B2
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 04:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CB11F2D12A
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8E2C1BC;
	Thu, 28 Mar 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvIuzk5d"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06891DA5E;
	Thu, 28 Mar 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595165; cv=none; b=hfR5vz5UcYFp6cA2aLER7zSuWFugHL3cotnKBOX2IyPucqy4MLhOnB+/CLdYJi9nYmNnM4Y2tKwYQ19AZbXpdQMCSxtX4d5qssSREXLjcEZE+5AiCun1dVd/OxFjHhdOIddbDZ3laoNr+jFIaGrNQSsvD318sOQ5+IpDF282i28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595165; c=relaxed/simple;
	bh=g0Nb94nfMdyYyE/DQ8SREHcKOrjTBEc5s7J+WY32GCY=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=X5UdoeaqH/TqoSgrRDhbFjM8dsH+eWNPcX5pkiAJWb6mgnveh9lhD1Qmcueq2u8tzMYXNHwCzCPEs2IjtyvXXTu8XXa6u4eP/wrnzPTVMQultyRM5557HXSOxiWFSjg7cxly1joiLuf8+0xZdVQU6v7hqAWVDsk+mr8b9n9JM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvIuzk5d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711595164; x=1743131164;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=g0Nb94nfMdyYyE/DQ8SREHcKOrjTBEc5s7J+WY32GCY=;
  b=VvIuzk5dROVlYaQbAYZZzcviz9ZvMKJ9GPhG0GwECSiuy/Xzx1/6ouUq
   Fd8wLNF0dmTN5cS4WUtt9Zq+f44mVBxOfycA7BjvIx/S5RjA7o53oRsuX
   cjc6XO9abhxfbhwvgcKlBdhQye5EalejE2UV6iyyWc/lv38t5drgCNsrv
   1Hqgv/Mbz1Ur68vbCTjigmPiLSkPW88E/zLUwLV4yEJe92f+fnzPvgd38
   VNcmXFNo7eJNtZtX2dxOBrWsiYbfELdk2lMqFMnvg10hmEXK/VVcAWny6
   KyTL2fJMlSHIgDGa5mRthhLUnsG1okf+xqwkrHVgR2SXeGhhRkAeSWYXC
   g==;
X-CSE-ConnectionGUID: PchohIYbQ6iegMAB0Wb3AA==
X-CSE-MsgGUID: 0DNWvGaoSY+9mySedPJPFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24222391"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="24222391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 20:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17124206"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Mar 2024 20:06:00 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Haitao Huang"
 <haitao.huang@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Wed, 27 Mar 2024 22:05:59 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lbpj9nawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 27 Mar 2024 19:57:26 -0500, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> On Wed, 27 Mar 2024 11:56:35 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
> wrote:
>
>> On Wed Mar 27, 2024 at 2:55 PM EET, Jarkko Sakkinen wrote:
>>> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>>> > The scripts rely on cgroup-tools package from libcgroup [1].
>>> >
>>> > To run selftests for epc cgroup:
>>> >
>>> > sudo ./run_epc_cg_selftests.sh
>>> >
>>> > To watch misc cgroup 'current' changes during testing, run this in a
>>> > separate terminal:
...
>>> > wait_and_detect_for_any() {
>>>
>>> what is "any"?
>>>
>>> Maybe for some key functions could have short documentation what they
>>> are and for what test uses them. I cannot possibly remember all of this
>>> just by hints such as "this waits for Any" ;-)
>>>
>>> I don't think there is actual kernel guideline to engineer the script
>>> to work with just ash but at least for me that would inevitably
>>> increase my motivation to test this patch set more rather than less.
>>
>> I also wonder is cgroup-tools dependency absolutely required or could
>> you just have a function that would interact with sysfs?
>
> I should have checked email before hit the send button for v10 :-).
>
> It'd be more complicated and less readable to do all the stuff without  
> the cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only  
> depends on libc so I hope this would not cause too much inconvenience.
>
> I saw bash was also used in cgroup test scripts so at least that's  
> consistent :-)
> I can look into ash if that's required. Let me know.
>

Sorry I missed you earlier comments. I actually tried to make it  
compatible with busybox on Ubuntu.

I'll address your other comments and update. But meanwhile could you  
tryout this version in your env?

https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4b537fbc3bbff6f

Thanks
Haitao

