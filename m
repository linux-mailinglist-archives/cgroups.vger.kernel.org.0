Return-Path: <cgroups+bounces-16252-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHifDmCdFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16252-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6B5CDE58
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A0430027A7
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178737F019;
	Mon, 25 May 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjCYtrwY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EC3750B2
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735899; cv=none; b=PIM9kdG+iqr7mNdoO+WWuT5U3GJg55pEKSWrb8WIErlMhrA8o07YKcSZ1Vz77qWeU2wCn2QGP6mdqbi741gntndI62qED5zdFlT12cW7n6oxo6m71qfHtE+6jokqnWpRgCLTjnZvNU+cEg/AtQQj8jEgm9G7X9YYhrDVP9uL4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735899; c=relaxed/simple;
	bh=l5R1YGJHMK2ztHlqCD/O23AFreNTdT9N0zjySpshk+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu373prkDqPXSWIpmPFf/HGMRjkv1CL62lKdn+EumckNkXdF+fIKIIEjEUB7ipcU5IoQklAtwFguDWxEZ6VvIWPYljgV79QUXorSc5TMqlKUhZQTIpIV6qSzD2za6nyT0xKmwYO9c+1HZubML6UAVneXvtNpbK/rGt4jwIRscZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjCYtrwY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcdd1b492eso9902073a34.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735897; x=1780340697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiSNZGlI52E7JWBNAgrZcZTSVxRjmA7Low1cc7dass=;
        b=ZjCYtrwYQxoxEJPMADr+CNEU/kpi9OAEhuQ2w5oVFQF4dzYeQgSRkNmkR6WzIIbd2+
         Xng+OoOS1YjG995k6WGKem6/kg+QPC94+NsWqFv+YaRankgRYM6aYAU4kqtFwEZOEguP
         ylVLI5catZp2NWxdJjPs3lorZplfXKKQzczo4c7jt+hY4+YJ/N1QwSmYmeS3oyVso8di
         CWIWVa2ZzRy+l963eYGfPf+QPyFB0hCIN+cHkkYnP2ri5Pmlb/ZFDl5o2PW7ePJI2Hs1
         acnZvszxvJPTrXqX04cmvxI7Ud5JFbEs1JARDKsqRW2dMrLoczpmKVyWDF0rc0vHyolu
         WY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735897; x=1780340697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsiSNZGlI52E7JWBNAgrZcZTSVxRjmA7Low1cc7dass=;
        b=M0RmIlA7bYG5kcNzAI1gJNo4u7L9ER6IpSkXBWCB15Jl4JPYPb5fy6ET2KMnm1tvUJ
         knvJmqB9VY/ycn/uCWClmVI2gCWpK8/sLT++5h5yTXB0P34fGxfnRtJxFFpthFGnzNGe
         4P5IXvm0nR83RpZuwvE4LKvXbJyKpNbFVvUx7rMWj+gKx0ZEGAdYoO+zdbxSzfO5POW1
         FkGAIbCvcqNKUOa8IQCnt+Vc9Ipbj/0egT8tEYZs5Z4dUjqJt539Gzxb34Nxu1falfDV
         ZSTNEcakkOJIkF1VkaxuyXrq9wB1aGMexM3AkK+Qr1Dk0/uCLBavg9AbWfJv9HAWkP/y
         xJWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1BIUxVeen8muuz42zfNqVSQsKUvz7/Vo1ElLlMACPJgR1uGiwXilKJInbgLcJw7VH43h81fLz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eiQFHgPnmic6xz7tjq3EobDU+QtCz4Gt9j1MfqknQEMOLxwC
	fydNKxZzwMS55+QtehYayuRqBIKHq2M0uaEyoIRjqVay0mbcIELHv0gE
X-Gm-Gg: Acq92OEzIjOGfZb60wYAENJUFJ8q4wYFza7De7eCOjgBZTKNnb6mBExqb0uX6ntXlSe
	m4beFDp9Eul+uwLx6/rnabTEWw5+hUs2iyXOd0CCx16i2wWi5vRKt2OqftZAXkS1JjM3HeOcmaB
	7h11Rv4EqAa6+6jn5w2AzcVsHLDJAumo1zsatEALl7by4/U5NqikmtLDx6sNwqSL6saVoAMxk64
	4pZlHIrBYZd7o/uyhDgPgL7lw0ZLtSS6FZuRpBi67hjG2FgA/x0ocnx5nJSPlkkdhuoY/dwFOk0
	PMWV2U24gxEYg3AN0wNuolPPjOqc/iBfj9HqsVuklViu4O1+AO+LS2iXkj4ygy8HIDTRqSxb6Bm
	nP6ccwjH9eTaJR4NPzj1OUAyjZfd0PDSfO8EsDFYwOdyVkghyo3zwDpESh5gvNl6uP6V9QwM0iE
	5d/8dRKsCZ8YeiLM3m/8Rj95+akKSnYAISOe0pA6DR9stUjKdTe9A1RQ==
X-Received: by 2002:a05:6830:41:b0:7e6:50c4:e954 with SMTP id 46e09a7af769-7e650c4ff36mr836626a34.11.1779735896872;
        Mon, 25 May 2026 12:04:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm7751933a34.0.2026.05.25.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:04:56 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
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
Subject: [PATCH 0/7 v3] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Mon, 25 May 2026 12:04:47 -0700
Message-ID: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16252-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A5D6B5CDE58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
allocations, allowing small allocations to avoid walking the expensive
mem_cgroup hierarchy traversal and atomic operations on each charge.
This design introduces a fastpath, but there is room for improvement:

1. Currently, each CPU tracks up to 7 (NR_MEMCG_STOCK) mem_cgroups. When
   more than 7 mem_cgroups are actively charging on a single CPU, a
   random victim is evicted and its associated stock is drained.

2. Stock management is tightly coupled to struct mem_cgroup, which makes
   it difficult to add a new page_counter to mem_cgroup and have
   multiple sources of stock management, which is required when trying
   to introduce fastpaths to multiple hard limit checks.

This series moves the per-cpu stock down into the page_counter which
consolidates stock limit checking and page_counter limit checking into
page_counter_try_charge. This eliminates the 7-memcg-per-cpu slot limit,
the random evictions (drain & refill), and slot traversal.

In turn, we can add independent stock management for additional
page_counters in each memcg, which is used in my tiered memory limits
series to add a new page_counter to track toptier usage [1].

The resulting code in memcg is also easier to follow, as the caching
becomes transparent from memcg's perspective and managed entirely within
page_counter.

There are, however, a few tradeoffs.

First, the bound on how much memory can be overcharged (and remain stale
as stock) is raised. Previously, it was fixed to nr_cpus x 7 x 64 pages.
Now, it becomes nr_leaf_cgroups x nr_cpus x 64 pages. On large machines
with many cgroups, this could be significant. There are three qualifying
points: (1) larger machines should be able to tolerate the additional
overhead, (2) the stock should not remain stale as long as the
cgroups are actively charging memory, and (3) a process would have to
migrate across all CPUs to incur this upper bound on overhead.

Secondly, we introduce some additional memory footprint. The new struct
page_counter_stock adds 2 words of extra overhead per-(cpu x memcg).

A small change is that for cgroupv1, reported memsw usage can be lower
than reported memory usage, if the memsw page_counter overcharges to its
stock whereas the memory page_counter does not.

Finally, to keep the above memory footprint limited, I opted to not
embed a work_struct into page_counter_stock, but rather decided to
trigger synchronous stock draining, since the drain operation is rarer
now, and only happens under memory pressure and on cgroup death.

Performance testing across single-cgroup, as well as 4-cgroup (under the
7 memcg limit) and 32-cgroup scenarios on a 40CPU, 50G memory system
shows negligible performance differences. In the tests, I repeatedly
fault and release anonymous pages using madvise(MADV_DONTNEED) to
stress the charge/uncharge path, across 40 trials of 50 iterations.
Metric here is time it took across each iteration (ms).

There are two testing versions below; the only difference is that v3
is based on top of mm-new, and v2 is based on top of mm-stable. The
"after" on both sides are similar, but mm-new and mm-stable have
different perforamnces. 

v3, tested against mm-new
+----------+--------+-------+-----------+
| #cgroups | mm-new | after | delta (%) |
+----------+--------+-------+-----------+
|        1 |    357 |   358 |    +0.283 |
|        4 |   1245 |  1214 |    -2.430 |
|       32 |   9281 |  8970 |    -3.470 |
+----------+--------+-------+-----------+

v2, tested against mm-stable
+----------+-----------+-------+-----------+
| #cgroups | mm-stable | after | delta (%) |
+----------+-----------+-------+-----------+
|        1 |       352 |   353 |    +0.283 |
|        4 |      1198 |  1217 |    +1.585 |
|       32 |      8980 |  9027 |    +0.526 |
+----------+-----------+-------+-----------+

Further testing on other stress-ng microbenchmarks also agreed with
these results.

v2 --> v3:
- Rebased on top of latest mm-new, May 25, 2026, since the previous
  version could not be applied for Sashiko review.
- Re-ran test numbers

v1 --> v2:
- Dropped stock returning on uncharge to preserve same behavior as memcg
  stock. This resolves some race conditions present in v1.
- Fixed many race conditions between disabling page_counter_stock and
  in-flight charges
- Restructured drain_all_stock to iterate over all CPUs first before
  memcgs, to reduce the number of synchronous CPU work scheduling
- Optimized cgroup v2 further to drain only on the first child and skip
  the root mem_cgroup
- Dropped RFC
- Wordsmithing cover letter

[1] https://lore.kernel.org/all/20260423203445.2914963-1-joshua.hahnjy@gmail.com/

Joshua Hahn (7):
  mm/page_counter: introduce per-page_counter stock
  mm/page_counter: use page_counter_stock in page_counter_try_charge
  mm/page_counter: introduce stock drain APIs
  mm/memcontrol: convert memcg to use page_counter_stock
  mm/memcontrol: optimize memsw stock for cgroup v1
  mm/memcontrol: optimize stock usage for cgroup v2
  mm/memcontrol: remove unused memcg_stock code

 include/linux/page_counter.h |  16 ++
 mm/memcontrol.c              | 289 +++++++----------------------------
 mm/page_counter.c            | 140 ++++++++++++++++-
 3 files changed, 212 insertions(+), 233 deletions(-)

-- 
2.53.0-Meta


