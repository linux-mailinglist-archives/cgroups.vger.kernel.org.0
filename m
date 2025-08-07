Return-Path: <cgroups+bounces-9025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461EB1DE7D
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99EE1AA5174
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 20:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB62230BE1;
	Thu,  7 Aug 2025 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cv+2G9TS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E048227EAA
	for <cgroups@vger.kernel.org>; Thu,  7 Aug 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599973; cv=none; b=DjbDtKtSV1jtvikOl9J254bgkUtywUnv5sXcB+ilMlEhzNrWfifaJw1rj/wweI2ECrdO+zc9BSgDLWaMo9UIn4U3BDkIzBkr2wN2buGEmNfFZq5JVKPy0iBm/BIDdLLQj94EnZGyrJcRWNmr680usmfii1yRyYbiW4sba+JdbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599973; c=relaxed/simple;
	bh=PoqJp2XFDsH+Bn5FzVG6Kjp14YnL+M01555xKIT21l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpAgf3gZso2hjM+cjONmYgR8b8ZDfRBq3wkWNeHfCIsTV1KK5fB/3yFYRuatj1S7jVC15PUdU2K3j/q4BvtYbzilRrMWMTP0b47e+ie2rYrBgcyfL4mzOACRjwFJwLmEr8XodZtXyipMJ0HVFZiyoAFi00f8Jsh4dBBbWkpohNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cv+2G9TS; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Aug 2025 13:52:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754599967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOPUpSlPIiZZc2oV/h1m7LERhF2i5s7DpFEXBoy92xw=;
	b=Cv+2G9TS/mizvM7tGRu57w71x5ym/SU6RYjfXnEqPUY6X3fa1F5zCW/NAMWE1gHtrmjqgq
	v/jXuwxYX0Y6ACEqaL4ydjvAtqxb76JAAOUFrtO06qMgpWW9hjJ0WkDTz1I93VKLwXj8kL
	+lcikozCwODHKJSSghRHUhxds3NKhAo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
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
Message-ID: <qsncixzj7s7jd7f3l2erjjs7cx3fanmlbkh4auaapsvon45rx3@62o2nqwrb43e>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
 <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 07, 2025 at 12:22:01PM +0200, Daniel Sedlak wrote:
> On 8/7/25 1:34 AM, Shakeel Butt wrote:
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
> 
> Thanks for the KCSAN recommendation, I didn't know about this sanitizer.
> 
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
> 
> Thanks for the snippet, will incorporate it.

Cool though that is just like a pseudo code, so be careful in using it.

> 
> > > > 
> > > >          if (!spin_trylock(memcg->net_pressure_lock))
> > > >                  return;
> > > > 
> > > >          socket_pressure = jiffies + HZ;
> > > >          diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> > > 
> > > READ_ONCE() should be unnecessary here.
> > > 
> > > > 
> > > >          if (diff) {
> > > >                  WRITE_ONCE(memcg->socket_pressure, socket_pressure);
> > > >                  // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
> > > >                  // OR
> > > >                  // while (memcg) {
> > > >                  //      memcg->sk_pressure_duration += diff;
> > > >                  //      memcg = parent_mem_cgroup(memcg);
> > > 
> > > The parents' sk_pressure_duration is not protected by the lock
> > > taken by trylock.  Maybe we need another global mutex if we want
> > > the hierarchy ?
> > 
> > We don't really need lock protection for sk_pressure_duration. The lock
> 
> By this you mean that we don't need the possible new global lock or the
> local memcg->net_pressure_lock?

We definitely don't need a global lock. For memcg->net_pressure_lock, we
need to be very clear why we need this lock. Basically we are doing RMW
on memcg->socket_pressure and we want known 'consistently' how much
further we are pushing memcg->socket_pressure. In other words the
consistent value of diff. The lock is one way to get that consistent
diff. We can also play some atomic ops trick to get the consistent value
without lock but I don't think that complexity is worth it. Third option
might be to remove our consistency requirement for diff as the error is
bound to HZ (as mentioned by Kuniyuki) but I think this code path is not
performance critical to make this option worth it. So, option 1 of
simple memcg->net_pressure_lock is good enough.

We don't need memcg->net_pressure_lock's protection for
sk_pressure_duration of the memcg and its ancestors if additions to
sk_pressure_duration are atomic.

Someone might notice that we are doing upward traversal for
memcg->sk_pressure_duration but not for memcg->socket_pressure. We can
do that if we decide to optimize mem_cgroup_under_socket_pressure().
However that is orthogonal work. Also the consistency requirement will
change.

