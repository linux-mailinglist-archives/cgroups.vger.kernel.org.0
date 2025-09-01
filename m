Return-Path: <cgroups+bounces-9576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7420B3EBD4
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 18:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7747517FE6C
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF152DF122;
	Mon,  1 Sep 2025 16:03:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049932F772
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742629; cv=none; b=ffr1ESUf6T78EHYHTx6HOdvkeFCJuSwABF42Iyhvoa4RVlaWRIfDMmsCrdO61E4rilWQPo9nZqSom8uddJFF8+jlMicMYVZytnrHiggBSNZL7UDK04QAYzo/JPycxB6xdD6SGZzNElf4uVUnNXF3Cv/w4sPorwlMJ5+2zNb6ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742629; c=relaxed/simple;
	bh=AFqHdAfodD4+2yf9u1F2Rp3YBD/K6FRojrAd0mlDvNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrwMRRGsESL9qopfFtxhGHA+8vyfwPYh7JZotvucfIXdq+OC2kmdtvp9P0DMfukXFRb99pQC0GuExWUJ/fpHQfoDjEEK71ArhJVtHJjYNEt97jUVocAI2zHd4sirKADvbwE1JxdCLDydkJLtFYiYXjhNVrlBFKNV3CyHRjClDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 2 Sep 2025 01:03:38 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 2 Sep 2025 01:03:38 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aLXD2mvx47i1e18k@yjaykim-PowerEdge-T330>
References: <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
 <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
 <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
 <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
 <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>

Overall, the alignment looks good. Among the three points you suggested,
I agree with (3) cgroup inheritance. I would like to continue the
discussion on (1) swap tier lifecycle and (2) allocation logic.

1. swap tier lifecycle
2. allocation logic
3. cgroup inheritance

> > This part relates to my earlier point on runtime modification. My
> > intention was to only allow setting the tiers globally, and to align
> > bitmask with priority ranges. For example, an input like:
> >
> >   ssd:100, hdd:50, network_swap
> >
> > would translate into ranges as 100+ (bit0), 50–99 (bit1), and 0–49
> > (bit2).
> >
> > From your description, I understand you are considering allowing
> > additive updates, insertions and letting bitmask differ from the range priority. Is
> > that correct? In that case we probably need a way to distinguish
>
> That is right.

Yes, I agree that add/remove semantics can be supported,
But it was not fully clear whether there was agreement on the full set
format, I wanted to state explicitly that my preference is to require
the full set format for simplicity. That said, if staged insertion and
removal are considered useful, one possible approach is:

(side note! explanation of the interface was somewhat
descriptive, which may not have been fully clear. If this explanation is
sufficient to establish the general direction, I will aim to present it
more concretely in the patch series. Otherwise, I can provide a more
detailed explanation in a follow-up email.)

  echo "add ssd:100,hdd:50,network_swap" >/sys/kernel/mm/swap/tiers
  echo "add new:80"  > /sys/kernel/mm/swap/tiers
  echo "remove hdd" > /sys/kernel/mm/swap/tiers

Alternatively, separate files for add, remove, and show could be used to
represent staged operations:

  echo "ssd:100,hdd:50,network_swap" >/sys/kernel/mm/swap/tiers/add
  echo "new:80"  > /sys/kernel/mm/swap/tiers/add
  echo "hdd" > /sys/kernel/mm/swap/tiers/remove

When using the fullset approach:

  ssd:100(bit0), hdd:50(bit1), network_device(bit2)

If we remove the ssd layer and add a new tier:

  echo new:80,hdd:50,network_device >/sys/kernel/mm/swap/tiers

The show output could display staged state (imaginary output for understanding):

  ssd:100(bit0), new:80(bit3, in stage), hdd:50(bit1, removing), network_device(bit2)

After the hdd tier reference drops to zero:

  ssd:100(bit0), new:80(bit3),  network_device(bit2)

> > between “add” and “reset”. Personally, I feel supporting only reset
> > semantics would make the interface simpler, while still allowing add
> > semantics when the full set is provided again.
>
> The counterpart of "add" is "remove". There are two possible ideas to explore:
> 1) only allow removing a tier when all swap devices in that tier
> range have been swapped off.
> 2) Remove the tier by removing a midpoint from the range. The lower
> tier automatically gets the range belonging to the tier that was
> removed. Optionally, you can add another tier back in replacement
> with different range boundaries. This effectively achieves replacement
> as well. This approach does not require swapping off the swap device. I
> like it better. If you want to avoid the race window where the
> swap device temporarily belongs to the lower tier, you can always swap
> off the device before performing 2). So 2) can be mixed with 1) as well.

I have already explained this from the perspective of option 2 mixed
with option 1. Let me clarify one point:

If...
ssd:100, hdd:50, network_device.
Insertion above 100 becomes visible after ssd removal,
Insertion above 50 becomes visible after hdd removal,
Insertion above 0 becomes visible after network_device removal.

It means that as long as the tier exists, the referenced priority ranges
cannot be overridden.

And Regarding swap_tier object lifecycle:

A swap_tier should not be deleted until all devices in the tier are
swapped off (As you said, references are held). Therefore, cgroups that reference a
tier should also hold a reference. Silently dropping a tier is problematic
from a cgroup perspective.

If we allow this, the implementation should behave as follows as I think:
If a swap_tier is removed, the cgroup’s tier configuration could be
marked invalid. This should trigger an event to the cgroup to notify
user space.

> >
> > > > 2. Slow path allocation uses bitmask skipping; fast path uses per-cpu
> > > >    tier cluster caches.
> > > If the fast path fails, it will go through the slow path. So the slow
> > > patch is actually a catch all.
> >
> > Do you mean that if the cluster does not belong to the desired tier in
> > the fast path, it will skip and then fall back to the slow path? If so,
>
> I am describing the existing swap cluster allocator behavior. In my
> mind, we are using the existing cluster swap allocator code, with
> constraints that only allow swap entry to be allocated from the
> affected tier bitmask.
>
> > the slow path would need to avoid inserting the cluster back into the
> > cache, otherwise processes with a global swap view may end up using the
> > wrong tier device(which must be referenced firstly assumed)
> > Also cgroup which is tier set experience performance degradation
> > because, there is possibility to try to alloc swap on slowpath most of the time.
> > Wouldn’t this have performance implications?
>
> I think we are mixing two different concepts. There are swap tiers
> which decide which swap device to use. Then there is the swap
> allocator to allocate a swap from the allowed list.
>
> If we move to the swap tiers, the swap allocator needs to be swap
> tiers aware. So it might move to per-cgroup cache list or disable the
> cache for cgroups that haven't been allocating for a while. The
> allocation logic should be in the allocator, not in the swap tier
> layer.
>
> > I was thinking that maintaining per-tier per-cpu cluster caches would be
> > simpler. Then each tier manages its own cluster cache, and we only need
> > an array of per-cpu caches of size “max tiers”.
>
> Again, let's not jump to premature optimizations. Do it the simple way
> first, then let the measurement numbers guide us.
> It might be per swap file has a cache not necessary per CPU. per-cpu x
> per-tier the combination is too big, I am worried about caching too
> much swap clusters. Each cluster is 2M.

You suggested maintaining per-swap-device cluster caches. As an
alternative, I would like to suggest a per-device per-CPU cache
approach, which could be simpler from an integration perspective. It
would fit more naturally with the existing allocation logic, remove tier
awareness from the allocator, and should not introduce functional
differences in behavior. Moreover, since SSD devices are likely to be
concentrated in only a small number of tiers (with one being the "best"
tier), the number of clusters actually cached at any time would not be
large. I am not presenting this as the ultimate solution, but rather as
a simple and reasonably practical approach to consider. I agree that we
should revisit and evaluate this approach further.

> We DO want some parent level control. That is a real customer
> requirement. The cons with your proposal is that, if you want to
> change the whole set from top-level cgroup to child cgroups, you need
> to traverse the hierarchical chain to set each child cgroup. While
> walking the child tree, more sub-level cgroups may be added, and
> you could miss newly created cgroups. It becomes a mess.
>
> It is much cleaner if we allow the child cgroup to have the default
> "swap.tiers" empty. Then you just need to set one value at the top-level
> parent cgroup, and all child cgroups inherit it automatically. A child
> can overwrite it if desired; by default it inherits from its parent.
>
> The whole set of cgroups from top-level including children can map
> into a Kubernetes pod. It is common to perform adjustments on the
> whole set atomically. We should support it.

Okay I will adopt default inheritance for pod-level and similar use cases. A
child cgroup inherits the nearest ancestor’s mask upon creation. If it
later sets its own mask, that configuration will apply to itself.

> I think we are aligned.
>
> Thanks
>
> Chris

Many thanks for the detailed review. It helped clarify the implementation
direction, and I look forward to preparing the patch series accordingly.

Youngjun Park

