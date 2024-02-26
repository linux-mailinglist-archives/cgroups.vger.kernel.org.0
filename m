Return-Path: <cgroups+bounces-1860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6D86834D
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BA41F2423C
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8913173B;
	Mon, 26 Feb 2024 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaZqnfpk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788D1DFCD;
	Mon, 26 Feb 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984107; cv=none; b=l0GZ0jEZABUBJFrTfA/B5LSWcMnehsI3G12Y9y8KCA+r8JNJ1dCYF6vCe1zOvODIllB6FxeITs4zuV8WIbXSyzoNwscrZ+qwLczmxVXpRK0RfpERe2PcJbi50+hYu1cJi9ze109BsfXFUXLN7ZB9wDVMy9PPoFY0h2eEDJEKims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984107; c=relaxed/simple;
	bh=p1RkEchGE/mNaNi3qBs14D7WQ1wY+4Ol5xO9+bc3K1o=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=RtPKLfcGb1clUEu5BgI/8+qtwVUQbPDr10nueKbm163jlFFBEesRZI0chdHSfrjWpPy/1XcDO0YUC7YK6VOkJ4YCj0EPlpquPx7Cu5ptCQHj4OhS+bMhJdXci6kFtXJbm9Dzh8wKFaCURRSrBiaU8WHhXgWf3y2WaEl3cfcLpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaZqnfpk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708984105; x=1740520105;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=p1RkEchGE/mNaNi3qBs14D7WQ1wY+4Ol5xO9+bc3K1o=;
  b=CaZqnfpkB2fw7JFZEvCz/ylI2YALJyoyJTauYm3EG3lIbdquUKOAddep
   f6l3O1SgoF4MtP5o+vPetFx8y0jz7FGQhqt1LmxAFHFVjbq6CqhlOrgMD
   4tFO8tDdCTIWcPXo0XH8A4hs6xdfHR8sTzr0+2ue9Rkm+ApWuirAT5MwZ
   bfa+1yX35M1Xgyrho4eB4HwxWYSKk7WKSinqsaFZfW+3b8WPTg+7o2iRl
   8WnJrXjPc/SyrupkXm+zr7PZoyqntCTEULecC3to9HtZ155XJ6MWeXV2B
   QQHAO+ePBRtgryb5GRiIggZuET1LvJODYs1EoXbX7oYxl7IySYHyjOMdi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14010315"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14010315"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 13:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7225171"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Feb 2024 13:48:20 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Huang, Kai" <kai.huang@intel.com>, "tj@kernel.org" <tj@kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
Date: Mon, 26 Feb 2024 15:48:18 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Dave,

On Mon, 26 Feb 2024 08:04:54 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 2/26/24 03:36, Huang, Kai wrote:
>>> In case of overcomitting, even if we always reclaim from the same  
>>> cgroup
>>> for each fault, one group may still interfere the other: e.g.,  
>>> consider an
>>> extreme case in that group A used up almost all EPC at the time group B
>>> has a fault, B has to fail allocation and kill enclaves.
>> If the admin allows group A to use almost all EPC, to me it's fair to  
>> say he/she
>> doesn't want to run anything inside B at all and it is acceptable  
>> enclaves in B
>> to be killed.
>
> Folks, I'm having a really hard time following this thread.  It sounds
> like there's disagreement about when to do system-wide reclaim.  Could
> someone remind me of the choices that we have?  (A proposed patch would
> go a _long_ way to helping me understand)
>

In case of overcomitting, i.e., sum of limits greater than the EPC  
capacity, if one group has a fault, and its usage is not above its own  
limit (try_charge() passes), yet total usage of the system has exceeded  
the capacity, whether we do global reclaim or just reclaim pages in the  
current faulting group.

> Also, what does the core mm memcg code do?
>
I'm not sure. I'll try to find out but it'd be appreciated if someone more  
knowledgeable can comment on this. memcg also has the protection mechanism  
(i.e., min, low settings) to guarantee some allocation per group so its  
approach might not be applicable to misc controller here.

> Last, what is the simplest (least amount of code) thing that the SGX
> cgroup controller could implement here?
>
>

I still think the current approach of doing global reclaim is reasonable  
and simple: try_charge() checks cgroup limit and reclaim within the group  
if needed, then do EPC page allocation, reclaim globally if allocation  
fails due to global usage reaches the capacity.

I'm not sure how not doing global reclaiming in this case would bring any  
benefit. Please see my response to Kai's example cases.

Thanks
Haitao

