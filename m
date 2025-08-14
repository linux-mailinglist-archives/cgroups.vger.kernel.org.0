Return-Path: <cgroups+bounces-9180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21748B26FFE
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4075A7A6F
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323225A337;
	Thu, 14 Aug 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIx6Z4xr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475F25A633
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202169; cv=none; b=iRnCRouAecXniXjLhv2nx7ClHcwb2O3vEEVvdHQ3JudK5ZURjBrCSgp24kYhsZ7m/ARSg6x7X5lVQrMuG2BzGjBIVV9C4KOXIZvhAT2DasPS3SS0HLJs+sJF9gDyfqgQRKZQLSNLSsc2Yivy/2QkriTo85K8DCFt+Y+NYizePoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202169; c=relaxed/simple;
	bh=wBgxnJgLekPbWtwUujx11FBhulM3TCiAE2w9nltYFJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhFpDoc49nveTEx+NHjRm5Q5h3BvOxu2XMFENaDpANepFMk/lPynHbBM7ccY7L174JpfIfKPMQiSLw0aaUakYtk3CwxsVAa2a4Wzgh26r+y910zdosCCCBND2f4cCOR9ZMgy2uCf+2+VcQr0bi1RAssYVbdzzk4N4UqV9F8g3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIx6Z4xr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so14976725ad.2
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202167; x=1755806967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqwQko3rlUblyrU4VKeLR8maNWxKsVT32Pjp/b8BmK4=;
        b=bIx6Z4xrNKSIx1s8KBjR/sIjITiGFsOk90PTEcBzx2F39T7lsy6El1/ucfMZw24MVy
         g1wz44LdmoQPV7osYwldNQHN3KmobfUHBy3j7X2pe6+cTxE+GKDgFS5vWnh4TD8PG8DW
         IWCLbMKawLO5U2FiPyDmWqSTiiN1iV7iRKKnaJ6rbOmSL3LagPql/9lIPGWB13f7kq5H
         iqHy5u1o1pnYJvXbIny1uDejt5BnzN1RkePrRn0rhvQBR0ad292eKn6TY3VqS0F9Jb5l
         +CjhwmylrMEPGaASGLZZ9OpVuM2nyC7qaVQd+fdfiIYZPjX8AMiuK+8i/HLElkJ4yAhd
         ki1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202167; x=1755806967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqwQko3rlUblyrU4VKeLR8maNWxKsVT32Pjp/b8BmK4=;
        b=NZxD8H/OHA1lBO5S9d2zzGCJNHtzO30P2m9KN97zoO6zY6EYz94clZ7X76JHTuRwdx
         ePOeQ/4+XbS8GDuZtXYd7OsbV7b7k0yCf0srUqslLYOph2vK7RfDZcsOSLfIkeoUld61
         EI5ZeNcnaIpEOPQtOairBvXsFrv91c42LlXULcSKTCzBxCKV/rtV2705R7p+kXIudlIF
         lYgzBDf7NRhiJIYQ4LOsyQnle1e/P9G+8G0zLw04aeffnqROeNvpTE7taxZEzeiGOQ4C
         vGqJbMpVacL/2d8FIIHZNE/1hXVNNsQ7s4Pqe+YrKYJnAkZ4ZxwYZ0xpnTueuHlrfalM
         a/7A==
X-Forwarded-Encrypted: i=1; AJvYcCWKYcFREbfBsLos0rlzGja63K8OWC5qbCKvHNnrv5Wxk9IzGbogdx2+BhyV7pV90o5plGWXEz/m@vger.kernel.org
X-Gm-Message-State: AOJu0YzJA/1nrQ1v7GqMh2CwMVI/kborjcPUCGP1TCUXFSqdT4r8eFot
	R0B2N1uhF1GV4PQivcpLR7OxewbHuetiEnxYh4vIMIBaKCYiGCt/HLRLPQqO6uwfQExDWAFQxc7
	FHwZ6Rg==
X-Google-Smtp-Source: AGHT+IFpk9GsZzJtad1xWRq/jKEfmD5Hu2g99Bbrw9g4nsIfbB0KESQYa2J63MdiGdBZTWW3/moD48VO1k8=
X-Received: from plbmv14.prod.google.com ([2002:a17:903:b8e:b0:240:3ef8:c304])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f550:b0:242:9bc4:f1c7
 with SMTP id d9443c01a7336-244586e0821mr67776325ad.54.1755202167115; Thu, 14
 Aug 2025 13:09:27 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:40 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-9-kuniyu@google.com>
Subject: [PATCH v4 net-next 08/10] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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
---
 include/linux/memcontrol.h      | 29 ++++++++++++++++++++++++-----
 mm/memcontrol.c                 | 18 +++++++++++-------
 net/core/sock.c                 | 24 +++++++++++-------------
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/tcp_output.c           |  3 +--
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..ff008a345ce7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1596,14 +1596,15 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
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
+bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
+			  gfp_t gfp_mask);
+void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1659,8 +1660,26 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
-static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
-static inline void mem_cgroup_sk_free(struct sock *sk) { };
+static inline void mem_cgroup_sk_alloc(struct sock *sk)
+{
+}
+
+static inline void mem_cgroup_sk_free(struct sock *sk)
+{
+}
+
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
index 1717c3a50f66..02f5e574fea0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5030,17 +5030,19 @@ void mem_cgroup_sk_free(struct sock *sk)
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
 
@@ -5053,12 +5055,14 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
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


