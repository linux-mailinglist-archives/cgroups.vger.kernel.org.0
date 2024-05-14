Return-Path: <cgroups+bounces-2897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870788C5C4D
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F201F223DA
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6B181BAE;
	Tue, 14 May 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DZNopNqt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39374181B9E
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718413; cv=none; b=AqtknE0nV7FzeBZOXmIyTtwa/AvAGzrsjEbI/BBg9Bz2Dw6u2buwydc8LvZpDGczq2hEci0YFJr7P+z0p4vTetfSwjLSLd/ciZlk4UHNvtCD6L30pW8nOvq350pPOGRyji22k3ejmvVd2fVoO25drd3qg4dM8LkDqdET8o97HCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718413; c=relaxed/simple;
	bh=9ovL8blt54J4IkURyy71i8AdXyULzVLQ8iVXwLUpsIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOrSDsTTFL0u3YOvPFvOhv1bH7raIr0eokbV2N9xwx33opZdJlYZ/p05gAvuOsyuKzaZ4Uk2y+v7KB59cOGtjHKnSgF2mJub/ZXZaYqWoRCT2wSrYN3U6M9c5vwoXel467cv0fZoi75jz7DJ8P2KvDmHvqH6Aiopda0/dl2nbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DZNopNqt; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f12171523eso156139a34.1
        for <cgroups@vger.kernel.org>; Tue, 14 May 2024 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715718407; x=1716323207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O5XCYkGYyzGIUkvLmvAAXCAYXLNncUqXZsXZSUBTyQ=;
        b=DZNopNqt5+d0nCeEv5eHz4gQ1WYgOwvbbQBXE/IXeMoPS0odT/STYUJIcDjyGWMEAD
         eC3mkTxvB7qV700q1N1oqKsRW4Y/8WNRMuydZAfGnwolcnJQD/IWpyoC79OckDPG8+ZR
         E8ybLSq5KXOCZZOnGFB1CvfENaq5+R4DJhdj90Mtl1km0he5PxzNddCE8dYTtJPRSoTG
         915Mivcbrd3VNBXye9olTZ2LTOCAi9MkOcJWxkxj+2f+FdiV91T1skot7f+yKKcpUB3/
         f9JCyCiInpTuRWO1c27bihiaVbUdEiLp2NsGM9Lz46y0PMGaCrAc1ngWaIavCZHwL7sy
         R6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715718407; x=1716323207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0O5XCYkGYyzGIUkvLmvAAXCAYXLNncUqXZsXZSUBTyQ=;
        b=lAuANsNFACmIGsyJmgSdYrjEhq10+mqVQ8yM5/dIASx6dVnwtLIHDn7z6pP1/3/Iu0
         4ndRUSN77mH7N4rF8F8MW2ToA2gSs0tzPpb+0myWZ3L2wVNqiGDkR3LMMJobpLoUJYYq
         d047XipdoVAjqT0oIbVNLv6mr/T9xyEeg9zFtyPiL0zkwjsenWugu8kJz6z3snnGCviC
         noSOxbeVuiFOvxaUaxVyzivhDqSsRZA/MmO7RHbX12D+dncW0hFRT8PfyW2eR9XP+Kwz
         oi7wFVCwtOFKJ2X/RXuh+Uww4NQ05u1gXN59cy/80Yxf+PaTLiFtQrZUZDRv+b2NAHmK
         fwxA==
X-Forwarded-Encrypted: i=1; AJvYcCWXOkDzMf9XnQ+FgKTvG1szN7IhZbqiRzI+r8fhKp6wYIT1xghVwVPezntFTeouwX21GOhita2LtTGWQz++M3AkYKNII/sPNA==
X-Gm-Message-State: AOJu0YztARMuMfcX6oHjPYJOBhfMk8g92l+OkvZUxKr7vUTOBiE6Bc0E
	den1IADgtLq5D2yFtluB60mLWzC+7SRrI0pDGwV0j68ife+sNlthkHiGRWwcHU8=
X-Google-Smtp-Source: AGHT+IGO+qAPmSeGOWuLJTewv+LxksrKrecgjOdKQj5wXGe1ZeHG3N4/yS0s7LykbAFJrCVucSG0eA==
X-Received: by 2002:a9d:3e4d:0:b0:6ef:8634:f5f1 with SMTP id 46e09a7af769-6f0e92e9ec5mr16038071a34.31.1715718407030;
        Tue, 14 May 2024 13:26:47 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf31168csm598943285a.115.2024.05.14.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 13:26:46 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Rik van Riel <riel@surriel.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] mm: vmscan: restore incremental cgroup iteration
Date: Tue, 14 May 2024 16:26:41 -0400
Message-ID: <20240514202641.2821494-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, reclaim always walks the entire cgroup tree in order to
ensure fairness between groups. While overreclaim is limited in
shrink_lruvec(), many of our systems have a sizable number of active
groups, and an even bigger number of idle cgroups with cache left
behind by previous jobs; the mere act of walking all these cgroups can
impose significant latency on direct reclaimers.

In the past, we've used a save-and-restore iterator that enabled
incremental tree walks over multiple reclaim invocations. This ensured
fairness, while keeping the work of individual reclaimers small.

However, in edge cases with a lot of reclaim concurrency, individual
reclaimers would sometimes not see enough of the cgroup tree to make
forward progress and (prematurely) declare OOM. Consequently we
switched to comprehensive walks in 1ba6fc9af35b ("mm: vmscan: do not
share cgroup iteration between reclaimers").

To address the latency problem without bringing back the premature OOM
issue, reinstate the shared iteration, but with a restart condition to
do the full walk in the OOM case - similar to what we do for
memory.low enforcement and active page protection.

In the worst case, we do one more full tree walk before declaring
OOM. But the vast majority of direct reclaim scans can then finish
much quicker, while fairness across the tree is maintained:

- Before this patch, we observed that direct reclaim always takes more
  than 100us and most direct reclaim time is spent in reclaim cycles
  lasting between 1ms and 1 second. Almost 40% of direct reclaim time
  was spent on reclaim cycles exceeding 100ms.

- With this patch, almost all page reclaim cycles last less than 10ms,
  and a good amount of direct page reclaim finishes in under 100us. No
  page reclaim cycles lasting over 100ms were observed anymore.

The shared iterator state is maintaned inside the target cgroup, so
fair and incremental walks are performed during both global reclaim
and cgroup limit reclaim of complex subtrees.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/vmscan.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6981a71c8ef0..fc22704fbbe1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -133,6 +133,9 @@ struct scan_control {
 	unsigned int memcg_low_reclaim:1;
 	unsigned int memcg_low_skipped:1;
 
+	/* Shared cgroup tree walk failed, rescan the whole tree */
+	unsigned int memcg_full_walk:1;
+
 	unsigned int hibernation_mode:1;
 
 	/* One of the zones is ready for compaction */
@@ -5862,9 +5865,25 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
+	struct mem_cgroup_reclaim_cookie reclaim = {
+		.pgdat = pgdat,
+	};
+	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
 	struct mem_cgroup *memcg;
 
-	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
+	/*
+	 * In most cases, direct reclaimers can do partial walks
+	 * through the cgroup tree, using an iterator state that
+	 * persists across invocations. This strikes a balance between
+	 * fairness and allocation latency.
+	 *
+	 * For kswapd, reliable forward progress is more important
+	 * than a quick return to idle. Always do full walks.
+	 */
+	if (current_is_kswapd() || sc->memcg_full_walk)
+		partial = NULL;
+
+	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
@@ -5914,7 +5933,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				   sc->nr_scanned - scanned,
 				   sc->nr_reclaimed - reclaimed);
 
-	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
+		/* If partial walks are allowed, bail once goal is reached */
+		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
+			mem_cgroup_iter_break(target_memcg, memcg);
+			break;
+		}
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
 }
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
@@ -6287,6 +6311,20 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	if (sc->compaction_ready)
 		return 1;
 
+	/*
+	 * In most cases, direct reclaimers can do partial walks
+	 * through the cgroup tree to meet the reclaim goal while
+	 * keeping latency low. Since the iterator state is shared
+	 * among all direct reclaim invocations (to retain fairness
+	 * among cgroups), though, high concurrency can result in
+	 * individual threads not seeing enough cgroups to make
+	 * meaningful forward progress. Avoid false OOMs in this case.
+	 */
+	if (!sc->memcg_full_walk) {
+		sc->memcg_full_walk = 1;
+		goto retry;
+	}
+
 	/*
 	 * We make inactive:active ratio decisions based on the node's
 	 * composition of memory, but a restrictive reclaim_idx or a
-- 
2.45.0


