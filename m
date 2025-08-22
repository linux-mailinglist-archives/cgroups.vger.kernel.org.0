Return-Path: <cgroups+bounces-9321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC238B30E44
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2767B9791
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E542E265B;
	Fri, 22 Aug 2025 05:45:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FA20E033
	for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841529; cv=none; b=fszjFSVEmVHABnafZFLkBR1be4M2EZkx13XHGiyfNEmyil2vojgrdvFPZp5KZ8ZoZIkoyTBMo+uFzvQwSAmeMw1a2T2WB2QZuqR8dwGhssLWKq0Qrmnx7jTGBhkhsgmf4O972lK/qyIpUPJ3dynT3FINlR8fe1vQsrIItzAMP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841529; c=relaxed/simple;
	bh=C6zhtBJR1m/7kPOv2gYNp0w5HSgKglOjWakItYQ+OTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUQmjBtPowM8s3m+2H6jPi28lVWC084wMN5vB4G5Dr84jPXVnTENomaOqbG5lENaGidbPcxM48iNX1R3Dw3DMw9+Vp5CwQ1ouq7nbFEkT33QUPTf28NGclN7jSEGlb3QYaj1avNh4Ky7LPiLOVDozRD62yIgPZvdS+1ouWea5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 22 Aug 2025 14:45:18 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 22 Aug 2025 14:45:18 +0900
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
Message-ID: <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330>
References: <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
 <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330>
 <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330>
 <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330>
 <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>

I still believe that the priority based approach has more flexibility,
and can cover more usage scenarios. That opinion has not changed.

However, from this discussion I came to clearly understand and agree on
three points:

1. The swap.tier idea can be implemented in a much simpler way, and
2. It can cover the most important use cases I initially needed, as well
   as common performance scenarios, without causing LRU inversion.
3. The really really needed usage scenario of arbitrary ordering does not exist.
the usage scenario I suggest is imaginary.(just has possibility)

I have also considered the situation where I might need to revisit my
original idea in the future. I believe this would still be manageable
within the swap.tier framework. For example:

* If after swap.tier is merged, an arbitrate ordering use case arises
  (which you do not consider concrete), it could be solved by allowing
  cgroups to remap the tier order individually.

* If reviewers later decide to go back to the priority based direction,
  I think it will still be possible. By then, much of the work would
  already be done in patch v2, so switching back would not be
  impossible.

And also, since I highly respect you for long-time contributions and
deep thinking in the swap layer, I decided to move the idea forward
based on swap.tier.

For now, I would like to share the first major direction change I am
considering, and get feedback on how to proceed. If you think this path
is promising, please advise whether I should continue as patch v2, or
send a new RFC series or new patch series.

-----------------------------------------------------------------------
1. Interface
-----------------------------------------------------------------------

In the initial thread you replied with the following examples:

> Here are a few examples:
> e.g. consider the following cgroup hierarchy a/b/c/d, a as the first
> level cgroup.
> a/swap.tiers: "- +compress_ram"
> it means who shall not be named is set to opt out, optin in
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
> "- +ssd +hdd -ssd" will simplify to: "- +hdd", which means hdd only.
> "+ -hdd": No hdd for you! Use everything else.
>
> Let me know what you think about the above "swap.tiers"(name TBD)
> proposal.

My opinion is that instead of mapping priority into named concepts, it
may be simpler to represent it as plain integers. 
(The integers are assigned in sequential order, as explained in the following reply.)
This would make the interface almost identical to the cpuset style suggested by Koutný.

For example:

  echo 1-8,9-10 > a/swap.tier   # parent allows tier range 1–8 and 9-10
  echo 1-4,9    > a/b/swap.tier # child uses tier 1-4 and 9 within parent's range
  echo 20   > a/b/swap.tier # invalid: parent only allowed 1-8 and 9-10

named concepts can be dealt with by some userland based software solution.
kernel just gives simple integer mapping concept. 
userland software can abstract it as a "named" tier to user.

Regarding the mapping of names to ranges, as you also mentioned:

> There is a simple mapping of global swap tier names into priority
> range
> The name itself is customizable.
> e.g. 100+ is the "compress_ram" tier. 50-99 is the "SSD" tier,
> 0-55 is the "hdd" tier.
> The detailed mechanization and API is TBD.
> The end result is a simple tier name lookup will get the priority
> range.
> By default all swap tiers are available for global usage without
> cgroup. That matches the current global swap on behavior.

One idea would be to provide a /proc/swaptier interface:

  echo "100 40" > /proc/swaptier

This would mean:
* >=100 : tier 1
* 40–99 : tier 2
* <40   : tier 3

How do you feel about this approach?

-----------------------------------------------------------------------
2. NUMA autobind
-----------------------------------------------------------------------

If NUMA autobind is in use, perhaps it is best to simply disallow
swaptier settings. I expect workloads depending on autobind would rely
on it globally, rather than per-cgroup. Therefore, when a negative
priority is present, tier grouping could reject the configuration.

-----------------------------------------------------------------------
3. Implementation
-----------------------------------------------------------------------

My initial thought is to implement a simple bitmask check. That is, in
the slow swap path, check whether the cgroup has selected the given
tier. This is simple, but I worry it might lose the optimization of the
current priority list, where devices are dynamically tracked as they
become available or unavailable.

So perhaps a better design is to make swap tier an object, and have
each cgroup traverse only the priority list of the tiers it selected. I
would like feedback on whether this design makes sense.

-----------------------------------------------------------------------

Finally, I want to thank all reviewers for the constructive feedback.
Even if we move to the swap.tier approach, the reviews from Kairui, Nhat
Pham and Koutný are still valid and will remain relevant.

Kairui, Nhat Pham
* Regarding per-cgroup per-cluster feedback: this would likely need to
  be adapted to tier-based design.
* Regarding passing percpu info along the allocation path: since tier is
  selected per-cgroup, this may still be needed, depending on
  implementation.

Koutný
* Regarding NUMA autobind complexity: as explained above, I intend to
  design the mechanism so that autobind does not affect it. Parent-child
  semantics will remain essentially identical to cpuset. If the proposed
  interface is accepted, its usage would be like cpuset, which should be
  less controversial.

---

Thank you again for the suggestions. I will continue to review while
waiting for your feedback.

Best Regards,
Youngjun Park

