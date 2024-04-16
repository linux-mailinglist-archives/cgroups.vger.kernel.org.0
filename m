Return-Path: <cgroups+bounces-2551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24E8A782A
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 00:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A49282236
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCE13A3F1;
	Tue, 16 Apr 2024 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFtoFe/N"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92313A3E8;
	Tue, 16 Apr 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307728; cv=none; b=by6Hj23pucjEctQoKSNm0jo36Z5p7ZVlAE1POzqMu3W0vS/OUa/Gn/MlWtn6otFrZY3d9xF5ZeQI1cd1q1fqVT8i4+PojJTPZW86CIb+8h7NBt7grwTcNlcsu7vod5v2RpLppNH0rBVAbY0CUfi3/MifNhY0OGVWmRmMPtWkdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307728; c=relaxed/simple;
	bh=Vp1j4MGmUcagkQYsn9tWw5+GZ2D1D6UXf7Y83LOqr+A=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=F9+hvJ10XVw9d79zzF09g4XWvPGFLC1Qgu3w7+vb4Nc+PN4mZWYVm+OmnYRnvPEFw+gxgTwMCkKtHfYdpIFMo30tRjfkr6kmQr9otEblVcxPuQ9d9Sm9LUdS0q8CozLjPdlKRbulBaBp1b1Pmxhm6/O2GOesPdOMXFhmZB1y2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFtoFe/N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713307726; x=1744843726;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Vp1j4MGmUcagkQYsn9tWw5+GZ2D1D6UXf7Y83LOqr+A=;
  b=aFtoFe/N0UUn/Uw841LVQUsAhOGNckpcxAlcTbTWwWoaw9Kl9KH9yOKG
   1BiC2qjqFRZ8bncaI7IU4ZTx04ZdAYVtvvZk0Eeyln4JgSb8PtAz6SsWJ
   ZZoggxXIMORRyveDKcjwGCRIBmM5ZOBteNlxxCLJHFyDebWu//sIpmLwg
   MO8VW2tkT0TkCfXSOTHstXV6GsGil1Udj15OKKX/aLAJfEOhGxkTtDsOz
   pzPJqlYJGajA/uw7gR2MFcGsn/vo90g3SQUofutXUnjvBbcOgv1V2ym7b
   6L2TquDO/NrCT51EM8mrIyqMBJ8UEPBA2VAoDh+n+3poU1rcMmQ500RMU
   g==;
X-CSE-ConnectionGUID: Ni75NYzhRh+KT5Zdk+XBYw==
X-CSE-MsgGUID: c0EIKclwQca5nrKEiJ1PTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19336704"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19336704"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:48:46 -0700
X-CSE-ConnectionGUID: N0PoXSc6RoKbelsFxJEn3A==
X-CSE-MsgGUID: jNW5Aq0JTYqyypRWex69ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22411950"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 15:48:35 -0700
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
Subject: Re: [PATCH v12 07/14] x86/sgx: Abstract tracking reclaimable pages in
 LRU
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-8-haitao.huang@linux.intel.com>
 <e218d2aab5d793a3b4c64f90f7bad997c745ba91.camel@intel.com>
Date: Tue, 16 Apr 2024 17:48:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mcey3spwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <e218d2aab5d793a3b4c64f90f7bad997c745ba91.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 09:07:33 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2024-04-15 at 20:20 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> The functions, sgx_{mark,unmark}_page_reclaimable(), manage the tracking
>> of reclaimable EPC pages: sgx_mark_page_reclaimable() adds a newly
>> allocated page into the global LRU list while
>> sgx_unmark_page_reclaimable() does the opposite. Abstract the hard coded
>> global LRU references in these functions to make them reusable when
>> pages are tracked in per-cgroup LRUs.
>>
>> Create a helper, sgx_lru_list(), that returns the LRU that tracks a  
>> given
>> EPC page. It simply returns the global LRU now, and will later return
>> the LRU of the cgroup within which the EPC page was allocated. Replace
>> the hard coded global LRU with a call to this helper.
>>
>> Next patches will first get the cgroup reclamation flow ready while
>> keeping pages tracked in the global LRU and reclaimed by ksgxd before we
>> make the switch in the end for sgx_lru_list() to return per-cgroup
>> LRU.
>
> I found the first paragraph hard to read.  Provide my version below for
> your reference:
>
> "
> The SGX driver tracks reclaimable EPC pages via
> sgx_mark_page_reclaimable(), which adds the newly allocated page into the
> global LRU list.  sgx_unmark_page_reclaimable() does the opposite.
>
> To support SGX EPC cgroup, the SGX driver will need to maintain an LRU
> list for each cgroup, and the new allocated EPC page will need to be  
> added
> to the LRU of associated cgroup, but not always the global LRU list.
>
> When sgx_mark_page_reclaimable() is called, the cgroup that the new
> allocated EPC page belongs to is already known, i.e., it has been set to
> the 'struct sgx_epc_page'.
>
> Add a helper, sgx_lru_list(), to return the LRU that the EPC page should
> be/is added to for the given EPC page.  Currently it just returns the
> global LRU.  Change sgx_{mark|unmark}_page_reclaimable() to use the  
> helper
> function to get the LRU from the EPC page instead of referring to the
> global LRU directly.
>
> This allows EPC page being able to be tracked in "per-cgroup" LRU when
> that becomes ready.
> "
>
Thanks. Will use

> Nit:
>
> That being said, is sgx_epc_page_lru() better than sgx_lru_list()?
>

Sure

>>
>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>
>
> Feel free to add:
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Thanks
Haitao

