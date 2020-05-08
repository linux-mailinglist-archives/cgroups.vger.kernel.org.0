Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6A1CB752
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEHScy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728007AbgEHScj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5BEC05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q13so2134663qtp.7
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8KiuhgQn9QjGDSCTgxu+4Kxp1JpMMevwAlfWeqInNo=;
        b=E2/lkZF0RiYCcxCPe/xtrbbOTBo+Qxeuh14fqtLHVi8JGBUexR8E+nf1ZYvsRpjnq3
         WUM8sdHfMP74Ue7jRiI3xJAJsYMPcoL+KvjpUXLwTCRYJOLRS6vsocDXLXNwariB43xz
         YDMRuuALVf5GQgkJkO0+hXlMzIrhktWXL3fZyHhuFP8NJ33pUU6L+/lB+KmZhJaDt2/1
         YlZ6m7+V7kw0Krdvkg2DhESdmleb8pXSxgiA18MxnNR9N+LUgKgZ8c8Bmpark/3yvRhk
         /4G9o8qLzzBs1gA1h6dea5GplFO581TSJ5K4TLbOl8cg46nvgoMUvQBwiw/mLjWZ6WFj
         4PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8KiuhgQn9QjGDSCTgxu+4Kxp1JpMMevwAlfWeqInNo=;
        b=ER5pWsEzBNkDodvoWo0DGnUK1RiSMUqKrzScBkBLx8LIWa3ySIsyX0ZiVHIQfxtoo6
         /afbd5Aw7RA6ZYjpkQaSg375Q3odpPPq2MCMKhu/UFZVpz3zyqJCGjr8rumg5vdSUXHf
         gSiDjh66xihRnRReiOwZ+HCK86T4V6mDmsZT+ZCWZg2gKIrFqUi3xwIKw45TURWmagrh
         8cJgU0vVyZbA3l9IOr1hr9nFc7PBUJhCOlG/EUQ6OikG6gOwivFcWb3mMk2YUcptRB8l
         Dy02p67IgwYlnTY2A6AgVhw3WNQx1KNvWf6z7htsoD+HZ+x8obMRc+RZj1htFBUwLOhC
         VKdQ==
X-Gm-Message-State: AGi0PubJWlPVyNIFRZgLDlpKJvcBe9WX+baqItaAaqig4mWSooPdnFQq
        tov0af2xPikfZS4IZ02tKoXdtw==
X-Google-Smtp-Source: APiQypLTdqRXlY45AtYDRrAQb39ZTePitQOY1dbwmLbvV/fD+BLOCJo0IQRd9GeUZYQvZU6P/RJ8gg==
X-Received: by 2002:ac8:46d8:: with SMTP id h24mr4610830qto.352.1588962757352;
        Fri, 08 May 2020 11:32:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id q185sm1767510qkf.100.2020.05.08.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:36 -0700 (PDT)
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
Subject: [PATCH 14/19] mm: memcontrol: prepare swap controller setup for integration
Date:   Fri,  8 May 2020 14:31:01 -0400
Message-Id: <20200508183105.225460-15-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A few cleanups to streamline the swap controller setup:

- Replace the do_swap_account flag with cgroup_memory_noswap. This
  brings it in line with other functionality that is usually available
  unless explicitly opted out of - nosocket, nokmem.

- Remove the really_do_swap_account flag that stores the boot option
  and is later used to switch the do_swap_account. It's not clear why
  this indirection is/was necessary. Use do_swap_account directly.

- Minor coding style polishing

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 59 ++++++++++++++++++--------------------
 mm/swap_cgroup.c           |  4 +--
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 23608d3ee70f..3fa70ca73c31 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -572,7 +572,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
 #ifdef CONFIG_MEMCG_SWAP
-extern int do_swap_account;
+extern bool cgroup_memory_noswap;
 #endif
 
 struct mem_cgroup *lock_page_memcg(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b9bb7ca0b44..bb5f02ab92fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -83,10 +83,14 @@ static bool cgroup_memory_nokmem;
 
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
-int do_swap_account __read_mostly;
+#ifdef CONFIG_MEMCG_SWAP_ENABLED
+bool cgroup_memory_noswap __read_mostly;
 #else
-#define do_swap_account		0
-#endif
+bool cgroup_memory_noswap __read_mostly = 1;
+#endif /* CONFIG_MEMCG_SWAP_ENABLED */
+#else
+#define cgroup_memory_noswap		1
+#endif /* CONFIG_MEMCG_SWAP */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -95,7 +99,7 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && do_swap_account;
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
 }
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -6459,18 +6463,19 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		/*
 		 * Every swap fault against a single page tries to charge the
 		 * page, bail as early as possible.  shmem_unuse() encounters
-		 * already charged pages, too.  The USED bit is protected by
-		 * the page lock, which serializes swap cache removal, which
+		 * already charged pages, too.  page->mem_cgroup is protected
+		 * by the page lock, which serializes swap cache removal, which
 		 * in turn serializes uncharging.
 		 */
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		if (compound_head(page)->mem_cgroup)
 			goto out;
 
-		if (do_swap_account) {
+		if (!cgroup_memory_noswap) {
 			swp_entry_t ent = { .val = page_private(page), };
-			unsigned short id = lookup_swap_cgroup_id(ent);
+			unsigned short id;
 
+			id = lookup_swap_cgroup_id(ent);
 			rcu_read_lock();
 			memcg = mem_cgroup_from_id(id);
 			if (memcg && !css_tryget_online(&memcg->css))
@@ -6943,7 +6948,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !do_swap_account)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || cgroup_memory_noswap)
 		return 0;
 
 	memcg = page->mem_cgroup;
@@ -6987,7 +6992,7 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return;
 
 	id = swap_cgroup_record(entry, 0, nr_pages);
@@ -7010,7 +7015,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
@@ -7027,7 +7032,7 @@ bool mem_cgroup_swap_full(struct page *page)
 
 	if (vm_swap_full())
 		return true;
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
 	memcg = page->mem_cgroup;
@@ -7042,22 +7047,15 @@ bool mem_cgroup_swap_full(struct page *page)
 	return false;
 }
 
-/* for remember boot option*/
-#ifdef CONFIG_MEMCG_SWAP_ENABLED
-static int really_do_swap_account __initdata = 1;
-#else
-static int really_do_swap_account __initdata;
-#endif
-
-static int __init enable_swap_account(char *s)
+static int __init setup_swap_account(char *s)
 {
 	if (!strcmp(s, "1"))
-		really_do_swap_account = 1;
+		cgroup_memory_noswap = 0;
 	else if (!strcmp(s, "0"))
-		really_do_swap_account = 0;
+		cgroup_memory_noswap = 1;
 	return 1;
 }
-__setup("swapaccount=", enable_swap_account);
+__setup("swapaccount=", setup_swap_account);
 
 static u64 swap_current_read(struct cgroup_subsys_state *css,
 			     struct cftype *cft)
@@ -7123,7 +7121,7 @@ static struct cftype swap_files[] = {
 	{ }	/* terminate */
 };
 
-static struct cftype memsw_cgroup_files[] = {
+static struct cftype memsw_files[] = {
 	{
 		.name = "memsw.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
@@ -7152,13 +7150,12 @@ static struct cftype memsw_cgroup_files[] = {
 
 static int __init mem_cgroup_swap_init(void)
 {
-	if (!mem_cgroup_disabled() && really_do_swap_account) {
-		do_swap_account = 1;
-		WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys,
-					       swap_files));
-		WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys,
-						  memsw_cgroup_files));
-	}
+	if (mem_cgroup_disabled() || cgroup_memory_noswap)
+		return 0;
+
+	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
+	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_swap_init);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 45affaef3bc6..7aa764f09079 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -171,7 +171,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return 0;
 
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
@@ -209,7 +209,7 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return;
 
 	mutex_lock(&swap_cgroup_mutex);
-- 
2.26.2

