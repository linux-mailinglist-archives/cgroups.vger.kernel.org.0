Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9224330F
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 06:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgHMEC2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHMEC2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 00:02:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0730AC061757;
        Wed, 12 Aug 2020 21:02:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so4118476qke.11;
        Wed, 12 Aug 2020 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XtxT1MTxM5ARJ+08eWr2bJ37iwug5sulaz41RNmMU7k=;
        b=p7aKYuuOYtZex8EmSHqns2ZVG6wtpk4+BJY6vTjOWkw9WYj2eijkenTtU70ZLdXWyE
         GQrZFDJrpyqGeq6kIv3KfpWbtPJ0thdDxLNyrRk32/WBCYNISKcCW1gOEnlUnynVrMY2
         unbACAKixzD21x1yKI8PZY26drlVM4slXcE4ZnTDk6FPDyy+BNskGWk2LNwClTmLWpAu
         UjT5Bc1jXlMXNnfJWxGeJA8NmE7vREmRF9Qo3Ym76m44t8HmrT4uKcB10SnYiSsdX/cE
         iy1vSkyE7G/EC5PmTx5uC0TRNuQGC48FnnYA5zPE0xjrCLLM1NZltN3VJwV6S0aaW5+/
         OkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XtxT1MTxM5ARJ+08eWr2bJ37iwug5sulaz41RNmMU7k=;
        b=r5x8X1LCHu3RAuwxrqR5aMRs4dIoHw4LkGlVyO7ESCgtJTQ9CUOGEA1fzXd/0YEnXK
         hApTUzEuF4/2Jcfp7RuYitA/MKdF/u4MMQ2NH3t8xH/O0Qy0v9jPUizCIKxi3wMl0Vpt
         L28pnyDbaopR8i3olttn2vbbzUFXj8k2EscQcuTL7AlR12ISC6QNAMj+jEk6eKt3Hcw4
         Ub5FgG1Jn528Ud3sCtBXxMKUOQJaQjf3GbZ52BvxfRLRrigqtLykKRMSefQG6ELDKXXW
         eHFTBsoYX47KabBlFISyu0giFFNxmlhw/e6nUmGVu1WBlyRJo7Hz47jvzl/fy+Yc6cYT
         i3LA==
X-Gm-Message-State: AOAM533C911n6oQ6MGb7abZwD+1T58B0qnRXwjBMfv2LZoleJ3Vg4YPy
        aWYKcZl735G3EcIKioLgg0s=
X-Google-Smtp-Source: ABdhPJx3h8V1BGcujSWy01LeHbHKLGD8NBYz+86psVF7eNMM6naaE4zznE3jh+HZ/CMxH6oUQbTbFQ==
X-Received: by 2002:a05:620a:10ab:: with SMTP id h11mr2890878qkk.219.1597291347120;
        Wed, 12 Aug 2020 21:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id s4sm4959859qtn.34.2020.08.12.21.02.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 21:02:26 -0700 (PDT)
Subject: [RFC PATCH 1/3] mm: Drop locked from isolate_migratepages_block
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Wed, 12 Aug 2020 21:02:24 -0700
Message-ID: <20200813040224.13054.96724.stgit@localhost.localdomain>
In-Reply-To: <20200813035100.13054.25671.stgit@localhost.localdomain>
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

We can drop the need for the locked variable by making use of the
lruvec_holds_page_lru_lock function. By doing this we can avoid some rcu
locking ugliness for the case where the lruvec is still holding the LRU
lock associated with the page. Instead we can just use the lruvec and if it
is NULL we assume the lock was released.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/compaction.c |   45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b99c96c4862d..5021a18ef722 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -803,9 +803,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 {
 	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	unsigned long nr_scanned = 0, nr_isolated = 0;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
-	struct lruvec *locked = NULL;
 	struct page *page = NULL, *valid_page = NULL;
 	unsigned long start_pfn = low_pfn;
 	bool skip_on_failure = false;
@@ -866,9 +865,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * a fatal signal is pending.
 		 */
 		if (!(low_pfn % SWAP_CLUSTER_MAX)) {
-			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
-				locked = NULL;
+			if (lruvec) {
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec = NULL;
 			}
 
 			if (fatal_signal_pending(current)) {
@@ -949,9 +948,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			 */
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
-				if (locked) {
-					unlock_page_lruvec_irqrestore(locked, flags);
-					locked = NULL;
+				if (lruvec) {
+					unlock_page_lruvec_irqrestore(lruvec, flags);
+					lruvec = NULL;
 				}
 
 				if (!isolate_movable_page(page, isolate_mode))
@@ -992,16 +991,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		rcu_read_lock();
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-
 		/* If we already hold the lock, we can skip some rechecking */
-		if (lruvec != locked) {
-			if (locked)
-				unlock_page_lruvec_irqrestore(locked, flags);
+		if (!lruvec || !lruvec_holds_page_lru_lock(page, lruvec)) {
+			if (lruvec)
+				unlock_page_lruvec_irqrestore(lruvec, flags);
 
+			lruvec = mem_cgroup_page_lruvec(page, pgdat);
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
-			locked = lruvec;
 			rcu_read_unlock();
 
 			lruvec_memcg_debug(lruvec, page);
@@ -1023,8 +1019,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				SetPageLRU(page);
 				goto isolate_fail_put;
 			}
-		} else
-			rcu_read_unlock();
+		}
 
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
@@ -1057,9 +1052,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
-		if (locked) {
-			unlock_page_lruvec_irqrestore(locked, flags);
-			locked = NULL;
+		if (lruvec) {
+			unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec = NULL;
 		}
 		put_page(page);
 
@@ -1073,9 +1068,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * page anyway.
 		 */
 		if (nr_isolated) {
-			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
-				locked = NULL;
+			if (lruvec) {
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
@@ -1102,8 +1097,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	page = NULL;
 
 isolate_abort:
-	if (locked)
-		unlock_page_lruvec_irqrestore(locked, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	if (page) {
 		SetPageLRU(page);
 		put_page(page);

