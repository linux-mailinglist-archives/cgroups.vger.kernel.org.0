Return-Path: <cgroups+bounces-9107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99788B23122
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311047ADBA1
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19ED30AAB4;
	Tue, 12 Aug 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzjoz5ig"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194772FABFF
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021558; cv=none; b=pswIbXilQe7JFpIoOV2XUxw/NRXz+sDDUIWK1CHUZeZlRKaNc1O4k+mni4Fxw741dSfAz2MABff7I7kjgLqWJgDjRgtD5RIafF/lG5ojU85OJhlMaUwvpkaF+x0wzW/9D9+DJK5fnxdInFoVtm5ssvz4SXlRHXwHUSS/bpr+uVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021558; c=relaxed/simple;
	bh=ZsDUXB/yvo8uZXixpqGuqcq1s3slWdJ/IT4m8a/kwAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIf2yA0m7IgDONn4mIyolBiTlLpsJ+XeWvyrkxGxefzPh1C3J2HQTAvnrr9YcIhjBVCzr82LL0wA6EPk4Yigh89j0Zxc3WIDer5IHrRdIbeIuA7afezlv0WjK1fyQSmxZ381/BO5oF80Wn6wBzZA+cpEZa2e3XiKTeBcH1DFAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jzjoz5ig; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea14cc097so5460873a91.3
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021554; x=1755626354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=12VsIRpu33AswUdPPRoU3ogIBZKRgH8+iMLaTz6mZnM=;
        b=Jzjoz5igRz3fKLBAFkyenjTz+m0HdlEBRXAtPDc4okhfPdS0VhA9lYGyWp8EWgN4ia
         weVWchy5ki5Sfa/wHwK3BRsvNt5cnbUZ999xkb8RUnpJHJM7o8NneywWmSgTnn0Hufts
         aFE823JaXgzMEAxdZOtOfphW/KZuX99t0RAvmhxoVAvw59tYqDgk5H84fVBgsku8cf9z
         N0qUsOS9fxZ1XQekWLJ7Dg/1kpCpn+ZlvuRzTDn7Kv42Z9DAWhskVa19pLeojAM/fWbd
         isWqgtLWaAJUdeZ9o7aRxnv7BKDwxAC4i3IvwTin2/z6w7fcHAdeScXvNpEYM8IOU0Pk
         W+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021554; x=1755626354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12VsIRpu33AswUdPPRoU3ogIBZKRgH8+iMLaTz6mZnM=;
        b=W+qhnYs2B2R7DVN65VoBBm6EWHsdNfP74BumHxscYrOKmM4ivdvYyZaakD52FlqxAx
         ZDvrppNE1gVLNqH6YDr53dRIdWoNcrmyqOOgsOfehh6MTx8OUucCTE6a/uyGDg+8Df38
         lHKgkoxYNHGgY+/kC7JPjTJeYAD8gOijSzzfhxhUyMkD/kbb7eRiMfVQbsrVOdHJu5kn
         JRnWh2USoT5BJs7f7f6LNcZivVYcIs68IRnPFQPN79ROKTUTdCLY5nfQhRn8BckFbZ97
         qdNpZx9WdjMLMedronhclOy53oMRQ9Y1Xor22ionMB1DWewmQNhAD0IfOj0RyUZOubP0
         fKGw==
X-Forwarded-Encrypted: i=1; AJvYcCWxe5VJO7WfrvdgcIYR2WvmCZ3AwiUQ3jDIrSYTg8HWltGzrpBnHi1/F1DRx67S0+X+frYdgtxj@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+AiJNvdSIS9Sn8xvF4L0Kqob0uic9zbNhSJg3L0I9e46Q4P6
	xa4OG90qYDyRQff/pu+JmCShbplA7xGoRDY8xCtu/a57tmOJV5VvwfAjdR760h1Ikp+9ocFMeQr
	7IosL2w==
X-Google-Smtp-Source: AGHT+IEyIJ3QxWoWnwCUmlvpvFc2sz3YPkZ2Y+XguPdyYnKCZK2UJq098iKz0gqOrCQQVUwpkBAfznuiPeg=
X-Received: from pjbsx8.prod.google.com ([2002:a17:90b:2cc8:b0:312:187d:382d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a10:b0:321:38e0:d591
 with SMTP id 98e67ed59e1d1-321cf976681mr917108a91.17.1755021554281; Tue, 12
 Aug 2025 10:59:14 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:30 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg from
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
v3:
  * Fix build failure for kTLS

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
 net/tls/tls_device.c            |  4 ++-
 8 files changed, 94 insertions(+), 34 deletions(-)

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
index f672a62a9a52..6696ef837116 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -35,6 +35,7 @@
 #include <linux/netdevice.h>
 #include <net/dst.h>
 #include <net/inet_connection_sock.h>
+#include <net/proto_memory.h>
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <linux/skbuff_ref.h>
@@ -371,7 +372,8 @@ static int tls_do_allocation(struct sock *sk,
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
2.51.0.rc0.205.g4a044479a3-goog


