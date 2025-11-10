Return-Path: <cgroups+bounces-11763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A907C49347
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 21:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B75E04E5743
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5E2E8B60;
	Mon, 10 Nov 2025 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDZdHH/k"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38728C5DE
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805968; cv=none; b=MG2z6Xfm6uKCJ07Gq0vl0Ih22pbLRNrFwJfiEK0ORLZouiku6YtpMCq8EyNLvdlEfAvMPlfhjBjdw9DY5pG3kqJGFefT1ON7mU6al22FQOclk2fPBi2BiPoYTpPEkn1+9F7bZb9/FACVyigX7uw65g9lt9qbi0bCR1TMV6a105Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805968; c=relaxed/simple;
	bh=UWfWbE2YkWvUZqhgvPTAog2KAzm0EdoRBGtcNUv/b/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLHICV1ENuI68WFTp6lZnTsC3j6+YLHCSq3B2illCgFQEZqisH7cwmDDhLhY7AGiCOUzYGa+nZld8OBiBTVNLXGTKcmPNUe5BaTvsyIzsO5cftmuVPHfDFfTKW4dkfsX5DgdjBr//opB8GHfAwY1Y6cK8an2+HuedybcQhPo0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDZdHH/k; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 20:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762805953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUAtP+bOC5fLBEO7OxWohIhZ/kKSaZK8V4CE4mNGeCE=;
	b=dDZdHH/kUkiRo3SsSNquTHnsNNN5J1Hk+BaJBgf32qqXkT9h85QIiDkbubM9dJ0mnW2sJI
	m1tCceGb4xcU/Fsn4Th82hnSW3LDELgBS33j4ATEEaZ2qp0rTfOXLwrGL86r/sDmFKxpSa
	HdMxQ1gJ8Hm1xuXfedgVL8bXwbUNMx0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: shakeel.butt@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, corbet@lwn.net, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	jack@suse.cz, joel.granados@kernel.org, kyle.meyer@hpe.com, 
	lance.yang@linux.dev, laoar.shao@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mclapinski@google.com, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Message-ID: <fwthn4zl6uppdjdckjkmglxwnby42x2rd57i3m22pbqamjzaxy@aso4l7xyvhek>
References: <blygjeudtqyxk7bhw5ycveofo4e322nycxyvupdnzq3eg7qtpo@cya4bifb2dlk>
 <20251110063757.86725-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110063757.86725-1-leon.huangfu@shopee.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 10, 2025 at 02:37:57PM +0800, Leon Huang Fu wrote:
> On Fri, Nov 7, 2025 at 7:56 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Nov 06, 2025 at 11:30:45AM +0800, Leon Huang Fu wrote:
> > > On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > +Yosry, JP
> > > >
> > > > On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
> > > > > On high-core count systems, memory cgroup statistics can become stale
> > > > > due to per-CPU caching and deferred aggregation. Monitoring tools and
> > > > > management applications sometimes need guaranteed up-to-date statistics
> > > > > at specific points in time to make accurate decisions.
> > > >
> > > > Can you explain a bit more on your environment where you are seeing
> > > > stale stats? More specifically, how often the management applications
> > > > are reading the memcg stats and if these applications are reading memcg
> > > > stats for each nodes of the cgroup tree.
> > > >
> > > > We force flush all the memcg stats at root level every 2 seconds but it
> > > > seems like that is not enough for your case. I am fine with an explicit
> > > > way for users to flush the memcg stats. In that way only users who want
> > > > to has to pay for the flush cost.
> > > >
> > >
> > > Thanks for the feedback. I encountered this issue while running the LTP
> > > memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
> > > where it consistently failed.
> > >
> > > I was aware that Yosry had improved the memory statistics refresh mechanism
> > > in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
> > > backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
> > > kernel with those improvements, the test still fails intermittently on XFS.
> > >
> > > I've created a simplified reproducer that mirrors the LTP test behavior. The
> > > test allocates 50 MiB of page cache and then verifies that memory.current and
> > > memory.stat's "file" field are approximately equal (within 5% tolerance).
> > >
> > > The failure pattern looks like:
> > >
> > >   After alloc: memory.current=52690944, memory.stat.file=48496640, size=52428800
> > >   Checks: current>=size=OK, file>0=OK, current~=file(5%)=FAIL
> > >
> > > Here's the reproducer code and test script (attached below for reference).
> > >
> > > To reproduce on XFS:
> > >   sudo ./run.sh --xfs
> > >   for i in {1..100}; do sudo ./run.sh --run; echo "==="; sleep 0.1; done
> > >   sudo ./run.sh --cleanup
> > >
> > > The test fails sporadically, typically a few times out of 100 runs, confirming
> > > that the improved flush isn't sufficient for this workload pattern.
> >
> > I was hoping that you have a real world workload/scenario which is
> > facing this issue. For the test a simple 'sleep 2' would be enough.
> > Anyways that is not an argument against adding an inteface for flushing.
> >
> 
> Fair point. I haven't encountered a production issue yet - this came up during
> our kernel testing phase on high-core count servers (224-256 cores) before
> deploying to production.
> 
> The LTP test failure was the indicator that prompted investigation. While
> adding 'sleep 2' would fix the test, it highlights a broader concern: on these
> high-core systems, the batching threshold (MEMCG_CHARGE_BATCH * num_online_cpus)
> can accumulate 14K-16K events before auto-flush, potentially causing significant
> staleness for workloads that need timely statistics.

The thresholding is implemented as a tradeoff between expensive flushing
and accurate stats, and it aims to at least provide deterministic
behavior in terms of how much the stats can deviate.

That being said, it's understandable that some use cases require even
higher accuracy and are willing to pay the price. Although I share
Shakeel's frustration that the driving motivation is tests where you can
sleep for 2 seconds or alter the tests to allow some bound deviation.

The two alternatives I can think of are the synchronous flushing
interface, and some sort of tunable that determines the needed accuracy.
The latter sounds like it would be difficult to design properly and may
end up with some of the swappiness problems, so I think the synchronous
flushing interface is probably the way to go. This was also brought up
before when the thresholding was implemented.

If we ever change the stats implementation completely and lose the
concept of flushes/refreshes, the interface can just be a noop, and we
can document that writes are useless (or even print something in dmesg).

So no objections from me.

> 
> We're planning to deploy container workloads on these servers where memory
> statistics drive placement and resource management decisions. Having an explicit
> flush interface would give us confidence that when precision matters (e.g.,
> admission control, OOM decisions), we can get accurate stats on demand rather
> than relying on timing or hoping the 2-second periodic flush happens when needed.
> 
> I understand this is more of a "preparing for future needs" rather than "fixing
> current production breakage" situation. However, given the interface provides
> opt-in control with no cost to users who don't need it, I believe it's a
> reasonable addition. I'll prepare a v3 with the dedicated memory.stat_refresh
> file as suggested.
> 
> Thanks,
> Leon

