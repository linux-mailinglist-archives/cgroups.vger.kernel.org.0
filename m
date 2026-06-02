Return-Path: <cgroups+bounces-16534-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJdqGXokHmoohgkAu9opvQ
	(envelope-from <cgroups+bounces-16534-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 02:31:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF269626902
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6053029AD0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE362DCF41;
	Tue,  2 Jun 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1O5VgG7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B4286D7D;
	Tue,  2 Jun 2026 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360306; cv=none; b=NpztX+Wlnc8/4CRtWXeg1lg9P1oXi4C1+JO/ZZPUdJXk8GxzaPdctAhVbl8gNJafUPO6HN0Jh2VwwMTZY1UUf7Fhlvl49LnUmeNxACzPsh+SELqFK0HfVFq4lvcrfeA8NN6J0DdKwlPec2KpOAyFx+soZruQkqtyKsCP1UaaWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360306; c=relaxed/simple;
	bh=+8sQrUqGSN1oOA5tT/s+QkoUQ8LxHayYh2tkLGm+6aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRy3lFGGMULVqHBxATllNxsaB1Fs5p7C7ow+q7zos7rOLFdaGNaHyWdCLrxhaYYzgXJPKqZ3vK/+slYyJ+zx1CJDd1qif/yMd12VRTvSQqp1bgwb3Zy55CGu4dT3BYHgHsQk1D2uE5A41UrcHu49DPKP1y1XNWPD/r6nGEhnxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1O5VgG7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0391F00893;
	Tue,  2 Jun 2026 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780360304;
	bh=dvpsrQF436x2L0cWUtnjT+RXsKFfyVf7IVhk+awr3Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1O5VgG7fthYL5WKXAy3t/bCYnCqhKDmIUjEsm+ZGqi+ffXciopqgn1893NvG6rUo
	 PXyr5CNlmK0mjIB18aA5+8RD1D2IBm2SonVoAbGBtTdSDuXofu/Nhr9Qc12RD5QfFi
	 UmPwy7FucbWywRVVYGfBV7HJezhTMxaDpmhH+yP44zkO5Z/9z0zOh6rwNCSxdHM9ef
	 5ic6sxSiFHOkYFzrZmUyD0uFU72zisqaoyuoazfFbDgXuXeOFzGXz9v+mgeBo3sSNq
	 cshKdE57GJRSp5CmcTSFHCz/NC+2tfW7kW859Uhr1xAGX7GFsFy59m3DE39N+1qzid
	 wFBEPHOsVNq4w==
Date: Tue, 2 Jun 2026 00:31:42 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <ah4ZZGl7GYJf54Wz@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16534-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF269626902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 07:07:45PM +0800, Hao Jia wrote:
> 
> 
> On 2026/5/30 09:24, Yosry Ahmed wrote:
> > On Tue, May 26, 2026 at 07:45:58PM +0800, Hao Jia wrote:
> > > From: Hao Jia <jiahao1@lixiang.com>
> > > 
> > > The zswap background writeback worker shrink_worker() uses a global
> > > cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
> > > across the online memcgs under root_mem_cgroup.
> > > 
> > > Proactive writeback also wants a similar per-memcg cursor that is
> > > scoped to the specified memcg, so that repeated invocations against
> > > the same memcg make forward progress across its descendant memcgs
> > > instead of restarting from the first child memcg each time.
> > 
> > Is this a problem in practice?
> > 
> > Is the concern the overhead of scanning memcgs repeatedly, or lack of
> > fairness? I wonder if we should just do writeback in batches from all
> > memcgs, similar to how reclaim does it, then evaluate at the end if we
> > need to start over?
> > 
> 
> Not using a per-cgroup cursor will cause issues for "repeated small-budget
> calls" cases. For example, repeatedly triggering a 2MB writeback might
> result in only writing back pages from the first few child memcgs every
> time. In the worst-case scenario (where the writeback amount is less than
> WB_BATCH), it might only ever write back from the first child memcg.

Right, so a fairness concern?

I wonder if we should just reclaim a batch from each memcg, then check
if we reached the goal, otherwise start over. If the batch size is small
enough that should work?

> 
> Similar to how memory reclaim uses mem_cgroup_iter() (via struct
> mem_cgroup_reclaim_iter) and the old shrink_worker() used zswap_next_shrink,
> we need a shared cursor here.

Right, I understand that in theory we need a cursor. I am just wondering
if the complexity is justified in practice. Reclaim is a much larger
beast than zswap writeback. I wonder if we can just get away with
scanning a batch from each child memcg -- for per-memcg reclaim, not
global.

We can always improve it later with a cursor if there's an actual need.

> 
> 
> > > 
> > > Naturally, group the cursor and its protecting spinlock into a
> > > zswap_wb_iter struct, and make it a member of struct mem_cgroup to
> > > realize per-memcg cursor management. Accordingly, shrink_worker() now
> > > uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.
> > 
> > If we really need to have per-memcg cursors (I am not a big fan), I
> > think we can minimize the overhead by making the cursor updates use
> > atomic cmpxchg instead of having a per-memcg lock.
> > 
> 
> Because mem_cgroup_iter() always calls css_put(&prev->css), we cannot simply
> update zswap_wb_iter.pos via cmpxchg() after calling it. Doing so could lead
> to a double css_put() issue on prev->css.
> 
> Therefore, if we switch to the cmpxchg() approach, we wouldn't be able to
> reuse the existing mem_cgroup_iter() logic. We would have to write a new
> function similar to cgroup_iter(), and its implementation might end up
> looking a bit obscure/complex.

What if we do something like this (for the global cursor):

	do {
		memcg = xchg(zswap_next_shrink, NULL);
		memcg = mem_cgroup_iter(NULL, memcg, NULL);
		/* If the cursor was advanced from under us, try again */
		if (!try_cmpxchg(zswap_next_shrink, NULL, memcg))
			continue;
	} while (..);
			

There is a window where a racing shrinker will see the cursor as NULL
and start over, but that should be fine. We can generalize this for the
per-memcg cursor.

That being said..

> 
> Currently, this lock is only used in shrink_memcg(), proactive writeback,
> and mem_cgroup_css_offline(). Note that shrink_memcg() only acquires the
> lock of the root cgroup, and mem_cgroup_css_offline() is unlikely to be a
> hot path.

..this made me realize it's probably fine to just use a global lock for
now?

IIUC the only additional contention to the existing lock will be from
userspace proactive writeback, and that shouldn't be a big deal
especially with the critical section being short?

> 
> So, should we keep the spin_lock or go with the cmpxchg() approach?
> Yosry and Nhat, what are your thoughts on this?

I think we should experiment with the global lock first. See if you
observe any regressions with workloads that put a lot of pressure on the
lock (a lot of threads in reclaim doing writeback + a few userspace
threads doing proactive writeback). See if the userspace threads
actually cause a meaningful regression.

> 
> 
> 
> > > 
> > > Because the cursor is now per-memcg, the offline cleanup must visit
> > > every ancestor that could be holding a reference to the dying memcg.
> > > Factor out __zswap_memcg_offline_cleanup() and walk from dead_memcg up
> > > to the root.
> > 
> > Another reason why I don't like per-memcg cursors. There is too much
> > complexity and I wonder if it's warranted. If we stick with per-memcg
> > cursors please do the refactoring in separate patches to make the
> > patches easier to review.
> 
> 
> Sorry about that. I will try to keep each patch as simple as possible in the
> next version.

No worries, thanks!

> 
> 
> Thanks,
> Hao
> 
> 

