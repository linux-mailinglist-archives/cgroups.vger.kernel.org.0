Return-Path: <cgroups+bounces-8806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128BB0CC02
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ACC4E2C00
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69724397A;
	Mon, 21 Jul 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjjvvfSa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC185242D79
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130204; cv=none; b=a9SsJVhWoZRhEM0sWww3MmS7psKAegPoTV1KFDBqhzW9kAbBcTjmg7IgV2WmptGaE018KGWuH42JaN+QUYNKOFPMOhOy7jG/oN1XixKFD6UpXWjqOGZQFvYOu1sEJ0+qIhR74rzMXWdBv1QPYdzDYrFWU/2NVaxU/xebWXTwc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130204; c=relaxed/simple;
	bh=i5GAzC5L1kuCCltZ38C9FzfkiUrjLYUlG5NNBN2V574=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q6bPFNG2xt/9L1Z1MpeU4i4nidZzB2SFnTpvCAHf4kyjea82IHQRftLdgCLlCE3fWSgZf00mtS7kAVqggvI6DsA4dIoFRUe/XESkVV3q+p2xukm/MHxMD1XsIhvu9zkDre+UGsB5MDhW0zae89onNjia/XSLKiJ5trkrL/0tINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bjjvvfSa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36951518so5326844a12.2
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130202; x=1753735002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=bjjvvfSatUqpb9wFl+n3o5/Jy9tp5CPAir/lSp6e+cozjksV6PJIgfu6udmzLWWwQ9
         P3TaOWcIuO1hSzwDmgslXkJgGBpREaLGWlf5RdbgMK3xTLQEoxJonusNA1iQqeciqxRp
         MOBWMwKPj4QN9AI1z/Zq2CldJCL9ge+/RYt1fEhA1AZB22YSbMYRpwYY3c9mJCj5KyZt
         7tX/8o0KD+H895LMPwko5HtG5r/PXMH+TrqU5fcXsPYgf9nTH9tjWNnpOKZntFbIzdgf
         wsbacbBrOljw3GEj/CQc5WDJOCrYU3a20618JowSrU0/SFtEeHyn8n7jr+QJWwBurJXi
         ukiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130202; x=1753735002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=SxMHMlNa/D1Fcy22fquBgo4KL8yfRhrC9aCYT8hO6kufmUQ59jY5PWLbFui6LNPwAC
         fDN4fIST+1/4HYpgzY8fdiwHG7JR9dBavq4oxDNRBxvfHk9Y8jVkmVEDg5Toq/TpMXLx
         r7n9uQE2zi2xpIPJ34rAFNklrTrXTTP5pwOJKdPTkZ8XX1/1z93stqR861UUjXsDDiEg
         uKF+aS+ZXVfdeF1QviV7w+2+8ACwhoieT9xd1kNbGRRX7TFCrChb8BybzKN9ihM/Wwvl
         4KBZyzqmT0FxZlrrQNi0Fnpk7aKKQLhjMe1L+Nct9gV8IQVQyMf7aIpemGOISPvLRj4i
         y5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXxbeMKWqlC/p46RGl7jlZrpoNrqy9e53FsUUDmkPBziue+FjjFIszMZNDkV81dmSkvYI6xIBou@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0F02kgr53+8rH97BjFc/svdewZf2zTf5EiSThevTNbQ8LhpI9
	8BS265E5QgxyrALg2+905PrIrDgPLOXZrvbe/dJ/3dgbwGNEECvCqyijHE45EMHA4WSoFPNQxsR
	v9nokIQ==
X-Google-Smtp-Source: AGHT+IH0bPuHNRYQE3IBCaVT7B1b82DZOEQMUavwyW5ZrY7G02YZ/hUnE3IIWK5LKSPidRIy8Lw1sZSx8D4=
X-Received: from pfblj15.prod.google.com ([2002:a05:6a00:71cf:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:233:f0c6:a8a4
 with SMTP id adf61e73a8af0-2390dc51bc4mr34981014637.31.1753130201882; Mon, 21
 Jul 2025 13:36:41 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:29 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index efb2f659236d4..16fe0e5afc587 100644
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
index 5537ca2638588..ab6953d295dfa 100644
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
2.50.0.727.gbf7dc18ff4-goog


