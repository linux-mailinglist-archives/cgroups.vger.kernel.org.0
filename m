Return-Path: <cgroups+bounces-9246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB720B28FE7
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A9D1BC3070
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791222F99AC;
	Sat, 16 Aug 2025 17:36:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0818CC1D
	for <cgroups@vger.kernel.org>; Sat, 16 Aug 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365785; cv=none; b=ezVb+WNTjbXbbjdBl/qYN7yhgvNOpiEVJIBlSHBGBul27CO05NBV3G+JtBsNgJzB96D1oxgQHrKS+3uKEl0zOeGaNnF6TAaZZ5HuiNA3n74Ub3Y7Ype476GMqXqazp19rTEjTa6oDMSCN/5SUlYGJdveZ/4IHr9FxNZkQdJHRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365785; c=relaxed/simple;
	bh=iCFmh05oyI15zk2J+U/nYs9Bse+88rMFNd3dBvigg1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhW2bja8t5xqVjOKcPcojWqGZb8MVsslgKM+ggOof94v89g9h3TG3CB5HqneVyVXMW0w7YnR03dlVttpnNZ5VsCPloMWunmRSKcEvDhOWuY5jvGMBsnra4hU2hF+EsxlFw2znn/Sim6FlEfMQZ0V7BbxKikXf8SI8WAXx/lM2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 17 Aug 2025 02:21:21 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 17 Aug 2025 02:21:21 +0900
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
Message-ID: <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
 <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>

On Fri, Aug 15, 2025 at 08:10:09AM -0700, Chris Li wrote:
> Hi Michal and YoungJun,

First of all, thank you for sharing your thoughts. I really appreciate the
detailed feedback. I have many points I would like to think through and
discuss as well. For now, let me give some quick feedback, and I will follow
up with more detailed responses after I have had more time to reflect.

> I am sorry for the late reply. I have briefly read through the patches
> series the overall impression:
> 1)  Priority is not the best way to select which swap file to use per cgroup.
> The priority is assigned to one device, it is a per swap file local
> change. The effect you want to see is actually a global one, how this
> swap device compares to other devices. You actually want  a list at
> the end result. Adjusting per swap file priority is backwards. A lot
> of unnecessary usage complexity and code complexity come from that.
> 2)  This series is too complicated for what it does.

You mentioned that the series is overly complex and does more than what is
really needed. I understand your concern. I have spent quite a lot of time
thinking about this topic, and the reason I chose the priority approach is
that it gives more flexibility and extensibility by reusing an existing
concept.

Where you see unnecessary functionality, I tend to view it as providing more
degrees of freedom and flexibility. In my view, the swap tier concept can be
expressed as a subset of the per-cgroup priority model.

> I have a similar idea, "swap.tiers," first mentioned earlier here:
> https://lore.kernel.org/linux-mm/CAF8kJuNFtejEtjQHg5UBGduvFNn3AaGn4ffyoOrEnXfHpx6Ubg@mail.gmail.com/
> 
> I will outline the line in more detail in the last part of my reply.
> 
> BTW, YoungJun and Michal, do you have the per cgroup swap file control
> proposal for this year's LPC? If you want to, I am happy to work with
> you on the swap tiers topic as a secondary. I probably don't have the
> time to do it as a primary.

I have not submitted an LPC proposal. If it turns out to be necessary,
I agree it could be a good idea, and I truly appreciate your offer to
work together on it. From my understanding, though, the community has
so far received this patchset positively, so I hope the discussion can
continue within this context and eventually be accepted there.
 
> OK. I want to abandon the weight-adjustment approach. Here I outline
> the swap tiers idea as follows. I can probably start a new thread for
> that later.
> 
> 1) No per cgroup swap priority adjustment. The swap file priority is
> global to the system.
> Per cgroup swap file ordering adjustment is bad from the LRU point of
> view. We should make the swap file ordering matching to the swap
> device service performance. Fast swap tier zram, zswap store hotter
> data, slower tier hard drive store colder data.  SSD in between. It is
> important to maintain the fast slow tier match to the hot cold LRU
> ordering.

Regarding your first point about swap tiers: I would like to study this part
a bit more carefully. If you could share some additional explanation, that
would be very helpful for me.
 
> 2) There is a simple mapping of global swap tier names into priority range
> The name itself is customizable.
> e.g. 100+ is the "compress_ram" tier. 50-99 is the "SSD" tier, 0-55 is
> the "hdd" tier.
> The detailed mechanization and API is TBD.
> The end result is a simple tier name lookup will get the priority range.
> By default all swap tiers are available for global usage without
> cgroup. That matches the current global swap on behavior.
> 
> 3) Each cgroup will have "swap.tiers" (name TBD) to opt in/out of the tier.
> It is a list of tiers including the default tier who shall not be named.
> 
> Here are a few examples:
> e.g. consider the following cgroup hierarchy a/b/c/d, a as the first
> level cgroup.
> a/swap.tiers: "- +compress_ram"
> it means who shall not be named is set to opt out,  optin in
> compress_ram only, no ssd, no hard.
> Who shall not be named, if specified, has to be the first one listed
> in the "swap.tiers".
> 
> a/b/swap.tiers: "+ssd"
> For b cgroup, who shall not be named is not specified, the tier is
> appended to the parent "a/swap.tiers". The effective "a/b/swap.tiers"
> become "- +compress_ram +ssd"
> a/b can use both zswap and ssd.
> 
> Every time the who shall not be named is changed, it can drop the
> parent swap.tiers chain, starting from scratch.
> 
> a/b/c/swap.tiers: "-"
> 
> For c, it turns off all swap. The effective "a/b/c/swap.tiers" become
> "- +compress_ram +ssd -" which simplify as "-", because the second "-"
> overwrites all previous optin/optout results.
> In other words, if the current cgroup does not specify the who shall
> not be named, it will walk the parent chain until it does. The global
> "/" for non cgroup is on.
> 
> a/b/c/d/swap.tiers: "- +hdd"
> For d, only hdd swap, nothing else.
> 
> More example:
>  "- +ssd +hdd -ssd" will simplify to: "- +hdd", which means hdd only.
>  "+ -hdd": No hdd for you! Use everything else.
> 
> Let me know what you think about the above "swap.tiers"(name TBD) proposal.

Thank you very much for the detailed description of the "swap.tiers" idea.
As I understand it, the main idea is to separate swap devices by speed,
assign a suitable priority range for each, and then make it easy for users to
include or exclude tiers. I believe I have understood the concept clearly.

I agree that operating with tiers is important. At the same time, as I
mentioned earlier, I believe that managing priorities in a way that reflects
tiers can also achieve the intended effect.

I have also been thinking about a possible compromise. If the interface is
intended to make tiers visible to users in the way you describe, then mapping
priority ranges to tiers (as you propose) makes sense. Users would still have
the flexibility to define ordering, while internally we could maintain the
priority list model I suggested. I wonder what you think about such a hybrid
approach. 

Thank you as always for your valuable insights.

Best regards,
Youngjun Park

