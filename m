Return-Path: <cgroups+bounces-9233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF8B28719
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3121CB20257
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0730DEC2;
	Fri, 15 Aug 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGMTvg1z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1130DEAA
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289071; cv=none; b=WRi+ft54WD6tFIbAs7QLBzOFdI8ibtpBe4DoEg19h1EDVwCqr6lzjuxE10+KHQps/n+OlKSH5R09iuacn7RzLicmUIyLUsuD233FzJsrbEYdOX8SUllrJ9Rv1zs1E0s9V9n+W7Kdmo2mUNIuTMCrdAKo4h0DZlHrCI4XW6vFzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289071; c=relaxed/simple;
	bh=MRR/+pSEWAeLMgDmwMpMUrOeg1/9Qpf6YfZ+Z/dvLPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAasNPEl38+IBzlQoVLxit84rTE48XkaJNPDG+KtKYwlHHr1+4du/+D96xiaF5qlGah+IV66xPART9m1fSTC3OxmlXR5wjdO4t1e25HjKqT9tfyBVEdKfbs/wPubZ5J6c4u3YRaCpieTGhnIsnEWRLrG+xqCOxTqbhKuKcz2NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGMTvg1z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326de9344so4406399a91.2
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289069; x=1755893869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf92k/WXre/NA9XVBZNM2RHpUQnxne1oa7jt/AbjtmQ=;
        b=IGMTvg1zm7xKmKjxBCufmnZSRZJiG8jEBmPEFHT2t9m2YfPdze5xdbLOMDqwOODNYl
         9oHnpSw3nSc8rrZUDDghidSBjJH9yhRj2xegkKW8p73zglEeprQmhPux+tuFLWC+5/KE
         AWae3MMocRKmGYy5i1V3n0MLzTMq8FirzI/TK09+1AdOXU9arrmmxKH54QjDfqtRcG6A
         MWEBYr54fWgJ57NPrGZon6SdCukkp4cYxnlZ2dzUCVp2rDnbpj8NhZQruaSC3QJLWLwI
         4kDWSxpptGdAQdDDfjeIToMVT37VyNyaNFARKcwhqu15RhcgGo/c4Cn40T4lBlme7Vb+
         9BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289069; x=1755893869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf92k/WXre/NA9XVBZNM2RHpUQnxne1oa7jt/AbjtmQ=;
        b=WiEqy7jXDR11CqaoZ+F84iZ8y2wWQgctomJ4P6rnMEM5ZucwbZAFWkiWi8YVD44B3K
         0FF86+uxm6MtYXjM/3kql4gXogIcrf0U6JB4zjP0J8HgZJhEvEhzOVQwMW+m14KM3Xp3
         6NV4Ipz3AUkABOynRaGSiQKgH0P32EAvB0un9lWMEGZ1ibw8wlpSzKuUaIlIkWJhAHHx
         dya5jH+QAMiyJmYqDuS5qBhIQkZPaaHgYS2/9OnTcLWKeYX/0C/Uq17zlysywaJ22zyd
         4xJgRlkSzXCQnHGBIBLG3zY9a/nhAHV5zQD3BU50I+hTahr/CeUDyRhvqIW7xYh4iPRk
         wvTw==
X-Forwarded-Encrypted: i=1; AJvYcCUYBBHXZwGk0UZDk6oU1vNCsWcbwMNtDZoH6v7brxeYfBb+CKmCagY0Z69rjJEF//jlQS/Hqelr@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1VvxXNXrgKqB8oe4HE2k1X6TKT1DTELCu6i0mcSMuiUWNOVv
	JgpnUqQJm3B5pVl/66jpvWdXyaCN2u/3RHUIoXxJi/METfYihx2Qh33Hmz5hYOK8rlCLc7LiUAx
	PbjuWtQ==
X-Google-Smtp-Source: AGHT+IHqEnxA1uJzc0XPdj9fJKBo3wWRxP+lR/iywZBaE8USdSC80qtRAT2PdogMo7IxQ/C4U5ZzQhy0h2k=
X-Received: from pjbli13.prod.google.com ([2002:a17:90b:48cd:b0:31e:d9dc:605f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c06:b0:321:cfbf:cbd6
 with SMTP id 98e67ed59e1d1-32341e9b0abmr4796319a91.6.1755289069062; Fri, 15
 Aug 2025 13:17:49 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:18 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-11-kuniyu@google.com>
Subject: [PATCH v5 net-next 10/10] net: Define sk_memcg under CONFIG_MEMCG.
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

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3bc4d566f7d0..1c49ea13af4a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -443,7 +443,9 @@ struct sock {
 	__cacheline_group_begin(sock_read_rxtx);
 	int			sk_err;
 	struct socket		*sk_socket;
+#ifdef CONFIG_MEMCG
 	struct mem_cgroup	*sk_memcg;
+#endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
diff --git a/net/core/sock.c b/net/core/sock.c
index 5537ca263858..ab6953d295df 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2512,8 +2512,10 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	sock_reset_flag(newsk, SOCK_DONE);
 
+#ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+#endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
 
@@ -4452,7 +4454,9 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_err);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_socket);
+#ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
+#endif
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
-- 
2.51.0.rc1.163.g2494970778-goog


