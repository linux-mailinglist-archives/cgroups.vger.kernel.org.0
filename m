Return-Path: <cgroups+bounces-9331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8603AB320C7
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E574AE467E
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE4307AD3;
	Fri, 22 Aug 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgyipajJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E690302740
	for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881326; cv=none; b=rLgLVc2BkEx9JLtYySBxGlWLI5LIY+ULNBPmK9pEpgPuzXjl1z0FMnOectMAqgHZQxB82ct+A8hvQ7XULmalJwrgIg2ihFvz+IDbFtu4nKmL24UZ8WBJlBXOdUc6qW80x4rrNBjTiHZgWecYBujebo437Q1jdmi5rGFXMsaUx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881326; c=relaxed/simple;
	bh=TYQIQp1NujBukq4LQ/crsbFhjOljGgADOcjgjYHCdAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTBfPjxyqM/aKgt4zWxTbDBb9o4LcQdNNPWFh64ExAGgXKITsdmNtJyjnxz0K16Z0+EVyxZeLXuCcp1tO1S4u4K60ETI2IwfDdSPsGrQv3tGqT8a+h6KeyMhDyT3Nc1wT3ao3CnwgUOqbFFZu2u8j6PGFkmWeI2xwT3LscQ92WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgyipajJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB84C116C6
	for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 16:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881325;
	bh=TYQIQp1NujBukq4LQ/crsbFhjOljGgADOcjgjYHCdAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TgyipajJ2g8nbnedK0RV54hnypJ3DaUalN56+ZaiY0hXPaOPINmqflvVqqA6Ade8A
	 42/Pzaf9zZoLZOtkhVdYjiopjSXHiHsLvT1kKoheRpc8UbDEmqBzeT6voLYzeTxprf
	 FPLIL2j+W9LfErkKxV44We00MXb3LWMwwozQZ6B8VrmPki6m0eYV/nt4sxw4Z46SyD
	 X33XlOikFYMJg9xt6Vh4wVV5bjM52KrM/H4yrwLbBhm7DsX3J+TFros4HZtLw/SR4a
	 QPhCKjY8odgbFwOUI6ttH9vZkSFA1CcDhUc/f8Hx/dOM2VwAH4aZhmvIuQ4LCyQS6F
	 i/5IvaIYhEPGA==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so745e9.1
        for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 09:48:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt0qDxcbQEk5eHrL/qzaieKca2SVNMwjwOUv1bDbhFVSVa50VQR4wdGhyHPvPceT9IBjnKJEtT@vger.kernel.org
X-Gm-Message-State: AOJu0YyoD8mX6QXMtOMCyMjVWzcg97mnEt9Q9m1V4OF41rDPnafvkEZO
	3F2mUzv70Zzz5TQHGTpFuRV4XX6eRUXFBawkW8Yy/LOX2nkXOgtSOCFm5cbHH1xdC+hjDU9mAJr
	Vf3s97MwWNXK0SXVucckbng+/9pP0nzos2UiiwbKI
X-Google-Smtp-Source: AGHT+IEQGkNZ+YIeD4Ab6wByDF43LtG+ePKPKlcWbnTXJJTA28r5qb3dOjGqLRBrrTV3SgP9gvvGQquS1jK3YV4hBNQ=
X-Received: by 2002:a05:600c:4aa9:b0:456:4607:b193 with SMTP id
 5b1f17b1804b1-45b52128a6emr1291465e9.7.1755881324322; Fri, 22 Aug 2025
 09:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330> <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330> <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330> <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330> <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
In-Reply-To: <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 22 Aug 2025 09:48:33 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
X-Gm-Features: Ac12FXwV8Pu536bYTbqPyLV4-nVlSFp8jYXrfNMlVJBoyvYT3NOOf-bufZ6u1ZI
Message-ID: <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
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

On Thu, Aug 21, 2025 at 10:45=E2=80=AFPM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
> I still believe that the priority based approach has more flexibility,
> and can cover more usage scenarios. That opinion has not changed.

I agree with you on that. It is more flexible that way, no question about i=
t.

I am open to considering your usage scenarios and revisit the
swap.tiers limitation. I just haven't seen the real usage scenario
yet.

> However, from this discussion I came to clearly understand and agree on
> three points:
>
> 1. The swap.tier idea can be implemented in a much simpler way, and
> 2. It can cover the most important use cases I initially needed, as well
>    as common performance scenarios, without causing LRU inversion.
Glad we are aligned on this.

> 3. The really really needed usage scenario of arbitrary ordering does not=
 exist.
> the usage scenario I suggest is imaginary.(just has possibility)
Wow, that is surprise for me to see that from you. I was expecting
some very complex or special usage case demand on the arbitrary
ordering. If it is just an imaginary usage scenario, I am very glad we
did not pay the price of extra complexity for imaginary usage.

> I have also considered the situation where I might need to revisit my
> original idea in the future. I believe this would still be manageable
> within the swap.tier framework. For example:

Sure, having an incremental improvement is a good thing. We can always
come back and revisit if the reasoning for the previous decision is
still valid or not.

> * If after swap.tier is merged, an arbitrate ordering use case arises
>   (which you do not consider concrete), it could be solved by allowing
>   cgroups to remap the tier order individually.

Ack.

> * If reviewers later decide to go back to the priority based direction,
>   I think it will still be possible. By then, much of the work would
>   already be done in patch v2, so switching back would not be
>   impossible.

I really doubt that we need to get back to the pure priority approach.

> And also, since I highly respect you for long-time contributions and
> deep thinking in the swap layer, I decided to move the idea forward
> based on swap.tier.

Thank you. I really appreciate you taking the feedback with flexibility.

> For now, I would like to share the first major direction change I am
> considering, and get feedback on how to proceed. If you think this path
> is promising, please advise whether I should continue as patch v2, or
> send a new RFC series or new patch series.
>
> -----------------------------------------------------------------------
> 1. Interface
> -----------------------------------------------------------------------
>
> In the initial thread you replied with the following examples:
>
> > Here are a few examples:
> > e.g. consider the following cgroup hierarchy a/b/c/d, a as the first
> > level cgroup.
> > a/swap.tiers: "- +compress_ram"
> > it means who shall not be named is set to opt out, optin in
> > compress_ram only, no ssd, no hard.
> > Who shall not be named, if specified, has to be the first one listed
> > in the "swap.tiers".
> >
> > a/b/swap.tiers: "+ssd"
> > For b cgroup, who shall not be named is not specified, the tier is
> > appended to the parent "a/swap.tiers". The effective "a/b/swap.tiers"
> > become "- +compress_ram +ssd"
> > a/b can use both zswap and ssd.
> >
> > Every time the who shall not be named is changed, it can drop the
> > parent swap.tiers chain, starting from scratch.
> >
> > a/b/c/swap.tiers: "-"
> >
> > For c, it turns off all swap. The effective "a/b/c/swap.tiers" become
> > "- +compress_ram +ssd -" which simplify as "-", because the second "-"
> > overwrites all previous optin/optout results.
> > In other words, if the current cgroup does not specify the who shall
> > not be named, it will walk the parent chain until it does. The global
> > "/" for non cgroup is on.
> >
> > a/b/c/d/swap.tiers: "- +hdd"
> > For d, only hdd swap, nothing else.
> >
> > More example:
> > "- +ssd +hdd -ssd" will simplify to: "- +hdd", which means hdd only.
> > "+ -hdd": No hdd for you! Use everything else.
> >
> > Let me know what you think about the above "swap.tiers"(name TBD)
> > proposal.
>
> My opinion is that instead of mapping priority into named concepts, it
> may be simpler to represent it as plain integers.

In my mind, the tier name is just a look up to a bit in the bit mask.
Give it a name so it is easier to distinguish with the other number
e.g. priority number.

> (The integers are assigned in sequential order, as explained in the follo=
wing reply.)
> This would make the interface almost identical to the cpuset style sugges=
ted by Koutn=C3=BD.
>
> For example:
>
>   echo 1-8,9-10 > a/swap.tier   # parent allows tier range 1=E2=80=938 an=
d 9-10

swap.tiers, it can have more than one tier.

How do you express the default tier who shall not name? There are
actually 3 states associated with default. It is not binary.
1) default not specified: look up parent chain for default.
2) default specified as on. Override parent default.
3) default specified as off. Override parent default.

e.g. "- +zswap +ssd" means default off, allow zswap and sdd tiers.

>   echo 1-4,9    > a/b/swap.tier # child uses tier 1-4 and 9 within parent=
's range
>   echo 20   > a/b/swap.tier # invalid: parent only allowed 1-8 and 9-10

How are you going to store the list of ranges? Just  a bitmask integer
or a list?
I feel the tier name is more readable. The number to which actual
device mapping is non trivial to track for humans.
Adding a name to a tier object is trivial. Using the name is more convenien=
t.
We might be able to support both if we make up a rule that tier names
can't be pure numbers.

I want to add another usage case into consideration. The swap.tiers
does not have to be per cgroup. It can be per VMA. We can extend the
"madvise" syscall so the user space can advise to the kernel, I only
want this memory  range which contains my private key swap to zswap,
not hdd. So that if there is an unexpected power off event,  my
private key will not end up in the hdd. In RAM or zswap is fine
because they will be gone when power off.
>
> named concepts can be dealt with by some userland based software solution=
.
> kernel just gives simple integer mapping concept.
> userland software can abstract it as a "named" tier to user.

The kernel will need to manage the tier object anyway, which range it
covers, having a name there is trivial. I consider it just convenient
for system admins. Pure tier number map to another priority number is
a bit cryptic.

> Regarding the mapping of names to ranges, as you also mentioned:
>
> > There is a simple mapping of global swap tier names into priority
> > range
> > The name itself is customizable.
> > e.g. 100+ is the "compress_ram" tier. 50-99 is the "SSD" tier,
> > 0-55 is the "hdd" tier.
> > The detailed mechanization and API is TBD.
> > The end result is a simple tier name lookup will get the priority
> > range.
> > By default all swap tiers are available for global usage without
> > cgroup. That matches the current global swap on behavior.
>
> One idea would be to provide a /proc/swaptier interface:

Maybe stay away from  '/proc'. Maybe some thing like "/sys/kernel/mm/swap"
>
>   echo "100 40" > /proc/swaptier
>
> This would mean:
> * >=3D100 : tier 1
> * 40=E2=80=9399 : tier 2
> * <40   : tier 3
>
> How do you feel about this approach?
Sounds fine. Maybe we can have
"ssd:100 zswap:40 hdd" for the same thing but give a name to the tier
as well.You can still reference the tier by numbers.

>
> -----------------------------------------------------------------------
> 2. NUMA autobind
> -----------------------------------------------------------------------
>
> If NUMA autobind is in use, perhaps it is best to simply disallow
> swaptier settings. I expect workloads depending on autobind would rely
> on it globally, rather than per-cgroup. Therefore, when a negative
> priority is present, tier grouping could reject the configuration.

Can you elaborate on that. Just brainstorming, can we keep the
swap.tiers and assign NUMA autobind range to tier as well? It is just
negative ranges, we can assign negative ranges to say "NUMA" tier.
Then if the swap.tiers contain "ssd NUMA" then it is as if the system
only configures ssd and numa globally. Frankly I don't think the NUMA
autobind swap matters any more in the new swap allocator. It can also
make up rules that if swap.tiers was used, no NUMA autobinds for that
cgroup.

>
> -----------------------------------------------------------------------
> 3. Implementation
> -----------------------------------------------------------------------
>
> My initial thought is to implement a simple bitmask check. That is, in
> the slow swap path, check whether the cgroup has selected the given
> tier. This is simple, but I worry it might lose the optimization of the
> current priority list, where devices are dynamically tracked as they
> become available or unavailable.
>
> So perhaps a better design is to make swap tier an object, and have
> each cgroup traverse only the priority list of the tiers it selected. I
> would like feedback on whether this design makes sense.

I feel that that has the risk of  premature optimization. I suggest
just going with the simplest bitmask check first then optimize as
follow up when needed. The bitmask check should still work with the
dynamic lists of swap devices but I doubt how much of a difference
that NUMA autobind makes now.

Chris

