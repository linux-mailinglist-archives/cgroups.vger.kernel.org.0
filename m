Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCEDF39E0
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 21:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKGUxm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 15:53:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41931 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfKGUxm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 15:53:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id h4so2740574pgv.8
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnXcKvw24Mkpxrnsn9Jk/2NsGqvskVrKtfbs3H323nA=;
        b=OzWbKP3QiAn5Cn8rqW3do83+lh2GNKnq0FS6MLFOgzuNg9dowb58c23NoQzbB4lOdp
         W/UmmwJIvWubOW8e8AJP+Ab0S8N1ndrzXmVCVkPfewcm1xbU9rkvqPvwCOU8QjJ0TCz1
         2XA8J6K9+5TBaC2uSnBomFE2jescOZki3s/+b7Zs8yd34ZfQTpzAi0FICpNiOTlz2+iG
         aepA0Eqnm1gTv2wpj5IcSHjnJhNPZMhqlHSPShHOjL5/j8blN+6ibf/WtsHncdXvrzo1
         XbshrsG+fEWB6/dMhCk8in4SmLpDYy0wWZ0Rcw2WEvEW4Pno2tVgkBqADGtysU6hrNC2
         1Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnXcKvw24Mkpxrnsn9Jk/2NsGqvskVrKtfbs3H323nA=;
        b=kAkjTN8FMvHgCVhMUJ33Tl8vPuozZD5yxx+tDXh7R4zHkretT4ZiOime8/BoG3xAnT
         P53jaHIrIGOxsc0gzWClti2jcBkm03/L4KC5TNX9UQdmQYkuJWiK4aUPTI7QdLk54Zia
         NBtHq8Nk8CL6zTOA/u36TF+7pCjlH8TG/s+5LGn0K5TAJA9gl1Pf8EmxlsTof9/KtB53
         17i5/f9CRCoE+M12D5P232a4ijs9Ymigt5mKS9eDsge/3YFsVYg4fOfN8eyp+BNXzK+Y
         OeyMPA6AC1vDTFI4bqs2T2cv9LfgxnItSJgQb6KnaqV2aSDo5N/snrfxfYwZ4Kd+sM1S
         fv5w==
X-Gm-Message-State: APjAAAX92dDpzr/o/pPenq0VAffL89CxbAzg1BCB63wUlS20u4V5SR2N
        qzBDxP2I24s0QNRpy6Zy5NkNCg==
X-Google-Smtp-Source: APXvYqxk4ogczT9UUDe68wHpQWglnBtvKn9ruyhCd3jhJInvgSAjwsTSTQtXb9gPlZ2UM0VJE49c9w==
X-Received: by 2002:a62:53:: with SMTP id 80mr7030693pfa.192.1573160020255;
        Thu, 07 Nov 2019 12:53:40 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::3:3792])
        by smtp.gmail.com with ESMTPSA id r11sm2952834pjp.14.2019.11.07.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:53:39 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/3] mm: vmscan: move file exhaustion detection to the node level
Date:   Thu,  7 Nov 2019 12:53:32 -0800
Message-Id: <20191107205334.158354-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107205334.158354-1-hannes@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When file pages are lower than the watermark on a node, we try to
force scan anonymous pages to counter-act the balancing algorithms
preference for new file pages when they are likely thrashing. This is
a node-level decision, but it's currently made each time we look at an
lruvec. This is unnecessarily expensive and also a layering violation
that makes the code harder to understand.

Clean this up by making the check once per node and setting a flag in
the scan_control.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 80 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d97985262dda..e8dd601e1fad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -101,6 +101,9 @@ struct scan_control {
 	/* One of the zones is ready for compaction */
 	unsigned int compaction_ready:1;
 
+	/* The file pages on the current node are dangerously low */
+	unsigned int file_is_tiny:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -2289,45 +2292,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}
 
 	/*
-	 * Prevent the reclaimer from falling into the cache trap: as
-	 * cache pages start out inactive, every cache fault will tip
-	 * the scan balance towards the file LRU.  And as the file LRU
-	 * shrinks, so does the window for rotation from references.
-	 * This means we have a runaway feedback loop where a tiny
-	 * thrashing file LRU becomes infinitely more attractive than
-	 * anon pages.  Try to detect this based on file LRU size.
+	 * If the system is almost out of file pages, force-scan anon.
+	 * But only if there are enough inactive anonymous pages on
+	 * the LRU. Otherwise, the small LRU gets thrashed.
 	 */
-	if (!cgroup_reclaim(sc)) {
-		unsigned long pgdatfile;
-		unsigned long pgdatfree;
-		int z;
-		unsigned long total_high_wmark = 0;
-
-		pgdatfree = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
-		pgdatfile = node_page_state(pgdat, NR_ACTIVE_FILE) +
-			   node_page_state(pgdat, NR_INACTIVE_FILE);
-
-		for (z = 0; z < MAX_NR_ZONES; z++) {
-			struct zone *zone = &pgdat->node_zones[z];
-			if (!managed_zone(zone))
-				continue;
-
-			total_high_wmark += high_wmark_pages(zone);
-		}
-
-		if (unlikely(pgdatfile + pgdatfree <= total_high_wmark)) {
-			/*
-			 * Force SCAN_ANON if there are enough inactive
-			 * anonymous pages on the LRU in eligible zones.
-			 * Otherwise, the small LRU gets thrashed.
-			 */
-			if (!inactive_list_is_low(lruvec, false, sc, false) &&
-			    lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, sc->reclaim_idx)
-					>> sc->priority) {
-				scan_balance = SCAN_ANON;
-				goto out;
-			}
-		}
+	if (sc->file_is_tiny &&
+	    !inactive_list_is_low(lruvec, false, sc, false) &&
+	    lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
+			    sc->reclaim_idx) >> sc->priority) {
+		scan_balance = SCAN_ANON;
+		goto out;
 	}
 
 	/*
@@ -2754,6 +2728,36 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
+	/*
+	 * Prevent the reclaimer from falling into the cache trap: as
+	 * cache pages start out inactive, every cache fault will tip
+	 * the scan balance towards the file LRU.  And as the file LRU
+	 * shrinks, so does the window for rotation from references.
+	 * This means we have a runaway feedback loop where a tiny
+	 * thrashing file LRU becomes infinitely more attractive than
+	 * anon pages.  Try to detect this based on file LRU size.
+	 */
+	if (!cgroup_reclaim(sc)) {
+		unsigned long file;
+		unsigned long free;
+		int z;
+		unsigned long total_high_wmark = 0;
+
+		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
+		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
+			   node_page_state(pgdat, NR_INACTIVE_FILE);
+
+		for (z = 0; z < MAX_NR_ZONES; z++) {
+			struct zone *zone = &pgdat->node_zones[z];
+			if (!managed_zone(zone))
+				continue;
+
+			total_high_wmark += high_wmark_pages(zone);
+		}
+
+		sc->file_is_tiny = file + free <= total_high_wmark;
+	}
+
 	shrink_node_memcgs(pgdat, sc);
 
 	if (reclaim_state) {
-- 
2.24.0

