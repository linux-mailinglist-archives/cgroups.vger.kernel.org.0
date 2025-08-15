Return-Path: <cgroups+bounces-9231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7BCB2871A
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C52620856
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3D2F9C5D;
	Fri, 15 Aug 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3gfu7dc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA35317714
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289068; cv=none; b=stYr8SLLNrCr2NMcgvkKInCiLSdxCubZOpiUr5Mx/P48cglkOXZCh9cTRd8UeS5IeBjqDZHZerhAJdz0TzsJpB7qaBaD9AE/VYR/LA5EgeSU6oi+VBbx3b37Nk8NvG3RVQUTXWV2LrWXwXd96ibvwvhtm3KWSUeRWE5mXf1W3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289068; c=relaxed/simple;
	bh=suM19LgjkKO83Xld9CyJYPHJ6rg11N/UNfS+zxoIKCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKPVd3gIUCW9/mSEgH6IcVQJmGzQere89jaEm6RI7pGRToK3Tf1sQzcFunZzT+VIS0S5z8SAp7genj5+UVLOYNdpJ90HmCum+VfxihsGW8NXkKu6LpDdfqPfFkigj/PU6L+4XBMF4ZQxu0RcFiiMhDtx10Gcc0O9UjFCd6xrWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3gfu7dc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so2141817b3a.0
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289066; x=1755893866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfW0AKjgNSELXjjoDcEX6Y6n+0gVaLsZmB/XYkuwP9I=;
        b=I3gfu7dcdxYSG8qUmx0NU3oj5tAmd6rZPxcZn3/HwPvT59KS0nmLS7yQ5R80g0nxS7
         8hvmxuOKBfBIVwpG4Fe5n/2/7f4bJ2pBMeZVVPZl/AKrdhLD1CU/5Gqja+NSW+Ez89dd
         v5BiQJ0tjDo0oY0KAvhFWISnaBCyZs9iklNcZpiNDZh1XopOE4+6AaARbnYTpcrFbUYL
         GlVnn1XQ1gjnZhgIIyGV/luIAG0kXNNBFuQrteNbHbOq9pilHZJF3wO+bfba7ZnhpQIX
         HAIQNoPArE/t68X8ZYBOPSpyPezUzhPxKB1nCedog8F9Zup5vLXre7W8TK8riuLt1pOX
         DK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289066; x=1755893866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfW0AKjgNSELXjjoDcEX6Y6n+0gVaLsZmB/XYkuwP9I=;
        b=VceHaxzBH/8trC16guJQQi0oWWtZl6w0Itis3CPlQtWvvBAq1Vwiff8kP2Fq9mE9FZ
         LbG45dgf1sfCfuglAZ0YG3jmRnepBI+vJDwzsY/FMeuxC+1bSJwSrZ/Tf8JCw2YaPt04
         NJxk4fg00bnQnuPDZDVx77/Fv4jLoY3x8TR+YPdkY1gBF9XJv+GYiFVIzLn1WIFkXoB3
         IYcV0xVjArAq3wZamyu0Nukxso5nUem+TzUp5SklsYjtnJMjxIAlUUtvGYAAdL0CPdk8
         3FIinPIOKELpcjxIreXSPcds2bj30kcKn4MP88zSamyRS0iujKdhrwkyv955ly3ZRG2v
         qpcg==
X-Forwarded-Encrypted: i=1; AJvYcCU+8gCq221XiGA3xRWwFOa9Ai1o4JLXQRKC/oz39INQwKSr2IobvYFYH9OAGtBKWymTZaj5dmJq@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIMREe/xUezZJiYdp4PgUlSF4RT5uEsoe5QTciaGQuqOzlRcO
	XWu7hNRzpL5Vb2W8cPGFWxNrysLaBo3FXeVA5sI22qv19eC2pO4vK6jCRkeo3f8jzjfQ8MK0SKE
	1stwXsQ==
X-Google-Smtp-Source: AGHT+IElDnvoGmI5tD6Ho6R2PezWL3Vx1xKjyABAEM7ehtZ7uqynZz9sJvg0jdDpQOByEtsqMjA1ed/8pGE=
X-Received: from pgbeu24.prod.google.com ([2002:a05:6a02:4798:b0:b46:dae0:dfe8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8a:b0:23e:19fd:e182
 with SMTP id adf61e73a8af0-240d302fdd7mr6071025637.13.1755289066069; Fri, 15
 Aug 2025 13:17:46 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:16 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-9-kuniyu@google.com>
Subject: [PATCH v5 net-next 08/10] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
and mem_cgroup_uncharge_skmem().

Let's pass struct sock to the functions.

While at it, they are renamed to match other functions starting
with mem_cgroup_sk_.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h      | 29 ++++++++++++++++++++++++-----
 mm/memcontrol.c                 | 18 +++++++++++-------
 net/core/sock.c                 | 24 +++++++++++-------------
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/tcp_output.c           |  3 +--
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 25921fbec685..0837d3de3a68 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1596,15 +1596,16 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 struct sock;
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
-			     gfp_t gfp_mask);
-void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
+
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
+bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
+			  gfp_t gfp_mask);
+void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1660,13 +1661,31 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
-static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
-static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_alloc(struct sock *sk)
+{
+}
+
+static inline void mem_cgroup_sk_free(struct sock *sk)
+{
+}
 
 static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 {
 }
 
+static inline bool mem_cgroup_sk_charge(const struct sock *sk,
+					unsigned int nr_pages,
+					gfp_t gfp_mask)
+{
+	return false;
+}
+
+static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
+					  unsigned int nr_pages)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d8a52d1d08fa..df3e9205c9e6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5043,17 +5043,19 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 }
 
 /**
- * mem_cgroup_charge_skmem - charge socket memory
- * @memcg: memcg to charge
+ * mem_cgroup_sk_charge - charge socket memory
+ * @sk: socket in memcg to charge
  * @nr_pages: number of pages to charge
  * @gfp_mask: reclaim mode
  *
  * Charges @nr_pages to @memcg. Returns %true if the charge fit within
  * @memcg's configured limit, %false if it doesn't.
  */
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
-			     gfp_t gfp_mask)
+bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
+			  gfp_t gfp_mask)
 {
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);
 
@@ -5066,12 +5068,14 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 }
 
 /**
- * mem_cgroup_uncharge_skmem - uncharge socket memory
- * @memcg: memcg to uncharge
+ * mem_cgroup_sk_uncharge - uncharge socket memory
+ * @sk: socket in memcg to uncharge
  * @nr_pages: number of pages to uncharge
  */
-void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
+void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 {
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		memcg1_uncharge_skmem(memcg, nr_pages);
 		return;
diff --git a/net/core/sock.c b/net/core/sock.c
index ab658fe23e1e..5537ca263858 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1041,8 +1041,8 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	pages = sk_mem_pages(bytes);
 
 	/* pre-charge to memcg */
-	charged = mem_cgroup_charge_skmem(sk->sk_memcg, pages,
-					  GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	charged = mem_cgroup_sk_charge(sk, pages,
+				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!charged)
 		return -ENOMEM;
 
@@ -1054,7 +1054,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	 */
 	if (allocated > sk_prot_mem_limits(sk, 1)) {
 		sk_memory_allocated_sub(sk, pages);
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, pages);
+		mem_cgroup_sk_uncharge(sk, pages);
 		return -ENOMEM;
 	}
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
@@ -3263,17 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
+	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	struct mem_cgroup *memcg = NULL;
-	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
 	if (mem_cgroup_sk_enabled(sk)) {
-		memcg = sk->sk_memcg;
-		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
+		memcg_enabled = true;
+		charged = mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
 	}
@@ -3347,10 +3346,9 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
 			/* Force charge with __GFP_NOFAIL */
-			if (memcg && !charged) {
-				mem_cgroup_charge_skmem(memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
-			}
+			if (memcg_enabled && !charged)
+				mem_cgroup_sk_charge(sk, amt,
+						     gfp_memcg_charge() | __GFP_NOFAIL);
 			return 1;
 		}
 	}
@@ -3360,7 +3358,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
-		mem_cgroup_uncharge_skmem(memcg, amt);
+		mem_cgroup_sk_uncharge(sk, amt);
 
 	return 0;
 }
@@ -3399,7 +3397,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	sk_memory_allocated_sub(sk, amount);
 
 	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
+		mem_cgroup_sk_uncharge(sk, amount);
 
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 93569bbe00f4..0ef1eacd539d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -727,7 +727,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		}
 
 		if (amt)
-			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
+			mem_cgroup_sk_charge(newsk, amt, gfp);
 		kmem_cache_charge(newsk, gfp);
 
 		release_sock(newsk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 37fb320e6f70..dfbac0876d96 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3579,8 +3579,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
+		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
 }
 
 /* Send a FIN. The caller locks the socket for us.
-- 
2.51.0.rc1.163.g2494970778-goog


