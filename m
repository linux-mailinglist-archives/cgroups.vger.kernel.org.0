Return-Path: <cgroups+bounces-9228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42FB28711
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AB31CE8930
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E622C21E0;
	Fri, 15 Aug 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr3c8rUc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD32C15A8
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289063; cv=none; b=PjHfl50kOHJwUOkkpFX2uHMiONjeqe/AktU5o24RZE3mZ4uO8NFzkhYBrqkSTwnttIZdGZsMmNpOdwgq3k5ina3OWmC68mfqHVvT/1etAo6GV8TuQ+ytiy/QVJm0CxdvHDZSIbL0oMzTT+is4DI2uuupBYlb8ciPjWrrp9q0nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289063; c=relaxed/simple;
	bh=49AUVqRZ9QX0gApoGVu2lLYolROcKxAhbfDoW1MZFwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZmUVMgHqKDGbKqBddAbD9+VebRykdcBOS8k4N/yfikeG3erCXGDJiKdUlKgyozjmjtr80p+nitmG/MKurHq8iUXQmqfUFt/kvZTMOALz9LdpeNrPwcenaqOktzRhKPONmRRhUBUEkdfjSe4gAqSdcp6n0kU2DPaqV82+P0pF6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pr3c8rUc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f440f0so23022615ad.0
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289062; x=1755893862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=pr3c8rUcGg+Hq6woWmanoF3q210lZjxPHAldFrev9h8tgqH1aaMxulOVs+EOrm5o8v
         F4NfhOZ0y7fgLJiAwpcZOMYqeOjX2hTCc4o/Zvon2firEBkpo5G0eROP1OlNvzN3urE9
         w1CtZJfKl64jCKDrKHel9OZoobVmp7am6F6rBOCqF0nhMxTfYOxrf/n9Jcj+1pGn3mpo
         zChFYPozozix3TWO7XCRpwqf33S7thGD8zEAH1dMR/t8pB7rMDN4ZcAMb97A/khOwLgl
         eLwWonY3tRxIf1+UXoeZzKlGSS2aW6j6exnxLVTXlrJtKX8fKwVfvNwyapmw3xlHCZD3
         V45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289062; x=1755893862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=NXJyX4nkTHdajnM5hGHupL/y3XbGuGuctkG1cBVXkq/2KVa8Eaw8ra8NIGgRrYvqs+
         UTU0cv4ZREwGNX8di35jMmi13EDtS2/ctM9tFEubNnfsgNXY7LJ0f8BD8tJ20KDDLfm3
         L8//zRcZegAH71rFbR4If6K58LKTsZF0xs/RQEGiZN8ZHxQHDV+rs7I/m2ImeNB8CZE0
         h1BBQrjz2TXCU2ZVhhu+twOzzMMFs6Q7bdkkq5zUkAcaDQqW4hF+cPhK3El/qE7hR4C8
         9/f9CEzZqQdDyQY5ABpEd5xB8HcXRy7k0duzIeLZu5KirPJZIGOtIBYJNKSQKD6nM7Cl
         07WA==
X-Forwarded-Encrypted: i=1; AJvYcCV9XPOVTc0ZnNb62jhyhtYlW8tyeXdCSPzdAyNEyJVH2mbOe/YToVvmnMfpfRSIKa2/JHOLyfaP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmcjq7q5rnmXZn/n8oRhcDKrIkjtX0m8XA/dDjvqiKdxJ5MhqR
	rKRvijQmjjXt2whuFE1vXa2lrGK8jrOZeDKF9cNoGN9zpR4bKSYBhHfvC9TKsExSeYJiKn3MB5v
	YJXkRAg==
X-Google-Smtp-Source: AGHT+IGYcQH7/mF6y+bCQF+wvj8byumWi1k0Tu655xRzdfVqKzsBybbZLpijTnLaQewu7vlc+0MtmLwfX5c=
X-Received: from plbmn15.prod.google.com ([2002:a17:903:a4f:b0:243:5a:ee2a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:240:3239:21c7
 with SMTP id d9443c01a7336-2446d89d237mr56657975ad.37.1755289061594; Fri, 15
 Aug 2025 13:17:41 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:13 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-6-kuniyu@google.com>
Subject: [PATCH v5 net-next 05/10] net: Clean up __sk_mem_raise_allocated().
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
2.51.0.rc1.163.g2494970778-goog


