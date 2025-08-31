Return-Path: <cgroups+bounces-9517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7AB3D3C1
	for <lists+cgroups@lfdr.de>; Sun, 31 Aug 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59AE7A04B4
	for <lists+cgroups@lfdr.de>; Sun, 31 Aug 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0277255F53;
	Sun, 31 Aug 2025 13:53:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93665145355
	for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756648404; cv=none; b=sXeOEVuam2vIggwumwnuA3EomKY3KujLc/+mZX+meAptwUiONiBKkN1clFEw++dRS12pHujv66WC3YSlFiDgBNBEhc+KY86gDKY1rSBOQJlfP0jY7eX/O6riKL8CcNCopMXzrfyc98YCeW1KnaoNg8ArMpqoxDJIjqlHJs9KQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756648404; c=relaxed/simple;
	bh=+RG6DDnZ/mMFXGijrhOIbN90D4JB2j+2YhYxyUAd/qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzmIc0T8lWz9DZPf1S47z9fBu03beczOtLwFfJ6fVZMynPizNgpGUD0+2B9LmjXc0DePBHZhd0d1SRSDYLZmpt7FV2L6t84q8S/NFGZSKcK6mdA2vzZ/00BwoQGLFCsRHqBhgzZOMmhMy6b7sY/c14wOO19DaHeu4m4ShB3OxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 31 Aug 2025 22:53:13 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 31 Aug 2025 22:53:13 +0900
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
Message-ID: <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
References: <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
 <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
 <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
 <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
 <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>

> Yes, I slept on it for a few days. I reached a similar conclusion.
> I am happy to share my thoughts:
> 1) FACT: We don't have any support to move data from swap device to
> another swap device nowadays. It will not happen overnight. Talking
> about those percentage allocation and maintaining those percentages is
> super complicated. I question myself getting ahead of myself on this
> feature.
> 2) FACT: I don't know if any real customers want this kind of
> sub-cgroup swap per tier max adjustment. We should write imaginary
> code for imaginary customers and reserve the real coding for the real
> world customers. Most of the customers I know, including our company,
> care most about the top level CGroup swap assignment. There are cases
> that enable/disable per sub CGroup swap device, in the QoS sense not
> the swap max usage sense.
> I think this will be one good question to ask feedback in the LPC MC
> discussion.

Great—looking forward to it at the LPC MC.

> > At this point I feel the main directions are aligned, so I’ll proceed
> > with an initial patch version. My current summary is:
> >
> > 1. Global interface to group swap priority ranges into tiers by name
> >    (/sys/kernel/mm/swap/swaptier).
> I suggest "/sys/kernel/mm/swap/tiers" just to make the file name look

Yes, I also think "/sys/kernel/mm/swap/tiers" is a better fit.

> different from the "swap.tiers" in the cgroup interface.
> This former defines all tiers, giving tiers a name and range. The
> latter enroll a subset of the tiers.
>  I think the tier bit location does not have to follow the priority
> order. If we allow adding a new tier, the new tier will get the next
> higher bit. But the priority it split can insert into the middle thus
> splitting an existing tier range. We do need to expose the tier bits
> into the user space. Because for madvise()  to set tiers for VMA, it
> will use bitmasks. It needs to know the name of the bitmask mapping,
> I was thinking the mm/swap/tiers read back as one tier a line. show:
> name, bitmask bit, range low, range high

This part relates to my earlier point on runtime modification. My
intention was to only allow setting the tiers globally, and to align
bitmask with priority ranges. For example, an input like:

  ssd:100, hdd:50, network_swap

would translate into ranges as 100+ (bit0), 50–99 (bit1), and 0–49
(bit2).

From your description, I understand you are considering allowing
additive updates, insertions and letting bitmask differ from the range priority. Is
that correct? In that case we probably need a way to distinguish
between “add” and “reset”. Personally, I feel supporting only reset
semantics would make the interface simpler, while still allowing add
semantics when the full set is provided again.

> > 2. Slow path allocation uses bitmask skipping; fast path uses per-cpu
> >    tier cluster caches.
> If the fast path fails, it will go through the slow path. So the slow
> patch is actually a catch all.

Do you mean that if the cluster does not belong to the desired tier in
the fast path, it will skip and then fall back to the slow path? If so,
the slow path would need to avoid inserting the cluster back into the
cache, otherwise processes with a global swap view may end up using the
wrong tier device(which must be referenced firstly assumed)
Also cgroup which is tier set experience performance degradation 
because, there is possibility to try to alloc swap on slowpath most of the time.
Wouldn’t this have performance implications?  

I was thinking that maintaining per-tier per-cpu cluster caches would be
simpler. Then each tier manages its own cluster cache, and we only need
an array of per-cpu caches of size “max tiers”.

> > 3. Cgroup interface format modeled after cpuset.
> I am not very familiar with the cpuset part of the interface. Maybe
> you should explain that to the reader without using cpuset cgroup as a
> reference.

The similarity with cpuset is only in the text format. Like cpuset.cpus
uses a comma-separated list and dash ranges (e.g. "0-4,6,8-10"), the
swap tier interface would use the same style but with tier names. For
example:
  echo ssd-network_device,some_device2 > swap.tiers
This makes it easy for users to read and modify at runtime, and keeps
the interface consistent with existing cgroup controls.
(Reference: https://docs.kernel.org/admin-guide/cgroup-v2.html, Cpuset Interface Files)

> > 4. No inheritance between parent and child cgroup as a perspective of QoS
> In my original proposal of "swap.tiers", if the default is not set on
> this tier, it will look up the parent until the root memcg. ...

My current thought is that it might be simpler to avoid inheritance
entirely. Since this is a QoS interface rather than a resource limit
mechanism, inheritance semantics may not be the best fit. I would prefer
to always override based on what is explicitly set, and otherwise fall
back to global swap. For example, input like:

  swap.tiers = ssd,network_device,some_device2

would always override the setting directly, without any parent lookup.

> > 5. Runtime modification of tier settings allowed.
> Need to clarify which tier setting? "swap.tiers" or /sys/kernel/mm/swap/tiers?

My earlier comment was about allowing runtime modifications
to the global /sys/kernel/mm/swap/tiers.

> > 6. Keep extensibility and broader use cases in mind.
> >
> > And some open points for further thought:
> >
> > 1. NUMA autobind
> >    - Forbid tier if NUMA priorities exist, and vice versa?
> >    - Should we create a dedicated NUMA tier?
> >    - Other options?
>
> I want to verify and remove the NUMA autobind from swap later. That
> will make things simpler for swap. I think the reason the NUMA swap
> was introduced does not exist any more.

Per your suggestion, the question of whether NUMA autobind 
is needed can be addressed in a dedicated discussion later. 
I look forward to it. :)

The NUMA autobind removal work.. possible directions could be:
  
  - runtime toggle (default off),  
  - keep default on but gradually flip to default off,  
    eventually remove entirely.
  - remove it. entirely.

Not a proposal —just a thought 

In my current patch,
tier and NUMA priorities are made mutually exclusive so they cannot be set together. 

> > 2. swap.tier.max
> >    - percentage vs quantity, and clear use cases.
> >   -  sketch concrete real-world scenarios to clarify usage
>
> Just don't do that. Ignore until there is a real usage case request.

Agreed. It is better to defer until we see a concrete use case.

> > 4. Arbitrary ordering
> >    - Do we really need it?
> >    - If so, maybe provide a separate cgroup interface to reorder tiers.
>
> No for now. Need to answer how to deal with swap entry LRU order
> inversion issue.

Right, if we want to support this usage, your point about LRU order must
definitely be addressed first.

Best Regards
Youngjun Park

