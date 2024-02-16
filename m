Return-Path: <cgroups+bounces-1682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADC858A30
	for <lists+cgroups@lfdr.de>; Sat, 17 Feb 2024 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E8E1C21E80
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631511487ED;
	Fri, 16 Feb 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUo9qF9i"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5D146900;
	Fri, 16 Feb 2024 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126397; cv=none; b=sEZhpthdzidMXgWKcDjjUQbqP4WSeEoNksHVTmrisHBNaTMP1I37D5K5+o5tOAZ50eWKhYGfIa0SCQc566kTIFsvdrswxLxLhubD4LIKHsP7TG2dPWDnDQZuJDYOyssN8cv72yR92+mMfMDPD37/+Srb4zWI9fPBPVwm2o1x9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126397; c=relaxed/simple;
	bh=Cd475hAGgyuF2aGmyxhl9VvNyX0OKqZk6zOdf4II6mU=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=nYvORzbCeYdsKUuCrKpYvnTSURe7N8FgF6gSqWC0wIqX3SmxMs9D0Z3vAoFRfwcf/hLm5tBNTB1naDBhCfRcraoi4b/FTOWAgiXfLokDWO87x4aq+WwJjOhZecSPKFjvSS0TaU0xzOboqkkGVYwdEbaTmFeraJJDymjGFxzbLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUo9qF9i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708126395; x=1739662395;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Cd475hAGgyuF2aGmyxhl9VvNyX0OKqZk6zOdf4II6mU=;
  b=QUo9qF9iy1aUfNh5mbCHoP2tqLbREIiMflR2o+kmbvLZMELfyEhVWwGq
   ajzIAqUASOt75YWZNp4WjyP1iYZUdrwgsTXSHHCXh6HssTAcrhhcYc383
   e3Ls45EJWUCKqspGr0cnen93quJQ80YkaDL8MloLMGWK6GBKAOKcagc8z
   Xcsop8YrIhKakVviEDoBMgfSH7ok4zony49RwB0YsDAik/cPIpZelXjMy
   i8SDkXJmysLbZHztVcnxIAByxmljEl/O/z4znVzIy08Z66yemEZqZvMQn
   6Lu4pqXhhmye2eCXOZQUTW4BpJKTJqBlJJunJAYfsY9zt23SHERoUViiL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12898553"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12898553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4020035"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 16 Feb 2024 15:33:10 -0800
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
 <a5bd910b-3148-47ec-9280-561cfe6c16df@intel.com>
 <op.2i87qioawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <0ab99d42-c3fe-4415-b993-57fb1fec21a4@intel.com>
Date: Fri, 16 Feb 2024 17:33:07 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2i9c1hr5wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0ab99d42-c3fe-4415-b993-57fb1fec21a4@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 16 Feb 2024 15:55:10 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 2/16/24 13:38, Haitao Huang wrote:
>> On Fri, 16 Feb 2024 09:15:59 -0600, Dave Hansen <dave.hansen@intel.com>
>> wrote:
> ...
>>> Does this 'indirect' change any behavior other than whether it does a
>>> search for an mm to find a place to charge the backing storage?
>>
>> No.
>>
>>> Instead of passing a flag around, why not just pass the mm?
>>>
>> There is no need to pass in mm. We could just check if current->mm ==
>> NULL for the need of doing the search in the enclave mm list.
>>
>> But you had a concern [1] that the purpose was not clear hence suggested
>> current_is_ksgxd().
>
> Right, because there was only one possible way that mm could be NULL but
> it wasn't obvious from the code what that way was.
>
>> Would it be OK if we replace current_is_ksgxd() with (current->flags &
>> PF_KTHREAD)? That would express the real intent of checking if calling
>> context is not in a user context.
>
> No, I think that focuses on the symptom and not on the fundamental  
> problem.
>
> The fundamental problem is that you need an mm in order to charge your
> allocations to the right group.  Indirect reclaim means you are not in a
> context which is connected to the mm that should be charged while direct
> reclaim is.
>
>>> This refactoring out of 'indirect' or passing the mm around really  
>>> wants
>>> to be in its own patch anyway.
>>>
>> Looks like I could do:
>> 1) refactoring of 'indirect' value/enum suggested above. This seems the
>> most straightforward without depending on any assumptions of other
>> kernel code.
>> 2) replace  current_is_ksgxd() with current->mm == NULL. This assumes
>> kthreads has no mm.
>> 3) replace current_is_ksgxd() with current->flags & PF_KTHREAD. This is
>> direct use of the flag PF_KTHREAD, so it should be better than #2?
>>
>> Any preference or further thoughts?
>
> Pass around a:
>
> 	struct mm_struct *charge_mm
>
> Then, at the bottom do:
>
> 	/*
> 	 * Backing RAM allocations need to be charged to some mm and
> 	 * associated cgroup.  If this context does not have an mm to
> 	 * charge, search the enclave's mm_list to find some mm
> 	 * associated with this enclave.
> 	 */
> 	if (!charge_mm)
> 		... do slow mm lookup
> 	else
> 		return mm_to_cgroup_whatever(charge_mm);
>
> Then just comment the call sites where the initial charge_mm comes in:
>
> 	
> 	/* Indirect SGX reclaim, no mm to charge, so NULL: */
> 	foo(..., NULL);
>
>
> 	/* Direct SGX reclaim, charge current mm for allocations: */
> 	foo(..., current->mm);
>
>
Okay. got it now.

Thank you very much!

Haitao

