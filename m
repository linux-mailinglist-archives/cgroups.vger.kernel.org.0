Return-Path: <cgroups+bounces-9104-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC1B2312D
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 20:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BB9580BF9
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C62302CD2;
	Tue, 12 Aug 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwOQStoX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E32FFDFB
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021551; cv=none; b=iXyfMLZx3WvWhR19WblK5zUGg0MJagV7cslXLcjPV5lErfmYAg/ieAehisnhng4uR+OJkLkeD1xVHNwFRq1mxX3tDOXnM4+Fz9ApbIVshx00wETg4NUcmYMagq/IFXZ8k393vLkb2jigHSYQ1ijM2vn4sFuuDrcsa6pW4qa3q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021551; c=relaxed/simple;
	bh=jOslt91PW8Uwrsjd44KeyK+AgmwIveniaUCIRfb5Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nohq9dX0Q3yNpsWvxwlQ7EjbpI2RKxAqQA3CfO9ocOvATgMbFRSO+G9ArcyJH45JEm8wW0uwJeL1crrCq+XfT3qllPSoAwP1HDWm6y1D59Xi0OefBKK/fdswYhutRtbHbtkmXpvnY+kXFJX7eU2qcpb7TcSO7swgvlMW4dzxfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwOQStoX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eec17b5acso6747614a91.2
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021549; x=1755626349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAQKiMCakkqwV95b2b8VWBJpRa3xearNZGx30z89mh4=;
        b=mwOQStoXBQnn505AEObqvBjZmVfHxq5fY86jREmmdLmRMxR0KOzGXY7xylYC/6wwAe
         4dxqsnBBmwiwKVJlaYTtXXkEA1kbNh1SENRdjG4kNB6mg++NTZYPLlXlIdhuzdJeRdv4
         0nH9tYGf2u+iResmEvu0LYibbAFlV3OtS1AjgRZa8UUa9MaavjpUqc6XL22h65SR+2u6
         m6rt0zM1VZF4cRtK3sUtg4MSU0OriQI55favX+TSvaDn7X3QaWXB5q9SbiMPCUN397U8
         BI0Ehu2royf/zN6DkfBdVrtPJGLprRrQCfVZvaMEIrxdELJ0xkF23v8FJAj0bYRPgX3y
         Q6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021549; x=1755626349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAQKiMCakkqwV95b2b8VWBJpRa3xearNZGx30z89mh4=;
        b=R2spkrnBQDZuIpw6KciRd5qv5w/p54vRrtUGcR7FiuLZ4vG/v/UAE8qK0VM4PmMFMn
         zityMv5zK3mIvJL9qIrFOEeZS3cTkScorzjP9Ia+3fEFOBBK/OjcZ8UysgKCkRJAW85m
         dMpT7tK5mWjOq3SipTANKPJB4etonvOmOMqrZv0qABxyIWQDVaqsyvbxzn7fRZqxBSh6
         e1zBuCoUrO4LS6rlsGEBJ5Uxf+MqK/jX5vLLCq0nVDrcNyIUwDdtD2MPW8WEGCRvNA1n
         L65FxquTLfWbjoYYWX8z5Bjg8juvkOzsex658QGX1WpTSAHkkzHZXmOBxbKMRgg48dRk
         /J5g==
X-Forwarded-Encrypted: i=1; AJvYcCXB0s3/9e0Uo+r8nwjUGOm2s6ufzmwTUEYYqewTuYJugF7B7JvcCBIUmiLpdEt5IT3OdWonLccT@vger.kernel.org
X-Gm-Message-State: AOJu0YzijNxBmddPLBZ81oDfebUHegVHU8pCp6L5lBDdwKYFc2TEsDuH
	Ih3fl8mu0EbnlztLbsRo+fsJ1cb9lQRpkZKdZ2tyeCDvZ+jLs/qYN7KU1OynOuMb1LmrUXtYllz
	id+z0QQ==
X-Google-Smtp-Source: AGHT+IFO4uc9EvAV7okCx9zQHxmIApDMA+yhfz+lGyPq4mF4kWTkx5Mc08aiDs0AG+bvf5xkZqRyMQpe5fQ=
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:311:c5d3:c7d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dd8f:b0:311:eb85:96df
 with SMTP id 98e67ed59e1d1-321cf97d624mr650175a91.17.1755021549334; Tue, 12
 Aug 2025 10:59:09 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:27 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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

Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().

Let's pass struct sock to it and rename the function to match other
functions starting with mem_cgroup_sk_.

Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/memcontrol.h | 18 ------------------
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 22 ++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0837d3de3a68..fb27e3d2fdac 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1642,19 +1642,6 @@ static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
 }
 #endif
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-#ifdef CONFIG_MEMCG_V1
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
-#endif /* CONFIG_MEMCG_V1 */
-	do {
-		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
-			return true;
-	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
-}
-
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
@@ -1686,11 +1673,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
 {
 }
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-	return false;
-}
-
 static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 859e63de81c4..8e91a8fa31b5 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -32,7 +32,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 		return false;
 
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3efdf680401d..3bc4d566f7d0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2604,6 +2604,23 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+#ifdef CONFIG_MEMCG_V1
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
+#endif /* CONFIG_MEMCG_V1 */
+
+	do {
+		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
+			return true;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return false;
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
@@ -2614,6 +2631,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f01b6be6444..2936b8175950 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -276,7 +276,7 @@ extern unsigned long tcp_memory_pressure;
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return READ_ONCE(tcp_memory_pressure);
-- 
2.51.0.rc0.205.g4a044479a3-goog


