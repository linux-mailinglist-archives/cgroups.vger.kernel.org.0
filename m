Return-Path: <cgroups+bounces-1705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6C85AE60
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B29B22661
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D454FA9;
	Mon, 19 Feb 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9agmI/G"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDE54730;
	Mon, 19 Feb 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381535; cv=none; b=Ts0CmRl21JEMkCY5Rt3AJIDd9QBYrtZhCCAmrGfpRxeCtHhSVgJTCY9i+kMHfUYXqtcr3yMCliIvE+tchY/z/xrrwP4Nsk4bHL/Zd7J90iW5ktdK7ySLCUI4Ss2RlfSjuDpUz+Aw2nH+XU3Bx+Ps3AHccupieVM1HLQRdeMiePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381535; c=relaxed/simple;
	bh=crP7RAEv7VRGsrEhWj4V+xiOIILazy22p7z1gsKcuEg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=afZ+d+UQXQ/XjDonhzWJOuVCHGCHco1xM4jU9yutEtb3KijoMAR4OxHxSsL5Fl2i92igaDNOlhjsNK0RJEXRxlYYxY4XKpszmMbGtIS54qnUNfGklyqPnwidCPDALRDPMoEWDZmGTo09laWtz+pKUkhsAtymDOO/YI7e+eYIS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9agmI/G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708381533; x=1739917533;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=crP7RAEv7VRGsrEhWj4V+xiOIILazy22p7z1gsKcuEg=;
  b=j9agmI/GQuD/SHLxb2c4lntCa8iWDWl6RLzeerYneUXKl5V5/eFlFhnk
   vBALiTUYr3AHHcFz/a/EAd+uW9duzK9sqXkdbubyl58flEpWKeIr9KNuD
   H7YeSRhSA5EMswgBg5rS05i7KZbo17acX/JVPV6hgDLtMwXONs/xrn9vm
   V5txxtfCE0ZI1JVVD2oCl5uipdqe8i6pI1Kgzvbq4IqOBjJjnQ59XdZam
   aJU3e2/bnbuXSP8XwEGOhs5wmepBQ/0x/fyOt7N/7PzQJDGuI0kpBUtNw
   sXKrkTHG1RHV3qKB8HxCZH1FnpGd/8T7FZPbQtwfHBodSERCDTktYPtAq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13097391"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="13097391"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 14:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="9296252"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 19 Feb 2024 14:25:27 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Dave Hansen" <dave.hansen@intel.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>
Cc: anakrish@microsoft.com, bp@alien8.de, cgroups@vger.kernel.org,
 chrisyan@microsoft.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kristen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, mikko.ylinen@linux.intel.com, mingo@redhat.com,
 mkoutny@suse.com, seanjc@google.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tim.c.chen@linux.intel.com, tj@kernel.org, x86@kernel.org,
 yangjie@microsoft.com, zhanb@microsoft.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH] x86/sgx: Remove 'reclaim' boolean parameters
References: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
 <20240219153957.9957-1-haitao.huang@linux.intel.com>
 <40f95b90-8698-42dd-89d7-cd73d1e311b1@intel.com>
 <CZ9CIP97661C.2WUZJNNCQUHE8@seitikki>
Date: Mon, 19 Feb 2024 16:25:22 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jetwkvkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CZ9CIP97661C.2WUZJNNCQUHE8@seitikki>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 19 Feb 2024 14:42:29 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Feb 19, 2024 at 3:56 PM UTC, Dave Hansen wrote:
>> On 2/19/24 07:39, Haitao Huang wrote:
>> > Remove all boolean parameters for 'reclaim' from the function
>> > sgx_alloc_epc_page() and its callers by making two versions of each
>> > function.
>> >
>> > Also opportunistically remove non-static declaration of
>> > __sgx_alloc_epc_page() and a typo
>> >
>> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> >  arch/x86/kernel/cpu/sgx/encl.c  | 56 +++++++++++++++++++++------
>> >  arch/x86/kernel/cpu/sgx/encl.h  |  6 ++-
>> >  arch/x86/kernel/cpu/sgx/ioctl.c | 23 ++++++++---
>> >  arch/x86/kernel/cpu/sgx/main.c  | 68  
>> ++++++++++++++++++++++-----------
>> >  arch/x86/kernel/cpu/sgx/sgx.h   |  4 +-
>> >  arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
>> >  6 files changed, 115 insertions(+), 44 deletions(-)
>>
>> Jarkko, did this turn out how you expected?
>>
>> I think passing around a function pointer to *only* communicate 1 bit of
>> information is a _bit_ overkill here.
>>
>> Simply replacing the bool with:
>>
>> enum sgx_reclaim {
>> 	SGX_NO_RECLAIM,
>> 	SGX_DO_RECLAIM
>> };
>>
>> would do the same thing.  Right?
>>
>> Are you sure you want a function pointer for this?
>
> To look this in context I drafted quickly two branches representing
> imaginary next version of the patch set.
>
> I guess this would simpler and totally sufficient approach.
>
> With this approach I'd then change also:
>
> [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup functionality
>
> And add the enum-parameter already in that patch with just "no reclaim"
> enum. I.e. then 10/15 will add only "do reclaim" and the new
> functionality.
>
> BR, Jarkko
>

Thanks. My understanding is:

1) For this patch, replace the boolean with the enum as Dave suggested. No  
two versions of the same functions. And this is a prerequisite for the  
cgroup series, positioned before [PATCH v9 04/15]

2) For [PATCH v9 04/15], pass a hard coded SGX_NO_RECLAIM to  
sgx_epc_cg_try_charge() from sgx_alloc_epc_page().

3) For [PATCH v9 10/15], remove the hard coded value, pass the reclaim  
enum parameter value from sgx_alloc_epc_page() to  sgx_epc_cg_try_charge()  
and add the reclaim logic.

I'll send patches soon. But please let me know if I misunderstood.

Thanks
Haitao

