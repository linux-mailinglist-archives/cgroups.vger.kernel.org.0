Return-Path: <cgroups+bounces-8809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8DB0CBFD
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D61C20054
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5F23DEAD;
	Mon, 21 Jul 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgnG09Ni"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E689245033
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130208; cv=none; b=j21MsRlg1Yc7Z2fTUoeqGrOM/ohQPD4TBafGZZxadDIxBiX/lxlpPbQpJweGiNGRWEAqz3NNqDpeCsLvM/UBan25n0CnRGBEAuAbuYjvYesfgt0FHDlFceEshwd3zhuXVKVD7rCOLooLRUeOxRxDoSBwegzBPuANdDdDSMhx2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130208; c=relaxed/simple;
	bh=PASGG2Ff90fjH/vqEYJ89hhiHfQMtaYoG/eC4+HIyh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNCDaFnGMCyGddgV74uZkutej7IT1KCBnP/UVKuEo4XbN2SQEpBAO6VUtf5MPx0oDU7KeiD1EqC0E8TIMaF4wW+gxz0NSRikG6S4nC4jkhmC25fdJK+qnax0096SzPhQMI/TD3VL/WHlNwWdwZBdOeAJuHJ0k7uOiaOKGBT5btI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgnG09Ni; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so4365767b3a.1
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130206; x=1753735006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUinzOTBmFzGlPRyqzH40paksGVV4+5eLWcmsRYDtpk=;
        b=SgnG09NiMe3dVZCVQL7vY+P3Fd1Ef6y750CPYk1AamhHZEpXPEUFqXb7wYHYJrLWXK
         IhAmWt9cvRsS5RMM2P7/AkFmlRiurs608D4edBi7pfnsC4XhnSOxVJFDfEnMlKjf2vyQ
         jMfBCZ7AJhOYqOxR36FECn/fkwKJ7ZikXnn+IfWeYSIjRrZH9PRWSJCHzy+kfoT1t/OG
         XQkhky7hh6PKA3m8Ce2dKdFzQe0Z7KcBgoMX8cEGrVPTe3GVHvMVbydSx8kAQ3Vnxit8
         CyRj5UxVZ3jNc7Y26YHsCrcNHLCpBLxGLW8j8Q7N0N+r3WJVG8nDOiWfUZGOsPTFxR56
         gDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130206; x=1753735006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUinzOTBmFzGlPRyqzH40paksGVV4+5eLWcmsRYDtpk=;
        b=fnYL8BD8FoeRq+2FLBZq03yybcztiU6XD6cbwLqgVTtsM4rhSTGssYA9GGUAFuI5du
         Ml0ckCiPcVjW+JDAqRR2NqZDOcZT3L5PC3/IrrxA+5X8WSQpw6slCZG0KMnllWo6ftvO
         iuBDuZbroHM/X2knaklQenpZqI8lMwGPi4Cei8GNd3uKSAuSSwU03NXGAcefYGRYrEX9
         J5wrF8CvZnO4eh0kajrnqARrc6MtoqAp2orUVbUgKPpoOkoUxFeMP7e04cVeTHzkjok0
         kdS/fkQWND/cf2WwBXDzn4ap+/YmO0GTx2cpY3psJJo3IO0vaemd8UDy9kjExO8wH7lt
         yZug==
X-Forwarded-Encrypted: i=1; AJvYcCUv3z9QdZdsnonV+/ohg+DIs4KA9gvW5L7/WTRhpetFcbx1hVyqpZTBwyxQv1/P5U1U6WVdsZHo@vger.kernel.org
X-Gm-Message-State: AOJu0YxKA6FzNY9sL3rug00+CcoIFTV0214JteNEfxYasN51LQDdjMiT
	Hje3ZYL9quRVlxPyWH4Fn13lzdv/NkMFOlx2aAf3JM9o0JyRU+c1s2Na8tEiVKYn2fqhn4wZjqy
	TcYbJ7w==
X-Google-Smtp-Source: AGHT+IF55Tasmzf40vI7WdvTmtciM9z/zourqwpEu8s96++APVGs+R76gSIW5Yf92/sZUKZ1BwWIx+Puq2c=
X-Received: from pfoo15.prod.google.com ([2002:a05:6a00:1a0f:b0:746:683a:6104])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1a:b0:230:f120:f7f3
 with SMTP id adf61e73a8af0-2391c92c40bmr23246374637.8.1753130206377; Mon, 21
 Jul 2025 13:36:46 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:32 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) implement memory accounting for socket
buffers and charge memory to per-protocol global counters pointed to by
sk->sk_proto->memory_allocated.

When running under a non-root cgroup, this memory is also charged to the
memcg as sock in memory.stat.

Even when memory usage is controlled by memcg, sockets using such protocols
are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).

This makes it difficult to accurately estimate and configure appropriate
global limits, especially in multi-tenant environments.

If all workloads were guaranteed to be controlled under memcg, the issue
could be worked around by setting tcp_mem[0~2] to UINT_MAX.

In reality, this assumption does not always hold, and a single workload
that opts out of memcg can consume memory up to the global limit,
becoming a noisy neighbour.

Let's decouple memcg from the global per-protocol memory accounting.

This simplifies memcg configuration while keeping the global limits
within a reasonable range.

If mem_cgroup_sk_isolated(sk) returns true, the per-protocol memory
accounting is skipped.

In inet_csk_accept(), we need to reclaim counts that are already charged
for child sockets because we do not allocate sk->sk_memcg until accept().

Note that trace_sock_exceed_buf_limit() will always show 0 as accounted
for the isolated sockets, but this can be obtained via memory.stat.

Tested with a script that creates local socket pairs and send()s a
bunch of data without recv()ing.

Setup:

  # mkdir /sys/fs/cgroup/test
  # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
  # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"

Without memory.socket_isolated:

  # echo 0 > /sys/fs/cgroup/test/memory.socket_isolated
  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 24682496
  #  ss -tn | head -n 5
  State Recv-Q Send-Q Local Address:Port  Peer Address:Port
  ESTAB 2000   0          127.0.0.1:54997    127.0.0.1:37738
  ESTAB 2000   0          127.0.0.1:54997    127.0.0.1:60122
  ESTAB 2000   0          127.0.0.1:54997    127.0.0.1:33622
  ESTAB 2000   0          127.0.0.1:54997    127.0.0.1:35042
  # nstat | grep Pressure || echo no pressure
  TcpExtTCPMemoryPressures        1                  0.0

With memory.socket_isolated:

  # echo 1 > /sys/fs/cgroup/test/memory.socket_isolated
  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 2766671872
  # ss -tn | head -n 5
  State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
  ESTAB 112000 0           127.0.0.1:41729    127.0.0.1:35062
  ESTAB 110000 0           127.0.0.1:41729    127.0.0.1:36288
  ESTAB 112000 0           127.0.0.1:41729    127.0.0.1:37560
  ESTAB 112000 0           127.0.0.1:41729    127.0.0.1:37096
  # nstat | grep Pressure || echo no pressure
  no pressure

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/proto_memory.h      | 10 +++--
 include/net/tcp.h               | 10 +++--
 net/core/sock.c                 | 65 +++++++++++++++++++++++----------
 net/ipv4/inet_connection_sock.c | 18 +++++++--
 net/ipv4/tcp_output.c           | 10 ++++-
 5 files changed, 82 insertions(+), 31 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 8e91a8fa31b52..3c2e92f5a6866 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,9 +31,13 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_sk_under_memory_pressure(sk))
-		return true;
+	if (mem_cgroup_sk_enabled(sk)) {
+		if (mem_cgroup_sk_under_memory_pressure(sk))
+			return true;
+
+		if (mem_cgroup_sk_isolated(sk))
+			return false;
+	}
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9ffe971a1856b..a5ff82a59867b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -275,9 +275,13 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_sk_under_memory_pressure(sk))
-		return true;
+	if (mem_cgroup_sk_enabled(sk)) {
+		if (mem_cgroup_sk_under_memory_pressure(sk))
+			return true;
+
+		if (mem_cgroup_sk_isolated(sk))
+			return false;
+	}
 
 	return READ_ONCE(tcp_memory_pressure);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index ab6953d295dfa..e1ae6d03b8227 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1046,17 +1046,21 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	if (!charged)
 		return -ENOMEM;
 
-	/* pre-charge to forward_alloc */
-	sk_memory_allocated_add(sk, pages);
-	allocated = sk_memory_allocated(sk);
-	/* If the system goes into memory pressure with this
-	 * precharge, give up and return error.
-	 */
-	if (allocated > sk_prot_mem_limits(sk, 1)) {
-		sk_memory_allocated_sub(sk, pages);
-		mem_cgroup_sk_uncharge(sk, pages);
-		return -ENOMEM;
+	if (!mem_cgroup_sk_isolated(sk)) {
+		/* pre-charge to forward_alloc */
+		sk_memory_allocated_add(sk, pages);
+		allocated = sk_memory_allocated(sk);
+
+		/* If the system goes into memory pressure with this
+		 * precharge, give up and return error.
+		 */
+		if (allocated > sk_prot_mem_limits(sk, 1)) {
+			sk_memory_allocated_sub(sk, pages);
+			mem_cgroup_sk_uncharge(sk, pages);
+			return -ENOMEM;
+		}
 	}
+
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
 
 	WRITE_ONCE(sk->sk_reserved_mem,
@@ -3153,8 +3157,12 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
 		return true;
 
-	sk_enter_memory_pressure(sk);
 	sk_stream_moderate_sndbuf(sk);
+
+	if (mem_cgroup_sk_enabled(sk) && mem_cgroup_sk_isolated(sk))
+		return false;
+
+	sk_enter_memory_pressure(sk);
 	return false;
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
@@ -3267,18 +3275,30 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	long allocated;
-
-	sk_memory_allocated_add(sk, amt);
-	allocated = sk_memory_allocated(sk);
+	long allocated = 0;
 
 	if (mem_cgroup_sk_enabled(sk)) {
+		bool isolated = mem_cgroup_sk_isolated(sk);
+
 		memcg_enabled = true;
 		charged = mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
-		if (!charged)
+
+		if (isolated && charged)
+			return 1;
+
+		if (!charged) {
+			if (!isolated) {
+				sk_memory_allocated_add(sk, amt);
+				allocated = sk_memory_allocated(sk);
+			}
+
 			goto suppress_allocation;
+		}
 	}
 
+	sk_memory_allocated_add(sk, amt);
+	allocated = sk_memory_allocated(sk);
+
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
 		sk_leave_memory_pressure(sk);
@@ -3357,7 +3377,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	sk_memory_allocated_sub(sk, amt);
+	if (allocated)
+		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
 		mem_cgroup_sk_uncharge(sk, amt);
@@ -3396,11 +3417,15 @@ EXPORT_SYMBOL(__sk_mem_schedule);
  */
 void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
-	sk_memory_allocated_sub(sk, amount);
-
-	if (mem_cgroup_sk_enabled(sk))
+	if (mem_cgroup_sk_enabled(sk)) {
 		mem_cgroup_sk_uncharge(sk, amount);
 
+		if (mem_cgroup_sk_isolated(sk))
+			return;
+	}
+
+	sk_memory_allocated_sub(sk, amount);
+
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d1..9d56085f7f54b 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
+#include <net/proto_memory.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 /* match_sk*_wildcard == true:  IPV6_ADDR_ANY equals to any IPv6 addresses
@@ -710,7 +711,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-		int amt = 0;
 
 		/* atomically get the memory usage, set and charge the
 		 * newsk->sk_memcg.
@@ -719,15 +719,27 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		mem_cgroup_sk_alloc(newsk);
 		if (mem_cgroup_from_sk(newsk)) {
+			int amt;
+
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
 			amt = sk_mem_pages(newsk->sk_forward_alloc +
 					   atomic_read(&newsk->sk_rmem_alloc));
+			if (amt) {
+				/* This amt is already charged globally to
+				 * sk_prot->memory_allocated due to lack of
+				 * sk_memcg until accept(), thus we need to
+				 * reclaim it here if newsk is isolated.
+				 */
+				if (mem_cgroup_sk_isolated(newsk))
+					sk_memory_allocated_sub(newsk, amt);
+
+				mem_cgroup_sk_charge(newsk, amt, gfp);
+			}
+
 		}
 
-		if (amt)
-			mem_cgroup_sk_charge(newsk, amt, gfp);
 		kmem_cache_charge(newsk, gfp);
 
 		release_sock(newsk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 09f0802f36afa..79e705fca8b67 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3562,12 +3562,18 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	delta = size - sk->sk_forward_alloc;
 	if (delta <= 0)
 		return;
+
 	amt = sk_mem_pages(delta);
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
-	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sk_enabled(sk))
+	if (mem_cgroup_sk_enabled(sk)) {
 		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
+
+		if (mem_cgroup_sk_isolated(sk))
+			return;
+	}
+
+	sk_memory_allocated_add(sk, amt);
 }
 
 /* Send a FIN. The caller locks the socket for us.
-- 
2.50.0.727.gbf7dc18ff4-goog


