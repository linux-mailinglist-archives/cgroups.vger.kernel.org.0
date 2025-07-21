Return-Path: <cgroups+bounces-8801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73EB0CBF4
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981EB546A1E
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FF241666;
	Mon, 21 Jul 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwcpDCEt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53323C39A
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130196; cv=none; b=JtRWYp/KSziaWOrNqoPkaR6Ui6fQ/Ae8hMIrFmUUaRFnYbZ+mXM9uF7Sb05Tlt4mH9Sx0a227/L6KByW4XEjFMlYwPUEMnQ9nBXSXur5NBFMNZwmxxpXEqaHnHCVtKIHR1+6zKjm4g6Qikdc022zhxo4I981IzGKxWs57da8GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130196; c=relaxed/simple;
	bh=x6W9fSLS0sdD6u16GfcO5OEeoEdgWbD5AwJHjH26y4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIqq/EN4TTl/yZ8pKceDRZ+d6yMNJgcsdxH8tyPmGp/9I5d5R7WWjRK8s4kFtFfpfqESKEnSDiP12hes5ESB5P1x8cCwM/TDh5BnPZf7hs5E9FWrOWN4bCQPx4CjqdMKXTHZnfd/dMq9M5aXNHMDaLOU/GM50q213XpX/dK5HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwcpDCEt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-756a4884dfcso4489846b3a.3
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130195; x=1753734995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=hwcpDCEtClqZWlpuM5v0so8CaBaMj/tWZTtFturxpJR7wnSjez0ijBKatjsTeTxdAQ
         saY5JxVUGRcFAAkieCO6Jvhr5VvD3BobcgjOlpFnBc3DGnn7iuzKSlK0GkLLTa5G+rZf
         r2FEMeSDnUC/IDenc8o221Lvq8YztMA6/rwMVyDEN4a5g2Pt3cI2et7FwA65uwUpqPzj
         RmBGeRznJzjbp0hhAoKeMJ++S56Kt/yyZqF+5oWI3ajpuDpOUcPWmjS1lU3kx3oA0CkZ
         yXz9+KB/PCspQ3lmE3du6bUIhuXL6Oszhrp4h7M/alUGMnClEjA1bHrazxPF1s8qsuiQ
         BCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130195; x=1753734995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=a5ISC+Y+vUTzh4/NjX6jD1TgfU15UTBgTXbt4KkMkqtICwTp9aolqKn1gga2nFtVsd
         shpwW3fUvSXjP4tVV3DOCi3fagHLN3pul04et6A0AzqXDNWZoeObrCUKqhPDeUrudvtU
         6kzoUzEZ8fXM8NEi0WYjMf3mJzfuKjcg3VL9vC7IYpJnB5xvYw2AWkn9b4JdtdcHvSMt
         3mpp1qt2dKCpcNiX5UU0gSS0EDyiEzdKcOmfNxNe+Sfa/frWj5Xjhfvu5NY9zipmBIin
         /BtTpHffTF4dIGz5M3uVI6gVJ4BvqzajC55byRErUU+mCSP26e1NPp/998R4A7+OSQP+
         BFDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1mZlsGw4uii2S4+QY1ZZXDOCLIJK0uyDDnfJKE3uTAsuiKq3e0RvtFK4INpx8hRt1EukB1ZoN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+lFpmFAhf1ephHopAs3+Qi0oQSKVOxCYxrjSRuPozsgzC0IO
	kyK9b/Oj8vhCu807s23RzyVXavSrp4KSJjPjC6knHoTnsxGNHTAv48eUV97E1EPvuKLenhI5oJG
	SUpVKvw==
X-Google-Smtp-Source: AGHT+IFv6U7uHL2iBa9yupFYshgEXju3eOkU6QMVmKj+fMe7znAZlxzbdQTya4Ql3pAJYEeoSFGsqqqmF3U=
X-Received: from pfay32.prod.google.com ([2002:a05:6a00:1820:b0:74b:54a2:ff33])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f86:b0:730:75b1:7219
 with SMTP id d2e1a72fcca58-7572466bee2mr28714696b3a.12.1753130194603; Mon, 21
 Jul 2025 13:36:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:24 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
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

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa69829..000940ecf360e 100644
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
2.50.0.727.gbf7dc18ff4-goog


