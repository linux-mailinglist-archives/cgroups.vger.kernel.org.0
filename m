Return-Path: <cgroups+bounces-9174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C911B26FF7
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D35A232C
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C306256C6F;
	Thu, 14 Aug 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOoGuS6P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F99252917
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202161; cv=none; b=Qr7RIpR0Yd3Y5r2y6NrPVit212c0jISPDxRgG/qWuhnaKXYIk/rhaTE2DnzU83pluPW1ys/pB885zc0mFiTVJyD13Rm++z4bDSBLWmdzO0Qz4f4Y+6V1EXJ8PrMV/jGgHD1X8ltV92uFAbZxABn5/gMdArYGk/FDyCRoJbciK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202161; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3eUym5978Q7ByrrsfpMzCXDtFzDN1kiM76aF/mVDDkcyq2PBaJ+hnd3fg6eSenbBZt0+6nsZyqo05tdyNADP9WK8hBJsOVlo2W32WXdSaOlb33rIi/PBmbrdc3aWykIjq8bXzix0in4dT+tKwrPtLBwvh2ldXRiSZC5XoVnUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOoGuS6P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326de9344so2552535a91.2
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202158; x=1755806958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=QOoGuS6PLrLVYEOtlKI5T8eNQHyAcMh4cBChobGXzGzXqcMo42bibIH/zHtjNpWm0/
         NLd2AEf40k8u9dXeSXewYnszWSnRJeSr21q7ltZ83imxyyTHfMaKC8RKsN7773MstMR2
         9wDF+ayEtVzrn+CQwuCfzcJxjBOUgqDhzBIVynAvkUmAgRjoxfQwvgoyyZP79jyJGVee
         Diy/O9W72+HxlcIBaMY5RILlKNXLScdY5JG0kTYsTjCEctRdITEV552N3YzVwxap3bJq
         kjJQSIScTCa8jkxGbTRcKiosLIuP219FEMheWVpWDYXGQc+uWGhraH4W03OKkl/T2VlT
         3Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202158; x=1755806958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=mE/vnvBg9H713I2SYPb0+CtAH7eYqRwgRxxCj6DWk+XlFeuF3geWdB7iF1TxrBDaF4
         m1F6avlJplmCD24d+VyzAhKEQyLIRrS7HuVPXDzuR9tokBznP4i8NhYk1BcaahmgNJYJ
         XPnWNpkDWm7NaQodmm88P53jI+rsr8UmtUWnQBCetOZkNdYyrPTgoS53ppqhtOBf8Z+g
         GZA8oBuXqDRv2PCd4sshQyepcLNkaca3FBYPWytssL2M4r1vgGPDquj9ebstS1+QkN0V
         YtwutIyVa5yky93zdOBsj6+eTqFzjNDrneWFC09eZf0622fTVH24/rl4a95CGpENnZog
         fHQw==
X-Forwarded-Encrypted: i=1; AJvYcCWc26ydwQgiswTe+dKsO1nmuJV4ppBMFZr5hwinYUF0s5LmYZ4cnH57X+Xz0KEFlXX6+5s7UY/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11tZaUAksl/zsSMroyjwgInkOKL/YhXB3r5jjphYKYhTvlpXf
	05lqYtJ9S8li6Jcy6fjxd8ElVGLugnDyZT2hzhcTnjXAvDHOLpyLLZP3oCcOQCwfNlg7SjDOtlb
	BoFhy1g==
X-Google-Smtp-Source: AGHT+IHJqj8OCBO957elyCb7Tb9EvqaiAKT/a7fghGIK2eeAw95lJXxXFobtfukkiYu1/mXizBdvqnwNOyA=
X-Received: from pjbqb16.prod.google.com ([2002:a17:90b:2810:b0:321:c300:9aac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0e:b0:31f:16ee:5dcc
 with SMTP id 98e67ed59e1d1-323279cec2fmr7690481a91.14.1755202157953; Thu, 14
 Aug 2025 13:09:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:34 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-3-kuniyu@google.com>
Subject: [PATCH v4 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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


