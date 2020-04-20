Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1B1B1910
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgDTWLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgDTWLo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03FC061A0C
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c16so10066340qtv.1
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7/z7NMewJSIi2itFoYhlm0aJz+TzGla37jQr9d/NIQ=;
        b=DkH0cJIWSxLVdQu3FuqQ6xuCWHM39JsPRR6UFozRIF79nnzQlMdLi7EsaGotcqDA0e
         mNCEoz7y0HOoBLz8deGU0CU2oVJztygMslxineP4v3GTFiAHGm4eQpca6dq0xW06C/MO
         CoLBEidF1VHQMiolPK5tH8rqy/W4Ht/Xog9SjtOCtiUV2iJOwa5jS1H+H5ZbxvEqqoSs
         /i7hQwgNO2XWIRMa1RxwCGoLHG+Lo3vjNXq7LMVY+yWi8szuGGn4UDdrP9UJoEmYZxO3
         oAfPtfRd37MeP5qQNnUbjZPMqHQLwi8MrXy+3jsseVCy4fJ0jGfuLZghtHfEHs57jIfS
         Mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7/z7NMewJSIi2itFoYhlm0aJz+TzGla37jQr9d/NIQ=;
        b=MEOdwWnqIUQ8aHq+0WJs/6H9RuWno80GcTMX5hDymbYvF9bxwxCl4WNPPgVcEcpJ3V
         4i0fCySSjsSBtl/FYupKM6nGlKULXH+1ptIhFIx7bS/Xb8Hkrmx2BEKTixkGSzjzBBD+
         kyP632iszl1iXJ+5afs0pyo+UGvU/EmaDzE+Pn9RMBo4OywbVjKZ4Oah7uMJF22nQI4z
         MPdPDdUjQTGuTQvEjlfvq61wfJQKJOGqhnBeCNQBki34ewXOEFUxzrvusTUcmoVZV/y+
         jMAdTYSB+YLwVUlXrfQ6hnW0DGuMT2rCka5LxDhOQo/A/uN90jVf4OmZiNYpBeUgtZ4L
         NySA==
X-Gm-Message-State: AGi0PubJS5zqHlbPzDk6z56WPM73teuWujgL1bU+Fpp6qsNlUbEqTgWG
        4HgN5rQtjffchFamaQatQlUUZA==
X-Google-Smtp-Source: APiQypIX1NRNeD/ZDLr7me0AtRIIPQ0sv2K/iH3epenr+0kAb6qHkWrCRyhhYf5EM6qgF7KVBtQkXg==
X-Received: by 2002:ac8:7c96:: with SMTP id y22mr18152524qtv.17.1587420702984;
        Mon, 20 Apr 2020 15:11:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id m25sm606580qkg.83.2020.04.20.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:42 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge moving
Date:   Mon, 20 Apr 2020 18:11:10 -0400
Message-Id: <20200420221126.341272-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The move_lock is a per-memcg lock, but the VM accounting code that
needs to acquire it comes from the page and follows page->mem_cgroup
under RCU protection. That means that the page becomes unlocked not
when we drop the move_lock, but when we update page->mem_cgroup. And
that assignment doesn't imply any memory ordering. If that pointer
write gets reordered against the reads of the page state -
page_mapped, PageDirty etc. the state may change while we rely on it
being stable and we can end up corrupting the counters.

Place an SMP memory barrier to make sure we're done with all page
state by the time the new page->mem_cgroup becomes visible.

Also replace the open-coded move_lock with a lock_page_memcg() to make
it more obvious what we're serializing against.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5beea03dd58a..41f5ed79272e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5372,7 +5372,6 @@ static int mem_cgroup_move_account(struct page *page,
 {
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
-	unsigned long flags;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
 	bool anon;
@@ -5399,18 +5398,13 @@ static int mem_cgroup_move_account(struct page *page,
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	spin_lock_irqsave(&from->move_lock, flags);
+	lock_page_memcg(page);
 
 	if (!anon && page_mapped(page)) {
 		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
 	}
 
-	/*
-	 * move_lock grabbed above and caller set from->moving_account, so
-	 * mod_memcg_page_state will serialize updates to PageDirty.
-	 * So mapping should be stable for dirty pages.
-	 */
 	if (!anon && PageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
 
@@ -5426,15 +5420,23 @@ static int mem_cgroup_move_account(struct page *page,
 	}
 
 	/*
+	 * All state has been migrated, let's switch to the new memcg.
+	 *
 	 * It is safe to change page->mem_cgroup here because the page
-	 * is referenced, charged, and isolated - we can't race with
-	 * uncharging, charging, migration, or LRU putback.
+	 * is referenced, charged, isolated, and locked: we can't race
+	 * with (un)charging, migration, LRU putback, or anything else
+	 * that would rely on a stable page->mem_cgroup.
+	 *
+	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * to save space. As soon as we switch page->mem_cgroup to a
+	 * new memcg that isn't locked, the above state can change
+	 * concurrently again. Make sure we're truly done with it.
 	 */
+	smp_mb();
 
-	/* caller should have done css_get */
-	page->mem_cgroup = to;
+	page->mem_cgroup = to; 	/* caller should have done css_get */
 
-	spin_unlock_irqrestore(&from->move_lock, flags);
+	__unlock_page_memcg(from);
 
 	ret = 0;
 
-- 
2.26.0

