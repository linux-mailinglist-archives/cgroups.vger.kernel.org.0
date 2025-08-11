Return-Path: <cgroups+bounces-9083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12BB21348
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DC13E37D1
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C82DF3D1;
	Mon, 11 Aug 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxWPVgWx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA62DD5E2
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933506; cv=none; b=Ydbut+wGnuaUsduZm/7xtH4YVdwDibwpOMn0Y27hnHiZ/zOYZBKBzTFHWnq7Zk4mQlo+gh72wyldzG/ZgTew1szXorriVGawtf7VN4K/ViNk3AE8wxSd4RxThxMoE5P1BmA7zBxD0ZDT4eJdpE0YDZgynyVlwopVXZPw0+4iQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933506; c=relaxed/simple;
	bh=ZAz1mVorVRFB618WT7mmuym45O0GXG2XAc0+SY/lJcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sf3dMuAskD3XyP2bf4UrSiQIU84SH22u2Rn81fxmpBIe3go0N0yzER1fKfDMu8EWUwmT1SHOwV0H8nYbpU+aE8HgaShshnWYiNDb7YGSfDHFt5DaoH3WTNt8wmKX9I3flzaGkTdsP7+PtAE9XA/GvZAlkaeGe4eHLuxnTm4nguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxWPVgWx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-240b9c0bddcso42902765ad.2
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933505; x=1755538305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=RxWPVgWx5tin7I4Fwr2uMm6VI5XTLrPfhiFlNQBiFeRFQv/OS6Yniuk3/Q21JYyaz2
         QK3LpA3hQYVYSdp/qLUVfEt1T9GYu1IcmQIav7kWDSp4lkrqk5WdKhMaviJ3e/8kMlE+
         2+gvIhYPtAwmwUSbqBtaNkLA07x9V11N/DetbS0mgOnN9O/rX6PCmYEqucxsLeoeYoCd
         AVa2kKBpSDSUxjGSUNRn9yLRMSe0ze180n7v/D67UgZYi5TuSK+F27BmhW7p/4e0TVJ1
         e2CpkbBbjE6X8e9iCCBcNKnZJOqS2hR7KQ90mLhHoO0AmDlq4J9upI1FnNFYzzbl3zxH
         2Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933505; x=1755538305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=Av2KxF6G6K0jpBGFsAxdv1NzvQtlB4BU/frj2aNFEScR2Gf87VIA6ZAbCMGGhr3YEi
         zGHSVYhZ9xrYpPCRjpcnIcodkXQ/MMYO6ZJ2f1NeXo8qZYvO39z7rLp3X8pyIpgDqbJN
         OGk4/YR9cXWb0GI9PKbSKx6A0WvKJwVE4wBAA//q+5O201mxj3wHyuaU2pWMTVbgEZGw
         6KNi1Xb86AKXvlkU/xeDlEGKGISgpS26jYnq7F3ZW41JdTC3K5ln8lBV/V3GbaVOYBQq
         JngwHGyztnwQFbrep6U6RCIQhcct4yPTLrKLjTqBVjuj4WuAdHa25Rzei6p0o7kgPNUT
         3Plg==
X-Forwarded-Encrypted: i=1; AJvYcCUvVabO+3oHi7TS+ItEZvRxaX69d/aQHDkZBfgwSILX1kYUmjC/b2BsbNWWbHgj3NHqUa8ZLMZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoWYO1e1RV9HL2xb+K2qul1qXvPYuEDRhJRMYirebAxEuh3Jl
	P214q2PO6NmyzHk4r3T/L+w7aujmafTPeQec6R3XlZkhtNDsEy599RM9ftKCQdPRioF935HMOui
	3UGDHTA==
X-Google-Smtp-Source: AGHT+IEtI0hZmQkLl6do9xR5bq6fk+hkwUvmFCZYReLtL0+PGPBf8SbdQd0pvNwlObuC5a18Dro3jK8mXEE=
X-Received: from plbmi15.prod.google.com ([2002:a17:902:fccf:b0:23f:cd4f:c45d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc2:b0:234:f4da:7eeb
 with SMTP id d9443c01a7336-242c1ffb1f7mr164182355ad.7.1754933504815; Mon, 11
 Aug 2025 10:31:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:37 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
2.51.0.rc0.155.g4a0f42376b-goog


