Return-Path: <cgroups+bounces-9074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF1B2132F
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 19:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668ED6267C9
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351D72C21CB;
	Mon, 11 Aug 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlA7p8hv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0117E4
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933492; cv=none; b=JY8UR6fAQGEzYu4nQgW2J4JmjoOIj404sy0FIjpziO8kAZa4ELQ8Q4+MyEtTAx2CPwwyG4gMysMiKlWDmTpssUfHn+zzPMOJ07tv5PfDcwz7D77p2E+fARNq/fYSt7Bf67+KMGu6aJgPfqZtRcW1lGgroVGVAzV0va5rbJmaor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933492; c=relaxed/simple;
	bh=wjBddw33igPbjaGFSG/M03kBeoib+ICuiTs+4RgVDNw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nihucfcje0sgdISZfRf53qnO+Ff0gNTmeH6nYZ6yXUHM6Kc5ZdgO8CfR0bypxY/cGzAXFYipJR4ZhilkchDQFI3vDJhXN70D/oUgAKCZI+E6H6gXZbiUj4pTxPqRL+rikNHXsVMHW5QwkmZb9H1oEeT1ZYdtPDepP/BanGQHmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlA7p8hv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be4422a36so4358188b3a.0
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933491; x=1755538291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTb4ZYMYPpk1ACseddHrcz3FiaeJvW+qXE8HO8bxlXA=;
        b=BlA7p8hviXxzFIfEpJFBiuLfS+sQvOeTnUKyGaR3aEX3RmkSISzMJgV8XRA8Z1It+A
         L7uCROg8cGOGPoC92ZtZiow6HOSXHqOqqGgX03imhd8dsbWVIU6D2j7Gdz/MdWqnz1Tb
         hVT4bIUX0jXISMo4yI6DlN25Dqr022QBAHGsb9xWC3MrsMVkL1mBZxm9kWujosuxUHbK
         eV5gYv2oJwTO273RRt2PEFLO/NBY4hbAYkjSuxRMjVMoXRNhXjTLiJOOGcXcXE/MV7vj
         jZdTjVqLSdmtPBrSMvcnKaPEN9avCzuPk0iq3obZMu6Nhgsv5tl8wNZzuUqjLtFOOxa2
         h6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933491; x=1755538291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTb4ZYMYPpk1ACseddHrcz3FiaeJvW+qXE8HO8bxlXA=;
        b=GNSIXwuezXq9/Fe2wV6Cy2A58O+YvGY3vF/WG9wHZLIRKCrT6oMPUEplARca+ntjVj
         K084OlrOBccCS30nOnErPHpM3gizlG8f4zeJK4nV5mg8sSPdNAjN+ptqaz6vQsYAMjEV
         vKdGhnSVspiWSZB7mF2usNBh8YjAo20RaZCe2IgaxajaNWzp3upn93xkGIF8jojXqJcW
         yq7IgtyX43OMbZov2NrDBTZJe4iIEBQQzXEMzK5XFmLD+p/zMg8dqF3bYDS2L+2dZt5p
         uanpamcS5oybUdxpsrN00YJac12WtyJLY2yfq22f2u3flzSu3rWkIihpxIhblvibGobG
         pMTA==
X-Forwarded-Encrypted: i=1; AJvYcCV4pD11uhko+ImmarOcTQSxWA3NLlV5oblqY+V5D6LLWaE7bjmh8tTAOdPEW0ZZG9hU1911cItQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpbKEgEFqHm9Q5HoQSIEzdmTuJEgTahg0j98k2rg/VazULcw/
	zwPIgwBw3dXYtlaagj6EUjUUw768oSXIivMXMCDEB4FwBeVnyodvEtXGn3bI5uFALkXNrYui/k3
	VLajKow==
X-Google-Smtp-Source: AGHT+IGKr6oqVCjBFIQc4hDZq54MhrQz3SYGcbPyQOfRTd5efyFcfkryP7IWXH22Nn+DBiaaLRdr8LG3oKg=
X-Received: from pfll28.prod.google.com ([2002:a05:6a00:159c:b0:740:5196:b63a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:401f:b0:238:351a:f960
 with SMTP id adf61e73a8af0-2409a4ab650mr442290637.23.1754933490717; Mon, 11
 Aug 2025 10:31:30 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:28 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/12] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
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

Some protocols (e.g., TCP, UDP) have their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

Sockets of such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

If all workloads were guaranteed to be controlled under memcg, the issue
can be worked around by setting tcp_mem[0~2] to UINT_MAX.

However, this assumption does not always hold, and processes that belong
to the root cgroup or opt out of memcg can consume memory up to the global
limit, which is problematic.

This series decouples memcg from the global memory accounting if its
memory.max is not "max".  This simplifies the memcg configuration while
keeping the global limits within a reasonable range, which is only 10% of
the physical memory by default.

Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG
  patch 11 stores a flag in the lowest bit of sk->sk_memcg
  patch 12 decouples memcg from sk_prot->memory_allocated based on the flag


Changes:
  v2:
    * Remove per-memcg knob
    * Patch 11
      * Set flag on sk_memcg based on memory.max
    * Patch 12
      * Add sk_should_enter_memory_pressure() and cover
        tcp_enter_memory_pressure() calls
      * Update examples in changelog

  v1: https://lore.kernel.org/netdev/20250721203624.3807041-1-kuniyu@google.com/


Kuniyuki Iwashima (12):
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
  net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
  net-memcg: Decouple controlled memcg from global protocol memory
    accounting.

 include/linux/memcontrol.h      | 45 +++++++++-------
 include/net/proto_memory.h      | 15 ++++--
 include/net/sock.h              | 67 +++++++++++++++++++++++
 include/net/tcp.h               | 10 ++--
 mm/memcontrol.c                 | 48 +++++++++++++----
 net/core/sock.c                 | 94 +++++++++++++++++++++------------
 net/ipv4/inet_connection_sock.c | 35 +++++++-----
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 13 +++--
 net/mptcp/protocol.c            |  4 +-
 net/mptcp/protocol.h            |  4 +-
 net/mptcp/subflow.c             | 11 ++--
 net/tls/tls_device.c            |  3 +-
 13 files changed, 253 insertions(+), 99 deletions(-)

-- 
2.51.0.rc0.155.g4a0f42376b-goog


