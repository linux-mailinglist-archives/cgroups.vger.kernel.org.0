Return-Path: <cgroups+bounces-1859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21268682D4
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307CDB2386F
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360DA130E58;
	Mon, 26 Feb 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cn8WqXrc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115C1E878;
	Mon, 26 Feb 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982289; cv=none; b=Bi93avPT+R5UW4ZGb+6b5XrKJkaK64iBhxBfkmWFnCOS/wmTKkA06dtKSrsHrMDXpdIDXX68y1YI1y+duVF8oWardQAC7+BmbEgJOawmkQcIOdgjrQVNz3wqIEjskotLwT1oRI12gyWCHn0nEcbb3Fu4RI1kIqj1YTP9muj7O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982289; c=relaxed/simple;
	bh=85ZvPu5LN35tUePxSjmceVl5Io330kFPQ92Yn7hXFOA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=J7g7zePZNOHsLZNwHdapEoOOY63Jh1q3zsPBDCJHBDZ+WrtRflVrfLKumA9vcwsa9UdNpK77bqxQQDbhlRQjrJyO9Q+8vIPgsMxVDaeE70iCGNlDTWpBqlcI//6zgMfW3PCjMqpzrBowsxGJXAlMnVBqwsbLa4gkeG4EsdVK9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cn8WqXrc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708982288; x=1740518288;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=85ZvPu5LN35tUePxSjmceVl5Io330kFPQ92Yn7hXFOA=;
  b=cn8WqXrcijy9bz/bc1jT1h3B5yZmsyNkQ3TjwR2OMcR2YJMfumKEb8hR
   84kauToiaYqro47kVRTg+6bqi5T4qldij2scPd0PvYaEVauPn+oz68vJo
   OI+/XlFE5gIlkDRGrhehDlmmwMbHF0AQ1AfbMZObayrMddKuZEDAXI9Bf
   NZufLDGjPvhg0LVbRL87uvZI67E9MANpWL1PLSNtQL9XCl/vTvQpWE98l
   4UypeaQlsVlKkGwQQpKAJwaxoBOYvdIt7yvwNJK+RjnXkK8+RJTUowsV5
   CxPSVF1h7y5IBNkZEPnVdhv+D/CYgTpLqcdzqSULcbw2Qm/Ucaj3L10NP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7124469"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7124469"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 13:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11396702"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Feb 2024 13:18:04 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "Huang, Kai" <kai.huang@intel.com>
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
Date: Mon, 26 Feb 2024 15:18:02 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jrpgcufwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 26 Feb 2024 05:36:02 -0600, Huang, Kai <kai.huang@intel.com> wrote:

> On Sun, 2024-02-25 at 22:03 -0600, Haitao Huang wrote:
>> On Sun, 25 Feb 2024 19:38:26 -0600, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> >
>> >
>> > On 24/02/2024 6:00 am, Haitao Huang wrote:
>> > > On Fri, 23 Feb 2024 04:18:18 -0600, Huang, Kai <kai.huang@intel.com>
>> > > wrote:
>> > >
>> > > > > >
>> > > > > Right. When code reaches to here, we already passed reclaim per
>> > > > > cgroup.
>> > > >
>> > > > Yes if try_charge() failed we must do pre-cgroup reclaim.
>> > > >
>> > > > > The cgroup may not at or reach limit but system has run out of
>> > > > > physical
>> > > > > EPC.
>> > > > >
>> > > >
>> > > > But after try_charge() we can still choose to reclaim from the  
>> current
>> > > > group,
>> > > > but not necessarily have to be global, right?  I am not sure  
>> whether I
>> > > > am
>> > > > missing something, but could you elaborate why we should choose to
>> > > > reclaim from
>> > > > the global?
>> > > >
>> > >  Once try_charge is done and returns zero that means the cgroup  
>> usage
>> > > is charged and it's not over usage limit. So you really can't  
>> reclaim
>> > > from that cgroup if allocation failed. The only  thing you can do  
>> is to
>> > > reclaim globally.
>> >
>> > Sorry I still cannot establish the logic here.
>> >
>> > Let's say the sum of all cgroups are greater than the physical EPC,  
>> and
>> > elclave(s) in each cgroup could potentially fault w/o reaching  
>> cgroup's
>> > limit.
>> >
>> > In this case, when enclave(s) in one cgroup faults, why we cannot
>> > reclaim from the current cgroup, but have to reclaim from global?
>> >
>> > Is there any real downside of the former, or you just want to follow  
>> the
>> > reclaim logic w/o cgroup at all?
>> >
>> > IIUC, there's at least one advantage of reclaim from the current  
>> group,
>> > that faults of enclave(s) in one group won't impact other enclaves in
>> > other cgroups.  E.g., in this way other enclaves in other groups may
>> > never need to trigger faults.
>> >
>> > Or perhaps I am missing anything?
>> >
>> The use case here is that user knows it's OK for group A to borrow some
>> pages from group B for some time without impact much performance, vice
>> versa. That's why the user is overcomitting so system can run more
>> enclave/groups. Otherwise, if she is concerned about impact of A on B,  
>> she
>> could lower limit for A so it never interfere or interfere less with B
>> (assume the lower limit is still high enough to run all enclaves in A),
>> and sacrifice some of A's performance. Or if she does not want any
>> interference between groups, just don't over-comit. So we don't really
>> lose anything here.
>
> But if we reclaim from the same group, seems we could enable a user case  
> that
> allows the admin to ensure certain group won't be impacted at all, while
> allowing other groups to over-commit?
>
> E.g., let's say we have 100M physical EPC.  And let's say the admin  
> wants to run
> some performance-critical enclave(s) which costs 50M EPC w/o being  
> impacted.
> The admin also wants to run other enclaves which could cost 100M EPC in  
> total
> but EPC swapping among them is acceptable.
>
> If we choose to reclaim from the current EPC cgroup, then seems to that  
> the
> admin can achieve the above by setting up 2 groups with group1 having  
> 50M limit
> and group2 having 100M limit, and then run performance-critical  
> enclave(s) in
> group1 and others in group2?  Or am I missing anything?
>

The more important groups should have limits higher than or equal to peak  
usage to ensure no impact.
The less important groups should have lower limits than its peak usage to  
avoid impacting higher priority groups.
The limit is the maximum usage allowed.

By setting group2 limit to 100M, you are allowing it to use 100M. So as  
soon as it gets up and consume 100M, group1 can not even load any enclave  
if we only reclaim per-cgroup and do not do global reclaim.

> If we choose to do global reclaim, then we cannot achieve that.


You can achieve this by setting group 2 limit to 50M. No need to  
overcommiting to the system.
Group 2 will swap as soon as it hits 50M, which is the maximum it can  
consume so no impact to group 1.

>
>>
>> In case of overcomitting, even if we always reclaim from the same cgroup
>> for each fault, one group may still interfere the other: e.g., consider  
>> an
>> extreme case in that group A used up almost all EPC at the time group B
>> has a fault, B has to fail allocation and kill enclaves.
>
> If the admin allows group A to use almost all EPC, to me it's fair to  
> say he/she
> doesn't want to run anything inside B at all and it is acceptable  
> enclaves in B
> to be killed.
>
>
I don't think so. The user just knows group A + B peak usages higher than  
system capacity. And she is OK for them to share some of the pages  
dynamically. So kernel should allow one borrow from the other at a  
particular instance when one group has higher demand. And later doing the  
opposite. IOW, the favor goes both ways.

Haitao

