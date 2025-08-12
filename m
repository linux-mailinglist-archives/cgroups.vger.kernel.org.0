Return-Path: <cgroups+bounces-9106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C42B23133
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57E86E075C
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354AE3093D0;
	Tue, 12 Aug 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNbe17o4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA0307AD0
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021555; cv=none; b=BCktSbdTuS/arcI7YJeIkcXfHQFsML17L0RHzJt+G2divaoeTyuFHFsJ02VpHq7WNONNZG70XJd0frTXmXo4CbnBd27frpjl/+ekm/vBzG8iQ4EVUKvXmll/IJMR9OCnkzFPEQEe0ihAft6sDpL3KV+uIT55ATyXvBVoPBluNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021555; c=relaxed/simple;
	bh=AzdjAyuAeTtLY2TPo5CDqjmI3gwoVZT9bLy7bQdg2ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfrNGLwQHsTmCpOYK7XCYjkzzv4X/J5h2FctmC40vvQ798BOYIpbP211QRSlICe7JZ4Zo8IMqqxOqYoQsUVi12s5VJP3uhgMiOJcmDWGrOLkAVYKcEieI5U+2ObkpjmEUZTKvNt+XIYdqnMicJ3um4ZiQOrV3vMLn2lkhg0ZrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNbe17o4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea7007866so5227790b3a.2
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021553; x=1755626353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovBhq/8jpHlM6xqUqyu+IoeRpzyccIKyfTNMwGT0Gbo=;
        b=ZNbe17o4sOlccgInsFDxKpnaq7QDUTnvYgeYcKGDuvxpfm61OZCAC1hgpGZ+GpV9HW
         A2HCjbIRyhAXAissFKpVEFCQX4tu1Gs9VATMdgexpUBYRO9cN16DhNYKaFwPjXul5m56
         bcD0CK7R2vwZjrxvV0zsdAuBpXwtrIqsG2rgNiaR0oQWRnQqvj7sPwo7QsuWij461BKh
         vCUSarO5vPQEqVaVxBzLIdzOS4oqwAgB8fYG54r3OHmjYKsSFtKQ7TVmSy8fa7BA9gbL
         4vOOlRI1fgfoKuVOLx6VXGZuQmiZ4mo384MKge2KuJY3vmY2v3N7aykgoDdjeH4R2VcY
         7hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021553; x=1755626353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovBhq/8jpHlM6xqUqyu+IoeRpzyccIKyfTNMwGT0Gbo=;
        b=VfHAFxSugcBsM4hf62aeCSnPvt25x0Uq6rOfiAmamhIkhKf2AFFZIak5OIIMycvC5j
         m43/FqO/AE0nbwXtyOZ4v1BdAaDqDjbaTZIQ74+Kp8CnMOF+RsIQ5kxdQ9CIuJevbbJw
         LQYEL1/ayuqzcuYa69oxMMUgtfa72d3buzfL0ddYdulYt6Sl/IvWBCO7TFK1Fk606THd
         Ybsv2pXgM4/7SFFhsGDTtIOQFrhjpe6fIi1sUrtGC/JT2/deqL4LZxxVc01AJzvH3zbO
         KMIt2rcQc+HyhusgT3BqRkM4ksYuoUq1VZJ183RxJbMsmYFHhvnNOBaP2AFtpihBenpf
         g6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXgJ3xUZ4kV3Z8vWlroqCaEq1qswVs2oPrVMml2VCwuD1DrS1itPcBdh1ZeS8BZpnC2Tgprs9ow@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLJeKIaMh/+2N3NcJuP5fFtOYDZhfb2VOfR/e+PHsk7w0rb/f
	sa0KLnTyIdae9GAoCz/XHBGlAevtTk++MNC4hQ+SUADEgl3ZR6www7g4PkVHo8ssWKnJNf2SnTq
	t44HHNQ==
X-Google-Smtp-Source: AGHT+IE5Mz+dp6VV6fNyX45tpzOfL0y24+xxBoFkDHbdJqD0bFXipR3WVQOWKJpZtMRbGnc0JSgega5q8zY=
X-Received: from pfmm3.prod.google.com ([2002:a05:6a00:2483:b0:76b:d2d1:119c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8e:b0:76b:e561:9e1b
 with SMTP id d2e1a72fcca58-76e20c9a3efmr172719b3a.1.1755021552359; Tue, 12
 Aug 2025 10:59:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:29 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
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

We will decouple sockets from the global protocol memory accounting
if the cgroup's memory.max is not "max" (PAGE_COUNTER_MAX).

memory.max can change at any time, so we must snapshot the state
for each socket to ensure consistency.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and add
a helper to check the bit.

In the next patch, if mem_cgroup_sk_isolated() returns true,
the socket will not be charged to sk->sk_prot->memory_allocated.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Set MEMCG_SOCK_ISOLATED based on memory.max instead of
    a dedicated knob
---
 include/net/sock.h | 23 ++++++++++++++++++++++-
 mm/memcontrol.c    | 14 ++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1c49ea13af4a..29ba5fdaafd6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2597,9 +2597,18 @@ static inline gfp_t gfp_memcg_charge(void)
 }
 
 #ifdef CONFIG_MEMCG
+
+#define MEMCG_SOCK_ISOLATED	1UL
+#define MEMCG_SOCK_FLAG_MASK	MEMCG_SOCK_ISOLATED
+#define MEMCG_SOCK_PTR_MASK	~(MEMCG_SOCK_FLAG_MASK)
+
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
-	return sk->sk_memcg;
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= MEMCG_SOCK_PTR_MASK;
+
+	return (struct mem_cgroup *)val;
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2607,6 +2616,13 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = sk->sk_memcg;
+
+	return (unsigned long)memcg & MEMCG_SOCK_ISOLATED;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2634,6 +2650,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return false;
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d32b7a547f42..cb5b8a9d21db 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4995,6 +4995,16 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
+static void mem_cgroup_sk_set(struct sock *sk, const struct mem_cgroup *memcg)
+{
+	unsigned long val = (unsigned long)memcg;
+
+	if (READ_ONCE(memcg->memory.max) != PAGE_COUNTER_MAX)
+		val |= MEMCG_SOCK_ISOLATED;
+
+	sk->sk_memcg = (struct mem_cgroup *)val;
+}
+
 void mem_cgroup_sk_alloc(struct sock *sk)
 {
 	struct mem_cgroup *memcg;
@@ -5013,7 +5023,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
-		sk->sk_memcg = memcg;
+		mem_cgroup_sk_set(sk, memcg);
 out:
 	rcu_read_unlock();
 }
@@ -5035,7 +5045,7 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 
 	mem_cgroup_sk_free(newsk);
 	css_get(&memcg->css);
-	newsk->sk_memcg = memcg;
+	mem_cgroup_sk_set(newsk, memcg);
 }
 
 /**
-- 
2.51.0.rc0.205.g4a044479a3-goog


