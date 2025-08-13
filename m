Return-Path: <cgroups+bounces-9121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B60B24259
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 09:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CE61BC3D84
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45A2D3EE3;
	Wed, 13 Aug 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gG4+WM5I"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE02BEFEB
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069111; cv=none; b=lFDomDldcsIRdJcOOid9EUDHp1/1kdaVrxJ61NzCQqh+z+/7PXQnJx5gNFeFvq4454wWgR9ImbG9ziGYcSqhqYuiZAo98IUq441j5+GOfS5DBiXHJlgL1YNXleFolvXF9Ro7O+bfS/l0eUO0nyd4lpnViMkPxDkvul79qKvYtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069111; c=relaxed/simple;
	bh=j5cndD/Yt7hg4UEX0fFeQVI5gpYpcjUZXvJ2XEBYzHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJr+SdGAVj7NXprCjsZ0iQzcC/JerBsIIXG6cCJc9HUwnm5yR8FfppWZ3NiNL0CrKg71//v0UscfGwjLiWIqGVEfUblofZK5+kQZgy5pX98YatlZviszGku17vhAOi24iAfZRoUayrIctQ6R+mowOFiY8BhWszatikv3w90/Euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gG4+WM5I; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Aug 2025 00:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755069097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZFsYJiyB1fvxRtIFfJFidT6INioyMRvmFKceuBeMbE=;
	b=gG4+WM5IZTev5FDHmnVkWiRF1CQo6nK2IILnadjEoI9rVXYIWj5lqRHGRPWSTwTu/MyN1z
	pTwxSpKzCwmyNqhJ3fP1/velQ2CJGQd8gNXMYsF7mK5SHPjDHm8PvczlF7tQireXlSgce/
	ApBgrQ6UG9VPQre3jLqz44suXJwDq8M=
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
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-13-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> When running under a non-root cgroup, this memory is also charged to the
> memcg as "sock" in memory.stat.
> 
> Even when a memcg controls memory usage, sockets of such protocols are
> still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> 
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
> 
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes that
> belong to the root cgroup or opt out of memcg can consume memory up to
> the global limit, becoming a noisy neighbour.

Processes running in root memcg (I am not sure what does 'opt out of
memcg means') means admin has intentionally allowed scenarios where
noisy neighbour situation can happen, so I am not really following your
argument here.

> 
> Let's decouple memcg from the global per-protocol memory accounting if
> it has a finite memory.max (!= "max").

Why decouple only for some? (Also if you really want to check memcg
limits, you need to check limits for all ancestors and not just the
given memcg).

Why not start with just two global options (maybe start with boot
parameter)?

Option 1: Existing behavior where memcg and global TCP accounting are
coupled.

Option 2: Completely decouple memcg and global TCP accounting i.e. use
mem_cgroup_sockets_enabled to either do global TCP accounting or memcg
accounting.

Keep the option 1 default.

I assume you want third option where a mix of these options can happen
i.e. some sockets are only accounted to a memcg and some are accounted
to both memcg and global TCP. I would recommend to make that a followup
patch series. Keep this series simple and non-controversial.


