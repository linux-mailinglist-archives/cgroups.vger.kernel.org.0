Return-Path: <cgroups+bounces-9097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3EB2310C
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235E97A8B23
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DC2FF14D;
	Tue, 12 Aug 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpZc98Qq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E92FE586
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021540; cv=none; b=LNCF2NZhOv5sTeX50+0ouxfXnuSwH58BiXP0YK4sMrj0b/VT8Zsieo4uV9GhfjNM3KeDGEX8oibTqiQXpP4Lyx36U6qTrSZ/Fd8+Hu4PXpzNtFXPyosaaQL61avlyEIxyIrkaFvkSfjfL5Wim0ixFGjI8gAin0jNBr03qXi2V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021540; c=relaxed/simple;
	bh=gUdtY93TVXd8U7THwQpainuRObH4njplELc5maxDEW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBXAcj2k+bVI+jVMxnEmHDzOPQy7hWaWMmLygmzPUkBBSFVPm5chYcrSUSlxD4rnN5SXpWUlM9D+bdijtr1vyAEwVfgIi+DaMAQqXZ8vC/2NO0KWHuyBdlPggWD8c25eoUBdaqqAbcpnQQcg6fwE4sgvRv1aD/05bahYbbykww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpZc98Qq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42bcfe9c89so8137191a12.1
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021538; x=1755626338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=IpZc98QqWiAJSbc2AyHFttQybGnmwYxAJ8c816Ja0ZCwTnBDoOElHfyHHw/zhlRgxi
         RAioMPhPXhhZxYucIItdqtiVtYzKD4oZatX9QnGKoWdzg0pm7/Qj+KyH3aGdAF0Jo2wY
         zWab/BFoxzvMtWL1L+NewL1AW57IvHqH2NS30b++jQs6S1kTcH56xTbmgj6jFVJzkq5U
         F4AuInZFOswXPlqGJeMDDjiXOR4zLrE0RBNWhahTQ63TEjSsRaahePTkH07nm2+5SZdS
         tCXeO6bAZt5INoZGvnpN2YG3l0nL7Nv/rmQ8nws2nojYRLt5gBvL89X9+9j9FvUUA0+I
         e62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021538; x=1755626338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=PZHWI8VFNnWkQC8nVHFYdYjaTCeiTTrB4w+Rfz2iouGv1KZO6svEUBOjgZQvhjJH1p
         tMdFTgCayNdnwRW8DyNYkwxv9f64kD3BYrqXkL5IhGdv2kLWohuFnIapZMcLBbFIFHCe
         sn8EIGrvBNO/ukDw7wYXYypWlqDoHsJ3+qS1lTFqV7G7LFY2FVtzzC9d1tWi4Qr3zw99
         +jvBlv+g7DTuWDMpIYLXlV1g0xOYmHVaXfqoXA17jOto1XUG2oaOUJlJ5C1P+/nXo6m0
         0gkM5VTYN9AfcbLLQfDjO6nEwKSbzGxTzXuYaGirfZBD9hTq6HPf4QjewE2cer5HOIrN
         mQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsqSKyzDWnMFvLm+sBzHqlzXcAf8yzxoyJ8Dzo+iQd35ypH9aAp02yOhtxs0NsVbOUtqQ4HhRp@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOMYN6DUVVW6MXhFzOsqhbnly1x7avvikqv/oqYuc4SQv9nf0
	JdQPojYkuUvqe2eLGEwWcU9yNPWw6ml6lLl5XywReOXPAqm9UhSsykM6Tk4hkMwjEDpUI1VSQpr
	LCtfUBw==
X-Google-Smtp-Source: AGHT+IFYsGjbaobi8vNz9wbDh44fnvU9qpjmhcBJj3ep2W5xNnuwjJPdvlexzH+8pKUpV2yp3JlpFVyM3a8=
X-Received: from pfblu20.prod.google.com ([2002:a05:6a00:7494:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9985:b0:23d:d612:3dfa
 with SMTP id adf61e73a8af0-240a8bc1fe5mr267608637.40.1755021538144; Tue, 12
 Aug 2025 10:58:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:20 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b15d7fab5c4b..a1787a1344ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -788,9 +788,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
 	 * as it can always coalesce them
 	 */
 	return (data_avail >= sk->sk_rcvlowat) ||
-	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
-	       READ_ONCE(tcp_memory_pressure);
+		tcp_under_memory_pressure(sk);
 }
 
 int mptcp_set_rcvlowat(struct sock *sk, int val);
-- 
2.51.0.rc0.205.g4a044479a3-goog


