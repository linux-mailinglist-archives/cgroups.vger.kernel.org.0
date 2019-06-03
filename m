Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B790633A7D
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2019 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCV67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 17:58:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33954 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCV66 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 17:58:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so2584198pfc.1
        for <cgroups@vger.kernel.org>; Mon, 03 Jun 2019 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW9XEaleHf0fxFzrzaLu3/5nxBFHbI/f8wU4NVTruL4=;
        b=GiZl3I0/1nrhXFLsEYVx8i8I4at3od658KebcT8wvAtJDzTnhyqemuN29q2/fcr3KW
         tDsgy9TzZFg8DTfH/bgCfQ9DMl4vc7J4plUg5mA9cty9aXI8rxvDidvnbUu121RWDy3r
         e1RxDwqqABcmlJXwZaGPTzP0keY1G2zSdow7H3XEkR3F49wcmjR9HuHqyQb5DFvxXdrE
         L+ebT5LxPIX7aGWwOApYSGaixnBATTA3AvWr+WjSjHJsz0lxIbyDxEPuHK3xJkUAPctk
         yP5msqE7q+xLnKa1SZBpeRAnKA5wg+rgZtDOy4sVffJyMyZx1w3RUzvp12AR2PMSm3mf
         jkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW9XEaleHf0fxFzrzaLu3/5nxBFHbI/f8wU4NVTruL4=;
        b=SgvVbuinVEjj3EfdmFGepcfhv/gYyEBL9jMcbXUVeC0ARneDJ0AP1Md/AKl5A1KFLh
         oEXdWqk7TzzyKEnjEH+frhKrv6cEk/4Tv/Bo/4PysA55zORnpBVLgTXF37xCE2ZZxCJa
         JzMRsQwE3LEoq8Jobt1cyuNJ4zSSF9eHOAezkOoZ6phIRCUAON7I42EyS0SqrM/Rb014
         fwLUo2hXlV3P/HZUwee07iH/U5zDn+oiVcSTrxe821x90bcqHqQc8bfPyx28zQkRx1vu
         JVRl4VJILhlkbKmGWr6r68vULJ/VaRlT/f1tcJsBN0tYC+otzcpnv0Ktq+bVFE6kt9Sl
         dGkg==
X-Gm-Message-State: APjAAAWj5dbC5XsDp/qp+G1iACCBZfaC9d56k/+zlsnHohNwW1H1VFrH
        MyoTBzj2vr1ZizRwWq7s6tZ6lsPgHR8=
X-Google-Smtp-Source: APXvYqxRKIe7ZlIxfiZR5KZpvX0iyzwEdC5f5c2JCVHHT7fr7Ha6rZsuX4a/y9QMM1RAzJK5pY+vwA==
X-Received: by 2002:a17:90a:30a1:: with SMTP id h30mr33354770pjb.14.1559596109171;
        Mon, 03 Jun 2019 14:08:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id p18sm3454267pff.93.2019.06.03.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:28 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 03/11] mm: vmscan: simplify lruvec_lru_size()
Date:   Mon,  3 Jun 2019 17:07:38 -0400
Message-Id: <20190603210746.15800-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
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
 mm/vmscan.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 853be16ee5e2..69c4c82a9b5a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -342,30 +342,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  */
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
-	unsigned long lru_size;
+	unsigned long size = 0;
 	int zid;
 
-	if (!mem_cgroup_disabled())
-		lru_size = lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
-	else
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
+	return size;
 
 }
 
-- 
2.21.0

