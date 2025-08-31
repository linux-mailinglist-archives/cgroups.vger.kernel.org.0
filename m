Return-Path: <cgroups+bounces-9518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC543B3D46B
	for <lists+cgroups@lfdr.de>; Sun, 31 Aug 2025 18:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC93BD8E6
	for <lists+cgroups@lfdr.de>; Sun, 31 Aug 2025 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47A255F2D;
	Sun, 31 Aug 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAyZl3XN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA8469D
	for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658749; cv=none; b=Fi5D1lL7rGNHZEyEe4B4h4Lg9pz2YfTNcJcu4r043PTOo+BtTvj3XOvaLuTZLh0FC8dUgXnpR06F796AXHu6sxq2Nwdsm6oaOjaNVQKc7z8Z7WwMJ9ddx+Ed7qh8cOAMnAWmHbafyvQdH3H/oj9imK4r1ocG407fv8Gwnwp/wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658749; c=relaxed/simple;
	bh=Ia+NcoXFFp3Rc17X/ZrTRBLMS8MC0woErKY7A01sbIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSbAIaDvwPCmciGIVqlRpI4KGG57dz8ZEUNQfNAftcqpUtzZYz8o2K2PtXEowlUAwrZ33F6WtGpQZWaJM2Srw4wuXYjBQ2elFpur/r5x/RfNvSXy8eHzZnW9/YNbRNS2sVgHIvnoIqBdAqhykXxD0TS4oleUvA7Kx3rGbasOFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAyZl3XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3501C4CEF4
	for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756658748;
	bh=Ia+NcoXFFp3Rc17X/ZrTRBLMS8MC0woErKY7A01sbIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aAyZl3XNcMqm+IkNAqkqh6MeveKAN5pGmidutv9lrweXc4+N+sapZ2v/yuGj46LW0
	 JkiJN0ZQNKGFVy+fK6dxwwmqaDAL8EDmLpkVmsuOBK+0fShrvjAUXjUXLsgn1tGdAt
	 XoZ3e6xbtIvGKmsH3rzOSJUCOePU6Y5faxHeRKFQM5lQyi3kjTQCWjKKjXSHe9FBQm
	 qrwcRSM61YVnmfPDuw1M4bPg0ZG09ypwQ3tMNvLwCVisvaYpqwawHN21AwJrugj1k6
	 otDvejGZGonmbTTQa4gCiAa201QjbeK526XiUGnZS2d7d2qH2rlBd0wAxhxS24QYJX
	 4t+44FE564jYA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71ff2b20039so32957547b3.3
        for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 09:45:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+MiZVydRW4TtawIKy7sf0gi0gPFyaEP4BG0qVzrwuA/dH4fzuivI9sDYYL5Zy0X8gV/0G5Rfe@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyrVQPZADMSRo1Ws/QywwM8JmI3Y3l5X88sGU4eU966qX3R8H
	gr9BsBELHUENbzvA4lhmO39qRz8AUQ/9c2RWWrGwmvQFf3op8jwvgHPjHwma47PtvP9RlsF0zBz
	0wvcrQU94c/syJIixl9QiKJjQqHI43Cl6jP/ebhYK2A==
X-Google-Smtp-Source: AGHT+IHA0dzOWBSMCR6hNyYZK2bqnpmasmQvgM5hHiHfnQD9K8zKcb35aDvOColV6PdQxuy41cvC3OrOS+7a8UeUeHY=
X-Received: by 2002:a05:690c:64c7:b0:71f:f049:340a with SMTP id
 00721157ae682-72276332d6emr61640757b3.1.1756658747908; Sun, 31 Aug 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330> <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
In-Reply-To: <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 31 Aug 2025 09:45:36 -0700
X-Gmail-Original-Message-ID: <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
X-Gm-Features: Ac12FXz0mIIdH1Z1YFPJdDME5qvEoyzFFsKi8o5raJAjx3V5raHA5OX-7s2zxbs
Message-ID: <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: YoungJun Park <youngjun.park@lge.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 6:53=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
> > I think this will be one good question to ask feedback in the LPC MC
> > discussion.
>
> Great=E2=80=94looking forward to it at the LPC MC.

Ack

>
> > > At this point I feel the main directions are aligned, so I=E2=80=99ll=
 proceed
> > > with an initial patch version. My current summary is:
> > >
> > > 1. Global interface to group swap priority ranges into tiers by name
> > >    (/sys/kernel/mm/swap/swaptier).
> > I suggest "/sys/kernel/mm/swap/tiers" just to make the file name look
>
> Yes, I also think "/sys/kernel/mm/swap/tiers" is a better fit.
>
> > different from the "swap.tiers" in the cgroup interface.
> > This former defines all tiers, giving tiers a name and range. The
> > latter enroll a subset of the tiers.
> >  I think the tier bit location does not have to follow the priority
> > order. If we allow adding a new tier, the new tier will get the next
> > higher bit. But the priority it split can insert into the middle thus
> > splitting an existing tier range. We do need to expose the tier bits
> > into the user space. Because for madvise()  to set tiers for VMA, it
> > will use bitmasks. It needs to know the name of the bitmask mapping,
> > I was thinking the mm/swap/tiers read back as one tier a line. show:
> > name, bitmask bit, range low, range high
>
> This part relates to my earlier point on runtime modification. My
> intention was to only allow setting the tiers globally, and to align
> bitmask with priority ranges. For example, an input like:
>
>   ssd:100, hdd:50, network_swap
>
> would translate into ranges as 100+ (bit0), 50=E2=80=9399 (bit1), and 0=
=E2=80=9349
> (bit2).
>
> From your description, I understand you are considering allowing
> additive updates, insertions and letting bitmask differ from the range pr=
iority. Is
> that correct? In that case we probably need a way to distinguish

That is right.

> between =E2=80=9Cadd=E2=80=9D and =E2=80=9Creset=E2=80=9D. Personally, I =
feel supporting only reset
> semantics would make the interface simpler, while still allowing add
> semantics when the full set is provided again.

The counterpart of "add" is "remove". There are two possible idea to explor=
e:
1) only allow removing  a tier when all swap devices in that tier
range have been swapped off.
2) Remove the tier is removing a midpoint from the range. So the lower
tier automatically gets the range belonging to the tier that was
removed. Then optionally you can add another tier back in replacement
with different range boundaries. It effectively achieves replacement
as well. This approach does not require swap off the swap device. I
like it better. Because if you don't want the race window where the
swap device temporarily belongs to the lower tier, you can always swap
off the device in question before performing 2). so 2) can actually be
mixed with 1) as well.

>
> > > 2. Slow path allocation uses bitmask skipping; fast path uses per-cpu
> > >    tier cluster caches.
> > If the fast path fails, it will go through the slow path. So the slow
> > patch is actually a catch all.
>
> Do you mean that if the cluster does not belong to the desired tier in
> the fast path, it will skip and then fall back to the slow path? If so,

I am describing the existing swap cluster allocator behavior. In my
mind, we are using the existing cluster swap allocator code, with
constraints that only allow swap entry to be allocated from the
affected tier bitmask.

> the slow path would need to avoid inserting the cluster back into the
> cache, otherwise processes with a global swap view may end up using the
> wrong tier device(which must be referenced firstly assumed)
> Also cgroup which is tier set experience performance degradation
> because, there is possibility to try to alloc swap on slowpath most of th=
e time.
> Wouldn=E2=80=99t this have performance implications?

I think we are mixing two different concepts. There are swap tiers
which decide which swap device to use. Then there is the swap
allocator to allocate a swap from the allowed list.

If we move to the swap tiers, the swap allocator needs to be swap
tiers aware. So it might move to per cgroup cache list or disable the
cache for the cgroup that hasn't been allocating for a while. The
allocation logic should be in the allocator, not in the swap tier
layer.

> I was thinking that maintaining per-tier per-cpu cluster caches would be
> simpler. Then each tier manages its own cluster cache, and we only need
> an array of per-cpu caches of size =E2=80=9Cmax tiers=E2=80=9D.

Again, let's not jump to premature optimizations. Do it the simple way
first, then let the measurement number guide us.
It might be per swap file has a cache not necessary per CPU. per-cpu x
per-tier the combination is too big, I am worried about caching too
much swap clusters. Each cluster is 2M.

>
> > > 3. Cgroup interface format modeled after cpuset.
> > I am not very familiar with the cpuset part of the interface. Maybe
> > you should explain that to the reader without using cpuset cgroup as a
> > reference.
>
> The similarity with cpuset is only in the text format. Like cpuset.cpus
> uses a comma-separated list and dash ranges (e.g. "0-4,6,8-10"), the
> swap tier interface would use the same style but with tier names. For
> example:
>   echo ssd-network_device,some_device2 > swap.tiers
> This makes it easy for users to read and modify at runtime, and keeps
> the interface consistent with existing cgroup controls.
> (Reference: https://docs.kernel.org/admin-guide/cgroup-v2.html, Cpuset In=
terface Files)

Thanks for the explanation. That sounds fine to me.

>
> > > 4. No inheritance between parent and child cgroup as a perspective of=
 QoS
> > In my original proposal of "swap.tiers", if the default is not set on
> > this tier, it will look up the parent until the root memcg. ...
>
> My current thought is that it might be simpler to avoid inheritance
> entirely. Since this is a QoS interface rather than a resource limit
> mechanism, inheritance semantics may not be the best fit. I would prefer
> to always override based on what is explicitly set, and otherwise fall
> back to global swap. For example, input like:
>
>   swap.tiers =3D ssd,network_device,some_device2
>
> would always override the setting directly, without any parent lookup.

We DO want some parent level control. That is a real customer
requirement. The cons with your proposal is that, if you want to
change the whole set from top level cgroup to child cgroup, you need
to talk the hieratical chain to set each of the child cgroup. While
you are walking the child tree, there are races with more sub level
cgroup added to the tree. You will end up missing the newly created
cgroup. It is a mess.

It is much cleaner if we can allow the child cgroup to have the
default "swap.tiers" to be empty. Then you just need to set one value
to the top level parent cgroup and all child cgroup get it without
exception. The child can overwrite it if they want, default is getting
it from the parents.

The whole set of cgroup from top level including child can map into a
k8s pod. It is common to perform adjustments on the whole set
atomically. We should support it.

> > > 5. Runtime modification of tier settings allowed.
> > Need to clarify which tier setting? "swap.tiers" or /sys/kernel/mm/swap=
/tiers?
>
> My earlier comment was about allowing runtime modifications
> to the global /sys/kernel/mm/swap/tiers.

Ack.

> > > 6. Keep extensibility and broader use cases in mind.
> > >
> > > And some open points for further thought:
> > >
> > > 1. NUMA autobind
> > >    - Forbid tier if NUMA priorities exist, and vice versa?
> > >    - Should we create a dedicated NUMA tier?
> > >    - Other options?
> >
> > I want to verify and remove the NUMA autobind from swap later. That
> > will make things simpler for swap. I think the reason the NUMA swap
> > was introduced does not exist any more.
>
> Per your suggestion, the question of whether NUMA autobind
> is needed can be addressed in a dedicated discussion later.
> I look forward to it. :)

I was thinking of removing the NUMA autobind feature from the Linux
source code. Deleting codes, if the measurement number shows the NUMA
autobind does not make much of a difference any more. The performance
charistic have changed dramatically with the new cluster based swap
allocator. It is possible NUMA autobind does not make sense to justify
the complexity to exist in the source code.

> The NUMA autobind removal work.. possible directions could be:
>
>   - runtime toggle (default off),
>   - keep default on but gradually flip to default off,
>     eventually remove entirely.
>   - remove it. entirely.
>
> Not a proposal =E2=80=94just a thought
>
> In my current patch,
> tier and NUMA priorities are made mutually exclusive so they cannot be se=
t together.

That is one more reason to remove NUMA priorities completely.

> > > 2. swap.tier.max
> > >    - percentage vs quantity, and clear use cases.
> > >   -  sketch concrete real-world scenarios to clarify usage
> >
> > Just don't do that. Ignore until there is a real usage case request.
>
> Agreed. It is better to defer until we see a concrete use case.

Ack.

> > > 4. Arbitrary ordering
> > >    - Do we really need it?
> > >    - If so, maybe provide a separate cgroup interface to reorder tier=
s.
> >
> > No for now. Need to answer how to deal with swap entry LRU order
> > inversion issue.
>
> Right, if we want to support this usage, your point about LRU order must
> definitely be addressed first.

Ack.

I think we are aligned.

Thanks

Chris

