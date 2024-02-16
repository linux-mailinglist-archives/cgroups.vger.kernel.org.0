Return-Path: <cgroups+bounces-1680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049D858843
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 22:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5651C23244
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E517146900;
	Fri, 16 Feb 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj8vUAJx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B11D69A;
	Fri, 16 Feb 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120517; cv=none; b=PcU38KJXLeasgXjCQeczAe5yEffzhwr2x6HSSlDeg9+y+KtQFuUNVTCF1qSYCQI6YK2dmo6SDchJE58dLLKCzlJkcEvDAUWZ0aaexWqeZNwnQmo0nahi8f3e7MGvA64B6jCH48QoOJMxP2qQAzVehXaWq1mGLQeM5Y93PXNzuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120517; c=relaxed/simple;
	bh=JJi9BKz1Hy77qPlNe22+LLtX2HVuOnm2Jchu1KeoqhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlkdWgDsgkjbYMtlaIgSBYRlIFVPOW7gLkcwbrE2Oknr8iNS2zwH59i1+orRL44qALQsGFGIp9pWHOOrx97k0Ai7sDwJPslqmqv6TK1QYQctnVKMC/4Q7GlEWxcQx5BBCq5o8edUdr0vj8+M1mTP3flDJMLqT0sDqKG/bjpMEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj8vUAJx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708120515; x=1739656515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJi9BKz1Hy77qPlNe22+LLtX2HVuOnm2Jchu1KeoqhI=;
  b=Cj8vUAJxInn/6tib6y4RE1z1LOk+1PLl28sS4WJGT1hkz2CGts0+FsX8
   v8NYAU5OeEv1HNO06Gn5SbdpDVrO5MrxsFsfTsuxPyHVp7s891fVhLtzn
   bz5t29+qmgStUozZmp6RjNOEXFe2h6YeNRMHsEg2J0srQqCNsHyDfnbkb
   tLA8hJpRx/Df5mgta8Y7f+HcfUkqRh6ayyDmQ6zz/u+MM52oP923aiSdU
   tGDiaS5KfIDnZRqzcR1uxo4JcFv9p622UqEc7J+VJeB3RkJN/hcijgQ2w
   I7NFZEqDhGhQwhzvRMg3LNoM/PTupOxFt/GPk+BHyRqSNW3+PsKeQKzS8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2170230"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2170230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4240895"
Received: from smidford-mobl.amr.corp.intel.com (HELO [10.209.63.169]) ([10.209.63.169])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:55:11 -0800
Message-ID: <0ab99d42-c3fe-4415-b993-57fb1fec21a4@intel.com>
Date: Fri, 16 Feb 2024 13:55:10 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
Content-Language: en-US
To: Haitao Huang <haitao.huang@linux.intel.com>, jarkko@kernel.org,
 dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-10-haitao.huang@linux.intel.com>
 <a5bd910b-3148-47ec-9280-561cfe6c16df@intel.com>
 <op.2i87qioawjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <op.2i87qioawjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/24 13:38, Haitao Huang wrote:
> On Fri, 16 Feb 2024 09:15:59 -0600, Dave Hansen <dave.hansen@intel.com>
> wrote:
...
>> Does this 'indirect' change any behavior other than whether it does a
>> search for an mm to find a place to charge the backing storage?
> 
> No.
> 
>> Instead of passing a flag around, why not just pass the mm?
>>
> There is no need to pass in mm. We could just check if current->mm ==
> NULL for the need of doing the search in the enclave mm list.
> 
> But you had a concern [1] that the purpose was not clear hence suggested
> current_is_ksgxd().

Right, because there was only one possible way that mm could be NULL but
it wasn't obvious from the code what that way was.

> Would it be OK if we replace current_is_ksgxd() with (current->flags &
> PF_KTHREAD)? That would express the real intent of checking if calling
> context is not in a user context.

No, I think that focuses on the symptom and not on the fundamental problem.

The fundamental problem is that you need an mm in order to charge your
allocations to the right group.  Indirect reclaim means you are not in a
context which is connected to the mm that should be charged while direct
reclaim is.

>> This refactoring out of 'indirect' or passing the mm around really wants
>> to be in its own patch anyway.
>>
> Looks like I could do:
> 1) refactoring of 'indirect' value/enum suggested above. This seems the
> most straightforward without depending on any assumptions of other
> kernel code.
> 2) replace  current_is_ksgxd() with current->mm == NULL. This assumes
> kthreads has no mm.
> 3) replace current_is_ksgxd() with current->flags & PF_KTHREAD. This is
> direct use of the flag PF_KTHREAD, so it should be better than #2?
> 
> Any preference or further thoughts?

Pass around a:

	struct mm_struct *charge_mm

Then, at the bottom do:

	/*
	 * Backing RAM allocations need to be charged to some mm and
	 * associated cgroup.  If this context does not have an mm to
	 * charge, search the enclave's mm_list to find some mm
	 * associated with this enclave.
	 */
	if (!charge_mm)
		... do slow mm lookup
	else
		return mm_to_cgroup_whatever(charge_mm);

Then just comment the call sites where the initial charge_mm comes in:

	
	/* Indirect SGX reclaim, no mm to charge, so NULL: */
	foo(..., NULL);


	/* Direct SGX reclaim, charge current mm for allocations: */
	foo(..., current->mm);


