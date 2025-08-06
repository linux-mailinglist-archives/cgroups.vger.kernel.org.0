Return-Path: <cgroups+bounces-9011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189DB1CF86
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF93D3A7B21
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 23:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7022DFA7;
	Wed,  6 Aug 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxuonsxG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9AE14D283
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524322; cv=none; b=TRDiJAIo4+WRZoUoE4qGuoYXX/mTQpfPbpQaZge8kC8PzJwTHF94ZomT0LC70lazlVfKSZxONLqVc2J0wykstSWikBxJHHVedfsoOyYkAaZ5LNuWKb4leS7PeYidmFBBAkWi5NKBWIgv71Kozh6xb2n4ZkCdbmlzew5TcikW4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524322; c=relaxed/simple;
	bh=H3tUS4tMw+ALA3XFesO6J1gYy/juddA6KF1OWw1DaDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9B1dRIro62FtGWkyYDLl+wGbvTqyvQaE85xzxt8bdpShwpfNp7eQuwdIrmKaxjYs02ZiQQC4ZeUYjmVLRwInr/mEj+AfTfOuOb0QJIfrz8P/7yip7eb8sIgFkdxrDvnPVmC0T+V62XT4aVa/jX4OF3AyJ2XY7S+/ioRxZ6KKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxuonsxG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 16:51:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754524318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wP0O1tbMn8HVhzrrMtN0N9Bu4W03vBBOSwFroD8yV8=;
	b=MxuonsxGj9mLWiEibLGLoux3An6eyPmDLEpSO+AXBrUnZHWjMFnsjvIjs3km8kAYy1b3O8
	/O/7fHFx5NNDWISuRCDlhqVKSwoXL9wIzA7hIHNo4c0o2srnxCM/JTiQ5Bl3GpYykH5kcr
	FD6toaiINNAAWTaQoYKXpz0KNf4ber0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <ai34al6aocctgjxob7pshhm4lyqfnzlytjefhlum6dxwjcx26o@fj2ca5jdqxa7>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
 <CAAVpQUB_aEcbOJR==z=KbfC1FtWi2NM_wNm_p+9vL1xqfw7cEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUB_aEcbOJR==z=KbfC1FtWi2NM_wNm_p+9vL1xqfw7cEQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 06, 2025 at 04:40:45PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 6, 2025 at 4:34 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Aug 06, 2025 at 03:01:44PM -0700, Kuniyuki Iwashima wrote:
> > > On Wed, Aug 6, 2025 at 2:54 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> > > > > > > +                     socket_pressure = jiffies + HZ;
> > > > > > > +
> > > > > > > +                     jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> > > > > > > +                     memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);
> > > > > >
> > > > > > KCSAN will complain about this. I think we can use atomic_long_add() and
> > > > > > don't need the one with strict ordering.
> > > > >
> > > > > Assuming from atomic_ that vmpressure() could be called concurrently
> > > > > for the same memcg, should we protect socket_pressure and duration
> > > > > within the same lock instead of mixing WRITE/READ_ONCE() and
> > > > > atomic?  Otherwise jiffies_diff could be incorrect (the error is smaller
> > > > > than HZ though).
> > > > >
> > > >
> > > > Yeah good point. Also this field needs to be hierarchical. So, with lock
> > > > something like following is needed:
> > > >
> > > >         if (!spin_trylock(memcg->net_pressure_lock))
> > > >                 return;
> > > >
> > > >         socket_pressure = jiffies + HZ;
> > > >         diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> > >
> > > READ_ONCE() should be unnecessary here.
> > >
> > > >
> > > >         if (diff) {
> > > >                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
> > > >                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
> > > >                 // OR
> > > >                 // while (memcg) {
> > > >                 //      memcg->sk_pressure_duration += diff;
> > > >                 //      memcg = parent_mem_cgroup(memcg);
> > >
> > > The parents' sk_pressure_duration is not protected by the lock
> > > taken by trylock.  Maybe we need another global mutex if we want
> > > the hierarchy ?
> >
> > We don't really need lock protection for sk_pressure_duration. The lock
> > is only giving us consistent value of diff. Once we have computed the
> > diff, we can add it to sk_pressure_duration of a memcg and all of its
> > ancestor without lock.
> 
> Maybe I'm wrong but I was assuming two vmpressure() called
> concurrently for cgroup-C and cgroup-D, and one updates
> cgroup-C's duration and another updates C&D duration.
> 
> cgroup-A -> cgroup-B -> cgroup-C -> cgroup-D
> 
> Could that happen ?  Even if it's yes, we could use atomic ops.

I am not getting the hierarchy you are using but yes concurrent updates
to sk_pressure_duration can happen and simple atomic_add is good enough
without any locking.

