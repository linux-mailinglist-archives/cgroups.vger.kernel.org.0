Return-Path: <cgroups+bounces-9178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C897B26FFC
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61A35A797E
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753725A35D;
	Thu, 14 Aug 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYpcASU9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E82580F9
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202166; cv=none; b=hlEZn0AZWb5v09/yMa7o1Sy8nB85RaTU5mmtd4tYcXpvxk3xA4dvadRFpRp3kBh0Jmgar/5FQG36ldAny7ru0xZKomeQlzVtiQQgvRUG7/Jl7GcxmSG59osLzAfFRt0PKia3kSQCzn/bFOpAaz5+PEJxRrNTpq9WX8Fx79DOPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202166; c=relaxed/simple;
	bh=OYwhMqPRagtIcBUHpo/Oc2UFRaQswQzrbLGR0xfc4DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R4dHCdlcYFWd9s0Rx/gB+G058kEH2QzgmF5zrQ2AtzB1oDmkJ6UaJHkkjJ0BcBSfhPZKWc9kn8GjLR32YdILhKOdsr2vk8iiSOZVnA3ZzNdc8ZekJmxvZ4APcDVTo9BzcscbRhQe9cn9yfy+8lYCq2Ik6kVsPIM+ayCO0NGpHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYpcASU9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445820337cso13305455ad.3
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202164; x=1755806964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMWDRwJwZj6qLhFgWvOz68lXKSU0dd2mnEaog5fuH+Q=;
        b=rYpcASU9hSMvcYObeBoxSL4uS3Z1bDfBBIlqPDS/KA4P0vw5/SaYoSBgMC2mkKBTtE
         ngP7s4W3qciEc2EhKW+UcBjm/za7LLbNmTbJDGSCv610n6b2dZ3oYXkPUHRpDBY8A14u
         DsFEsheI+3L5k1I9T8emxzIxZt1Ba7/DCONvQZcvhAg1SovXOLEVVPk62cjSTQ476zer
         fPUkDtOjWEYmN4nIiDpNWnY1QVb3+JTH/WrMAqI97QTiSp4p7NH2HljoopxGH7MflrzF
         B/VSukfgtgyNCDgDaAawT1gngk7VZKwu+5ijX11P2WnWcLMys2CXNLQ2PbzPJj/2M9Fg
         6b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202164; x=1755806964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMWDRwJwZj6qLhFgWvOz68lXKSU0dd2mnEaog5fuH+Q=;
        b=MqFPKPZLmlfxnNtX6UXRZVa+fK5Ayql+B/vVCjuF1VuPrMtU8fsSE6B1WxrvgK4iBk
         G/xvMwdEXJhKU01iESlZWdtn+RT7p5++eHfDan0r3f+nJH3WKLUj+HzITOzD+ibOa/4t
         KTGW1zwQut6FTGmXmw+FQ5Nmw0S4rgdK1jhFDHGRWG11qlAFCp5WqRKFl3vbevqTIZkN
         H7MfV0weEd1vxzSvwCplUtCZssmuCUjYyWa79JAY8hIcSprUoXVKM5emklSo0IHAUpNZ
         QVBFa6fM83Zb/BL3euOYgxmlWoPr6cno6QY9/6uSRqug/WKeUqOJIvYDSFaP3f2ErNY/
         gk6w==
X-Forwarded-Encrypted: i=1; AJvYcCUjT+JzYTUCDuhDEzHGOwKPn7KqGo7+qNlWHZPgqwhZ0pzfIV9m4SzDhn3soRT9wCXmtthBplbj@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW6k4KOl8jpshalT/DQQRuGY34LcWesbJL8OdOLfTVggk2efp
	mQ0Fp0AG3bvpG8zQ74y2iYCKRxcb1gaI3GULhOC3UxyPWAyMvCh+ZMQVz3ZF6ZFAa3d5PIySOOq
	fG2eqAA==
X-Google-Smtp-Source: AGHT+IFje8BoX0rFMQZYCLiSz6us/b9pp/B+IiT79+DebSAxtnCRFOhBlrxLa4L+ahHzlUigtDSR9HFZ8z0=
X-Received: from plhi8.prod.google.com ([2002:a17:903:2ec8:b0:23f:e59c:8c1f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54b:b0:240:6766:ac01
 with SMTP id d9443c01a7336-244589fd923mr76041705ad.2.1755202163976; Thu, 14
 Aug 2025 13:09:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:38 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-7-kuniyu@google.com>
Subject: [PATCH v4 net-next 06/10] net-memcg: Introduce mem_cgroup_from_sk().
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
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 |  6 ++++--
 net/ipv4/inet_connection_sock.c |  2 +-
 net/mptcp/subflow.c             |  2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

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
index 450862e7fd7a..1717c3a50f66 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5023,8 +5023,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 void mem_cgroup_sk_free(struct sock *sk)
 {
-	if (sk->sk_memcg)
-		css_put(&sk->sk_memcg->css);
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg)
+		css_put(&memcg->css);
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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a4809054ea6c..70c45c092d13 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1759,7 +1759,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	memcg = set_active_memcg(sk->sk_memcg);
+	memcg = set_active_memcg(mem_cgroup_from_sk(sk));
 	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	set_active_memcg(memcg);
 	if (err)
-- 
2.51.0.rc1.163.g2494970778-goog


