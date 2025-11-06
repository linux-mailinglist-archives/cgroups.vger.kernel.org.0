Return-Path: <cgroups+bounces-11653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3DC3DE92
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 00:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1772534E87B
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58398350D74;
	Thu,  6 Nov 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j2wvssLd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE834FF54
	for <cgroups@vger.kernel.org>; Thu,  6 Nov 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473384; cv=none; b=pcUIUNov2hAGPckppzXO5V43vvg+EYyW72IK1HKQqCmPa4dVCA+J/qNe/tUBuKO6zK0g6fZ31kuEArG0Gue2Jn9RgWHDZJBz/kjXP4xKjBqBy//rDMU3aBUrBt5qt1NXLImGH0EBBBL4PdPOe9qeqoT8ZOkM4CexApPNaU38Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473384; c=relaxed/simple;
	bh=et7QnWbxo9CCaBu8sHpUQXNVSyg1OXgkY7ZnpcVDxhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcyG7YWpIlhOeq9sgU6MeVNwCWElUx1FdzPQEcCrSl7SNQ1RAr8U5KCk2tWp5gDZvBlGYI8klwEfPRFBqWfapzIuDT9cPL8a+iXVtVr8LW0xFKnQybdsxzvKvS9/NYniiL0Z0vv3dlEOgyFFLi2L7ahCsCQnRK0yEngvpZWVpak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j2wvssLd; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Nov 2025 15:55:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762473370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGQCjkfCEjQXXmAAtqWjaaeJ29j6gKbahZ5m7Q+7IDo=;
	b=j2wvssLdIAJwGLdiSwv+8Cm3wGBQ0K/g96eIbosBcuZ8GgxR82zGjOHEXkd+yZw5aS+ehK
	VukZps16+SNYzrm3jTCBoYtnZyn9poIBDqK1gzU4tv9o6Q6wUuLAwGm7RzxhKWcvGfwah8
	nTekdmNAQVjsqGbIn5SxwPqdIE/HBlY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net, 
	hannes@cmpxchg.org, inwardvessel@gmail.com, jack@suse.cz, joel.granados@kernel.org, 
	kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, yosry.ahmed@linux.dev
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Message-ID: <blygjeudtqyxk7bhw5ycveofo4e322nycxyvupdnzq3eg7qtpo@cya4bifb2dlk>
References: <6kh6hle2xp75hrtikasequ7qvfyginz7pyttltx6pkli26iir5@oqjmglatjg22>
 <20251106033045.41607-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106033045.41607-1-leon.huangfu@shopee.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 06, 2025 at 11:30:45AM +0800, Leon Huang Fu wrote:
> On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > +Yosry, JP
> >
> > On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
> > > On high-core count systems, memory cgroup statistics can become stale
> > > due to per-CPU caching and deferred aggregation. Monitoring tools and
> > > management applications sometimes need guaranteed up-to-date statistics
> > > at specific points in time to make accurate decisions.
> >
> > Can you explain a bit more on your environment where you are seeing
> > stale stats? More specifically, how often the management applications
> > are reading the memcg stats and if these applications are reading memcg
> > stats for each nodes of the cgroup tree.
> >
> > We force flush all the memcg stats at root level every 2 seconds but it
> > seems like that is not enough for your case. I am fine with an explicit
> > way for users to flush the memcg stats. In that way only users who want
> > to has to pay for the flush cost.
> >
> 
> Thanks for the feedback. I encountered this issue while running the LTP
> memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
> where it consistently failed.
> 
> I was aware that Yosry had improved the memory statistics refresh mechanism
> in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
> backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
> kernel with those improvements, the test still fails intermittently on XFS.
> 
> I've created a simplified reproducer that mirrors the LTP test behavior. The
> test allocates 50 MiB of page cache and then verifies that memory.current and
> memory.stat's "file" field are approximately equal (within 5% tolerance).
> 
> The failure pattern looks like:
> 
>   After alloc: memory.current=52690944, memory.stat.file=48496640, size=52428800
>   Checks: current>=size=OK, file>0=OK, current~=file(5%)=FAIL
> 
> Here's the reproducer code and test script (attached below for reference).
> 
> To reproduce on XFS:
>   sudo ./run.sh --xfs
>   for i in {1..100}; do sudo ./run.sh --run; echo "==="; sleep 0.1; done
>   sudo ./run.sh --cleanup
> 
> The test fails sporadically, typically a few times out of 100 runs, confirming
> that the improved flush isn't sufficient for this workload pattern.

I was hoping that you have a real world workload/scenario which is
facing this issue. For the test a simple 'sleep 2' would be enough.
Anyways that is not an argument against adding an inteface for flushing.


