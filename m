Return-Path: <cgroups+bounces-8804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BDB0CBFB
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AD9544A47
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7223C502;
	Mon, 21 Jul 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzKafixT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4E241CAF
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130201; cv=none; b=dHNvCzThcw99hB2GYzsN0W3rPIat5k373fnjosbKQHbZrYSgMPJpjj6syRAfYn6EBxbbzElyAML891pg+1CsQ9ufd+Y0EC/NJ55nna5ILD8S/LCbqOh8YJzonvbIQRgVUfnLsraYXB61vPWU1HS43/2C/e4a7xv3Us6h+pVKfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130201; c=relaxed/simple;
	bh=PTX3iVv9Ku7TSrw69jK0X11zqasCKUo1GUoDKQ1jgFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U+kQRDcN6y6mSP7DUIICUmhWWNzderEXFJJYzKiW0N0YpmnSx5vgbM3u8pXaHh5/Qrs4R1mulRSgspaHcEQEq/KkJIylRXOwVddjEKfaKsw1EvxtzEMSCdyZuxKhQi7DyWAzBt/OVmWb4G+j7WgP/ox67B5O3AnlXuwrQJrCu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzKafixT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so4350424a91.0
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130199; x=1753734999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoUvWeKsVeVx1EY4fRbQ+6aQfQTe9Vq1LkXAKDABLBI=;
        b=JzKafixTamahSzZ8n3Ga9GFFG2AG8aNoZIhy+2oEX7H0HO/QheXSCLp+k4MkoX1jLK
         IXgyE59DY4FReSIBigGHOM6G8qi24OpQWE4Jo48kwC23z+DkOyzSu2KwfLD86SG7rfLl
         2gR5yeimCKHK/TQ1o7rFkDpC914Nred9pACR3QMk50f+wHxe7GRwdtrw/EGHC05+HYfu
         Xw7Irdb7yllnF52SqZ7+FH7/r8Q9xRlRxpYbcAdn+1M41VBpAMVszlDMVKT9PEOzxBF9
         VwEQRqpawTdqKth38Usp/O5XkmqsldwY8MEpgUYQvkQlbxJ7lOM3Fwma8Uc9iYcEXhsD
         3V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130199; x=1753734999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoUvWeKsVeVx1EY4fRbQ+6aQfQTe9Vq1LkXAKDABLBI=;
        b=lGR7q3c5u3VPacPRrb3bFqITat86lgwIDr3pWGrMTQADswbsziYlrPtsXvrh47aheU
         IB7k1tnEmC1iA/tbwuJSUELE0iBDx0TlIfaqM1GvM8eVWG4hdXDifJLzJPPBsz5VQmaP
         3D/+pgJVqMKj2WVHHneBlU3m6YbHxplkaENQmM4rqB5RqnNLp66bfa9aWK4jLBynr+iI
         Sspt3CdpxSMp54Mfl3lInLJoxJGfLGd/Ubtr3zJwAdprjs3sGNEdqKpKi+AH1Gh+mrHK
         r3kwKmXZncfIS5AMwwalktFcsok44C+hJQuxQUOUM0qbu8825YlLf1MPfD6+YARY3J29
         NZnw==
X-Forwarded-Encrypted: i=1; AJvYcCXB9JG/iDerNN/PL7L69m9WRcd3GfCUGPc2ZnuRzGxJKntjM30xj/vIjM5gryXOJiKKGZdMQSWR@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpM+1CZx2KPUNmecI2WVTfO/kTW2bR7IznUlw29+Dysi+DRfD
	w1QpHIPwVVNBvNSKNwC6UaVPgTmcl46sZ2sOjHmWAJfymL+LAWU0Lb6RsrkKgKfNbIOR2C9pcnq
	Sr6004w==
X-Google-Smtp-Source: AGHT+IF0GEZfGU8amzJJ0YhldecloQOnsxr/9oopxqYyUHJO4PqIqFZMmRr7D3sidRtGioBbSwED02P8YQM=
X-Received: from pjzz15.prod.google.com ([2002:a17:90b:58ef:b0:311:ef56:7694])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5385:b0:313:d343:4e09
 with SMTP id 98e67ed59e1d1-31c9f45e1a3mr25469971a91.3.1753130199131; Mon, 21
 Jul 2025 13:36:39 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:27 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/13] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
and mem_cgroup_uncharge_skmem().

Let's pass struct sock to the functions.

While at it, they are renamed to match other functions starting
with mem_cgroup_sk_.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/memcontrol.h      | 29 ++++++++++++++++++++++++-----
 mm/memcontrol.c                 | 18 +++++++++++-------
 net/core/sock.c                 | 24 +++++++++++-------------
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/tcp_output.c           |  3 +--
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d8319ad5e8ea7..9ccbcddbe3b8e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1594,15 +1594,16 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
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
 
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
@@ -1623,13 +1624,31 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
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
index 89b33e635cf89..d7f4e31f4e625 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5105,17 +5105,19 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
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
 
@@ -5128,12 +5130,14 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
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
index ab658fe23e1e6..5537ca2638588 100644
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
index 93569bbe00f44..0ef1eacd539d1 100644
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
index 4e0af5c824c1a..09f0802f36afa 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3567,8 +3567,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
+		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
 }
 
 /* Send a FIN. The caller locks the socket for us.
-- 
2.50.0.727.gbf7dc18ff4-goog


