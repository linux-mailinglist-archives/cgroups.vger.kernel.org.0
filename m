Return-Path: <cgroups+bounces-9085-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89095B21342
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4507AF86F
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9E2E06EC;
	Mon, 11 Aug 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYouSA09"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886232DECC5
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933509; cv=none; b=K09SAs1shrOQJo3Oz9NsbBs+d8nH7czsjkh2VQsF+SArao3smo/YRNltyauW4WaXzv2OMT5UKtuf+1f1p2K/P69au0+blcEvhpytD/dELJGO2C7osNMTLDP9OSjOl73n6sktykYWxo0aWIwEGoaylLgMx0YatlPvcCrkvkK0avM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933509; c=relaxed/simple;
	bh=xkRERDS1LDhtc4ABopT6NOBLc6UTOqA/kGMvd9jxHhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOVvjZ7idiQw0JKQY8EJognRBrs2KiXU/qgpa3zEXZfM5ymKKsZeldlsEHG9ol/Xrcxv0wUdULHbnBmdjOZawLjh564Y808OU2x+xKFAmiR8caSsYMAjl7/YyxZheTMwvDk01YDc1nCk3rR1NWRWcWUWo9EQJJptWp0i4yhLFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYouSA09; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42a11d7427so2593421a12.3
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933508; x=1755538308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvflH4mEPAWQ6li4TrYWNHfiAFRxuWfsFRk3VY+0HGw=;
        b=fYouSA09+azNyCfNt/WhcKTUFcGKWwaQwSLbFvY4HWmyKSJucYEP/aMidPyF7RtO1C
         onHl0fCUGqhS7wQTNI3R4kGzWntxWqA8BNieXHYk3eepbLoATxHnFEZtihrRYWf/Sch7
         ygfm3KspZ0X0hUeTjuoJYs4/3vZbJgyB+0Oc0cB7qaaqb0+EA3z2uor5i+xaaJo0Ncg3
         oU9m45whNFbFf5Y8LCgN2F7uqhgYdSYI9H71pqnzDtnaCRVV0P8gWJXBpSt7v9qUtSCl
         H9H4nYLrNDuTkwl3RDsMymeKhnAuPaMOndirFY17b1ukT0m8Q6/ZeVu9rG4Jj1NIVlUA
         oknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933508; x=1755538308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvflH4mEPAWQ6li4TrYWNHfiAFRxuWfsFRk3VY+0HGw=;
        b=S8+uXwBWoSg50DDciirJAgJrWVcoE57YGYuMrtLokj03d7pHzOmMznwr2A8DC4QWfC
         hEbi/3NEYBMX6xpVobf5HuRul7Mu4Db5M13U2iIXRPOfT9Vth1TP4wCtK7oBRYjB3OAF
         HYqHMb38rzokonigLd+NKIf4qL4F6YwKtTOMPLLM+2vebpBAjIeJNfxIhIz3uMXAVfyK
         fqq99D38z0rNF1GFxCRwZ2b2R7XCU5C8evh8t00Ayq/3I5rJtyS2ctd0bwZ0NkSGcXPl
         hdvNsExpDwkcXzhSAm4ah48WA3wdkCZnOWAl1rqaMbYh644GZXEyvpeM6+ZQTbm8NM7I
         GaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEH91V0v4BHCYqGAUqOStVI/ihtAJzhzeXJmUhs6a74gxRwdEvTqiL1qD5fogDdhibSz/BAMbQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kas2IA5B2sW6oWQfb7LN2OtC5CXfp3am7u1RdhlkXK9J7Jd4
	AxBwC+68mtUEeLFW0TGKejENCPWqOB3Jx3F65gfsxwmAs44Ruokkx8nmCWVD+T8Uye6goMaD/sU
	/XEY0Rw==
X-Google-Smtp-Source: AGHT+IHWru/esDMIorV9KwapH35BgNKYXxj+gZBO2aUFirZsNJPkvzOa2N5vDdIDqP57DTCGbEd9T+ROCI0=
X-Received: from pjbgf4.prod.google.com ([2002:a17:90a:c7c4:b0:312:ea08:fa64])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d85:b0:206:a9bd:a3a3
 with SMTP id adf61e73a8af0-2409a968d13mr468882637.24.1754933507942; Mon, 11
 Aug 2025 10:31:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:39 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
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
2.51.0.rc0.155.g4a0f42376b-goog


