Return-Path: <cgroups+bounces-9176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867EEB27007
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51691893221
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF5259C98;
	Thu, 14 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd8VwE1N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA62550A3
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202163; cv=none; b=jh9IZA7tSaoUBb/OSBakPIgANK4VwW80T6QsXMwQSPUSeWAVJhtKE/WVFPLlzM6VLGYeVzNas8WSUpz9WoXf+eSiT20odFEU1lwiBIzY6ZVga1+inXGJTjOvZmz48mXWzxoSCFTv4hJJGoXfLlWwMoUXXQsnBl79BoKfRdOpOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202163; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcRW4FVHy1J2ypbejTaO1Ejz7Vso0Y93ZvYPCy2e1WEh4l8seQNQTyXYZf4FCByyPjE08e5Cvul076r3aIPilFmUgXorFZ4khfDMpoLfsD+VqCkoNdaJsC75aOHHpAR9hAe+nWtvO+hkC80MZ3OQAlV1q3nLGtLKpv3Mf6BSNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd8VwE1N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326de9344so2552580a91.2
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202159; x=1755806959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=xd8VwE1NkLUiuBNwXqCyRGX7pLfFBUhgeyEVN8uUJf/LiTTIzPvbqlqonTLSH8f3vd
         +csxUdnpcE5EdFy8Rn3jCWCHQQo148DunH8oXRWrk32jMlGiMrfHW7t3v8pQlK6ojEc9
         utb+hxuGs36VhgrnJ/WoTZAAyAazLsVIVKPCsK0C7zZi1oRlX4GnH+s9chHNfYd92sFH
         ZM2Z99Mh289qXcNI98TXx5RrFEgCC52BjGFyfd/jw2v9GtsFC46Z7RLiRhQM0A0+9qjx
         2K7zuWqDmZ1ls4h3vs20+mrb1uNOPeLO1kBVhHGel/Xl5ge1mjuFZhkrmAyYQ8zT1Hrz
         gonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202159; x=1755806959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=sMVCFQnmwer1qnQ+Ay5iYR80kdwMuijjHW9ED8zMwCjFw3jlZZOYxa2ENn+kFv1auw
         sSTaKgkpltnxoz5+0VUDORY1ZMkDv/jZCCenSEZV3pjOjq6KLDaypXBZqY5uWgwwTLOy
         dbCMzG5iP77lqpxXNVar1ICSCDdWK6UxGl6Jo70ndJb1SqP3TKaBrvrlOvLF0lYXxPC/
         ktufsEOKodbFohTJIDghuaoT0lSTuKd8VbDjNTXqAEkmNhe6j7Hj89K4al3qQcxWVski
         /P6ykDX0Fw4JH9LCHL/0iMdaSt8A3YB7K3+xenLJmY0NRe5ZO7BojBskQozId4Q3/jCP
         2x6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMYYGS3qvrauPegQY1RRTs5rnfZlBuIJLoQH+P+VgCpkM5NZ09d+5ZvnzwDvo0KLkLa3pUSoB4@vger.kernel.org
X-Gm-Message-State: AOJu0YyOH8Y3rXTeqiilANEoQJ3ei8YZqYl+Nw7Ntr7G9TTIm0h5L/B2
	8k1E6FFA72YlJVWxFdCybBhElC2536YCt1mFuAb31BzrFkRFSkg8h/FUyDfuVH30KdbrFDXx2Qh
	887vCGA==
X-Google-Smtp-Source: AGHT+IH+nzG+2OcnZiv+3/UMTbEq2fBzLGSyOMqRhyX99l+CDhgD+Ism6ZOY2XsIJISoEwSwcdBmJbzd56M=
X-Received: from pjj16.prod.google.com ([2002:a17:90b:5550:b0:320:e3e2:6877])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d82:b0:321:a1fc:a425
 with SMTP id 98e67ed59e1d1-32327a8b7c5mr6718040a91.26.1755202159430; Thu, 14
 Aug 2025 13:09:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:35 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-4-kuniyu@google.com>
Subject: [PATCH v4 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
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

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..724bd9ed6cd4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,9 +706,9 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
 
-out:
 	release_sock(sk);
-	if (newsk && mem_cgroup_sockets_enabled) {
+
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 		int amt = 0;
 
@@ -732,18 +732,17 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		release_sock(newsk);
 	}
+
 	if (req)
 		reqsk_put(req);
 
-	if (newsk)
-		inet_init_csk_locks(newsk);
-
+	inet_init_csk_locks(newsk);
 	return newsk;
+
 out_err:
-	newsk = NULL;
-	req = NULL;
+	release_sock(sk);
 	arg->err = error;
-	goto out;
+	return NULL;
 }
 EXPORT_SYMBOL(inet_csk_accept);
 
-- 
2.51.0.rc1.163.g2494970778-goog


