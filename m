Return-Path: <cgroups+bounces-15657-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIyBEkBv/GknQAAAu9opvQ
	(envelope-from <cgroups+bounces-15657-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:53:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B34E7108
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3061530297B5
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7523CFF53;
	Thu,  7 May 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6cV3VFW"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87623932ED;
	Thu,  7 May 2026 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151225; cv=none; b=Uusw2HY5G763+OVdRqtPIFhlsoepTUoWKB1tbrBSGTWFqnEH8J9ZjMgrJZQZYtDCnkqoyTP81IhU9kilZnuNrpWi26owHfvzkIc7unasMG2knlVLTtJIt1L/FJfm3rOIkTxM4L3HlNf9XHyFcTtN+i1ZC7dfhRKRRZm/kGjv1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151225; c=relaxed/simple;
	bh=70IGI1vNK4APAHcdk4oo+FCzlXGiLiuM2p9m4h/qQww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIPlO0Sw8K3Dki9Ihvz13sveXB8zmZb3edxUzypbefI9LA+FmYkz9p3eH5PNukLPpXoKSXxaU4ASLybX5NgJ86GI/2NV3NOnbEICB/F6RwCacCDxQ3iU/tHpGtdbRchb/7sh6V6IPTzj68r+wGtS8mVFyZNmCGGyZhcVpyDfvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n6cV3VFW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U1LXP3g90HkCRniJtYUgytJdSLFosGKVOZ2blgFO3hU=; b=n6cV3VFWM/6sCtyrINC1+WwZze
	PrlOdkcIMPeHSa6036ZmDDuCMJ6oD4Fy90A/tj7okM8166nb8a04ZNZPtMUJnIWX5yIwWn2uUNy8x
	2gjINH3X0EPBjkJXGmKtlP5cDV0w45/VdyKGFB7+2NGJc7ctcuKHRKM+ugWHmMoVe2cwtEuckr+KH
	RMY9ZUqltges4iAvBnUWKg9nWqotTAgV6dcMDFQ+aBMJatdiPu1TXv892gpUlfigVcxQLNKDw+ox+
	PwOxLtY4c2lD2l+WIMkEFXWBt/P6UrEJq7o31f+3nsp/d04sZ4sUf3gUciHuH8q7f4FAtZZujcj7j
	xkqrBh/g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKwMG-00000003HM6-28lq;
	Thu, 07 May 2026 10:53:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65E51301261; Thu, 07 May 2026 12:53:31 +0200 (CEST)
Date: Thu, 7 May 2026 12:53:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
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
Message-ID: <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpLir8tD0Ycb3D8@slm.duckdns.org>
X-Rspamd-Queue-Id: B80B34E7108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15657-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 09:56:58AM -1000, Tejun Heo wrote:
> Hello,
> 
> Some high level comments:
> 
> - Please align it with existing cgroup2 interface files. See cpu.max. This
>   can be e.g. cpu.rt.max without about the same semantics.
> 
> - cgroup2 enforces that internal cgroups w/ controllers enabled cannot have
>   threads in them. No need to enforce that separately.

Looking at cpu_period_quota_parse() this thing takes two u64 values for:
{runtime, period} but allows runtime to be the string "max".

I think we'd want an optional extension to that and allow 3 values for:
{runtime, period, deadline}, where if the deadline is not given, it will
be the same as period.

In previous versions there was also an option to specify a cpumask,
getting rid of that is one of the reasons I suggested making this thing
a cgroup-v2 thing, then we can use the cpuset controller's effective
mask.

> - However, the cpu controller is a threaded controller which means that it
>   can have threaded sub-hierarchy where the no-internal-process rule doesn't
>   apply. This was created explicitly for cpu controller. The proposed change
>   blocks it effectively forcing cpu controller into regular domain
>   controller behavior subject to no-internal-process rule. Note these are
>   enforced at controller granularity and this means that users who use the
>   threaded mode will be forced to pick between the two.

Right... this then means we need two controls, one to do hierarchical
bandwidth distribution, and one to assign bandwidth to the internal
group -- which is then subject to its own bandwidth distribution
constraint.

This might be a little confusing, but there is no way around that
AFAICT.

> - This has the same problem with cgroup1's rt cgroup sched support where
>   there is no way to have a permissive default configuration, which means
>   that users who don't really care about distributing rt shares
>   hierarchically would get blocked from running rt processes by default,
>   which basically forces distros to disable rt cgroup sched support. This is
>   not new but it'd be a shame to put in all the work and the end result is
>   that most people don't even have access to the feature.

Right, but cgroup-v2 allows enabling/disabling specific controllers for
a (sub)-hierarchy, right? So if the controller is not enabled (by
default), it will fall back to putting the tasks in whatever parent does
have it on, and by default the root group would have and would accept
tasks.

Additionally, I think we want a flag to allow non-priv tasks to use RT
inside the controller -- after all, these tasks would be subject to
strict bandwidth controls and cannot burn the system like unbounded/root
FIFO tasks can.

Does that all sound workable?

