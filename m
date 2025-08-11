Return-Path: <cgroups+bounces-9078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E383BB21338
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D2362354A
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485A2D6E4B;
	Mon, 11 Aug 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je3WKUAL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FA2D4819
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933498; cv=none; b=m7W8/27mrsKvGf3cgn1uUWydTx+tzMPcNhopXQElNCmsAPQuAVttLXaXMCs3yoCYinrLeV38lP411QF+OyLsN/rwGKIVJgvOGDcYLg6Obyk9waarRZE47itpyZ6XNx65HfjnzO5fePEb0CQzkT71B6C5D6sLCTPua7o+z083ddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933498; c=relaxed/simple;
	bh=0sASMMf3hdYMOoWJgOc7ZaOQV4MEaeOmZCKjZhVqGRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K82KMsZsWCrYpON1GQ11sV7mYyLGrlbtdQqFBSwnLqjB8KWnflnTqjGw3/qoWufE1OE6iBh0Tjp+djNi1qUAkBj7vzWTAqgZC8a/QtAFvi/5wgEhcdKV/gwyqDuKc6HfhpS2XfHvJ64oei2zTSazp6ZThkgWeCDIKHeaRb+wFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=je3WKUAL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2424aaa9840so49785005ad.1
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933497; x=1755538297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=je3WKUALSp5ZZNqNlbH+/BbO2Qy2YOveCQdPEOqQYZvNcoRvnC7LnLA53T3hJpK28E
         G8DbUdtnDwUgQjMNL1zfQBZYjhgDI5ywM1ZMEB2RvAvB6IeHMnjEVrbphUXRJjCRLJoj
         2WLbcJ1OEGdqnnyhL3v8bsP/kMyNsy/ZCJN/5zB2PfnGj3X4ZO6bE3YxtX86S91ltxFW
         tiiPOLaXsKPIa3m2rZlANMnKh/W9/YnC3tDIUVFgBCY6vFpMQBPZrHYhvo+wepW68rIK
         IzzUHL+ASzeTRSrKVBV3KeJVsC11Id3htEHM1jc8vjRCrXazX0D5yaTb7CN4iJW9/kVD
         TJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933497; x=1755538297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=VdpQ2KAJUyrvvCtswyduycs//K6Ag1Ldm3PZNctcHDeMqYow0A2pUgyHv6My7LqvR0
         uvf5yN10LRjgt7NZ4E43gUeviyivvDnoWsZ8O+HT3ELc6ecisj9JWM/eluwgdPzcSeOb
         txbNKxiDK3FhFslFnuW3aogyOb2Ug5Im1priBrUouAL5WexBQ6MBj5CTZWwSkT6f347B
         1G2E5UShAnbpOiLxcBWw//AFmdahNyZ9frUIzP47Ebd6FDtmYgPEpc1hCJz2u7feHEih
         CO9Ik7PLYmAP4JcTeMCaZc7KRC6gtIPMPPZitZIZ6y5n+/W14PsVW9zvmQ2tG3iXmUow
         2EnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtZUOuxhfNeaSAfhFhbPgXF7go/1sBp7hlGn4IfbuPBQrzK2CZCwf7hQCUwiWuuDURTWmp87wv@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpDpfGHuJiCvfiq4vzMTun92hXaVTh30GHNsi5vlBBzVO/Bkb
	e6Ltl1uDQUHiMsfcQf7jGnVPE0/euUXmqATt7rUJJv+3ZU5O1QauMmcKCkrBvL0MHrvRNM7TOGQ
	7GoTdfA==
X-Google-Smtp-Source: AGHT+IFCL/e8m3EpZsorqhDOQWgbVKsvSbTHCyrTvZCPhbJX57+yQJEYtdDdTVRR3b+15GDZLagPnHJ4FnA=
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:321:abeb:1d8a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a23:b0:23f:c945:6081
 with SMTP id d9443c01a7336-242fc31aeefmr6642605ad.31.1754933496988; Mon, 11
 Aug 2025 10:31:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:32 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for
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
2.51.0.rc0.155.g4a0f42376b-goog


