Return-Path: <cgroups+bounces-2718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241A8B5EC6
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1D1C20D86
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06845839FD;
	Mon, 29 Apr 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At6VKUvz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE68537E4;
	Mon, 29 Apr 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407501; cv=none; b=ODi7PrE6G6CCUVgeChkoNSqVVQW888sLJuQE7zDOmd/s5iczPjv/0eYGQbbLTDPKbTapO25Qf65sqKD6P+bhHG1Kvx32oARXt8SVyG86/f18EyZvjuRhEtP5ET3Pq51IdaoBUzP8tJ9IxEsFJs+ZgaLwfnDSIcNNzpRJFadToVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407501; c=relaxed/simple;
	bh=LBuy7+u22XYLP6slU0hFcE1E69/icyzPjA7IvIwgCs8=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=T668NGQ53OpxxoHXTOwONIOJ6nibskTGkq8I9eF3M/ukhbfpNq8zf8r04LDamDrxcQeODrRor5eKJsslLvJtfaYzyJ9tzOzEkaEXFHOwaRHsC28h8zIMKDXIMc/HtNO1vgU3JbBcK2RoF3GhvZHQ7JoLUo8yUJkXV8xxr68VFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At6VKUvz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714407501; x=1745943501;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LBuy7+u22XYLP6slU0hFcE1E69/icyzPjA7IvIwgCs8=;
  b=At6VKUvzcngJUp8jAPC/hc80BeqMoiZPsjus87T97vr6KFM8W838xjTn
   EfCPGYJxRnXOKM2F6Pj3+G8OkPhoiuuqUP0FPSGVJQNnOP5g6tiJBMQch
   wrl7+iRwnkxSJKR2wHrkw8Y8/JffX5SWN07rU6ZGG+gI6ubkGTfOE9uQ1
   K73nWKWRUk1gIjf0fgU5uy3Ron+U66fBhwy33P93+CrwjQUc8HUeBn7rw
   OWaQbkVbB1OwbaUz0SeDN/7K4O0Phii34jAkqaYOEGOgq2tJbLUr6gWLo
   aSsT0170cSbxWqLg0yJQQc75c3KDvL3KKF2y3KaA89VkP33aLTu5rpGFT
   A==;
X-CSE-ConnectionGUID: nFiGjjsES/GFxql0H359sQ==
X-CSE-MsgGUID: S0MmgxErS2aok/UjIquNgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10199467"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10199467"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:18:20 -0700
X-CSE-ConnectionGUID: 83HsGjfeQ5urAXVdohNFBQ==
X-CSE-MsgGUID: v2qtS/nVTt2Kt8SNCPtNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26265079"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.99.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 29 Apr 2024 09:18:16 -0700
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
Date: Mon, 29 Apr 2024 11:18:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mzzkowowjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0W3G5GVNMMW.3OCGUH8AYNORY@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

Hi Jarkko

On Sun, 28 Apr 2024 17:03:17 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Fri Apr 26, 2024 at 5:28 PM EEST, Dave Hansen wrote:
>> On 4/16/24 07:15, Jarkko Sakkinen wrote:
>> > On Tue Apr 16, 2024 at 8:42 AM EEST, Huang, Kai wrote:
>> > Yes, exactly. I'd take one week break and cycle the kselftest part
>> > internally a bit as I said my previous response. I'm sure that there
>> > is experise inside Intel how to implement it properly. I.e. take some
>> > time to find the right person, and wait as long as that person has a
>> > bit of bandwidth to go through the test and suggest modifications.
>>
>> Folks, I worry that this series is getting bogged down in the selftests.
>>  Yes, selftests are important.  But getting _some_ tests in the kernel
>> is substantially more important than getting perfect tests.
>>
>> I don't think Haitao needs to "cycle" this back inside Intel.
>
> The problem with the tests was that they are hard to run anything else
> than Ubuntu (and perhaps Debian). It is hopefully now taken care of.
> Selftests do not have to be perfect but at minimum they need to be
> runnable.
>
> I need ret-test the latest series because it is possible that I did not
> have right flags (I was travelling few days thus have not done it yet).
>
> BR, Jarkko
>

Let me know if you want me to send v13 before testing or you can just use  
the sgx_cg_upstream_v12_plus branch in my repo.

Also thanks for the "Reviewed-by" tags for other patches. But I've not got  
"Reviewed-by" from you for patches #8-12 (not sure I missed). Could you go  
through those alsoe when you get chance?

Thanks
Haitao

 

