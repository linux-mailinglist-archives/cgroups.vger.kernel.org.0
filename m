Return-Path: <cgroups+bounces-9096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8078B23120
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 20:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68BD6880D2
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9F92FE59E;
	Tue, 12 Aug 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pu/lp/Ae"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA92FDC5D
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021538; cv=none; b=NiYo3cPhgSmmOEPyPpJOKr7fV5ba4KW11xb/+/sPTu7QBYadlFn+ngKLdTztCr6E5iO1go+6CBr0hjfTvkzcT4mBbnBA+cOFmphLxtOuTzzAm1AcRcgAtQqnfa5TbMyyE12Z8JFQHBESWHnYCkCs5MB7kQjUTnj85AyxLSq6Uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021538; c=relaxed/simple;
	bh=q6y1Mod3BWMdsGSHg0SEmtds3ikTNBJyifvdqgX0uCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiUSlMIV7yR+lt+BVyyZPjQuuyz6GCpTqjCLWsohtMxhy6DsbG8kyebKpwAoS5fjvtHcRhKNs6dBC5t/LDa1T/RIeRD6ckkI9bjdhiC7DQNxNDsHxTPr3WB+w5bNpCZMQ+LyqjtcH2EXB/GnY7rtZ3zPjReK4CyWnbwIJLpl+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pu/lp/Ae; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so9593485a91.2
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021536; x=1755626336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5967b+D6n+JBP35k0TPK9w7l1JYggqKd+S8TzhqKYXE=;
        b=pu/lp/Ae0QB6026p2iTPwUBFtzwbzP00owp1yajb9hU7YRM28yN7nVN8UWzzSz2vg4
         cnlIkLU9oEGVJQCAqva19XsXh1FKqCW42mq+n4gbTPvYL3mKLy+BGbSvRWHCffA5Bkyv
         dgELDZDOKO2oPk+jkPUODxK+/YvSlFt38fYZpH4QDz8KuYjExrVaOfOCfuFdd98BMFEQ
         yAJORqFTxG231570rYAd7iXCkySvh7aNNHMn8jfFZvO7Dy897+Jcx2gOcBbOWaUWwG+2
         5c4RuG4FSUD2XXFl4fsOTk01jUsqQ+4AjeU0cplucS4F/Y0avghwiwgCD9Ssrc9/zrVP
         E97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021536; x=1755626336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5967b+D6n+JBP35k0TPK9w7l1JYggqKd+S8TzhqKYXE=;
        b=DSrrcCp40abK0eDx3oU0kUrThxZ3yjNBwEnO79DrPn+g9wyFbpFZDH70nwq4cBWIIG
         TkPZGbf0etUuFfLq9qNmzM+lYXoPc1Pb4blm3jlywDSrMG2IKlPk+g92INmN2zKi+zQn
         g3LkuF5YsUibiv+P2cdcC79rihZNLxKqAfdnefqVg7pZNgG12A6koV5/V1GafWHTNEkH
         amEFT4slnnA4FFv42Bff/Gu0ijkJRnLsV3/x1co5YGkGPQOMG7WpJkV5xRwDHVvl0Abx
         uWz6u6G+03MtNM0ry6nh2av3EoN/m0nA3MgRE+YkDqsOYAi61sRqAJEzqN0CEJhP3412
         6Ytw==
X-Forwarded-Encrypted: i=1; AJvYcCVigG95Bajt66/KLM0MLdwXEeBa2IT/RMEZXKj3iLCFsynGFWTHF7U83QI+Sj83+0QSIiPnoyH3@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYBOFrypl7Pwq1qhwwGihz+9niOfshWTjc2Ggd4/blm7xOTeR
	Zsut5JuD6Zx6YFHkOZoruSTIns7+UBc0za5OZZBk4vZH+Y4zQTMfACptZWt+hh8nPNCyrgRWo9N
	q2I9C7Q==
X-Google-Smtp-Source: AGHT+IEHywGL60FQFSS0J0vulVLgaUAf9Fyk68Q4f3QM+UdkI4p7EfgIk7dpwlIPEPt8UyX87u+Sce3emJ0=
X-Received: from pjbqb13.prod.google.com ([2002:a17:90b:280d:b0:31c:160d:e3be])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:de85:b0:31e:94d2:c36f
 with SMTP id 98e67ed59e1d1-321cf94cc50mr651519a91.8.1755021536592; Tue, 12
 Aug 2025 10:58:56 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:19 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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

When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
sk->sk_memcg based on the current task.

MPTCP subflow socket creation is triggered from userspace or
an in-kernel worker.

In the latter case, sk->sk_memcg is not what we want.  So, we fix
it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().

Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
under #ifdef CONFIG_SOCK_CGROUP_DATA.

The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
correctly.

Let's move the code out of the wrong ifdef guard.

Note that sk->sk_memcg is freed in sk_prot_free() and the parent
sk holds the refcnt of memcg->css here, so we don't need to use
css_tryget().

Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 10 ++++++++++
 net/mptcp/subflow.c        | 11 +++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..25921fbec685 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1604,6 +1604,7 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1661,6 +1662,11 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..08c6e06750ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5024,6 +5024,16 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+	if (sk->sk_memcg == newsk->sk_memcg)
+		return;
+
+	mem_cgroup_sk_free(newsk);
+	css_get(&sk->sk_memcg->css);
+	newsk->sk_memcg = sk->sk_memcg;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..6fb635a95baf 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1717,19 +1717,14 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	/* only the additional subflows created by kworkers have to be modified */
 	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
 	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-#ifdef CONFIG_MEMCG
-		struct mem_cgroup *memcg = parent->sk_memcg;
-
-		mem_cgroup_sk_free(child);
-		if (memcg && css_tryget(&memcg->css))
-			child->sk_memcg = memcg;
-#endif /* CONFIG_MEMCG */
-
 		cgroup_sk_free(child_skcd);
 		*child_skcd = *parent_skcd;
 		cgroup_sk_clone(child_skcd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+
+	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+		mem_cgroup_sk_inherit(parent, child);
 }
 
 static void mptcp_subflow_ops_override(struct sock *ssk)
-- 
2.51.0.rc0.205.g4a044479a3-goog


