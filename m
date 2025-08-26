Return-Path: <cgroups+bounces-9427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59499B36A13
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D64E1020
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92D3570D1;
	Tue, 26 Aug 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbTaXnbb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A13570BB
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218672; cv=none; b=eeMqHTLRpfTKNYDlVthIuTQZhKSRe08qW10DN5YDSPKp5VOB1+FLH1+cXShLs0bmKHw0cb8T9lBMGbOvD2VM20gL7FViX+YtkKXlGJdelKUKh+E/dcgmKprSiWjfohwOm4ziGwurSCopzWBm1c9eBUTjMnZvjMkOKqYlGdfbgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218672; c=relaxed/simple;
	bh=sBfx6RKR1jhch/MJ9ACYN2YBRPZO24K433uzek3l4ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8GNbnypDc16OpD8yeEhMI3aJmOJjrdkPTaJdfLrZw9aVaft0JqutIipsHLJ+5+lJjUX0zRm7h8rXk1x6RioqC4PPC9w0QExUxyrVnaIU5PTftx/fIdsCJOqKpywV4aThiDaC5NZSe5f1l5OeYhMO+i1pKcPB53QhJF4/fcpvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbTaXnbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF5C2BCB0
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218672;
	bh=sBfx6RKR1jhch/MJ9ACYN2YBRPZO24K433uzek3l4ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XbTaXnbbzG/d6gVrjThDZOTm6OX/vFx1BAVAyCtoot6uaCepVvB9RSYemPdQdpTdZ
	 SPxEROg54JYRZaCDCRWzEXM33Nadn0luuWFBZW5s/kiO35xqCtoTRhqcx5xAH2f52r
	 go07HXmJjVbsviCP8Mrxzul4g/nubWpVsaApfH5kOx0ln6K45x4D/7JQ7M5q/nj257
	 +9D6l0Chqdm09ZyEMO8Pay9g5Vvyt2+vtHvFtxAW/KcCNdZ0kaKumQM/9qkj8cXgmO
	 nZht9h/jQaDa0WUrUQNOfdz20/lZ69dFLBCquOEqgQZKWh0tJeMbUGHFGOauaY7SbN
	 07sqm1v4nhFwQ==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e9537b957caso2191938276.2
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:31:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUSPHP28nrBsWWt8gAE3KarxjY3GO2pC9FLzxgna9SqYNK10Z07OzrKjTq236ijrqKCx23X98I@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNwTnlJdGiaO5phWu9hhyKrIsgIF37Rjq9UV5fY92KUaRDZeR
	TUDWgjvh8EY8wA8BYEoEHP5KqBRwux9e99vo4tsmhWcoDWeEtp9YYf5gbZ36E7fwC3O/ruT9r1Z
	xzHgIMlQYP4HXrKOPp9iDWImPl2qlmgI1lzn6Kk/Cuw==
X-Google-Smtp-Source: AGHT+IH77JJDEIbuN57uz40sfp31MTxtmzP/v0+AqhSg4CF4IS4dWmvMXFv8EBgo5iGIl4cbs9yN/DHVqc/mvA+YSpk=
X-Received: by 2002:a05:6902:4209:b0:e95:1d30:8b5c with SMTP id
 3f1490d57ef6-e951d308d39mr14909266276.36.1756218671544; Tue, 26 Aug 2025
 07:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330> <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330> <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330> <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
In-Reply-To: <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 07:30:59 -0700
X-Gmail-Original-Message-ID: <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
X-Gm-Features: Ac12FXw4zet859fBsaeudg3OJUMSKFPlBY7LHUVeCvmswDqRkdcrnIgtIV0rVqs
Message-ID: <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
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

On Tue, Aug 26, 2025 at 5:57=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
> > I think both cases are possible, I don't see a strong reason to limit
> > the flexibility when there is no additional cost. I expect the
> > restriction approach having similar complexity.
>
> In my use case, I think a restrictive inheritance model could
> be sufficient. My argument was mainly based on the fact that most cgroup
> resource distribution mechanisms usually follow a parent=E2=86=92child re=
strictive
> pattern. Through the review, I came to the view that I should adhere to t=
he
> common behavior whenever possible.

I sleep on it a bit both literally and philosophically. I like to
point out that most of the cgroup control is about resource
constraints. For example, if you set a memory limit on the toplevel
cgroup. None of the children can go beyond that limit. So the child
usage does not make sense to go more than the parent usage. This is a
strict mathematical subset containing relationships. That is the
deeper reason behind the parent to child more restrictive pattern,
because mathematically it does not make sense otherwise.

The swap file control is different. What we really want is not about
the source limit. We have swap.max for that. The swap.tiers is about
QoS control. In the QoS point of view, there is not such a strict
subset containing relationships. The QoS of the parent and child can
be independent. Therefore, it is justifiable to have an anti-pattern
here. Because the root cause, the QoS is not a resource limit type of
the constain. It is more like a policy.

We shouldn't adhere to the common behavior just because other cgroup
interfaces do it. Here I believe we have a justifiable reason to break
away from it. Because it is a different type of control, QoS vs limit.

I think you touch on a very important question that might trigger a
big design change. Do we want to have a per tier swap.max? It will
specify not only whether this cgroup will enroll into this tier or
not. It also controls how much swap it allows to do in this cgroup.
The swap.max will follow the straight contain relationship. I would
need to think more about the relationship between swap.max and
swap.tiers. Initial intuition is that, we might end up with both per
tier swap.max, which control resource limit, it has subset contain
relationship. At the same time the swap.tiers which control QoS, it
does not follow the subset contained.

Need more sleep on that.

> Firstly(on RFC), I initially supported allowing parent/child inconsistenc=
y
> for flexibility, so I actually agree with your view regarding flexibility=
.
> For the examples you mentioned, I have no disagreement. I think my final
> understanding is aligned with yours.
>
> > Can you clarify what I need to reconsider? I have the very similar
> > bitmask idea as you describe now.
> > I am not a dictator. I just provide feedback to your usage case with
> > my reasoning.
> >
>
> Oh! I think you are a good reviewer :D
> Okay then, Let me explain my preference for numeric tiers in more detail.
> It seems we are aligned on the implementation strategy with bitmask,
> but I think our difference lies in the interface style =E2=80=94 'name' v=
s.
> 'numeric increase'."
>
> 1. A simple numeric interface makes the usage more straightforward.
>    Instead of '+/-' semantics, directly listing the numeric range feels
>    clearer and easier to use. For example:

I am not against it. There might be some small aspect of it here and
there to fine tune.

>      tier 1 (ram)
>      tier 2 (ssd)
>      tier 3 (hdd)
>      tier 4 (network device)
>      tier 5 (some device)
>      tier 6 (some device2)
>
>    cg1: echo 1-3  > memory.swap.tier (ram,ssd,hdd)

First of all, sorry about the pedantic, it should be "swap.tiers" just
to be consistent with the rest of the discussion.
Secondly, I just view names as an alias of the number. 1-3 is hard to
read what you want.
If we allow name as the alias, we can also do:
echo zram-hdd > memory.swap.tieres

It is exactly the same thing but much more readable.

>    cg1/cg2: 2-4,6  > memory.swap.tie (ssd,hdd,network device, somedevice =
2, assuming non-subset is allowed)

echo ssd-network_device,some_device2 > memory.swap.tiers

See, same thing but much more readable what is your intention.

BTW, we should disallow space in tier names.

>
>    Tier specification can also be expressed simply as arrays of priority
>    ranges, which feels easy to understand.

The number to device mapping is just harder for humans to process. I
think the named alias makes sense. There is an advantage of using bash
to control it from sysfs rather than a dedicated user space swap tiers
control tool. You can still write a user space tool if you want. I
want the userspace tool optional.
It is the same thing under the hook anyway.

> 2. Since tiers are inherently ordered, numbering fits naturally and is
>    easier for users to accept.
>    In my view, assigning a name is mainly useful to distinguish between
>    otherwise 'indistinguishable' groups, but in this case, there is alrea=
dy
>    a clear distinction given by the different priorities which simply be
>    charaterized by increasing number.
>
> I understand your point that tier names may be more convenient for
> administrators, and I see the value in that. That was why I used the word
> "reconsider" =E2=80=94 your feedback makes sense as well.

I still prefer to use the name myself. I am not against having numbers
if you prefer numbers more. You can configure it with numbers. I have
a small brain and I want to use names as aliases to config.

> I do not have a strong preference. It would be good to align after
> considering the pros and cons. I look forward to your thoughts."

The name is a huge usability improvement for bare mortals. I don't
want to maintain user space tools just to adjust swap.tiers IMHO. I am
not opposed to someone else having such tools. It needs to be
optional.

> > > There seem to be two possible choices:
> > >
> > > 1. Once a cgroup references a tier, modifying that tier should be
> > >    disallowed.
> >
> > Even modify a tier to cover more priority range but no swap device
> > falls in that additional range yet?
> > I think we should make the change follow the swap on/swap off
> > behavior. Once the swap device is swapped on, it can't change its tier
> > until it is swapped off again. when it is swapped off, there is no
> > cgroup on it. Notice the swap file belongs to which tier is not the
> > same as the priority range of the tier. You can modify the range and
> > reorder swap tiers as long as it is not causing swap on device jump to
> > a different tier.
> >
> > > 2. Allow tier re-definition even if cgroups are already referencing
> > >    it.
> >
> > You can still swap off even if cgroup is still using it.
> >
> > > Personally, I prefer option (1), since it avoids unexpected changes
> > > for cgroups that already rely on a particular tier definition.
> >
> > Swap off and on already have similar problems. We can't change the
> > priority when the swap device is swapon already. We can go through a
> > swap off to change it.
>
> I see your point. In practice, when tiers are already being referenced
> by cgroups, swap devices may come and go within those tiers. I think
> this can be considered a "natural" behavior, as swap management is
> usually performed explicitly by the administrator.
>
> From that perspective, I expect that unintended behavior is very
> unlikely to occur in real scenarios. So I am comfortable assuming this
> implicit behavior when reasoning about tier modifications.
>
> Thanks again for the clarification. With this, the overall picture
> feels much clearer. Once we reach alignment on the "named" vs. "numeric"
> tier interface, I plan to move forward with the patch work.

I consider that really trivial. Why can't we have both? The madvise
interface might only use numbers in the form of bit mask. Because that
is a C interface. For sysfs and administrative control, having a name
as an alias is so much better.

We do want to think about swap.tiers vs per tier swap.max. One idea
just brainstorming is that we can have an array of
"swap.<tiername>.max".
It is likely we need to have both kinds of interface. Because
"swap.<tiername>.max" specifies the inclusive child limit.
"swap.tiers" specifies this C group swap usage QoS. I might not use
hdd in this cgroup A, but the child cgroup B does. So A's hdd max
can't be zero.

The other idea is to specify a percentage for each tier of the
swap.max in "swap.tiers.max". That in place of "swap.<tiername>.max":
zram:30  sdd:70
That means zram max is "swap.max * 30%"   and ssd max is "swap.max *
70%". The number does not need to add up to 100, but can't be bigger
than 100.
The sum can be bigger than 100.

Need more sleep on it.

Chris

