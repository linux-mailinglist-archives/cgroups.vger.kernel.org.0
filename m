Return-Path: <cgroups+bounces-9172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0ACB26FF3
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FEA7AF253
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4A24A066;
	Thu, 14 Aug 2025 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEF6FVjQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79B244694
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202157; cv=none; b=Vr5gD8VTc1jcRYx/73J81lLIFwwP9y/5nxJWEKMuKFgsSWMYiLanBffcllNmv+gR0AmhydKYkHBNNh3cs5Bk615FN3zSZVQ8ta2yYD8sT3e10WyB25GOfC4ORWOif143+6Cjkn/OyZxYM9l54Olm2Vgzix/qTvwFQKgi5vQx6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202157; c=relaxed/simple;
	bh=XRFloEn6WUdoHP1BiKO+9NyjAYqAlyAeTcjtp3BnPEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cbxKnLBWnfF7FCTXP/kZT+eq05UmtbH6Q3FbZaPWWmFcckaiK5s3tJbhmVy2h2FEZpktfSYxDMGoV9qdhhf/ODzRdauQajgTSqJCevhJQJpPtwQyhiSeQ51Md0PsmDrtjN2XQAAAER/z+XSZYv6/bDlR9+tPqlKmDvWtyVGSP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEF6FVjQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bd712cso1288254a91.2
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202155; x=1755806955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPx3oS3D/U5/Z6SJp4+G98+eGPb8Zkxs9lelPKWCUiM=;
        b=BEF6FVjQ5q3g8Hpy6Q1fRXr09C9QWVgrtsxNqz8z1Oxt5DYyS5MwrcFzoFzwW4IGSL
         bJOySiAyGUx1bugTib8pP5/yO0YHdjCivJUwXyIy8QWbAaBxoHmFWVKtLxCfCK7nxgNR
         e8Ozkp7io4/oYz3bxr9Ou1wEq3Joxq6fgVakSqzTvDbF8q6+StttXV2xiJyPP7MEcQOw
         xpEehmIlvt0Y2tY8CuQWVr2wVndbPUWEZRcIbu/06oU9ygEL1/toP471aiK3YLi6j9fs
         gWBvHahfEmdlIlJr2ye44eSuMSA3Gf1YnxpmtHYTscw1QzLHafgrlL5EpXtlc9dLsLit
         pYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202155; x=1755806955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPx3oS3D/U5/Z6SJp4+G98+eGPb8Zkxs9lelPKWCUiM=;
        b=Ju5384TKwmg4f4hmsB4maJUQ2ijFd0hxI2eL04Zh+Ul6yUd37yBAhn29PEHohZjjTf
         0AbNNR4C5XSeHXr7qFzmY+S+RaYyRwJeK1M1yKQZ8X55VZx63wH5UUs5ttAzC9qOHPbA
         4wmb22ytz/OzrIBmccyfjgFWbk3t5MKCS57LA3GRzekggkL9yP1IuDdhL6dNYBqgyebN
         m0Nr4ccwKNDIEJp2puEjXVcxQDnFN8AJC8VpZAmzSEq5jg/vhuQ+NxJmmg9AmALVSRHy
         yg28F7BcBsS5uA2miDEDzVcKbesCTxBt5r0qqhNST3ySzk+rG0RvOXmXB4AcNSGy4bDN
         J5YA==
X-Forwarded-Encrypted: i=1; AJvYcCXN4lsHTubtXJzIJz4t+D6OF9J4ZOQKkfecF8GIRiOt2OCWWU1e9BG0nwgYj1uBtEy6+NP02mEs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KZEDDUwabYPTsuYPG/nTYYdh/YQLCeVaDT3nbgJbbbGR+FyJ
	t7IXfNGVyzAxyp3aiHhkelVNO+yJ/UebT5v+jWjs2onoa5cH1mUBJeMnut/oD+WswGKmWB+BtIN
	uqJPO9Q==
X-Google-Smtp-Source: AGHT+IHoeO4kZujSsChFOwaTNJ8uA4UdHGwa9a1sAiH+eAKhd1r6y1himci0q94O8Kz1fkx16/6OM5R2r0A=
X-Received: from pjbsy14.prod.google.com ([2002:a17:90b:2d0e:b0:31e:c1fb:dbb2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c2:b0:31f:6d6b:b453
 with SMTP id 98e67ed59e1d1-3232b7b76damr5551630a91.30.1755202154816; Thu, 14
 Aug 2025 13:09:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:32 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-1-kuniyu@google.com>
Subject: [PATCH v4 net-next 00/10] net-memcg: Gather memcg code under CONFIG_MEMCG.
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

This series converts most sk->sk_memcg access to helper functions
under CONFIG_MEMCG and finally defines sk_memcg under CONFIG_MEMCG.

This is v4 of the series linked below but without core changes
that decoupled memcg and global socket memory accounting.

I will defer the changes to a follow-up series that will use BPF
to store a flag in sk->sk_memcg.


Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG


Changes:
  v4:
    * Patch 1
      * Use set_active_memcg()

  v3: https://lore.kernel.org/netdev/20250812175848.512446-1-kuniyu@google.com/
    * Patch 12
      * Fix build failrue for kTLS (include <net/proto_memory.h>)

  v2: https://lore.kernel.org/netdev/20250811173116.2829786-1-kuniyu@google.com/
    * Remove per-memcg knob
    * Patch 11
      * Set flag on sk_memcg based on memory.max
    * Patch 12
      * Add sk_should_enter_memory_pressure() and cover
        tcp_enter_memory_pressure() calls
      * Update examples in changelog

  v1: https://lore.kernel.org/netdev/20250721203624.3807041-1-kuniyu@google.com/


Kuniyuki Iwashima (10):
  mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
  mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
  tcp: Simplify error path in inet_csk_accept().
  net: Call trace_sock_exceed_buf_limit() for memcg failure with
    SK_MEM_RECV.
  net: Clean up __sk_mem_raise_allocated().
  net-memcg: Introduce mem_cgroup_from_sk().
  net-memcg: Introduce mem_cgroup_sk_enabled().
  net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
  net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
  net: Define sk_memcg under CONFIG_MEMCG.

 include/linux/memcontrol.h      | 39 ++++++++++++++--------------
 include/net/proto_memory.h      |  4 +--
 include/net/sock.h              | 46 +++++++++++++++++++++++++++++++++
 include/net/tcp.h               |  4 +--
 mm/memcontrol.c                 | 29 ++++++++++++++-------
 net/core/sock.c                 | 38 ++++++++++++++-------------
 net/ipv4/inet_connection_sock.c | 19 +++++++-------
 net/ipv4/tcp_output.c           |  5 ++--
 net/mptcp/protocol.h            |  4 +--
 net/mptcp/subflow.c             | 11 +++-----
 10 files changed, 124 insertions(+), 75 deletions(-)

-- 
2.51.0.rc1.163.g2494970778-goog


