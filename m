Return-Path: <cgroups+bounces-11944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1BC5AE0C
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 02:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC5C3B192A
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1C21CC60;
	Fri, 14 Nov 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+IIlc2K"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA22116F4
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082348; cv=none; b=RRLBL/ox3V87SOBNdyrQAGEDfOyUqkFzJsw+4BLdquQnaZoPF8viTZrfKDrdQDW92WAOOVEr7LxwfMZaHN9rwTgQS0tJWMX3sh+T9oOmmu8zbRM2bmYWvgaDCSFxA1eRQhCyhlxLd9uO7CaZ8gixv0IzcWwa7hgGlRQOhgQrc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082348; c=relaxed/simple;
	bh=hWCKdO4oE1iGD2+/fLgtyoVHxYKVwfTQWtkT4nGHcBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+l/pRPOvC1qdHCuHUtKF3JyQ0AjxK3FdGSkfs631WxJ9nfxF/3etHxrFW1l2DCnngnkM0y2HGmwrTLqN9Fh3ILNbja3kdbXGO2xk5PEcnXP7dTplZx6Bt00PS7h/30HNcibHd25Qp+DOX8mPLcVA7Twuq75Ni+b+VyFCHT5/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+IIlc2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763082345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHpvy+dt2D7kRucAfZrZc/1IWiFzNfAv62SU5Sy7nig=;
	b=G+IIlc2Kh81J8Nk42VakhZ5SQVHxOjxw+3ui8+v9FkiIDj6Hnkt8AgAQRem+UNH60bBO49
	PcAlBD3/0bd5WhwbwHHVwv24N/yI1iOGsEgD9VqdODQWLQ9RH5mp/A+zLvf+ELJc5mobca
	1bJxoiQCNgig9LKCeHGjLavD6Sl+Lko=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596--lLcIvL2NICkYdqatfb8qQ-1; Thu,
 13 Nov 2025 20:05:42 -0500
X-MC-Unique: -lLcIvL2NICkYdqatfb8qQ-1
X-Mimecast-MFC-AGG-ID: -lLcIvL2NICkYdqatfb8qQ_1763082340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B56261800451;
	Fri, 14 Nov 2025 01:05:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC00300018D;
	Fri, 14 Nov 2025 01:05:35 +0000 (UTC)
Date: Fri, 14 Nov 2025 09:05:31 +0800
From: Baoquan He <bhe@redhat.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisl@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/3] mm, swap: change back to use each swap device's
 percpu cluster
Message-ID: <aRaAW5G7NDWDu5/D@MiWiFi-R3L-srv>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-2-youngjun.park@lge.com>
 <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>
 <aRXE0ppned4Kprnz@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRXE0ppned4Kprnz@yjaykim-PowerEdge-T330>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/13/25 at 08:45pm, YoungJun Park wrote:
> On Thu, Nov 13, 2025 at 02:07:59PM +0800, Kairui Song wrote:
> > On Sun, Nov 9, 2025 at 8:54 PM Youngjun Park <youngjun.park@lge.com> wrote:
> > >
> > > This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> > > allocation fast path").
> > >
> > > Because in the newly introduced swap tiers, the global percpu cluster
> > > will cause two issues:
> > > 1) it will cause caching oscillation in the same order of different si
> > >    if two different memcg can only be allowed to access different si and
> > >    both of them are swapping out.
> > > 2) It can cause priority inversion on swap devices. Imagine a case where
> > >    there are two memcg, say memcg1 and memcg2. Memcg1 can access si A, B
> > >    and A is higher priority device. While memcg2 can only access si B.
> > >    Then memcg 2 could write the global percpu cluster with si B, then
> > >    memcg1 take si B in fast path even though si A is not exhausted.
> > >
> > > Hence in order to support swap tier, revert commit 1b7e90020eb7 to use
> > > each swap device's percpu cluster.
> > >
> > > Co-developed-by: Baoquan He <bhe@redhat.com>
> > > Suggested-by: Kairui Song <kasong@tencent.com>
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> >
> > Hi Youngjun, Baoquan, Thanks for the work on the percpu cluster thing.
> 
> Hello Kairui,
> 
> > It will be better if you can provide some benchmark result since the
> > whole point of global percpu cluster is to improve the performance and
> > get rid of the swap slot cache.
> 
> After RFC stage,
> I will try to prepare benchmark results.
> 
> > I'm fine with a small regression but we better be aware of it. And we
> > can still figure out some other ways to optimize it. e.g. I remember
> > Chris once mentioned an idea of having a per device slot cache, that
> > is different from the original slot cache (swap_slot.c): the allocator
> > will be aware of it so it will be much cleaner.
> 
> Ack, we will work on better optimization.
> 
> > > ---
> > >  include/linux/swap.h |  13 +++-
> > >  mm/swapfile.c        | 151 +++++++++++++------------------------------
> > >  2 files changed, 56 insertions(+), 108 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 38ca3df68716..90fa27bb7796 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -250,10 +250,17 @@ enum {
> > >  #endif
> > >
> > >  /*
> > > - * We keep using same cluster for rotational device so IO will be sequential.
> > > - * The purpose is to optimize SWAP throughput on these device.
> > > + * We assign a cluster to each CPU, so each CPU can allocate swap entry from
> > > + * its own cluster and swapout sequentially. The purpose is to optimize swapout
> > > + * throughput.
> > >   */
> > > +struct percpu_cluster {
> > > +       local_lock_t lock; /* Protect the percpu_cluster above */
> >
> > I think you mean "below"?
> 
> This comment was originally written this way in the earlier code, and it
> seems to refer to the percpu_cluster structure itself rather than the
> fields below. But I agree it's a bit ambiguous. I'll just remove this
> comment since the structure name is self-explanatory. Or change it to below. :)
> 
> > > +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
> > > +};
> > > +
> > >
> > > -/*
> > > - * Fast path try to get swap entries with specified order from current
> > > - * CPU's swap entry pool (a cluster).
> > > - */
> > > -static bool swap_alloc_fast(swp_entry_t *entry,
> > > -                           int order)
> > > -{
> > > -       struct swap_cluster_info *ci;
> > > -       struct swap_info_struct *si;
> > > -       unsigned int offset, found = SWAP_ENTRY_INVALID;
> > > -
> > > -       /*
> > > -        * Once allocated, swap_info_struct will never be completely freed,
> > > -        * so checking it's liveness by get_swap_device_info is enough.
> > > -        */
> > > -       si = this_cpu_read(percpu_swap_cluster.si[order]);
> > > -       offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> > > -       if (!si || !offset || !get_swap_device_info(si))
> > > -               return false;
> > > -
> > > -       ci = swap_cluster_lock(si, offset);
> > > -       if (cluster_is_usable(ci, order)) {
> > > -               if (cluster_is_empty(ci))
> > > -                       offset = cluster_offset(si, ci);
> > > -               found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
> > > -               if (found)
> > > -                       *entry = swp_entry(si->type, found);
> > > -       } else {
> > > -               swap_cluster_unlock(ci);
> > > -       }
> > > -
> > > -       put_swap_device(si);
> > > -       return !!found;
> > > -}
> > > -
> > >  /* Rotate the device and switch to a new cluster */
> > > -static bool swap_alloc_slow(swp_entry_t *entry,
> > > +static void swap_alloc_entry(swp_entry_t *entry,
> > >                             int order)
> >
> > It seems you also changed the rotation rule here so every allocation
> > of any order is causing a swap device rotation? Before 1b7e90020eb7
> > every 64 allocation causes a rotation as we had slot cache
> > (swap_slot.c). The global cluster makes the rotation happen for every
> > cluster so the overhead is even lower on average. But now a per
> > allocation rotation seems a rather high overhead and may cause serious
> > fragmentation.
> 
> Yeah... The rotation rule has indeed changed. I remember the
> discussion about rotation behavior:
> https://lore.kernel.org/linux-mm/aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330/
> 
> After that discussion, I've been thinking about the rotation.
> Currently, the requeue happens after every priority list traversal, and this logic
> is easily affected by changes.
> The rotation logic change behavior change is not not mentioned somtimes.
> (as you mentioned in commit 1b7e90020eb7).
> 
> I'd like to share some ideas and hear your thoughts:
> 
> 1. Getting rid of the same priority requeue rule
>    - same priority devices get priority - 1 or + 1 after requeue
>      (more add or remove as needed to handle any overlapping priority appropriately)
> 
> 2. Requeue only when a new cluster is allocated
>    - Instead of requeueing after every priority list traversal, we
>      requeue only when a cluster is fully used
>    - This might have some performance impact, but the rotation behavior
>      would be similar to the existing one (though slightly different due
>      to synchronization and logic processing changes)

2) sounds better to me, and the logic and code change is simpler.
> 
> Going further with these approaches, if we remove the requeue mechanism
> entirely, we could potentially reduce synchronization overhead during
> plist traversal. (degrade the lock)

Removing requeue may change behaviour. Swap devices of the same priority
should be round robin to take.


