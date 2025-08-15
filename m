Return-Path: <cgroups+bounces-9230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6AB28718
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743C621359
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E88304BD2;
	Fri, 15 Aug 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ifm3n7iW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34B2BEFE2
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289066; cv=none; b=m7u+cRttP2Q7eg6hcEIJEQaqhWYNJkKCj1AdLZQWPq7EmOFP4bxqhPHMgBki1KSpbZ9KO4ER+VTLgd2Rz+RSzLoXs7zFV5bw0g5q5YNoR4b16nxTDkonOysbDvf/x2wMFwz+Nz/RcBwnnhODmL+SgDqyF8PqZCsn7KiZrIuRlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289066; c=relaxed/simple;
	bh=xgpsREOCYRY1NWdqxf1bGZBj6wbqBx7wgP4twWSHYDI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xu0gbEg6Ix8BGj1dPT281mCG2MYbTRwEM9Z5v4X//92jhRQnCQemmGNlYDS5Di9ReJsqq2kKFG4RsNtzMgdXM+MIPEz9JuG3F3Q/dhM6hqxL5egBzgsEIg2zn1IhwLdyFk061BW+Fd5LZvalNpKRMx5kKrSJ+5FyIvkQ1Sm2JWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ifm3n7iW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so2141796b3a.0
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289065; x=1755893865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mp+7e2gfxyzJJta6x3bXxbo+4BlzrD3g7OeGza9E6Y=;
        b=Ifm3n7iWKHMrAFrU95HdPM50ZDn8OLGgH702uPj2g4BU9MoaHIEburK5WnR8Oo3wYX
         KHRW4+ysLFqXhLM92UIH76c0JrNhUtqaJ5+zZIgZlX0+G0riuTRwfjHnF63mEGh8on3Q
         dMRzVgnIjg9u6JW0mMIefmBykiPJLUTCo338vxWoj1c43ULL0hdeto+cBqpcncujkNUq
         10G0zL+HGnsV/GIpIivXs2Zl5DtPZGCoaGi0e0m4frO2Vi+MFvDObFCe3G3fBjBwzJ+D
         +umMME0wyQzp+pTOCr9lpPO8w7JwU5RN+glHYUYdWC0d8gJL0CyjFggoN61Ozq2l6SzA
         GNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289065; x=1755893865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mp+7e2gfxyzJJta6x3bXxbo+4BlzrD3g7OeGza9E6Y=;
        b=pmXtjx/l+N3s4BQhRSy0z/IKIDzqNfP6lVitjhG2MdXHAV7B2G8MgqcPRgpMd+r/z3
         8NDkbBz6/piMBOyslkbzQ0EvZU/7pqJWwqwuX2zZ0fqwDvw0kJmBeWEPC4Q2lTgdGeWC
         fEE/JLsG92y0eq4RQY8CFL+80FInYCBltPhucIYT88uQgiUJ0N7lqiAWDvQF2th/3rPZ
         C1LAPEPMs5k0QHYyahXQCWMsxYYZzZamAfm2OKGorNLFHOVNAPp95QNPWVdieajpP/8w
         qj8HGm4X7lSWnrNI2pyXH0C7lWWBxi88e2TF7b6BZqlU8NEJSsZUQJ2xYxZbbSjo5+Jp
         NvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc03Kd26Doy25DqGhNgLlOuAARrABkDdWdh1c5LXwORgbEGOgyuXPuFC3Uqn9P3WhD/ug5mcBX@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBN4IAVPLfrYBJPzM16uiG+a1C+qBI0JT4pgUd5kTDwblORJg
	ntNeD69XJTp6IFD8/N67lOITWQEm2GNXfZikP/7qvwBYoM9xRjQdDL4dJs2L1tgha3DU6+6Fn+w
	VTFDzJQ==
X-Google-Smtp-Source: AGHT+IG5FBv3Dc0dvsUM0MYH02dugnLFfR8sX8Mh4NHngLs2eiGnFx+J6RBCbR3sas2sD1KA15Q90KlIGAA=
X-Received: from pfrj12.prod.google.com ([2002:aa7:8dcc:0:b0:76b:3822:35ea])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b42:b0:736:3979:369e
 with SMTP id d2e1a72fcca58-76e446ffb04mr3567357b3a.9.1755289064709; Fri, 15
 Aug 2025 13:17:44 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:15 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-8-kuniyu@google.com>
Subject: [PATCH v5 net-next 07/10] net-memcg: Introduce mem_cgroup_sk_enabled().
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

The socket memcg feature is enabled by a static key and
only works for non-root cgroup.

We check both conditions in many places.

Let's factorise it as a helper function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index a6ab2f4f5e28..859e63de81c4 100644
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
index 811f95ea8d00..3efdf680401d 100644
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
index 526a26e7a150..9f01b6be6444 100644
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
index 000940ecf360..ab658fe23e1e 100644
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
index caf11920a878..37fb320e6f70 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3578,7 +3578,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 }
-- 
2.51.0.rc1.163.g2494970778-goog


