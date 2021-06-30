Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6407A3B7C59
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhF3EFi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhF3EFg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DFC061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7xNRxU2d+g0pxJV1UZSJ1U58/qvZb9UUyyUY3cXQBnc=; b=Rfjq8Aj/6MOwV343S7QdscUBVq
        LKt2sfFOgujJxKkJAmsYe5V80hkmSbEcYAKXW6FoJQ/UPdV0aN+wIwh+ZAT/YA2goBWPQbJch+0ls
        z6Lg6+WZrodAiYe6F7D/4v+NbyjpyVDrKEDqxIuH/eZCQtqnPL/RyYS8QUhpcBl/QwCoWOg/NCX2H
        bMSRtZTWe/bxNEeA+oZt5Z5kaYmSl2Oeye7sAVd6E661TrdKnwPOErvidqPJfd/3RqECS0/BMEfYf
        kmY0S/SLhejpH6fyV3fYpaz29+E2rPKQt/OFHFysMXsdJn4tbc4aySwjXAOUcJsewn+gRAb6CNlVW
        ZGA51HpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRQQ-004qpS-BM; Wed, 30 Jun 2021 04:02:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 02/18] mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
Date:   Wed, 30 Jun 2021 05:00:18 +0100
Message-Id: <20210630040034.1155892-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The last use of 'page' was removed by commit 468c398233da ("mm:
memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
the parameter from the function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ee243ce6135..25cad0fb7d4e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -826,7 +826,6 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
-					 struct page *page,
 					 int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
@@ -5687,9 +5686,9 @@ static int mem_cgroup_move_account(struct page *page,
 	ret = 0;
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(to, page, nr_pages);
+	mem_cgroup_charge_statistics(to, nr_pages);
 	memcg_check_events(to, page);
-	mem_cgroup_charge_statistics(from, page, -nr_pages);
+	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, page);
 	local_irq_enable();
 out_unlock:
@@ -6710,7 +6709,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 	commit_charge(page, memcg);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 out:
@@ -7001,7 +7000,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
@@ -7231,7 +7230,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page);
 
 	css_put(&memcg->css);
-- 
2.30.2

