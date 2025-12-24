Return-Path: <cgroups+bounces-12621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17223CDB01B
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 01:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2333008D58
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B881FBC92;
	Wed, 24 Dec 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obHAR9Xy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFD188596
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536602; cv=none; b=BZQLTz7RqnQzUAZsHXltphZEh2MrGZz6Flxf+ql8GTSAArHheXBZcH2dUKRoHpUlMr7JKtjizN9yAewv17q7ed9aRUeIqw/dcLEfh7U49lOKf7Prenw+KLOASc9a64t5VQGE3e3xnifAoFTb+AxXUG3aew031hz/wpr+dp4oASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536602; c=relaxed/simple;
	bh=fN87WTEoanoricIniPYswai36Eh7U2jS43ftzDtI55Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQhe3y7dYL8oYLJWdVVrVLI0c99pZZA1UX+FshNnTFJ3SrcLCKvM+45cOJsAIi4tN6zaLSpLx10/MS83aJMnSOIArnB+lPy6deaIJpixwFhrQgLF1a77TfLKfIX8uMlpdB81QMJNfj/uwT9OPCiRLVyzYNRjs3a3IXP2KdH6wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obHAR9Xy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 16:36:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766536585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvTruLv6Dhc42akl1jnVGxsC5c+HgJvahoPGXJ5OJlo=;
	b=obHAR9XyEqk3PowbYmJC/l/XhQ0RpW3LyXN8vgo9SnxT2aQOrSGCQkA4wFJiFyMuYvnqWM
	gXaDcvSyZrp6SjGvLJhTsU1zmKgXyqgbw8vw5RvhMpKMCT10qbKwoBJ7r/suj6192unExW
	J/CE1F/T/C64RuOhmVYACJw2csgHCqY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 24, 2025 at 12:07:50AM +0000, Yosry Ahmed wrote:
> On Tue, Dec 23, 2025 at 03:20:47PM -0800, Shakeel Butt wrote:
> > On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
> > [...]
> > > 
> > > I think there might be a problem with non-hierarchical stats on cgroup
> > > v1, I brought it up previously [*]. I am not sure if this was addressed
> > > but I couldn't immediately find anything.
> > 
> > Sigh, the curse of memcg-v1. Let's see what we can do to not break v1.
> > 
> > > 
> > > In short, if memory is charged to a dying cgroup 
> > 
> > Not sure why stats updates for dying cgroup is related. Isn't it simply
> > stat increase at the child memcg and then stat decrease at the parent
> > memcg would possibly show negative stat_local of the parent.
> 
> Hmm not sure I understand what you mean here. Normally an update to the
> child memcg should not update state_local of the parent. So outside the
> context of dying cgroups and reparenting I don't see how state_local of
> the parent can become negative.

We might be talking about same thing. When you said "memory is charged
to a dying cgroup", it does not have to be dying cgroup, it can be alive
child which died later. So to give an example, let's say a process in
the child allocates a file page, NR_FILE_PAGES is increased at the
child and next child has been rmdir'ed, so when that specific file page
is freed, the NR_FILE_PAGES will be decreased at the parent after this
series.

> 
> > 
> > > at the time of
> > > reparenting, when the memory gets uncharged the stats updates will occur
> > > at the parent. This will update both hierarchical and non-hierarchical
> > > stats of the parent, which would corrupt the parent's non-hierarchical
> > > stats (because those counters were never incremented when the memory was
> > > charged).
> > > 
> > > I didn't track down which stats are affected by this, but off the top of
> > > my head I think all stats tracking anon, file, etc.
> > 
> > Let's start with what specific stats might be effected. First the stats
> > which are monotonically increasing should be fine, like
> > WORKINGSET_REFAULT_[ANON|FILE], PGPG[IN|OUT], PG[MAJ]FAULT.
> > 
> > So, the following ones are the interesting ones:
> > 
> > NR_FILE_PAGES, NR_ANON_MAPPED, NR_ANON_THPS, NR_SHMEM, NR_FILE_MAPPED,
> > NR_FILE_DIRTY, NR_WRITEBACK, MEMCG_SWAP, NR_SWAPCACHE.
> > 
> > > 
> > > The obvious solution is to flush and reparent the stats of a dying memcg
> > > during reparenting,
> > 
> > Again not sure how flushing will help here and what do you mean by
> > 'reparent the stats'? Do you mean something like:
> 
> Oh I meant we just need to do an rstat flush to aggregate per-CPU
> counters before moving the stats from child to parent.
> 
> > 
> > parent->vmstats->state_local += child->vmstats->state_local;
> > 
> > Hmm this seems fine and I think it should work.
> 
> Something like that, I didn't look too closely if there's anything else
> that needs to be reparented.
> 
> > 
> > > but I don't think this entirely fixes the problem
> > > because the dying memcg stats can still be updated after its reparenting
> > > (e.g. if a ref to the memcg has been held since before reparenting).
> > 
> > How can dying memcg stats can still be updated after reparenting? The
> > stats which we care about are the anon & file memory and this series is
> > reparenting them, so dying memcg will not see stats updates unless there
> > is a concurrent update happening and I think it is very easy to avoid
> > such situation by putting a grace period between reparenting the
> > file/anon folios and reparenting dying chils'd stats_local. Am I missing
> > something?
> 
> What prevents the code from obtaining a ref to a parent's memcg

I think you meant child's memcg here.

> before
> reparenting, and using it to update the stats after reparenting? A grace
> period only works if the entire scope of using the memcg is within the
> RCU critical section.

Yeah this is an issue.

> 
> For example, __mem_cgroup_try_charge_swap() currently does this when
> incrementing MEMCG_SWAP. While this specific example isn't problematic
> because the reference won't be dropped until MEMCG_SWAP is decremented
> again, the pattern of grabbing a ref to the memcg then updating a stat
> could generally cause the problem.
> 
> Most stats are updated using lruvec_stat_mod_folio(), which updates the
> stats in the same RCU critical section as obtaining the memcg pointer
> from the folio, so it can be fixed with a grace period. However, I think
> it can be easily missed in the future if other code paths update memcg
> stats in a different way. We should try to enforce that stat updates
> cannot only happen from the same RCU critical section where the memcg
> pointer is acquired.

The core stats update functions are mod_memcg_state() and
mod_memcg_lruvec_state(). If for v1 only, we add additional check for
CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
this issue?




