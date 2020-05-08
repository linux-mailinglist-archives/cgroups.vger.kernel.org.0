Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC01CB762
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEHSdT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgEHScX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F2C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q13so2133883qtp.7
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os71RgO7UYZW6sWXEwj0lDMyIJjz3G/urqsx0D5LgDI=;
        b=Ok41Lo1vf1PMKfG8DI0O4GLzAqQtpVb1zNf1EPZ4My8rTLN7d9U322b+HhpR56d+zr
         qgw/tjjicxzAND+jaT9qVeoLd36ipg11elnWg1Y7bYPF/T6YCZATPbJafo69PY0BO/J3
         f8aKqmu/arzV5mpttkCYZsi4SOXhka0OG9RtKFYGeBnYCLhWW70fKPsQST7VvJY7tiBu
         mJkZ1G5k5ovJfOTNzY5LP819R3F0edK6ciYpm6/r1d0sHdZHrBt0W7VbrHppDC88JPH5
         ygDS6M79il+1OV54bUyD4agmTHx0tqczjshn0Sbt2wFolrxpQQpTGDv4hvCuGMBxwdJA
         CWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os71RgO7UYZW6sWXEwj0lDMyIJjz3G/urqsx0D5LgDI=;
        b=tyoc0Yp1MdUusKAIYkbG7cCMsDc26s8Kd9PtvPRDc2gQgdK9EDbk+gSfyJeKwRloUq
         rNQJzr51fkLsCTeAiLSk2SpixPvSxVNRpfnK/B3YWA2HiT+kH0FnBNYNDEPKZTrmThwI
         orv7Jlu6DrtqhDcRiS2gk2elyxMg3xmJblxZc6tmLgPGmirG0vTTj2BBuNdJw6UkVTWG
         8RUTNAQ8YDpPZMRi8pFRRmAFzwsJadN5XxFq/VTuHHG70ilP3yvUlglP7X5Jl0JwLil6
         opgB9p1/OtPmpLfOyvA6Y62Nk2t3oM6CiF4U5853N8ix/UurjvD8Y/SjC/nNFohFhDzZ
         KGeA==
X-Gm-Message-State: AGi0PuZxj0UxcyJwHwHcd+wXyPGHWv+Ol61S01K8osggvK5CB+xGWqss
        MHN6EdI6UymtkhYRP5oLGd8NCg==
X-Google-Smtp-Source: APiQypLLbfqSzYKsedCrMYddgiO1/unFT31fQvO3IxHuqOtWBpejHnB2p+HWn96iuTaw56MC3MvTsw==
X-Received: by 2002:ac8:7496:: with SMTP id v22mr4449251qtq.348.1588962742353;
        Fri, 08 May 2020 11:32:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id w27sm2114893qtc.18.2020.05.08.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:21 -0700 (PDT)
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
Subject: [PATCH 06/19] mm: memcontrol: prepare uncharging for removal of private page type counters
Date:   Fri,  8 May 2020 14:30:53 -0400
Message-Id: <20200508183105.225460-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The uncharge batching code adds up the anon, file, kmem counts to
determine the total number of pages to uncharge and references to
drop. But the next patches will remove the anon and file counters.

Maintain an aggregate nr_pages in the uncharge_gather struct.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memcontrol.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1d45a09b334f..a5efdad77be4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6607,6 +6607,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
+	unsigned long nr_pages;
 	unsigned long pgpgout;
 	unsigned long nr_anon;
 	unsigned long nr_file;
@@ -6623,13 +6624,12 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
-	unsigned long nr_pages = ug->nr_anon + ug->nr_file + ug->nr_kmem;
 	unsigned long flags;
 
 	if (!mem_cgroup_is_root(ug->memcg)) {
-		page_counter_uncharge(&ug->memcg->memory, nr_pages);
+		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, nr_pages);
+			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
 			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
@@ -6641,16 +6641,18 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
 	__mod_memcg_state(ug->memcg, NR_SHMEM, -ug->nr_shmem);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, nr_pages);
+	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
 
 	if (!mem_cgroup_is_root(ug->memcg))
-		css_put_many(&ug->memcg->css, nr_pages);
+		css_put_many(&ug->memcg->css, ug->nr_pages);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
+	unsigned long nr_pages;
+
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
 	if (!page->mem_cgroup)
@@ -6670,13 +6672,12 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 		ug->memcg = page->mem_cgroup;
 	}
 
-	if (!PageKmemcg(page)) {
-		unsigned int nr_pages = 1;
+	nr_pages = compound_nr(page);
+	ug->nr_pages += nr_pages;
 
-		if (PageTransHuge(page)) {
-			nr_pages = compound_nr(page);
+	if (!PageKmemcg(page)) {
+		if (PageTransHuge(page))
 			ug->nr_huge += nr_pages;
-		}
 		if (PageAnon(page))
 			ug->nr_anon += nr_pages;
 		else {
@@ -6686,7 +6687,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 		}
 		ug->pgpgout++;
 	} else {
-		ug->nr_kmem += compound_nr(page);
+		ug->nr_kmem += nr_pages;
 		__ClearPageKmemcg(page);
 	}
 
-- 
2.26.2

