Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE911CB75F
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEHScS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbgEHScQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337E6C05BD0A
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v4so1210238qte.3
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjChPX7glAdooI23QIihtHHWKSsyoFkOYmamMQuDTUs=;
        b=E2/VFAYie4kY0oIe+I5W4UoCkIR1MFpm8OEx4ahvA8yieQG6LQNzAimM1n3W6Li+Oc
         I0/5BUjFGqhTxN8yW7GlZ3Qzgx77PFKUTO/h1kkZEBPp6kUrL/LmkNlQb1nLZXjWmB0e
         rVfbzBbUsU1z770LBdlYdN5Lm4Dn5WiB6Yvl/XrvK1A2xYQHB9jIvQZjN+BkQ6AHKJ0Z
         vLZWRfxOlBhIZzVQIEwWwp+RcnrRAK1wpNAGjkQX5HJxuSN0dt59OcKSyfcOZ8DqFpJe
         5E+Xw3g91V+3mRBPj1qstLwYoLSWZwC6SzFfsjqKkKRqw6wOVDd6flbMtu4wLGK37FZw
         LjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjChPX7glAdooI23QIihtHHWKSsyoFkOYmamMQuDTUs=;
        b=o88ohcDt0huYmcxaCsn4gw3axiaQcBtP1VqPEJM3VcblyTNFZqF0HnGmqRK/TeJUhh
         nbbzyMZwbxZoJL6/9wI/MB84JWTxBHu5BkRCOHuNSqmrLId+riXzcPMK9/gn95YGB9m0
         Y7/7y4ptUJpydTNEVFfMsYL7aogNIbbuEkT8A/55APeIp2ayKOB8vQR5WE94XOseAfjx
         u0K91HikkeHatnRGzYW5wyu3nz8XFBEd1n0F3fE5txb70aF5QTcXmhZ4JFvc9YsJp9P7
         EM867U1a1yoyP6PaakD3UUoPCFbNnXCUEcx3PhMg4pvLdun2hpdWWaWSI4+krA55qgxX
         aTYA==
X-Gm-Message-State: AGi0PuY0HXv5asjHDwtlKp1WihKb/HZpTsHpWjxnbowYBUxroxx36LFM
        G2TrZZMGDSn7lwziCEeVWe8xfQ==
X-Google-Smtp-Source: APiQypKfEaNko+TNl5fRiEjFygGSRu6c+fbfE4Rvr4dO+JYHm+E6+/ujwz88q8b+m6+BImDW3PWNwA==
X-Received: by 2002:ac8:c0d:: with SMTP id k13mr1670052qti.136.1588962735392;
        Fri, 08 May 2020 11:32:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g11sm1725212qkk.106.2020.05.08.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 02/19] mm: memcontrol: fix stat-corrupting race in charge moving
Date:   Fri,  8 May 2020 14:30:49 -0400
Message-Id: <20200508183105.225460-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
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
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 317dbbaac603..cdd29b59929b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5376,7 +5376,6 @@ static int mem_cgroup_move_account(struct page *page,
 {
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
-	unsigned long flags;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
 	bool anon;
@@ -5403,18 +5402,13 @@ static int mem_cgroup_move_account(struct page *page,
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
 
@@ -5430,15 +5424,23 @@ static int mem_cgroup_move_account(struct page *page,
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
2.26.2

