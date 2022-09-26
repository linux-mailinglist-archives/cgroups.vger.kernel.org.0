Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B635EA9FC
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiIZPPB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiIZPOS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 11:14:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618044E865
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l14so4332440qvq.8
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HeJ4YaLZeye7K1WDyF1k6x7DVspo4c+vBec349uMCXA=;
        b=0d/wItGXbtug7zpturg/zxUG+IZarNXHxgNZ2X8AOYRuE9PfYFwwS5l6CL131XGwvT
         F22e4LAZG3MD/PUwEN6sr7Hw9S+5Apeqx+qfbFw+GDau4kqS3lvpdGgY7KuJRn9M1UNX
         puNO1MgLzrzXTx3MVyb9aIZlat2aM4gNqTkE+wAjMl1rgTbDL0vKg99D8WL8zytzSMcj
         4ZlKV/xY9ZUNiuX0Q1ZadfGHe9gXSROaEQHpHK1V3wiKZqnHy/DLWNDSpW/HE/Vk0U+u
         +otTACZTiF+2iS//DQyG7gsLLmfOuSzIlyfQ2A4Zfohjsbr2RxOOaJ3JHrv3EgWTASFH
         B6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HeJ4YaLZeye7K1WDyF1k6x7DVspo4c+vBec349uMCXA=;
        b=67vLUQZMm4f50LrU/JxRHAZ0XpixPR3sbKI8NOzZoVj21FiSWT8PYakewj4P+/+3ut
         MCNmEGJyY+9e1KB8sZi7ySdbVrE0QlH1AHpG5bm8+gMMuLhtshvb5DDQDldBZyJ2F+xM
         d2lnjMmaBONIJuYmhuuR0P8uNVxbPUiDzH/VShetCMS0673O/rABt99OJxR9kYc+M0l5
         FlwURxHxxx3kQEHKYOgARwQ96A7IjLcBchhcFezpN5qv0cn56nxCco0gPfc/zhP9E/Rt
         NSvEzNhl5ylGac3nsHfjPxBKEiDGx/x9fcugDWhj3fHikya64s5TGr0j24LOKGeC6EM3
         RoYQ==
X-Gm-Message-State: ACrzQf2sA1n3OpjOb4JSJsx8NSKbdMD3qLhMqhmXxjA9h7S95UQJPjyD
        7C4Xwwy8mJByZT+UihWHq/IwAQ==
X-Google-Smtp-Source: AMsMyM6FFcCCA0OAWsPzQLrlbPjXWThgUurSXOP/ecbenkipkttwdl4PhN2O8Tv+RF7syCrQiz1dEA==
X-Received: by 2002:a0c:abc8:0:b0:4ac:d471:7b83 with SMTP id k8-20020a0cabc8000000b004acd4717b83mr17310086qvb.102.1664200635053;
        Mon, 26 Sep 2022 06:57:15 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id fg21-20020a05622a581500b00342f8d4d0basm10991554qtb.43.2022.09.26.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:57:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: memcontrol: deprecate swapaccounting=0 mode
Date:   Mon, 26 Sep 2022 09:57:02 -0400
Message-Id: <20220926135704.400818-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926135704.400818-1-hannes@cmpxchg.org>
References: <20220926135704.400818-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The swapaccounting= commandline option already does very little
today. To close a trivial containment failure case, the swap ownership
tracking part of the swap controller has recently become mandatory
(see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
integral part of memory control") for details), which makes up the
majority of the work during swapout, swapin, and the swap slot map.

The only thing left under this flag is the page_counter operations and
the visibility of the swap control files in the first place, which are
rather meager savings. There also aren't many scenarios, if any, where
controlling the memory of a cgroup while allowing it unlimited access
to a global swap space is a workable resource isolation strategy.

On the other hand, there have been several bugs and confusion around
the many possible swap controller states (cgroup1 vs cgroup2 behavior,
memory accounting without swap accounting, memcg runtime disabled).

This puts the maintenance overhead of retaining the toggle above its
practical benefits. Deprecate it.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ---
 mm/memcontrol.c                               | 50 ++++---------------
 2 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3b95f65bafe2..99a13f2be2ef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6036,12 +6036,6 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swapaccount=	[KNL]
-			Format: [0|1]
-			Enable accounting of swap in memory resource
-			controller if no parameter or 1 is given or disable
-			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
-
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
 			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9e3c010ca676..4be1b48b9659 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -88,22 +88,6 @@ static bool cgroup_memory_nosocket __ro_after_init;
 /* Kernel memory accounting disabled? */
 static bool cgroup_memory_nokmem __ro_after_init;
 
-/* Whether the swap controller is active */
-#ifdef CONFIG_MEMCG_SWAP
-static bool cgroup_memory_noswap __initdata;
-
-static DEFINE_STATIC_KEY_FALSE(memcg_swap_enabled_key);
-static inline bool memcg_swap_enabled(void)
-{
-	return static_branch_likely(&memcg_swap_enabled_key);
-}
-#else
-static inline bool memcg_swap_enabled(void)
-{
-	return false;
-}
-#endif
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
@@ -111,7 +95,7 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg_swap_enabled();
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -7379,7 +7363,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
-	if (memcg_swap_enabled() && memcg != swap_memcg) {
+	if (memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
 			page_counter_charge(&swap_memcg->memsw, nr_entries);
 		page_counter_uncharge(&memcg->memsw, nr_entries);
@@ -7431,7 +7415,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
-	if (memcg_swap_enabled() && !mem_cgroup_is_root(memcg) &&
+	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
@@ -7466,7 +7450,7 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
-		if (memcg_swap_enabled() && !mem_cgroup_is_root(memcg)) {
+		if (!mem_cgroup_is_root(memcg)) {
 			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 				page_counter_uncharge(&memcg->swap, nr_pages);
 			else
@@ -7482,7 +7466,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (!memcg_swap_enabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
@@ -7499,7 +7483,7 @@ bool mem_cgroup_swap_full(struct folio *folio)
 
 	if (vm_swap_full())
 		return true;
-	if (!memcg_swap_enabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (do_memsw_account())
 		return false;
 
 	memcg = folio_memcg(folio);
@@ -7519,10 +7503,9 @@ bool mem_cgroup_swap_full(struct folio *folio)
 
 static int __init setup_swap_account(char *s)
 {
-	bool res;
-
-	if (!kstrtobool(s, &res))
-		cgroup_memory_noswap = !res;
+	pr_warn_once("The swapaccount= commandline option is deprecated. "
+		     "Please report your usecase to linux-mm@kvack.org if you "
+		     "depend on this functionality.\n");
 	return 1;
 }
 __setup("swapaccount=", setup_swap_account);
@@ -7791,24 +7774,11 @@ static struct cftype zswap_files[] = {
 };
 #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
 
-/*
- * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
- * instead of a core_initcall(), this could mean cgroup_memory_noswap still
- * remains set to false even when memcg is disabled via "cgroup_disable=memory"
- * boot parameter. This may result in premature OOPS inside
- * mem_cgroup_get_nr_swap_pages() function in corner cases.
- */
 static int __init mem_cgroup_swap_init(void)
 {
-	/* No memory control -> no swap control */
 	if (mem_cgroup_disabled())
-		cgroup_memory_noswap = true;
-
-	if (cgroup_memory_noswap)
 		return 0;
 
-	static_branch_enable(&memcg_swap_enabled_key);
-
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
@@ -7816,6 +7786,6 @@ static int __init mem_cgroup_swap_init(void)
 #endif
 	return 0;
 }
-core_initcall(mem_cgroup_swap_init);
+subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_MEMCG_SWAP */
-- 
2.37.3

