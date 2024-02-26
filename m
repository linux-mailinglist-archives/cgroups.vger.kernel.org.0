Return-Path: <cgroups+bounces-1830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81E866922
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 05:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE35E281812
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 04:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756D1947E;
	Mon, 26 Feb 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHaStmdU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550F1BF27;
	Mon, 26 Feb 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920195; cv=none; b=moyNhuoDVpRYzxP6oe1qMqqyYt26bMMO2GKuQ3b8t6HxlvAl283gqojaAD87A30UaZNDCu3PM11IdGqkhWnmINKoYnO/g2jWsKPTIlpQmVqItwX9V3drn7Zol7yKigGNg+EJhZkH7jv/YmfF2BepBNQt4QkcVy9j0KzhN8m9ONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920195; c=relaxed/simple;
	bh=cOK/D0QdQmnKaw36G2aH4rUG67tZkKC9uaopo68fxLA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=rnM5ey4GQOWaesv/pJTILWY6/ZEtb2QrhiDDY51m7mb6vwdTZWmII2POFv+FeR7IE5HsZxVEXtQpE6YuvGhTkYz9wjwhp9EIIAW0z4oJ2EmVVSCwwTVzMcwwFaMcqo3qnbbOiRL8ll1Arc/rqs0sNTdgZdgkMTPphY9XAH8dIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHaStmdU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708920194; x=1740456194;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=cOK/D0QdQmnKaw36G2aH4rUG67tZkKC9uaopo68fxLA=;
  b=SHaStmdUaTvV0tHPeSPqTDW5ScSKqw61aELklDQ1f1z5kx6ImxyDklOc
   RPXwCCuNm7qgNJZO6xB+xvMtntkn4utO+aH2bEH0o+zHwkR4tZEm/GwLm
   P2puc7jV3UVLK7SOT8mLSgNkrZvw6Vfylhiu0piC3tfK2uAKpEnNkc5A6
   gvExOj72zB8DRBDBbZP8JYLg3WrP3JTPShvd7TKWmGnXyH19M+HezUUI+
   mNEIQP3odPS5aCkjM/PBWnVrdcx4cSesggkW+v2EBNySNUiqfX5NZI6Qy
   vZWzKynm3E+OFMRj7VMWsnLhDxP1fSwqWfuUEubdNu21beBT/HgXCKuNc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3066042"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3066042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 20:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6957596"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Feb 2024 20:03:10 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org"
 <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
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
Date: Sun, 25 Feb 2024 22:03:09 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Sun, 25 Feb 2024 19:38:26 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 24/02/2024 6:00 am, Haitao Huang wrote:
>> On Fri, 23 Feb 2024 04:18:18 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>>>> >
>>>> Right. When code reaches to here, we already passed reclaim per  
>>>> cgroup.
>>>
>>> Yes if try_charge() failed we must do pre-cgroup reclaim.
>>>
>>>> The cgroup may not at or reach limit but system has run out of  
>>>> physical
>>>> EPC.
>>>>
>>>
>>> But after try_charge() we can still choose to reclaim from the current  
>>> group,
>>> but not necessarily have to be global, right?  I am not sure whether I  
>>> am
>>> missing something, but could you elaborate why we should choose to  
>>> reclaim from
>>> the global?
>>>
>>  Once try_charge is done and returns zero that means the cgroup usage  
>> is charged and it's not over usage limit. So you really can't reclaim  
>> from that cgroup if allocation failed. The only  thing you can do is to  
>> reclaim globally.
>
> Sorry I still cannot establish the logic here.
>
> Let's say the sum of all cgroups are greater than the physical EPC, and  
> elclave(s) in each cgroup could potentially fault w/o reaching cgroup's  
> limit.
>
> In this case, when enclave(s) in one cgroup faults, why we cannot  
> reclaim from the current cgroup, but have to reclaim from global?
>
> Is there any real downside of the former, or you just want to follow the  
> reclaim logic w/o cgroup at all?
>
> IIUC, there's at least one advantage of reclaim from the current group,  
> that faults of enclave(s) in one group won't impact other enclaves in  
> other cgroups.  E.g., in this way other enclaves in other groups may  
> never need to trigger faults.
>
> Or perhaps I am missing anything?
>
The use case here is that user knows it's OK for group A to borrow some  
pages from group B for some time without impact much performance, vice  
versa. That's why the user is overcomitting so system can run more  
enclave/groups. Otherwise, if she is concerned about impact of A on B, she  
could lower limit for A so it never interfere or interfere less with B  
(assume the lower limit is still high enough to run all enclaves in A),  
and sacrifice some of A's performance. Or if she does not want any  
interference between groups, just don't over-comit. So we don't really  
lose anything here.

In case of overcomitting, even if we always reclaim from the same cgroup  
for each fault, one group may still interfere the other: e.g., consider an  
extreme case in that group A used up almost all EPC at the time group B  
has a fault, B has to fail allocation and kill enclaves.

Haitao

