Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054AFE01F3
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfJVKV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 06:21:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbfJVKV2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 22 Oct 2019 06:21:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70F64AE00;
        Tue, 22 Oct 2019 10:21:24 +0000 (UTC)
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
 <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
 <20190910132418.GC2063@dhcp22.suse.cz>
 <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
 <2fe81a9e-5d29-79cf-f747-c66ae35defd0@profihost.ag>
 <4f6f1bc9-08f4-d53a-8788-a761be769757@suse.cz>
 <76ad5b29-815b-3d87-cefa-ec5b222279f1@profihost.ag>
 <b82b9fcb-fa64-c36c-5ef5-cb2e4d64a51a@suse.cz>
 <1430bb64-ef9b-f6a1-fb2c-1ca351e7950e@profihost.ag>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f533e547-996d-5a05-5b25-92862c8f9057@suse.cz>
Date:   Tue, 22 Oct 2019 12:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1430bb64-ef9b-f6a1-fb2c-1ca351e7950e@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/22/19 12:02 PM, Stefan Priebe - Profihost AG wrote:
> 
> Am 22.10.19 um 09:48 schrieb Vlastimil Babka:
>> On 10/22/19 9:41 AM, Stefan Priebe - Profihost AG wrote:
>>>> Hi, could you try the patch below? I suspect you're hitting a corner
>>>> case where compaction_suitable() returns COMPACT_SKIPPED for the
>>>> ZONE_DMA, triggering reclaim even if other zones have plenty of free
>>>> memory. And should_continue_reclaim() then returns true until twice the
>>>> requested page size is reclaimed (compact_gap()). That means 4MB
>>>> reclaimed for each THP allocation attempt, which roughly matches the
>>>> trace data you preovided previously.
>>>>
>>>> The amplification to 4MB should be removed in patches merged for 5.4, so
>>>> it would be only 32 pages reclaimed per THP allocation. The patch below
>>>> tries to remove this corner case completely, and it should be more
>>>> visible on your 5.2.x, so please apply it there.
>>>>
>>> is there any reason to not apply that one on top of 4.19?
>>>
>>> Greets,
>>> Stefan
>>>
>>
>> It should work, cherrypicks fine without conflict here.
> 
> OK but does not work ;-)
> 
> 
> mm/compaction.c: In function '__compaction_suitable':
> mm/compaction.c:1451:19: error: implicit declaration of function
> 'zone_managed_pages'; did you mean 'node_spanned_pages'?
> [-Werror=implicit-function-declaration]
>       alloc_flags, zone_managed_pages(zone)))
>                    ^~~~~~~~~~~~~~~~~~
>                    node_spanned_pages

Ah, this?

----8<----
From f1335e1c0d4b74205fc0cc40b5960223d6f1dec7 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 12 Sep 2019 13:40:46 +0200
Subject: [PATCH] WIP

---
 include/linux/compaction.h     |  7 ++++++-
 include/trace/events/mmflags.h |  1 +
 mm/compaction.c                | 16 +++++++++++++--
 mm/vmscan.c                    | 36 ++++++++++++++++++++++++----------
 4 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 68250a57aace..2f3b331c5239 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -17,8 +17,13 @@ enum compact_priority {
 };
 
 /* Return values for compact_zone() and try_to_compact_pages() */
-/* When adding new states, please adjust include/trace/events/compaction.h */
+/* When adding new states, please adjust include/trace/events/mmflags.h */
 enum compact_result {
+	/*
+	 * The zone is too small to provide the requested allocation even if
+	 * fully freed (i.e. ZONE_DMA for THP allocation due to lowmem reserves)
+	 */
+	COMPACT_IMPOSSIBLE,
 	/* For more detailed tracepoint output - internal to compaction */
 	COMPACT_NOT_SUITABLE_ZONE,
 	/*
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a81cffb76d89..d7aa9cece234 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -169,6 +169,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 
 #ifdef CONFIG_COMPACTION
 #define COMPACTION_STATUS					\
+	EM( COMPACT_IMPOSSIBLE,		"impossible")		\
 	EM( COMPACT_SKIPPED,		"skipped")		\
 	EM( COMPACT_DEFERRED,		"deferred")		\
 	EM( COMPACT_CONTINUE,		"continue")		\
diff --git a/mm/compaction.c b/mm/compaction.c
index 5079ddbec8f9..7d2299c7faa2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1416,6 +1416,7 @@ static enum compact_result compact_finished(struct zone *zone,
 /*
  * compaction_suitable: Is this suitable to run compaction on this zone now?
  * Returns
+ *   COMPACT_IMPOSSIBLE If the allocation would fail even with all pages free
  *   COMPACT_SKIPPED  - If there are too few free pages for compaction
  *   COMPACT_SUCCESS  - If the allocation would succeed without compaction
  *   COMPACT_CONTINUE - If compaction should run now
@@ -1439,6 +1440,16 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 								alloc_flags))
 		return COMPACT_SUCCESS;
 
+	/*
+	 * If the allocation would not succeed even with a fully free zone
+	 * due to e.g. lowmem reserves, indicate that compaction can't possibly
+	 * help and it would be pointless to reclaim.
+	 */
+	watermark += 1UL << order;
+	if (!__zone_watermark_ok(zone, 0, watermark, classzone_idx,
+				 alloc_flags, zone->managed_pages))
+		return COMPACT_IMPOSSIBLE;
+
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
@@ -1526,7 +1537,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
 				ac_classzone_idx(ac), available);
-		if (compact_result != COMPACT_SKIPPED)
+		if (compact_result > COMPACT_SKIPPED)
 			return true;
 	}
 
@@ -1555,7 +1566,8 @@ static enum compact_result compact_zone(struct zone *zone, struct compact_contro
 	ret = compaction_suitable(zone, cc->order, cc->alloc_flags,
 							cc->classzone_idx);
 	/* Compaction is likely to fail */
-	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
+	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED
+	    || ret == COMPACT_IMPOSSIBLE)
 		return ret;
 
 	/* huh, compaction_suitable is returning something unexpected */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b37610c0eac6..7ad331a64fc5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2849,11 +2849,12 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 }
 
 /*
- * Returns true if compaction should go ahead for a costly-order request, or
- * the allocation would already succeed without compaction. Return false if we
- * should reclaim first.
+ * Returns 1 if compaction should go ahead for a costly-order request, or the
+ * allocation would already succeed without compaction. Return 0 if we should
+ * reclaim first. Return -1 when compaction can't help at all due to zone being
+ * too small, which means there's no point in reclaim nor compaction.
  */
-static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
+static inline int compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
 	enum compact_result suitable;
@@ -2861,10 +2862,16 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
-		return true;
+		return 1;
 	if (suitable == COMPACT_SKIPPED)
 		/* Compaction cannot yet proceed. Do reclaim. */
-		return false;
+		return 0;
+	if (suitable == COMPACT_IMPOSSIBLE)
+		/*
+		 * Compaction can't possibly help. So don't reclaim, but keep
+		 * checking other zones.
+		 */
+		return -1;
 
 	/*
 	 * Compaction is already possible, but it takes time to run and there
@@ -2910,6 +2917,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					sc->reclaim_idx, sc->nodemask) {
+		int compact_ready;
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -2929,10 +2937,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			 * page allocations.
 			 */
 			if (IS_ENABLED(CONFIG_COMPACTION) &&
-			    sc->order > PAGE_ALLOC_COSTLY_ORDER &&
-			    compaction_ready(zone, sc)) {
-				sc->compaction_ready = true;
-				continue;
+			    sc->order > PAGE_ALLOC_COSTLY_ORDER) {
+				compact_ready = compaction_ready(zone, sc);
+				if (compact_ready == 1) {
+					sc->compaction_ready = true;
+					continue;
+				} else if (compact_ready == -1) {
+					/*
+					 * In this zone, neither reclaim nor
+					 * compaction can help.
+					 */
+					continue;
+				}
 			}
 
 			/*
-- 
2.23.0


