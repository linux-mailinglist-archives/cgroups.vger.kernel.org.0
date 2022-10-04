Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23E5F4CA6
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 01:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJDXe7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 19:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJDXe5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 19:34:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7869AA1AA
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 16:34:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z7-20020a170903018700b0017835863686so11198904plg.11
        for <cgroups@vger.kernel.org>; Tue, 04 Oct 2022 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=1VwEyudEEg4smBY+MKZJWdKtquNfzB47uQiiqV8iKco=;
        b=NTnSd9KVV9hSY/eQWHkPHqQELNcIlqXK5hsxw8/MyexBmo1bKCndxFIWE0/C+FZmFI
         b11BypLFppC7UdyHn8rthfOwwJjqsgCrxnuD6cNd+0+xrH0d1+/k+Nwtr8TSQ2EUsCug
         OVYko2zetdkm1pM9AxqEGmEwKzORdSEW9qqgBCsaCQmp4G2ucgjqRP6zktn3MQ5b4kz/
         Lrq/ORYH0cFTXNOMop7YlY3ty97eccT7Xhy5HKM4jlo1ipvycIUlJc3uUcds3eWwEWQP
         6JXQb0c9AO4n177s6Rz0uP11zUUDZSknUhSW3b7sBMw3MxcoFPVumzPz6OBwo4IP5hqL
         Bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1VwEyudEEg4smBY+MKZJWdKtquNfzB47uQiiqV8iKco=;
        b=uOkgmyDPY9eQRfNqYcjM8W4wcnlhIpuN+fPykx6i+bFtcW/CFIIsGV2ltIxECPzuKF
         TrHqLM9nhwroQ3Gqf6Ob8YrWE13HktGnE5iM3kq6qqzbI1sXxalrJ3q9AQv/gvJ79Aia
         j9aUfULmjC4SLmfAzA6Zwo8o/oq+4ZOdqsbpXt9dyaiITGJsHuvr6l9K4FuDDq99LY0A
         v/nNaEF5lxO7ZuiYIV46/IIoTk0sTqFJJrexsznpKBwsii4W9yJ4oGZ/0gqWk+h0oktH
         96Niz4EqHoaxbZvVvA/2JcSHsFQUqqTOdDjZupttBfC2+0KLTKYLy5dJBElk50dvncka
         BC3A==
X-Gm-Message-State: ACrzQf1cZ6gEOeSoYPuuKD+RIIsSVTD6oNI5+XDoMusxW+Bu48TDz7Jr
        7rYQJ1vB/Txnby3WhWshXhB2PWqoTe0I9BFS
X-Google-Smtp-Source: AMsMyM7G2avoH6qtf6yI3RrR3LpogE6JnX6Z1xf+0wvpymlSTnAYLsRP24LicTX48tUJpOueGYCpPRPrkAvAMZ7b
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP
 id w6-20020a17090ac98600b00205f08ca82bmr438572pjt.1.1664926493371; Tue, 04
 Oct 2022 16:34:53 -0700 (PDT)
Date:   Tue,  4 Oct 2022 23:34:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004233446.787056-1-yosryahmed@google.com>
Subject: [PATCH] mm/vmscan: check references from all memcgs for swapbacked memory
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During page/folio reclaim, we check folio is referenced using
folio_referenced() to avoid reclaiming folios that have been recently
accessed (hot memory). The ratinale is that this memory is likely to be
accessed soon, and hence reclaiming it will cause a refault.

For memcg reclaim, we pass in sc->target_mem_cgroup to
folio_referenced(), which means we only check accesses to the folio
from processes in the subtree of the target memcg. This behavior was
originally introduced by commit bed7161a519a ("Memory controller: make
page_referenced() cgroup aware") a long time ago. Back then, refaulted
pages would get charged to the memcg of the process that was faulting them
in. It made sense to only consider accesses coming from processes in the
subtree of target_mem_cgroup. If a page was charged to memcg A but only
being accessed by a sibling memcg B, we would reclaim it if memcg A is
under pressure. memcg B can then fault it back in and get charged for it
appropriately.

Today, this behavior still makes sense for file pages. However, unlike
file pages, when swapbacked pages are refaulted they are charged to the
memcg that was originally charged for them during swapout. Which
means that if a swapbacked page is charged to memcg A but only used by
memcg B, and we reclaim it when memcg A is under pressure, it would
simply be faulted back in and charged again to memcg A once memcg B
accesses it. In that sense, accesses from all memcgs matter equally when
considering if a swapbacked page/folio is a viable reclaim target.

Add folio_referenced_memcg() which decides what memcg we should pass to
folio_referenced() based on the folio type, and includes an elaborate
comment about why we should do so. This should help reclaim make better
decision and reduce refaults when reclaiming swapbacked memory that is
used by multiple memcgs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c5a4bff11da6..f9fa0f9287e5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1443,14 +1443,43 @@ enum folio_references {
 	FOLIOREF_ACTIVATE,
 };
 
+/* What memcg should we pass to folio_referenced()? */
+static struct mem_cgroup *folio_referenced_memcg(struct folio *folio,
+						 struct mem_cgroup *target_memcg)
+{
+	/*
+	 * We check references to folios to make sure we don't reclaim hot
+	 * folios that are likely to be refaulted soon. We pass a memcg to
+	 * folio_referenced() to only check references coming from processes in
+	 * that memcg's subtree.
+	 *
+	 * For file folios, we only consider references from processes in the
+	 * subtree of the target memcg. If a folio is charged to
+	 * memcg A but is only referenced by processes in memcg B, we reclaim it
+	 * if memcg A is under pressure. If it is later accessed by memcg B it
+	 * will be faulted back in and charged to memcg B. For memcg A, this is
+	 * called memory that should be reclaimed.
+	 *
+	 * On the other hand, when swapbacked folios are faulted in, they get
+	 * charged to the memcg that was originally charged for them at the time
+	 * of swapping out. This means that if a folio that is charged to
+	 * memcg A gets swapped out, it will get charged back to A when *any*
+	 * memcg accesses it. In that sense, we need to consider references from
+	 * *all* processes when considering whether to reclaim a swapbacked
+	 * folio.
+	 */
+	return folio_test_swapbacked(folio) ? NULL : target_memcg;
+}
+
 static enum folio_references folio_check_references(struct folio *folio,
 						  struct scan_control *sc)
 {
 	int referenced_ptes, referenced_folio;
 	unsigned long vm_flags;
+	struct mem_cgroup *memcg = folio_referenced_memcg(folio,
+						sc->target_mem_cgroup);
 
-	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
-					   &vm_flags);
+	referenced_ptes = folio_referenced(folio, 1, memcg, &vm_flags);
 	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
@@ -2581,6 +2610,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	while (!list_empty(&l_hold)) {
 		struct folio *folio;
+		struct mem_cgroup *memcg;
 
 		cond_resched();
 		folio = lru_to_folio(&l_hold);
@@ -2600,8 +2630,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		}
 
 		/* Referenced or rmap lock contention: rotate */
-		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags) != 0) {
+		memcg = folio_referenced_memcg(folio, sc->target_mem_cgroup);
+		if (folio_referenced(folio, 0, memcg, &vm_flags) != 0) {
 			/*
 			 * Identify referenced, file-backed active folios and
 			 * give them one more trip around the active list. So
-- 
2.38.0.rc1.362.ged0d419d3c-goog

