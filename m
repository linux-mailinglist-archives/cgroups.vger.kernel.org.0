Return-Path: <cgroups+bounces-1225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AA83A012
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 04:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EB21F2957C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220E6123;
	Wed, 24 Jan 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/NWX0IE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72F1381;
	Wed, 24 Jan 2024 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066949; cv=none; b=DMpVQYDdqm+79JSKa0Yo/hw3aT94t6qbQxMYmJeNJ5C/U8x4fUdacBNoKRTvGWa3BTsjnZiEnYrzLC7503HYjC4GMqmf2GZkmKexI3GSP0P0Yf8W5vENLfP9Rr5w9cS/RO0ZusBKZLG+R2gn4+CPNtGZmEkQHcTvioeSVdmVEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066949; c=relaxed/simple;
	bh=LEKebXaU68il7ohv0EYVm0bpFq9dmjW5BYBJT6VpT8E=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Tlpn1vRYtrOhQSClihDoDaABVotQoMezJFneoEUToZIE72U8pprgx4wNimfDBHybRFA2Q4HRO2uuG4NnRg1l+TVpxdv69XQsF8U2R6HsFTq9mj6MOgLEdBiriEoGuNn9RxK3Q7wjdWI4Brh4rdaWSBpTlIMlZQWXp5qKYLieqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/NWX0IE; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706066947; x=1737602947;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LEKebXaU68il7ohv0EYVm0bpFq9dmjW5BYBJT6VpT8E=;
  b=D/NWX0IEjq+FluU77bRl1pe5ooB7wdWhx3Z63suva+c1WuIfXQWSUEOt
   DOzwCuBHa/ZLUOejgI1qvs45RnhnQXcaclGGNB3xbHm0IAIdzNl9oYfYg
   NdvidBC/XPglqlS3qePuFI0OAN0p6yXGkYchIli6WvN+WkblDBVbjND0W
   bOZkaKuFv9wre+PV488NBvDvoL09XE9+EfY+so/qx6trfsduNqehdooGW
   t1WdaUlWE+hCuYhB8pYOx6BHzD2FnEm3f0f2Cc61JOMKRXI9Wg6tVSSs5
   Sbh9JUk0ounTqNcwCWszzSZCfAA2oAneWNJ48WgaRGUbElaQ4Tb9Gf5eO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466002819"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="466002819"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1765232"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 23 Jan 2024 19:29:04 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v7 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-5-haitao.huang@linux.intel.com>
 <CYLIJZZJON62.24BNN310T3B2F@suppilovahvero>
Date: Tue, 23 Jan 2024 21:29:03 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2h07ypcmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CYLIJZZJON62.24BNN310T3B2F@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 22 Jan 2024 14:25:53 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> SGX Enclave Page Cache (EPC) memory allocations are separate from normal
>> RAM allocations, and are managed solely by the SGX subsystem. The
>> existing cgroup memory controller cannot be used to limit or account for
>> SGX EPC memory, which is a desirable feature in some environments.  For
>> example, in a Kubernates environment, a user can request certain EPC
>> quota for a pod but the orchestrator can not enforce the quota to limit
>> runtime EPC usage of the pod without an EPC cgroup controller.
>>
>> Utilize the misc controller [admin-guide/cgroup-v2.rst, 5-9. Misc] to
>> limit and track EPC allocations per cgroup. Earlier patches have added
>> the "sgx_epc" resource type in the misc cgroup subsystem. Add basic
>> support in SGX driver as the "sgx_epc" resource provider:
>>
>> - Set "capacity" of EPC by calling misc_cg_set_capacity()
>> - Update EPC usage counter, "current", by calling charge and uncharge
>> APIs for EPC allocation and deallocation, respectively.
>> - Setup sgx_epc resource type specific callbacks, which perform
>> initialization and cleanup during cgroup allocation and deallocation,
>> respectively.
>>
>> With these changes, the misc cgroup controller enables user to set a  
>> hard
>> limit for EPC usage in the "misc.max" interface file. It reports current
>> usage in "misc.current", the total EPC memory available in
>> "misc.capacity", and the number of times EPC usage reached the max limit
>> in "misc.events".
>>
>> For now, the EPC cgroup simply blocks additional EPC allocation in
>> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
>> still tracked in the global active list, only reclaimed by the global
>> reclaimer when the total free page count is lower than a threshold.
>>
>> Later patches will reorganize the tracking and reclamation code in the
>> global reclaimer and implement per-cgroup tracking and reclaiming.
>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> For consistency sake I'd also add co-developed-by for Kristen. This is
> at least the format suggested by kernel documentation.
>
She is the "From Author", so only Signed-off-by is needed for her  
according to the second example in the doc[1]?

Thanks
Haitao
[1]https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

