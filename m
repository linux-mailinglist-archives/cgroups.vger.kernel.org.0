Return-Path: <cgroups+bounces-1649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD98575D4
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 07:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B7B1F23186
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829114A90;
	Fri, 16 Feb 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLzjIZP0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12014A8D;
	Fri, 16 Feb 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708063656; cv=none; b=C/nXkQU6+7ZgVaSBDIuKiRc5VUfE1uS5cIAivcPgG7hE+3zxDwU2tEX9tJCu6wGy4Ozrs8edq4OJDlmUQyThgCYSkeK7PP66jEB8jksuxoMAq9SNueQegCsUHMgqo/cTc9sQKHdyFl03TrI0Et9zzl75RwMOlr4A8bFhKygHva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708063656; c=relaxed/simple;
	bh=gKqdrhGvXwQa/MD1xKqhRz44sgn+aAyq0soE+fJ1C/s=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=nQuErmtIWK0A0E1kD5KBaAXGLf2FYlgw10u3ArjlpKBLOQeR36SNNfzQ+au48sHJWySRNIeQwSF1ENSSgcgXefAeySzEFiJT/PQSk88amfx5MEivdGi1nvivvQ8olysYl/fJKLLR+0iB7ax66fy5T2UDu7bBZgOu+8y6OMW+Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLzjIZP0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708063655; x=1739599655;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=gKqdrhGvXwQa/MD1xKqhRz44sgn+aAyq0soE+fJ1C/s=;
  b=RLzjIZP03GqlWvB8S2MWPG8IGeqepMb7tyMhqKVuEWsw912rJA8EHeGo
   hLHgTb7TzXpnvoMR1Jk9TIGdgraL7GPppAlmTZ9r68yY5j+1Zucc0q8Gs
   Dcf1peUrTbEMgSCr2XvcUNR4IEeZzHkM7yYk0RKfhAC+xsuJweA4LmYQp
   k+Yt0q+W2ML7A28FmT4y3wKWYj72W3ed5KtPozzB+VH7sTxeuHQDg7VeY
   Y1YKSObizax0mO483lTBlQWs0X+qbGLwupC0gILHwb9g7p3vsE04Egeow
   gsw3zW1ViPQnY/aVB1i598TUqAbt2okDtxaBvQW+SOv+VpZAqi9LxE+Uk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6013712"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="6013712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 22:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4048552"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Feb 2024 22:07:32 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Dave Hansen" <dave.hansen@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-10-haitao.huang@linux.intel.com>
 <8a31fce6-9ad2-4868-b6bf-15997ef18334@intel.com>
Date: Fri, 16 Feb 2024 00:07:28 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2i70mqs3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <8a31fce6-9ad2-4868-b6bf-15997ef18334@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Dave,

On Thu, 15 Feb 2024 17:43:18 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 2/5/24 13:06, Haitao Huang wrote:
>>  static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl  
>> *encl)
>>  {
>> @@ -1003,14 +1001,6 @@ static struct mem_cgroup  
>> *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
>>  	struct sgx_encl_mm *encl_mm;
>>  	int idx;
>>
>> -	/*
>> -	 * If called from normal task context, return the mem_cgroup
>> -	 * of the current task's mm. The remainder of the handling is for
>> -	 * ksgxd.
>> -	 */
>> -	if (!current_is_ksgxd())
>> -		return get_mem_cgroup_from_mm(current->mm);
>
> Why is this being removed?
>
> Searching the enclave mm list is a last resort.  It's expensive and
> imprecise.
>
> get_mem_cgroup_from_mm(current->mm), on the other hand is fast and  
> precise.
>

I introduced a boolean flag to indicate caller is in kthread (ksgxd or  
cgroup workqueue), so sgx_encl_alloc_backing only calls this function if  
that flag is true, meaning search through the mm_list is needed.

But now I think a more straightforward way is to just replace  
current_is_ksgxd() with (current->flags & PF_KTHREAD).

Thanks

Haitao

