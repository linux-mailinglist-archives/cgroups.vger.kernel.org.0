Return-Path: <cgroups+bounces-1285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0FF84330E
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 02:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C2286180
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D593A2F2D;
	Wed, 31 Jan 2024 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBs6QA+2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BC4C89;
	Wed, 31 Jan 2024 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666377; cv=none; b=b9QOkctJ3/RVZdKIUf+AXDKvuX1MJdst8I+iHe35s5cZ26pR/HcYgKBaEnbsEVXzPHg+5E11a590v6IRUXsaqzu9g15+zqO6Lnprv6rA2OwnHXhKwT3GqovqsOiRhuPcHz+cslaKSojff07vkpgmZYvLr6etM+IsTA8ugatZBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666377; c=relaxed/simple;
	bh=vSwvUDof3a2+ogxMMuAxYWAPXW2RjzXJdbU0/Iel/0A=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=ZpfOHDWrvJnKB4BBDM3iQ0knQvFQIiRDc4X1jiIJA6wpZMJDDnfh65SC+zt/rSywbGJt5jSBsTw7RL5CTRfb1eR5ot/ZskxEc5YI+s2PeAblGeELlFFKR+Pbhv28UdyIseJ8GVdnZ6vYNcK8/l3NDp1ETHHVw9noqNKi+Ek+p9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBs6QA+2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706666376; x=1738202376;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=vSwvUDof3a2+ogxMMuAxYWAPXW2RjzXJdbU0/Iel/0A=;
  b=fBs6QA+2IyErVtYkUyLtvXGkP2BfKDwSugAYfVg69bZazmGSea5un2tY
   iNewPtuuA17/KJe3bqHSIr4jocULK62fldEXNl4Nr27vB9uj965w0iCr/
   jvoNaRnVDw4VPLKqNeYBpgBdtHJywbwaz7PuXD+HZihYBqkzkaE+Ch2Dt
   PBtRIssmGvXvfcUL1MrChkgKV+eUMBJbHpobp76U9vIahaEkX3M3Kt3dK
   Ftc2qIMyVYelHeWXK75Y/Hfl2bq7d+Gpn0lvXBLgTaSk3p+vMwNlTw0vn
   OJiBOtCKm8lPcfSxIZLR5Ax6pb02eEdlNgP3QQfGkwbJCWpNLk3BKMzqY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10206762"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10206762"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:59:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30078195"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 30 Jan 2024 17:59:29 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "jarkko@kernel.org" <jarkko@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "Huang, Kai" <kai.huang@intel.com>
Cc: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
 "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240130020938.10025-1-haitao.huang@linux.intel.com> <20240130020938.10025-5-haitao.huang@linux.intel.com> <BL1PR11MB59784620554CDAD5E2C2BF45F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
Date: Tue, 30 Jan 2024 19:59:26 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2id2hcvkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <BL1PR11MB59784620554CDAD5E2C2BF45F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 30 Jan 2024 09:22:14 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)  {
>> +	struct sgx_epc_cgroup *epc_cg;
>>  	struct sgx_epc_page *page;
>> +	int ret;
>> +
>> +	epc_cg = sgx_get_current_epc_cg();
>> +	ret = sgx_epc_cgroup_try_charge(epc_cg);
>> +	if (ret) {
>> +		sgx_put_epc_cg(epc_cg);
>> +		return ERR_PTR(ret);
>> +	}
>>
>>  	for ( ; ; ) {
>>  		page = __sgx_alloc_epc_page();
>> @@ -567,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
>> *owner, bool reclaim)
>>  			break;
>>  		}
>>
>> -		if (list_empty(&sgx_active_page_list))
>> -			return ERR_PTR(-ENOMEM);
>> +		if (list_empty(&sgx_active_page_list)) {
>> +			page = ERR_PTR(-ENOMEM);
>> +			break;
>> +		}
>
> (Sorry for replying from Outlook because I am in travel for Chinese New  
> Year.)
>
> Perhaps I am missing something but I don't understand this change.
>
> An empty sgx_active_page_list means you cannot reclaim any page from it,  
> so why need to break?
>

This is to avoid any escape for sgx_put_epc_cg(), which is added in this  
version.

>>
>>  		if (!reclaim) {
>>  			page = ERR_PTR(-EBUSY);
>> @@ -580,10 +593,25 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
>> *owner, bool reclaim)
>>  			break;
>>  		}
>>
>> +		/*
>> +		 * Need to do a global reclamation if cgroup was not full but
>> free
>> +		 * physical pages run out, causing __sgx_alloc_epc_page() to
>> fail.
>> +		 */
>>  		sgx_reclaim_pages();
>>  		cond_resched();
>>  	}
>
> And why adding this comment, especially in this patch?
>
> I don't see it brings additional clarity because there's only global  
> reclaim now, no matter whether cgroup is enabled or not.
>

True there is only global reclamation at the moment. The comment intended  
to help clarify why we can get here when try_charge() passes. It at least  
took me some thinking to realize that fact so I put it here to help remind  
this can happen even for cases that try_charge() passes. (In some earlier  
debugging for some concurrent issues, I actually tried mistakenly to  
remove this path hoping to narrow down some causes but made situation  
worse.)

I can remove if no one thinks this is needed.

Thanks
Haitao

