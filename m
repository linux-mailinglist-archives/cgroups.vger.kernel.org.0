Return-Path: <cgroups+bounces-11925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35541C57423
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 12:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F6B3A1432
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512633DED8;
	Thu, 13 Nov 2025 11:45:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8205347BB8
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034327; cv=none; b=hkFPExWrgDXYymucEEX4JEatp1hZ8ztBbNb2tbw72kTRQjZPme9c1LqaWGeRjlaiYBeT6NiGQ+KnVV42xMJDuQil0vwa2e3JpC+UHzJqw+4x7dSUmogI/BrrnDzRrFa3/hK0s2TH1Og3rhYZb3yiphnGxZuXpnU7mpuigiWfngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034327; c=relaxed/simple;
	bh=8Bjk7Se1d3lR9ScfHQTRNdgp+wGA4HYwbSkDp1IrILw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUOiU8PaTXfp+xrx+TGSUoA9rm/7eaDme7KLhOkNVURruo05WAudI6446bf/6YhkMy5h0wmbvh5CYUPMvnppCufoJ681lcoqnP9Mv3+AnEkfG6QqdW9MQTHlC2wqrDFf9USNDF/1ynAzBpijMD85pW8QDGNsIt52l8zaOPv0Wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Nov 2025 20:45:22 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 13 Nov 2025 20:45:22 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisl@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: Re: [PATCH 1/3] mm, swap: change back to use each swap device's
 percpu cluster
Message-ID: <aRXE0ppned4Kprnz@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-2-youngjun.park@lge.com>
 <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>

On Thu, Nov 13, 2025 at 02:07:59PM +0800, Kairui Song wrote:
> On Sun, Nov 9, 2025 at 8:54 PM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> > allocation fast path").
> >
> > Because in the newly introduced swap tiers, the global percpu cluster
> > will cause two issues:
> > 1) it will cause caching oscillation in the same order of different si
> >    if two different memcg can only be allowed to access different si and
> >    both of them are swapping out.
> > 2) It can cause priority inversion on swap devices. Imagine a case where
> >    there are two memcg, say memcg1 and memcg2. Memcg1 can access si A, B
> >    and A is higher priority device. While memcg2 can only access si B.
> >    Then memcg 2 could write the global percpu cluster with si B, then
> >    memcg1 take si B in fast path even though si A is not exhausted.
> >
> > Hence in order to support swap tier, revert commit 1b7e90020eb7 to use
> > each swap device's percpu cluster.
> >
> > Co-developed-by: Baoquan He <bhe@redhat.com>
> > Suggested-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
>
> Hi Youngjun, Baoquan, Thanks for the work on the percpu cluster thing.

Hello Kairui,

> It will be better if you can provide some benchmark result since the
> whole point of global percpu cluster is to improve the performance and
> get rid of the swap slot cache.

After RFC stage,
I will try to prepare benchmark results.

> I'm fine with a small regression but we better be aware of it. And we
> can still figure out some other ways to optimize it. e.g. I remember
> Chris once mentioned an idea of having a per device slot cache, that
> is different from the original slot cache (swap_slot.c): the allocator
> will be aware of it so it will be much cleaner.

Ack, we will work on better optimization.

> > ---
> >  include/linux/swap.h |  13 +++-
> >  mm/swapfile.c        | 151 +++++++++++++------------------------------
> >  2 files changed, 56 insertions(+), 108 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 38ca3df68716..90fa27bb7796 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -250,10 +250,17 @@ enum {
> >  #endif
> >
> >  /*
> > - * We keep using same cluster for rotational device so IO will be sequential.
> > - * The purpose is to optimize SWAP throughput on these device.
> > + * We assign a cluster to each CPU, so each CPU can allocate swap entry from
> > + * its own cluster and swapout sequentially. The purpose is to optimize swapout
> > + * throughput.
> >   */
> > +struct percpu_cluster {
> > +       local_lock_t lock; /* Protect the percpu_cluster above */
>
> I think you mean "below"?

This comment was originally written this way in the earlier code, and it
seems to refer to the percpu_cluster structure itself rather than the
fields below. But I agree it's a bit ambiguous. I'll just remove this
comment since the structure name is self-explanatory. Or change it to below. :)

> > +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
> > +};
> > +
> >
> > -/*
> > - * Fast path try to get swap entries with specified order from current
> > - * CPU's swap entry pool (a cluster).
> > - */
> > -static bool swap_alloc_fast(swp_entry_t *entry,
> > -                           int order)
> > -{
> > -       struct swap_cluster_info *ci;
> > -       struct swap_info_struct *si;
> > -       unsigned int offset, found = SWAP_ENTRY_INVALID;
> > -
> > -       /*
> > -        * Once allocated, swap_info_struct will never be completely freed,
> > -        * so checking it's liveness by get_swap_device_info is enough.
> > -        */
> > -       si = this_cpu_read(percpu_swap_cluster.si[order]);
> > -       offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> > -       if (!si || !offset || !get_swap_device_info(si))
> > -               return false;
> > -
> > -       ci = swap_cluster_lock(si, offset);
> > -       if (cluster_is_usable(ci, order)) {
> > -               if (cluster_is_empty(ci))
> > -                       offset = cluster_offset(si, ci);
> > -               found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
> > -               if (found)
> > -                       *entry = swp_entry(si->type, found);
> > -       } else {
> > -               swap_cluster_unlock(ci);
> > -       }
> > -
> > -       put_swap_device(si);
> > -       return !!found;
> > -}
> > -
> >  /* Rotate the device and switch to a new cluster */
> > -static bool swap_alloc_slow(swp_entry_t *entry,
> > +static void swap_alloc_entry(swp_entry_t *entry,
> >                             int order)
>
> It seems you also changed the rotation rule here so every allocation
> of any order is causing a swap device rotation? Before 1b7e90020eb7
> every 64 allocation causes a rotation as we had slot cache
> (swap_slot.c). The global cluster makes the rotation happen for every
> cluster so the overhead is even lower on average. But now a per
> allocation rotation seems a rather high overhead and may cause serious
> fragmentation.

Yeah... The rotation rule has indeed changed. I remember the
discussion about rotation behavior:
https://lore.kernel.org/linux-mm/aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330/

After that discussion, I've been thinking about the rotation.
Currently, the requeue happens after every priority list traversal, and this logic
is easily affected by changes.
The rotation logic change behavior change is not not mentioned somtimes.
(as you mentioned in commit 1b7e90020eb7).

I'd like to share some ideas and hear your thoughts:

1. Getting rid of the same priority requeue rule
   - same priority devices get priority - 1 or + 1 after requeue
     (more add or remove as needed to handle any overlapping priority appropriately)

2. Requeue only when a new cluster is allocated
   - Instead of requeueing after every priority list traversal, we
     requeue only when a cluster is fully used
   - This might have some performance impact, but the rotation behavior
     would be similar to the existing one (though slightly different due
     to synchronization and logic processing changes)

Going further with these approaches, if we remove the requeue mechanism
entirely, we could potentially reduce synchronization overhead during
plist traversal. (degrade the lock)

I'm curious what do you think about these possibilities?

Youngjun Park

