Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8931591C
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhBIWHe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 17:07:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:8467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233378AbhBIWFO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:14 -0500
IronPort-SDR: rHJ2ugH56T2qKz4IS2f85pPrjGuy3YpYd+6jJtDb5SznAWjkr92tidvNPsvUK2EZhuifWei2aX
 Rs40/o4icssQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161113152"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161113152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:30:37 -0800
IronPort-SDR: ntxFtm3gbYXN9YZW0jDW+P93csodkdqLTeOygb9DELVS/54Q5IXqSoho4FE39fWWsA4tGeFxqB
 6mFZv6L04ljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361953036"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 13:30:37 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: Fix missing mem cgroup soft limit tree updates
Date:   Tue,  9 Feb 2021 12:29:47 -0800
Message-Id: <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1612902157.git.tim.c.chen@linux.intel.com>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
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
a page belonging to a different node.

Reviewed-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d72449eeb85a..f5a4a0e4e2ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6804,6 +6804,7 @@ struct uncharge_gather {
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
 	struct page *dummy_page;
+	int nid;
 };
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
@@ -6849,7 +6850,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	 * exclusive access to the page.
 	 */
 
-	if (ug->memcg != page_memcg(page)) {
+	if (ug->memcg != page_memcg(page) ||
+	    /* uncharge batch update soft limit tree on a node basis */
+	    (ug->dummy_page && ug->nid != page_to_nid(page))) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
@@ -6869,6 +6872,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 		ug->pgpgout++;
 
 	ug->dummy_page = page;
+	ug->nid = page_to_nid(page);
 	page->memcg_data = 0;
 	css_put(&ug->memcg->css);
 }
-- 
2.20.1

