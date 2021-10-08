Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12B4266B5
	for <lists+cgroups@lfdr.de>; Fri,  8 Oct 2021 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhJHJ0W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Oct 2021 05:26:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:50470 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236195AbhJHJ0V (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 8 Oct 2021 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=BI1fdFpITncugnI8ZOhVcndov2suSbcgpwHQSA5zss0=; b=iSABWY+WWWhoqDCrxQC
        nB38taiVHhY686asLMwJQ4di0B+mUTrr288WyjGCl9ynJipevi7RY3SuBjRNjmNCLTlUj8mSE4ljD
        tQofyyvZhYa9lprVxChFOb4X+uFXhRoedlxKklPCAF/7NIpb/kdKl6V804E/sf2OLIncHyrVjYg=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mYm76-005QDp-IB; Fri, 08 Oct 2021 12:24:24 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
Date:   Fri, 8 Oct 2021 12:24:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__alloc_pages_bulk can call __count_zid_vm_events and zone_statistics
with nr_account = 0.

Fixes: 3e23060b2d0b ("mm/page_alloc: batch the accounting updates in the bulk allocator")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 602819a232e5..e67113452ee8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5364,9 +5364,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	}
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
-
-	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	if (nr_account) {
+		__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+		zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	}
 	if (objcg)
 		memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
 
-- 
2.31.1

