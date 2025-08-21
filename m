Return-Path: <cgroups+bounces-9313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A3B3077A
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B8B0797B
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4935AABB;
	Thu, 21 Aug 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXv+0i1h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146335A294
	for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808805; cv=none; b=cdzxaBsvYgX06SxZxmc1WCsNr92wfR0HCLc8+cino/5qvNr0weFlhZGsUZ/P8ZFAJDsZbueOkYncKLHMJzeuJ8Pr35CXcfRqn41vYQNwvRYWv34qfWvpN3vlx71xKfbJCXgqahpwXHtA4+cHXMd0oYn7Fn3zE3Rwt8irMA38hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808805; c=relaxed/simple;
	bh=OE8FIce0XKN85i6wjDeep8ikOe2wz+53GSgWxMmBDuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihVUl591VIQUIExZZcYZa1WlcahU4dx0WWXbFJQXQhhGrkWgWbWp7Mo28Rg/j8WoXlZLAGbnHEcturfQxc1R8wAFypb3OXLLu4KEqkLIaJNM0bIF/jbkNUBJ/h9qAOEVXMIAaOd/SdK2FyFgIWG8IJXXBrEzVjFZgJOLPmOVnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXv+0i1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D153C4AF09
	for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755808805;
	bh=OE8FIce0XKN85i6wjDeep8ikOe2wz+53GSgWxMmBDuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dXv+0i1h56OrHCHlETeTNP585D1FpSGphmxFQ+FQUvGpqgiTfwSD9P7FddXfgv8LY
	 GoWKDB/BAvmHwnHvo8Pw5YE9WhuUMoaWyoTh1A52XavUi4Iw6DfJ0R3cYolnyVaM6d
	 c6+GkejS9Rj+8pYOSKnwkpMpxSZxnnoshYdKubV1iEoTYiFA7Kqjv82mhsWpXtTZ5E
	 K9cj/qIuVXhyJeGJFSBZMBRbryy2dTc+AyMWNAX/gbVeEg8oMYCd7rvbML10fmnW+U
	 bq97JE01OkvsUTUCjllsDlutOqZ8TG4/gbw+t5MAkrvSoJhCkkxPGdZUjNRSHwE6M+
	 5onEN/X/0i8zQ==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc675d11so5785e9.1
        for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 13:40:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUfICYcu2xky3VkU1Qp0820cTEXRlzbtuS7H581DuVEWaC7FcQHSCcv7stYN4AA+Bb8RkmgiuX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JyMuAs5+hZjaTXDGWxQVMeho0f5+eT1nUreZvKAJAu0xUwVq
	NKs9+KTPDoF1XSHhxSgbx00nC1zkoh5d24Pk3Je4pS3FFc1XIoGXSHor39NQ0qneRse3b8Op66p
	xfQKIZJW7A4zDVXVS1Nb/cu8hjgIu7MBctpOGsoKB
X-Google-Smtp-Source: AGHT+IHAVVARzLJ+ujxq4b1q+Zeu2x/aLUsSEpqLl5XmMkgRCP5G74y7fShZw7wEhT73c61JdJx/IW6tPC7VB1P/PU8=
X-Received: by 2002:a05:600c:35d3:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45b5172a23bmr415565e9.6.1755808803420; Thu, 21 Aug 2025
 13:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330> <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330> <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330> <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
In-Reply-To: <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Aug 2025 13:39:51 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
X-Gm-Features: Ac12FXxJpZnWqBXonP4CvO1eyKw0FGi0bEJQVwb0VczZMRYfT2Bm2J2f9ppOvfI
Message-ID: <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
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

On Wed, Aug 20, 2025 at 7:39=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> > > inclusion/exclusion semantics at the cgroup level. The reason I decid=
ed not to
> > > go with it is because it lacks flexibility =E2=80=94 it cannot expres=
s arbitrary
> > > ordering. As noted above, it is impossible to represent arbitrary ord=
erings,
> > > which is why I chose a per-device priority strategy instead.
> >
> > As said, arbitrary orders violate the swap entry LRU orders. You still
> > haven't given me a detailed technical reason why you need arbitrary
> > orders other than "I want a pony".
>
> I believe the examples I provided for arbitrary ordering can be considere=
d
> a detailed technical reason.
> (You responded with Option 1 and Option 2.)

You still did not provide the detailed reason for it yet. I understand
you want the per cgroup swap device arbitrate ordering, that is a
solution not the root cause. I want to go one level deeper, why do you
want to have per cgroup swap device ordering. What is the
consideration to use the per cgroups list of the swap device order vs
other approach. For example, I want to preserve the fast swap device
mostly for jobs requiring fast response, I don't want to fill the fast
swap device with slow jobs' data. That is one of my guesses. Please
provide the background usage case and thinking process to get to that
conclusion.  Right now I am just guessing in the dark. You jump to the
conclusion of using aribitury cgroup swap device order as the only
solution too soon too quickly.

> > > The `swap.tier` concept also requires mapping priorities to tiers, cr=
eating
> > > per-cgroup tier objects, and so forth. That means a number of support=
ing
> > > structures are needed as well. While I agree it is conceptually well-=
defined,
> > > I don=E2=80=99t necessarily find it simpler than the per-device prior=
ity model.
> >
> > You haven't embraced the swap.tiers ideas to the full extent. I do see
> > it can be simpler if you follow my suggestion. You are imaging a
> > version using swap file priority data struct to implement the swap
> > tiers.
>
> Thank you for the detailed explanation. I think I understood the core poi=
nts of this concept
> What I wrote was simply my interpretation =E2=80=94 that it can be
> viewed as a well-defined extension of maintaining equal priority dependen=
cy
> together with inclusion/exclusion semantics. Nothing more and nothing les=
s.

Good.


> > That is not what I have in mind. The tiers can be just one
> > integer to represent the set of tiers it enrolls and the default. If
> > you follow my suggestion and the design you will have a simpler series
> > in the end.
>
> Through this discussion my intention is to arrive at the best solution,

Ack.

> and I appreciate that you pointed out areas I should reconsider. If you,
> and other reviewers(If somebody gives opions of it, then it will be helpf=
ul)
> generally conclude that the tier concept is the right path,

That is why we should make it a more formal proposal, list out the
details to solicit feedback.

> I have a clear willingness to re-propose an RFC and patches
> based on your idea. In that case, since arbitrary ordering would not be
> allowed, I fully agree that the main swap selection logic would become
> simpler than my current implementation.

Thank you. If you can integrate the swap.tiers into your next series,
that would be great. I am worried that I might not have enough time to
implement it myself. I can certainly reason about it and point you in
the right direction as best as I can.

> > The problem is that you pollute your fast tier with very cold swap
> > entry data, that is to your disadvantage, because you will need to
> > swap back more from the slower tier.
> >
> > e.g. you have two pages. Swap entry A will get 2 swap faults, the swap
> > entry B will get 20 swap faults in the next 2 hours. B is hotter than
> > A. Let's say you have to store them one in zswap and the other in hdd.
> > Which one should you store in faster zswap? Obvious swap entry B.
> >
> > It will cause more problems when you flush the data to the lower tier.
> > You want to flush the coldest data first. Please read about the
> > history of zswap write back and what LRU problem it encountered. The
> > most recent zswap storing the incompressible pages series in the mail
> > list precisely driven by preserving the swap entry LRU order reason.
> >
> > You really should consider the effect on swap entry LRU ordering
> > before you design the per cgroup swap priority.
>
> Then I would like to ask a fundamental question about priority. Priority =
is
> a user interface, and the user has the choice. From the beginning, when t=
he
> user sets priorities, there could be a scenario where the slower swap is

The Priority is just the global swap file ordering. Higher priority
use that swap device first.

> given a higher priority and the faster swap is given a lower one. That is
> possible. For example, if the faster device has a short lifetime, a real
> use case might be to consume the slower swap first for endurance, and onl=
y
> use the faster swap when unavoidable.

The idea of matching the faster swap with higher priority is just a
strategy to get better performance. It does not mean the priority =3D=3D
device speed.
If the user wants  to choose another priority strategy, maybe slower
performance, that is OK. They will get what they ask for.
We as  the kernel developer design the system as simply as possible to
achieve the good performance. Basically allow the good strategy to
happen easily. I wouldn't go overboard to change the meaning of
priority.

> In this case, logically from the LRU perspective there is no inversion of
> priority order, but in practice the slower device is filled first. That
> looks like degradation from a performance perspective =E2=80=94 but it is=
 exactly
> what the user intended.

You touch on a very good point. How to mix the global order and the
per memcg order.

> The swap tier concept appears to map priority semantics directly to servi=
ce
> speed, so that higher priority always means faster service. This looks li=
ke
> it enforces the choice on the user(but it is opend).

Yes, and no. We should allow the better performance strategy to happen
easily while maintaining the code complexity low. That is what I am
trying to do here.

> Even with swap tiers, under the semantics you suggested, it is possible f=
or
> a given cgroup to use only the slower tier. From that cgroup=E2=80=99s vi=
ew there
> is no LRU inversion, but since the fast swap exists and is left unused, i=
t
> could still be seen as an "inverse" in terms of usage.

Yes, if you put all the fast tier in one group. It needs to be
discussed case by case. That is exactly what I am asking for, what is
your usage case in mind that demands the per cgroup priority. We can
analyze the usage case and come up with creative solutions before we
jump to the conclusion. You can, for example, have divided the swap
space into two groups. A1 & A2 are both fast tiers. B1 & B2 are both
slow tiers. The one always follows to fill up A to B order using the
A1 and B1 group. The one wants to fill up the B first then A uses the
A2 and B2 group. 1 and 2 groups never mix. Then you can still maintain
LRU order when B2 fills up and starts to use A2, it will not upset the
A1 LRU because they are different swap devices on different groups.

If you give a more detailed usage situation, what challenge it faces.
I can give a more detailed solution using per cgroup priority vs
swap.tiers. That is why your usage case and reason is important.

> In summary, what I struggle to understand is that if the major assumption
> is that swap operation must always align with service speed, then even sw=
ap
> tiers can contradict it (since users may deliberately prefer the lower
> tier). In that case, wouldn=E2=80=99t the whole concept of letting users =
select swap
> devices by priority itself also become a problem?

Yes, if you keep them in one group and mix them. See the above 1 & 2
group option.

>
> > > I mentioned already on this mail: what swap tiers cannot do is arbitr=
ary
> > > ordering. If ordering is fixed globally by tiers, some workloads that=
 want to
> > > consume slower swap devices first (and reserve faster devices as a sa=
fety
> > > backend to minimize swap failures) cannot be expressed. This kind of =
policy
> > > requires arbitrary ordering flexibility, which is possible with per-d=
evice
> > > priorities but not with fixed tiers.
> >
> > Let's say you have fast tier A and slow tier B.
> >
> > Option 1) All swap entries go through the fast tier A first. As time
> > goes on, the colder swap entry will move to the end of the tier A LRU,
> > because there is no swap fault happening to those colder entries. If
> > you run out of space of  A, then you flush the end of the A to B. If
> > the swap fault does happen in the relative short period of time, it
> > will serve by the faster tier of A.
> >
> > That is a win compared to your proposal you want directly to go to B,
> > with more swap faults will be served by B compared to option 1).
> >
> > option 2) Just disable fast tier A in the beginning, only use B until
> > B is full. At some point B is full, you want to enable fast tier A.
> > Then it should move the head LRU from B into A. That way it still
> > maintains the LRU order.
> >
> > option 1) seems better than 2) because it serves more swap faults from
> > faster tier A.
>
> Option 1 does not really align with the usage scenario I had in mind,
> since it starts from the fast swap. Option 2 fits partially, but requires
> controlling when to enable the fast tier once full, and handling LRU
> movement =E2=80=94 which adds complexity.

Why do you want to fill up the slower device first? You haven't
answered that question in detail. You are asking for a behavior
because you already determined you want this behavior. You need to go
deeper to the root cause why you want this behavior. What is your
ultimate goal? There might be other solutions addressing your ultimate
goal without using the behavior you choose.

> Your final suggestion of Option 1 seems consistent with your original
> objection: that the system design should fundamentally aim at performance
> improvement by making use of the fast swap first.

You did not give me a reason why option 1) violates your goal. I feel
that your goal is already fixated on the swap order. That is only the
solution of your thought process. You haven't shown us how you come to
that conclusion.

> > > And vswap possible usage: if we must consider vswap (assume we can se=
lect it
> > > like an individual swap device), where should it be mapped in the tie=
r model?
> > > (see https://lore.kernel.org/linux-mm/CAMgjq7BA_2-5iCvS-vp9ZEoG=3D1Dw=
HWYuVZOuH8DWH9wzdoC00g@mail.gmail.com/)
> >
> > The swap tires do not depend on vswap, you don't need to worry about th=
at now.
>
> I initially understood vswap could also be treated as an
> identity selectable in the unified swap framework. If that were the case,=
 I
> thought it would be hard to map vswap into the tier concept. Was that my
> misinterpretation?

Your series assumes adopting swap.tiers are likely to get in before
the vswap does. If that is the case, that problem is for vswap to
solve. Let's work on this incrementally one step at a time.

> > The per cgroup swap tiers integer bitmask is simpler than maintaining
> > a per cgroup order list. It might be the same complexity in your mind,
> > I do see swap tiers as the simpler one.
>
> I agree that from the perspective of implementing the main swap selection
> logic, tiers are simpler. Since arbitrary ordering is not allowed, a larg=
e
> part of the implementation complexity can indeed be reduced.

Exactly. We can start with this simple case and address the main
problem. If there is a special case we need to do the other order, we
can add them later. It makes sense to have a simple and clean solution
address the majority of the usage case first. The most common usage I
see is that, let latency sensitive jobs use faster tiers. Overflow to
a slower tier if necessary. The latency insensitive jobs just use the
slower tiers.

> Once again, thank you for your thoughtful comments and constructive feedb=
ack.

You are most welcome.


Chris

