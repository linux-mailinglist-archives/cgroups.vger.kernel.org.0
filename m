Return-Path: <cgroups+bounces-9226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E7B2870E
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710FE1CE8BE0
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D724C242D69;
	Fri, 15 Aug 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyDu3t15"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478632BEFF6
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289061; cv=none; b=TjB3oqoBcjjK/yc9aMJf26p/lhrgGYMhXoBVFixZ4YicAf5BcEba8DeX8pfzok8df+ovxO2ZoI9NBn+3h5t2+dRpJ6A5tOa53/1LHbWS0vipMd1WV7NYFVccKQ8IWJnVlKRLWj37564fISztnvAtLi3NICXv+ZxhGzc1aNHNk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289061; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZnfD8MSSTyh8E7NiN0f9C2P0F+90odD7UAlD0iuPlZ/eTy6Xa8MpeYli5MbbWthbarlx8evbk1uG6NPEDB6zA1LiET9e4ExWRocyJrfWFstMvevJoUzmH9z4vRUJqjxop1Yjfe6HcENihZ/d5ikywXDIce4C6tFf+kjMutypXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyDu3t15; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eac5c63so1912455b3a.2
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289059; x=1755893859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=PyDu3t15uFAQIIqy9WpCRmyfQ68tRnFy1oGP3DDif28aTJfUD524mRMeJfY0z2rkri
         pyqYt+1mHY68ieuW9u7rR+dPEV0qPaM+YVx0AxrWUUzK/VLXRcy+emaR+inehBB0cT0W
         m2oidPtrMm06hrLKVv5J/GtW2+4bXGYgX72kUDc0gqrbt77cgc2yfV8/9MbPgzgfOWul
         79qAyNHZGwFRIxreUt3GyOfNjAwy3aY2s1+qe4DqLFkM80bDNcMUIIIrfuVGWSvLTG4T
         ylen60cMA+2Dxn1ylQg428NNuQjiWocaUprX8pTCACkBOrnUZsUpISJ1QxEP3I53qBRY
         im+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289059; x=1755893859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=ItQA8cClqRqFL25iWLr/1/VBEJeJ9IiNT2ZhLQ3y54ns2AYUVIgZ+2x2njdOszJflg
         8hoPunum+BnxlurzHu0BtVExke5grg70GDt4n6z27wm/kZ9P8HTDGd498/a1vKze1bc6
         S9Z7M+Tl5Z1wB+JxqDJUHEB0XJTwnHwUtr3/cN8HaYCwzxLq1xn2QJRBY3p8olkS4Weu
         807j/P5l3tuOwi5DJKHNuBqLKKQg5REF3euJzXlygjSliV9XwUqTpV63JmfgIfN9hL9Z
         K454WEJjG+T3rYkWmobq03Qkvi21bYl2LnS3bFN7R9yUy8jek51Bb+oCFaGHIElf/Y1M
         PRQA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ntQAEmztiZBEKTsB5KMA4x7ZgNYEj5DbMB6g5sSyAlQP63vbzelF8RsMck8y9QUpFwyqQb9E@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIOtcvZSE11SYZrFIHj+rhZqrrNrvMzO2kkGIIZ31Lbcp54Tn
	csfjmoPFtRheqxz0ND3TRA12aDmGEqfTLFiT8xQIBHtmyBO6+NA4T0KaJOK3oX43utduQ82rHd9
	yhBTvXw==
X-Google-Smtp-Source: AGHT+IGfFQhxVrC0MRMQ+CGQK5l5v2DySu8ZxAiDgHkcBvf9T0+txoiH03BQJJ5/iyzxBM/IkoVynChoTcY=
X-Received: from pgbdk2.prod.google.com ([2002:a05:6a02:c82:b0:b43:6adc:24d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a1:b0:240:1327:ab3e
 with SMTP id adf61e73a8af0-240e611783amr454188637.9.1755289058544; Fri, 15
 Aug 2025 13:17:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:11 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-4-kuniyu@google.com>
Subject: [PATCH v5 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
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


