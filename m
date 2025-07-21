Return-Path: <cgroups+bounces-8803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF2B0CBF6
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9D189EDC2
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23D242902;
	Mon, 21 Jul 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxUfp/Ir"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EF241672
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130200; cv=none; b=X1cuwBJvcd/+kDZ39PG8FzfDR/CX1qhvHRFlranrLlmZFnurAD3MnbaPgUtiGh4LbNLi6yv+Qj1k6kwvxrGH3qo+S65YByxXoxWeWBe8EmlvVhJlp1oYHovgRlrSFfEpeMJ0mAn0Tsu+LhXxw089fik92lsWZKSbBWXrTv/Oo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130200; c=relaxed/simple;
	bh=Np33N9r0abllKVI2quaOtsW8GKG8UR/+pGRXFZjdmVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFX+xjKKUitlsCgDE/JyVxrM+43WfL+k0ArJW58rGEXhEVnYzhKkXQ6k5FQ31+TQoQwh8mzw5XIBegI+xIjjO/TLXdWx9pnT0zvaIZvlT8lAU/0lnSREMV46lmaDfU18A7kXPhaPJm7I2lPob4GAq+/BTpy7/faT78l3x25chFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxUfp/Ir; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so4459990a91.0
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130198; x=1753734998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzkCcE7y2iiEKWHZNkTKmLOP5up72GHF++8nWGJ0fgE=;
        b=yxUfp/IrcN6d+LLzZha/tiKphwPnso2KOi2jz0KwGvTNGwNlPhZYC/0nJKcOD78O0U
         DmPzYa64D99BgLpy6jOXdJAGAVJBfJwi2mOQrudNdYKA5G9b+ReKwHXj0CJv2jEyUl3L
         zphmYm/szd+GB0rlFNfl16acyX3bHFj8M9b/z1KDRtppFFLfEn7eE+/90lqRQJUIKe4T
         ft1FFlza5+xCUROGz5qg6YL59jro1VUPrtFRO+Jmv04vED/ZtveIvs37VdrtqQFnewrd
         ddDJf2ADXIFgvnWV/Mb08GEpUcmtKrVmSFnjxWTCkOD2B9dwmamLU+5+Am5p3NqpEaZM
         K31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130198; x=1753734998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzkCcE7y2iiEKWHZNkTKmLOP5up72GHF++8nWGJ0fgE=;
        b=uJhBK98e+lUaBRY8V9UGSS+gExiig0p80YxkAiUD7wMBMKZGWg8UBep5ETAGJhOIQ0
         2L7xmlvAcgzbZLaSeADYr1zZjYaHIpWHHtFPx7IUSkN1CeZ3FrINMeH9fetu08c4WMpb
         7kUBS4MtuVGDwcutE17qJWDP2QuMw3xJxUfEDO/8T6wtckCTbFYDhcQ4+ggd9d4TQ0ho
         9JsHfAW3oHgrnv5IVNicwbYe77paHufjLc1rUrpAakAsukx7QJo5Q+PZ+xFb0HQ9VrLX
         W/8Fv03XiX8kgX+qBE8PXRDRJ5menycmh+0LIP5k8bcUmWz+dYDuVwTwJ753kRB7f7m4
         +j5w==
X-Forwarded-Encrypted: i=1; AJvYcCXVdLVSe5bWwO6ss70f0+8oKk31H2Jz5b/kbcmHW/0WDonB4UnfF+Dhh38Di9LJcJQDQG2EaED4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KLueU3EWpVAZ4IzawioK1yP1Ox17SbNAsd86n0hL+NNuIOi9
	hgnauGOIu8+vVRema2TB2r82iZykR3gqgmJUvepqre2xp4awXLivIr0Rg/FJqiDAfZd8OxLWxeT
	SQCXadw==
X-Google-Smtp-Source: AGHT+IE6OSr24etnKRAVeW0ucA3S4ktB5FCi5MdQH2kT6HggNuPbZhFVkCzC2ipGvzXe9c/IyTBVfm1pHvo=
X-Received: from pjbhk17.prod.google.com ([2002:a17:90b:2251:b0:31e:3c57:ffc8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8c:b0:310:c8ec:4192
 with SMTP id 98e67ed59e1d1-31e3e1cf38fmr1125302a91.10.1753130197825; Mon, 21
 Jul 2025 13:36:37 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:26 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
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

The socket memcg feature is enabled by a static key and
only works for non-root cgroup.

We check both conditions in many places.

Let's factorise it as a helper function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 net/mptcp/subflow.c        |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index a6ab2f4f5e28a..859e63de81c49 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,7 +31,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 811f95ea8d00c..3efdf680401dd 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2599,11 +2599,21 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return sk->sk_memcg;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return NULL;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b3815d1043400..f9a0eb242e65c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -275,7 +275,7 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 000940ecf360e..ab658fe23e1e6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1032,7 +1032,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	bool charged;
 	int pages;
 
-	if (!mem_cgroup_sockets_enabled || !sk->sk_memcg || !sk_has_account(sk))
+	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
 		return -EOPNOTSUPP;
 
 	if (!bytes)
@@ -3271,7 +3271,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+	if (mem_cgroup_sk_enabled(sk)) {
 		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
@@ -3398,7 +3398,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
 	sk_memory_allocated_sub(sk, amount);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
 	if (sk_under_global_memory_pressure(sk) &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b616776e3354c..4e0af5c824c1a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3566,7 +3566,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f21d90fb1a19d..5325642bcbbce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1722,7 +1722,7 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
 
-	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+	if (mem_cgroup_sk_enabled(parent))
 		mem_cgroup_sk_inherit(parent, child);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


