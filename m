Return-Path: <cgroups+bounces-10047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D011B553D5
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA585C1866
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA2313278;
	Fri, 12 Sep 2025 15:39:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04483112D3
	for <cgroups@vger.kernel.org>; Fri, 12 Sep 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691570; cv=none; b=dI0pGjCVAy4f1HOYWaU4DpRYqw/OsI7kI3X2Nv99NapQkWPIWG1Gpuc5r5S2pSmqRWlv07blJsWDUxX4lZ2JJyrAzw1m8yBuxXJAuLKBP8M2ZcuurTs92+7bkXQ4nFWPY8Jlg+gXKbRtM2PugWBZjRABdPFO9zJvA+6lyiv7BfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691570; c=relaxed/simple;
	bh=QlYpP7d3l6pQnMel5vWkFjSrhSuXbfiulSpKqcZMvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V59/391rKlWutAk812GT9i2gwqSp/9LNdwDaCtOPiX7TnoL1m1sOmIm7EBdDKiaL2Ww9fUarOjqFxyZnA2LrTad+9AVVwR2PP2Jzr/nAndF/DAiqqOzJeVFWa9rn0W6ASbUVid5KRlNhA/qzekrQfVZ5sPLYr1g9hte+g5GPmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Sep 2025 00:39:19 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 13 Sep 2025 00:39:19 +0900
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
	Kairui Song <ryncsn@gmail.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aMQ+pzsINPPE8EQ6@yjaykim-PowerEdge-T330>
References: <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
 <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
 <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330>
 <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
 <aL3Dav4RLvtLliYC@yjaykim-PowerEdge-T330>
 <CAF8kJuPnaJi=aKFwEknoh-eNgUPoje29EiKApmaWur+GqBGc0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuPnaJi=aKFwEknoh-eNgUPoje29EiKApmaWur+GqBGc0g@mail.gmail.com>

Hello Chris Li :D

> On Sun, Sep 7, 2025 at 10:40 AM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > Hi, Chris Li
> >
> > Thank you for your thoughtful and quick feedback.
> >
> > > > If you remove the
> > > > swap tier. the range of that tier merges to the neighbour tier.  That
> > > > way you don't need to worry about the swap file already having an
> > > > entry in this tier you swap out.
> > >
> > > Should the configured mask simply be left as-is,
> > > even if (a) the same key is later reintroduced with a different order (e.g.,
> > > first → third), or (b) a merge causes the cgroup to use a lower tier it did not
> >
> > Let me clarify my concern with a concrete example.
> > Suppose:
> > 1. SSD → tier "A" (31–40), HDD → "B" (21–30), HDD2 → "C" (10–20), HDD3 → "D" (0–9)
> > 2. A cgroup uses tier "A"
> > 3. SSD is swapped off → tier "A" becomes a hole
>
> There is just no swap device in A. A still (31-40).

I implicitly meant that A would be removed. After step 3  SSD is swapped off, 
tier A would be REMOVED via the interface.

>
> > 4. Tier "D" is removed
> > 5. Tier "A" is reassigned to range (0–9)
> > 6. Then a cgroup configured with "A" cannot actually use "A" (0~9)
>
> That would require each cgroup to hold a reference count of A.
> So A can't be re-assign while having a cgroup using A. in 5.

Yes, exactly.
I also think cgroups should hold references.
If we only rely on swap devices for references, complexity decreases, but 
the issue I mentioned could still occur.

> > 7. Later a new tier "E" is added and assigned (31–40)
> > 8. A cgroup now configured with "E" refers to the same numeric range (31–40),
> >    but the meaning has changed compared to when it used "A".
>
> I consider the user reassigning the same tier name with different
> ranges is a user error. They want to shoot themself in the foot, we
> can't stop them. Maybe we shouldn't even try to stop them. It does not
> make sense to complicate things just to prevent users from doing
> nonsense things. It has no additional complexity cost, sure.

I also disagree with reassigning the same name.

Assuming no cgroup tier references exist, I was referring to a situation where 
"A" is removed and then reassigned.
In that case, the cgroup that originally specified "A" would be unable to 
reference its intended tier range.
If we align on holding cgroup references, the concern I raised would be 
cleanly resolved.

>
> >
> > This feels unintuitive. I would prefer invalidating the mask if the referenced
> > tier is removed, so stale references don't silently point to a different tier.
>
> If there is a life cycle of the invalidation? Forever does not seem to
> be good either. It will prevent user reuse the tier range even there
> is no cgroup referencing that before.
>
> If you want this kind of invalidation, I suggest just make a reference
> count on the "A", each cgroup that references "A" holds a reference
> count. It will be tricky to reference count the default on case
> though, basically every tier is reference counted.

Yes, I agree!

> > > I talked to Wei about swap tiers a bit. Add him to the CC as well. He
> > > made me realize that we need two level things in the cgroup
> > > "swap.tiers".
> > > ...
> > > For the operation, each tier will need two bits, including the
> > > default. One bit select this timer off, one bit select this tier on.
> > > e.g. we have 16 tiers including the default, then all 16 tiers take up 32 bits.
> >
> > My understanding is:
> >
> > Per tier (2-bit state)
> > - `+` → always on (bit 10)
> > - `-` → always off (bit 01)
> > - missing → inherit from parent (bit 00)
> > - `11` is invalid
>
> Right.
>
> >
> > Default tier
> > - `+` means inherit parent as the base
> > - `-` means start from zero (ignore parent)
> > - missing means (this is the part I want to confirm) nothing?
>
> + means override default to "on" for all, allow every tier. (starting
> for every tier)
> - means override default to "off" for all. disallow every tier.
> (starting from zero)

Ack.
So for the missing case, is it "nothing"? 
Isn't it that we inherit from the parent and then incrementally add or 
remove from there?

> > So in my view "default" is an **inheritance control knob**, whereas in your
> > explanation "default" is also a **special tier** with its own 2-bit state.
> > Is that the right reading?
>
> It is a knob to override all. Yes it is a special tier wild cast. If
> the tier was not mentioned using +tier_name or -tier_name, the tier
> uses the default on/off value. If a tier has more than one on/off
> operation, the last write wins (closer to the leaf node cgroup) wins.
>
> Therefore, if the cgroup has default override was set, there is no
> need to lookup the parent any more, it overrides every tier already.
> That provides a way for the child cgroup to overwrite all parent swap
> tiers selection.
>
> >
> > If my understanding is correct, I'm also happy to adopt the interface format
> > you proposed.
> >
> > Over the weekend I kept thinking about it, and your proposal looks like a
> > more flexible interface. It also has clear similarities to how cgroup
> > controllers are added, so the format seems acceptable to me.
>
> It is more flexible and I have a simple way to perform the parent
> lookup on/off evaluation with short cuts. I send that out in the other
> email.

Ack. Thank you once again for the detailed pseudo-code proposal.

> > I have one remaining concern about cgroup semantics.
> > The inheritance and resource model we're discussing seems to diverge
> > somewhat from existing cgroup v2 conventions. Since we've aligned that
> > this effectively acts as QoS control, it also makes me wonder whether we
> > should proactively propose a doc update to the "Resource Distribution
> > Models" section so the concept is explicitly covered. This may be me
> > being overcautious, so I'd appreciate your view.
>
> More documents is better. Yes it diverges from the existing V2
> convention as the parent contains the child. QoS is a policy, it is
> relative indpendent of parents, unlike the containing relationship.

Yes, I'll think about this more and share if I have something clearer to 
discuss.

> > > Wei also raises one very important point. Because zswap is not tight
> > > to a swap device. We might want a predefined tier bit to describe
> > > zswap. e.g. the first tier bit is always given to zswap and the tier
> > > name is always zswap, the priority range can be assigned from
> > > mm/swap/tiers interface.
> >
> > Ack. Reserving a predefined tier bit for zswap makes sense.
> >
> > As a passing thought (not a strong proposal): a few common tiers (e.g., zswap,
> > ssd, hdd, remote) could be predefined and non-removable, with users inserting
> > custom ranges between or apart from them. For example, if an SSD tier is
> > predefined, `swapon` for SSD devices could be limited to that tier—this would
> > align with grouping by service speed and nudge users toward sensible configs.
>
> Then we will need to assign a fixed default range for them thus might
> make this more complex when people actually define their own tiers.
> I think the kernel should avoid making any default scheme on the user
> space swap tiers. Just like the software that manages the cgroup
> controls it.
>
> There are other complications. e.g. I have priority 3: first SSD drive
> 1, then priority 2: HDD, then priority 1: SSD driver 2.
> Pre-configured SSD tier will not be able to describe this, the first
> and third drive in the list is SSD. It create conflict in ordering. I
> think it is best to avoid defining any customer definable tier.

Ack. Thank you for your thoughts.

> > > > * **Tier specification**
> > > >   - Priority >= 0 range is divided into intervals, each identified by a
> > > >     tier name. The full 0+ range must be covered.
> > >
> > > Not necessarily true if we allow removal of the tier and generate
> > > holes removed range as we discussed above. Unless I understand the
> > > previous hole idea incorrectly.
> >
> > Ack. I prefer allowing holes, so we don't need to enforce covering the full
> > range simply.
> > (I had considered usage making full-range coverage coexist with holes,
> > but on reflection that doesn't seem necessary. complicated)
>
> Ack.

I'm reconsidering this part.

Previously, I thought about holes because we weren't holding cgroup's tier
references.
If there's no swap device but a cgroup references a tier, and we remove 
that tier and let it merge, it would be very confusing for the cgroup 
holding the reference. They implicitly uses other tier's the swap devices
(That's why I proposed cgroup mask invalidation + holes.)

If cgroups hold tier references, suppose a specific assigned middle tier 
disappears.
Then, merging this tier seems more natural.
Since no swap device or cgroup is using the disappearing tier, merging 
the tier's priority itself shouldn't be problematic.
From the perspective of the tier being merged into, since there are no 
swap devices in the merging tier, it won't end up using unintended swap 
devices, so it shouldn't be an issue.

So I'm thinking maybe we should go back to full range coverage + tier 
merge.

>
> Great.
>
> More agreement now.

Yes, we seem to agree on most things.
Thank you again for the review!

Best Regards
Youngjun Park

