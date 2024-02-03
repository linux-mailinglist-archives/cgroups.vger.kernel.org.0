Return-Path: <cgroups+bounces-1329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84C847DED
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FE01C20DB1
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 00:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43E7EC;
	Sat,  3 Feb 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtW/VJdI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD841626;
	Sat,  3 Feb 2024 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920771; cv=none; b=TG8tzQQ0QWb7Xgn8RfSm08wKhyBZzjfR4ZWNzrsKLEofFphkJ1V3ZzQy+AmvXBAEc8rMKW7878++FzeDUH4f5jO7vwqY/D0koN35ptrUheTzt+K6mPAsxEG3KkMiDc15BU0WkiHty7SHu4Io7FwvGMOCKRi5ckZTK0+4iQOKd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920771; c=relaxed/simple;
	bh=PI5AaiKImIamke2x947YdZTAG/oLNmB8JsTt9OqkWnY=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=APAN6N5beJxCv4jIWdgPy003okHyrJ/vNG1R/UYDexCSArzZfiQLOrk+h+4mMmxfAccB5W77U1UFsMpcEDItm1WRF3NSqulIAS8teuR3iw1MlDztZZ0ksl+rBKW0l/NOo/U5p/JC5omsFnom9y30rtaM5VDIV1BZ9PTFPfpBYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtW/VJdI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706920770; x=1738456770;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=PI5AaiKImIamke2x947YdZTAG/oLNmB8JsTt9OqkWnY=;
  b=GtW/VJdI2uxj/WtyVlMGg8bw89z/01P4fBWhvlqCM914eCED7Y9ay0+6
   4scKg5N13sVliGI30uC2vGBxn9umOPZzWmAImFRq1dBImOMz000ma1gHO
   JvMKzBJmM42oed8aWBpMsIhGJlO3+s8KV2XraBAGYyrDEKHc+XY7u071u
   jMjr6BsapaBgGPV9ZJTPUtdDWDKFJW2XTXMLwvZA8Y9sSXC480KFKb/mB
   fVA98lpoA4cqFNIM2D193fMRKI0kkyv2aPxR0UdkEWs8k8bqeE9nXhNVc
   8LYG7hCMu8cDSIE4oV0im7vQSqH/aNO5E5033rN06sFWBfMa0KbbR+rVg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="25728920"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="25728920"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 16:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="223174"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Feb 2024 16:39:25 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com, "Tim Chen"
 <tim.c.chen@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-10-haitao.huang@linux.intel.com>
 <ca25d3462944dcea553665d7c85903cdd6a846bc.camel@linux.intel.com>
Date: Fri, 02 Feb 2024 18:39:23 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ijirxjlwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ca25d3462944dcea553665d7c85903cdd6a846bc.camel@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Tim,
On Fri, 02 Feb 2024 17:45:05 -0600, Tim Chen <tim.c.chen@linux.intel.com>  
wrote:

> On Mon, 2024-01-22 at 09:20 -0800, Haitao Huang wrote:
>>
>> @@ -1047,29 +1037,38 @@ static struct mem_cgroup  
>> *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
>>   * @encl:	an enclave pointer
>>   * @page_index:	enclave page index
>>   * @backing:	data for accessing backing storage for the page
>> + * @indirect:	in ksgxd or EPC cgroup work queue context
>> + *
>> + * Create a backing page for loading data back into an EPC page with  
>> ELDU. This function takes
>> + * a reference on a new backing page which must be dropped with a  
>> corresponding call to
>> + * sgx_encl_put_backing().
>>   *
>> - * When called from ksgxd, sets the active memcg from one of the
>> - * mms in the enclave's mm_list prior to any backing page allocation,
>> - * in order to ensure that shmem page allocations are charged to the
>> - * enclave.  Create a backing page for loading data back into an EPC  
>> page with
>> - * ELDU.  This function takes a reference on a new backing page which
>> - * must be dropped with a corresponding call to sgx_encl_put_backing().
>> + * When @indirect is true, sets the active memcg from one of the mms  
>> in the enclave's mm_list
>> + * prior to any backing page allocation, in order to ensure that shmem  
>> page allocations are
>> + * charged to the enclave.
>>   *
>>   * Return:
>>   *   0 on success,
>>   *   -errno otherwise.
>>   */
>>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long  
>> page_index,
>> -			   struct sgx_backing *backing)
>> +			   struct sgx_backing *backing, bool indirect)
>>  {
>> -	struct mem_cgroup *encl_memcg = sgx_encl_get_mem_cgroup(encl);
>> -	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
>> +	struct mem_cgroup *encl_memcg;
>> +	struct mem_cgroup *memcg;
>>  	int ret;
>>
>> +	if (indirect) {
>> +		encl_memcg = sgx_encl_get_mem_cgroup(encl);
>> +		memcg = set_active_memcg(encl_memcg);
>> +	}
>> +
>>  	ret = __sgx_encl_get_backing(encl, page_index, backing);
>>
>> -	set_active_memcg(memcg);
>> -	mem_cgroup_put(encl_memcg);
>> +	if (indirect) {
>> +		set_active_memcg(memcg);
>> +		mem_cgroup_put(encl_memcg);
>> +	}
>>
>
>
> You can reduce the number of if statements to make the logic
> simpler.  Something like
>
> 	if (!indirect)
> 		return __sgx_encl_get_backing(encl, page_index, backing);
>
> 	encl_memcg = sgx_encl_get_mem_cgroup(encl);
> 	memcg = set_active_memcg(encl_memcg);
> 	ret = __sgx_encl_get_backing(encl, page_index, backing);
> 	set_active_memcg(memcg);
> 	mem_cgroup_put(encl_memcg);
>
>>  	return ret;
>
> Tim
>

Yes, will do.
Thanks
Haitao

