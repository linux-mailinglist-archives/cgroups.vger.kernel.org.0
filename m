Return-Path: <cgroups+bounces-1717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA985D077
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 07:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976C91F23402
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87C3B19D;
	Wed, 21 Feb 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKTvoGO6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97C3A1BC;
	Wed, 21 Feb 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496611; cv=none; b=ICYym6DcU0GuT59UVfJjESiDlhTMmMs27Mt9dj/YRCY4MsoUJp7KPt/PQ60GBgr2YZXTyE8qfe/09+QJTO3efRyTl1Q4ZZUyrP/d3EQRItLfduHSsaapwna2lO9h2SenVKyAAbyHTs5/xQkPcHUDniBcgt8jUcLloilAsTySyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496611; c=relaxed/simple;
	bh=0lWBlh6xitCkQRn/+82kIvUqjqF7tK3nFPTc+NjV+nA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=bui+0NFQfhjbUCTNW8D4z/Bj4uOmOFUsl8IhEyQveqEHpcLAa5fjtdLaFYsnBjWubvEoo2Ynq5HTKytbbJvUzm24uhp/1n/lKkF/FyoUBDVPbtGYxRLBUj7wA9EVIiGwWZbCFzmyfUzwL8LO83GEOyxfMfWd+TjNkpwwtDt6hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKTvoGO6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708496610; x=1740032610;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=0lWBlh6xitCkQRn/+82kIvUqjqF7tK3nFPTc+NjV+nA=;
  b=NKTvoGO6t7BIlMvVk5wO3P6Q9/Kp30HCyXBMJTrvfe84DEMzFLiWIfQk
   Bu3AjdsRHtQ6oDv9FNWXvqFSJwBWq/ojUEpmRp4myeiZPa0+xdODPOIZ7
   4nisriCAq+c5gW5hLFxZpKGaEKreDC/zpjy/6rcCAHP+EglnyzuAWM7uj
   d8MtShMpyfQqpX0Nt0QEhTJ6bQaXReNjY5oPKxTxrzasc5Ej7m0+fr85o
   dSAi8bhGsTbk2NWh067sSylJ53WaPdn6ouSuTCfvFiAStdJ8V3rSOUBCY
   vp/6WIykfGhCwun9eh5l852W0InjfPrzd/+1lNMdiId8wMi/Ky9q+wM9s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13758070"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13758070"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827290820"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="827290820"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 20 Feb 2024 22:23:26 -0800
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
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
Date: Wed, 21 Feb 2024 00:23:20 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jhao6nzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

StartHi Kai
On Tue, 20 Feb 2024 03:52:39 -0600, Huang, Kai <kai.huang@intel.com> wrote:
[...]
>
> So you introduced the work/workqueue here but there's no place which  
> actually
> queues the work.  IMHO you can either:
>
> 1) move relevant code change here; or
> 2) focus on introducing core functions to reclaim certain pages from a  
> given EPC
> cgroup w/o workqueue and introduce the work/workqueue in later patch.
>
> Makes sense?
>

Starting in v7, I was trying to split the big patch, #10 in v6 as you and  
others suggested. My thought process was to put infrastructure needed for  
per-cgroup reclaim in the front, then turn on per-cgroup reclaim in [v9  
13/15] in the end.

Before that, all reclaimables are tracked in the global LRU so really  
there is no "reclaim certain pages from a  given EPC cgroup w/o workqueue"  
or reclaim through workqueue before that point, as suggested in #2. This  
patch puts down the implementation for both flows but neither used yet, as  
stated in the commit message.

#1 would force me go back and merge the patches again.

Sorry I feel kind of lost on this whole thing by now. It seems so random  
to me. Is there hard rules on this?

I was hoping these statements would help reviewers on the flow of the  
patches.

At the end of [v9 04/15]:

For now, the EPC cgroup simply blocks additional EPC allocation in
sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
still tracked in the global active list, only reclaimed by the global
reclaimer when the total free page count is lower than a threshold.

Later patches will reorganize the tracking and reclamation code in the
global reclaimer and implement per-cgroup tracking and reclaiming.

At the end of [v9 06/15]:

Next patches will first get the cgroup reclamation flow ready while
keeping pages tracked in the global LRU and reclaimed by ksgxd before we
make the switch in the end for sgx_lru_list() to return per-cgroup
LRU.

At the end of [v9 08/15]:

Both synchronous and asynchronous flows invoke the same top level reclaim
function, and will be triggered later by sgx_epc_cgroup_try_charge()
when usage of the cgroup is at or near its limit.

At the end of [v9 10/15]:
Note at this point, all reclaimable EPC pages are still tracked in the
global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
is activated yet.


Thanks
Haitao

