Return-Path: <cgroups+bounces-9358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638FB32FE4
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 14:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFE8481E83
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D5274B54;
	Sun, 24 Aug 2025 12:05:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FE238178
	for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756037148; cv=none; b=HIF8/DoU0tPMHioIoh32bVVKDA8WWaSZIIy/KMJ6Vl/i5kxZ/nwNzo5xCw2iIwiiQf0a+OrnQsOzutLdD+SxGyJpOuh0kCZAxijLDOc/lQvu9ZHh4LlVi7O3dpDRtr3fxXhzUxKGJOdAeeUoNDuHta2OpwhZoIOnMKtpSQEtqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756037148; c=relaxed/simple;
	bh=unzH2Zg3QLYapxP0d9yYYXyfQ/FWfgufZj/vUZ29xlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjCFtIG6nsQu1MndWvJdMRXd5WzHSEG36v4qSDVnBDSJ7xYcj7WUxNCUFeioBQXV7VS9s58PckQnIpTsdtFrct6FiA8mQ0zr4yeNOKOZG3xpmvmKuFCpo/wKDfSFAjaYJuHz+NxLATZemplHbZA3bWfPd66GFCvOgdIPVPDqrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 24 Aug 2025 21:05:37 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 24 Aug 2025 21:05:37 +0900
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
Message-ID: <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
References: <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330>
 <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
 <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
 <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
 <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>

> How do you express the default tier who shall not name? There are
> actually 3 states associated with default. It is not binary.
> 1) default not specified: look up parent chain for default.
> 2) default specified as on. Override parent default.
> 3) default specified as off. Override parent default.

As I understand, your intention is to define inheritance semantics depending
on the default value, and allow children to override this freely with `-` and
`+` semantics. Is that correct?

When I originally proposed the swap cgroup priority mechanism, Michal Koutný
commented that it is unnatural for cgroups if a parent attribute is not
inherited by its child:
(https://lore.kernel.org/linux-mm/rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr/)

Therefore, my current thinking is:
* The global swap setting itself is tier 1 (if nothing is configured).
* If a cgroup has no setting:
  - Top-level cgroups follow the global swap.
  - Child cgroups follow their parent’s setting.
* If a cgroup has its own setting, that setting is applied.
(child cgroups can only select tiers that the parent has allowed.)

This seems natural because most cgroup resource distribution mechanisms follow
a subset inheritance model.

Thus, in my concept, there is no notion of a “default” value that controls
inheritance.

> How are you going to store the list of ranges? Just a bitmask integer
> or a list?

They can be represented as increasing integers, up to 32, and stored as a
bitmask.

> I feel the tier name is more readable. The number to which actual
> device mapping is non trivial to track for humans.

Using increasing integers makes it simpler for the kernel to accept a uniform
interface format, it is identical to the existing cpuset interface, and it
expresses the meaning of “tiers of swap by speed hierarchy” more clearly in my
view.

However, my feeling is still that this approach is clearer both in terms of
implementation and conceptual expression. I would appreciate if you could
reconsider it once more. If after reconsideration you still prefer your
direction, I will follow your decision.

> I want to add another usage case into consideration. The swap.tiers
> does not have to be per cgroup. It can be per VMA. [...]

I understand this as a potential extension use case for swap.tier.  
I will keep this in mind when implementing. If I have further ideas here, I
will share them for discussion.

> Sounds fine. Maybe we can have "ssd:100 zswap:40 hdd" [...]

Yes, this alignment looks good to me!

> Can you elaborate on that. Just brainstorming, can we keep the
> swap.tiers and assign NUMA autobind range to tier as well? [...]

That is actually the same idea I had in mind for the NUMA use case.  
However, I doubt if there is any real workload using this in practice, so I
thought it may be better to leave it out for now. If NUMA autobind is truly
needed later, it could be implemented then.

This point can also be revisited during review or patch writing, so I will
keep thinking about it.

> I feel that that has the risk of  premature optimization. I suggest
> just going with the simplest bitmask check first then optimize as
> follow up when needed. [...]

Yes, I agree with you. Starting with the bitmask implementation seems to be
the right approach.

By the way, while thinking about possible implementation, I would like to ask
your opinion on the following situation:

Suppose a tier has already been defined and cgroups are configured to use it.
Should we allow the tier definition itself to be modified afterwards?

There seem to be two possible choices:

1. Once a cgroup references a tier, modifying that tier should be disallowed.
2. Allow tier re-definition even if cgroups are already referencing it.

Personally, I prefer option (1), since it avoids unexpected changes for
cgroups that already rely on a particular tier definition.

What is your opinion on this?

Best Regards,
Youngjun Park

