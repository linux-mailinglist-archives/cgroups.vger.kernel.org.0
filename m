Return-Path: <cgroups+bounces-9234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D324B288C8
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 01:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1117AC3EA9
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0E2820B6;
	Fri, 15 Aug 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUalADxH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732723C503
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300715; cv=none; b=RUpTsfWysHNDmW+0e4PN6LlZkPL5ChcJYwaXULIZRvNZHWs+m101BzuGTIrtIivG6CRTfdbeE9ZzFPuAcFIb8PxLC5q0bDEwyWs8yfotqLH5BEHdPtMw9D/XUWAgyLmF5DmTiC3LT7hiuq1B3V5WHGWj9yG4YfORVWiXOqsbw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300715; c=relaxed/simple;
	bh=IjyK+DpeelkhKjQ4pKnvMKVGUp3feARBxTF26AxXLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw5LNSoea/bMSVTAt1blgw53anNcEmFQUtE90x4nq4qoZB+0jFmvJ7V3BIUamhTWqzLE8sK5+O5jIjw39D9Z+37YvrQBje3VCHxDW1RIdDtcw0izJv7m0et2BvhrPICzf79EKgqb+9mWoKNpmlP9N4IjCBloTpPSX/TmjcUZ/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUalADxH; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 16:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755300701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8mWAMiGacIPdo/U9tWrZ4G95PCsJeEqc6aHk78b6x74=;
	b=vUalADxHq4n5TJyKV8RytL6pshWYqmbgSJ52T0tz2UYUci8EEBIB85xnniIlNi5ddQLAR7
	ucGIjd839HqjVorE6RTr1GxfMme8r59DDlekkpWP/EcvAs2oI7tWmFQdBFW5MpBXbUHFK4
	+Rh2quaCh0LQ46ltOhdBynDEnItymNI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <3x5m5rvbvtnta6lqyyx6k3uew4zhg5nxt2wmadkpi5t6tlsko6@peltw6axwvkg>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:09PM +0000, Kuniyuki Iwashima wrote:
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
> 
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.
> 
> In the latter case, sk->sk_memcg is not what we want.  So, we fix
> it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> 
> Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> under #ifdef CONFIG_SOCK_CGROUP_DATA.
> 
> The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> correctly.
> 
> Let's move the code out of the wrong ifdef guard.
> 
> Note that sk->sk_memcg is freed in sk_prot_free() and the parent
> sk holds the refcnt of memcg->css here, so we don't need to use
> css_tryget().
> 
> Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

