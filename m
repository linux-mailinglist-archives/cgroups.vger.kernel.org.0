Return-Path: <cgroups+bounces-8691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4BAF9A35
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF9F1C42E22
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161D2DEA61;
	Fri,  4 Jul 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQHNLwSO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7AA288C8E;
	Fri,  4 Jul 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651879; cv=none; b=BfFMKzNPB97htYbFrEjbHDh5fmK24i7R578eHCWNgoNEdJajatuDijjj+NpChoSNcLUJvz8M/wKEtoLhyuy8MGn/syolNCWdz7BYk0Opv/lOHO0oOJE2q1fAugzhVPA9il/XgEZf1KagMxofPj9922z40O2timM5tyF9vzbo5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651879; c=relaxed/simple;
	bh=zytPR8zjyyZVsG2luURuCmDIGI8iPX7/19zypztv92o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBhMNj4L+CYyAKsZlUDN/scGC3xq3GBCXybAyPsSmtkWIL+BHO0ZtFt5Nu8+gfnQljw2ifuNWCVPmqZRPjyQpsAdVnwD2Tbov5lnYMr9qjDHFHi1xkVcNuNA/XxB9wNlwo8toAAh6Pe2puUZHHv8TQIpAiRPvAS2bpxzknV8v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQHNLwSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CFC4CEE3;
	Fri,  4 Jul 2025 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651878;
	bh=zytPR8zjyyZVsG2luURuCmDIGI8iPX7/19zypztv92o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQHNLwSOIuLeHF3J+L9116G4GUPC/ZAkrOvpRS0XR9wP2BrplD2E9oc+g3TK2chjg
	 NhNqKJf1gRu9G5Te45QYi4mHuFdd2Jc5Zd60esKNW8bUW5UUL07bPGg7TqhSkB4xwH
	 oQjfQH/eFPi6gj17gLH0PGoMs7sjNLrPOrWbK6e2LD9W7xKO7NPvExHuSMo69k79zy
	 7lJD1fGKtdvyES7fsCjSpu0EzREpUiuNza5Pt2/4OFPszON7ea75X8kCPBT62EBqEd
	 O4iMlpYb/BwvoJegAFNaN687m8rQeVxjsRU4TEW29JchTyspNcuFciADgqhxNPGRpl
	 VBODTbTOG5Dog==
Date: Fri, 4 Jul 2025 07:57:47 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <aGgWG_eSHVxntfEh@slm.duckdns.org>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aF7L8jRkWm1TrwSu@slm.duckdns.org>
 <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aGKxvQdAZ-vSd48D@slm.duckdns.org>
 <CH3PR11MB7894766BBF3A24A4174D41A5F142A@CH3PR11MB7894.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB7894766BBF3A24A4174D41A5F142A@CH3PR11MB7894.namprd11.prod.outlook.com>

Hello,

On Fri, Jul 04, 2025 at 01:13:56PM +0000, Wlodarczyk, Bertrand wrote:
...
> After 54 units both solutions have the same result.
> What's the issue here? Why user seeing A = 1, B = 0, C = 0 in 22 unit (instead of spin) is a bad thing in rstat scenario?

Because some stats are related to each other - e.g. in blkcg, BPS and IOPS.
Here, overlapping cputime stats if we ever add [soft]irq time breakdowns,
and that can lead to non-sensical calculations (divide by zero, underflow,
and so on) in its users, just rare enough to not debugged easily but
frequent enough to be a headache in larger / longer deployments. And,
because we can usually do better.

> > Can you please try a different approach?
> 
> In last few days I've investigated this, have some success but nowhere
> near to the improvements yield by atomics use. For the reasons I mentioned
> above, locks approach is much more complex to optimize.

So, I'm not converting these stats to atomics. It's just not a good long
term direction. Please find a better solution. I'm pretty sure there are
multiple.

>> Yeah, I saw the benchmark but I was more curious what actual use case
>> would lead to behaviors like that because you'd have to hammer on those
>> stats really hard for this to be a problem. In most use cases that I'm
>> aware of, the polling frequencies of these stats are >= 1sec. I guess the
>> users in your use case were banging on them way harder, at least
>> previously.
> 
> From what I know, the https://github.com/google/cadvisor instances
> deployed on the client machine hammered these stats. Sharing servers
> between independent teams or orgs in big corps is frequent. Every
> interested party deployed its own, or similar, instance. We can say just
> don't do that and be fine, but it will be happening anyway. It's better to
> just make rstats more robust.

I do think this is a valid use case. I just want to get some sense on the
numbers involved. Do you happen to know what frequency cAdvisor was polling
the stats at and how many instances were running? The numbers don't have to
be accurate. I just want to know the ballpark numbers.

Thanks.

-- 
tejun

