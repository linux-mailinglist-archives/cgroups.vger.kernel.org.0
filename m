Return-Path: <cgroups+bounces-9272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE0B2BE99
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F76188BD7C
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A7322526;
	Tue, 19 Aug 2025 10:13:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACB320CA8
	for <cgroups@vger.kernel.org>; Tue, 19 Aug 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598388; cv=none; b=nJJOixvBlft2EBTgEQK4cq6OGQ1fJOYGGyzbqqgftjfWSqbWdTB8V0av+cU41bbmNyR7Xja4OS6Ho6qn9/JnCfKQGhKMbSADIE97J20/NH1QgroxTDABqEAzpWX3RtHhULE47gOIJmUjdOWd7HNBi/UbMCH5jHXpTdDjyuePsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598388; c=relaxed/simple;
	bh=L++LVjd8ejoi3HzKBzqoEV3hTViJYz6fJtmKQKonoN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5zPIaS2G89t7ktri1YSUp7xN0uXVGP3ZuEZFEXuttmzmsx8smVhGNR/IWzti6ABqeboZ3TOjMbGOANbkA0JjfPi+Z4nheOkPxLwdkXeh/b3tKHTixNBj3xtgZoAoP/jS0FEa11+guAVPAqa3w7bfEG74EG0OSxjKFnvcrqYdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 19 Aug 2025 19:12:57 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 19 Aug 2025 19:12:57 +0900
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
Message-ID: <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
 <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330>
 <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>

On Sat, Aug 16, 2025 at 12:15:43PM -0700, Chris Li wrote:

At first, Thank you for detailed and fast feedback!

> I have not questioned the approach you can achieve with your goal. The
> real question is, is this the best approach to consider to merge into

Yes, I believe this could be the best approach.
I have compared several possible approaches before making this proposal. These
are the alternatives I reviewed in the RFC:
(https://lore.kernel.org/linux-mm/20250612103743.3385842-1-youngjun.park@lge.com/)
The part I mentions are as belows

> Evaluated Alternatives
> ======================
> 1. **Per-cgroup dedicated swap devices**
>    - Previously proposed upstream [1]
>    - Challenges in managing global vs per-cgroup swap state
>    - Difficult to integrate with existing memory.limit / swap.max semantics
> 2. **Multi-backend swap device with cgroup-aware routing**
>    - Considered sort of layering violation (block device cgroup awareness)
>    - Swap devices are commonly meant to be physical block devices.
>    - Similar idea mentioned in [2]
> 3. **Per-cgroup swap device enable/disable with swap usage contorl**
>    - Expand swap.max with zswap.writeback usage
>    - Discussed in context of zswap writeback [3]
>    - Cannot express arbitrary priority orderings
>      (e.g. swap priority A-B-C on cgroup C-A-B impossible)
>    - Less flexible than per-device priority approach
> 4. **Per-namespace swap priority configuration**
>    - In short, make swap namespace for swap device priority
>    - Overly complex for our use case
>    - Cgroups are the natural scope for this mechanism

In my view, the `swap.tier` proposal aligns quite well with alternative (3) that
I reviewed. That approach keeps the global priority assignment while adding
inclusion/exclusion semantics at the cgroup level. The reason I decided not to
go with it is because it lacks flexibility — it cannot express arbitrary
ordering. As noted above, it is impossible to represent arbitrary orderings,
which is why I chose a per-device priority strategy instead.

> the main line Linux kernel. Merging into the main line kernel has a
> very high bar. How is it compared to other alternative approaches in
> terms of technical merit and complexity trade offs.

Since you seem most concerned about complexity, I have been thinking more about
this point.

1. **Conceptual complexity**  
   The idea is simply to add a swap priority list per cgroup. This is
   straightforward to understand. The more complicated part is NUMA priority
   handling — but if that turns out to be too complex, we can drop it entirely
   or adjust its semantics to reduce the complexity.

2. **Implementation complexity**  
   Could you clarify from which perspective you see implementation complexity as
   problematic? I would like to know more specifically what part worries you.

The `swap.tier` concept also requires mapping priorities to tiers, creating
per-cgroup tier objects, and so forth. That means a number of supporting
structures are needed as well. While I agree it is conceptually well-defined,
I don’t necessarily find it simpler than the per-device priority model.

> Why would I trade a cleaner less complex approach for a more complex
> approach with technical deficiency not able to address (inverting swap
> entry LRU ordering)?

Could you elaborate on what exactly you mean by “inverting swap entry LRU order”?
Do you mean that because of per-cgroup priority differences, entries on the
global swap LRU list could become inconsistent when viewed from different
cgroups? If that is the case, could you explain more concretely what problems
such inconsistencies would cause? That would help me understand the concern
better.

> Let me clarify. LPC is not required to get your series merged. Giving
> a talk in LPC usually is an honor. It does not guarantee your series
> gets merged either. It certainly helps your idea get more exposure and
> discussion. You might be able to meet some maintainers in person. For
> me, it is nice to meet the person to whom I have been communicating by
> email. I was making the suggestion because it can be a good topic for
> LPC, and just in case you might enjoy LPC. It is totally for your
> benefit. Up to your decision, please don't make it a burden. It is
> not.
>
> If after your consideration, you do want to submit a proposal in LPC,
> you need to hurry though. The deadline is closing soon.

I see, thank you for the suggestion. I also think having the chance to discuss
this at LPC would be very beneficial for me. I will not see it as a burden —
if I decide to go forward, I will let you know right away (until this week).

> From the swap file point of view, when it needs to flush some data to
> the lower tiers, it is very hard if possible for swap file to maintain
> per cgroup LRU order within a swap file.

Could you explain in more detail why the flush operation is difficult in that
case? I would like to understand what the concrete difficulty is.

> It is much easier if all the swap entries in a swap file are in the
> same LRU order tier.

This is related to the same question above — I would appreciate a more
detailed explanation because it is not yet clear to me. Why is it easy?

> The swap.tiers idea is not a compromise, it is a straight win. Can you
> describe what per cgroup per swap file can do while swap.tiers can
> not?

I mentioned already on this mail: what swap tiers cannot do is arbitrary
ordering. If ordering is fixed globally by tiers, some workloads that want to
consume slower swap devices first (and reserve faster devices as a safety
backend to minimize swap failures) cannot be expressed. This kind of policy
requires arbitrary ordering flexibility, which is possible with per-device
priorities but not with fixed tiers.

And vswap possible usage: if we must consider vswap (assume we can select it
like an individual swap device), where should it be mapped in the tier model?
(see https://lore.kernel.org/linux-mm/CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com/) 
In my opinion, it cannot be mapped purely by service speed. 
There are indeed situations where tiering by service speed is beneficial, 
but I also believe priority-based ordering can capture the same intention 
while also covering exceptional use cases.

So, I see the per-device priority approach as more general: it can represent
tier-based usage, but also more flexible policies that tiers alone cannot cover.

> It obviously will introduce new complexity. I want to understand the
> reason to justify the additional complexity before I consider such an
> approach.

I think that any new concept adds complexity, whether it is “swap.tier” or
per-device priority. If you could clarify more precisely what kind of
complexity you are most concerned about, I would be happy to give my detailed
thoughts in that direction.

Thank you again for your prompt and thoughtful feedback :). I will continue
thinking about this further while awaiting your reply.

Best regards,
Youngjun Park

