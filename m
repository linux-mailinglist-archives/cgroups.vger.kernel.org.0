Return-Path: <cgroups+bounces-9508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1BB3C7BE
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C015E585D
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87A275847;
	Sat, 30 Aug 2025 04:05:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B03274B29
	for <cgroups@vger.kernel.org>; Sat, 30 Aug 2025 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526727; cv=none; b=uIYW1LlH8ys9J8KMP1ENDgwKrCNNmO4RVhITYs6CnNq3Xsp8s1KKLkyfi90C3Oj/sNFEoXwrDjiguMH4SW89cpYFeZ4XB/kPa183s56R3erGDJE1sD9MNPcBJuXOEBOCp5PANh2qb5rHmLl8KWCYKkvnYZz8f3VIBh7FxCowRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526727; c=relaxed/simple;
	bh=aw3+fIVL9jzi4PiHU70Olj4DbGA8xCVqHe/xoTSEL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqGJEDgXYEfiBkJDN8k9fxLzkPMK+phJxVkhberyWRMRxv6ngNEv/Th6c3oY/YzWs2BloXwN3vva7PxKvioIm/egE15xJmaBOIWpgdnVLH7BCmfdxTcl6U5EGTU+FimgSLLbR3LCP02kg1fk17ly55K3+Gc1rIhoyvK0IPZDlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 30 Aug 2025 13:05:16 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 30 Aug 2025 13:05:16 +0900
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
Message-ID: <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
References: <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
 <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
 <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
 <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
 <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
 <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>

Hi Chris,

Thanks for the detailed feedback, and sorry for the late reply.

> I think you touch on a very important question that might trigger a
> big design change. Do we want to have a per tier swap.max? It will
> specify not only whether this cgroup will enroll into this tier or
> not. It also controls how much swap it allows to do in this cgroup.
> The swap.max will follow the straight contain relationship. I would
> need to think more about the relationship between swap.max and
> swap.tiers. Initial intuition is that, we might end up with both per
> tier swap.max, which control resource limit, it has subset contain
> relationship. At the same time the swap.tiers which control QoS, it
> does not follow the subset contained.
>
> Need more sleep on that.

When I first ideated on this, I also considered per-device max values,
with 0 meaning exclusion, to implement cases like a cgroup using only
network swap. At that time the idea was to give each device its own
counter, so setting it to 0 would imply exclusion. But this approach
would effectively require maintaining per-device page counters similar
to the existing swap.max implementation, and the relationship between
these per-device counters and the global swap.max would need to be
carefully defined. That made the design significantly heavier than the
functionality I was aiming for, so I decided to drop it. I read your
point more as a QoS extension, and I see it as complementary rather
than a counter argument.

> First of all, sorry about the pedantic, it should be "swap.tiers" just
> to be consistent with the rest of the discussion.
> Secondly, I just view names as an alias of the number. 1-3 is hard to
> read what you want.
> If we allow name as the alias, we can also do:
> echo zram-hdd > memory.swap.tieres
>
> It is exactly the same thing but much more readable.
>
> >    cg1/cg2: 2-4,6  > memory.swap.tie (ssd,hdd,network device, somedevice 2, assuming non-subset is allowed)
>
> echo ssd-network_device,some_device2 > memory.swap.tiers
>
> See, same thing but much more readable what is your intention.
>
> BTW, we should disallow space in tier names.

Ack—those spaces were only in my example; the implementation will reject
spaces in tier names.

I like the interface format you proposed, and I’ll move forward with an
initial implementation using the name-based tier approach, dropping
the numeric format.

> We do want to think about swap.tiers vs per tier swap.max. One idea
> just brainstorming is that we can have an array of
> "swap.<tiername>.max".
> It is likely we need to have both kinds of interface. Because
> "swap.<tiername>.max" specifies the inclusive child limit.
> "swap.tiers" specifies this C group swap usage QoS. I might not use
> hdd in this cgroup A, but the child cgroup B does. So A's hdd max
> can't be zero.
>
> The other idea is to specify a percentage for each tier of the
> swap.max in "swap.tiers.max": zram:30  sdd:70
> That means zram max is "swap.max * 30%"   and ssd max is "swap.max *
> 70%". The number does not need to add up to 100, but can't be bigger
> than 100.
> The sum can be bigger than 100.
>
> Need more sleep on it.

I don’t have additional ideas beyond what you suggested at now. Since swap.max
is defined in terms of quantity, my intuition is that tier.max should
probably also be quantity-based, not percentage. As I mentioned earlier,
I had also considered per-device max in the early RFC stage. The design
was to introduce per-device counters, but that added substantial overhead
and complexity, especially in reconciling them with the global swap.max
semantics. For that reason I abandoned the idea, though I agree your
suggestion makes sense in the context of QoS extension.

At this point I feel the main directions are aligned, so I’ll proceed
with an initial patch version. My current summary is:

1. Global interface to group swap priority ranges into tiers by name
   (/sys/kernel/mm/swap/swaptier).
2. Slow path allocation uses bitmask skipping; fast path uses per-cpu
   tier cluster caches.
3. Cgroup interface format modeled after cpuset.
4. No inheritance between parent and child cgroup as a perspective of QoS
5. Runtime modification of tier settings allowed.
6. Keep extensibility and broader use cases in mind.

And some open points for further thought:

1. NUMA autobind
   - Forbid tier if NUMA priorities exist, and vice versa?
   - Should we create a dedicated NUMA tier?
   - Other options?
2. swap.tier.max
   - percentage vs quantity, and clear use cases.
  -  sketch concrete real-world scenarios to clarify usage 
3. Possible future extensions to VMA-based tier usage.
4. Arbitrary ordering
   - Do we really need it?
   - If so, maybe provide a separate cgroup interface to reorder tiers.

Best Regards
Youngjun Park

