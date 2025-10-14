Return-Path: <cgroups+bounces-10747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319EBDB414
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E17C19A3512
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD0306B0D;
	Tue, 14 Oct 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l8rkUGSB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7B2DC35A
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473994; cv=none; b=OrMHf8zzSaQympBlVtp4V467nRDxq6D8VW7pheefNH+5AdO5XsTcMLtSAqsYjKy+2Eld4MMIPHX6B8uYL6gA4PCY2LV4kIZEmFOofDjETDAEkt1J+SOeS2B6Dia/BYfP9fkk6Ff45Ez0divqrAgVqAKYPonHXVSCoRws80oTbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473994; c=relaxed/simple;
	bh=K6SR03oWZbp1zF3cy64l53yWJxRSDh3vlbnAx+WnxpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsL9rrxJAyl8hOoFSkGlh/Lu6MUNZnYtyD7a94duZ+VTd1p/miuvf1DBQdlAw3oqBOMjCj+2IViXHxYq7g83IbzF2QRKw4Rtf5W5tT+0R3iH8s/qPd7Eh+qCaBmz1KILyonANNSfL/+Dps+/6X8doH4A6zV7kt9urzkkkLxuldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l8rkUGSB; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 13:32:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760473979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwSCDIXETHGxMb4XVhxx+vCGIG2/jXfEf6gnZuLgFYM=;
	b=l8rkUGSBKEErpxxVuhjASwkfNV0le9MZVTgo0/omQyPwbZWoxaOHRfDsXonsm2OiEnPEVz
	W5vMr040iTYoxIiuHH9PuZwFY8z9h94Ft3umWPAWbd4NJ7FVCaq4rGQ6ORDABsdwVb5eaP
	QJR9wYJ8cy/x7gXJhRCQJSVURJFVwsc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev>
 <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
 <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev>
 <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev>
 <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
[...]
> > > > > How about we track the actions taken by the callers of
> > > > > mem_cgroup_sk_under_memory_pressure()? Basically if network stack
> > > > > reduces the buffer size or whatever the other actions it may take when
> > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
> > > > > is what I think is needed here, at least for the debugging use-case.
> 
> I am not against it, but I feel that conveying those tracked actions (or how
> to represent them) to the user will be much harder. Are there already
> existing APIs to push this information to the user?
> 

I discussed with Wei Wang and she suggested we should start tracking the
calls to tcp_adjust_rcv_ssthresh() first. So, something like the
following. I would like feedback frm networking folks as well:


From 54bd2bf6681c1c694295646532f2a62a205ee41a Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Tue, 14 Oct 2025 13:27:36 -0700
Subject: [PATCH] memcg: track network throttling due to memcg memory pressure

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 1 +
 mm/memcontrol.c            | 2 ++
 net/ipv4/tcp_input.c       | 5 ++++-
 net/ipv4/tcp_output.c      | 8 ++++++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..5fe254813123 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -52,6 +52,7 @@ enum memcg_memory_event {
 	MEMCG_SWAP_HIGH,
 	MEMCG_SWAP_MAX,
 	MEMCG_SWAP_FAIL,
+	MEMCG_SOCK_THROTTLED,
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..9207bba34e2e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4463,6 +4463,8 @@ static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 		   atomic_long_read(&events[MEMCG_OOM_KILL]));
 	seq_printf(m, "oom_group_kill %lu\n",
 		   atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
+	seq_printf(m, "sock_throttled %lu\n",
+		   atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
 }
 
 static int memory_events_show(struct seq_file *m, void *v)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2d..2206968fb505 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -713,6 +713,7 @@ static void tcp_grow_window(struct sock *sk, const struct sk_buff *skb,
 		 * Adjust rcv_ssthresh according to reserved mem
 		 */
 		tcp_adjust_rcv_ssthresh(sk);
+		memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
 	}
 }
 
@@ -5764,8 +5765,10 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 
 	if (!tcp_can_ingest(sk, in_skb))
 		tcp_clamp_window(sk);
-	else if (tcp_under_memory_pressure(sk))
+	else if (tcp_under_memory_pressure(sk)) {
 		tcp_adjust_rcv_ssthresh(sk);
+		memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
+	}
 
 	if (tcp_can_ingest(sk, in_skb))
 		return 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7..8fe8d973d7ac 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3275,8 +3275,10 @@ u32 __tcp_select_window(struct sock *sk)
 	if (free_space < (full_space >> 1)) {
 		icsk->icsk_ack.quick = 0;
 
-		if (tcp_under_memory_pressure(sk))
+		if (tcp_under_memory_pressure(sk)) {
 			tcp_adjust_rcv_ssthresh(sk);
+			memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
+		}
 
 		/* free_space might become our new window, make sure we don't
 		 * increase it due to wscale.
@@ -3334,8 +3336,10 @@ u32 __tcp_select_window(struct sock *sk)
 	if (free_space < (full_space >> 1)) {
 		icsk->icsk_ack.quick = 0;
 
-		if (tcp_under_memory_pressure(sk))
+		if (tcp_under_memory_pressure(sk)) {
 			tcp_adjust_rcv_ssthresh(sk);
+			memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
+		}
 
 		/* if free space is too low, return a zero window */
 		if (free_space < (allowed_space >> 4) || free_space < mss ||
-- 
2.47.3


