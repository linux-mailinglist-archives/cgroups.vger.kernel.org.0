Return-Path: <cgroups+bounces-12622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB40CDB009
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0689830BA2C6
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC902D8367;
	Wed, 24 Dec 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKujYfz3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B422D8372;
	Wed, 24 Dec 2025 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536996; cv=none; b=ipw1xwBHRKysKqa+UUMJSvxDs61PFmcLAMYby9x0FuBkaufOmq2lRxEY47W2RQsDJM73GNGjODtI9oVUoQ2UWE4pDUONpennLTL7kE4EdgzajXTgCRF8G18FKBMDR7pBBjktcLnx++wUk+FFwjQL2qNig4ABtal16W/t3gAQry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536996; c=relaxed/simple;
	bh=Le0x0ezL4ikD9O2xhmuDakOxMEwCFQpXNin1IF0A9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAjk4Zq16cWxfRy2Y6zb3HhWXfW6QdPfP5YVWD/WB5CYmFPZTa+qtco455Ze3c230tsgcRqN0ksKsKS0ANuT53ANq6GhrFtHVgb//8SQsKCwNy3ooLowEalxKxN3InysjRu/sZK8AwfPFtcMLz7WsiD4JnRBa1rDvk97YEpIWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKujYfz3; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Dec 2025 00:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766536990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p/NBqFZeLVjN6xggAhBjlG26Cbhd95DkUEqc0nS51M=;
	b=qKujYfz3DzhT15fZcIF1ioBx4jguu4eGfWOe8iZC5y5m7JZeVIQ70f14oXwUvV3DnuBP4Y
	qfQPwgvD/pVENwjasoqTo1crCWs09DjGvVFg2E1G/mWBkuaq5JOS+inH4CZXy/KSP0FQB2
	a8wvniBYxCl3Ks+C73Fm+YCNFp3492Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
 <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 23, 2025 at 04:36:18PM -0800, Shakeel Butt wrote:
> On Wed, Dec 24, 2025 at 12:07:50AM +0000, Yosry Ahmed wrote:
> > On Tue, Dec 23, 2025 at 03:20:47PM -0800, Shakeel Butt wrote:
> > > On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
> > > [...]
> > > > 
> > > > I think there might be a problem with non-hierarchical stats on cgroup
> > > > v1, I brought it up previously [*]. I am not sure if this was addressed
> > > > but I couldn't immediately find anything.
> > > 
> > > Sigh, the curse of memcg-v1. Let's see what we can do to not break v1.
> > > 
> > > > 
> > > > In short, if memory is charged to a dying cgroup 
> > > 
> > > Not sure why stats updates for dying cgroup is related. Isn't it simply
> > > stat increase at the child memcg and then stat decrease at the parent
> > > memcg would possibly show negative stat_local of the parent.
> > 
> > Hmm not sure I understand what you mean here. Normally an update to the
> > child memcg should not update state_local of the parent. So outside the
> > context of dying cgroups and reparenting I don't see how state_local of
> > the parent can become negative.
> 
> We might be talking about same thing. When you said "memory is charged
> to a dying cgroup", it does not have to be dying cgroup, it can be alive
> child which died later. So to give an example, let's say a process in
> the child allocates a file page, NR_FILE_PAGES is increased at the
> child and next child has been rmdir'ed, so when that specific file page
> is freed, the NR_FILE_PAGES will be decreased at the parent after this
> series.

Yes this is exactly what I mean. Specifically, an update happens after
the cgroup becomes "dying".

> 
> > 
> > > 
> > > > at the time of
> > > > reparenting, when the memory gets uncharged the stats updates will occur
> > > > at the parent. This will update both hierarchical and non-hierarchical
> > > > stats of the parent, which would corrupt the parent's non-hierarchical
> > > > stats (because those counters were never incremented when the memory was
> > > > charged).
> > > > 
> > > > I didn't track down which stats are affected by this, but off the top of
> > > > my head I think all stats tracking anon, file, etc.
> > > 
> > > Let's start with what specific stats might be effected. First the stats
> > > which are monotonically increasing should be fine, like
> > > WORKINGSET_REFAULT_[ANON|FILE], PGPG[IN|OUT], PG[MAJ]FAULT.
> > > 
> > > So, the following ones are the interesting ones:
> > > 
> > > NR_FILE_PAGES, NR_ANON_MAPPED, NR_ANON_THPS, NR_SHMEM, NR_FILE_MAPPED,
> > > NR_FILE_DIRTY, NR_WRITEBACK, MEMCG_SWAP, NR_SWAPCACHE.
> > > 
> > > > 
> > > > The obvious solution is to flush and reparent the stats of a dying memcg
> > > > during reparenting,
> > > 
> > > Again not sure how flushing will help here and what do you mean by
> > > 'reparent the stats'? Do you mean something like:
> > 
> > Oh I meant we just need to do an rstat flush to aggregate per-CPU
> > counters before moving the stats from child to parent.
> > 
> > > 
> > > parent->vmstats->state_local += child->vmstats->state_local;
> > > 
> > > Hmm this seems fine and I think it should work.
> > 
> > Something like that, I didn't look too closely if there's anything else
> > that needs to be reparented.
> > 
> > > 
> > > > but I don't think this entirely fixes the problem
> > > > because the dying memcg stats can still be updated after its reparenting
> > > > (e.g. if a ref to the memcg has been held since before reparenting).
> > > 
> > > How can dying memcg stats can still be updated after reparenting? The
> > > stats which we care about are the anon & file memory and this series is
> > > reparenting them, so dying memcg will not see stats updates unless there
> > > is a concurrent update happening and I think it is very easy to avoid
> > > such situation by putting a grace period between reparenting the
> > > file/anon folios and reparenting dying chils'd stats_local. Am I missing
> > > something?
> > 
> > What prevents the code from obtaining a ref to a parent's memcg
> 
> I think you meant child's memcg here.

Yes, sorry.

> 
> > before
> > reparenting, and using it to update the stats after reparenting? A grace
> > period only works if the entire scope of using the memcg is within the
> > RCU critical section.
> 
> Yeah this is an issue.
> 
> > 
> > For example, __mem_cgroup_try_charge_swap() currently does this when
> > incrementing MEMCG_SWAP. While this specific example isn't problematic
> > because the reference won't be dropped until MEMCG_SWAP is decremented
> > again, the pattern of grabbing a ref to the memcg then updating a stat
> > could generally cause the problem.
> > 
> > Most stats are updated using lruvec_stat_mod_folio(), which updates the
> > stats in the same RCU critical section as obtaining the memcg pointer
> > from the folio, so it can be fixed with a grace period. However, I think
> > it can be easily missed in the future if other code paths update memcg
> > stats in a different way. We should try to enforce that stat updates
> > cannot only happen from the same RCU critical section where the memcg
> > pointer is acquired.
> 
> The core stats update functions are mod_memcg_state() and
> mod_memcg_lruvec_state(). If for v1 only, we add additional check for
> CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
> this issue?

But this is still racy, right? The cgroup could become dying right after
we check CSS_DYING, no?

