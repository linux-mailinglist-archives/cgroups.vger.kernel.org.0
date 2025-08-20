Return-Path: <cgroups+bounces-9283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075EB2D0D3
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB1E7B6CC9
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C718C031;
	Wed, 20 Aug 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE7oQhcE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E41C27
	for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651174; cv=none; b=OFyJh8uNG4LtBelqr3cPP9B73PloXi2Kp5bvBaVacCM4B1mkFCsKYgFjvbx3g43Sj2sBRo9CgiBWgfhcx+8j8o1ADjPmdhYg+3PI3xYY8mczbdC+C/ArqUwJNwUek/8jo/godKfA/ULMnyeRVo79RS5X7U5DXjaLUl4OZunS/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651174; c=relaxed/simple;
	bh=gyxDw6RJLZ4nHOW//7O/dOWyMikXlHhdl9FS8tozaIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzmfFM+bqxER/A4wP3/ndSMQtgObZh2arZ9zpYvP64MAt4hDR2+qK/RZRa/U4F2sUFIKcWdqv1gnsHydQHobCKqIJeYusQIdWFfRz9PbRHi9Lr/1wj7qkbpRatQz8l2y2tXSXZkxHFh1DCSe84MZhz/Gf3R15zP+SQ1qEScW+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE7oQhcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB0C2BCB4
	for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 00:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651173;
	bh=gyxDw6RJLZ4nHOW//7O/dOWyMikXlHhdl9FS8tozaIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XE7oQhcEh14/9LRdxfeo8vG2f3N8WNF/IBLtdZST5PUMjsW50RkIefAPXy0MER1lS
	 8aHmvBknBQaXz1xZ93bEhCk0zuFrji4S5DlZh6YjDet2ARQh4Gp6R5wGT71f0oBDYN
	 D7KaTVRxOpm9aHKXbYD2JbM+YRCaCTCAOplwIfc7a0K1UBrDrfj/TcweN9T5qs3RGX
	 +mIpbprlsbvB8Xx+y7Jt+FJgl6zcHzHKCAVMFMCCeMjrY6wBtArtDvoXIJbZFT2rbN
	 thVyBSb+7lnhWTGMvo3XRyzMEM80OM9SQ8pj0Y7qfG6OQtECBOIMwbvJK9C7iq1M6f
	 6fhu4w+O7bl0A==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459fc675d11so16625e9.1
        for <cgroups@vger.kernel.org>; Tue, 19 Aug 2025 17:52:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLAin4a8WviGaGDzTHwSpQB7DnGA7CJpdPQP8BF0aA59+0AFXwW2x11Vuc3TyCqjV9HQiavqMH@vger.kernel.org
X-Gm-Message-State: AOJu0YykfLhCQhgKWE2esNMVy085dVxWUqZCitoUF0X7BOh6iIv48drj
	643YqHI+kBfgClvIkiHRpGNQsgoiygxpSNi1BWg0vlyl+boyHvCv5lraDvFV6iYUsjcyMvFC5TI
	V1uA7Ybc+Mo/9PAqRWlcmXPWijUGTqZVz7he9izX8
X-Google-Smtp-Source: AGHT+IFQ0lLQ7LStOuv6ZrlcBR1b2jECtuFF2XmQzgGif7AkQw7+tIT3lA4q2BnzLBkSF3gaXH8SoEg9aL563Wg43Lc=
X-Received: by 2002:a05:600c:35c2:b0:45a:207a:eb7c with SMTP id
 5b1f17b1804b1-45b476d7e09mr701005e9.0.1755651172251; Tue, 19 Aug 2025
 17:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com> <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330> <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330> <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
In-Reply-To: <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Aug 2025 17:52:39 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
X-Gm-Features: Ac12FXx_nPLaGsHvIhpZPPFVTK0BSLVMR7dAaEP08V7iOUT0TsBblzZbq7PhYug
Message-ID: <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
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

On Tue, Aug 19, 2025 at 3:13=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Sat, Aug 16, 2025 at 12:15:43PM -0700, Chris Li wrote:
>
> At first, Thank you for detailed and fast feedback!
>
> > I have not questioned the approach you can achieve with your goal. The
> > real question is, is this the best approach to consider to merge into
>
> Yes, I believe this could be the best approach.
> I have compared several possible approaches before making this proposal. =
These
> are the alternatives I reviewed in the RFC:
> (https://lore.kernel.org/linux-mm/20250612103743.3385842-1-youngjun.park@=
lge.com/)
> The part I mentions are as belows
>
> > Evaluated Alternatives
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. **Per-cgroup dedicated swap devices**
> >    - Previously proposed upstream [1]
> >    - Challenges in managing global vs per-cgroup swap state
> >    - Difficult to integrate with existing memory.limit / swap.max seman=
tics
> > 2. **Multi-backend swap device with cgroup-aware routing**
> >    - Considered sort of layering violation (block device cgroup awarene=
ss)
> >    - Swap devices are commonly meant to be physical block devices.
> >    - Similar idea mentioned in [2]
> > 3. **Per-cgroup swap device enable/disable with swap usage contorl**
> >    - Expand swap.max with zswap.writeback usage
> >    - Discussed in context of zswap writeback [3]
> >    - Cannot express arbitrary priority orderings
> >      (e.g. swap priority A-B-C on cgroup C-A-B impossible)
> >    - Less flexible than per-device priority approach
> > 4. **Per-namespace swap priority configuration**
> >    - In short, make swap namespace for swap device priority
> >    - Overly complex for our use case
> >    - Cgroups are the natural scope for this mechanism
>
> In my view, the `swap.tier` proposal aligns quite well with alternative (=
3) that
> I reviewed. That approach keeps the global priority assignment while addi=
ng

Not the same as option 3. swap.tier has one level in direction for the
tier class. It does not directly operate on swap files. That level of
indirection allows swap files to rotate within the same tier. I expect
it to have very few tires so all the swap tires can fit a simple
bitmask, e.g. one 32 bit integer per cgroup is good enough. Assume we
allow 31 tiers. We can have less than 32 swap files, 31 tiers should
be more than enough.

> inclusion/exclusion semantics at the cgroup level. The reason I decided n=
ot to
> go with it is because it lacks flexibility =E2=80=94 it cannot express ar=
bitrary
> ordering. As noted above, it is impossible to represent arbitrary orderin=
gs,
> which is why I chose a per-device priority strategy instead.

As said, arbitrary orders violate the swap entry LRU orders. You still
haven't given me a detailed technical reason why you need arbitrary
orders other than "I want a pony".

> > the main line Linux kernel. Merging into the main line kernel has a
> > very high bar. How is it compared to other alternative approaches in
> > terms of technical merit and complexity trade offs.
>
> Since you seem most concerned about complexity, I have been thinking more=
 about
> this point.
>
> 1. **Conceptual complexity**
>    The idea is simply to add a swap priority list per cgroup. This is
>    straightforward to understand. The more complicated part is NUMA prior=
ity
>    handling =E2=80=94 but if that turns out to be too complex, we can dro=
p it entirely
>    or adjust its semantics to reduce the complexity.

The swap priority list is a list. The swap tiers is just a set less
than32 total tiers. Can be expressed in one integer bitmask.

> 2. **Implementation complexity**
>    Could you clarify from which perspective you see implementation comple=
xity as
>    problematic? I would like to know more specifically what part worries =
you.

Your 4 patch series total lines of code? I expect the swap tiers can
be much shorter, because it does not deal with arbitrate orders.

> The `swap.tier` concept also requires mapping priorities to tiers, creati=
ng
> per-cgroup tier objects, and so forth. That means a number of supporting
> structures are needed as well. While I agree it is conceptually well-defi=
ned,
> I don=E2=80=99t necessarily find it simpler than the per-device priority =
model.

You haven't embraced the swap.tiers ideas to the full extent. I do see
it can be simpler if you follow my suggestion. You are imaging a
version using swap file priority data struct to implement the swap
tiers. That is not what I have in mind. The tiers can be just one
integer to represent the set of tiers it enrolls and the default. If
you follow my suggestion and the design you will have a simpler series
in the end.

> > Why would I trade a cleaner less complex approach for a more complex
> > approach with technical deficiency not able to address (inverting swap
> > entry LRU ordering)?
>
> Could you elaborate on what exactly you mean by =E2=80=9Cinverting swap e=
ntry LRU order=E2=80=9D?
> Do you mean that because of per-cgroup priority differences, entries on t=
he
> global swap LRU list could become inconsistent when viewed from different
> cgroups?

Exactly.

>If that is the case, could you explain more concretely what problems
> such inconsistencies would cause? That would help me understand the conce=
rn

The problem is that you pollute your fast tier with very cold swap
entry data, that is to your disadvantage, because you will need to
swap back more from the slower tier.

e.g. you have two pages. Swap entry A will get 2 swap faults, the swap
entry B will get 20 swap faults in the next 2 hours. B is hotter than
A. Let's say you have to store them one in zswap and the other in hdd.
Which one should you store in faster zswap? Obvious swap entry B.

It will cause more problems when you flush the data to the lower tier.
You want to flush the coldest data first. Please read about the
history of zswap write back and what LRU problem it encountered. The
most recent zswap storing the incompressible pages series in the mail
list precisely driven by preserving the swap entry LRU order reason.

You really should consider the effect on swap entry LRU ordering
before you design the per cgroup swap priority.

> > From the swap file point of view, when it needs to flush some data to
> > the lower tiers, it is very hard if possible for swap file to maintain
> > per cgroup LRU order within a swap file.
>
> Could you explain in more detail why the flush operation is difficult in =
that
> case? I would like to understand what the concrete difficulty is.
>
> > It is much easier if all the swap entries in a swap file are in the
> > same LRU order tier.
>
> This is related to the same question above =E2=80=94 I would appreciate a=
 more
> detailed explanation because it is not yet clear to me. Why is it easy?

Because I don't need to alter the list ording. When it enumerates the
same list of swap files, it just needs to check if the current swap
file is excluded by the swap.tiers integer bitmask. Each swap file can
cache a bit which tier it is belonging to, for example.

>
> > The swap.tiers idea is not a compromise, it is a straight win. Can you
> > describe what per cgroup per swap file can do while swap.tiers can
> > not?
>
> I mentioned already on this mail: what swap tiers cannot do is arbitrary
> ordering. If ordering is fixed globally by tiers, some workloads that wan=
t to
> consume slower swap devices first (and reserve faster devices as a safety
> backend to minimize swap failures) cannot be expressed. This kind of poli=
cy
> requires arbitrary ordering flexibility, which is possible with per-devic=
e
> priorities but not with fixed tiers.

Let's say you have fast tier A and slow tier B.

Option 1) All swap entries go through the fast tier A first. As time
goes on, the colder swap entry will move to the end of the tier A LRU,
because there is no swap fault happening to those colder entries. If
you run out of space of  A, then you flush the end of the A to B. If
the swap fault does happen in the relative short period of time, it
will serve by the faster tier of A.

That is a win compared to your proposal you want directly to go to B,
with more swap faults will be served by B compared to option 1).

option 2) Just disable fast tier A in the beginning, only use B until
B is full. At some point B is full, you want to enable fast tier A.
Then it should move the head LRU from B into A. That way it still
maintains the LRU order.

option 1) seems better than 2) because it serves more swap faults from
faster tier A.

> And vswap possible usage: if we must consider vswap (assume we can select=
 it
> like an individual swap device), where should it be mapped in the tier mo=
del?
> (see https://lore.kernel.org/linux-mm/CAMgjq7BA_2-5iCvS-vp9ZEoG=3D1DwHWYu=
VZOuH8DWH9wzdoC00g@mail.gmail.com/)

The swap tires do not depend on vswap, you don't need to worry about that n=
ow.

> In my opinion, it cannot be mapped purely by service speed.
> There are indeed situations where tiering by service speed is beneficial,
> but I also believe priority-based ordering can capture the same intention
> while also covering exceptional use cases.

The above two options should be able to cover what you want.

> So, I see the per-device priority approach as more general: it can repres=
ent
> tier-based usage, but also more flexible policies that tiers alone cannot=
 cover.

Not worth while to break the swap entry LRU order. We can do it in a
way keeping the LRU order. You will be serving the more swap fault
from the fast tier which is an overall win.

> > It obviously will introduce new complexity. I want to understand the
> > reason to justify the additional complexity before I consider such an
> > approach.
>
> I think that any new concept adds complexity, whether it is =E2=80=9Cswap=
.tier=E2=80=9D or
> per-device priority. If you could clarify more precisely what kind of
> complexity you are most concerned about, I would be happy to give my deta=
iled
> thoughts in that direction.

I see no real justification to break the swap entry LRU order yet.
Will my solution 1) or 2) work for you in your example?

The per cgroup swap tiers integer bitmask is simpler than maintaining
a per cgroup order list. It might be the same complexity in your mind,
I do see swap tiers as the simpler one.

Chris

