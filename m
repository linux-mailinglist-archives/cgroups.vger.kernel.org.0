Return-Path: <cgroups+bounces-8863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B32B0E383
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE816CD26
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23888280CE0;
	Tue, 22 Jul 2025 18:30:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F827EFFB
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209038; cv=none; b=q229QYK3wiO7JvUgi4cem2xyOOLXcy44yTINw3qRVzXfAfdzpxxQTxFNEiJe8NSLliiigd1yRp5GS7BkR4mDNJQnojAg4QN6DNbvYQKk4stjUJQ+1eLyOGNg6V/aDRFpH1lVDfv03PfipGtGvtObcDCuc/pUY5Nxb3SIdoj+dLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209038; c=relaxed/simple;
	bh=s93iSOLHKAqJafoXuoEukzfOjYM4TGn2cfZlmM72xLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1w5Ey8aPCqQclk+Ok8Me+HsFbcE/VgMrfP4XAHm8pwDQtj40od4FJmiMufISuM+N/8LCwh19iV/K9fAjYSHj9cdcjwzvJbtxZw8u/49KZIF0VEULCsgZUfYmLsr2t7l3Sa+afLhlnTH5mxt5baUPJ+vFDpBZVjHnftESXq10IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 23 Jul 2025 03:30:33 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 23 Jul 2025 03:30:33 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 4/4] mm: swap: Per-cgroup per-CPU swap device cache with
 shared clusters
Message-ID: <aH/YyRs+UFBAtkza@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-5-youngjun.park@lge.com>
 <CAMgjq7COLbfGwd4CYxNBaLTi4UaPDkKQzkLhsV-caoA-xq1V-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7COLbfGwd4CYxNBaLTi4UaPDkKQzkLhsV-caoA-xq1V-g@mail.gmail.com>

On Wed, Jul 23, 2025 at 01:44:49AM +0800, Kairui Song wrote:
> On Thu, Jul 17, 2025 at 4:21 AM Youngjun Park <youngjun.park@lge.com> wrote:
> 
> Hi Youngjun
> 
> One thing I noticed after a quick glance is that this
> swap_alloc_cgroup_priority is bloated and it is doing similar things
> as folio_alloc_swap.
> 
> I imagined that we can just have a struct (eg. let's call it struct
> swap_percpu_info / pi) as a closure of what the allocator needs, it
> contains the plist and fast path device.
> 
> With slight changes to folio_alloc_swap, it can respect either the
> cgroup's pi or global pi. (might be a horrible name though, feel free
> to change it)
> 
> For example first thing swap_alloc_fast do will be:
> 
> `struct swap_percpu_info *pi = folio_swap_percpu_info(folio);`
> 
> folio_swap_percpu_info returns the cgroup's swap_percpu_info or the global one.
> 
> swap_alloc_slow can do a similar thing, it then can just use pi->plist
> and pi->pcpu_swapdev, (cluster info will be in si) ignoring all the
> cgroup differences.

I was also considering whether the priority handling (like `plist`) could be  
abstracted to unify the allocation logic across paths.  

At the time, I leaned toward keeping the existing allocator logic intact as    
much as possible, which is why I avoided introducing a new struct and instead  
duplicated some logic.  

Your suggestion with `swap_percpu_info` makes the design clearer and aligns    
well with what I had in mind — I’ll review this direction more closely. If my  
thoughts change during the process, I’ll make sure to share the update on the  
mailing list.  

Thanks again for the helpful input!

> Also it is better to check your patches with ./scripts/checkpatch.pl,
> I'm seeing some styling issues.

I should have paid more attention to this.  
I’ll be sure to run `./scripts/checkpatch.pl` more carefully and address those 
issues in the next version of the patch. Thanks for the reminder!

> I'll check your other patches too later this week, thanks for the
> update on this idea.

Thanks again for the great idea, and I really appreciate you taking the time to
review this in the middle of your busy schedule.

> 
> Why not just remove the `percpu_swap_cluster.offset` and just share
> si->percpu_cluster among all cgroups (including root cgroup)?
> 
> Otherwise, eg. if rootcg's pcpu cluster and one cgroup's pcpu
> cluster are pointing to one same cluster, they might be in
> contention on allocation of different order, or even in the same order
> the performance might not be good as multiple CPUs will race
> with each other.
> 
> It will be easier to implement too.

I originally kept `percpu_swap_cluster.offset` around to
preserve compatibility when swap cgroup priority is not enabled, and to        
minimize disruption to the existing fast path.  

But after reviewing your suggestion, I agree it makes more sense to unify this 
path and always rely on `si->percpu_cluster`, even for the root cgroup.  

This simplifies the implementation, and as you pointed out, avoids potential   
contention and complexity that could arise from sharing per-cgroup clusters    
across CPUs.  

Thanks again for the clear and helpful insight.

