Return-Path: <cgroups+bounces-2589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B346E8A9F0D
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185E5B24A2E
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD016F83F;
	Thu, 18 Apr 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IsVD6mVu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B316F830
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455392; cv=none; b=dWEt+tx80xU0oaKZMo66Lpk6XZedK3jkV22osQ9ui4KepdamKdD2hosidazpNy044RAFXFFNMTbRXZMaFM19Iq5RRQ6Z0WBCN1yBX0tzPPfjiJ77fAPYlaM/jD8ezSL/eLwSlbspt1/YacigTbuAMjSgLjFeA7MQK2K5ch+uIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455392; c=relaxed/simple;
	bh=p/dF7JMox6BrqaZIBuvA5pvpXeCd9gZESmiZZctmfkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHBjJmUePJCPPS/EnQHrvBgr3xtDk2h7iyUI6BlO4PDcq2G/gdOS7amCjxkTLnG9ZgyZjs1GZZY0SGWVzMG+DhHtOcVMz8/KE2UFasXCV/Bc3Xn35GUkhfJ4dMzT2ivdaFnUnDAysJnQaafpdQiN2onmEk6X6mlIhuttKMMNgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IsVD6mVu; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Apr 2024 08:49:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713455387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziaS2a2JLbKpn9yWeB1wELMDTiamfefOEg/5bnjE4gE=;
	b=IsVD6mVumHoODJn7B/wl4ZNhpjw8ihVo+pRJpCI3y59wPDzivclT2aF5c/mQG55Mp+pFY+
	hEtMsbiS1SKwooNaoh23/Hf/B/G5u+7a4sg+2RchIP7qIEsZEfKw3QL2xjHtkUE6VINkrO
	tqr5ma/KinE2a4BcflYzP6lbU5+7ekY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
Message-ID: <4o4qxf3tcos5rl7h2noldeg3knqkgc2ph36tv2cceourbsxgas@xicxkcacme7v>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 18, 2024 at 01:00:30PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 18/04/2024 04.21, Yosry Ahmed wrote:
> > On Tue, Apr 16, 2024 at 10:51 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > > 
> > > This patch aims to reduce userspace-triggered pressure on the global
> > > cgroup_rstat_lock by introducing a mechanism to limit how often reading
> > > stat files causes cgroup rstat flushing.
> > > 
> > > In the memory cgroup subsystem, memcg_vmstats_needs_flush() combined with
> > > mem_cgroup_flush_stats_ratelimited() already limits pressure on the
> > > global lock (cgroup_rstat_lock). As a result, reading memory-related stat
> > > files (such as memory.stat, memory.numa_stat, zswap.current) is already
> > > a less userspace-triggerable issue.
> > > 
> > > However, other userspace users of cgroup_rstat_flush(), such as when
> > > reading io.stat (blk-cgroup.c) and cpu.stat, lack a similar system to
> > > limit pressure on the global lock. Furthermore, userspace can easily
> > > trigger this issue by reading those stat files.
> > > 
> > > Typically, normal userspace stats tools (e.g., cadvisor, nomad, systemd)
> > > spawn threads that read io.stat, cpu.stat, and memory.stat (even from the
> > > same cgroup) without realizing that on the kernel side, they share the
> > > same global lock. This limitation also helps prevent malicious userspace
> > > applications from harming the kernel by reading these stat files in a
> > > tight loop.
> > > 
> > > To address this, the patch introduces cgroup_rstat_flush_ratelimited(),
> > > similar to memcg's mem_cgroup_flush_stats_ratelimited().
> > > 
> > > Flushing occurs per cgroup (even though the lock remains global) a
> > > variable named rstat_flush_last_time is introduced to track when a given
> > > cgroup was last flushed. This variable, which contains the jiffies of the
> > > flush, shares properties and a cache line with rstat_flush_next and is
> > > updated simultaneously.
> > > 
> > > For cpu.stat, we need to acquire the lock (via cgroup_rstat_flush_hold)
> > > because other data is read under the lock, but we skip the expensive
> > > flushing if it occurred recently.
> > > 
> > > Regarding io.stat, there is an opportunity outside the lock to skip the
> > > flush, but inside the lock, we must recheck to handle races.
> > > 
> > > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > 
> > As I mentioned in another thread, I really don't like time-based
> > rate-limiting [1]. Would it be possible to generalize the
> > magnitude-based rate-limiting instead? Have something like
> > memcg_vmstats_needs_flush() in the core rstat code?
> > 
> 
> I've taken a closer look at memcg_vmstats_needs_flush(). And I'm
> concerned about overhead maintaining the stats (that is used as a filter).
> 
>   static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>   {
> 	return atomic64_read(&vmstats->stats_updates) >
> 		MEMCG_CHARGE_BATCH * num_online_cpus();
>   }
> 
> I looked at `vmstats->stats_updates` to see how often this is getting
> updated.  It is updated in memcg_rstat_updated(), but it gets inlined into a
> number function (__mod_memcg_state, __mod_memcg_lruvec_state,
> __count_memcg_events), plus it calls cgroup_rstat_updated().
> Counting invocations per sec (via funccount):
> 
>   10:28:09
>   FUNC                                    COUNT
>   __mod_memcg_state                      377553
>   __count_memcg_events                   393078
>   __mod_memcg_lruvec_state              1229673
>   cgroup_rstat_updated                  2632389
> 

Is it possible for you to also measure the frequency of the unique
callstacks calling these functions? In addition the frequency of the
each stat item update would be awesome.

> 
> I'm surprised to see how many time per sec this is getting invoked.
> Originating from memcg_rstat_updated() = 2,000,304 times per sec.
> (On a 128 CPU core machine with 39% idle CPU-load.)
> Maintaining these stats seems excessive...
> 
> Then how often does the filter lower pressure on lock:
> 
>   MEMCG_CHARGE_BATCH(64) * 128 CPU = 8192
>   2000304/(64*128) = 244 time per sec (every ~4ms)
>   (assuming memcg_rstat_updated val=1)
> 

It seems like we have opportunities to improve the stat update side and
we definitely need to improve the stat flush side. One issue from the
memcg side is that kernel has to do a lot of work, so we should be
reducing that.

