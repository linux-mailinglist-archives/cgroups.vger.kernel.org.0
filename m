Return-Path: <cgroups+bounces-2322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947B898B4F
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4091F29F1B
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACED129A99;
	Thu,  4 Apr 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BL5Nhvp6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721012B87;
	Thu,  4 Apr 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245171; cv=none; b=ZQenR2l9QadLIzSKQFcVcN3BZ73Vjc4olDgah8IvaIS+wQcdSNqWeR5bcgHDQCqYFxahm972GYiG7C/Otfa1HgUSe5CJNHW6vpgWkCnmrOl8b9WuqsCDmcalcaGfz8UFrhyC9iOw3hc4Z7wrZCsC+D215RpLXmSO+usV/gYV8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245171; c=relaxed/simple;
	bh=SyMXF+YI9dsKS9EwsdxFUximlqPUveJCPZuIvwTOF/E=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Xyg9xT27pKnNxXWXgrlhaADLIXciA2ywNFfLDg6ojn5DSUtFMNhbZlw4ntO8sQg4szaJiyUQn0oKbI6zaWzxft1TXPOPedA68wOtAtF9rHY02CyJdtdPSTW8oIgczUzbAR1O8r1Z/fKjkS9Fd8m2UcFTsJGjH5AC9XzBFgMoqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BL5Nhvp6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712245170; x=1743781170;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=SyMXF+YI9dsKS9EwsdxFUximlqPUveJCPZuIvwTOF/E=;
  b=BL5Nhvp6l5lhdp1HXImj4SNMs1Yg5ip8xSX3q/2WUWdFNYFoQewGtiC8
   hKI7xCa18qVrcaBlgbZJM262Df1qn3nV3d9c8BZyIALgdnmJ1V92QO5iI
   rYWuFmTJNKzXiIIj7YASoMne/P2n4GIjO+vlFWM4wTQNlbESQaY9YID+7
   3WviPv4nnSVg4hQPHbQL2VZfc7fX5wUQrgbT+5IsorShMfQJy8CcILOzB
   PXvps5puT6eG0mtm220pkSyXoXDl+e6gpuldzuwXRSAxnkXbwQXM7ITbu
   RDL7zdRuDt4SOXAepUXvlkWM2aMJs6N8LU+6Ywy2nCz9k3q9XaV3nCYbh
   Q==;
X-CSE-ConnectionGUID: Xjwd6miJTO2ONGd3J4lc1w==
X-CSE-MsgGUID: XArMb3lzTJOlQcuXGNzX2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18271757"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18271757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:39:29 -0700
X-CSE-ConnectionGUID: EVj/EoeDSNCuzxhTN+5cCw==
X-CSE-MsgGUID: yFrNcW5oTgKVAZnP8hFI8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23518129"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.247.65.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 04 Apr 2024 08:39:16 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 09/14] x86/sgx: Implement async reclamation for cgroup
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-10-haitao.huang@linux.intel.com>
 <cb5a76983bc195e1cfb2a4e2c96c31d694e5b777.camel@intel.com>
Date: Thu, 04 Apr 2024 10:39:10 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lpm3ktdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <cb5a76983bc195e1cfb2a4e2c96c31d694e5b777.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 04 Apr 2024 06:16:54 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2024-03-27 at 17:22 -0700, Haitao Huang wrote:
>>   void sgx_cgroup_init(void)
>>  {
>> +	sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE,  
>> WQ_UNBOUND_MAX_ACTIVE);
>> +
>> +	/* All Cgroups functionalities are disabled. */
>> +	if (WARN_ON(!sgx_cg_wq))
>> +		return;
>> +
>
> I don't think you should WARN(), because it's not a kernel bug or  
> similar.  Just
> print a message saying EPC cgroup is disabled and move on.
>
> 	if (!sgx_cg_wq) {
> 		pr_err("SGX EPC cgroup disabled: alloc_workqueue() failed.\n");
> 		return;
> 	}


Sure
Thanks
Haitao

