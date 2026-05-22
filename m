Return-Path: <cgroups+bounces-16220-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBqpKPHTEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16220-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:08:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E785BAF14
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7D7130362F0
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199703909A8;
	Fri, 22 May 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxP9KSXx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873C38D412
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487591; cv=none; b=JMDkalgv+VwLyZlI6JQJNcbb/V5CnQRmykZYuh41GHUnyYXx2FaXeWHN76YfJIDP5a9SVLvC0ehV6bbPXbND/WXX/b/+n4Tm2V3IBrICAykLRx2is7cmzfaMddfx0GmommvENH3smSVYry2pYKR3MlP+Z04MDPmM9l+2v0u/Wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487591; c=relaxed/simple;
	bh=962U/sFP2aV6aoQ/n5p22srRp1SFYr/o1PwxhK7nhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIX6nvdk6uOTSfd5vPzWHkcH+s8eRhF8JVSs4/wABL3DGM9clg8LEYohJwXoTNU5uUNbVbOPigwOIP2VUqiA2WoGeGUS49NDAV/TSJCU1TzKCmWf2GE40+1xvet2ihbF0NS09tFiAiEdcrGlr7toiITjZ9Hg4IGA1oI4cPc/buE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxP9KSXx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d79fc48d2so1357333eaf.1
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487589; x=1780092389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aitoRh8af8hU9OmkzJFXm6Hu0+SgnlMA/xdSbDz8UH4=;
        b=qxP9KSXxDRnPcNQSH/kFvPK/t82QLOLT3U84lEN2Qn8U8NFp0hsI7ZnNmGv/J6jxNy
         qqI9F36q6apPED1ErFvfLXSvT+6tP8oyvhXVmpwqs3+vS847Iqqz5qGT3gCbqgcxJyzR
         WMqdtoXRexBG6Zm9GRAyUAhXcXezOSk6tqWAgHpnnVtbWs0nvJ+UiYPbwSZwPl4s0B8s
         Kn5QQLxi64eAf5/N3+m7JUOAUAzmLFs7yG3+yoF6njYqnaD4e1XpexFSh1pUuy4su6rN
         Qhbc5XZja9fnsGIwWtMeF0BBDNl+5fuBVnmQEdGm11LS4xOQzAcq08enVOALDangNWn7
         i8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487589; x=1780092389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aitoRh8af8hU9OmkzJFXm6Hu0+SgnlMA/xdSbDz8UH4=;
        b=oa034Rwvii4sRSsdMinqRa/qCg5U7N1Ic0SCGJ2kan+zOvA0bJlAG/enl3D9paaNi+
         puLexrhlFlOZe+AHDrJjiy34Kqa0RO7s4rJpbyBWat3DupLbb/6pBRZr8iPCDFV1rmUZ
         HV58EOoeJQeYeU9xfrp6N3XLvfKsLePqFH920dIoSqpFRQxPQhWN04rO/9sOzjqD1Uwl
         Vw8pKPmbxCpSeI/S4+Tf8/Wod8y0v1NdKWCwsNi0L5NtJdM+uX2tZTX8sz5iNbmaiSQY
         u8iBXeWnQWgnj8vmMNsAkUusZVyElgLyUBLsuTOXlecCZIDD9an1BoMnb7uUdctwmYHF
         3tjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YCoU43JK0V3EW5aiMmUARa262s4vHgCCtPmtXpzyp0PxtMY7D3cdFoDwEMAjPC82yx4NZSdVP@vger.kernel.org
X-Gm-Message-State: AOJu0YxufcFX/2uCVnga8bzAPt8Kv+cWyPozulPRIcJ9Qx02cYPcADO7
	XKqCdsiZBOEQEDtXtC4MBHT4z5CmDixMVk0KoXJFRms44Lt4QW18tVmQ
X-Gm-Gg: Acq92OHs5rLT3FV74muSW5ueC4nRAxILl3eNmZE8cctukkCNlwxa/5zPt3QlIf9lO0B
	qXLbAc44nIcIRwx5x5pJEv4vTn8YAZeg5rBlBQeOyfjMVHsf6ieuIHJDpAMhZ9KR+mvUKh0sJxb
	NZHGTXfYctrsjWF5EvQZoImsG1YMShJFMqGODppsm4opSwGo1U7jHVyT4zyGVBwoUhlH+ndi2lM
	GqED70HPjjVsiXG4wRCYgTZBdqJWZcnW9DBmMPYowv7gYhNeMcU0AT0cQXQs7RMrH85VsJns135
	HUb2LItAyR0MwcqBmcXNax9UJuxed2vJfgpiLEsCJms6ttl7ZUChpgY2RaM/lh8blt77R24Oqvx
	sIV/gT9y1SfpG7CeEHRRAFVWZHEFSSJ9T8ABkTvNDF+IswjLf5Ek39vJH+gQtps9d6CxjHnEc2N
	f+bu6UW/hVWFwI/vYk0mJDY1S+W96VMOoErwDjPL7fdkaa+avooIYVcg==
X-Received: by 2002:a4a:d813:0:b0:69d:7bdb:ade2 with SMTP id 006d021491bc7-69d7ec28651mr2091887eaf.32.1779487589309;
        Fri, 22 May 2026 15:06:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635e373fsm2879308fac.8.2026.05.22.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:28 -0700 (PDT)
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
Subject: [PATCH 0/7 v2] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri, 22 May 2026 15:06:18 -0700
Message-ID: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16220-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63E785BAF14
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
stress the charge/uncharge path, across 30 trials of 50 iterations.
Metric here is time it took across each iteration (ms).

+----------+--------+-------+-----------+
| #cgroups | before | after | delta (%) |
+----------+--------+-------+-----------+
|        1 |    352 |   353 |    +0.283 |
|        4 |   1198 |  1217 |    +1.585 |
|       32 |   8980 |  9027 |    +0.526 |
+----------+--------+-------+-----------+

Further testing on other stress-ng microbenchmarks also agreed with
these results.

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
 mm/memcontrol.c              | 286 ++++++++---------------------------
 mm/page_counter.c            | 140 ++++++++++++++++-
 3 files changed, 212 insertions(+), 230 deletions(-)

-- 
2.53.0-Meta


