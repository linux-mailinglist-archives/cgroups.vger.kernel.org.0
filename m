Return-Path: <cgroups+bounces-16668-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RYSCNcvvImrZfQEAu9opvQ
	(envelope-from <cgroups+bounces-16668-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F32649775
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BR20jETF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16668-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16668-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4591A3067F8D
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF03F0746;
	Fri,  5 Jun 2026 15:36:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C98175A8D
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673769; cv=none; b=Ic5rfhpRBm5vPnszn/lhtF1rGzmzfCgpaUB9QRGy3abQsjHQ62hZohrhn6I9EHyu5TMSL4U7ve+3YduvlY69a7wLsGIVgad/9SMmgKGMUwA/HtGcF3GKnxCxVplAXU7ZoFBIAbadE/rOfvknJisD+S4HPYASHMasir1ye8mtPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673769; c=relaxed/simple;
	bh=fhq8e8X9blJMJLSwX7ZK1MoKmj66J3cq3EZ6sKEAElA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoApF5wF+buXBKDlDztVamsU+6yuX884U85bC8jgO6rAVtCDYLdnfKa/UjAyR91AqGMKefWqGlxu02nhL7GhUpPCHs2yus2zU1wSScOZLHJQ9K2w7Ng7SGtx/AUW18rR/ZYWbYNWm3bMRJ9A4BEAc6gQcZQgC15H8KQXzPbXpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR20jETF; arc=none smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6f27619e7so1528639a34.2
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673764; x=1781278564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrISvpPCKWDj31WRr2OteniiAJNmHCrQHZNb3nzP7nc=;
        b=BR20jETFS+kbSwrFSmvfyKrzCl7Nl7Qk4PRD6B4nK6ixCpPCMESgibqrY4eGpD5Diz
         W631CApwethzktX8PzniFaEIBrknlDHqKg9zi3i6TmSySwXpL+MFHrYQSI32lPi2wsIq
         WDq7dfiaw/OLLLEm2zo9NLlEt47xCjFKvblmiYIhdMsxNj6CbNKmX4uYd/yFvgUOAwYv
         Qpj5RPPMqIurURSDd/yYhSquwgE9aAu7Czw/9ktKFJ2OpZ3AmvdO7V3a4GJo77D8aeNv
         prA48ZHyJcTNl/SFZsOpX4on+AaAJAWgBDAb4jJB3q+hMmtpfo+Xozmc45foUg4w/3tf
         Q0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673764; x=1781278564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrISvpPCKWDj31WRr2OteniiAJNmHCrQHZNb3nzP7nc=;
        b=nlSg/Bos6XKrowdgTLHbciBTOXrzOHBFwjXqoenqHy7W4YzlqNzIXCNgRG64KiFqg4
         8rELbmd/Goe8a2j2IBFt6i7XBMyFuwjEYWRaah0aqhWeecHA8LSwXsKucxiQmrKE8Npu
         ra1cdfhaII3SIaTN4UYFoqoCd9XQBZRPjxyU2NBx3tyYQSi08x50jqSQKi9yU0lZeqCW
         WRXJEaogJKwkhEB60KNfna6QRAto41oSbcCdmHfdIPjCFqiPT/lTfcwIkUI+H1S6176O
         g8gCliR1dHVthEU9BZeZGdM0w1zlSdhU90xg1CugdEynNVpT3H2iKeTzYv0dL2CD/MOa
         NBcA==
X-Forwarded-Encrypted: i=1; AFNElJ85aERPQWV/IsDEc6jJRsRqDgzY7cRs4MYlFYuJIdjuaBrxtbiUKbj5wP4/eVeVzmiYMiR1GXsw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A05XtSZ2xrIXVdWydCa20QCInwEaEIW70GBsIoowveS/pKpU
	6I/X8fEu3WQdCE8Abssf5uTJpQYQ5otdYM8MBBZnJJExEr2H/wlzLGvM
X-Gm-Gg: Acq92OEuQAf350S0ZB1C/caYIURffg/gPV98voFKAjtz802Kk0Xag3OS26HY4lbwTAw
	krNIWpm2jwOBatttyBjHct7iA9KG1IAQAZSfZFlF0rWDV7XqcNcF+nDXECfx8p4Qn39/zfhXJ2n
	xLT7FtiHcgtB6JzPBuQA+Qbpdm1jteO9tKwgf9REpKcnYiQZnVAjcztJjiisOdTvadaUrl5YBrG
	6bdQmcw7L2a5nYm4slEZXn1wJtCEGkQLDY9lrysUC/aD70BuULeQiQhBhujYm0TjLI0RDoeopn8
	WXQCZAf+oIdmKoIWjoW3SzR+L/9g7nylIxU/OZZvVSP9alIeewTaOiWXWARWxjXC0Dn+uOB+9WZ
	TjJ6dJKHqBxIaYwZyzQqQeDoMYenD9EJx9G2YxEYhN8Rz4qVyqxBwyNRlUvxUCyltfB2c0kjrKQ
	Nzrn2ff//eQc5cm3iTP7aCCu4NSXCt1z4jksgI3lswcc6wm8Iz/dksG8YGD9JdHc7+
X-Received: by 2002:a05:6830:4425:b0:7e6:ff83:4b46 with SMTP id 46e09a7af769-7e70ca5c621mr2621260a34.23.1780673764515;
        Fri, 05 Jun 2026 08:36:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7468f8fsm6342595a34.6.2026.06.05.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:04 -0700 (PDT)
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
Subject: [PATCH 0/6 v3] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri,  5 Jun 2026 08:35:56 -0700
Message-ID: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16668-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49F32649775

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
with many cgroups, this could be significant.

There are four qualifying points:
1. Larger machines should be able to tolerate the additional overhead,
2. Stock should not remain stale as long as the cgroups are actively
   charging memory,
3. Getting close to this overhead is rare, as it would require a process
   to migrate across all CPUs and leave stock there.
4. These charges are not "real" allocated memory, but rather accounting
   done in memcg; they are easily returned on pressure.

Secondly, we introduce some additional memory footprint. The new struct
page_counter_stock adds 2 words of extra overhead per-(cpu x memcg).

A small change is that for cgroupv1, reported memsw usage can be lower
than reported memory usage, if the memsw page_counter overcharges to its
stock whereas the memory page_counter does not.

Finally, to keep the above memory footprint limited, I opted to not
embed a work_struct into page_counter_stock, but rather decided to
trigger synchronous stock draining, since the drain operation is rarer
now, and only happens under memory pressure and on cgroup death.

One side effect of doing synchronous work is that drain_all_stock holds
the percpu_charge_mutex longer while it performs the work, which means
chargers may be more likely to be unable to grab the mutex lock and
exhaust MAX_RECLAIM_RETRIES and OOM, in theory. In practice, I have not
been able to replicate this behavior in my experiments.

Performance testing across single-cgroup, as well as 4-cgroup (under the
7 memcg limit) and 32-cgroup scenarios on a 40CPU, 50G memory system
shows moderate performance gains (~1%). In the tests, I repeatedly
fault and release anonymous pages using madvise(MADV_DONTNEED) to
stress the charge/uncharge path, across 30 trials of 50 iterations.
Metric here is time it took across each iteration (ms).

+----------+--------+-------+-----------+
| #cgroups | before | after | delta (%) |
+----------+--------+-------+-----------+
|        1 |    357 |   350 |    -1.960 |
|        4 |   1221 |  1204 |    -1.392 |
|       32 |   9184 |  9032 |    -1.682 |
+----------+--------+-------+-----------+

Further testing on other stress-ng microbenchmarks also agreed with
these results.

v2 --> v3:
- Dropped the cgroup v2 optimization, since it could indeed lead to too
  much time held with the cgroup_mutex. Instead we let the stock
  accumulate in the parent cgroups, which is not so bad; charges can
  still land on these cgroups, and if we ever reach the mem_cgroup
  limit, we can easily return those charges.
- page_counter_disable_stock no longer drains, just prevents
  accumulating stock. The actual draining is done in the free_stock
  variant, where we know for sure there are no in-flight charges.
- Reordering the page_counter_disable_stock path to disable before
  draining as to prevent accumulating stock first.
- Skip isolated CPUs when draining synchronously
- Rebase on newest mm-new
- Wordsmithing

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

Joshua Hahn (6):
  mm/page_counter: introduce per-page_counter stock
  mm/page_counter: use page_counter_stock in page_counter_try_charge
  mm/page_counter: introduce stock drain APIs
  mm/memcontrol: convert memcg to use page_counter_stock
  mm/memcontrol: optimize memsw stock for cgroup v1
  mm/memcontrol: remove unused memcg_stock code

 include/linux/page_counter.h |  16 ++
 mm/memcontrol.c              | 276 ++++++-----------------------------
 mm/page_counter.c            | 129 +++++++++++++++-
 3 files changed, 188 insertions(+), 233 deletions(-)

-- 
2.53.0-Meta


