Return-Path: <cgroups+bounces-11990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCFC60267
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 10:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15B11356AF6
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE66257828;
	Sat, 15 Nov 2025 09:28:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168D242D87
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763198907; cv=none; b=WAxoFTB2f5nu4l3JkqBPZXHHu2h2LMmNqEGq1Qj8/64DA62MwDQOIzEf0nnsgxfO3AFvuABsXSDoQ73LKsViJDSVlGp+4DiPQN15GkxGknsXSAnxybJi2kogM1RsYyxie9P9xW4KIEo1N1k7wHKLSIjROkZ0qv+C+vaB6ADabIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763198907; c=relaxed/simple;
	bh=PP9ng+07RNSYZH6C9fcZ3Y1dtRToGRbeKubx+ISrD1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlBdJNzpVEhlbSWujr8FC0TRw4H6G3p6+uDLkz3ngC0C37DrglyERGknNTKD1/fgcKRLbQt/0DMeUzRgN7hUbjKem5ug/BdrwxCHqDY+AXeRIVFt+jJ0gJrd1zi3k0JwRRngPtnj1L/0kTi48M6uuFCdYr0e5cWd0O7eC4niHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 15 Nov 2025 18:28:17 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 15 Nov 2025 18:28:17 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisl@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/3] mm, swap: change back to use each swap device's
 percpu cluster
Message-ID: <aRhHsbh6ZtjCJ3wP@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-2-youngjun.park@lge.com>
 <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>
 <aRXE0ppned4Kprnz@yjaykim-PowerEdge-T330>
 <aRaAW5G7NDWDu5/D@MiWiFi-R3L-srv>
 <CAMgjq7D=eULiSQzUo6AQ16DUMtL_EQaRSOXGRhMJrUzakvj5Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7D=eULiSQzUo6AQ16DUMtL_EQaRSOXGRhMJrUzakvj5Jg@mail.gmail.com>

On Fri, Nov 14, 2025 at 11:52:25PM +0800, Kairui Song wrote:
> On Fri, Nov 14, 2025 at 9:05 AM Baoquan He <bhe@redhat.com> wrote:
> > On 11/13/25 at 08:45pm, YoungJun Park wrote:
> > > On Thu, Nov 13, 2025 at 02:07:59PM +0800, Kairui Song wrote:
> > > > On Sun, Nov 9, 2025 at 8:54 PM Youngjun Park <youngjun.park@lge.com> wrote:
> > > > >
> > > > > This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> > > > > allocation fast path").
> > > > >
> > > > > Because in the newly introduced swap tiers, the global percpu cluster
> > > > > will cause two issues:
> > > > > 1) it will cause caching oscillation in the same order of different si
> > > > >    if two different memcg can only be allowed to access different si and
> > > > >    both of them are swapping out.
> > > > > 2) It can cause priority inversion on swap devices. Imagine a case where
> > > > >    there are two memcg, say memcg1 and memcg2. Memcg1 can access si A, B
> > > > >    and A is higher priority device. While memcg2 can only access si B.
> > > > >    Then memcg 2 could write the global percpu cluster with si B, then
> > > > >    memcg1 take si B in fast path even though si A is not exhausted.
> > > > >
> > > > > Hence in order to support swap tier, revert commit 1b7e90020eb7 to use
> > > > > each swap device's percpu cluster.
> > > > >
> > > > > Co-developed-by: Baoquan He <bhe@redhat.com>
> > > > > Suggested-by: Kairui Song <kasong@tencent.com>
> > > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > > >
> > > > Hi Youngjun, Baoquan, Thanks for the work on the percpu cluster thing.
> > >
> > > Hello Kairui,
> 
> ...
> 
> > >
> > > Yeah... The rotation rule has indeed changed. I remember the
> > > discussion about rotation behavior:
> > > https://lore.kernel.org/linux-mm/aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330/
> > >
> > > After that discussion, I've been thinking about the rotation.
> > > Currently, the requeue happens after every priority list traversal, and this logic
> > > is easily affected by changes.
> > > The rotation logic change behavior change is not not mentioned somtimes.
> > > (as you mentioned in commit 1b7e90020eb7).
> > >
> > > I'd like to share some ideas and hear your thoughts:
> > >
> > > 1. Getting rid of the same priority requeue rule
> > >    - same priority devices get priority - 1 or + 1 after requeue
> > >      (more add or remove as needed to handle any overlapping priority appropriately)
> > >
> > > 2. Requeue only when a new cluster is allocated
> > >    - Instead of requeueing after every priority list traversal, we
> > >      requeue only when a cluster is fully used
> > >    - This might have some performance impact, but the rotation behavior
> > >      would be similar to the existing one (though slightly different due
> > >      to synchronization and logic processing changes)
> >
> > 2) sounds better to me, and the logic and code change is simpler.
> >
> > Removing requeue may change behaviour. Swap devices of the same priority
> > should be round robin to take.
> 
> I agree. We definitely need balancing between devices of the same
> priority, cluster based rotation seems good enough.

Hello Kairui, Baoquan.
Thanks for your feedback. 

Okay I try to keep current rotation logic workable on next patch iteration.

Based on Kairui suggested previously,
We can keep the per-cpu si cache alive.
(However, since it could pick si from unselected tiers, it should
exist per tier - per cpu)

Or, following the current code structure, we could also consider,
Requeue while holding swap_avail_lock when the cluster is consumed.
 
> And I'm thinking if we can have a better rotation mechanism? Maybe
> plist isn't the best way to do rotation if we want to minimize the
> cost of rotation.

I did some more ideation.
(Although it is some workable way, next step idea. like I said just ideation )

I've been thinking about the inefficiencies with plist_requeue during
rotation, and the plist_for_each_entry traversal structure itself.
There is also small problem like it can be ended up selecting a lower priority swap device
while traversing the list, even when a higher priority swap device gets
inserted into the plist.

So anyway as I think... 

- On the read side (alloc_swap_entry), manage it so only one swap
  device can be obtained when selecting a swap device. (grabbing
  read_lock). swap selection logic does not any behavior affecting
  logic change like current approach. just see swapdevice only.

- On the write side, handle it appropriately using plist or some
  improved data structure. (grabbing write_lock)

- For rotation, instead of placing a plist per swap device, we could
  create something like a priority node. In this priority node
  structure, entries would be rotated each time a cluster is fully used.

- Also, with tiers introduced, since we only need to traverse the
  selected tier for each I/O, the current single swap_avail_list may
  not be suitable anymore. This could be changed to a per-tier
  structure.


Thanks,
YoungJun 

