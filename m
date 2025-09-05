Return-Path: <cgroups+bounces-9721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FCDB44DF4
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 08:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2251C23FBD
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9C28D8E8;
	Fri,  5 Sep 2025 06:30:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBA1DA60F
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053853; cv=none; b=ijJys86Wxl2LtfQGEnaPbIPzWEf8T6kBr8mnbaghVQdSJhBliNtzQ6mgc0MGPtIe+/7hR2Rtuz+6WvcWsVdfRnIMcEZVQ9bcrIuyiOcXmVAO+qn2JnUNIe4qODWfLS360vaDNK9LXp3YWUMNxah7C/KzvPyTytc1zjoME0Aobnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053853; c=relaxed/simple;
	bh=iXAyYs38ed5hZ71z4u1jPBV+remIZ+GjM5oilrzVLkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFHLo8eUuzC48dPzCRjYOoT/WmuQm0Ybxmoy0X225SfulAzLulan4naJSNZibcP9m6ZNzkYiXWiwELymQPkUvy+BUb4HosCUF6FFV3K224nW6wCdu3C1w2xTrOAlxcBOMazBQ2VS//CFA8mY10k++Ca87GVAsrA6OviYESHfqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 5 Sep 2025 15:30:42 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 5 Sep 2025 15:30:42 +0900
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
Message-ID: <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330>
References: <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
 <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
 <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
 <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
 <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>

> Yes, that works. I would skip the "add" keyword.
> Also I notice that we can allow " " in place of "," as a separator as well.

Yes, supporting both " " and "," sounds convenient.

> Maybe instead of "remove hdd", just "-hdd" which is similar to how to
> operate on swap.tiers.

Agreed, "+" for add and "-" for remove is simpler.

> Oh, you mean the tier not listed in the above will be deleted.
> I prefer the above option 1) then.

That makes sense. Option 1) looks simplest overall.

> I don't understand what is this "removing" and "in stage"...
> What is it trying to solve?

That came from an idea to pre-add a new tier before removing another.
But I now think returning an error on overlap is simpler, so staging is
not needed.

> What do you mean by "visible"? Previous discussions haven't defined
> what is visible vs invisible.

By “visible” I meant a staged state becoming active. I realize the term
was confusing. and it is not needed as I already explained.

> Trigger event to notify user space? Who consumes the event and what
> can that user space tool do?

I agree, sending user events is unnecessary. It is simpler to let tiers merge or
be recreated and let the allocator handle it.

> If you remove the
> swap tier. the range of that tier merges to the neighbour tier.  That
> way you don't need to worry about the swap file already having an
> entry in this tier you swap out.

Should the configured mask simply be left as-is,
even if (a) the same key is later reintroduced with a different order (e.g.,
first → third), or (b) a merge causes the cgroup to use a lower tier it did not
explicitly select? 
I infer that leaving the mask unchanged is acceptable and this concern
may be unnecessary. if you consider this unnecessary, I am fine
to follow the simpler direction you suggested.

> If the fast path fails, it will go through the slow path. So the slow
> path is actually a catch all.

I think my intention may not have come across clearly. I was not trying
to propose a new optimization, but to describe a direction that requires
almost no changes from the current behavior. Looking back, I realize the
ideas I presented may not have looked like small adjustments, even
though that was my intent.

As a simple approach I had in mind:
- Fastpath can just skip clusters outside the selected tier.
- Slowpath naturally respects the tier bitmask.
- The open point is how to treat the per-CPU cache.

If we insert clusters back, tiered and non-tiered cgroups may see
low-priority clusters. If we skip insertion, tiered cgroups may lose
caching benefits.

Chris, do you have another workable approach in mind here, or is this
close to what you were also thinking?

> In my original proposal, if a parent removes ssd then the child will
> automatically get it as well.

I now see you mean the effective mask is built by walking parents with local
settings taking precedence, top to bottom, preferring the nearest local
setting. Conceptually this yields two data structures: a local-setting mask and
a runtime/effective mask. Does the above capture your intention, or is there
anything else I should mention?

A few thoughts aligned with the above:
- There is no separate “default setting” knob to control inheritance.
- If unset locally, the effective value is derived by walking the cgroup
  hierarchy from top to bottom.
- Once set locally, the local setting overrides everything inherited.
- There is no special “default tier” when tiers are absent.
- If nothing is set anywhere in the hierarchy, the initial mask is treated as
  fully set at configuration time (selecting all tiers; global swap behavior).
  However, reading the local file should return an empty value to indicate
  “not set”.

One idea is to precompute the effective mask at interface write time, since
writes are rarer than swap I/O. You may have intended runtime recomputation
instead—which approach do you prefer? This implies two masks: a local
configuration mask and a computed effective mask.

And below is a spec summary I drafted, based on our discussion so far for
note and alignment. 
(Some points in this reply remain unresolved, and there are additional TBD items.)

* **Tier specification**
  - Priority >= 0 range is divided into intervals, each identified by a
    tier name. The full 0+ range must be covered.
  - NUMA autobind and tiering are mutually exclusive.
  - Max number of tiers = MAX_SWAPFILES (single swap device can also be
    assigned as a tier).
  - A tier holds references when swap devices are assigned to its
    priority range. Removal is only possible after swapoff clears the
    references.
  - Cgroups referencing a tier do not hold references. If the tier is
    removed, the cgroup’s configured mask is dropped. (TBD)
  - Each tier has an order (tier1 is highest priority) and an internal
    bit for allocation logic.
  - Until it is set, there is no default tier. 
    (may internally conceptually used? but not exported)

* **/sys/kernel/mm/swap/tiers**
  - Read/write interface. Multiple entries allowed, delimiters: space or
    comma.
  - Format:
      + "tier name":priority  → add (priority and above)
      - "tier name"           → remove
    Note: a space must follow "+" or "-" before the tier name.
  - Edge cases:
      * If not all ranges are specified: input is accepted, but cgroups
        cannot use incomplete ranges. (TBD)
	e.g) echo "hdd:50" > /sys/kernel/mm/swap/tiers. (0~49 not specifeid)
      * Overlap with existing range: removal fails until all swap
        devices in that range are swapped off.
  - Output is sorted, showing tier order along with name, bit, and
    priority range. (It may be more user-friendly to explicitly show
    tier order. (TBD))

* **Cgroup interface**
  - New files (under memcg): memory.swap.tier, memory.swap.tier.effective
    * Read/write: memory.swap.tier returns the local named set exactly
      as configured (cpuset-like "+/-" tokens; space/comma preserved).
    * Read-only: memory.swap.tier.effective is computed from the cgroup
      hierarchy, with the nearest local setting taking precedence
      (similar to cpuset.effective). (TBD)
    * Example (named-set display, cpuset-like style)

      Suppose tier order:
        ssd (tier1), hdd (tier2), hdd2 (tier3), net (tier4)

      Input:
        echo "ssd-hdd, net" > memory.swap.tier

      Readback:
        cat memory.swap.tier
          ssd-hdd, net     # exactly as configured (named set)

        cat memory.swap.tier.effective
          ssd-hdd, net     # same format; inherited/effective result

  - Inheritance: effective mask built by walking from parent to child,
    with local settings taking precedence.
  - Mask computation: precompute at interface write-time vs runtime
    recomputation. (TBD; preference?)
  - Syntax modeled after cpuset:
      echo "ssd-hdd,net" > memory.swap.tier
    Here “-” specifies a range and must respect tier order. Items
    separated by “,” do not need to follow order and may overlap; they
    are handled appropriately (similar to cpuset semantics).

* **Swap allocation**
  - Simple, workable implementation (TBD; to be revisited with
    measurements).

I tried to summarize the discussion and my inline responses as clearly as
possible. If anything is unclear or I misinterpreted something, please
tell me and I’ll follow up promptly to clarify. If you have comments, I
will be happy to continue the discussion. Hopefully this time our
alignment will be clearer.

Best regards,
Youngjun Park

