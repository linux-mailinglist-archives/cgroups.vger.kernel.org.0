Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404B0E06B5
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfJVOsT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbfJVOsS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so27107568qtj.12
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6d0e71c1U6ZW8RKPMSK80x36zGerojsdp9LXPgfjJI=;
        b=mxq29U7KFf8nIL2EPYKGYZG3PSPLfnfyyUP3N9kMMBJep9Noe7BqgaM7RFDkI//avH
         +lWfp9sEakhlXGJS7YoZspH/bCa783BlFJaZLulfx06SkaVO6nseVrPLlE02uM46F5BT
         aXX+S5xo0gm2UsAhO2A+VmjIUQsL1r/v4PvaaiE2y1ld5cy0y2xidgDz/jYugGswM5YV
         XXV8qKlJgxAtFWHtk1MlF7jqqYsu3cW2zhBUYJ9MJyMxm8kVj4CL23AeGxB9bcLq1Cws
         cSqoKgFqCMpFHjtqd2m7RkiZsKaft0d6fZFpH0OP4v5ikJ/CxQXmt9q7gy7W0QOWLeLy
         G68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6d0e71c1U6ZW8RKPMSK80x36zGerojsdp9LXPgfjJI=;
        b=MNape2vx1W5O0iBnK4simfdqgdak94D0hu20buZc4y1b2ZfMVY2FOy4fw7axsg9xZc
         G4u2FZHBCODGLvj7keQMuOxU8oQDraRom9p43DQE2Jts1RgoUAj2JI2QEhyIFvaDYlQN
         D3ph0q6XM2XyguVJaVfyqglqLJ7chTWM+Bq/w4zRCQrjObQl/FGUw9XEC+MvKW0z9qNo
         nEgNon9tk8immy3vq/w5iiQr58Z5GHAwFTJv68wwmQ6i9zeYSa5ymwoDw290xk1lWC1P
         VbRTIIbQllJT0O7+If3Sft+aGgLWZual2GJgeuqaAFCH3CDcgJ3ovajRKmJfWO2zVvDd
         +iug==
X-Gm-Message-State: APjAAAUXnCSvwD2dUoBtR0fHEr1w8LcTsooAbyEpGZTDCiETvIjxJNSC
        0osmy3Hsx7Mjf2lO+jVz0hfSY+3aaf0=
X-Google-Smtp-Source: APXvYqxLvuowjOIIcKYn75H2RxPI6SfUMcvB5TDKG/Hu0VfyuATYs1IGLTNo2b4pr6S1lKK5e7BkVg==
X-Received: by 2002:ac8:6146:: with SMTP id d6mr3741857qtm.271.1571755697749;
        Tue, 22 Oct 2019 07:48:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id p4sm10518531qkf.112.2019.10.22.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:17 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/8] mm: vmscan: move inactive_list_is_low() swap check to the caller
Date:   Tue, 22 Oct 2019 10:47:58 -0400
Message-Id: <20191022144803.302233-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

inactive_list_is_low() should be about one thing: checking the ratio
between inactive and active list. Kitchensink checks like the one for
swap space makes the function hard to use and modify its
callsites. Luckly, most callers already have an understanding of the
swap situation, so it's easy to clean up.

get_scan_count() has its own, memcg-aware swap check, and doesn't even
get to the inactive_list_is_low() check on the anon list when there is
no swap space available.

shrink_list() is called on the results of get_scan_count(), so that
check is redundant too.

age_active_anon() has its own totalswap_pages check right before it
checks the list proportions.

The shrink_node_memcg() site is the only one that doesn't do its own
swap check. Add it there.

Then delete the swap check from inactive_list_is_low().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index be3c22c274c1..622b77488144 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2226,13 +2226,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	unsigned long refaults;
 	unsigned long gb;
 
-	/*
-	 * If we don't have swap space, anonymous page deactivation
-	 * is pointless.
-	 */
-	if (!file && !total_swap_pages)
-		return false;
-
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
 	active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
 
@@ -2653,7 +2646,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (inactive_list_is_low(lruvec, false, sc, true))
+	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
-- 
2.23.0

