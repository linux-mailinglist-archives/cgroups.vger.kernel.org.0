Return-Path: <cgroups+bounces-9223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8DB28707
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9765E7D09
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF262BDC3F;
	Fri, 15 Aug 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17PIjwuE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782C29A309
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289056; cv=none; b=gX3nowZMKky1sWIs6NEkYTb8Ml8QgNcMQEh8eZT3Ju1EFrsQgW4Zac8nvaMlwuFD78Rv0k6V/ix1molLC15mHxwy8xfVbvRs4b2eyA0Brc/XTDztk58Bq/xhcI1G32886oIHkjrNjzBUar7kiLtG4O66iP1zg0T0zCScFPQSV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289056; c=relaxed/simple;
	bh=llcTD+zSiOG3Kd78oaB5lSAH9fReOnOetwZy90bEHOM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QmPiyJaAh++cATx0Ll2avNvyTEtauvEEwJQ386mXQkGduT0MFPMJE8rgfvUQuz9+jAlZrsw2oSg0jg3tSmtL3cW/XSoSQNCycebXVoDnevzsUI4rHkmziXjelnsLrnIlSGKGsFBBOG2R0GZrNhtMhYXnFCmgEpJgxDWYNlxjZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17PIjwuE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471757d82fso1619479a12.3
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289054; x=1755893854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2PRNy71eyK2aZPpC5gSBBIxfuZRCi4H6U9oHXzC7IIg=;
        b=17PIjwuE0whnVHDA/YeoVH86eDY5ulRYxbHUup/1a15O0Reu7txxRnesXOTup4cxIg
         B4csSeTzJoQQkh3pITrtqUKw8kplhT5Yg+6JRHOxXIoX1ATMSQOf2N2Ru02IYNiV1OA6
         /lvttfGLYvLR7UTzoz0mqXa6loZlCvnjMvrVBzNI7CIJGIgRUtvNx+GljtjlwKoB8RSo
         cAbFZiG5vMdLLb3Gt9FcY2nuEXIflU5BOVqycw0P+8fu8NRAKbEOhC99NbsdorjgQk5b
         CvOag03IyEjpe27+Zs82Us8vnvMjNNW+RzVCj0TvYCU+2ySa13ndlZjeWvxLVYrX+Vzt
         Rvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289054; x=1755893854;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PRNy71eyK2aZPpC5gSBBIxfuZRCi4H6U9oHXzC7IIg=;
        b=QFDiC1jKjGqjmZlpNc+pW4K85hU0NJKeq786L0kY4YUgf25J5gWXkVSpJnvQebNNDM
         Eft4ho0n1j3s6iQplNTN3c0ORH1jpe3jFqBaOeN/k5kgF5WtLhk9k9N0K28YfQ2QzuVs
         qMSYZy+bTIIIeonyVi/ID349DOlc3BmXPFq4Noe7sqAfdFkWgu12NzyqYX2ql31lrrbi
         QQb+Uv04jBRnLR07rOBp3a08sDJUbVJ/ogtXHs/s68whBDkv9BAxwlTStEQJ1UHkwUhv
         mJhkgxgq1j4R/19DsNp3hPE4f0QIRR0hRzo3gmS4FHMGYX9zF/ZsKyWDHHPES1H78gFY
         hr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2yHso7elpkqGWAFb1WJkcfQgWChE87uUpu2EDkEjQDT+EKoBeBg9GJv1ZuaYttdZyDOQ2JLzK@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlV3iWy0wn4Lu4TkPJWwfBsw9UfOj4a+Zq89YCup6PDM49f0/
	pgDUaqv5JVPXBrJ5pLrU9gPsIiaLxf7P6Ho52oojRsJmmp8mqdugN1FsRdDwW27SIYUvUfCRLGc
	VbMYUaA==
X-Google-Smtp-Source: AGHT+IHmaMP4DwtVSKqH4dVqDx4zRe8jIMCHyyumzBMZfK2MDVM9bvEJ6Kw/6qH1LxunWf0RV1NxlfpDR00=
X-Received: from pgww10.prod.google.com ([2002:a05:6a02:2c8a:b0:b42:2672:b159])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a27:b0:240:5f9:6359
 with SMTP id adf61e73a8af0-240d2f1add1mr5795559637.34.1755289053981; Fri, 15
 Aug 2025 13:17:33 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:08 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-1-kuniyu@google.com>
Subject: [PATCH v5 net-next 00/10] net-memcg: Gather memcg code under CONFIG_MEMCG.
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

This is v5 of the series linked below but without core changes
that decoupled memcg and global socket memory accounting.

I will defer the changes to a follow-up series that will use BPF
to store a flag in sk->sk_memcg.


Overview of the series:

  patch 1 is a trivial fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG


Changes:
  v5:
    * Patch 1
      * Don't use set_active_memcg() and restore
        mem_cgroup_sk_inherit()

  v4: https://lore.kernel.org/netdev/20250814200912.1040628-1-kuniyu@google.com/
    * Drop patch 11 & 12
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

 include/linux/memcontrol.h      | 45 ++++++++++++++++++--------------
 include/net/proto_memory.h      |  4 +--
 include/net/sock.h              | 46 +++++++++++++++++++++++++++++++++
 include/net/tcp.h               |  4 +--
 mm/memcontrol.c                 | 40 +++++++++++++++++++++-------
 net/core/sock.c                 | 38 ++++++++++++++-------------
 net/ipv4/inet_connection_sock.c | 19 +++++++-------
 net/ipv4/tcp_output.c           |  5 ++--
 net/mptcp/protocol.h            |  4 +--
 net/mptcp/subflow.c             | 11 +++-----
 10 files changed, 142 insertions(+), 74 deletions(-)

-- 
2.51.0.rc1.163.g2494970778-goog


