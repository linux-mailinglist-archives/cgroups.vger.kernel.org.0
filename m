Return-Path: <cgroups+bounces-9765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF1B4674D
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 01:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0DD7B226E
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52801A9F82;
	Fri,  5 Sep 2025 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9UeiWT7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A16BA4A
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115962; cv=none; b=ZQJMQYEIhCtWfuIpgxGiP3+/gqSi6qK3RR8+4gmqo9VyMSAwE+l1WyrMxSQxSstIVHaRgMVKTY7RDc4AhxlngYGu5IU6QY4trA2N4Ex3P7aHkCcwlrQVBheFpGa2B3WlZb7gi664Tl+rZrK7fa3cWwePqFtKI2SxQ6dFQHIeBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115962; c=relaxed/simple;
	bh=zXqNohIJ1dL5P65i8pty3P3f/0+3nm3CYqBdYwi+Eiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOJzBhvzZhgTrpR8LJ6w8etdcOaLmzgHdyOXyMra/x/oICfdbZHZQdhDgASfwDog1suwv7aRA7SWyYSWwjqr6BdKzejaAPnNtHRjm+6xrCABXngY/amPCYbD+QMpQ+7WeY6R1rVcV6vzsL6nHoSEf48S6AiMpVZUHLgID/oXDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9UeiWT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C97C4CEFB
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115962;
	bh=zXqNohIJ1dL5P65i8pty3P3f/0+3nm3CYqBdYwi+Eiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V9UeiWT7a3rertJj4XY1EhP9h8fR64Rrza7I8sy+cmFG2q9py/NzW8xcg6BmW2Nft
	 mTOHQztpBPR44qWpJHqcweKifpkmaojUqArsOoxB/ns762wwufafrLw8O9M7cLmhl+
	 MO6JV5ujXZQkXcHzKtYCnzm5xB0uZ9d/VtbNE25T2lkHnEKq5cUkCt+x6/fhrqOsRv
	 WKnKviiH5XoDTNXAdvxNInipaLSPPzNJSV6kPh3JnvV7HXkWMvUMjUdyWjbMRqVoS4
	 +jhBRF9Wfa6o93subFwv0XDzxajxukO6ovTOWHU9eHdj0CLuIQ/D7BW6wcoZVpuB+n
	 xznlVd/nEgq5w==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so28135e9.0
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 16:46:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLmrCg0xFQLHxyxYq/u6SPTRCMBrHvtUdQuP3Tjh5q5+k+n/rKxVsh9fuGR50vJWMKxse4H/tb@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6o2k9Kg37/16a+H55y0gmot3QBi1jmqDGVL405Dx/vWleCgk
	QBroXc6wJgHqE10wBa2CspYYPalPSs7hUep+YhTyPr2c4+pDLiPsFGZHQUXbfuYgOeC4FqX0uva
	tbqEIG9Sl+xXoLYFyXs9kfg7pdDZWJ7isLqq0aeSf
X-Google-Smtp-Source: AGHT+IHFEBMIsi5MrtRcGdq9hoDsiULLBoI3XaBc2RJeZ7zpvvmLW8mr74ycrYbukebT+vEmsG0mOxtcJQ1aqRhFJKY=
X-Received: by 2002:a05:600c:a408:b0:45b:7d8f:4bd4 with SMTP id
 5b1f17b1804b1-45dddad7944mr471065e9.4.1757115960274; Fri, 05 Sep 2025
 16:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330> <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330>
In-Reply-To: <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 16:45:48 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
X-Gm-Features: Ac12FXzV1gsLBVEgGHywni-KyXL7Dk-qXpPbPBljTzv3lMg18XUf0ZsoyULLQz0
Message-ID: <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
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

Sorry I was busy with some work related tasks and haven't got a chance
to reply to your last email.

On Thu, Sep 4, 2025 at 11:30=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> > Yes, that works. I would skip the "add" keyword.
> > Also I notice that we can allow " " in place of "," as a separator as w=
ell.
>
> Yes, supporting both " " and "," sounds convenient.

Ack.

>
> > Maybe instead of "remove hdd", just "-hdd" which is similar to how to
> > operate on swap.tiers.
>
> Agreed, "+" for add and "-" for remove is simpler.

Ack.

>
> > Oh, you mean the tier not listed in the above will be deleted.
> > I prefer the above option 1) then.
>
> That makes sense. Option 1) looks simplest overall.

Ack.

>
> > I don't understand what is this "removing" and "in stage"...
> > What is it trying to solve?
>
> That came from an idea to pre-add a new tier before removing another.
> But I now think returning an error on overlap is simpler, so staging is
> not needed.

Ack.

> > What do you mean by "visible"? Previous discussions haven't defined
> > what is visible vs invisible.
>
> By =E2=80=9Cvisible=E2=80=9D I meant a staged state becoming active. I re=
alize the term
> was confusing. and it is not needed as I already explained.

Ack.

> > Trigger event to notify user space? Who consumes the event and what
> > can that user space tool do?
>
> I agree, sending user events is unnecessary. It is simpler to let tiers m=
erge or
> be recreated and let the allocator handle it.

Ack.

> > If you remove the
> > swap tier. the range of that tier merges to the neighbour tier.  That
> > way you don't need to worry about the swap file already having an
> > entry in this tier you swap out.
>
> Should the configured mask simply be left as-is,
> even if (a) the same key is later reintroduced with a different order (e.=
g.,
> first =E2=86=92 third), or (b) a merge causes the cgroup to use a lower t=
ier it did not
Can you elaborate a)? I am not sure I understand it correctly.

Let's say we have 4 tier bit, firs two is default on/off.

bit 1: overwrite default on. bit 2: overwrite default off, bit3: zram
on, bit4, zram off

In this example, if we delete zram  how does the mask leave as it is
and follow a)?
I suspect you create a hole in the priority range and make swap
devices in that range not selectable.

> explicitly select?
> I infer that leaving the mask unchanged is acceptable and this concern
> may be unnecessary. if you consider this unnecessary, I am fine
> to follow the simpler direction you suggested.

We can leave them unassign as well. So after delete we have a hole in
the priority range. The swap device in that hole will not get more
swap out written to it, because it is not selectable from the
"swap.tiers". However the swap in can still happen on that device
until the device is swapped off. That sounds fine to me. I actually
like that better. Thank you for the suggestion.

> > If the fast path fails, it will go through the slow path. So the slow
> > path is actually a catch all.
>
> I think my intention may not have come across clearly. I was not trying
> to propose a new optimization, but to describe a direction that requires
> almost no changes from the current behavior. Looking back, I realize the
> ideas I presented may not have looked like small adjustments, even
> though that was my intent.

I see. We don't need to jump to implementation details yet. I can help
you resolve the swap allocator internals as well. Let's have the
user's visible behavior settle down first.

> As a simple approach I had in mind:
> - Fastpath can just skip clusters outside the selected tier.

That part will need to hack the current swap allocator regarding per
cpu cached swap.

> - Slowpath naturally respects the tier bitmask.

Ack.

> - The open point is how to treat the per-CPU cache.

That is what I consider the fast path modification in the swap cluster
based allocator. Let me think about it a bit. On the other hand, we
don't need to worry too much about the internals right now. We get the
effective tier selection bitmask and the swap cluster allocator just
honours it.

>
> If we insert clusters back, tiered and non-tiered cgroups may see
> low-priority clusters. If we skip insertion, tiered cgroups may lose
> caching benefits.

That is why I think the cluster cache which holds the current
allocation offset within a cluster might need to move to per swap tier
level or swap device level. Might be both.

> Chris, do you have another workable approach in mind here, or is this
> close to what you were also thinking?

I think this is close to what I am thinking, just some details haven't
ironed out.

> > In my original proposal, if a parent removes ssd then the child will
> > automatically get it as well.
>
> I now see you mean the effective mask is built by walking parents with lo=
cal
> settings taking precedence, top to bottom, preferring the nearest local
> setting. Conceptually this yields two data structures: a local-setting ma=
sk and
> a runtime/effective mask. Does the above capture your intention, or is th=
ere
> anything else I should mention?

I talked to Wei about swap tiers a bit. Add him to the CC as well. He
made me realize that we need two level things in the cgroup
"swap.tiers".
What we have discussed is the  "+ssd" with possible parent lookup
behavior is a kind of operation. The end result of the operation is a
tier bit set to indicate which tier is allowed in the swap out. The
end result tier netmask doenot need to have default, default is part
of the local operation selection. For the operation we also need two
bits per tier so we can specify on/off/missing.

For the operation, each tier will need two bits, including the
default. One bit select this timer off, one bit select this tier on.
e.g. we have 16 tiers including the default, then all 16 tiers take up 32 b=
its.

For example:
a/swap.tiers: "- +ssd" # default off, only allow ssd.
a/b/swap.tiers: "-ssd" # don't want ssd. the rest inherit the parent.

> A few thoughts aligned with the above:
> - There is no separate =E2=80=9Cdefault setting=E2=80=9D knob to control =
inheritance.

If there is no default knob. Every swap.tiers operation will need to
walk from the root to the current cgroup.
With default knob, the walk can terminate at the closest the parent
with the default overridden.

Also without default, how do you start with no swap then each child
has the option to add their own swap tiers?
That will force the parent to list and turn off each tier at the top
level memcg.

> - If unset locally, the effective value is derived by walking the cgroup
>   hierarchy from top to bottom.
Ack. In my mind, with or without local operation value, it needs to
walk the parent unless local has default override. Any local default
override will terminate the parent walking chain.

> - Once set locally, the local setting overrides everything inherited.
I need to think about that a bit. This is different from the original
inheritage appended from the parent operation syntax.
e.g. previously parent has "- +ssd" (nothing but ssd). child has
"+hdd", in the original proposal the effective is "- +ssd +hdd",
If you override the parent, then the child will become "- +hdd" (hdd
only). If the child wants to inherit the parent ssd behavior, it will
need to walk up the parent chain and set "- +ssd +hdd" instead of just
"+hdd".

It seems the append operation has the most flexible inherited
behavior, also more consistent. Need more discussion here.

> - There is no special =E2=80=9Cdefault tier=E2=80=9D when tiers are absen=
t.
If there is no default tier. Nothing is set in any of the
"swap.tiers", what is the behavior? Are all swap devices usable?
It seems we need the default in the swap.tiers operation. But the
final tier selection bitmask does not need default.

> - If nothing is set anywhere in the hierarchy, the initial mask is treate=
d as
>   fully set at configuration time (selecting all tiers; global swap behav=
ior).
>   However, reading the local file should return an empty value to indicat=
e
>   =E2=80=9Cnot set=E2=80=9D.

Seems a bit arbitrary. Global "" is all and local "" is nothing.

> One idea is to precompute the effective mask at interface write time, sin=
ce
> writes are rarer than swap I/O. You may have intended runtime recomputati=
on
> instead=E2=80=94which approach do you prefer? This implies two masks: a l=
ocal
> configuration mask and a computed effective mask.

We can have more discussion and give more examples here. I still like
the "- +ssd -zswap" as well as "+ -ssd -hdd", that kind of operation
syntax, which seems to have more consistent inherage story, more
flexible, and less make up rules. It can support incremental add as
well as incremental subtract. I can be convinced otherwise as well. We
just need to allow each tier to have two bits, one bit for off and one
bit for one.

Wei also raises one very important point. Because zswap is not tight
to a swap device. We might want a predefined tier bit to describe
zswap. e.g. the first tier bit is always given to zswap and the tier
name is always zswap, the priority range can be assigned from
mm/swap/tiers interface.

> And below is a spec summary I drafted, based on our discussion so far for
> note and alignment.
> (Some points in this reply remain unresolved, and there are additional TB=
D items.)
>
> * **Tier specification**
>   - Priority >=3D 0 range is divided into intervals, each identified by a
>     tier name. The full 0+ range must be covered.
Not necessarily true if we allow removal of the tier and generate
holes removed range as we discussed above. Unless I understand the
previous hole idea incorrectly.

>   - NUMA autobind and tiering are mutually exclusive.
For now. Ack.

>   - Max number of tiers =3D MAX_SWAPFILES (single swap device can also be
>     assigned as a tier).
That will make it a bit less than 32 tiers I think.

>   - A tier holds references when swap devices are assigned to its
>     priority range. Removal is only possible after swapoff clears the
>     references.

Ack.

>   - Cgroups referencing a tier do not hold references. If the tier is
>     removed, the cgroup=E2=80=99s configured mask is dropped. (TBD)

Ack the TBD part. That also means removing the tier from global tiers
list we will need to walk all cgroups and clear the tier bits to get
used. Because removing is a rare operation, maybe that is fine.

>   - Each tier has an order (tier1 is highest priority) and an internal
The order you mean swap device priority order or the tier internal bit orde=
r?
>     bit for allocation logic.
Ack the internal bit.

>   - Until it is set, there is no default tier.

Does that mean you can't do incremental add or incremental subtract tiers?

>     (may internally conceptually used? but not exported)

My suggestion now is "swap.tiers" is an operation rather than a
bitmask. It can include "default", Each tier can select on or off or
missing so 3 operation states. "default" tier has no name, if
specified, must be listed as the first in "swap.tiers"


> * **/sys/kernel/mm/swap/tiers**
>   - Read/write interface. Multiple entries allowed, delimiters: space or
>     comma.
>   - Format:
>       + "tier name":priority  =E2=86=92 add (priority and above)
>       - "tier name"           =E2=86=92 remove
Ack.

>     Note: a space must follow "+" or "-" before the tier name.
>   - Edge cases:
>       * If not all ranges are specified: input is accepted, but cgroups
>         cannot use incomplete ranges. (TBD)
>         e.g) echo "hdd:50" > /sys/kernel/mm/swap/tiers. (0~49 not specife=
id)
Because removing the tier will generate holes in the priority range
anyway. 0-49 is not specified in the same as if a tier is there
previously then gets removed.

>       * Overlap with existing range: removal fails until all swap
>         devices in that range are swapped off.
Specifically a new tier priority landing in the middle of a tier
range, the new tier will split the range with the existing one.

>   - Output is sorted, showing tier order along with name, bit, and
>     priority range. (It may be more user-friendly to explicitly show
>     tier order. (TBD))
Ack.

>
> * **Cgroup interface**
>   - New files (under memcg): memory.swap.tier, memory.swap.tier.effective

I don't think we need two interface files. We can live with one just
"memory.swap.tiers"
We can list the local one first then effective one on the second line
or separate with "#"

cat a/memory.swap.tiers # will show:
- +ssd # ssd
cat a/b/memory.swap.tiers  will show:
+hdd # ssd hdd.  The ssd is from the parent a/memory.swap.tiers.

>     * Read/write: memory.swap.tier returns the local named set exactly
>       as configured (cpuset-like "+/-" tokens; space/comma preserved).
Ack.

>     * Read-only: memory.swap.tier.effective is computed from the cgroup
>       hierarchy, with the nearest local setting taking precedence
>       (similar to cpuset.effective). (TBD)
I suggest that as the second line or after the "#" separator.

>     * Example (named-set display, cpuset-like style)
>
>       Suppose tier order:
>         ssd (tier1), hdd (tier2), hdd2 (tier3), net (tier4)
>
>       Input:
>         echo "ssd-hdd, net" > memory.swap.tier

Ah, that will only allow incremental add, how about incremental subtract?

>       Readback:
>         cat memory.swap.tier
>           ssd-hdd, net     # exactly as configured (named set)

I think it is hard to store the range. I was thinking about the locals
as each tier takes 2 bits, on/off.
In that case if we want the exactly as configured, we need to store
the original expression as well.
Can we show the +ssd -hdd kind of evaluated tier operation there.
Store the original range expression will have complications when
removing the tier. It is complicate to clear the tier from the
original range.
effectively split the range. I was hoping the local internal storage
is the already processed bits of on/off.
Need more discussion here.
>
>         cat memory.swap.tier.effective
>           ssd-hdd, net     # same format; inherited/effective result
You might just spell out all the tier by name. The inherited behavior
will make it different from local, then the same set will have
different expressions to output it, using range or not. Just spell out
the tiers set might be simpler.
This is for debugging only anyway.
Consider joining this with the "swap.iter" output with a separation by
new line or "#".

>   - Inheritance: effective mask built by walking from parent to child,
>     with local settings taking precedence.

I was thinking that the parent "swap.tiers" would be appended with the
child "swap.tiers". Only override when the child uses default on/off.
Need more discussion here.

>   - Mask computation: precompute at interface write-time vs runtime
>     recomputation. (TBD; preference?)

Let's start with runtime. We can have a runtime and cached with
generation numbers on the toplevel. Any change will reset the top
level general number then the next lookup will drop the cache value
and re-evaluate.

>   - Syntax modeled after cpuset:
>       echo "ssd-hdd,net" > memory.swap.tier
>     Here =E2=80=9C-=E2=80=9D specifies a range and must respect tier orde=
r. Items
>     separated by =E2=80=9C,=E2=80=9D do not need to follow order and may =
overlap; they
>     are handled appropriately (similar to cpuset semantics).

Need discussion for incremental subtract. That syntax is incremental add.


> * **Swap allocation**
>   - Simple, workable implementation (TBD; to be revisited with
>     measurements).

Ack.

>
> I tried to summarize the discussion and my inline responses as clearly as
> possible. If anything is unclear or I misinterpreted something, please
> tell me and I=E2=80=99ll follow up promptly to clarify. If you have comme=
nts, I
> will be happy to continue the discussion. Hopefully this time our
> alignment will be clearer.

Yes, I leave comments on the part I think needs more discussion.

Thanks for the great summary.

Chris

