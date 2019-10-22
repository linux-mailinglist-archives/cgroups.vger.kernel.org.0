Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD434E06BB
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbfJVOs0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37914 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbfJVOsZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id p4so16494157qkf.5
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcikxxhhZnd6YbZpIU4lRQd5AagmURIl+Vuyl9j6u4o=;
        b=FvZrlFyRQntoTimiufrW53mtj9qQm5Pfkmi6p9CvHGf4iR1aINMvfQGfKS5J6FOE6Q
         +a/mswPjs8yJdf44DISKKSp7pkEDXdEPHmpL5dPfkzMfKhGowvZmJntlFeptg/YT+M/4
         F1yyqrA4p/pPpGQwEYO5wWe4v1QX3CFT8wrfa/IjioJDCqvPCRNx912M+Xg1uvyLIba4
         UAI8qPBU/g32WGoLKqRcwfWhJ/8NtFsyvIIeW30mb8ztOxvbZzL7agXcNuzl+ePB6+7e
         nyCJPye+F9FgFZgkKIcjPyM7ig4P+P+beI6kZp4hAJ8urRBGbCg/vCRTdLEj/z9s2Ymk
         ndjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcikxxhhZnd6YbZpIU4lRQd5AagmURIl+Vuyl9j6u4o=;
        b=FAMdE347/ZjPmymCeUjjqNmeLjjssOOUKRP4VQ5D8kuohL+9ndzaJCGI41uxVLPjzE
         rY22AAS/g5XCizite4rkfoWwPDhJ73QydKQelrg1QXqb7Zosa5Ew8hOazmnXyG0pmL1r
         86vvBxej26mRKAZSIDzus8yujGlatDRbnYbMz1HOOJMjcDS/zSho8df7p/j8cPTgIvj8
         trbKj7hxj7QRQLytV6bjIgmQE6VBDUx7ROzUQvlbiMf6lnCutJAGEdBUweL6BMy7jjCp
         Yfwhmbfiq0uqyiRtgQ2dXrpq9SeyqzaiOf+7+PBCurZ3E0eL7y+FXqUHjC5vZRk4hKFn
         8keQ==
X-Gm-Message-State: APjAAAUbEOUgpViawvcLOXIGWyuJUmIFsq8U1ku6fu+HmVy0X00B2jXA
        pCQFAAVpo+lvgZAB/tEZ+ongoA==
X-Google-Smtp-Source: APXvYqwd6CQlHw+mwJeGW1LxVFd0b0qCo4M2vpP4Ov/AangPWepYRJV0QsNC4KaEIrqRkOUKo/osTA==
X-Received: by 2002:a37:8183:: with SMTP id c125mr3303192qkd.279.1571755703347;
        Tue, 22 Oct 2019 07:48:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id b4sm3862311qtt.26.2019.10.22.07.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:22 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 7/8] mm: vmscan: split shrink_node() into node part and memcgs part
Date:   Tue, 22 Oct 2019 10:48:02 -0400
Message-Id: <20191022144803.302233-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function is getting long and unwieldy, split out the memcg bits.

The updated shrink_node() handles the generic (node) reclaim aspects:
  - global vmpressure notifications
  - writeback and congestion throttling
  - reclaim/compaction management
  - kswapd giving up on unreclaimable nodes

It then calls a new shrink_node_memcgs() which handles cgroup specifics:
  - the cgroup tree traversal
  - memory.low considerations
  - per-cgroup slab shrinking callbacks
  - per-cgroup vmpressure notifications

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index db073b40c432..65baa89740dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2722,18 +2722,10 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 		(memcg && memcg_congested(pgdat, memcg));
 }
 
-static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct mem_cgroup *root = sc->target_mem_cgroup;
-	unsigned long nr_reclaimed, nr_scanned;
-	bool reclaimable = false;
 	struct mem_cgroup *memcg;
-again:
-	memset(&sc->nr, 0, sizeof(sc->nr));
-
-	nr_reclaimed = sc->nr_reclaimed;
-	nr_scanned = sc->nr_scanned;
 
 	memcg = mem_cgroup_iter(root, NULL, NULL);
 	do {
@@ -2786,6 +2778,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			   sc->nr_reclaimed - reclaimed);
 
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+}
+
+static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
+{
+	struct reclaim_state *reclaim_state = current->reclaim_state;
+	struct mem_cgroup *root = sc->target_mem_cgroup;
+	unsigned long nr_reclaimed, nr_scanned;
+	bool reclaimable = false;
+
+again:
+	memset(&sc->nr, 0, sizeof(sc->nr));
+
+	nr_reclaimed = sc->nr_reclaimed;
+	nr_scanned = sc->nr_scanned;
+
+	shrink_node_memcgs(pgdat, sc);
 
 	if (reclaim_state) {
 		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
@@ -2793,7 +2801,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/* Record the subtree's reclaim efficiency */
-	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
+	vmpressure(sc->gfp_mask, root, true,
 		   sc->nr_scanned - nr_scanned,
 		   sc->nr_reclaimed - nr_reclaimed);
 
-- 
2.23.0

