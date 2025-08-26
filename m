Return-Path: <cgroups+bounces-9419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E14B3607D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 15:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC3E7C65B2
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EA770FE;
	Tue, 26 Aug 2025 12:57:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46441C54A9
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213036; cv=none; b=V4iqXHRqPtSXobHSy8x1iitpqYInajMA966LE6UL0pzn1iYCmNmrvtnSq5ySy6FJH3/6UoVF0tAABOfE9DAQqPsceSgdDHAa0+CWHuLI6qRMfpKT7qUh3WHBuCCz/8i04Xe9UohvJnQASPOg+pht47bMYE7rlPnmdB5bjz+f0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213036; c=relaxed/simple;
	bh=dCIzKeehA75sfDwjNSZmfmXjiMkdul1BtdEIr64Qn1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmKWezUjpO95uSco1VorK+Q9LgTq9zzblFnkGjr5dAunNdLQ1oL41xqT0kb06ESKmiHA1ewaB4/Z5BA6mJU+HaLeo5FhWvCJ+vlRe3y6jAUREtMG+IKrS0hJhiOtRA+C+YWmmISb0+yF4j/fmQzX2zKhZxD26c+O/atr4ElyTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 26 Aug 2025 21:57:05 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 26 Aug 2025 21:57:05 +0900
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
Message-ID: <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
References: <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330>
 <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
 <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
 <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
 <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
 <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>

> > Therefore, my current thinking is:
> > * The global swap setting itself is tier 1 (if nothing is configured).
> > * If a cgroup has no setting:
> >   - Top-level cgroups follow the global swap.
> >   - Child cgroups follow their parent’s setting.
> > * If a cgroup has its own setting, that setting is applied.
> > (child cgroups can only select tiers that the parent has allowed.)
>
> That is too restrictive. The most common case is just the parent
> cgroup matters, the child uses the exact same setting as the parent.
> However, if you want the child to be different from the parent, there
> are two cases depending on your intention. Both can make sense.
> 1) The parent is more latency sensitive than the child. That way the
> child will be more (slower) tired than the parent. Using more tiers is
> slower, that is the inverted relationship. Your proposal does not
> allow this?
> 2) The parent is latency tolerant and the child is latency sensitive.
> In this case, the child will remove some swap files from the parent.
> This is also a valid case, e.g. the parent is just a wrapper daemon
> invoking the real worker as a child. The wrapper just does log
> rotation and restarting the child group with a watchdog, it does not
> need to be very latency sensitive, let say the watchdog is 1 hours.
> The child is the heavy lifter and requires fast response.
>
> I think both cases are possible, I don't see a strong reason to limit
> the flexibility when there is no additional cost. I expect the
> restriction approach having similar complexity.

In my use case, I think a restrictive inheritance model could
be sufficient. My argument was mainly based on the fact that most cgroup
resource distribution mechanisms usually follow a parent→child restrictive
pattern. Through the review, I came to the view that I should adhere to the
common behavior whenever possible.

Firstly(on RFC), I initially supported allowing parent/child inconsistency
for flexibility, so I actually agree with your view regarding flexibility.
For the examples you mentioned, I have no disagreement. I think my final
understanding is aligned with yours.

> Can you clarify what I need to reconsider? I have the very similar
> bitmask idea as you describe now.
> I am not a dictator. I just provide feedback to your usage case with
> my reasoning.
>

Oh! I think you are a good reviewer :D
Okay then, Let me explain my preference for numeric tiers in more detail.
It seems we are aligned on the implementation strategy with bitmask,
but I think our difference lies in the interface style — 'name' vs.
'numeric increase'."

1. A simple numeric interface makes the usage more straightforward.
   Instead of '+/-' semantics, directly listing the numeric range feels
   clearer and easier to use. For example:

     tier 1 (ram)
     tier 2 (ssd)
     tier 3 (hdd)
     tier 4 (network device)
     tier 5 (some device)
     tier 6 (some device2)

   cg1: echo 1-3  > memory.swap.tier (ram,ssd,hdd)
   cg1/cg2: 2-4,6  > memory.swap.tie (ssd,hdd,network device, somedevice 2, assuming non-subset is allowed)

   Tier specification can also be expressed simply as arrays of priority
   ranges, which feels easy to understand.

2. Since tiers are inherently ordered, numbering fits naturally and is
   easier for users to accept.  
   In my view, assigning a name is mainly useful to distinguish between
   otherwise 'indistinguishable' groups, but in this case, there is already
   a clear distinction given by the different priorities which simply be 
   charaterized by increasing number.

I understand your point that tier names may be more convenient for
administrators, and I see the value in that. That was why I used the word
"reconsider" — your feedback makes sense as well.

I do not have a strong preference. It would be good to align after
considering the pros and cons. I look forward to your thoughts."

> > There seem to be two possible choices:
> >
> > 1. Once a cgroup references a tier, modifying that tier should be
> >    disallowed.
>
> Even modify a tier to cover more priority range but no swap device
> falls in that additional range yet?
> I think we should make the change follow the swap on/swap off
> behavior. Once the swap device is swapped on, it can't change its tier
> until it is swapped off again. when it is swapped off, there is no
> cgroup on it. Notice the swap file belongs to which tier is not the
> same as the priority range of the tier. You can modify the range and
> reorder swap tiers as long as it is not causing swap on device jump to
> a different tier.
>
> > 2. Allow tier re-definition even if cgroups are already referencing
> >    it.
>
> You can still swap off even if cgroup is still using it.
>
> > Personally, I prefer option (1), since it avoids unexpected changes
> > for cgroups that already rely on a particular tier definition.
>
> Swap off and on already have similar problems. We can't change the
> priority when the swap device is swapon already. We can go through a
> swap off to change it.

I see your point. In practice, when tiers are already being referenced
by cgroups, swap devices may come and go within those tiers. I think
this can be considered a "natural" behavior, as swap management is
usually performed explicitly by the administrator.  

From that perspective, I expect that unintended behavior is very
unlikely to occur in real scenarios. So I am comfortable assuming this
implicit behavior when reasoning about tier modifications.  

Thanks again for the clarification. With this, the overall picture
feels much clearer. Once we reach alignment on the "named" vs. "numeric"
tier interface, I plan to move forward with the patch work.

Best Regards
Youngjun Park

