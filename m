Return-Path: <cgroups+bounces-15604-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFQVE4MK+mlsIgMAu9opvQ
	(envelope-from <cgroups+bounces-15604-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:19:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893D4D0198
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B87C30891DE
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902C3A7824;
	Tue,  5 May 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o95i1RdH"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DD361DBC;
	Tue,  5 May 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994132; cv=none; b=grtu1XCLU/LnHse4KMhHaAzK33yzK4Wp4VQusvYXIuu5bFlk+WrCeng4YVpfMTHs5PrNvRrBgRdDqgolziqDqp0SmQXugLKOm3QB5A4ce2EMAt51n7GAMVpj+CPA/XZCoWlWI1zcjPkpL5g1YGBe9ku4emTZ96PqoAcYzFuLGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994132; c=relaxed/simple;
	bh=3iiRhXF4SG44rho4t/uDvy1V0mTb3KxKORV0atgHTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRnK5lgarDO6CZ/fn/zmX8V65nztDR4Dbz+h4vC9tK45EWvYP36NnMJFSIC3DJD2JI7tvX3gfkDOcR49MJUCkoywome0D3qgstx6HxLY4a4QZIzOh1+xsfs97gKATYMMaLaFsHxJ3zjL9BG19wZcn6nAfrWfsmwi+FK+mtpk/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o95i1RdH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1KBvajYrRfVnvuHnzVQAStRRwmGuOfavYIKbJ1tyq3E=; b=o95i1RdHDtb/q4VaBC82LVFZEV
	ulwm0BhGIngMQ8FgAHBzY3eBT8FsfMc8PAsuq1OV+bI+zoOtwMLX4Tgpb2qlYFJWKET4FyWnlnJwn
	0+NlglTPogw87Vye2LwbQ/xAX/x7CJEs/ibZYep/b3wTq+l7C/QcqS5EnmoPLN3dTJUGLOYRRXGaf
	NK/lkuFfuSthMSkMv0gzDmp1/iQeix2yIPPwmlte6ain20X/mAGkMOYfFhx9PVU40nmSuOIxkGjuM
	eISDDVmFRjuaeRFx50eZkyjmabLmlcAaBqyF6Je9JCC3Uu86DMoPItjmQBpivCO71Ep+vSghwddBd
	ONpAuqFA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKHUZ-0000000DrKd-3QkV;
	Tue, 05 May 2026 15:15:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 399C5300324; Tue, 05 May 2026 17:15:23 +0200 (CEST)
Date: Tue, 5 May 2026 17:15:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430213835.62217-21-yurand2000@gmail.com>
X-Rspamd-Queue-Id: 9893D4D0198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15604-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,santannapisa.it:email,infradead.org:dkim]

On Thu, Apr 30, 2026 at 11:38:24PM +0200, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Allow for cgroup hierarchies with more than two levels.
> 
> Introduce the concept of live and active groups:
> - A group is live if it is a leaf group or if all its children have zero
>   runtime.
> - A live group with non-zero runtime can be used to schedule tasks.
> - An active cgroup is a live group with running tasks.
> - A non-live group cannot be used to run tasks, but it is only used for
>   bandwidth accounting, i.e. the sum of its children bandwidth must be
>   less than or equal to the bandwidth of the parent. This change allows
>   to use cgroups for bandwidth management for different users.
> - While the root cgroup specifies the total allocatable bandwidth of rt
>   cgroups, a further accounting is performed to keep track of the live
>   bandwidth, i.e. the sum of the bandwidth of live groups. The hierarchy
>   invariant states that the live bandwidth must always be less than or
>   equal to the total allocatable bw.
> 
> Add is_live_sched_group() and sched_group_has_live_siblings() in
> deadline.c. These utility functions are used by dl_init_tg to perform
> updates only when necessary:
> - Only live groups may update the active dl bandwidth of dl entities
>   (call to dl_rq_change_utilization), while non-live groups must not use
>   servers, and thus must not change the active dl bandwidth.
> - The total bandwidth accounting must be changed to follow the
>   live/non-live rules:
>   - When disabling (runtime zero) the last child of a group, the parent
>     becomes a live group, and so the parent's bw must be accounted back.
>   - When enabling (runtime non-zero) the first child, the parent becomes a
>     non-live group, and so the parent's bandwidth must be removed.
> 
> Update tg_set_rt_bandwidth() to change the runtime of a group to a
> non-zero value only if its parent is inactive, thus forcing it to become
> non-live if it was precedently (it would've already been non-live if a
> sibling cgroup was live). An exception is made for groups which have the
> root cgroup as parent.
> 
> Update sched_rt_can_attach() to allow attaching only on live groups.
> 
> Update dl_init_tg() to take a task_group pointer and a cpu's id rather
> than passing directly the pointer to the cpu's deadline server. The
> task_group pointer is necessary to check and update the live bandwidth
> accounting.
> 
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>

This probably wants to have the cgroup folks on Cc (added now) to make
sure the semantics are in line with cgroup-v2 expectations.

