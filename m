Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6B8A703
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2019 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfHLTXT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Aug 2019 15:23:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42874 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfHLTXT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Aug 2019 15:23:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so49975849pgb.9
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2019 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbZ4Sjz/PnOqkj9Tyb0eRWLHmMcoPs5r9WlmOIHpeSo=;
        b=jzC2l9r88UaY1IukY7wBl28NxdfPM525Oizdju82oqnG+UjMFtJsmQ4V8Uvx/6+Orm
         fWS1GQxRoaEB2jq5CsZnnU1wxLSuBymvRWSQYQv2k4Fc04be15Oia6PI0grZJI7R2lxH
         IIEMek1SCHJoUx7vl2b0ZqSLUs8sascLRu9JdKIBwCJMo6nAISs6UQ+jEeXfnyNHERRv
         auaqhuzsjPAV71Ee7a+PteY3nAiiXs0DyQhgGfGNjObh9DdA0bOLONSDN10g6v6ng50c
         nzWmlZ4d3goJTdGLPL9hG2fwhhVHCKPrGDEk5V0RvMSdUKKA+J9+ZRo4KaIWYRmCYX2/
         vyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbZ4Sjz/PnOqkj9Tyb0eRWLHmMcoPs5r9WlmOIHpeSo=;
        b=kKDP0qWCC5p3Itby3AjbJc2VchrgSfJ/HskA9TbJSkEMfGCf3NqaXnxsRQOIK78JcX
         Som9iZcJDDz01E+gEiGGEGA7aqOcv6XexcjrkYji/mwkWJRi/ioVXz37tvMO7Et01US6
         AfIDF418GJ2n0lW18lSymCAvUWxv+5D1hhkNpJ7IJMkBuHNzKh/vcxnKZFacYeM2rWuG
         Ho5vXOVR6eSYcA2T5dDS9E3luZXgGgj14r6rx7std5UEAylrenBKV1qGjMBJa8RYjvwM
         9sfxrLhbCY6pm6u1WhKtaaUaoyMzXjuCgNeUAfRXsOIDhEI9ODDqnIbPtXzbbCTS86zB
         NvPg==
X-Gm-Message-State: APjAAAVZ5tdH4ysszJa/dzHFCqqfQHtDodEZ47nOduhXbsOA6zhmNhx5
        owAFjT6DvPkuTHWiJiNJeCDuGg==
X-Google-Smtp-Source: APXvYqw1S8904a2xrHCvhOv0CHIN7t7zCW5x0903Sd3n3zquB/ZaHzb6mZNsVhdWI0VY78GJibDFVA==
X-Received: by 2002:a65:5188:: with SMTP id h8mr31346069pgq.294.1565637798475;
        Mon, 12 Aug 2019 12:23:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::5810])
        by smtp.gmail.com with ESMTPSA id v8sm340554pjb.6.2019.08.12.12.23.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:23:17 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: vmscan: do not share cgroup iteration between reclaimers
Date:   Mon, 12 Aug 2019 15:23:16 -0400
Message-Id: <20190812192316.13615-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One of our services observed a high rate of cgroup OOM kills in the
presence of large amounts of clean cache. Debugging showed that the
culprit is the shared cgroup iteration in page reclaim.

Under high allocation concurrency, multiple threads enter reclaim at
the same time. Fearing overreclaim when we first switched from the
single global LRU to cgrouped LRU lists, we introduced a shared
iteration state for reclaim invocations - whether 1 or 20 reclaimers
are active concurrently, we only walk the cgroup tree once: the 1st
reclaimer reclaims the first cgroup, the second the second one etc.
With more reclaimers than cgroups, we start another walk from the top.

This sounded reasonable at the time, but the problem is that reclaim
concurrency doesn't scale with allocation concurrency. As reclaim
concurrency increases, the amount of memory individual reclaimers get
to scan gets smaller and smaller. Individual reclaimers may only see
one cgroup per cycle, and that may not have much reclaimable
memory. We see individual reclaimers declare OOM when there is plenty
of reclaimable memory available in cgroups they didn't visit.

This patch does away with the shared iterator, and every reclaimer is
allowed to scan the full cgroup tree and see all of reclaimable
memory, just like it would on a non-cgrouped system. This way, when
OOM is declared, we know that the reclaimer actually had a chance.

To still maintain fairness in reclaim pressure, disallow cgroup
reclaim from bailing out of the tree walk early. Kswapd and regular
direct reclaim already don't bail, so it's not clear why limit reclaim
would have to, especially since it only walks subtrees to begin with.

This change completely eliminates the OOM kills on our service, while
showing no signs of overreclaim - no increased scan rates, %sys time,
or abrupt free memory spikes. I tested across 100 machines that have
64G of RAM and host about 300 cgroups each.

[ It's possible overreclaim never was a *practical* issue to begin
  with - it was simply a concern we had on the mailing lists at the
  time, with no real data to back it up. But we have also added more
  bail-out conditions deeper inside reclaim (e.g. the proportional
  exit in shrink_node_memcg) since. Regardless, now we have data that
  suggests full walks are more reliable and scale just fine. ]

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dbdc46a84f63..b2f10fa49c88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2667,10 +2667,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	do {
 		struct mem_cgroup *root = sc->target_mem_cgroup;
-		struct mem_cgroup_reclaim_cookie reclaim = {
-			.pgdat = pgdat,
-			.priority = sc->priority,
-		};
 		unsigned long node_lru_pages = 0;
 		struct mem_cgroup *memcg;
 
@@ -2679,7 +2675,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		nr_reclaimed = sc->nr_reclaimed;
 		nr_scanned = sc->nr_scanned;
 
-		memcg = mem_cgroup_iter(root, NULL, &reclaim);
+		memcg = mem_cgroup_iter(root, NULL, NULL);
 		do {
 			unsigned long lru_pages;
 			unsigned long reclaimed;
@@ -2724,21 +2720,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				   sc->nr_scanned - scanned,
 				   sc->nr_reclaimed - reclaimed);
 
-			/*
-			 * Kswapd have to scan all memory cgroups to fulfill
-			 * the overall scan target for the node.
-			 *
-			 * Limit reclaim, on the other hand, only cares about
-			 * nr_to_reclaim pages to be reclaimed and it will
-			 * retry with decreasing priority if one round over the
-			 * whole hierarchy is not sufficient.
-			 */
-			if (!current_is_kswapd() &&
-					sc->nr_reclaimed >= sc->nr_to_reclaim) {
-				mem_cgroup_iter_break(root, memcg);
-				break;
-			}
-		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
+		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-- 
2.22.0

