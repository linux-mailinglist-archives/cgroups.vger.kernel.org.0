Return-Path: <cgroups+bounces-9086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68648B21349
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622D41A21D25
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE12E0928;
	Mon, 11 Aug 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nk2vDVGJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E02E0405
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933512; cv=none; b=CCn2I8ogsSqwcEoJlrmIQL1jSSr/sS+IKx8/fMlgE8821o1R1cA/gqbPAHJOoBG1DzC1xKUQYW/vYG2kuMGPfa4mFynyMMlhGEJVaUdcN4j1yd24/QMNTnrfFf/CFFl/WWbXrDV5YBAjsevjAuAh9WtnF2v3SgnPggPyz66dFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933512; c=relaxed/simple;
	bh=dOLfm9I4B2TFecBHydDXiOPMuM6Ln7/l9lzWDNQH6Dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKDzcpv1ILefgRl1Pj7KSTLVXA2dEnYEtJuZ9rYnYwtOQpfpP4vNRHjUzLRRxvAn3fBU8ZkxZDe26LDKovZ5ahfRqZfZeeDNMhxWcvHVxhQw5fVyod5MPbPR4EM0BJGGhvd11iZ/8Rq00xW9YSMykqbMUgDl3purl6XJP66OQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nk2vDVGJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76c47324232so2839405b3a.0
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933509; x=1755538309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7SLf/b1TNrP6kPGA7P5mGSIp2EjjMSQCEcOICNla1I=;
        b=Nk2vDVGJ2OW8hsS5RYK2guR1DSOAWyJE5adyvd3xtnjrW2MAQF8KvgTi9Sf/Z5vBZ6
         06OgmtyUiLed96IM1+pubBSYSz1wC6l+lZCzqVNyqte3YQ98Yi/E9VlJo05NYEuem0fh
         UaLWaZUsWohRfiYBlxt94AStGxgWAmesBh1hZqktiaB/fAwpt9+RmcxXszC0fTD98vAf
         KtDJnQ0JESk+v7+W2pYhMm8Fao1wdx4OgarKQBuTq9CXogENBC/zPK3nGolG/N6SB3MS
         XG7VPxfbzw5Ur3Rnr5NHRK0+wYFaIWGqLGuCjrh+WdlbEtgmOPQvsT+hVE5a0P49/pG9
         Mwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933509; x=1755538309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7SLf/b1TNrP6kPGA7P5mGSIp2EjjMSQCEcOICNla1I=;
        b=OE+YEU2ms8K43yBWOCuhcSKSmqCDRBxFtAP7lkbTtD3WurYsD6QYPMhRq20ChUpyT7
         8vV0m/F3iG+J29oybJgEmsNR0RQXMhKyxt6QWsMx0Kxv3lhgkCuwDaP3QAQGuaX6HqMb
         EupKvDMXyZec3BtSSXEwK72DxvFshCkbEl402XuXE7TDnDG+I/M0IfSFl56ubtxKaU4Z
         YuqwzFld8Er4/VAWvr4eY9MUZNs51v9Z9jRaIDPjUrAw64OExzNf9PwCY8DqfZw/Omxy
         uMHNMxqMxGC7eiTVa6zRz3dqAqIPbVZf9ULSi/r+dVivQmBpkbbabSTVo1Y/5h/cc/oX
         TEgg==
X-Forwarded-Encrypted: i=1; AJvYcCVHYoJIqD1WHqQe6CKfMVT/GSL64dM6nwWqSZec7dF3h2DyA1qMbY0LIy6UG7Ip8tvphXo7FRiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjl6qwvEDNRTAn3FLHOl/2m7rbIKL3rD9DyxMvWptq9bPi/fjM
	5VGLgED3GHx6jzAb7StQkXt8LVkyR07STwyhSzJuYTSA8OLtScJ7Mj94bFEZezIMnJAMW6waLuv
	XkPv6Vw==
X-Google-Smtp-Source: AGHT+IEkxOxyR4soNgLW4++VFX6C582L+cnGEVtxtVwkEQ3Ypcq86ke6b4X42kPLmM6zLuE6ldq4TTZy3Ic=
X-Received: from pgbee13.prod.google.com ([2002:a05:6a02:458d:b0:b42:c17:47ac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:892f:b0:240:9af2:71cb
 with SMTP id adf61e73a8af0-2409af27360mr180384637.20.1754933509378; Mon, 11
 Aug 2025 10:31:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:40 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg from
 global protocol memory accounting.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) implement memory accounting for socket
buffers and charge memory to per-protocol global counters pointed to by
sk->sk_proto->memory_allocated.

When running under a non-root cgroup, this memory is also charged to the
memcg as "sock" in memory.stat.

Even when a memcg controls memory usage, sockets of such protocols are
still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).

This makes it difficult to accurately estimate and configure appropriate
global limits, especially in multi-tenant environments.

If all workloads were guaranteed to be controlled under memcg, the issue
could be worked around by setting tcp_mem[0~2] to UINT_MAX.

In reality, this assumption does not always hold, and processes that
belong to the root cgroup or opt out of memcg can consume memory up to
the global limit, becoming a noisy neighbour.

Let's decouple memcg from the global per-protocol memory accounting if
it has a finite memory.max (!= "max").

We still keep charging memory to memcg and protocol duplicately if
memcg has "max" in memory.max because TCP allows only 10% of physical
memory by default.

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

Without setting memory.max:

  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 22642688
  # ss -tn | head -n 5
  State Recv-Q Send-Q Local Address:Port  Peer Address:Port
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
  # nstat | grep Pressure || echo no pressure
  TcpExtTCPMemoryPressures        1                  0.0

With memory.max:

  # echo $((64 * 1024 ** 3)) > /sys/fs/cgroup/test/memory.max
  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 2757468160
  # ss -tn | head -n 5
  State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
  ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
  ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
  ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
  ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
  # nstat | grep Pressure || echo no pressure
  no pressure

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Add sk_should_enter_memory_pressure() for
    tcp_enter_memory_pressure() calls not in core
  * Update example in changelog
---
 include/net/proto_memory.h      | 15 ++++++--
 include/net/tcp.h               | 10 ++++--
 net/core/sock.c                 | 64 ++++++++++++++++++++++-----------
 net/ipv4/inet_connection_sock.c | 18 ++++++++--
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 10 ++++--
 net/mptcp/protocol.c            |  4 ++-
 net/tls/tls_device.c            |  3 +-
 8 files changed, 93 insertions(+), 34 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 8e91a8fa31b5..8e8432b13515 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,13 +31,22 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
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
 
+static inline bool sk_should_enter_memory_pressure(struct sock *sk)
+{
+	return !mem_cgroup_sk_enabled(sk) || !mem_cgroup_sk_isolated(sk);
+}
+
 static inline long
 proto_memory_allocated(const struct proto *prot)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950..0191a4585bba 100644
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
index ab6953d295df..755540215570 100644
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
@@ -3153,8 +3157,11 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
 		return true;
 
-	sk_enter_memory_pressure(sk);
+	if (sk_should_enter_memory_pressure(sk))
+		sk_enter_memory_pressure(sk);
+
 	sk_stream_moderate_sndbuf(sk);
+
 	return false;
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
@@ -3267,18 +3274,30 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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
@@ -3357,7 +3376,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	sk_memory_allocated_sub(sk, amt);
+	if (allocated)
+		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
 		mem_cgroup_sk_uncharge(sk, amt);
@@ -3396,11 +3416,15 @@ EXPORT_SYMBOL(__sk_mem_schedule);
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
index 0ef1eacd539d..9d56085f7f54 100644
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc55..dcbd49e2f8af 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -908,7 +908,8 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 		}
 		__kfree_skb(skb);
 	} else {
-		sk->sk_prot->enter_memory_pressure(sk);
+		if (sk_should_enter_memory_pressure(sk))
+			tcp_enter_memory_pressure(sk);
 		sk_stream_moderate_sndbuf(sk);
 	}
 	return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dfbac0876d96..f7aa86661219 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3574,12 +3574,18 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a287b75c1b3..1a4089b05a16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,7 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
+#include <net/proto_memory.h>
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
@@ -1016,8 +1017,9 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (first)
+		if (first && sk_should_enter_memory_pressure(sk))
 			tcp_enter_memory_pressure(ssk);
+
 		sk_stream_moderate_sndbuf(ssk);
 
 		first = false;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..92a4c16b904a 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -371,7 +371,8 @@ static int tls_do_allocation(struct sock *sk,
 	if (!offload_ctx->open_record) {
 		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
 						   sk->sk_allocation))) {
-			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
+			if (sk_should_enter_memory_pressure(sk))
+				READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
 			sk_stream_moderate_sndbuf(sk);
 			return -ENOMEM;
 		}
-- 
2.51.0.rc0.155.g4a0f42376b-goog


