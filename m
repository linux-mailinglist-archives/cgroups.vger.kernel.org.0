Return-Path: <cgroups+bounces-9842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10CB509D2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8A3B2E48
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DF3987D;
	Wed, 10 Sep 2025 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plZorGeo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DF33086
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463304; cv=none; b=r1ckX3ORPkW5ksHIBfUbBIvKgDCIFg06gjIOJ0AJUNK3sW3jrUtGWrQMFPxIzhYkn2KhjHbIBjmUgg+sJCwlnyNjuIls7F2SMwiNs7ihAurHMww2YkLjnUBzfrO91plICgMfTLZAQMbhHy9IaN/or1pYOw0/SO7S9Y2hQBNBnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463304; c=relaxed/simple;
	bh=2uVLhJlplgb89JbQ1bHQcmHQq2uVTcHCutoz8vCMPxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRCS24dzhfhZTqu7ZV137txHYCOtkNQF89BfrOCJmQawOKXu+cj2OB+TtfkBHNltdF3RWZReIZpMd4o2wv+laMo6FvfUU1vjnl3BSrUUB5L/5+32LiIdZKjsJRhBCUlKrXGlZCB6FRJW7gSFHGezXDS54prsnYGsedwn71vTN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plZorGeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225B9C4AF0B
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757463304;
	bh=2uVLhJlplgb89JbQ1bHQcmHQq2uVTcHCutoz8vCMPxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=plZorGeoPWo2T5EhgvhEq5wFluNA3gzovgxofLq8S/tbpEeMY13X5OpTR06vugk4L
	 M9OQpyM8sRmdC3RqjlD/N/yFuk7PqugyGiRu11QV9qpLbD9j4UhrJhgUBfDu+IkvFT
	 HG/l3yBxV98/QFFmF6AiIjPZm+tr+bGE7WMUm15BnHzW6g/RedKJzE8ajrzTL259ck
	 kqz+xMOptbF2e7PimrQueO9qy32oMMulx3b6ufEWFFhvcBheRpyZqHl6/1yoGyRSWP
	 eiAoV+RtySuRMj8sHqSPskGCMir6FXlBZLPIvxrdVpNr1LdwMtg3j8y3j4CH2uwvBp
	 HFKiOesMH+ghw==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so35395e9.0
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 17:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcLo/twTGhDUAGMwXxXCUiFtmmewMzEm2wAdBoVYGQWGTrWBA0Ve+Mhv3zFFHdwkarCkm8ej07@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPR1AzobswGrISX2/sYQwyl7G4c+xPebuqvjlWZFJjOgseLVa
	FzhKpi5WA2fIlU/wk5lX1QoDl5k6M5PPWaruPOjSdJchCLs2wO6h2bLR5g1DhPlBGCYNyOEWUO5
	3Wnq47E7qtsg1KYpV8m2ogDn1LlkV6c7YmDiKx4UP
X-Google-Smtp-Source: AGHT+IE+gORxRI4n+sJBerwONXQn7eJVE2j/M+YKqRRdaYDPhNkkE+0dgIwwzoUwnzwsuDSbg7hspHrV0zfkTUgJm94=
X-Received: by 2002:a05:600c:a59a:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45df74f82aemr519715e9.6.1757463302636; Tue, 09 Sep 2025
 17:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330> <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330> <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
 <aL3Dav4RLvtLliYC@yjaykim-PowerEdge-T330>
In-Reply-To: <aL3Dav4RLvtLliYC@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 17:14:51 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPnaJi=aKFwEknoh-eNgUPoje29EiKApmaWur+GqBGc0g@mail.gmail.com>
X-Gm-Features: AS18NWAK32hgWYeSFL1FKe9s338QbW5OndmA7PMxvUwghvs2UAWhM87vV_oYI2U
Message-ID: <CAF8kJuPnaJi=aKFwEknoh-eNgUPoje29EiKApmaWur+GqBGc0g@mail.gmail.com>
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
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 10:40=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> Hi, Chris Li
>
> Thank you for your thoughtful and quick feedback.
>
> > > If you remove the
> > > swap tier. the range of that tier merges to the neighbour tier.  That
> > > way you don't need to worry about the swap file already having an
> > > entry in this tier you swap out.
> >
> > Should the configured mask simply be left as-is,
> > even if (a) the same key is later reintroduced with a different order (=
e.g.,
> > first =E2=86=92 third), or (b) a merge causes the cgroup to use a lower=
 tier it did not
>
> Let me clarify my concern with a concrete example.
> Suppose:
> 1. SSD =E2=86=92 tier "A" (31=E2=80=9340), HDD =E2=86=92 "B" (21=E2=80=93=
30), HDD2 =E2=86=92 "C" (10=E2=80=9320), HDD3 =E2=86=92 "D" (0=E2=80=939)
> 2. A cgroup uses tier "A"
> 3. SSD is swapped off =E2=86=92 tier "A" becomes a hole

There is just no swap device in A. A still (31-40).


> 4. Tier "D" is removed
> 5. Tier "A" is reassigned to range (0=E2=80=939)
> 6. Then a cgroup configured with "A" cannot actually use "A" (0~9)

That would require each cgroup to hold a reference count of A.
So A can't be re-assign while having a cgroup using A. in 5.

> 7. Later a new tier "E" is added and assigned (31=E2=80=9340)
> 8. A cgroup now configured with "E" refers to the same numeric range (31=
=E2=80=9340),
>    but the meaning has changed compared to when it used "A".

I consider the user reassigning the same tier name with different
ranges is a user error. They want to shoot themself in the foot, we
can't stop them. Maybe we shouldn't even try to stop them. It does not
make sense to complicate things just to prevent users from doing
nonsense things. It has no additional complexity cost, sure.

>
> This feels unintuitive. I would prefer invalidating the mask if the refer=
enced
> tier is removed, so stale references don=E2=80=99t silently point to a di=
fferent tier.

If there is a life cycle of the invalidation? Forever does not seem to
be good either. It will prevent user reuse the tier range even there
is no cgroup referencing that before.

If you want this kind of invalidation, I suggest just make a reference
count on the "A", each cgroup that references "A" holds a reference
count. It will be tricky to reference count the default on case
though, basically every tier is reference counted.

> > I think my intention may not have come across clearly. I was not trying
> > to propose a new optimization, but to describe a direction that require=
s
> > almost no changes from the current behavior. Looking back, I realize th=
e
> > ideas I presented may not have looked like small adjustments, even
> > though that was my intent.
> >
> > I see. We don't need to jump to implementation details yet. I can help
> > you resolve the swap allocator internals as well. Let's have the
> > user's visible behavior settle down first.
>
> Ack. Let=E2=80=99s settle user-visible semantics first and defer allocato=
r internals.
> We can revisit per-CPU cluster cache handling as a lower-priority topic w=
hen we
> move to patchwork.

Ack.

>
> > I talked to Wei about swap tiers a bit. Add him to the CC as well. He
> > made me realize that we need two level things in the cgroup
> > "swap.tiers".
> > ...
> > For the operation, each tier will need two bits, including the
> > default. One bit select this timer off, one bit select this tier on.
> > e.g. we have 16 tiers including the default, then all 16 tiers take up =
32 bits.
>
> My understanding is:
>
> Per tier (2-bit state)
> - `+` =E2=86=92 always on (bit 10)
> - `-` =E2=86=92 always off (bit 01)
> - missing =E2=86=92 inherit from parent (bit 00)
> - `11` is invalid

Right.

>
> Default tier
> - `+` means inherit parent as the base
> - `-` means start from zero (ignore parent)
> - missing means (this is the part I want to confirm) nothing?

+ means override default to "on" for all, allow every tier. (starting
for every tier)
- means override default to "off" for all. disallow every tier.
(starting from zero)

> So in my view =E2=80=9Cdefault=E2=80=9D is an **inheritance control knob*=
*, whereas in your
> explanation =E2=80=9Cdefault=E2=80=9D is also a **special tier** with its=
 own 2-bit state.
> Is that the right reading?

It is a knob to override all. Yes it is a special tier wild cast. If
the tier was not mentioned using +tier_name or -tier_name, the tier
uses the default on/off value. If a tier has more than one on/off
operation, the last write wins (closer to the leaf node cgroup) wins.

Therefore, if the cgroup has default override was set, there is no
need to lookup the parent any more, it overrides every tier already.
That provides a way for the child cgroup to overwrite all parent swap
tiers selection.

>
> If my understanding is correct, I=E2=80=99m also happy to adopt the inter=
face format
> you proposed.
>
> Over the weekend I kept thinking about it, and your proposal looks like a
> more flexible interface. It also has clear similarities to how cgroup
> controllers are added, so the format seems acceptable to me.

It is more flexible and I have a simple way to perform the parent
lookup on/off evaluation with short cuts. I send that out in the other
email.


> I have one remaining concern about cgroup semantics.
> The inheritance and resource model we=E2=80=99re discussing seems to dive=
rge
> somewhat from existing cgroup v2 conventions. Since we=E2=80=99ve aligned=
 that
> this effectively acts as QoS control, it also makes me wonder whether we
> should proactively propose a doc update to the =E2=80=9CResource Distribu=
tion
> Models=E2=80=9D section so the concept is explicitly covered. This may be=
 me
> being overcautious, so I=E2=80=99d appreciate your view.

More documents is better. Yes it diverges from the existing V2
convention as the parent contains the child. QoS is a policy, it is
relative indpendent of parents, unlike the containing relationship.

> > Wei also raises one very important point. Because zswap is not tight
> > to a swap device. We might want a predefined tier bit to describe
> > zswap. e.g. the first tier bit is always given to zswap and the tier
> > name is always zswap, the priority range can be assigned from
> > mm/swap/tiers interface.
>
> Ack. Reserving a predefined tier bit for zswap makes sense.
>
> As a passing thought (not a strong proposal): a few common tiers (e.g., z=
swap,
> ssd, hdd, remote) could be predefined and non-removable, with users inser=
ting
> custom ranges between or apart from them. For example, if an SSD tier is
> predefined, `swapon` for SSD devices could be limited to that tier=E2=80=
=94this would
> align with grouping by service speed and nudge users toward sensible conf=
igs.

Then we will need to assign a fixed default range for them thus might
make this more complex when people actually define their own tiers.
I think the kernel should avoid making any default scheme on the user
space swap tiers. Just like the software that manages the cgroup
controls it.

There are other complications. e.g. I have priority 3: first SSD drive
1, then priority 2: HDD, then priority 1: SSD driver 2.
Pre-configured SSD tier will not be able to describe this, the first
and third drive in the list is SSD. It create conflict in ordering. I
think it is best to avoid defining any customer definable tier.

> > > * **Tier specification**
> > >   - Priority >=3D 0 range is divided into intervals, each identified =
by a
> > >     tier name. The full 0+ range must be covered.
> >
> > Not necessarily true if we allow removal of the tier and generate
> > holes removed range as we discussed above. Unless I understand the
> > previous hole idea incorrectly.
>
> Ack. I prefer allowing holes, so we don=E2=80=99t need to enforce coverin=
g the full
> range simply.
> (I had considered usage making full-range coverage coexist with holes,
> but on reflection that doesn=E2=80=99t seem necessary. complicated)

Ack.

>
> > >   - Each tier has an order (tier1 is highest priority) and an interna=
l
> >
> > The order you mean swap device priority order or the tier internal bit =
order?
>
> I meant the order implied by the priority ranges. In the interface I sugg=
ested,
> the `-` operator specifies ordered ranges, so a notion of tier order matt=
ers.
> With your format this may not be needed or not that important.

I see. the '-' you mean the '-' between two tiers. The leading '-'
will mean "off".

> > >   - Until it is set, there is no default tier.
> >
> > Does that mean you can't do incremental add or incremental subtract tie=
rs?
>
> > >     (may internally conceptually used? but not exported)
> >
> > My suggestion now is "swap.tiers" is an operation rather than a
> > bitmask. It can include "default", Each tier can select on or off or
> > missing so 3 operation states. "default" tier has no name, if
> > specified, must be listed as the first in "swap.tiers"
>
> When I said =E2=80=9Cdefault tier,=E2=80=9D I meant a conceptual tier tha=
t covers the full
> priority range when nothing is specified. From your reply, your =E2=80=9C=
default=E2=80=9D
> sounds closer to a *default value* (inheritance control) rather than a
> standalone tier. Did I get that right?

It is the wild cast tier that controls on/off  for tier names that
haven't been mentioned with "+/-" "on/off" operation.
e.g.:
"- +ssd -hdd", that means default is off, turn on ssd and turn off hdd
(don't need to say that, default is already off).
But if there is also a zswap tier, it is not in the on/off operation
list. It is default to off because the leading "-".

> > >     Note: a space must follow "+" or "-" before the tier name.
> > >   - Edge cases:
> > >       * If not all ranges are specified: input is accepted, but cgrou=
ps
> > >         cannot use incomplete ranges. (TBD)
> > >         e.g) echo "hdd:50" > /sys/kernel/mm/swap/tiers. (0~49 not spe=
cifeid)
> >
> > Because removing the tier will generate holes in the priority range
> > anyway. 0-49 is not specified in the same as if a tier is there
> > previously then gets removed.
>
> As discussed above, we=E2=80=99re allowing holes, so we can accept inputs=
 that don=E2=80=99t
> cover the full range.
>
> > >       * Overlap with existing range: removal fails until all swap
> > >         devices in that range are swapped off.
> >
> > Specifically a new tier priority landing in the middle of a tier
> > range, the new tier will split the range with the existing one.
>
> If swapoff is complete but removal has not occurred and a new tier comes =
in,
> we can allow splitting. If a tier reference is still held, splitting shou=
ld not
> be allowed. A corner case: a tier spans 50=E2=80=93100 but only prioritie=
s 55 and 60
> have active swap; inserting a split at 70 (no active refs) =E2=80=94 to k=
eep rules
> simple, I=E2=80=99d still **not** accept the split while any references e=
xist anywhere
> in the original range.

In that case you want refcount the tiers by cgroup that reference it.
I am open to suggestion, I haven't give this too deep thought.

>
> > > * **Cgroup interface**
> > >   - New files (under memcg): memory.swap.tier, memory.swap.tier.effec=
tive
> >
> > I don't think we need two interface files. We can live with one just
> > "memory.swap.tiers"
> > We can list the local one first then effective one on the second line
> > or separate with "#"
>
> Ack. One file is simpler; show local then effective. For now, a newline
> separator looks clearer than =E2=80=9C#=E2=80=9D.

Ack.

>
> > >   - Syntax modeled after cpuset:
> > >       echo "ssd-hdd,net" > memory.swap.tier
> >
> > Need discussion for incremental subtract. That syntax is incremental ad=
d.
>
> I think the format you suggest (+, -)
> is appropriate from a flexibility perspective.

Ack, thank you.

>
> > > * **Swap allocation**
> > >   - Simple, workable implementation (TBD; to be revisited with
> > >     measurements).
>
> Ack.

Great.

More agreement now.

Chris

