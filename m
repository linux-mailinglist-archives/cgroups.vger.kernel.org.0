Return-Path: <cgroups+bounces-9514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1EEB3C89E
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 09:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906FBA22926
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 07:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CE241CA2;
	Sat, 30 Aug 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCssmDBy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B01400E
	for <cgroups@vger.kernel.org>; Sat, 30 Aug 2025 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756538006; cv=none; b=ZIUMKJnaK69lPu/rkDx7fZrsnkbvrjjxdbBhCwU64yZ46cnUSEXB3P9KemOylEH0ZqqEpTuE/DdrI3S2LEE9FR/PQ8ETARsM9QFuuDG8t+1YO/ebMKIfk9zEIV3pOI4v57eRe3Nqmz4R9V3UhV7CecXesF0fubkW5Ns6e3vxBDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756538006; c=relaxed/simple;
	bh=Rto1SfeQEwgVt2SXLt12f5WUHdKs23dkql68LsRgmQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc5eTusZ8s5mTCbxzgkYpuas2H6Cb/t/P3lb0M7Hi5AmAfiIVnQUskqjyQudg+rW6RPFkjr7qseMSXNSzidhG6kDtGSdlWbGbvGz0JwziLEm6o+vYq71QDqYEMXw03yV/dulFvK9/2KgZItNbHFE1Mt/PCiO94UVGm12iTXVtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCssmDBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB68C113D0
	for <cgroups@vger.kernel.org>; Sat, 30 Aug 2025 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756538005;
	bh=Rto1SfeQEwgVt2SXLt12f5WUHdKs23dkql68LsRgmQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PCssmDByNzziFHYhKRiiCjNGOyrBPXf9exjjb9nOpw7sEM1XxsPYqe2ELIoa/ycdC
	 uzoQ+3Pqe2l3K8/U0kX99qRVlc8Wwc3jzTBfGjCbYvwP48fTFujep1mdWW4XqJVMoS
	 L2+rYXCVEm/whDl8+YS2FHo0U+KI/5DYypEQnLgMNqNvTSwtjxzTu2tC0oxYIYuDTn
	 hFqFKeO+w6dXjU+aqMW8xHTUO65MeoZXQokb1NzkQsyuHTzxMta8AvIA8ZiQZgF7q+
	 +l9Hdi5tlo1XGj3/4kjKo2w2DfZ/1S/CaO57ffbhf/rBOhL2UFMOVkq4K9dXSbduLr
	 zGgp7CP5biGPg==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e970acf352fso2223845276.2
        for <cgroups@vger.kernel.org>; Sat, 30 Aug 2025 00:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/3tK/lHFy0DmGoIrWxuTlTUEQJdmLbR4yAbH6cugVZDNdbBilcXdZNInv8Jj0FJtGhqpZ/8kC@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzacSRvL2qQG8/DcGzB8WYEA++mHrT2vmPOC0D/kZjSXrIw3x
	xKgkFS/LiQ6WozwPHSPzDMjEUaca3oLbA5SiH36u1oWfgpa8ULYg71GP9QJBMd4MBGgiECWPzAI
	Xn+qeorSvtH8ySd5bVvlOnNI4VYRQXiYaQreoRTwk0A==
X-Google-Smtp-Source: AGHT+IEG4klphVqOjGx2D2qSDQ8Jl+i3TnCO4eJoe/IuFDAp9yWinCMp/GZHxiz+Cs0fFle255dbNjX8FpV9wu091ss=
X-Received: by 2002:a05:690c:6d8c:b0:722:6a6c:c010 with SMTP id
 00721157ae682-7227633350bmr10948847b3.8.1756538004516; Sat, 30 Aug 2025
 00:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330> <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330> <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
In-Reply-To: <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 30 Aug 2025 00:13:13 -0700
X-Gmail-Original-Message-ID: <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
X-Gm-Features: Ac12FXxYEdJMuFqqZYUQ2uhThBTcF8N9Rr1U8aKLwfnioxQ3gBLtkH906rYqcwI
Message-ID: <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
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

On Fri, Aug 29, 2025 at 9:05=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> Hi Chris,
>
> Thanks for the detailed feedback, and sorry for the late reply.

Not a problem at all. I have been pretty busy this week and don't have
much time for it either.

> > I think you touch on a very important question that might trigger a
> > big design change. Do we want to have a per tier swap.max? It will
> > specify not only whether this cgroup will enroll into this tier or
> > not. It also controls how much swap it allows to do in this cgroup.
> > The swap.max will follow the straight contain relationship. I would
> > need to think more about the relationship between swap.max and
> > swap.tiers. Initial intuition is that, we might end up with both per
> > tier swap.max, which control resource limit, it has subset contain
> > relationship. At the same time the swap.tiers which control QoS, it
> > does not follow the subset contained.
> >
> > Need more sleep on that.
>
> When I first ideated on this, I also considered per-device max values,
> with 0 meaning exclusion, to implement cases like a cgroup using only
> network swap. At that time the idea was to give each device its own
> counter, so setting it to 0 would imply exclusion. But this approach
> would effectively require maintaining per-device page counters similar
> to the existing swap.max implementation, and the relationship between
> these per-device counters and the global swap.max would need to be
> carefully defined. That made the design significantly heavier than the
> functionality I was aiming for, so I decided to drop it. I read your
> point more as a QoS extension, and I see it as complementary rather
> than a counter argument.

Yes, I slept on it for a few days. I reached a similar conclusion.
I am happy to share my thoughts:
1) FACT: We don't have any support to move data from swap device to
another swap device nowadays. It will not happen overnight. Talking
about those percentage allocation and maintaining those percentages is
super complicated. I question myself getting ahead of myself on this
feature.
2) FACT: I don't know if any real customers want this kind of
sub-cgroup swap per tier max adjustment. We should write imaginary
code for imaginary customers and reserve the real coding for the real
world customers. Most of the customers I know, including our company,
care most about the top level CGroup swap assignment. There are cases
that enable/disable per sub CGroup swap device, in the QoS sense not
the swap max usage sense.
I think this will be one good question to ask feedback in the LPC MC
discussion. Does anyone care about per tier max adjustment in the
cgroup? We should only consider that when we have real customers.

So I would shelf this per tier max adjustment and not spend any more time o=
n it.

> > First of all, sorry about the pedantic, it should be "swap.tiers" just
> > to be consistent with the rest of the discussion.
> > Secondly, I just view names as an alias of the number. 1-3 is hard to
> > read what you want.
> > If we allow name as the alias, we can also do:
> > echo zram-hdd > memory.swap.tieres
> >
> > It is exactly the same thing but much more readable.
> >
> > >    cg1/cg2: 2-4,6  > memory.swap.tie (ssd,hdd,network device, somedev=
ice 2, assuming non-subset is allowed)
> >
> > echo ssd-network_device,some_device2 > memory.swap.tiers
> >
> > See, same thing but much more readable what is your intention.
> >
> > BTW, we should disallow space in tier names.
>
> Ack=E2=80=94those spaces were only in my example; the implementation will=
 reject
> spaces in tier names.
>
> I like the interface format you proposed, and I=E2=80=99ll move forward w=
ith an
> initial implementation using the name-based tier approach, dropping
> the numeric format.

I am glad you like it.

> > We do want to think about swap.tiers vs per tier swap.max. One idea
> > just brainstorming is that we can have an array of
> > "swap.<tiername>.max".
> > It is likely we need to have both kinds of interface. Because
> > "swap.<tiername>.max" specifies the inclusive child limit.
> > "swap.tiers" specifies this C group swap usage QoS. I might not use
> > hdd in this cgroup A, but the child cgroup B does. So A's hdd max
> > can't be zero.
> >
> > The other idea is to specify a percentage for each tier of the
> > swap.max in "swap.tiers.max": zram:30  sdd:70
> > That means zram max is "swap.max * 30%"   and ssd max is "swap.max *
> > 70%". The number does not need to add up to 100, but can't be bigger
> > than 100.
> > The sum can be bigger than 100.
> >
> > Need more sleep on it.
>
> I don=E2=80=99t have additional ideas beyond what you suggested at now. S=
ince swap.max
> is defined in terms of quantity, my intuition is that tier.max should
> probably also be quantity-based, not percentage. As I mentioned earlier,
> I had also considered per-device max in the early RFC stage. The design
> was to introduce per-device counters, but that added substantial overhead
> and complexity, especially in reconciling them with the global swap.max
> semantics. For that reason I abandoned the idea, though I agree your
> suggestion makes sense in the context of QoS extension.

We are in agreement here. We should not touch it until we have a real
customer ask for it.

> At this point I feel the main directions are aligned, so I=E2=80=99ll pro=
ceed
> with an initial patch version. My current summary is:
>
> 1. Global interface to group swap priority ranges into tiers by name
>    (/sys/kernel/mm/swap/swaptier).
I suggest "/sys/kernel/mm/swap/tiers" just to make the file name look
different from the "swap.tiers" in the cgroup interface.
This former defines all tiers, giving tiers a name and range. The
latter enroll a subset of the tiers.
 I think the tier bit location does not have to follow the priority
order. If we allow adding a new tier, the new tier will get the next
higher bit. But the priority it split can insert into the middle thus
splitting an existing tier range. We do need to expose the tier bits
into the user space. Because for madvise()  to set tiers for VMA, it
will use bitmasks. It needs to know the name of the bitmask mapping,
I was thinking the mm/swap/tiers read back as one tier a line. show:
name, bitmask bit, range low, range high


> 2. Slow path allocation uses bitmask skipping; fast path uses per-cpu
>    tier cluster caches.
If the fast path fails, it will go through the slow path. So the slow
patch is actually a catch all.
> 3. Cgroup interface format modeled after cpuset.
I am not very familiar with the cpuset part of the interface. Maybe
you should explain that to the reader without using cpuset cgroup as a
reference.
> 4. No inheritance between parent and child cgroup as a perspective of QoS
In my original proposal of "swap.tiers", if the default is not set on
this tier, it will look up the parent until the root memcg. There are
two different tiers bitmask.
One is the local tier bitmask. The other is the effective bitmask.
If local tier bitmask sets the default, the effective tier bitmask =3D=3D
local tier bitmask
if local tier bitmask does not set default, The effective tier is
concatenation from parent to this memcg.

For example
a/swap.tiers: - +ssd # ssd only
a/b/swap.tiers: ""  # effective "- +ssh", also ssd only.
a/b/c : + -hdd # effective "- +ssd + -hdd", simplify as "+ -hdd"  The
'+' overwrite the default, anything before that can be ignored.

That way, if you are not setting anything in "swap.tiers" in the child
cgroup, that is the default behavior when you create a new cgroup.
Changing the parent can change all the child cgroup at the same time.

> 5. Runtime modification of tier settings allowed.
Need to clarify which tier setting? "swap.tiers" or /sys/kernel/mm/swap/tie=
rs?

> 6. Keep extensibility and broader use cases in mind.
>
> And some open points for further thought:
>
> 1. NUMA autobind
>    - Forbid tier if NUMA priorities exist, and vice versa?
>    - Should we create a dedicated NUMA tier?
>    - Other options?

I want to verify and remove the NUMA autobind from swap later. That
will make things simpler for swap. I think the reason the NUMA swap
was introduced does not exist any more.

> 2. swap.tier.max
>    - percentage vs quantity, and clear use cases.
>   -  sketch concrete real-world scenarios to clarify usage

Just don't do that. Ignore until there is a real usage case request.

> 3. Possible future extensions to VMA-based tier usage.

Madvise(). That can be introduced earlier. I know a usage case for
that is the android. Android does not set every app as a cgroup. I
haven't checked for a while if that is still true.

> 4. Arbitrary ordering
>    - Do we really need it?
>    - If so, maybe provide a separate cgroup interface to reorder tiers.

No for now. Need to answer how to deal with swap entry LRU order
inversion issue.

Chris

