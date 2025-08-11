Return-Path: <cgroups+bounces-9075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90636B21332
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522FB1A21B98
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF2D47F9;
	Mon, 11 Aug 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQVbBYFK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053229BD9B
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933495; cv=none; b=p2N3/qLOkYccvTmdZduds3W5w1LMjWnTK3uA3veieeef/qimMGggVftrwygOfrB9M50a2ja90Z2EEGV2looYD1c1KOhxu+4l1N+YQHVQaXzqV4l7g2AYf3De6ig2VruOLk4yVpbeHeyY21ST42ArdiqLfQ7KzT9taw0+UEjBqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933495; c=relaxed/simple;
	bh=RraDdlXe6ciaP6cYzKFgCu43EUAwSOZf2SxKtlzfM/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JB8u0pKrFsawYsMiTNiuE7/Knz2VH3jT7tbGGfvm7+xNDdHptFr59Vy0DvRdIrhvK+T5PLIbrMvtZWLc+kvAmYHbK3lxY483l+QRX2kl1ZIkcr/ZpSHPuApHdLIOHhSVi8YbduY5MFcD14gvZ8LuQqur+G1xIZyEgi/cV0bFDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQVbBYFK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76b6d359927so2887903b3a.3
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933492; x=1755538292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=aQVbBYFKO4gAwr65dH45TLAvKY5lFG9OJxYIgtKTqGRZqW+zGIZfZ51O1ZeZX2O/nl
         7QlORFFS6Sr3cPL08/oaIFaOvT7wPbi2gUzDEpktQ9BH7DSsIQqxfgP8QRDFmoorQDx2
         XufPk4jn7l+yJE64Rxa7sajFUIWx8cy32jjMoOuEydqeutzw9K0U7swo2AknnX5bgBXB
         O0RyabM0ccBn9BsmeuGAQEdD+YVvCEhT5hJiIu4QuyE9NJkEAxdSZHOQU++ggxQEiNZA
         yGSRUNilrTqTk+uhdzLwlJ3JOKJETWiBFFLt38c8633zCrZqkVdN07zNJlzR1NcO9moi
         wfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933492; x=1755538292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=ir/a4YIJ/iJ5x6SIuGu26YZWL3Dsl8xcNBwrzKZiA9imu2J3f98iuo5bPTDr6jbTYj
         m/4VIdRRXUx3OFcvsDL0uGL9jw5/7wmWGMsn26KlT+m2KHM19lw6+ZAlxbbSQMC9yJPu
         4D4u7hOfniBLKzcbJH86eqUsexcEaX5AD44UalnQghFP35tf4ldGThxc4Kr76CiLQF1K
         YRKRt2Gv4haQe4eNw3rLzLRP4mM9DaO3kcBWAtdfHz6stMVhP7GSZhOF+XQT39ohCwvY
         2eH+A88FPE5yHXbuZjRiLQpcYOqWK9wuAQJaNnWv5m+buxHVQLhFgjxrZ0CJVhCCoFcb
         pH/A==
X-Forwarded-Encrypted: i=1; AJvYcCUBmR0wRANxm7kBrzPdwmM15bOVdWhRn4zWWEEkuyCXknhFIDXuqPN0x0rFr5ZaKJdTzPHXyhoW@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeiyyFKnF7fhqW4nQePCTPrAtWwHl1WsreRFfBscAGx7S1Bf9
	FRFw+xifuVyZYh0ITlQgBif24RKab9Hdq0eCXPHCFteI6Aa8zY9dTaxCr7r2zY7lJjgQsgj793M
	p+Wce6g==
X-Google-Smtp-Source: AGHT+IHo2yNLTeCJQnssS8cRVh9LBZumUnUBfB6vxpMn5hTdAQ6pUphTOW3txkt3Suq2A0M516UNLF041yo=
X-Received: from pftb15.prod.google.com ([2002:a05:6a00:2cf:b0:76b:ca57:9538])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1b:b0:748:ffaf:9b53
 with SMTP id d2e1a72fcca58-76c461af0ebmr17005996b3a.16.1754933492214; Mon, 11
 Aug 2025 10:31:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:29 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
2.51.0.rc0.155.g4a0f42376b-goog


