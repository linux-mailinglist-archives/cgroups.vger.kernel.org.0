Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA831E199
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhBQVpC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 16:45:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:37244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhBQVo5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 16:44:57 -0500
IronPort-SDR: Uek8OnRX3Wosq9yzC5fgEvZLbBTlDivE6tg7JJB9nUIime4RVTVlGpLfdM9opLU/sUlWIDrtRC
 wmlRUzTEPtOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182538765"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="182538765"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 13:41:57 -0800
IronPort-SDR: fyXWGY+qTbQbuVmeCtCGViaNOmO5KLB9GCktnf6sqEPS4OOLdfqg8pm8qyxyXHVzxofdAq+crC
 i8lmAP2b6Ivw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="401430721"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2021 13:41:57 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
Date:   Wed, 17 Feb 2021 12:41:36 -0800
Message-Id: <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1613584277.git.tim.c.chen@linux.intel.com>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On a per node basis, the mem cgroup soft limit tree on each node tracks
how much a cgroup has exceeded its soft limit memory limit and sorts
the cgroup by its excess usage.  On page release, the trees are not
updated right away, until we have gathered a batch of pages belonging to
the same cgroup. This reduces the frequency of updating the soft limit tree
and locking of the tree and associated cgroup.

However, the batch of pages could contain pages from multiple nodes but
only the soft limit tree from one node would get updated.  Change the
logic so that we update the tree in batch of pages, with each batch of
pages all in the same mem cgroup and memory node.  An update is issued for
the batch of pages of a node collected till now whenever we encounter
a page belonging to a different node.  Note that this batching for
the same node logic is only relevant for v1 cgroup that has a memory
soft limit.

Reviewed-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d72449eeb85a..8bddee75f5cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6804,6 +6804,7 @@ struct uncharge_gather {
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
 	struct page *dummy_page;
+	int nid;
 };
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
@@ -6849,7 +6850,13 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	 * exclusive access to the page.
 	 */
 
-	if (ug->memcg != page_memcg(page)) {
+	if (ug->memcg != page_memcg(page) ||
+	    /*
+	     * Update soft limit tree used in v1 cgroup in page batch for
+	     * the same node. Relevant only to v1 cgroup with a soft limit.
+	     */
+	    (ug->dummy_page && ug->nid != page_to_nid(page) &&
+	     ug->memcg->soft_limit != PAGE_COUNTER_MAX)) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
@@ -6869,6 +6876,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 		ug->pgpgout++;
 
 	ug->dummy_page = page;
+	ug->nid = page_to_nid(page);
 	page->memcg_data = 0;
 	css_put(&ug->memcg->css);
 }
-- 
2.20.1

