Return-Path: <cgroups+bounces-8858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83CB0E0F5
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212D9AC16A4
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3851279DDB;
	Tue, 22 Jul 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ljxgpn9A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE0279DC6
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199559; cv=none; b=eX4QSQQbe3a9jm+He4fmcxY4Fr0kTlajmSLY8YYozXnB6djS1pCaTiAVLcdie3k0UJcwsb7IXuwR5rEPdHtNQUbY2TdrB3aackn/8ZXj77lmAwckt4R+xYA0nzCiyyKH8q0HFxHG2cNQH+HJ/5NFdD+K8HucCEsrKLZ0EmYCR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199559; c=relaxed/simple;
	bh=gGf29o3xZl+D/tSZ6cCokp/L2Hj8dFU3BoIR8OgD/Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk+LynkSWXIRnNNYdo55g6hZ2IT0nFsgJtZvjtEPz09cm7fT1HeqdJapAWtvajAblZ5RHiQ/L3XiisqXDHga2O0wYctlBQtdBdYyns0BFuS4OdrJcXhtBJNHPA17qsMgmnrKjHUnO4wdOdmSwweqwvgUGWBuYN7K77J/sqSxMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ljxgpn9A; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 08:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753199554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3XocA49nvohXItD3mzL5WPudh9EWNp7gI9bByeR0sQ=;
	b=Ljxgpn9AGU0hD67ioPTX6Wihgl2buBotwbluc/8RHH3rd1Bffik+N1YJ7tgTdUxM5u+pmV
	N1YRZmLvBRdjDW+LNf/fJEUgtgOUIJFW5q6OTGSye3qVuNaHdB28buqAJKgnPY5kUY9B64
	0UKNcb59Rvn+QH/FM3LtF/KDSQWr8Zg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 08:24:23AM -0700, Eric Dumazet wrote:
> On Tue, Jul 22, 2025 at 8:14 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > > buffers and charge memory to per-protocol global counters pointed to by
> > > sk->sk_proto->memory_allocated.
> > >
> > > When running under a non-root cgroup, this memory is also charged to the
> > > memcg as sock in memory.stat.
> > >
> > > Even when memory usage is controlled by memcg, sockets using such protocols
> > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> > >
> > > This makes it difficult to accurately estimate and configure appropriate
> > > global limits, especially in multi-tenant environments.
> > >
> > > If all workloads were guaranteed to be controlled under memcg, the issue
> > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > >
> > > In reality, this assumption does not always hold, and a single workload
> > > that opts out of memcg can consume memory up to the global limit,
> > > becoming a noisy neighbour.
> > >
> >
> > Sorry but the above is not reasonable. On a multi-tenant system no
> > workload should be able to opt out of memcg accounting if isolation is
> > needed. If a workload can opt out then there is no guarantee.
> 
> Deployment issue ?
> 
> In a multi-tenant system you can not suddenly force all workloads to
> be TCP memcg charged. This has caused many OMG.

Let's discuss the above at the end.

> 
> Also, the current situation of maintaining two limits (memcg one, plus
> global tcp_memory_allocated) is very inefficient.

Agree.

> 
> If we trust memcg, then why have an expensive safety belt ?
> 
> With this series, we can finally use one or the other limit. This
> should have been done from day-0 really.

Same, I agree.

> 
> >
> > In addition please avoid adding a per-memcg knob. Why not have system
> > level setting for the decoupling. I would say start with a build time
> > config setting or boot parameter then if really needed we can discuss if
> > system level setting is needed which can be toggled at runtime though
> > there might be challenges there.
> 
> Built time or boot parameter ? I fail to see how it can be more convenient.

I think we agree on decoupling the global and memcg accounting of
network memory. I am still not clear on the need of per-memcg knob. From
the earlier comment, it seems like you want mix of jobs with memcg
limited network memory accounting and with global network accounting
running concurrently on a system. Is that correct?

I expect this state of jobs with different network accounting config
running concurrently is temporary while the migrationg from one to other
is happening. Please correct me if I am wrong.

My main concern with the memcg knob is that it is permanent and it
requires a hierarchical semantics. No need to add a permanent interface
for a temporary need and I don't see a clear hierarchical semantic for
this interface.

I am wondering if alternative approches for per-workload settings are
explore starting with BPF.




