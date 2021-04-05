Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9B35469E
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhDESJ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:44462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233591AbhDESJY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:24 -0400
IronPort-SDR: itjVrzsHGiG58wlhJJsdAXxm/sGrIz87Wx378Z5FMzvURmOZEqMNTDJzGOJYGI+LdPtsIqfbeE
 fECNPUs6Bn5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010994"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010994"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:17 -0700
IronPort-SDR: Z2d3PhVq6ZdULJ11AoNx+8S2Kcbx3ybsA+3K/PIxzUJNYVASRhxqILbG3I8X2iZHEYMANSa1fu
 Bl97Vua6IcsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153974"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:17 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 11/11] mm: Wakeup kswapd if toptier memory need soft reclaim
Date:   Mon,  5 Apr 2021 10:08:35 -0700
Message-Id: <9d6b4eff73aef26fff3ecfbfc0693b84309d8b4c.1617642418.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Detect during page allocation whether free toptier memory is low.
If so, wake up kswapd to reclaim memory from those mem cgroups
that have exceeded their limit.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 2 ++
 mm/vmscan.c            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 789319dffe1c..3603948e95cc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -886,6 +886,8 @@ bool zone_watermark_ok(struct zone *z, unsigned int order,
 		unsigned int alloc_flags);
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 		unsigned long mark, int highest_zoneidx);
+bool pgdat_toptier_balanced(pg_data_t *pgdat, int order, int classzone_idx);
+
 /*
  * Memory initialization context, use to differentiate memory added by
  * the platform statically or via memory hotplug interface.
@@ -1466,5 +1468,6 @@ void sparse_init(void);
 #endif
 
 #endif /* !__GENERATING_BOUNDS.H */
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _LINUX_MMZONE_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91212a837d8e..ca8aa789a967 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3519,6 +3519,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+	} else if (!pgdat_toptier_balanced(zone->zone_pgdat, order, zone_idx(zone))) {
+		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
 	}
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 270880c8baef..8fe709e3f5e4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3625,7 +3625,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	return false;
 }
 
-static bool pgdat_toptier_balanced(pg_data_t *pgdat, int order, int classzone_idx)
+bool pgdat_toptier_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 {
 	int i;
 	unsigned long mark;
-- 
2.20.1

