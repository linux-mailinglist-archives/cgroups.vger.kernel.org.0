Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C936FE06B2
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJVOsQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40303 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOsP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so19315998qta.7
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFBKqmL/4fnTvQgxpmecsW4xlCLftKHwTd8yhraPD9Y=;
        b=po3EgEl1Mfcj8YgbJhdpnDMRmpW8tzAaBeWPxhTAU12MmtccZL11JGUkwiGCxgb3xA
         QjdEo7R/vlHoX3wx55XWp85atLxaGk+SyRuTtJRtL93CNS+tRpuJrui+/9PKaa7yN3ii
         JLNR+sQ8cffNhgL+fm6oIOASPG2kRusL/cs1itJ4EqXdId40uJ9ocUAIThgUAPxylvbj
         MObUpe5nqGUYyuW0YRa7+wCtibgztGJg5dkHeW5ZpttdFZ1zN86nHgyeiLiVBtPJvEU2
         rNzOnZd29An6Kf7sEkGGYMYqrq9BBDH/jts3v2801jiVF9o7199dTnfCZ1scCLknemwz
         ViqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFBKqmL/4fnTvQgxpmecsW4xlCLftKHwTd8yhraPD9Y=;
        b=ci0Hi6Vzbe7QM6zB6q3Y/cpltSAKXjnRY0XFBZolbzgkt+BnGZtHxkikl7gWJsb6RF
         wBBDl3wBpuOoaIt+PvXVE3o0Ri9OuPzPWftSf++7P1EuF3NobvyJ3Jp8xKsFnA3CQFQC
         Jig4/iYjmW4JED8yqr7Tf9mbnNF1fmtmv8mVITl0bHzC+81Unm+5ChUQlYDHkpruQ45H
         2YUGG5sJ1vfuPgBaREdbFgkPq/Vsdl2EpnRuCB6v8kEhFpAoL2fR7p7m3f63V4uFmb/I
         kXqDuOZ0wt5h83b14YUoJjIcEDeV4dCANPS4du5TNh8eG8MSsTewZHVD9ZPwazgsb+eM
         WciQ==
X-Gm-Message-State: APjAAAXUftqkRZGoWWPQwTOoIvzojX/IhO0zdMMyEgBYs+qczROCY/zZ
        EwWjsvCSSAfGtL3ne6iIB0KRSbLnYDo=
X-Google-Smtp-Source: APXvYqy986Sb7waIgJjeFtAwugsVpL846YOA+EY68E+Fbe+rKmh3XrhkBV/xTbPGtzHtIcBkSwwq1w==
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr3679282qts.56.1571755694979;
        Tue, 22 Oct 2019 07:48:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id m186sm9298409qkd.119.2019.10.22.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Date:   Tue, 22 Oct 2019 10:47:56 -0400
Message-Id: <20191022144803.302233-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function currently takes the node or lruvec size and subtracts
the zones that are excluded by the classzone index of the
allocation. It uses four different types of counters to do this.

Just add up the eligible zones.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1154b3a2b637..57f533b808f2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -351,32 +351,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  */
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
-	unsigned long lru_size = 0;
+	unsigned long size = 0;
 	int zid;
 
-	if (!mem_cgroup_disabled()) {
-		for (zid = 0; zid < MAX_NR_ZONES; zid++)
-			lru_size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
-	} else
-		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
-
-	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
+	for (zid = 0; zid <= zone_idx; zid++) {
 		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
-		unsigned long size;
 
 		if (!managed_zone(zone))
 			continue;
 
 		if (!mem_cgroup_disabled())
-			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
+			size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
 		else
-			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
-				       NR_ZONE_LRU_BASE + lru);
-		lru_size -= min(size, lru_size);
+			size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
 	}
-
-	return lru_size;
-
+	return size;
 }
 
 /*
-- 
2.23.0

