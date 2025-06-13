Return-Path: <cgroups+bounces-8516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ABEAD89CA
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB593177E37
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A102C325C;
	Fri, 13 Jun 2025 10:45:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA6257AF8
	for <cgroups@vger.kernel.org>; Fri, 13 Jun 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811527; cv=none; b=mGwOWspbpJLa6m3TxNI1oItyYWDvpY3j0LX9KscbLzCRXV3MmEWwDJ0McDE2y8JNnqi4kNgPj0+0bDcM0yXg1f4wk/6s3pNcdk6dJaocV9c7oHHWTAB+/BqNX3U7yyYzfp4XUw93jNj1F3SbwsqhCY5GkR4bj0OqmDgs7PUpE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811527; c=relaxed/simple;
	bh=ZuFlF01f04Ql+aEJFM/KMn2qbrjLWQUDyCJ7lnDU9S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG86c9XEBog7YdFCPc9pHn159k4JyKC7PvxOTZU05qsyyxTquwlU0t9PXetTsEnPbcWj58Fwo5npXUpu6jamk697mxPVAZNyM7h+bO6svXJSjljvVBRw5Svh1OIbKNWrzGd8zSMiHMoVTanYgGTnonZrH1xHIRTuIx+9mQY29xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 13 Jun 2025 19:45:16 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 13 Jun 2025 19:45:16 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org,
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
Message-ID: <aEwBPG8mvZ06YQEA@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com>
 <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
 <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
 <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
 <CAKEwX=PD+P_wugkAJ83ti6YRo4-6QNM7HDFs+KDURVwx2JrnZg@mail.gmail.com>
 <aEvPBSObBrrQCsa3@yjaykim-PowerEdge-T330>
 <CAMgjq7BzQ8bKKXuHB=TiQnkdSdCuABXrRf8Z8w2QkjpD44jdgA@mail.gmail.com>
 <CAMgjq7BPQx93GhaUU0sURVkhf7AofE-qqzSwXS22RXnJhE=3Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BPQx93GhaUU0sURVkhf7AofE-qqzSwXS22RXnJhE=3Rw@mail.gmail.com>

On Fri, Jun 13, 2025 at 03:38:37PM +0800, Kairui Song wrote:
> On Fri, Jun 13, 2025 at 3:36 PM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Fri, Jun 13, 2025 at 3:11 PM YoungJun Park <youngjun.park@lge.com> wrote:
> > >
> > > On Thu, Jun 12, 2025 at 01:08:08PM -0700, Nhat Pham wrote:
> > > > On Thu, Jun 12, 2025 at 11:20 AM Kairui Song <ryncsn@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jun 13, 2025 at 1:28 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 12, 2025 at 4:14 AM Kairui Song <ryncsn@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jun 12, 2025 at 6:43 PM <youngjun.park@lge.com> wrote:
> > > > > > > >
> > > > > > > > From: "youngjun.park" <youngjun.park@lge.com>
> > > > > > > >
> > > > > > >
> > > > > > > Hi, Youngjun,
> > > > > > >
> > > > > > > Thanks for sharing this series.
> > > > > > >
> > > > > > > > This patch implements swap device selection and swap on/off propagation
> > > > > > > > when a cgroup-specific swap priority is set.
> > > > > > > >
> > > > > > > > There is one workaround to this implementation as follows.
> > > > > > > > Current per-cpu swap cluster enforces swap device selection based solely
> > > > > > > > on CPU locality, overriding the swap cgroup's configured priorities.
> > > > > > >
> > > > > > > I've been thinking about this, we can switch to a per-cgroup-per-cpu
> > > > > > > next cluster selector, the problem with current code is that swap
> > > > > >
> > > > > > What about per-cpu-per-order-per-swap-device :-? Number of swap
> > > > > > devices is gonna be smaller than number of cgroups, right?
> > > > >
> > > > > Hi Nhat,
> > > > >
> > > > > The problem is per cgroup makes more sense (I was suggested to use
> > > > > cgroup level locality at the very beginning of the implementation of
> > > > > the allocator in the mail list, but it was hard to do so at that
> > > > > time), for container environments, a cgroup is a container that runs
> > > > > one type of workload, so it has its own locality. Things like systemd
> > > > > also organize different desktop workloads into cgroups. The whole
> > > > > point is about cgroup.
> > > >
> > > > Yeah I know what cgroup represents. Which is why I mentioned in the
> > > > next paragraph that are still making decisions based per-cgroup - we
> > > > just organize the per-cpu cache based on swap devices. This way, two
> > > > cgroups with similar/same priority list can share the clusters, for
> > > > each swapfile, in each CPU. There will be a lot less duplication and
> > > > overhead. And two cgroups with different priority lists won't
> > > > interfere with each other, since they'll target different swapfiles.
> > > >
> > > > Unless we want to nudge the swapfiles/clusters to be self-partitioned
> > > > among the cgroups? :) IOW, each cluster contains pages mostly from a
> > > > single cgroup (with some stranglers mixed in). I suppose that will be
> > > > very useful for swap on rotational drives where read contiguity is
> > > > imperative, but not sure about other backends :-?
> > > > Anyway, no strong opinions to be completely honest :) Was just
> > > > throwing out some ideas. Per-cgroup-per-cpu-per-order sounds good to
> > > > me too, if it's easy to do.
> > >
> > > Good point!
> > > I agree with the mention that self-partitioned clusters and duplicated priority.
> > > One concern is the cost of synchronization.
> > > Specifically the one incurred when accessing the prioritized swap device
> > > From a simple performance perspective, a per-cgroup-per-CPU implementation
> > > seems favorable - in line with the current swap allocation fastpath.
> > >
> > > It seems most reasonable to carefully compare the pros and cons of the
> > > tow approaches.
> > >
> > > To summaraize,
> > >
> > > Option 1. per-cgroup-per-cpu
> > > Pros: upstream fit. performance.
> > > Cons: duplicate priority(some memory structure consumtion cost),
> > > self partioned cluster
> > >
> > > Option 2. per-cpu-per-order(per-device)
> > > Pros: Cons of Option1
> > > Cons: Pros of Option1
> > >
> > > It's not easy to draw a definitive conclusion right away,
> > > I should also evaluate other pros and cons that may arise during actual
> > > implementation.
> > > so I'd like to take some time to review things in more detail
> > > and share my thoughs and conclusions in the next patch series.
> > >
> > > What do you think, Nhat and Kairui?
> >
> > Ah, I think what might be best fits here is, each cgroup have a pcp
> > device list,  and each device have a pcp cluster list:
> >
> > folio -> mem_cgroup -> swap_priority (maybe a more generic name is
> > better?) -> swap_device_pcp (recording only the *si per order)
> > swap_device_info -> swap_cluster_pcp (cluster offset per order)
> 
> Sorry the truncate made this hard to read, let me try again:
> 
> folio ->
>   mem_cgroup ->
>     swap_priority (maybe a more generic name is better?) ->
>       swap_device_pcp (recording only the *si per order)
> 
> And:
> swap_device_info ->
>   swap_cluster_pcp (cluster offset per order)
> 
> And if mem_cgroup -> swap_priority is NULL,
> fallback to a global swap_device_pcp.

Thank you for quick and kind feedback. This is a really good idea :)
On my workaround proposal, I just need to add the swap_device_pcp part 
along with some refactoring.

And the naming swap_cgroup_priority...
I adopted the term "swap_cgorup_priority" based on the
perspective of the functionality I'm aiming to implement.
Here are some words that immediately come to mind.
(Like I said, just come to mind)
* swap_tier, swap_order, swap_selection, swap_cgroup_tier, swap_cgroup_order,
swap_cgroup_selection....

I'll try to come up with a more suitable conceptual name as I continue working
on the patch.
In the meantime, I'd appreciate any suggestions or feedback you may have.

Thanks again your feedback and suggestions.

