Return-Path: <cgroups+bounces-9080-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42DB2133B
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F281A21BCB
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA52D3A7E;
	Mon, 11 Aug 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRhzY6RB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4D2D6E62
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933502; cv=none; b=JnUiohQzwfH4Me06Y0vSUrxUTblt/UwRoM/bHc9RIZZlhmShQ6wIUYX8Yhe0U2GPVTt0PrqalC0ZHkGaBZTBUrou93onw348kLsdv4TF+4r7vIH8Byqb5xhOKOmqC4GkhxAPQAv4VnzYhEfJpw4cqxQIUu3eT/Yu/h49qSmnT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933502; c=relaxed/simple;
	bh=djnZb6zv07TTJapDcbZzy/mNZjUZFqFs7UwvKkwxTow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f83U9UqOV7Z8I9iYYHwN2jPx74D8xt902LcjYpiv7jOO7m8/iLDE052vho/yv2x5DkEw1qSOIW+9kUwGay45P92QVTJNL98lZCB2241KL/49tFlizdg+jA3hHQdnXMg/ovAJqHH6dhydRwXs0cYPMm1GbxJdA+qZwu7Z3+zWjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRhzY6RB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fe28867b7so61592065ad.2
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933500; x=1755538300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1evf9NP8gzujZSmc68LKGIYtEyxxeyxaSo7A1dSfcIM=;
        b=QRhzY6RBJeqWo/vq0p/67yAZdJYc0iwrap8kWxOFE14sYddm5moZf4qyegyucx7A7n
         3VhKYjrAQCMZlpV7W8TXj+ncPR21tvEeCSsCojCFydaTZGWcXMBiYpiufsEPM7Hpkzro
         Ez+gvVRNtgUT+WY7BIyWozi4COVy2Ba2z0jPwr8t1yZUV7QiKTTbsejlX69Vqk5YZTv1
         jrPrzh9gJQzqIEVEZp1wckhFhjMeR+0RInJNmGk1SddqLOjfeJDSzLyxjGPN192TH3jB
         m9x6Yy7rkVj09j1v1vOO3O4pSbbB9Fjb/BwhNLEU9HC6coxH6ltNtF6Tk0X3hb7B63Yh
         dpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933500; x=1755538300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1evf9NP8gzujZSmc68LKGIYtEyxxeyxaSo7A1dSfcIM=;
        b=Wso83953rf/FQZfdyRfB+usxIAJRwx/wSX7u5NrihQoJ0SD/OQwfLFsgXdQHZmdD4s
         A1X6C6sXDoiJNVH8qKd2yiuLRLz5Dh0DE4/IDoproB09K1MaKW1rCY75V2nXo+dGLpWl
         wYu8p3j8iBbOQpb7cdpLgdiBESiwIY09hhryxd4rQl6FhkkZcRRZOwt5bITD/mLrHkLC
         cgZb3IRIJ4LzjUTd4M25h+5SXBf71Tdw5deuVMTcvANHEgHDjPWufsl1XpMrmwjhHuMX
         0PIywGEjLhFJaOvkiLPHrblNkCnRffnVC+8ZYxM1EZ9olVts5D8t1/euiPtSyLrBRNcn
         ndvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQV9TvmrF7Ub/A1WYKXBCx3rP60yRX+cX0j9fh6+CI1IxtJYHSIjAx7HbigEO5QZxN4ojjUKFp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45RSKhOS41IqSsAzt3KGheGEWsCNwDcvh40eoblVA0yTxxDKG
	1fuD3Gv0U6pAFw80OtDR9dENnyqb3YpqWL9A3DC3jb+OPcyDnrgB+UtOFKZ0Ep5tey5u+7sDac5
	VpfSXUA==
X-Google-Smtp-Source: AGHT+IHeBDKPPyqvP1rUR5CAMk5yyduE4pb1HwUuCqZE282C8A61+qQgO/7HcPgBMgw3doePxcL7KhLi5Vs=
X-Received: from pjbtb5.prod.google.com ([2002:a17:90b:53c5:b0:321:ab51:e32a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:240:4faa:75cd
 with SMTP id d9443c01a7336-242c225554emr205009335ad.48.1754933499961; Mon, 11
 Aug 2025 10:31:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:34 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/12] net-memcg: Introduce mem_cgroup_from_sk().
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
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 14 +++++++++-----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

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
index 08c6e06750ac..2db7df32fd7c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,18 +5020,22 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
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
-	if (sk->sk_memcg == newsk->sk_memcg)
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg == mem_cgroup_from_sk(newsk))
 		return;
 
 	mem_cgroup_sk_free(newsk);
-	css_get(&sk->sk_memcg->css);
-	newsk->sk_memcg = sk->sk_memcg;
+	css_get(&memcg->css);
+	newsk->sk_memcg = memcg;
 }
 
 /**
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
2.51.0.rc0.155.g4a0f42376b-goog


