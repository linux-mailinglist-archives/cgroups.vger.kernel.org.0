Return-Path: <cgroups+bounces-9167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A1B26DB6
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A1E17EF7F
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04225FA24;
	Thu, 14 Aug 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YPw7uzxK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60D2192E4
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192710; cv=none; b=uJizVzJOUROClmIg+i7eFMzQAs/a0kte4m469+TLNFjiMbUNGRGdoUXPItdONtXtlBiZFptpwpq2DrAsDHkIC3wunxAN09lDdx3r2jbAZSEF8ZzdYNXdRxxt9AxuZ5QWTU13TwSQgqT+HdNf6hOtF+oRdvfmFri6M1ifWLIeiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192710; c=relaxed/simple;
	bh=v9/GR2+xGr6Q0FIdq/r8OCyWYCmchbcxSkWevjx7I0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQAEpeTeNCtkI+9qQ5tbHWzSRDusvkKevtHRVnsBWpQmMa5E8QZyyObylb+iYJjG2cSxeHtVf37oExPzIZos5AdtPfxyt0A+9nncRSn5MEi5PgepjG0LuHk9gBCkMA0zTtptixUmsrLuCXujnInyW9VJSrOTnhP7U54XUUgFacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YPw7uzxK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 10:31:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755192706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh0ycP22zg5SwNs/Sb7kUvxkXVrYAjgQSgUwJWJ2qBI=;
	b=YPw7uzxKbUm4M5AjV2Aa4v0RZDZyekL6TSoj+zSl53Zsqa8t/9IKw9FyIDkO9POAeEh6xp
	DsjMM5khXrgGQu9clFlekVh2UEcM99xFCt2tIlEIvvTzbcX76SYf+PiRi5dWrtkiwYLrmi
	wP2vR4ldS2BSSzjgsV14Buoq8kyryFo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matyas Hurtik <matyas.hurtik@cdn77.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <okedwjaepuw2b55eki6zyn6l3ngstmml2amoebyvc4orzsxqjs@45tbzonckct5>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
 <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
 <qsncixzj7s7jd7f3l2erjjs7cx3fanmlbkh4auaapsvon45rx3@62o2nqwrb43e>
 <4937aca8-8ebb-47d5-986f-7bb27ddbdaba@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4937aca8-8ebb-47d5-986f-7bb27ddbdaba@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 06:27:22PM +0200, Matyas Hurtik wrote:
> On 8/7/25 10:52 PM, Shakeel Butt wrote:
> 
> > We definitely don't need a global lock. For memcg->net_pressure_lock, we
> > need to be very clear why we need this lock. Basically we are doing RMW
> > on memcg->socket_pressure and we want known 'consistently' how much
> > further we are pushing memcg->socket_pressure. In other words the
> > consistent value of diff. The lock is one way to get that consistent
> > diff. We can also play some atomic ops trick to get the consistent value
> > without lock but I don't think that complexity is worth it.
> 
> Hello,
> 
> 
> I tried implementing the second option, making the diff consistent using
> atomics.
> Would something like this work?
> 
> if (level > VMPRESSURE_LOW) {
>   unsigned long new_socket_pressure;
>   unsigned long old_socket_pressure;
>   unsigned long duration_to_add;
>   /*
>     * Let the socket buffer allocator know that
>     * we are having trouble reclaiming LRU pages.
>     *
>     * For hysteresis keep the pressure state
>     * asserted for a second in which subsequent
>     * pressure events can occur.
>     */
>   new_socket_pressure = jiffies + HZ;

Add an if condition here if old_socket_pressure is already equal to
the new_socket_pressure and skip all of the following.

>   old_socket_pressure = atomic_long_xchg(
>     &memcg->socket_pressure, new_socket_pressure);
> 
>   duration_to_add = jiffies_to_usecs(
>     min(new_socket_pressure - old_socket_pressure, HZ));

Here if duration_to_add is zero skip the upwards following traversal.

> 
>   do {
>     atomic_long_add(duration_to_add, &memcg->socket_pressure_duration);
>   } while ((memcg = parent_mem_cgroup(memcg)));
> }
> 
> memcg->socket_pressure would need to be changed into atomic_long_t,
> but we avoid adding the memcg->net_pressure_lock.

Awesome, seems fine to me.

> 
> > We don't need memcg->net_pressure_lock's protection for
> > sk_pressure_duration of the memcg and its ancestors if additions to
> > sk_pressure_duration are atomic.
> 
> With regards to the hierarchical propagation I noticed during testing that
> vmpressure() was sometimes called with memcgs, created for systemd oneshot
> services, that were at that time no longer present in the /sys/fs/cgroup
> tree.
> This then made their parent counters a lot larger than just sum of the
> subtree
> plus value of self. Would this behavior be correct?
> 

That is intentional. You can see couple of other similar monotonically
increasing stats in memory.stat like workkingset refaults and demotes.


