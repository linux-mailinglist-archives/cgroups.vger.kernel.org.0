Return-Path: <cgroups+bounces-1313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F48847568
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 17:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B667B2D82A
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1C14A4D4;
	Fri,  2 Feb 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQCciCfU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969814A4EC;
	Fri,  2 Feb 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892746; cv=none; b=o/NaY5058QPilt+ofBL4I7E2wEu96fKwMhjtldgiQEpm7xWDMm++EjZ4rGkFL8a0UJJna9JHPxahaB8g7CsR+SVjKuVnyQ7bI1gtH1IX5MvqN8mMVItTEh6tZHeT7PVg5tOlqvQWlvbgIAj/it1zyAy0fOsoiGGalOFIatl17ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892746; c=relaxed/simple;
	bh=HzgDzI/Ge9eFvWVgikaxYZfFSROrOdcCMT23siR2Q6o=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=qiYSeYdsG7NMeAWcp7YGSFJtBdqDc+r4/NaLh4U3A+CAyzp9BQ4tdLIjEvdnmecbUss25/n6DYH+ZAJzD/HlA9dbXo5Uc3iePCfPH+c5dbKtld4K3vD7Rhpt388FY3j6Hw3jxGbP4dHkzf2Rbh1GLLthd6a3RfCCYDAN+dYabPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQCciCfU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706892741; x=1738428741;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=HzgDzI/Ge9eFvWVgikaxYZfFSROrOdcCMT23siR2Q6o=;
  b=LQCciCfUe7id/mI1xZw4oEdn51ZVVKlNNI29SfutAVYE83VXu+DI8eEb
   +e9gHAiZpOcssBeugERBY9KqzSKhnwm9sM2o5JewkhR9Vz/2tpvepMN5L
   WH9GF9Lrv+bmkFVZmNz0n6KUgKSYpUSftW2rmdRLPwr2uEKi4xn9Gk7nY
   TUGukvG6CbRiQY3bb6UJBErXn+gZV4QdkP7HoZJ4MHmu9W2AOdflmhEcC
   YynHR0pyrX59sce/RQjnTNrhfFHYo7hrRInKVBeB8ehsoNy9AfNMmdQeH
   CegEs7jQLjQmaftmGtnjhyppqjwAjlnBVsrgezmynSGJwVZIel/zV6kFJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="102604"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="102604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435399"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Feb 2024 08:52:15 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v8 05/15] x86/sgx: Add sgx_epc_lru_list to encapsulate LRU
 list
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-6-haitao.huang@linux.intel.com>
 <CYU4S0Y9SVZ2.2G9RM5Y3K28XI@suppilovahvero>
Date: Fri, 02 Feb 2024 10:52:12 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2iiw5ajmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CYU4S0Y9SVZ2.2G9RM5Y3K28XI@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 01 Feb 2024 17:28:32 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Introduce a data structure to wrap the existing reclaimable list and its
>> spinlock. Each cgroup later will have one instance of this structure to
>> track EPC pages allocated for processes associated with the same cgroup.
>> Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
>> from the reclaimable list in this structure when its usage reaches near
>> its limit.
>>
>> Use this structure to encapsulate the LRU list and its lock used by the
>> global reclaimer.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> I'd put author as last sob but that said I'm not sure if there is rigid
> rule to do so. Thus not saying must here.
>

The documentation says "the ordering of Signed-off-by: tags should reflect  
the chronological history of the patch insofar as possible, regardless of  
whether the author is attributed via From: or Co-developed-by:. Notably,  
the last Signed-off-by: must always be that of the developer submitting  
the patch."

So this should be OK.
[...]
>>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
>>  void sgx_free_epc_page(struct sgx_epc_page *page);
>>
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko
>
Thank you!
Haitao

