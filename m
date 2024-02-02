Return-Path: <cgroups+bounces-1312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C408474E5
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1500D285395
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC61487DD;
	Fri,  2 Feb 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cpnnbu+K"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8057C6E9;
	Fri,  2 Feb 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891676; cv=none; b=VP7LOWww4MDwugF6dCcWjEV8GaWUX3ZlQcC3MF5zgMzn4jhice5PasoZe/1uyBINxapYmPoQYyro3Bgjv6PmXZ5NLOK4afH1kUdomfVV0/24M8741u1hcSH6KtGvUP2zhMzsiDFEbDXydWagzb750pmgCfBANueBQbUAyuyBcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891676; c=relaxed/simple;
	bh=b2ZLcg7YJ/dyepz/uVVFTYoYTOKVDQ4haDq9y0IB7yw=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=q7ArQQFTjBg9dZBx3tTrnzRYNsXs3lIt60z++1BYlsFrrrKPn3W6VByF2iJTvifkmyucLkCT3A4rWtMY/P4NXAmgyogxlfYqU8FiE1E+ih5yJxz/y/NXe2CBe9YcMVz3RVHlGvMpjIcTvscJzNXIz323jRjvg8nzriDGftBajQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cpnnbu+K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706891674; x=1738427674;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=b2ZLcg7YJ/dyepz/uVVFTYoYTOKVDQ4haDq9y0IB7yw=;
  b=Cpnnbu+KVRXqrAkSVjDn0TaB6BG3FDgZUYE82VRTpyTqSX1+oTBnB9qR
   xwGH9PXqG1qfWIzwwingZSyEEZ72mbtnmWm9OTKtjfMn0x7SFOpXCENoI
   5Z/hRyHoGV5VGM1FkttZ3cNDmiy93rIcJHtnbYsG2/a3VSkAMq1nSvixs
   Mb85ApP9GKK9HJG/cYBNXFKquu1uYCPhCUIvFQRBptddFj449CuEyK5Wq
   XqAGPtulOFyIX3pSfLSlcwu4h5T6tmwjYMIXvaOblO4+HIvGtb0WZ+LN7
   U+4DVzQm0fXVtHQWRvVx5kgkzGww0cZnAySs1VcgbL2Lu3lD38e5yj6Re
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17604796"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17604796"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="122759"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Feb 2024 08:34:31 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v8 01/15] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-2-haitao.huang@linux.intel.com>
 <CYU4P2CYNVSK.1UECAD4N86P8Z@suppilovahvero>
Date: Fri, 02 Feb 2024 10:34:29 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2iiwbrjpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CYU4P2CYNVSK.1UECAD4N86P8Z@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 01 Feb 2024 17:24:40 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> The misc cgroup controller (subsystem) currently does not perform
>> resource type specific action for Cgroups Subsystem State (CSS) events:
>> the 'css_alloc' event when a cgroup is created and the 'css_free' event
>> when a cgroup is destroyed.
>>
>> Define callbacks for those events and allow resource providers to
>> register the callbacks per resource type as needed. This will be
>> utilized later by the EPC misc cgroup support implemented in the SGX
>> driver.
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V8:
>> - Abstract out _misc_cg_res_free() and _misc_cg_res_alloc() (Jarkko)
>> V7:
>> - Make ops one per resource type and store them in array (Michal)
>> - Rename the ops struct to misc_res_ops, and enforce the constraints of  
>> required callback
>> functions (Jarkko)
>> - Moved addition of priv field to patch 4 where it was used first.  
>> (Jarkko)
>>
>> V6:
>> - Create ops struct for per resource callbacks (Jarkko)
>> - Drop max_write callback (Dave, Michal)
>> - Style fixes (Kai)
>
> This version looks nice and smooth:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko
>
Thanks Jarkko!

@tj, I had your Reviewed-by tags previously but dropped it due to some  
changes for refactoring suggested by other reviewers. Could you take a  
look at patches 1-2 for MiscController and confirm if I can have your  
Reviewed-by tags again?
Thanks

Haitao

