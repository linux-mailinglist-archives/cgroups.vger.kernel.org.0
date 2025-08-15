Return-Path: <cgroups+bounces-9229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6401B28717
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5251CE8DF4
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D932F9C44;
	Fri, 15 Aug 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9BMakQ6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82C2459DA
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289065; cv=none; b=l1SxobXUt5rGAplBEh9Z4IgNVtHNznUJ91fkaVD2J7t7xBo6YihxXwe1W7Dn9W5z2PxiIgdyLURk+nAd/f5MtxH4U99PW0hNzprzBEFh07MCEOpEz1IbrvY7jaxnQttqKvMgt7ZVOW4OSBf4NKh44Ws1PEOSoqTUi6Zto9Di8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289065; c=relaxed/simple;
	bh=P1p5zDYS1xHxFKHg6WTbv/b+iunvjNvMXhiBxP982n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/oi8mkABDTpa7oIS4yi1ANbmkTOUD6BK2BPEkoNbwWs3ADI0wt/uvrK4xzorQ1ZwvkDhoixdO8nH/N9Zg8sh2pYb6M5cMKSpaAb8LtLULjdp2jmLpL+L25ymZDQRgd7cEQyckZygedL2aoVC9w3ibfGW+Y/EED5La/IFmcnHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9BMakQ6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e8afd68so1881226b3a.1
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289063; x=1755893863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEvnK6Pj3gN8OdhZL7LCF5Umn99zHVRI3UVJuWX8S7Q=;
        b=R9BMakQ6pI/1rEcVi04hYVweMAwdqVsrp5Kp38Eu+7b4eNns/JsALbkoOFLLO8UgS/
         1ignBo+vn6jWyblGOrvjHPV/AK8OjklRACNqL2x3Zi7kQRB8wyPru/Bk3WcrXAp8MrPO
         W4ytjapWC/pTf93QjQj3z7burhiu+Gpajp2zgHQft9xKuTraDvi279IMo61nC3V+RZCd
         /CktoSjKzxzPCP2BnhzJc0McZCUzUxRfi33OXdFmVl2BX72sK+nRMFrltqJoZwwD4Ssw
         V4hGcXeUnXbotL4xt1RPHdHXj5anyO++zTEgP7aE/C1aB8XFo71sv2zfs5cP7w7hX0lm
         Jsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289063; x=1755893863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEvnK6Pj3gN8OdhZL7LCF5Umn99zHVRI3UVJuWX8S7Q=;
        b=HmCf0wwCHc3iiaUZC0LRfSAYuzCBX72uXXUwnowQIbbQoNFuc8L4ZjIGy2GaZ+9Hmo
         y+r54wVDRBBbO7lIiFctXnIS0dpUArvvgnK7onqBfqQSkWhY+4o9rZj32+tawEd06QMJ
         DB1EcxnB4SB+d5hKkxs9Yom6plnfNL0B1C1fv31IPw3cj8etv+D8hOlkbDBdlK/iFYJ0
         uyWEXtPz+kMHr2zoQJy95hbfxsjuuinnOONEOzi6t7jYcLlHCewSZoOabVgHYSkiP9Jg
         1EcitNi6LSGam7HCbeaniiWoLl0iwtJ04mtPDTswo3KNYHYqNdeVcYvxa9DkVeFv5/Uv
         CwpA==
X-Forwarded-Encrypted: i=1; AJvYcCU9nVNydrE3pE8VLmRBkvV8M9hVD4TUJm8pOJxk37H10hMlC+ZDJJZirFE71Z90Io41Fp0SCvsE@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtqR4YV/tGzvHYIpC6Hf2mNFnHC3YVq82nVmKor3ry/PEA3TT
	zSr38i1XiuJY30YRwKyrr3ONaKQd6BxIlTAluqg5jdRui8DQVHmygyHCa5kxYY+iIX1RobwHmEk
	Ruo2saA==
X-Google-Smtp-Source: AGHT+IGxIv0S/KYNNnJUfMwOQqTXy3ZcIqfpFjU2Pag6qHi+6din+ir3U6VMwmjnJzZZKWJVJdk8nIATIm8=
X-Received: from pfblg21.prod.google.com ([2002:a05:6a00:7095:b0:76b:d868:8052])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1391:b0:748:323f:ba21
 with SMTP id d2e1a72fcca58-76e516e9174mr461779b3a.1.1755289063124; Fri, 15
 Aug 2025 13:17:43 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:14 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-7-kuniyu@google.com>
Subject: [PATCH v5 net-next 06/10] net-memcg: Introduce mem_cgroup_from_sk().
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

Then, directly dereferencing sk->sk_memcg will be illegal, and we
do not want to allow touching the raw sk->sk_memcg in many places.

Let's introduce mem_cgroup_from_sk().

Other places accessing the raw sk->sk_memcg will be converted later.

Note that we cannot define the helper as an inline function in
memcontrol.h as we cannot access any fields of struct sock there
due to circular dependency, so it is placed in sock.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 13 +++++++++----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..811f95ea8d00 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2594,6 +2594,18 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#ifdef CONFIG_MEMCG
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return sk->sk_memcg;
+}
+#else
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return NULL;
+}
+#endif
+
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
 {
 	return noblock ? 0 : READ_ONCE(sk->sk_rcvtimeo);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46713b9ece06..d8a52d1d08fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,19 +5020,24 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 void mem_cgroup_sk_free(struct sock *sk)
 {
-	if (sk->sk_memcg)
-		css_put(&sk->sk_memcg->css);
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg)
+		css_put(&memcg->css);
 }
 
 void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 {
+	struct mem_cgroup *memcg;
+
 	if (sk->sk_memcg == newsk->sk_memcg)
 		return;
 
 	mem_cgroup_sk_free(newsk);
 
-	if (sk->sk_memcg)
-		css_get(&sk->sk_memcg->css);
+	memcg = mem_cgroup_from_sk(sk);
+	if (memcg)
+		css_get(&memcg->css);
 
 	newsk->sk_memcg = sk->sk_memcg;
 }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 724bd9ed6cd4..93569bbe00f4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -718,7 +718,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		lock_sock(newsk);
 
 		mem_cgroup_sk_alloc(newsk);
-		if (newsk->sk_memcg) {
+		if (mem_cgroup_from_sk(newsk)) {
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
-- 
2.51.0.rc1.163.g2494970778-goog


