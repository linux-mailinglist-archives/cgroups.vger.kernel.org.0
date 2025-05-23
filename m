Return-Path: <cgroups+bounces-8329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEABAC282F
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07771C06ED9
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A09297A61;
	Fri, 23 May 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/2sew1v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10807296FCC
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020016; cv=none; b=ktws0pQQ0jb93wp7j3esRwvHpOhJKJEqU3m2rxenQ/PcUYTp3p8HB6HNWiYi/zD7NPAzVD+KQkKDNS6Yy9LNnzP5p7jQg2ykqF1fQeG0TwARG2SWSb46h1FwkWlVBoG/YtDgHWTd3Ie/QOrld0YhxZxnHi3QY2Iyi4fiV3P0z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020016; c=relaxed/simple;
	bh=kTO86Yr9yECuI+Z75YE9dgiAuo/kBDUAB7RAsNdQ800=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw7/Fsb+DYje6HbPNbyMB7MplAfaMoymhliaYpaisqbBj0w9LigmV+J/hJpYnj0FTKVOR0QFhL6g9JURjuMNB8ULxJS0a+ARcB88wXfxMqFHlqEaQTF8fH7MBVx7V8bM6cYo0nNk6/FH7UmZ9Au+FHLHtaxOY1Cz6MRdsy5mE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/2sew1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3CEC4CEE9;
	Fri, 23 May 2025 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020014;
	bh=kTO86Yr9yECuI+Z75YE9dgiAuo/kBDUAB7RAsNdQ800=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/2sew1vcli3jpNIWBW8Q5N8Jouc+ikqp2aImWnodkF6SkeE/rnilP0HbzQppzChx
	 i7ZQrjegza3FhKBNYFyS1gBlpIyCINcMGDrLCmkl1wM4JwcyNanPeRYqVI1tdaSKqw
	 BXs2dli6WyOfCcv5eC9MNCcaPPUiIk8o9SNP7IerM81Hqfv3kuswMEHgXjCx47uyDv
	 Dlt6Lf3XUDalK41XOT12WylQjxohiqA+Y+SiisvqKex7lbdSs9KccQhBL/jzSG3Vwl
	 oCja4RH2RP+5cVKogJjm82sgsPOPWAHR45wI1fv6sc9vdShx+2e/CciO4rizRXtM97
	 il/xZnUT1/jbg==
Date: Fri, 23 May 2025 07:06:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <aDCrLTNoWC8oSS7Z@slm.duckdns.org>
References: <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
 <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com>
 <20250516164150.GD720744@cmpxchg.org>
 <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com>
 <20250516200423.GE720744@cmpxchg.org>
 <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com>
 <aC-ALtcs8RF1yZ1y@slm.duckdns.org>
 <de476962-194f-4c77-aabb-559a74caf5ac@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de476962-194f-4c77-aabb-559a74caf5ac@amd.com>

Hello, Christian.

On Fri, May 23, 2025 at 09:58:58AM +0200, Christian König wrote:
...
> > - There's a GPU workload which uses a sizable amount of system memory for
> >   the pool being discussed in this thread. This GPU workload is very
> >   important, so we want to make sure that other activities in the system
> >   don't bother it. We give it plenty of isolated CPUs and protect its memory
> >   with high enough memory.low.
> 
> That situation simply doesn't happen. See isolation is *not* a requirement
> for the pool.
...
> See the submission model of GPUs is best effort. E.g. you don't guarantee
> any performance isolation between processes whatsoever. If we would start
> to do this we would need to start re-designing the HW.

This is a radical claim. Let's table the rest of the discussion for now. I
don't know enough to tell whether this claim is true or not, but for this to
be true, the following should be true:

 Whether the GPU memory pool is reclaimed or not doesn't have noticeable
 performance implications on the GPU performance.

Is this true?

As for the scenario that I described above, I didn't just come up with it.
I'm only supporting from system side but that's based on what our ML folks
are doing right now. We have a bunch of lage machines with multiple GPUs
running ML workloads. The workloads can run for a long time spread across
many machines and they synchronize frequently, so any performance drop on
one GPU lowers utiliization on all involved GPUs which can go up to three
digits. For example, any scheduling disturbances on the submitting thread
propagates through the whole cluster and slows down all involved GPUs.

Also, because these machines are large on the CPU and memory sides too and
aren't doing whole lot other than managing the GPUs, people want to put on a
significant amount of CPU work on them which can easily create at least
moderate memory pressure. Is the claim that the combined write memory pool
doesn't have any meaningful impact on the GPU workload performance?

Thanks.

-- 
tejun

