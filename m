Return-Path: <cgroups+bounces-8798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB46B0CBED
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 22:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5907A8626
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACA23E358;
	Mon, 21 Jul 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+14S70Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B923D2AE
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130192; cv=none; b=Jc7s1npk3bAAOyuJOp8rvBAw44F5fb8PSLfA4pHc12SnIIK645icYiDxVc08yTMfS4wxdFpyifIiltmbeGwj9Vz2siQTFAozrOZULXETPyck8nq//kFMj0OgCtJe9wpXEc6ulzhhLP9z6wbVRrDexSKYWLMG+Otn8eAPMVPQKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130192; c=relaxed/simple;
	bh=lqqyywnLH34ueK612ieCcIgpjbH8J04q4qB8KlcMhUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWcSg3RnRE2y049A/PMQz4feulNyAxPB6bHWBWiotC8w5AELKEjUVdQESTwYmLdyoks3dufd2u4iKe1tGQDZpyV0OIgcne0yyOOtj9WjLsJTzP3FHO8H615VJSBHVdNKibjKWJOYfCXl9oN17+4JGG3ZTr6x9caYj4m8jZV/ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+14S70Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea7007866so4348911b3a.2
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130190; x=1753734990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=3+14S70Q9jsaXsxqvMDpjYpF6kYlJe7EfRnKBY9/TrskMmyPMepz3uX0oTgUHJcXvX
         QEG3ym5rhBhQzifFvdxqDIG6tuu19B8R15Gc/m/JfDvWpUrZiu20Mu2s1JyXQb7Flzs9
         yUdTTHJPRUJSd6ZAq00OwZWAFm7SrNiNrQs2qIfj0cBB5CVtIe3itI8qFTqCp4y9V/Xv
         4yI/n8dXilxSKIKTIrzv8iKbQDDuyUdkTpYqqrPNd/LCWqaha4nI2cC+1QT9LAgMcVj9
         tl1YT8mgkdloar+amjUAi9zdG3Rc3GW9QvB0MR/ktkAZurnLF4IDEmlwTwYSyfkQJvwH
         jaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130190; x=1753734990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=TnPcQAg8KwFsghstGV8SKINXXashNLu2CxHVe2xhY06vsWossAz6E1nkvN4KQ7JtkR
         /OeMGhxpGoH8B5ldjU2gGoZz9JjTre209A0d+mUGjtuxfNVRAE4LelTVB8o2tXe/f3vZ
         cumN+6IPxxdGqGkf1ioZxKEL3FS3zpv/xgsXzUYpEnMbhNNYqOu8AYKnAWOZKhXfhcCH
         wYzJKYXXlwSQ+1KQFsLe3XtSMdv3CRBxWqtEQ3CMcsD1jpBpy2FqVxXvLtdVmn5rBjei
         vcBupAt8TjySRoXSsqmBN1qpaAZp0v0eOUXjzhMtwww1s23pDLjlvzDjF/8//+g42uJh
         QNNg==
X-Forwarded-Encrypted: i=1; AJvYcCU6IpDzJPlY+DrRCwWvYKQI4VQerFUqA/ZKjlFHFXtR2Aq6z2NByo25UDblZ7CyWimU5+cHgncp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsn6t+yXFT251/j64HYEFmzinKKPPpOEVtVq068Hb6MEU5rZuy
	8+hMej8LsiPKamBnMobt6ADS268CC6y15+K4zgKX8M+r2yIrrqSJFvaL/J6EmU6aY0Sqpu4AoX+
	1DnrpoQ==
X-Google-Smtp-Source: AGHT+IGaUy/HgUE6Lp8HLDEGr2kbd1XL7Q/OQ0eUpQ2PrdZCIeYCL6Si0ZJ9Rped6b5KZL3DccuQO15A9BE=
X-Received: from pfbhd9.prod.google.com ([2002:a05:6a00:6589:b0:746:1a7b:a39a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a05:b0:742:aecc:c472
 with SMTP id d2e1a72fcca58-7572266ffdemr27218148b3a.2.1753130190133; Mon, 21
 Jul 2025 13:36:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:21 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ec245fd2778e..752e8277f2616 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -787,9 +787,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
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
2.50.0.727.gbf7dc18ff4-goog


