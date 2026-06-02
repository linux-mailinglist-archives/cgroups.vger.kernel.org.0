Return-Path: <cgroups+bounces-16587-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yJX3E/lkH2pilgAAu9opvQ
	(envelope-from <cgroups+bounces-16587-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 01:19:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48C632DD0
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 01:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ftb1Jwi7;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16587-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16587-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C0E03014C39
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCD30DD00;
	Tue,  2 Jun 2026 23:19:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083453A7597;
	Tue,  2 Jun 2026 23:19:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442355; cv=none; b=IW5XkESjnC1F/y8DxpF9gt27mXUiRHNezTR+1QnN21MoTueUKx7A+3a1S4MDtZiOoNMNU7xxqCEIW0WBnQJxzieWu5F8vcjtXqEvEHwbhsEJqDTUYcbE5LnRwFknImyET4npv31ZHvc4CdQ2+M8cK+GN/VtTJqiDdU/sJ9QpmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442355; c=relaxed/simple;
	bh=DrslTSQXT8cfx56wHRiJpsvTA1fviMta4VbTrLg4zTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcp3kXjMIBs+B/SeqY+bpVG7Y7JhjuOjPv35nCV6QZP0tQI7uKBv5RBXd1wZ+M5Ts/5oOHkDDolovY1YDHceem7pXsSGrZCzzKmsgAj7eFxD5DWHKW4vn6ts49CFiGfslPXLl9SxJYnREk4c4WvioHl0VRQkXSXPgXcI2dep8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftb1Jwi7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F4E1F00893;
	Tue,  2 Jun 2026 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780442352;
	bh=KCQTKKV4OkG0g4DPTo1dosbbUmHALAtgMMXh353W1do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftb1Jwi7vGUaTZ08YB0sJ8lzivTWYTQb5gxbwHrpsGAczoXYB03Jtxxu4GhdujeF9
	 4wHP/NTcSz8OqTJBEHWQ70CjZV7BF2NYZWVEag1D0NzIJAzOZ4MhKs90U8W0+ZtXjW
	 BsNXfsuVYZZlL+feBLoqauAHSiClLSnOL8MWWpo5sb2oCYqo4gCZVaWBejTi+J2oE0
	 wPY9mvm0bV+o8ktBPSpD2JAw+4gyTqQ+b7tnkLOGkL9lygFoneIRHCByRTbPLrWprB
	 R+90fhMCKQijvqOyKbidq2BCDM4HR1u1y2/Ym7dvz6hTzmsXNZvtBYY2OuqRPaIR4W
	 VLxgGAMKtUp4g==
Date: Tue, 2 Jun 2026 23:19:10 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <ah9i3uhh3PFiS0Uk@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16587-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F48C632DD0

> > > > > Proactive writeback also wants a similar per-memcg cursor that is
> > > > > scoped to the specified memcg, so that repeated invocations against
> > > > > the same memcg make forward progress across its descendant memcgs
> > > > > instead of restarting from the first child memcg each time.
> > > > 
> > > > Is this a problem in practice?
> > > > 
> > > > Is the concern the overhead of scanning memcgs repeatedly, or lack of
> > > > fairness? I wonder if we should just do writeback in batches from all
> > > > memcgs, similar to how reclaim does it, then evaluate at the end if we
> > > > need to start over?
> > > > 
> > > 
> > > Not using a per-cgroup cursor will cause issues for "repeated small-budget
> > > calls" cases. For example, repeatedly triggering a 2MB writeback might
> > > result in only writing back pages from the first few child memcgs every
> > > time. In the worst-case scenario (where the writeback amount is less than
> > > WB_BATCH), it might only ever write back from the first child memcg.
> > 
> > Right, so a fairness concern?
> > 
> > I wonder if we should just reclaim a batch from each memcg, then check
> > if we reached the goal, otherwise start over. If the batch size is small
> > enough that should work?
> 
> Even with a small batch size, for small writeback requests triggered by
> user-space (e.g., 2MB, which is batch size * N), it might still repeatedly
> write back from only the first N child memcgs.

Yes, I understand, I am asking if this is a problem in practice. For
this to be a problem we'd need to trigger small writeback requests and
have many memcgs. 

> This could cause the user-space agent to prematurely give up on zswap
> writeback.

Why? The kernel should not return before trying to writeback from all
memcgs. If we scan the first N child memcgs and did not writeback
enough, we should keep going, right?

> > What if we do something like this (for the global cursor):
> > 
> > 	do {
> > 		memcg = xchg(zswap_next_shrink, NULL);
> > 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
> > 		/* If the cursor was advanced from under us, try again */
> > 		if (!try_cmpxchg(zswap_next_shrink, NULL, memcg))
> > 			continue;
> > 	} while (..);
> > 			
> > 
> 
> Regarding the code above, IIRC, both the global and per-cgroup cursors
> suffer from race conditions. This race can cause mem_cgroup_iter(NULL, NULL,
> NULL) to return the root memcg or its descendants, leading zswap to write
> back pages from the wrong memcg.

Not the wrong memcg, it will just go back to the first memcg again,
which should be fine as I mentioned below.

> 
> Additionally, since mem_cgroup_iter() puts the prev memcg ref and gets the
> next memcg ref, a try_cmpxchg() failure on CPU1 might also lead to a ref
> leak for memcg1.
> 
> 
> 	CPU1                                       CPU2
> memcg1 = xchg(pos, NULL)
>                                memcg2 = xchg(pos, NULL) memcg2 = NULL;
> 
> memcg1 = mem_cgroup_iter()
>                        mem_cgroup_iter(NULL, **NULL**, NULL) error memcg
>                                 try_cmpxchg(pos，NULL，memcg2） succeed
> try_cmpxchg(pos，NULL，memcg1） **fail**

Yes, we can probably just take a ref on the memcg before calling
mem_cgroup_iter(). That being said, I think we can just keep the lock,
see below.

> 
> I took a stab at implementing a cmpxchg()-based zswap_mem_cgroup_iter()
> modeled after mem_cgroup_iter(), and it actually doesn't look that complex
> after all :)

I don't think we should re-implement mem_cgroup_iter() here.

[..]
> > There is a window where a racing shrinker will see the cursor as NULL
> > and start over, but that should be fine. We can generalize this for the
> > per-memcg cursor.
> > 
> > That being said..
> > 
> > > 
> > > Currently, this lock is only used in shrink_memcg(), proactive writeback,
> > > and mem_cgroup_css_offline(). Note that shrink_memcg() only acquires the
> > > lock of the root cgroup, and mem_cgroup_css_offline() is unlikely to be a
> > > hot path.
> > 
> > ..this made me realize it's probably fine to just use a global lock for
> > now?
> > 
> > IIUC the only additional contention to the existing lock will be from
> > userspace proactive writeback, and that shouldn't be a big deal
> > especially with the critical section being short?
> > 
> 
> In the current patch implementation, this lock protects the cgroup's own
> cursor variable. During each writeback, we only acquire the spin_lock of the
> target cgroup itself; we do not attempt to **spin on any child cgroup's lock
> while iterating through the descendants**.

Oh, I did not say anything about the current patch adding contention. I
am suggesting we just keep using the global lock for the per-memcg
cursors, if we keep them.

Right now, without this series, the global lock protects against
concurrent changes to the global cursor from concurrent shrinkers. After
the series, the only added contenders are userspace proactive writeback
threads. Unless you have 10s or 100s of those, it should be fine to keep
a single global lock, right?

Yes, userspace can affect writeback efficiency, but we can split the
lock when it actually causes a problem.

> 
> 
> > > 
> > > So, should we keep the spin_lock or go with the cmpxchg() approach?
> > > Yosry and Nhat, what are your thoughts on this?
> > 
> > I think we should experiment with the global lock first. See if you
> > observe any regressions with workloads that put a lot of pressure on the
> > lock (a lot of threads in reclaim doing writeback + a few userspace
> > threads doing proactive writeback). See if the userspace threads
> > actually cause a meaningful regression.
> 
> Sorry, it seems there are some implementation issues with the global lock
> approach.
> 
> In practice, our user-space agent mostly operates in the following two
> scenarios:
>  - Triggering proactive writeback on the same cgroup at different times
> (sequentially).
>  - Triggering proactive writeback on different cgroups at the same time
> (concurrently).
> 
> In both cases, there is no lock contention. So, the current lock works
> perfectly fine for us.

Would using the existing global lock work for your use case? How many
different cgroups can you end up reclaiming from concurrently?

> 
> However, if we really hate zswap_wb_iter.lock, I can try replacing it with
> the cmpxchg() approach.
> 
> Thanks,
> Hao

