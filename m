Return-Path: <cgroups+bounces-9076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D6B21335
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D51A21B82
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECD2D4809;
	Mon, 11 Aug 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piZaKFFB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE62D47E3
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933495; cv=none; b=DJbDCGnIJQHC1gTKqeLtVrG0uAZwLV5UQ58XiAOBnKOclrWXfhfyL8a8c1ONOGPT38Q9ywcmm10/wpR28rs4jMPg03p+oYHTVyoYamWVJ7XvisezYWhuGpKbTOwlkRdlLnqrDtt9xTLFicQo7n91nXOoXdzDYO3Uw82XSynntG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933495; c=relaxed/simple;
	bh=3O4wwZNIii75iBCsOBIERzFRse7hN1ZJ14qZD4q5cuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSX88GQ7Lk30BFlOaTt1EHzZ1Lgx14T0Rs7N4zHXdTTgDKluhKru54pIbYIPYwwM8fpTpAy7uePn50CWh32gBQzb0SiGfpDSeQf6ig7n2MZiDX95kOYp/GDJoxnHsK3lC7iMK+20I/ddLcg3t6lN9KDM9rj40LYM1HLp5eLkB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piZaKFFB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f3b65ce07so8116428a91.1
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933494; x=1755538294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUMgP2fCvnJmK1Iv88gPtdmkhT/9+UsLcGRktrUImI=;
        b=piZaKFFB/8UF+OnUdu1iX/7OEWxbwdyax62G/Plz6L0FpfuwERqyJeB8PoXOqq3+jJ
         tPzKSNNPkWQ4n6QExl1xjnkWbZYvAg5XVn9bzQah5HX1R3weRoXJd1i+CipZoyo8IgFQ
         w/8ENDdmJEpxBEcB7rh+Li1ShLO4tj4FTwyFejd4I636yBGzMw1+4ZCcC/3I0XElx7wN
         j4FnsFjeEsDyvfB14O2YAKs4aqPW5o1Ouz9Jj+hBeKbhlh8huZpjD8fHSWTmBlUtd3xu
         nlxqQavK2elV7pzjUBQe91SWS8R9PlUa4OGUvyqkv673GjaG2ExHZrtJ3DuSvk/OTsvQ
         /H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933494; x=1755538294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUMgP2fCvnJmK1Iv88gPtdmkhT/9+UsLcGRktrUImI=;
        b=JxXbhwt/u5yg3/Kehxiu+YmRXUl8cjtKMn7CkZgiEdcYS5zOIHcQ6k4GA1E+/V3sg/
         X68MIEH6b5JZ0bedRCgTcjr6SMcN3811vnl2MlT5KahS1ik30teKgt6HqkxliZ6jDKCX
         JKYWhGGdd3zBY3CcOK6xG2t/oIud7B7DEBp41yk4w2opWpNt98w+TItIK7PuAacvDMC+
         +sFnAypSQnsob98ixZGJoU4DOpUQQkwphIWtSpHoyzCEGhrHiQrlA0yV8B/vqP9DJDlc
         H4wXukAObt4zJZwU6mKBSiMqLxsd5tBw8LYNvbWPwvXb8j2qS1wF5OQkl9imhhT/ivXp
         YuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYZcvHU/oFC4qeqfOjhhWcNe3ORCNVrRjyUVPUlgnXMDjrcjAJszeemgU7SPYrbz81jc2U2x9@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHN3IdUY8pn0rmlUo0mNAxZTDfEkCS4ge9I3cGYZC1eruebA1
	LM74Y5o4jcKlExpin45rR2hqUy26TGg8dVoQYqhLq+HjdkuGQ79ljXQC4Cb1Wuyd/2tDQ4Qx3AS
	QCZHfDg==
X-Google-Smtp-Source: AGHT+IGLJHxtKJ3Pk5R4dgQvk7gs39J/mY7N5xl2jz8WX6Gc8LUYFyja4buobT+GhatPyGHT1yaWPuvm76w=
X-Received: from pjbsn13.prod.google.com ([2002:a17:90b:2e8d:b0:30a:31eb:ec8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2251:b0:31f:1a3e:fe31
 with SMTP id 98e67ed59e1d1-321c0a11aa9mr615779a91.11.1754933493761; Mon, 11
 Aug 2025 10:31:33 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:30 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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
2.51.0.rc0.155.g4a0f42376b-goog


