Return-Path: <cgroups+bounces-1497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB138527BA
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 04:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1ADB22C66
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1908F65;
	Tue, 13 Feb 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WD7+87SC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E278BFC;
	Tue, 13 Feb 2024 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794513; cv=none; b=G+iyDHQVoI4H1+yHjOpaQrQJGvEGAXEIcIx4mWOLuU6pPgi0M4dBh1Hc86pHDT8CbRQ2b9NTFn3OjUMFk7bv/fhzS7ZbQtDkWWohZfd3W+oweZMk7ftoKUohDTRhKYRLxH82O+iDd0lPCCA/uxbAKTXdZyUvK2VI7t9Uaaz0rdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794513; c=relaxed/simple;
	bh=COC+DgrRwbOsMKFiXhxGIvmheeowK1HumSOtDo0gkkc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=SepHE84sR4B1OX9KprxyEAtecCGsViJD2ihd0frR1RHpY3CD7AO73z+XxigyhxlydqXs3+rxW+3ZIu65nH4NhE27dESZR+UUzQl6nRqoHDHvlQHzP8Lnr02DcQrKdo/Jv82JTjVg0oGZGbrM+u9wbKGvSivzEEG2KsVuTITwHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WD7+87SC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707794512; x=1739330512;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=COC+DgrRwbOsMKFiXhxGIvmheeowK1HumSOtDo0gkkc=;
  b=WD7+87SCjTdrGx6z19Nt0fti1JFFp0jyyzOu7Ma53VCv0Pt6BflsmpSB
   3d3VbhfIpsGi0p+lby9avWFhN+uE7SuRQN9YdU2NbFNMzBpCRN4JGPxTb
   DS9xqQjT6U/3Eyze9hx003+5ywDvxiAGPTis216KUeypUpA8PcJHXQdrJ
   nxIPR1a204Arj1FzwwQwscMPpPW6IhVmdT/AssHJaa5S63A8c08Xzsxai
   0gkgvsBailO0b3/Bab3pc+fMXKs3dOa4pQb72AQCLwqfIoNJfIJfwH/Mv
   5DGzQiovCnMrjDBQL6pdJMZFJvo4YYKnMiJV6wEWPEOKkXDh+VX2brUrx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1944980"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1944980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 19:21:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7402632"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 12 Feb 2024 19:21:49 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-10-haitao.huang@linux.intel.com>
 <CZ3CXPOLZEI8.C6AJ9W0W07A9@kernel.org>
Date: Mon, 12 Feb 2024 21:21:47 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2i18ylk5wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CZ3CXPOLZEI8.C6AJ9W0W07A9@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 12 Feb 2024 13:46:06 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
>> Enclave Page Cache(EPC) memory can be swapped out to regular system
>
> "Enclave Page Cache (EPC)"
>                    ~
>
Will fix.

[...]
>>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long  
>> page_index,
>> -			   struct sgx_backing *backing)
>> +			   struct sgx_backing *backing, bool indirect)
>
> Boolean parameters should be avoided when possible because they confuse
> in the call sites.
>
>>  {
>> -	struct mem_cgroup *encl_memcg = sgx_encl_get_mem_cgroup(encl);
>> -	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
>> +	struct mem_cgroup *encl_memcg;
>> +	struct mem_cgroup *memcg;
>>  	int ret;
>>
>> -	ret = __sgx_encl_get_backing(encl, page_index, backing);
>> +	if (!indirect)
>> +		return  __sgx_encl_get_backing(encl, page_index, backing);
>
> If a call is either in heead or tail of the code block, then
> obviously better option is to make __sgx_encl_get_backing()
> as non-static sgx_encl_get_backing() and call it in those
> call sites that would call this with "false".
>
> I.e. you need a new patch where this preparation is done.
>

This would actually require more intrusive changes to the call stack for  
global and cgroup reclaim:

{sgx_epc_cgroup_reclaim_pages(),sgx_reclaim_pages_global()}->sgx_reclaim_pages()[->sgx_reclaimer_write()]->sgx_encl_alloc_backing()

We need make two versions of each of those functions.
It'd be especially complicated in refactoring sgx_reclaim_pages() for two  
versions.

I now double checked the history of current_is_ksgxd()[1], it seemed the  
intent was to replace "current->mm == NULL" criteria so it is more obvious  
we are running in ksgxd.

@Dave, @Kristen,

Can we restore the original criteria like below so it works for the cgroup  
work-queues?

bool current_is_ksgxd(void)
{
	return current == ksgxd_tsk;
}

--->

bool current_is_kthread(void)
{
	return current->mm == NULL;	
}

I'm not experienced in this area and not sure how reliable it is to use  
current->mm == NULL for kthread and work-queues. But it would eliminate  
the need for the boolean parameter.

Would appreciate the input.

Haitao

[1]https://lore.kernel.org/linux-sgx/9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com/

