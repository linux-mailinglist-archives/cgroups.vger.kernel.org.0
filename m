Return-Path: <cgroups+bounces-4243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122C950F5A
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52A31F2363B
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8A1AAE07;
	Tue, 13 Aug 2024 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pbNzjfki"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583651E498
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586066; cv=none; b=FDeh/iqBQcFgOF6QiIFdBeUd7/GbNAQuz7S+6SMkIbppasa7W+ZSSNxSBmr0Bv27O4y0aAIaPZBNFiUsOgM0KdBg3nBjlyucPBw1svOFbhUnHBF0UqGQ//2SCurDPzhR03w0CkHVIEArOJAzGvzxR3lYkC6KwlKzMj/uPvT5d/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586066; c=relaxed/simple;
	bh=ngbmzPaIxKWf5UwKfK8Me4kccHyDmy9FxE9+63UWwfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjQXJQWG42uWiS4q8KGSk8mJ6EC+xWD4PZjJmcuGacYpMOFQepQyLPSkLKg/qH4rNZ5VQwkyDdtcaz13Eh/YzEjyZC7OULiVUK0jWZJ7jgTnvgKq+YN5RRhC//p/j5zHWz9snuWwRzjmC1u6EsDFiE9kPwFrlwvxD+d2l5+I8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pbNzjfki; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723586061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I6Arg1vJbf0/Wx+BzG60P4s5RDSrDJtVAVWTc5jBHE0=;
	b=pbNzjfkiX/19NxQ6KDx2SG+dW7TlKPYFR5xrphkUmQy2A+Z6oRnQOzZWJk7rk8CR9r2zvk
	hlVl5uyC6cig0TY2SKYpKxTzNKfMutajuI6eqn7cUD4yvrqVbLXjRtPqeZNlnr1K262ovx
	dHjmBQ+QeJG/PD3mHUZDLjcUfDbO6rY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
Date: Tue, 13 Aug 2024 14:53:58 -0700
Message-ID: <20240813215358.2259750-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Meta prod is seeing large amount of stalls in memcg stats flush
from the memcg reclaim code path. At the moment, this specific callsite
is doing a synchronous memcg stats flush. The rstat flush is an
expensive and time consuming operation, so concurrent relaimers will
busywait on the lock potentially for a long time. Actually this issue is
not unique to Meta and has been observed by Cloudflare [1] as well. For
the Cloudflare case, the stalls were due to contention between kswapd
threads running on their 8 numa node machines which does not make sense
as rstat flush is global and flush from one kswapd thread should be
sufficient for all. Simply replace the synchronous flush with the
ratelimited one.

One may raise a concern on potentially using 2 sec stale (at worst)
stats for heuristics like desirable inactive:active ratio and preferring
inactive file pages over anon pages but these specific heuristics do not
require very precise stats and also are ignored under severe memory
pressure.

More specifically for this code path, the stats are needed for two
specific heuristics:

1. Deactivate LRUs
2. Cache trim mode

The deactivate LRUs heuristic is to maintain a desirable inactive:active
ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
check if there is a refault since last snapshot and the LRU size are
needed for the desirable ratio between inactive and active LRUs. See the
table below on how the desirable ratio is calculated.

/* total     target    max
 * memory    ratio     inactive
 * -------------------------------------
 *   10MB       1         5MB
 *  100MB       1        50MB
 *    1GB       3       250MB
 *   10GB      10       0.9GB
 *  100GB      31         3GB
 *    1TB     101        10GB
 *   10TB     320        32GB
 */

The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
LRU size information to calculate this ratio. In addition, if
deactivation is skipped for some LRU, the kernel will force deactive on
the severe memory pressure situation.

For the cache trim mode, inactive file LRU size is read and the kernel
scales it down based on the reclaim iteration (file >> sc->priority) and
only checks if it is zero or not. Again precise information is not
needed.

This patch has been running on Meta fleet for several months and we have
not observed any issues. Please note that MGLRU is not impacted by this
issue at all as it avoids rstat flushing completely.

Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- Updated the commit message.

 mm/vmscan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 008b62abf104..82318464cd5e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2282,10 +2282,11 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
 
 	/*
-	 * Flush the memory cgroup stats, so that we read accurate per-memcg
-	 * lruvec stats for heuristics.
+	 * Flush the memory cgroup stats in rate-limited way as we don't need
+	 * most accurate stats here. We may switch to regular stats flushing
+	 * in the future once it is cheap enough.
 	 */
-	mem_cgroup_flush_stats(sc->target_mem_cgroup);
+	mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.43.5


