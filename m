Return-Path: <cgroups+bounces-8800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A7B0CBF2
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA24544CE4
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEE2405E1;
	Mon, 21 Jul 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o01Xcz1n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516623ED63
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130195; cv=none; b=ZTrLHqedLqIu2gh00uySYLwyjx1+81C2+xSpNFKFDepMcoyyaq71sKyIZZWlpMKZ+mZW6gwu08fLCHdt5h2R42w82SdTKOphNnH/GLYUjX4UtpAXjIexYp0q4SXz/GqgW7pRvfIUaX1k7Kg4brgtVkSXKp7pakuGMv0SoeM/UPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130195; c=relaxed/simple;
	bh=7GYx0gT7yKuvyKvrpKME7Js52yeuvXmMr+g6Ow0vwcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkeurCp5RtJ63vrFsu8VMk6KxMH6cklRB0vjKM7JHAruz5uO9377uo/4FFNEIMfjw5zXzycrRCu7Y3nI9u1fHBetYrBTt5Ch/QlwDwNaHKcBYHbWqn2SUqEDsPuKnkDJUMf3fi5lu6Zhwzek1cxPMkt4kWxRx5YGbMawis1+DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o01Xcz1n; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756bb07b029so4242516b3a.1
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130193; x=1753734993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYUyNgMVCCaofoOHBPPUoPupTfXzfLB6/aiuX2w18Mw=;
        b=o01Xcz1nNQg9iB89fRXOZM8r/BvuWSd3TZK6CYW0cpYnk6fQhqjvcytLLMpheM0AXu
         mpvyIZHOb8HVDdrRP7NZS/IhGzM73lV3ToGRjfGh/9co12sjVi/3L01MyiK4WADXXzCp
         bE7ly+/16PWumRUicWuOLIDjCnkuXi99Lz/s7VPmdCMEDIl2mbODFJFmbvl47EA/uDVL
         Mg9YZThhcMdbQRO+iVa4v5PZh2VvdL8BgstR3OTtbgj9Sauq86juPfXFqV+kw7EOzTIU
         Wy4q4yt7TmN5qQog+nSgLUyWmyOJ0RYe+JruxrnhxpZ/OT2N6k7d6JqR09dZmtxtPZgU
         stYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130193; x=1753734993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYUyNgMVCCaofoOHBPPUoPupTfXzfLB6/aiuX2w18Mw=;
        b=R1mRyM0caH5bGl+r0pLrYIPLLvf0LZnxrN/rBkRNpmrGR+Lw1r98ouYio8KkcZTZdz
         VM7NQMokfUC567AigmrV3I0HK0q8CGxwvqkYXGFwHdXSzGwHmkXcvWE1zn9NhWv6FESe
         PryzYHfrQ7Z8mh3qxscqOxFozlXBLFYKKYxGA2Cc8xiT9T2hkuQmzfspi1XD/MeSt4oB
         zyK39ezM81BB4K5OocjiirFMJshefcLnrmut2VWVdcB1FnJKO734eNdUOnO2eP7kjVa9
         Grj+EbIkmcR6XrG8Ak2uJ3BumTBm0Y6DJpH3s6AR3nMwFwynE4R118smX9+eFHM4ObMz
         U6/g==
X-Forwarded-Encrypted: i=1; AJvYcCX46aIH9TAvVCOnbiSetHWvzbiERbvhr8m5FcXaH8OWcLa8jqUG1kWMdm9l9sxNCuITAlRb1xAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZ4wlkjrSvzYjxgwC7vbnvqQUXKmAgQeEF18jF7zBDfwm4luM
	4FyteU3S0O1sju5D0V5fYtF8SSiCFu7aLto4LlCRcKrLjs3INST2AhdA6q/TMayk0/uQ0yp0cKG
	IbP1Iig==
X-Google-Smtp-Source: AGHT+IGmJf5+70mstVkzYNSRFS4u46asIcv4vmF3QPlJsewm8h4FN3p0mxWoexnQlkXY7f0461xV86Ew6Co=
X-Received: from pgll188.prod.google.com ([2002:a63:25c5:0:b0:b2c:35e1:f278])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62c1:b0:216:1476:f5c
 with SMTP id adf61e73a8af0-23812b50d6cmr36295824637.25.1753130193273; Mon, 21
 Jul 2025 13:36:33 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:23 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/13] net: Call trace_sock_exceed_buf_limit() for
 memcg failure with SK_MEM_RECV.
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

Initially, trace_sock_exceed_buf_limit() was invoked when
__sk_mem_raise_allocated() failed due to the memcg limit or the
global limit.

However, commit d6f19938eb031 ("net: expose sk wmem in
sock_exceed_buf_limit tracepoint") somehow suppressed the event
only when memcg failed to charge for SK_MEM_RECV, although the
memcg failure for SK_MEM_SEND still triggers the event.

Let's restore the event for SK_MEM_RECV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce630..380bc1aa69829 100644
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
2.50.0.727.gbf7dc18ff4-goog


