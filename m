Return-Path: <cgroups+bounces-9175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96DEB26FFA
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99D37AEF47
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D72571B3;
	Thu, 14 Aug 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KOOMnwD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BEB2494FF
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202163; cv=none; b=eKRpJ+TmyhdEAJwWBbENw8Hotyv52JcozG58oTb3C4uHYdoKrrfqDmzkHekheJ7xcNbgQcJi7Ko+fYcO2Q+BAuSqYuwKw7rFDKvA3HN8GF11b3/80EsAgXtpW86verJm5RdV51cSd2YKHEZvlzCdF+pxL/VR/5Ut6X7vkrS6pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202163; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j02SPKlUacsyAwD+4YajjDr2lIw8CzTMwh9ltFL+6rPGQCnJv72OOwPGZJqjp6M09MSacW/r1bUSO0OfMpoE1XhKd9ZeDGhci33hClhsz45otSG+MJHEBzQObkGop5utQwjRCHzpsHgXWfsIBZ6+P/quQrHaLgaRYTRnl2ih40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KOOMnwD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445820337cso13305215ad.3
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202161; x=1755806961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=1KOOMnwD9qf3JJMbtLeSsgmlpqKiUvgcHdZbWPxcWFr1VfLgP3Yy0STR3b4hOpmw1k
         L7Q7kk+Z/JQDlz6zit7ZbRHw3dDsky70nnmTIXacB82s+5hk7ov1PMMCvfALUAcBYRk5
         Pgrp2Fjh53O6BsYYG7PdhwhJ3O8sa4LMy5c4tshnyrirh7ZOlbduqM21tzLcn4XHCSCa
         21URosIhOcNNk6zcz8ZGHi9zTUn3K8AjzpgjqNh3AEuhUgGDY6/THuYaAC5teBe0qrUT
         QiU++FmjvmGvbPryNHOBKSJW/10WWPIsUM7X5MjRnnpK2XTEqbtFLr+yK3tf16NVTkME
         o1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202161; x=1755806961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=d5EwEneYB9JV4hjK/LUPBb7SlO9qyvYBs4uEihLu0FZNtpCkMQuy8+nwj24f+i+ddt
         /+2IbXAxHRy/ZxfpZcZ9SXE+9+2jSwCPXZJucrcgCMfEJAhmWv9VUakyJN+IBORBD85q
         Z9++sNrZUIhir+qkQ0IkxNvA9MpPdksD0jsRqhppdZtUHEJ0hTifgaMXn7FQXAee4ER2
         wDq4vjNUJkuPqSaCsVxboL15+D2I0g1x8wGv8qldVqKApdqVEwC5V+mVfrwJ29y79Dee
         E3W4/vcCf2taKmcnKJkc8i007sWvqeNcbTTkWyruN3F3gZ4SdKoPDs2LqNfgRMNuNeCj
         hhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7G1cfKBeAPpWJvwTQ2BPjEnmspZAj9Zzt46hyrAATRWxes43MLgTQXQYwMLkeo3eKOxvllfW6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SA2EqhFZFtGPRuQXzmrb4CNqyneHcM8WtfvdNSzldb78Weej
	3yiiTYNOtt6ozWM5ULBaKGbmUW8hnkBrqS2TUTYaOgR5F8Avn54AzoYISvibE4OfgEZeQm3FPBg
	8HDSECw==
X-Google-Smtp-Source: AGHT+IFZG58mv+xFex5I3IvbaYDViC565d/Zaj2y0+6TxgO46lJTn88mwWlXmxsJcHxyM0rDApPblLTIl7c=
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:321:370d:cae5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:240:92cc:8fcf
 with SMTP id d9443c01a7336-24458b58443mr83319395ad.49.1755202160983; Thu, 14
 Aug 2025 13:09:20 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:36 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-5-kuniyu@google.com>
Subject: [PATCH v4 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
 memcg failure with SK_MEM_RECV.
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

Initially, trace_sock_exceed_buf_limit() was invoked when
__sk_mem_raise_allocated() failed due to the memcg limit or the
global limit.

However, commit d6f19938eb031 ("net: expose sk wmem in
sock_exceed_buf_limit tracepoint") somehow suppressed the event
only when memcg failed to charge for SK_MEM_RECV, although the
memcg failure for SK_MEM_SEND still triggers the event.

Let's restore the event for SK_MEM_RECV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce63..380bc1aa6982 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3354,8 +3354,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		}
 	}
 
-	if (kind == SK_MEM_SEND || (kind == SK_MEM_RECV && charged))
-		trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
+	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
 	sk_memory_allocated_sub(sk, amt);
 
-- 
2.51.0.rc1.163.g2494970778-goog


