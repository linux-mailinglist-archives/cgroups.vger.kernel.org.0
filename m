Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942344E45E5
	for <lists+cgroups@lfdr.de>; Tue, 22 Mar 2022 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiCVSY4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Mar 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiCVSYz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Mar 2022 14:24:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CC1E3F2;
        Tue, 22 Mar 2022 11:23:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8818210E9;
        Tue, 22 Mar 2022 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647973391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jKxuo3tSnTqh2UAPL1+VAIp6n+IcAR/qJqwZEPA/Ep0=;
        b=pejEAflbD21zArvB8wKtKlgVaGQeoKrHBbjaNQ+yMhdLHxpcZ5nSjgpEPiuPF3IwpPCuTN
        kdOtpj5t1Kj+d0NpiDAtZwrchSIQpMrEws2qmz681mePvSYG9jyO1PXoABxfa1eApIX/gQ
        v3p8YpFlcSdFbFKNVSoUFV6FpkRp080=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AF82133B6;
        Tue, 22 Mar 2022 18:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sIFvAQ8UOmLwGwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 22 Mar 2022 18:23:11 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Subject: [RFC PATCH] mm: memcg: Do not count memory.low reclaim if it does not happen
Date:   Tue, 22 Mar 2022 19:22:48 +0100
Message-Id: <20220322182248.29121-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This was observed with memcontrol selftest/new LTP test but can be also
reproduced in simplified setup of two siblings:

	`parent .low=50M
	  ` s1	.low=50M  .current=50M+ε
	  ` s2  .low=0M   .current=50M

The expectation is that s2/memory.events:low will be zero under outer
reclaimer since no protection should be given to cgroup s2 (even with
memory_recursiveprot).

However, this does not happen. The apparent reason is that when s1 is
considered for (proportional) reclaim the scanned proportion is rounded
up to SWAP_CLUSTER_MAX and slightly over-proportional amount is
reclaimed. Consequently, when the effective low value of s2 is
calculated, it observes unclaimed parent's protection from s1
(ε-SWAP_CLUSTER_MAX in theory) and effectively appropriates it.
The effect is slightly regularized protection (workload dependent)
between siblings and misreported MEMCG_LOW event when reclaiming s2 with
this protection.

Fix the behavior by not reporting breached memory.low in such
situations. (This affects also setups where all siblings have
memory.low=0, parent's memory.events:low will still be non-zero when
parent's memory.low is breached but it will be reduced by the events
originated in children.)

Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
Link: https://lore.kernel.org/all/20220321101429.3703-1-rpalethorpe@suse.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/memcontrol.h | 8 ++++----
 mm/vmscan.c                | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

Why is this RFC?

1) It changes number of events observed on parent/memory.events:low (especially
   for truly recursive configs where all children specify memory.low=0).
   IIUC past discussions about equality of all-zeros and all-infinities, those
   eagerly reported MEMCG_LOW events (in latter case) were deemed skewing the
   stats [1].
2) The observed behavior slightly impacts distribution of parent's memory.low. 
   Constructed example is a passive protected workload in s1 and active in s2
   (active ~ counteracts the reclaim with allocations). It could strip
   protection from s1 one by one (one:=SWAP_CLUSTER_MAX/2^sc.priority).
   That may be considered both wrong (s1 should have been more protected) or
   correct s2 deserves protection due to its activity.
   I don't have (didn't collect) data for this, so I think just masking the
   false events is sufficient (or independent).

[1] https://lore.kernel.org/r/20200221185839.GB70967@cmpxchg.org

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0abbd685703b..99ac72e00bff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -626,13 +626,13 @@ static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
 
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg, bool effective)
 {
 	if (!mem_cgroup_supports_protection(memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+	return page_counter_read(&memcg->memory) <= (effective ?
+		READ_ONCE(memcg->memory.elow) :	READ_ONCE(memcg->memory.low));
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
@@ -1177,7 +1177,7 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg, bool effective)
 {
 	return false;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b14e0d696c..3bdb35d6bee6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3152,7 +3152,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		} else if (mem_cgroup_below_low(memcg)) {
+		} else if (mem_cgroup_below_low(memcg, true)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
@@ -3163,7 +3163,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				sc->memcg_low_skipped = 1;
 				continue;
 			}
-			memcg_memory_event(memcg, MEMCG_LOW);
+			if (mem_cgroup_below_low(memcg, false))
+				memcg_memory_event(memcg, MEMCG_LOW);
 		}
 
 		reclaimed = sc->nr_reclaimed;
-- 
2.35.1

