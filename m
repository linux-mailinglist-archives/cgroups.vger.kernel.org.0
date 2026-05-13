Return-Path: <cgroups+bounces-15911-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Lh7LfLPBGr0PQIAu9opvQ
	(envelope-from <cgroups+bounces-15911-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:24:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA802539E3B
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66B9B3010507
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E537F3B635A;
	Wed, 13 May 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt01GXlv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2D3B5837;
	Wed, 13 May 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699442; cv=none; b=h80O4Efbhvhl7Ji1S++RITuHC7L/FL3q3RHC4uS1qb7I3tmhZUczSv31uYBW8Wrz+rFrjuDhxFRujthzGfK0/JsNJbPRmKQ+fsdd3tMd9Tui1zonSORp+5SFBm0ndNgahzrWcifzq92FoiFRBeXO6VNW6zVUjv07THfoVrkLBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699442; c=relaxed/simple;
	bh=Ja4tdX2yfM58Cfuh2bBgf7da3miE+R/5XOrkFDGo/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9AkC/72X8lFGW25ieZYElC3dyM/Lew8wD09xJ7YqQLEjA7qzh7z51FzyxGd4/cwjNc45sAV5K1p669zoKN4RWDxCvoBbZq3bMOKBf6h+MY4gn99fymNancoi/J0aLCIMKR5NCYotjRHudMcogIpKZ6+RhnkWtfUe/hOrxLZRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt01GXlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F8C19425;
	Wed, 13 May 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699441;
	bh=Ja4tdX2yfM58Cfuh2bBgf7da3miE+R/5XOrkFDGo/fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt01GXlv++jY82DjI0QBKYzeNlh5mgpt/0PBGbf80iE+N9opezaE6/2QpOcDM4Sh9
	 LvcpKGhVWMmnA+WPBLzQXrLXyIVLvdfE0AUUX1Z1ZSTm8yNSUc0sXxTT1poQpYUQfx
	 8wUk2XqdDAqMdvcbkPdxAuDuXhbT1FB9ALjdS6Em79NuSu3jbnbATUFfhOW2ymPSFT
	 FnCT+c6NpMCW6SgNjvTmXSy/ucna69tn2I37as9wVgWzf1I9ZlnuG2jfvHRcxFIfPw
	 yhLK42QAVbtzmQa+JbIpGCXmgMmLavNyot5UNaHt8Ux0LR3a4XHicGLcV+K1gByg4v
	 hcxGQhcs5+Prg==
Date: Wed, 13 May 2026 09:10:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Cc: luca abeni <luca.abeni@santannapisa.it>,
	Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agTMrz_nMV880pe0@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
 <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
 <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
 <agNvghphiv9sCJrq@slm.duckdns.org>
 <0d3336a7-ae42-4359-bfe7-48a7d6796d06@santannapisa.it>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3336a7-ae42-4359-bfe7-48a7d6796d06@santannapisa.it>
X-Rspamd-Queue-Id: DA802539E3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15911-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On Wed, May 13, 2026 at 02:08:52PM +0200, Yuri Andriaccio wrote:
> > How is a delegated subtree prevented from setting cpu.rt.min = 'root' and
> > escaping its ancestors' cpu.rt.max budget?
> 
> Is it strictly required that a child cgroup must have 'less runtime' than
> its parent? To be more precise I mean scheduling tasks on the root runqueue
> instead of using dl-servers. Small note: given that HCBS cgroups use
> dl-servers, and thus run at higher priority than FIFO/RR scheduled on the
> root runqueue, if a cgroup rt.min is 'root' would yes escape its ancestor
> budget but it may also possibly get starved because of the priority levels.

The high-level invariant that we must maintain is that any given cgroup has
control over resource usages in its subtree. If that doesn't work, the whole
thing is not very useful.

e.g. There are multiple containers in the system and each wants to manage
its own internal resource distribution, which is a relatively common
scenario in server deployments. This is implemented by putting each
container in a cgroup and deletating the sub-tree to the nested container
manager. At the host level, you don't know or have control over what's going
on in each container but you can control how much each container consumes in
total so that each gets what it's allotted and doesn't get in the way of
others.

While delegation scenario is a clear example, even in regular usages, it
gets really confusing if hierarchical resource distribution isn't actually
hierarchical. If you let a child escape to root at its own discretion, might
as well just not have all the complexities with hierarchical resource
control.

> If we require that child cgroups cannot escape their parent's bandwidth,
> even when using 'root', then the cpu.rt.max file must be disallowed in the
> root cgroup (removing the possibility to reserve bandwidth for HCBS, and so
> doing the admission test similarly to when SCHED_DEADLINE tasks are
> executed), and cpu.rt.max would use either 'root' if the whole subtree must
> be scheduled onto the root runqueue or a <runtime> <period> combination to
> reserve bandwidth for the whole subtree. The cpu.rt.min would then only be
> used to reserve internal bandwidth for the cgroup itself. This also means
> that a whole subtree either uses HCBS everywhere or the root runqueue
> everywhere.
> 
> > If the users on the system already started using rt, how do you enable the
> > controller from the top down with budgets already being used down in the
> > hierarchy?
> 
> In my original idea rt tasks would only interfere with their own cgroup
> configuration, but not with the subtree or their parents. When cpu.rt.min =
> 'root', you are free to change cpu.rt.max values to whatever you like in any
> place of the hierarchy, and tasks inside the rt.min = 'root' cgroup would
> not be affected as they are run in the root runqueue.
>
> If you want to switch a cgroup from/to 'root' and HCBS, you'd have to either
> move all the RT tasks out of the cgroup, set rt.min, and then move them back
> in, or change temporarily their scheduling policy to non-rt (SCHED_OTHER,
> SCHED_DEADLINE, whatever) and then back.
> 
> Hopefully I've answered your questions. Which solution do you think makes
> the most sense?

I'm not sure either makes sense. There's not much point in having
hierarchical controller in the first one (just require direct system-level
distribution) and I don't think the second one is very useable. I mean, try
to imagine being a user. You have to hunt down all rt tasks and twiddle
every one one way or another to change some config and then have to worry
about racing forks and class changes. At that point, you might as well just
control it centrally without the hirarchical stuff. You'd have to be really
dedicated or desparate, which means that not many are going to use it which
then brings up the question why are we doing this at all?

I wonder whether this can just be a regular max interface - ie. limit
maximum reservation in the subtree rather than exact reservation allocation.
Then cgroup can report total reservations in the subtree and admission
control can just reject anyting going over.

Thanks.

-- 
tejun

