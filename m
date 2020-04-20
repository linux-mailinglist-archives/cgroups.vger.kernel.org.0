Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B951B1931
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgDTWMq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgDTWL4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8246C061A0F
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:55 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c16so10066790qtv.1
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6Lc3E3LhxWdBCoIQ263CZTYhXxWswvkwsnvqPUoqvI=;
        b=zOh4nR//aGqF/G3PkVQBTFQpUXaW2roAMB53HTt3TgNOo4Skb5ppokAmhVW07gKrgS
         Iz5r3vdxlD8OBux0DOlpjHsXYTfU46y9ILOMZ+x+3ZN77/8ZkatUWSzOjZP3cHCh7IUm
         YHGQrlRRFJZ4Sksi3PQh6eOPU7qfLoNDvw5lAJxQFEzP8GUIQ+km9ul/+/baMjnxjpUR
         l01Mi9MKW3UZ01itSMHkJqXfR6hXne2g0igBp3ULTRt7epfQtzKpURMliuCd91FTIxsV
         4P5LdL/TnocHc9+7FXcNilk2T0otOYFWgPHciSC3APZ4Rj7J0C15LDLbsIgvf+cA7/Gd
         hSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6Lc3E3LhxWdBCoIQ263CZTYhXxWswvkwsnvqPUoqvI=;
        b=mbdYwBvFK1YA2z42kl24ZAAt6VN0u/rTSGxEYSxVpQUd1xEhYGgzX9NrDEcUNEvJVx
         4csqmK0mA9kon0rrtKOdCAb52hzf0LyYzmsnqE2qiXZgGCfo0grFRSHsIbpCUZlWHQ4U
         ATlQDUbCumuEPf3IAz8NNDj+Jz4i0cA3c01QCh+DYNXJRqx93/n12jG1PZBtf8ul2wZM
         97td3gmfzBrarsOxfDGLS+cBiP0cTwJqvlr5w9LB56b9cdlKZWACdCIoLisyysWZ1nP1
         0osrIGL+NNKkvbdXwIlLbIc2mpN2QBtqyvWP2qwVapt3Xx4VyjTaHgu5pSy78J/6t6vl
         /QmA==
X-Gm-Message-State: AGi0PuZWsvWo7vX8BdUXbFv4ZMXY0mH/eX/zji21R22DTs2pF20C0JfA
        QU5zo/LlvQcsp4J6hyrcBz3FyA==
X-Google-Smtp-Source: APiQypKQ1M8wB71QSzsxAGtLLoaeIXSGYaixUWDp3ZtfOFShTelL2dkvaBwia46T8j/DXNEt0qi+wQ==
X-Received: by 2002:aed:3b0b:: with SMTP id p11mr18236016qte.109.1587420715039;
        Mon, 20 Apr 2020 15:11:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id u5sm590828qkm.116.2020.04.20.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:54 -0700 (PDT)
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
Subject: [PATCH 08/18] mm: memcontrol: prepare cgroup vmstat infrastructure for native anon counters
Date:   Mon, 20 Apr 2020 18:11:16 -0400
Message-Id: <20200420221126.341272-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Anonymous compound pages can be mapped by ptes, which means that if we
want to track NR_MAPPED_ANON, NR_ANON_THPS on a per-cgroup basis, we
have to be prepared to see tail pages in our accounting functions.

Make mod_lruvec_page_state() and lock_page_memcg() deal with tail
pages correctly, namely by redirecting to the head page which has the
page->mem_cgroup set up.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5e8b0e38f145..5a1b5a7b7728 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -711,16 +711,17 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!page->mem_cgroup) {
+	if (!head->mem_cgroup) {
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
-	lruvec = mem_cgroup_lruvec(page->mem_cgroup, pgdat);
+	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ac6f2b073a5a..e9e22c86a118 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1979,6 +1979,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  */
 struct mem_cgroup *lock_page_memcg(struct page *page)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -1998,7 +1999,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page->mem_cgroup;
+	memcg = head->mem_cgroup;
 	if (unlikely(!memcg))
 		return NULL;
 
@@ -2006,7 +2007,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 		return memcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page->mem_cgroup) {
+	if (memcg != head->mem_cgroup) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2049,7 +2050,9 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
  */
 void unlock_page_memcg(struct page *page)
 {
-	__unlock_page_memcg(page->mem_cgroup);
+	struct page *head = compound_head(page);
+
+	__unlock_page_memcg(head->mem_cgroup);
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-- 
2.26.0

