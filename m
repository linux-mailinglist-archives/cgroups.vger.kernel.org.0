Return-Path: <cgroups+bounces-9225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B82B2870D
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2685DB07990
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0E2C08A0;
	Fri, 15 Aug 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vzv8hfy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10082BE7BC
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289059; cv=none; b=QkYLzpdZH35z+B+MZjm5eU3Zc7qEoF9eh/zpLD+hVlooVZmaQ0kfK+fdjNywyoRCh+VMWvY8n/KILyRoaJVMwh+Z0HlWXQp5WhcQ4GUtnP6OsO/mn3VZBhyS826Ce6IJiYAoTrWzmfajOjd5fOODNvxJMGklhGX6mWz5uMELRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289059; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAP7clID2TTFIvR+6gnJt1qO+Mg2Nba3ZPBcuEjrUBlX8Fny1mEh3d7zhuZ04cW+X/fmj6X/+//xeco3dzDYCC4utdjxHVshX8CA5xIP0mK1VixOBxxgy8ChYy+nwGUUymu80xrja1xXFJR+JcQno7LeboB9HmSxmvtXveerem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vzv8hfy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e617422so1903902b3a.0
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289057; x=1755893857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=4vzv8hfyj6U/S5Ut/cNt1mnZcSnJFucxdlyaNcPlsHbp2xZlKco3aOKky6auRSVlMt
         Zn9DapLv5QhrnuqGroXyaxb14+6ejLNT2gTFZ/oT12XqHqSfY947SD/zJpm8WBhvULpH
         MeX5rneRQ+bIT1cLQ/Bvl/Q8n9yEnBj9X+xAWeKQuPYGNozGEWWNW3OH2W5/j9dWbbGU
         2bAJHJmrQJ6Ohi2ltp2hNP/28wmmB6EufMBJgIAmC+l+t7wcU+eaCOf7lqw+WOLKkuCH
         LZfOqHZ5yzyMstUfFxmjSc5JLCAWs9ouNtUmc6AU+OJvlYRDk9kQEeLWITzj5vRnGka4
         w4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289057; x=1755893857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=JG1vGMeNBT+6v7ROBRlpc23aKqfzI1kBumI55VdTahY5XsGtfRJ3QhNwRC2fqPRxTE
         SQuujdgocmfuG4R2T1Ye+czPGJfyDGt11VXUjizJC5mcsmJHZM+QuYlFa947w1dSlAI4
         L+uf0ZQRd8LhL6sNxKOWb7g5RuHpvF9NAS/4CSgLNkJzMurJBng9NdXynZeFNaIN93TQ
         DxZDNKnszPda6GCOj2L47UBsWYta3UZne8l+3j6Qmp9ZgwNy1bKRWEcSzQQkOmnO+dKx
         u6sXf0+1yK6mhZYR9y005OKh71ZYtOfmw7Uwg2mEWpdZtKMZD5n124EHTTenDXIlCtXo
         ie9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3NIWLy+CGxK1urCtowP6c1PwlpNe7EyCRCXEyAuFt14FLgDMitpnCUVaDxdkZaSDmdXdvfsx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/4L7S0WqPsQSzHgohZXS75AYp9r4CpRYZrfRGk/8hhcNgl3t
	UbfxKGjdGaoehBNeCMt+loUyfFTKAtnHnFsiTS0pdSnJySfoTf1rZ/o2Hb4JF5v9bvi44GHKHwY
	MpClQXw==
X-Google-Smtp-Source: AGHT+IEr+/ZjFkXy8umwdjDxM5J/aKMeoAE5dmVL5UloiD+KmJwNlOPL6BEq/ZXuKgz5B8/N8YhDKs6emow=
X-Received: from pfnv9.prod.google.com ([2002:aa7:8509:0:b0:76b:8c3c:6179])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1893:b0:76b:e805:30e4
 with SMTP id d2e1a72fcca58-76e44838e26mr5098018b3a.24.1755289056973; Fri, 15
 Aug 2025 13:17:36 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:10 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-3-kuniyu@google.com>
Subject: [PATCH v5 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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
2.51.0.rc1.163.g2494970778-goog


