Return-Path: <cgroups+bounces-9227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93304B28710
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7134B201A3
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44D2BF011;
	Fri, 15 Aug 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWqoSfKx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9652C0F71
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289062; cv=none; b=E4qLFvCAkVNtVWJVFf2oVfUs1mib2NNoh06r8hBPCdHohyNd7cmhDdfo6TtE8Jc29DCGfjd7MkLLzSY94Np7ng0Elahrjuvdr0gip2IGJifU2wB9YyL1DIx5WkAJguwQAtWW+OUn3kWd/w1cKtCak042oYS9Q1V02rKMtiaKamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289062; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMP0duxveQ03oLQopUE3/pzGrc/CnwZCi1a9Lru/gmMR5MJnPF6JqnU+0ULzn19KqcffG0nk6HbxtmLdHbbKw9aUEk6WLwpkfCZ9C/BoLEHvux+i2kz9Dv9lpZnEdloHh5V3TqX8PS9ZwELpucDqql/jhr9iQ6DJpOsUF+K7lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWqoSfKx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581c62faso22635805ad.2
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289060; x=1755893860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=hWqoSfKxWI9cKS26GMuwbD4k4nLUzAPP/TurqnrxDJv2ylqTueJjJVhF3+gf8QheHT
         HuGuHusaCW1ajNqvYfJXd7gcV4IQhCFucVOhDSS5i3ktcThSH0NszV7RGXvYFxV86I6U
         8DcPJsYTJbJBGOzEH0miHuWkSpg8gbnM7X3pPX1qQyBCMHsfHRMx0pMESaK8goUN0eGW
         meCd4Dj1kw+eHtJYB1lXVJPGzZU9PIO4PQowA8F8yb8Gf+1xNdVpyXzh+68JTEBiua/6
         N1CNRY2k/z66PwW+SAwGCiC7r9/nyY9cZ1EKw28raWvri2edqvQdLjt1semZ0wZQtzgu
         wkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289060; x=1755893860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=FLQ4lCQzMR8i/i3854/fbbDSRC1P2AlVyN0I17v86ibTUVrE3wOHxkRFyMi6GVFtK5
         oQvrjzxY7pb6/IhbM8ZjFCUqmtkyg9jOqTr15WT8ChIdNL5/G7U7BccJh3w+/pybK7nV
         CzD7iHC9cwpb1ta3yOBU5WL/MrmoYal1qASgy9uVBnCbODbgBXzIdHyJpSeQ+TisfiBP
         M64zfHh5ljK6cXORA+NHzwo19vG/iR4PQ3oUOqHq6xd4M9bl9oaGWjET5/9njfbHX2TB
         iJSWIqi73X2XGUP1hFg6yxjjmWcaBml4XIVYIXQ+Ir8pl5aeUdjGDskgetK5/j7aPGsv
         jS3w==
X-Forwarded-Encrypted: i=1; AJvYcCXY0hYLDdif9Q53afhBYYUmCGSqiMehSSQm/2dF73NK+NrYNIR7qXD5PKhrst7/rwt0kN629DdY@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1iGlUnQguTKP2SomOkdULVQUuskpPluFrdEs6Tkl2ZqSB5z4
	6+AZiJpTXMkmQabcJtOsVkxeA0KSqGRCfg1SDB6Q5grORRGejrVo7ey3FElutnP0gCir51mLoYW
	yPmM26Q==
X-Google-Smtp-Source: AGHT+IG+NKmG4fQxWApznT/iNlBlE89VZOBkEiuZXVixRsMQFotYGpJhNutY1IkiTXx8XPjH7buaFadPEzU=
X-Received: from plgo12.prod.google.com ([2002:a17:902:d4cc:b0:23f:f3c5:dfc9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:23f:b112:2eaa
 with SMTP id d9443c01a7336-2446d8fe30fmr49723005ad.41.1755289060168; Fri, 15
 Aug 2025 13:17:40 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:12 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-5-kuniyu@google.com>
Subject: [PATCH v5 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
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


