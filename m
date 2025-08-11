Return-Path: <cgroups+bounces-9079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACDB2133A
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105331A21CFA
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806A2D6E63;
	Mon, 11 Aug 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lplqMQ5U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C72D6E4C
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933500; cv=none; b=uuvBFP7HWen5fEVx+/v69gavW7s4L/pAC6K7/I/4t9jZb1bpY65lMdLFN6+5mqs9pcvk4PExP4ZYviKU2fQevqgWqYPF1FLXWzAXaysrA28zHFFUQT477etLx3jLgN9Cga58BcVne5fgazmZP9x9eVecdgY0dDsw3nV/Z72lQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933500; c=relaxed/simple;
	bh=X8eX2iq6i1SdpjO7hV/2ZT1qtsDqnu8t+51xQUHLbiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GviNlF5EMkdPCRwTRVkJ8SWVq/r2//RmCPDmjwMJa9X36u3gXAEC/bypEaiLfJ51Ytib5whogJLpRcmFQmcQwurFhUJy7QeawAJhnybz4dnwqnZfOkk70zw4FPq+wfQcXkXUtZfgkmfrJ0S7LWEEcktK7YXXd4VTrlR7/YrCkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lplqMQ5U; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24283069a1cso50152445ad.1
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933498; x=1755538298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfVGGcr+sVaGRRL1v88D9i+PBN94epKYHJgJ64bEQY=;
        b=lplqMQ5UotY3GK2ATLcK2immEDYW5fwyfcHVKQNgQ1ZidrmKfnnTw+xFZC4ExTMin9
         inQLuiEQTxJT6hj2pgkikB4Fm8cveyDibF8twF9A4WZ2AlO7gfJtmDjc2PskwXnlIFzY
         jQIHU9bo7WZEOaF54L/+W72Aiyu3YtDL4obuFu1fzmKRTNGaPAwlNUzUS+xrCf4MheFV
         fatG/wDhrAS/Hqf1XBv6lKUIfCmK+LmRG8dIyk2b5mLTf1jk1yfIvTZGw+p39kkUHpza
         RGUtVDyeHF+WNUOXIrrKRpu3ySpptfc3fH+I4zIvAijqsz6ngaxkqQBgR9VBfrFz7jxJ
         rb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933498; x=1755538298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfVGGcr+sVaGRRL1v88D9i+PBN94epKYHJgJ64bEQY=;
        b=adDPqVL2NTVgAxZrnbjr8JSJt5tYKpWUzKKt7jYGZg5A+ASxQfMxRGcs7XCLJxMC61
         UVwE9Fwx7HkPN1TeqzYz9lPyeuq/gUF/V3e9aXKXpxHT6F/3VFOcW7PSneyiLeqntXIX
         KFxZ2Vyt3sn3c46ps/LJdZgr18qHPRxhdKqvFw6GXZ566aABT01tZK3FPibkJj/kBCZ1
         vEXhE0Geu0OHolznQ3vj3GPw7Jkg4D2g0HQNy5rTPv9FomtSxlwXzp2VJR/fZN5GWOnN
         n9+O3TCu0lO7vmwga/3U/QDCDtGXHNkT4Egz+qiIxorlRHAEwnCG+UIcjjQhUcIFpYJ0
         lNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmk9nTmniAbPa0nRGwQMRn+QADgbcf5v0OqBEwt6Ww8lFLgG1veiGchNb9pv/mloPWIOsBkOOM@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+asWgSpatTxhhKp9uXoy1UUVbFuWUgLEGCItV6HDePzuDF32
	zLO1vIN/VEuRnY6PL2Jxf/DkMPwOQMmlOt14N/npW8c/esQe+YVu1/Cdi/zoeMpvVvT/w/jmpTa
	zV34V/w==
X-Google-Smtp-Source: AGHT+IG9Zlocy4eDqCS5oKFJ6Lh7wIqM9jd+N5Kyl95s+RAxxPEZ9AxG7sDpQwLNd7KdpVUzfZOq2F2IpGg=
X-Received: from plbmv15.prod.google.com ([2002:a17:903:b8f:b0:240:3c5f:99d8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0f:b0:240:9ff:d546
 with SMTP id d9443c01a7336-242c1ecb9c1mr190995095ad.6.1754933498485; Mon, 11
 Aug 2025 10:31:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:33 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
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

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa6982..000940ecf360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3263,15 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	struct mem_cgroup *memcg = NULL;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (memcg) {
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
@@ -3358,7 +3359,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg && charged)
+	if (charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


