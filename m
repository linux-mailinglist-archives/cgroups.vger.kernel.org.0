Return-Path: <cgroups+bounces-15772-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP6gL94aAmocoAEAu9opvQ
	(envelope-from <cgroups+bounces-15772-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:07:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F15514147
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E1531F1A47
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6C4508FC;
	Mon, 11 May 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHd3INcC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402A35958;
	Mon, 11 May 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521038; cv=none; b=TtoDHB2jGMaRa6iWXsbEFoN+1ONgiiaNHmTbR+Dj0sMkXK/ng4VhhDXzNsZl2u0jWS/0FbQkCxQSD3vk1VrslW8b2Mo/n1PvAjt00bNGENUDuS8sLez3DKlmHdEHSx7qAI/ij9vr2TtzIGugGnUwItSNSqYiQJrtMHXCB6LI+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521038; c=relaxed/simple;
	bh=N/d70V8PE3dSH/aumUplyCyeuucJ1n4qD1Ocrb4xtAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOPIox+9AAF0nmsZhBeNhixROALlOhBdsuBzncBQjaCqWGMbMt9lxdZAANsV8pn1saYmopssjCde4lCsClMbs3Q90KwADYOrR+flhc9t/JAlwT5bFy4LN0OMdmTbwOtus3vMsvgS6EZvaECfwJeQW3zM2CdEorBaLVDCScv9P/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHd3INcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA75C2BCB0;
	Mon, 11 May 2026 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521037;
	bh=N/d70V8PE3dSH/aumUplyCyeuucJ1n4qD1Ocrb4xtAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHd3INcC285TiWddXtQwWIiRNQyLtd9nu93/mvX2tce6l0FHh4AumBvxV/q4lAEzY
	 ImYIBT+m5GX/oaZoxzbyLdJc3NH0RasadrYewCSkuZBkAUesVxULsXQ6lInQ3Qouaa
	 xmykr/j53WH5pBRGg0fnl3/PkKBVfGFycBiqCRWmR7IMGVNeIrJTikgJ6eeDOW5kDf
	 6PG73sxcYoxH0kI2dfVGU92zpDUXwEiJqoYy6nrOEAQBTdUiOY5bCjbpCK24uWiekE
	 NWaBILveXm96wvx2Pqrb5Tw5jYjtS1KM8jIwaNEndbwvRSB1OKFtC44H4rNtZ/OOCj
	 Em1kJEHJ7V2Aw==
Date: Mon, 11 May 2026 07:37:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agITzCYT3yf_szi7@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: 28F15514147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15772-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello, Peter.

On Thu, May 07, 2026 at 12:53:31PM +0200, Peter Zijlstra wrote:
...
> Looking at cpu_period_quota_parse() this thing takes two u64 values for:
> {runtime, period} but allows runtime to be the string "max".
> 
> I think we'd want an optional extension to that and allow 3 values for:
> {runtime, period, deadline}, where if the deadline is not given, it will
> be the same as period.

Yeah, I don't know what's needed here but extending the interface as
necessary is completely fine.

> Right... this then means we need two controls, one to do hierarchical
> bandwidth distribution, and one to assign bandwidth to the internal
> group -- which is then subject to its own bandwidth distribution
> constraint.
> 
> This might be a little confusing, but there is no way around that
> AFAICT.

Separating out the rt as a separate controller is one way and if the
configuration wants to stick to strict allocation model where nothing is
available by default unless explicitly allocated, this would be the only
way. Interface-wise, I think this is going to be fine but I suspect this
likely would complicated internal implementation quite a bit as now rt can't
piggyback on existing sched core cgroup infra - no task_group or
synchronization built around them - and has to build everything on its own.
It's not the end of the world but not ideal either.

> > - This has the same problem with cgroup1's rt cgroup sched support where
> >   there is no way to have a permissive default configuration, which means
> >   that users who don't really care about distributing rt shares
> >   hierarchically would get blocked from running rt processes by default,
> >   which basically forces distros to disable rt cgroup sched support. This is
> >   not new but it'd be a shame to put in all the work and the end result is
> >   that most people don't even have access to the feature.
> 
> Right, but cgroup-v2 allows enabling/disabling specific controllers for
> a (sub)-hierarchy, right? So if the controller is not enabled (by
> default), it will fall back to putting the tasks in whatever parent does
> have it on, and by default the root group would have and would accept
> tasks.
> 
> Additionally, I think we want a flag to allow non-priv tasks to use RT
> inside the controller -- after all, these tasks would be subject to
> strict bandwidth controls and cannot burn the system like unbounded/root
> FIFO tasks can.
> 
> Does that all sound workable?

Yeah, if rt becomes its own controller, I don't see any fundamental
roadblocks. It'd involve a bunch of churn which may add to maintenance
overhead but it should work. An alternative would be coming up with some way
to express the default no-enforcement state through the config knobs. I'm
sure this would be doable too and if folks can figure out a reasonable
interface, it should be able to obtain basically the same functionality with
a lot less code.

Thanks.

-- 
tejun

