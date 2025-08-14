Return-Path: <cgroups+bounces-9184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FFDB27102
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 23:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB31C81A37
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99783279DAC;
	Thu, 14 Aug 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1Lffbdo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C10275B19
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207877; cv=none; b=Z8Yv2Biu+0TbbLpy1ZBhoFKTY1cMA8bXNCoJGjm8Hir67uGQj0XMQmzYVQaHR6ZKHfg6bLAyzQ/qXCoq5HJkXPtg8eA+4L+IxT4f1KhUsgOrs848fLI6MTeYZp0SP6G8GV/nTHBLoFMysfnb6ZZTBIgIHnA/U2c6ZdQlxOoCmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207877; c=relaxed/simple;
	bh=DUPr5MQoUxFFoqkAGNzRO/DGWT8OKJ2LYBfoUBU+Xww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODgATRDmDGoDBtfgOIPHGQIEx3oTg56RdlJ19BD+jYQ7EKY4MsanTd8GkJ+ZqYKRCOYgUoyu/AvOLXm31aSbfx5u3wf7pEgZs+o3GYcLjUzwnj7cXatVBvwM9iG553Nzi2zNgcH66BqLeM/wjEgRFTZ6Sm/Ein8pcLsJAgR9lGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1Lffbdo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 14:44:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755207863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19ByPHkfjF5Lwww0ZNwzVRVwJ3xsKPEqJn5AnAvA/3U=;
	b=t1Lffbdo8V4eR10ikc1QCrxW10AzvrgCdPZA5YBsQ6+OleiyAIQA4YUzCr+08bP8URWDg8
	I3WGm7qBbMemh6lNZgLU3P0L13FkBioWFv+J8o7EcD+mc9jCxyJL+fK14ZPQz1+kwyZCWI
	y3C6iL3Q61oALehShym+eszZC21gE8E=
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
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814200912.1040628-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
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
> Let's wrap sock_create_kern() for subflow with set_active_memcg()
> using the parent sk->sk_memcg.
> 
> Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  mm/memcontrol.c     |  5 ++++-
>  net/mptcp/subflow.c | 11 +++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dd7fbed5a94..450862e7fd7a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  	if (!in_task())
>  		return;
>  
> +	memcg = current->active_memcg;
> +

Use active_memcg() instead of current->active_memcg and do before the
!in_task() check.

Basically something like following:

	memcg = active_memcg();
	/* Do not associate the sock with unrelated interrupted task's memcg. */
	if (!in_task() && !memcg)
		return;

>  	rcu_read_lock();
> -	memcg = mem_cgroup_from_task(current);
> +	if (likely(!memcg))
> +		memcg = mem_cgroup_from_task(current);
>  	if (mem_cgroup_is_root(memcg))
>  		goto out;
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 3f1b62a9fe88..a4809054ea6c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1717,14 +1717,6 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
>  	/* only the additional subflows created by kworkers have to be modified */
>  	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
>  	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
> -#ifdef CONFIG_MEMCG
> -		struct mem_cgroup *memcg = parent->sk_memcg;
> -
> -		mem_cgroup_sk_free(child);
> -		if (memcg && css_tryget(&memcg->css))
> -			child->sk_memcg = memcg;
> -#endif /* CONFIG_MEMCG */
> -
>  		cgroup_sk_free(child_skcd);
>  		*child_skcd = *parent_skcd;
>  		cgroup_sk_clone(child_skcd);
> @@ -1757,6 +1749,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct net *net = sock_net(sk);
> +	struct mem_cgroup *memcg;
>  	struct socket *sf;
>  	int err;
>  
> @@ -1766,7 +1759,9 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	if (unlikely(!sk->sk_socket))
>  		return -EINVAL;
>  
> +	memcg = set_active_memcg(sk->sk_memcg);
>  	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
> +	set_active_memcg(memcg);
>  	if (err)
>  		return err;
>  
> -- 
> 2.51.0.rc1.163.g2494970778-goog
> 

