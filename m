Return-Path: <cgroups+bounces-17190-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzYbKWXKOmpNHAgAu9opvQ
	(envelope-from <cgroups+bounces-17190-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:03:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E363D6B9597
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:03:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g9srL9+x;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17190-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17190-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DDE3058814
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307C3911D5;
	Tue, 23 Jun 2026 18:01:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9C2F8E9C
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:01:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237689; cv=none; b=DxOAwVeMedACI0n4JRVVw90Ys960dvHXFruwGMqZkLMKcwyl43sznhX0x5+7Fn02nDJ3wyKY6+ZPgmwVECckIKdZwHJNDfjjZPlAlYu74zGgERbjuDlXqD+lobAjyrYrwJCX+h/fzbc72Zd46XYeWxNcAvUoLuFesOCIFnig11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237689; c=relaxed/simple;
	bh=JPyZk6FF6oQcAECXw3GAs0B362Mqgccf/vZbjhYIu40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K94r2LwAht1ror6+Z3JYroJi3KGI9wYaoVX/PuRkOcdzgy4BSXBrZ34GttqdesN6ukhpnunfxGDluyqnTdXzyUItfwFsKVLifHKdkkYnfQI66jRNn5GYfSu2xewDIsWaMIwrlzlDoAhq1W+DCqOPHA9EV6VmVw7hRiTl1cJ5wZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9srL9+x; arc=none smtp.client-ip=209.85.160.52
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44758ab7c60so159595fac.2
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237686; x=1782842486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MY1Ldz3B6HlKyVZ18RU6aMWYK7T1s/vC+KTUQ9kZi20=;
        b=g9srL9+x5XyBEMkEvwGTySIDxoEOYayoMXP8jirDRmmjz90HF8sCEnmbAbK/CDpWxj
         3py6TXMVUgZBy3tiCnz6zULIiOfGf1ifU4zszdVS6LYVR2KuIppf07mbjAsx4okfh6gm
         cXxg2JzOmAnzLeQquGV7jsa/WjBs6nQTt8s2B9SsxQN4EeFV7ZWTykl1SYpO4oOJuKMo
         ezCRogdjHll184StOVzCyNhouO2j1EaAxZTvrX+PI2Lu7qAb83RRdl1R/eNBPQrdhngp
         lY0igPSyBFZqcijB+2qyC0tsYnvBW7vsuFydICBKWIBr5chMAngUB0XX1mKGZ4OOx5s/
         37Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237686; x=1782842486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY1Ldz3B6HlKyVZ18RU6aMWYK7T1s/vC+KTUQ9kZi20=;
        b=N7dVS5D8kxg/bVHVY8xEc6Y+LdE8Zmgfm0pVnmeCgSWe/ydqwIV4PIpvA1UtIKeESv
         qY+2G6e2xHQ7J1LV+AnPjk7Fpo4/tJm056xQygW//RiFbnbhQcUO4UhVA3O0Eofax7Sb
         rOVwthiPJjJx62ram7+3uUiao/6IaakSW6t8AI6qZsOPcmOE5XSzamfOR7Rdb4QB40UY
         T/GtV2RDpwOSY9XCWnZUNZIJCZu3iWE8GXDfJDhx/8LaNiZSGqlJI5CTwaCur2bepC8W
         ucNQD5/95rnWohURWodr8nrcrkQT47apn0uXI27nEjIB1O5E9T15PbSFYxh8ieY98uHT
         i+nw==
X-Forwarded-Encrypted: i=1; AHgh+Rr91xPKzj4qs624dkJdnoyF6md8Y6r55TEaqaekx0j+A0dsEeOa/Mbgr74K6gcwRI+hOdRTb0n0@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7my2Sp8VTYevDVJtYhknbeX5LvuaNNBytcY5QgZ6eQEgyZti
	bcuxx6QJ0HLY5+AynvfBfi0LJbWnDGj7gsf8DGZVNK7VVhAn0lW7ukj5
X-Gm-Gg: AfdE7cnWS96aMM1pn3/MKdE/Uz/N9izv8JOkfa7TN7HFAN5Ja/DOlScncszs2tq9R0O
	Q6Kv/Yk4Eh/LFEsF08Vho4/9V42b75N6HfkBN2ym99RXqjIdxRa4POSlGQvurlOAK4Wje6kFtl+
	WvVcEVpsF5VO/zL2GbRI4KEevJYCZ7DeTYTaQN1pb9LdTd/SLWCB8S4KSP+Ak4q7HYw7Fj32q1J
	yXvG04w6H+heQmXdbskLlCzO2qNu7EGeE9lykTaazvgSlrMLd5CSxCGqsEyVIrH1RtO7UXkKXb9
	8n/3ia39Y0y2uI7QQ42n4EGSG7L+mHlHTcUeHyyBUp0MS5K5k02SEMOtGQ+N4dNU+r6OveCzpaX
	n4NHtm6KTj/MhScmUtbH2lIOP0Pq1aQv7wN0ceszdXH1/b0QijAtO437EJnvYwYVgiEdxAIodpM
	btbTRyg/oV5SEHGePdB5QcbRBu2/FbBq75oOKjnvc3s9M=
X-Received: by 2002:a05:6870:638c:b0:43d:3790:46c with SMTP id 586e51a60fabf-44707ef2b82mr16146481fac.29.1782237685727;
        Tue, 23 Jun 2026 11:01:25 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ecd3b51sm8900432fac.7.2026.06.23.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:01:25 -0700 (PDT)
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
Subject: [PATCH v4 0/5] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Tue, 23 Jun 2026 11:01:18 -0700
Message-ID: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17190-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E363D6B9597

This series is intended for the next release cycle.

v3 --> v4
=========
- Reduced memory footprint by 4x, from 16 bytes per-(cpu x memcg) to
  4 bytes per-(cpu x memcg). Each page_counter_stock is a thin wrapper
  around an atomic_t.
- Removed locking completely and uses atomic operations to use stock.
- Removed synchronous work_on_cpu. All work is done via remote
  atomic_xchgs.
- Added a patch to flatten page_counter charging in try_charge_memcg
- Split page_counter_try_charge into stocked and non-stocked variants.

INTRO
=====
Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
allocations, allowing small and frequent allocations to avoid walking
the expensive mem_cgroup hierarchy traversal each time. This fastpath
offers real improvements, but there is room for improvement:

1. Currently, each CPU tracks up to 7 (NR_MEMCG_STOCK) mem_cgroups. When
   more than 7 mem_cgroups have stock present on a single CPU, a random
   victim is evicted and its associated stock is drained.

2. When one cgroup runs out of memory and needs to drain stock across
   all CPUs it has stock cached in, those CPUs will drain all other
   memcgs' stock present in that CPU. This leads to inefficient stock
   caching and cross-memcg interference under memory pressure.

3. Stock management is tightly coupled to struct mem_cgroup, which makes
   it difficult to add a new page_counter to mem_cgroup and have
   multiple sources of stock management.

This series moves the per-cpu stock down into page_counter which
consolidates stock limit checking and page_counter limit checking into
page_counter_try_charge_stock. This eliminates the 7 memcg-per-cpu slot
limit, the random cross-memcg stock drains, and slot traversal. We also
simplify memcontrol code, since we no longer need to maintain separate
draining functions or manage the asynchronous workqueue.

In turn, we can add independent stock management for additional
page_counters in each memcg, which is used in my tiered memory limits
series to add a new page_counter to track toptier usage [1].

There are a few tradeoffs, however.

First, the bound on how much memory can be overcharged (and remain stale
as stock) is raised. Previously, it was fixed to nr_cpus x 7 x 64 pages.
Now, it becomes nr_cpus x nr_cgroups x 64 pages. On large machines
with many cgroups, this could be significant.

There are 4 qualifying points:
1. Larger machines should be able to tolerate the additional overhead.
2. Stock should not remain stale as long as the cgroups are actively
   charging memory.
3. Getting anywhere close to this overhead is difficult and rare. It
   would require processes to bounce across CPUs and refill stock.
4. These charges are not "real" allocated memory, but rather accounting
   done in memcg; they are easily returned on pressure.

Secondly, we introduce a small memory footprint.
The new struct page_counter_stock is a wrapper around an atomic_t,
which adds 4 bytes of overhead per-(cpu x memcg). On a 1024-CPU,
1024-memcg system, this adds 4MB of overhead. Smaller machines will
see much smaller overhead.

One small side effect for cgroupv1: this series decouples swap for
the memory and memsw page_counters. Since stock charging can go out of
sync, this means that users can transiently see memsw usage go below
memory usage.

Finally, by moving from asynchronous workqueue scheduling for draining
to synchronous atomic_xchg, drain_all_stock holds the
percpu_charge_mutex longer while it performs the work. This means that
chargers may be more likely to be unable to grab the mutex lock and
exhaust MAX_RECLAIM_RETRIES and OOM, in theory. In practice, I have not
been able to replicate this behavior in my experiments.

The series was built on top of latest akpm/mm-new as of Jun 23 2026,
which is cdad4d4e4fc2e "mm/swap, PM: hibernate: atomically replace
hibernation pin".

TESTING
=======
I tried to demonstrate the worst-case overhead this series introduces
by writing a microbenchmark that pins multiple cgroup jobs to a single
CPU and repeatedly faulting and releasing anon pages using
madv(MADV_DONTNEED) in each cgroup. The data was collected over
30 trials of 15 iterations. Metric here is time each iteration took (ms)

+----------+--------+-------+-----------+--------------+
| #cgroups | before | after | delta (%) | variance (%) |
+----------+--------+-------+-----------+--------------+
|        1 |    112 |   112 |     0.000 |          1.1 |
|        4 |    443 |   451 |    +1.806 |          1.1 |
|       32 |   3512 |  3584 |    +2.051 |          2.0 |
+----------+--------+-------+-----------+--------------+

It appears as though there is some small regression, although the
magnitude is similar to the coefficient of variation (stddev / mean).

CHANGELOG
=========
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

Joshua Hahn (5):
  mm/page_counter: introduce per-page_counter stock
  mm/memcontrol: flatten try_charge_memcg control flow
  mm/page_counter: introduce page_counter_try_charge_stock()
  mm/memcontrol: convert memcg to use page_counter_stock
  mm/memcontrol: remove unused memcg_stock code

 include/linux/page_counter.h |  19 +++
 mm/memcontrol.c              | 280 ++++++-----------------------------
 mm/page_counter.c            |  90 +++++++++++
 3 files changed, 155 insertions(+), 234 deletions(-)

-- 
2.53.0-Meta


