Return-Path: <cgroups+bounces-2540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E98A735F
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349271C21775
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A95F1369B9;
	Tue, 16 Apr 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg/YRJvi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B251332A0
	for <cgroups@vger.kernel.org>; Tue, 16 Apr 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292886; cv=none; b=ZG3+OgmnZdrtVntK7ayfY7I9yybZmOHIyyHEAbxwWHbjTQ7tBTQ1f43DGkz96YA+WpIKAevjQC3MDNL8qMNT8ns/Ma/6JwEFNQtq/oBHoenjveSPQTQTDEJmxlhwcPiUDj8JfdLSLuyr3QS2cphBqISY7yNYYAljBSiWa50mJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292886; c=relaxed/simple;
	bh=bmzjTTFBWVz12gXu4GvtCl6/if4RyTfGK18ivEjF9FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpumgiEVQYI3qHaJ/jZhirl0sBnGAtmqBjxtc6y4DwUmAksb/I86cdxhjzfVQ72RHJ+Mu73+YkwWfUS+S2Et2NBCLPB63bYc9uhHs9uylt8UWmg6gQ3iDVIDjkrYjFQiY0X7svZVkhBCWOoY+uP/uFjVOxZZ2HfsJD2gsz3ey80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg/YRJvi; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Apr 2024 11:41:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713292882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AARNMAAmv0ZXNznpgmWdVj/ZM3y0d0nkfa+epz38edo=;
	b=Tg/YRJvi+gsorMTVglfkGMo25xZslc2DG+Q3niadqPeDe0UXXpz//oQEO/8rXho+keqy0O
	fT0WCzxTkS7d3YdtM/X2cSn/g/keKmFcCaY8tWIWLgWq52vcuvbfGQXocNILOLXpK6doWM
	I4E72O2k43z0IjPC4afmINIRpSVCOFU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jesper Dangaard Brouer <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeelb@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, 
	Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ivan Babrou <ivan@cloudflare.com>
Subject: Re: Advice on cgroup rstat lock
Message-ID: <f6daabzdesdwo7zdouexow5mdub3qnzr7e67lonmhh3itjgk5j@qw3xpvqoyb7j>
References: <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
 <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
 <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
 <4fd9106c-40a6-415a-9409-c346d7ab91ce@redhat.com>
 <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
 <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
 <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org>
 <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
 <9f6333ec-f28c-4a91-b7b9-07a028d92225@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6333ec-f28c-4a91-b7b9-07a028d92225@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 16, 2024 at 04:22:51PM +0200, Jesper Dangaard Brouer wrote:

Sorry for the late response and I see there are patches posted as well
which I will take a look but let me put somethings in perspective.

> 
> 
> > 
> > I personally don't like mem_cgroup_flush_stats_ratelimited() very
> > much, because it is time-based (unlike memcg_vmstats_needs_flush()),
> > and a lot of changes can happen in a very short amount of time.
> > However, it seems like for some workloads it's a necessary evil :/
> > 

Other than obj_cgroup_may_zswap(), there is no other place which really
need very very accurate stats. IMO we should actually make ratelimited
version the default one for all the places. Stats will always be out of
sync for some time window even with non-ratelimited flush and I don't
see any place where 2 second old stat would be any issue.

> 
> I like the combination of the two mem_cgroup_flush_stats_ratelimited()
> and memcg_vmstats_needs_flush().
> IMHO the jiffies rate limit 2*FLUSH_TIME is too high, looks like 4 sec?

4 sec is the worst case and I don't think anyone have seen or reported
that they are seeing 4 sec delayed flush and if it is happening, it
seems like no one cares. 

> 
> 
> > I briefly looked into a global scheme similar to
> > memcg_vmstats_needs_flush() in core cgroups code, but I gave up
> > quickly. Different subsystems have different incomparable stats, so we
> > cannot have a simple magnitude of pending updates on a cgroup-level
> > that represents all subsystems fairly.
> > 
> > I tried to have per-subsystem callbacks to update the pending stats
> > and check if flushing is required -- but it got complicated quickly
> > and performance was bad.
> > 
> 
> I like the time-based limit because it doesn't require tracking pending
> updates.
> 
> I'm looking at using a time-based limit, on how often userspace can take
> the lock, but in the area of 50ms to 100 ms.

Sounds good to me and you might just need to check obj_cgroup_may_zswap
is not getting delayed or getting stale stats.

> 
> 
> With a mutex lock contention will be less obvious, as converting this to
> a mutex avoids multiple CPUs spinning while waiting for the lock, but
> it doesn't remove the lock contention.
> 

I don't like global sleepable locks as those are source of priority
inversion issues on highly utilized multi-tenant systems but I still
need to see how you are handling that.

> Userspace can easily triggered pressure on the global cgroup_rstat_lock
> via simply reading io.stat and cpu.stat files (under /sys/fs/cgroup/).
> I think we need a system to mitigate lock contention from userspace
> (waiting on code compiling with a proposal).  We see normal userspace
> stats tools like cadvisor, nomad (and systemd) trigger this by reading
> all the stat file on the system and even spawning parallel threads
> without realizing that kernel side they share same global lock.
> 
> You have done a huge effort to mitigate lock contention from memcg,
> thank you for that.  It would be sad if userspace reading these stat
> files can block memcg.  On production I see shrink_node having a
> congestion point happening on this global lock.

Seems like another instance where we should use the ratelimited version
of the flush function.

