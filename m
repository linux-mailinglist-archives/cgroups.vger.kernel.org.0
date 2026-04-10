Return-Path: <cgroups+bounces-15210-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNerChRn2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15210-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:09:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FB3DCBF5
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938E33034E26
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979013A7F75;
	Fri, 10 Apr 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSDCZNJ2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB339F192
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855268; cv=none; b=AfUCbp0vlj3B4KoE6DBeIgu5eR9gnlPVf/CO5WGQjVuXGWa/UgREGxUn9qc8xKrNB09x820LDwAfehfrG96wB2yu0cXhqPdiQYeWCZUgwVvxQkoU8VXueF0fQy+UK6nyAV/SRXB5aYq7Jt4ZHS38qwzDfiNLor143HT7AANkHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855268; c=relaxed/simple;
	bh=1f/+Wg65Wzydtq/ARwlhRUIsAN+OxUJYfdFnUPasWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ionhncDIFO/95CDcTCZQj1EFjTyJeXNJhvc8JDqUxZtIBLbGao0+auoWc4ckh20LpMUoQU6Vv5Ff4FJzUM4/WLHnjhRbc/S3MMijVs3/MA8x14cLQUH53Ob6v4bPRB2e4e02QXynp3nZQfRJ5JfpUg3Ygkb8PMeJMH/wbJTRr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSDCZNJ2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1285015a34.1
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855265; x=1776460065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMjyo1BeE8Sjl3rJFGc/7waGNwkRpFV9y7vNe0a0k/I=;
        b=PSDCZNJ2OUPBOYMCX5rD2CXKwEHDZG9PuNlz32PV1lny6GGhrdvz0Y8pfPNI5Mio5q
         IvgLmWeM7zZX1bhlqej6ykZOFlAkowhkgPjXY5sVaG87ZMhNc69SpRlu669Ee8eaicLn
         vBlqxdQRseprprqPTVWOnLb23nCidsXIluNgtiuILpbCrh/FEvX04o/FVqIizLP5KXcX
         STI5TA3rHPYJYuv/4HU5vXgcK7WW0zBIjW7GzEdlNFUJtsiuF2sHjTsec/jucHQOlaZz
         iZkQqfM4NeawGFHSW7taJhHILTzTMHcTJzjIb9k5a4dO9crtUPFgyXvAmDAV3vX6N/Jk
         1DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855265; x=1776460065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMjyo1BeE8Sjl3rJFGc/7waGNwkRpFV9y7vNe0a0k/I=;
        b=Invu6/m5BP9hy1xd2owxEMjahHUKdquX7IpI23l8koKQUFyW/P04guNv2T9LjpxTgJ
         0E5RWkflk8bWx7f6P2p74GclOUjCO5FOsPqWofd+9o/Z9qxIePCfM/P9BDIcgNk0oBdv
         4AdKBvdACRmkujh5yhd8eHle2eAYSsXez28A8k0m1M2XJqE0qC6X/zcEP0l/TJA/zdT1
         1TAnOIoS3HqginS0SSet55/H42G3yW2WH9ACUtKiImWkmj6CKDXMkqQVvbsD3rAL7CxB
         2PUHoGkRs44gl5Ah09K6MzF1T5lRc8FasOVh+thqEK4E8KVYMLuwB9m/TX7GhqhRhRvd
         BIiw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdIiIZiPBHVJc4SD2+0qt4bFoQHNmops6QEs9eNcHGn5NeqSCdE4VQCTIRU7csOhZa7+R69e5@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVXwSq9G8O9FVmbl9rVG1jgKUUesOG9TvLBcpkDLKWvCcOo/4
	O8NKtWujZPf0aB4hLCTnc1MGIF3xBk4E8mAa61N+3Pyyu1DBmqeCBfb2t/VIbA==
X-Gm-Gg: AeBDieuOp1x0zFRvVGyhFRx5NcNKF2bLAqQ+6S4Ncmk2dNMzJNie0TyV9QENSjCi1sJ
	He5mBLFrm88/zpybxhk5pdCjXxUErjtUsoMOY3sgy3VULLY97yekWDKsBXF+77mggnRlt2906NI
	ASVPOpHgYvlCHwtfDGVlUtZXEZNHkwYM1+7iwt9c1PK3fYPaTHy5CJYuFDdL0m1tCV+Dr9ey8pS
	cg79ZGv99FftOP7qlGy1XNaI0uyTu3glznB6JyalXqpXDgA88+ReEY7wh62IHUZi3hIyzsS8rNn
	kd1aICDYld9+Ud7OHWwOKAfzVOPGnDho7qNvB5tO7WlC6XwdQbPDw8sKP2egn3rlG3YbFHWZ6gg
	pxJ+v+OvTdObvYOTBWWWcV92sI26RtvhfsjixlMpwL2/s/qhk8a1t/GgPmnuuEaPmgtFvDEtM7Q
	afhiSnVBa+5jhofddznLTyCw==
X-Received: by 2002:a05:6830:6b06:b0:7d7:4fc7:21a with SMTP id 46e09a7af769-7dc27ceee0cmr3297522a34.13.1775855265063;
        Fri, 10 Apr 2026 14:07:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2660ef75sm2708244a34.10.2026.04.10.14.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:44 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/8 RFC] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri, 10 Apr 2026 14:06:54 -0700
Message-ID: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15210-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC9FB3DCBF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
allocations, allowing small allocations and frees to avoid walking the
expensive mem_cgroup hierarchy traversal on each charge. This design
introduces a fastpath to charge/uncharge, but has several limitations:

1. Each CPU can track up to 7 (NR_MEMCG_STOCK) mem_cgroups. When more
   than 7 mem_cgroups are actively charging on a single CPU, a random
   victim is evicted, and its associated stock is drained, which
   triggers unnecessary hierarchy walks.

   Note that previously there used to be a 1-1 mapping between CPU and
   memcg stock; it was bumped up to 7 in f735eebe55f8f ("multi-memcg
   percpu charge cache") because it was observed that stock would
   frequently get flushed and refilled.

2. Stock management is tightly coupled to struct mem_cgroup, which
   makes it difficult to add a new page_counter to struct mem_cgroup
   and do its own stock management, since each operation has to be
   duplicated.

3. Each stock slot requires a css reference, as well as a traversal
   overhead on every stock operation to check which cpu-memcg we are
   trying to consume stock for.

This series moves the per-cpu stock down into the page_counter, which
consolidates stock limit checking and page_counter limit checking into
page_counter_try_charge. This eliminates the 7-memcg-per-cpu slot
limit, the random evictions (drain & refill), slot traversal, and
css refcounting.

In addition, it makes independent stock management scalable for future
users. As a demonstration, this series also introduces independent
stock management for the cgroup v1 memsw page_counter, which curbs
the likelihood of the worst-case scenario (traversing both the
memsw and memory page_counter hierarchies).

One change that should be noted is that draining is simplified to use
work_on_cpu() for synchronous remote CPU drain. This eliminates the
need for backpointers and embedded work_structs in the per-cpu stock
struct, which minimizes memory overhead. This change over the existing
async drain scheduling was done since the drain operation is much
more rare now, only happening under memory pressure and on cgroup
death (as opposed to the previous arbitrary scenario where more than
7 memcgs are charging to a CPU).

Performance testing across single-cgroup, as well as 4-cgroup (under the
7 memcg limit) and 32-cgroup scenarios on a 40CPU, 50G memory system
shows negligible performance differences. In the tests, I repeatedly
fault and release anonymous pages using madvise(MADV_DONTNEED) to
stress the charge/uncharge path, across 30 trials of 50 iterations.
Metric here is time it took across each iteration (ms).

+----------+--------+-------+--------+-----------+
| #cgroups | before | after | stddev | delta (%) |
+----------+--------+-------+--------+-----------+
|        1 |    446 |   441 |  5.097 |    -1.195 |
|        4 |   1832 |  1822 | 11.897 |    -0.582 |
|       32 |  14730 | 14739 | 54.089 |     0.061 |
+----------+--------+-------+--------+-----------+

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Joshua Hahn (8):
  mm/page_counter: introduce per-page_counter stock
  mm/page_counter: use page_counter_stock in page_counter_try_charge
  mm/page_counter: use page_counter_stock in page_counter_uncharge
  mm/page_counter: introduce stock drain APIs
  mm/memcontrol: convert memcg to use page_counter_stock
  mm/memcontrol: optimize memsw stock for cgroup v1
  mm/memcontrol: optimize stock usage for cgroup v2
  mm/memcontrol: remove unused memcg_stock code

 include/linux/page_counter.h |  15 ++
 mm/memcontrol.c              | 269 ++++++-----------------------------
 mm/page_counter.c            | 173 +++++++++++++++++++++-
 3 files changed, 224 insertions(+), 233 deletions(-)

-- 
2.52.0


