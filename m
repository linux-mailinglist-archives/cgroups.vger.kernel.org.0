Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639445A5B5E
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiH3GAS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3GAQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 02:00:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E7248EF;
        Mon, 29 Aug 2022 23:00:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so9745112pgq.6;
        Mon, 29 Aug 2022 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc;
        bh=+u8MsnXVLuPRXhuPrr3jHb9wYGXAHxn2UH8zEXx8loM=;
        b=WRDjKb7fg8Tsj3l+ddy3zDk90jir/6RXBcU4yHYfsGG62r8O4snu+Wj3ld1oCPOLrI
         dQwhSqGyI0L68HyBUz5dJXZuEAFPv2/1YywtYnnNlJVqZ7fyQvf/xWot6Gd32Uu54COH
         qlza/MtKuW+craGIfFi8rOSJsELzaJpPy+bKavkFcqN53gYK35drpsntz99ESHveiF2w
         yMkkTBQLTbDGPVTy517HM+mKWwnLlRVmMF3M/LsJunBt5gfQx8XHJ3p6GHcHq5prStXT
         EOBSSsqA9w9pZWwHBWllzf4gm09jt+fGobriEMn7+JAwQ3xD1nsZPLLjDCmhboRsRVHn
         ovXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=+u8MsnXVLuPRXhuPrr3jHb9wYGXAHxn2UH8zEXx8loM=;
        b=EC0oejA2F3AtkkSm4+VF2GI9vGnmHmndRogCYlRPLeXI/QhVnuUOn9xLbb/R/JIjuF
         zI/7+0AarS36Kj+ysvWiqtRTKPdiCGzhju1+OptelhKFLbP3QAuHRir0B+x1F4KTSqZc
         csKryweGKzfsA+ClxJ6WH32MpqJ1WKqJURqO229IB1tOxkKXRM4riz3TPp14m5qiI8eP
         1wd7wwegYQNOnFZqMVnZeNzHOPw9HxjefpZtd2PJzFVduSKXrCZ1nGxBwDW1t2dBBXwu
         8rkqw1uAYrQypq0D6yKskVblLcMf+InzHZwxC6gPv3h7LAa2PrbueM48spC99r1JHH7x
         /eXA==
X-Gm-Message-State: ACgBeo06PugehdgGQknY561Y20Gkb3LyyV1qRFa6QftDjXwHxIycoBnu
        vi//9t/Gd1hTTemPEaL/MrduR0MSWM+5qcB1
X-Google-Smtp-Source: AA6agR5ihjHu4632B9Qdv1JRLYurWHsyNOOp5mcpUyDOk0w8f09JiUu5xJ4j/A/OqHhnf3Kza6U52g==
X-Received: by 2002:a05:6a00:1681:b0:52e:d9b1:8596 with SMTP id k1-20020a056a00168100b0052ed9b18596mr19969441pfc.56.1661839211830;
        Mon, 29 Aug 2022 23:00:11 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090b069800b001fd962747d4sm5311546pjz.30.2022.08.29.23.00.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Aug 2022 23:00:11 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/2] mm: memcontrol: make cgroup_memory_noswap a static key
Date:   Tue, 30 Aug 2022 13:59:49 +0800
Message-Id: <20220830055949.12640-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220830055949.12640-1-ryncsn@gmail.com>
References: <20220830055949.12640-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

cgroup_memory_noswap is used in many hot path, so make it a static key
to lower the kernel overhead.

Using 8G of ZRAM as SWAP, benchmark using `perf stat -d -d -d --repeat 100`
with the following code snip in a non-root cgroup:

   #include <stdio.h>
   #include <string.h>
   #include <linux/mman.h>
   #include <sys/mman.h>
   #define MB 1024UL * 1024UL
   int main(int argc, char **argv){
      void *p = mmap(NULL, 8000 * MB, PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      memset(p, 0xff, 8000 * MB);
      madvise(p, 8000 * MB, MADV_PAGEOUT);
      memset(p, 0xff, 8000 * MB);
      return 0;
   }

Before:
          7,021.43 msec task-clock                #    0.967 CPUs utilized            ( +-  0.03% )
             4,010      context-switches          #  573.853 /sec                     ( +-  0.01% )
                 0      cpu-migrations            #    0.000 /sec
         2,052,057      page-faults               #  293.661 K/sec                    ( +-  0.00% )
    12,616,546,027      cycles                    #    1.805 GHz                      ( +-  0.06% )  (39.92%)
       156,823,666      stalled-cycles-frontend   #    1.25% frontend cycles idle     ( +-  0.10% )  (40.25%)
       310,130,812      stalled-cycles-backend    #    2.47% backend cycles idle      ( +-  4.39% )  (40.73%)
    18,692,516,591      instructions              #    1.49  insn per cycle
                                                  #    0.01  stalled cycles per insn  ( +-  0.04% )  (40.75%)
     4,907,447,976      branches                  #  702.283 M/sec                    ( +-  0.05% )  (40.30%)
        13,002,578      branch-misses             #    0.26% of all branches          ( +-  0.08% )  (40.48%)
     7,069,786,296      L1-dcache-loads           #    1.012 G/sec                    ( +-  0.03% )  (40.32%)
       649,385,847      L1-dcache-load-misses     #    9.13% of all L1-dcache accesses  ( +-  0.07% )  (40.10%)
     1,485,448,688      L1-icache-loads           #  212.576 M/sec                    ( +-  0.15% )  (39.49%)
        31,628,457      L1-icache-load-misses     #    2.13% of all L1-icache accesses  ( +-  0.40% )  (39.57%)
         6,667,311      dTLB-loads                #  954.129 K/sec                    ( +-  0.21% )  (39.50%)
         5,668,555      dTLB-load-misses          #   86.40% of all dTLB cache accesses  ( +-  0.12% )  (39.03%)
               765      iTLB-loads                #  109.476 /sec                     ( +- 21.81% )  (39.44%)
         4,370,351      iTLB-load-misses          # 214320.09% of all iTLB cache accesses  ( +-  1.44% )  (39.86%)
       149,207,254      L1-dcache-prefetches      #   21.352 M/sec                    ( +-  0.13% )  (40.27%)

           7.25869 +- 0.00203 seconds time elapsed  ( +-  0.03% )

After:
          6,576.16 msec task-clock                #    0.953 CPUs utilized            ( +-  0.10% )
             4,020      context-switches          #  605.595 /sec                     ( +-  0.01% )
                 0      cpu-migrations            #    0.000 /sec
         2,052,056      page-faults               #  309.133 K/sec                    ( +-  0.00% )
    11,967,619,180      cycles                    #    1.803 GHz                      ( +-  0.36% )  (38.76%)
       161,259,240      stalled-cycles-frontend   #    1.38% frontend cycles idle     ( +-  0.27% )  (36.58%)
       253,605,302      stalled-cycles-backend    #    2.16% backend cycles idle      ( +-  4.45% )  (34.78%)
    19,328,171,892      instructions              #    1.65  insn per cycle
                                                  #    0.01  stalled cycles per insn  ( +-  0.10% )  (31.46%)
     5,213,967,902      branches                  #  785.461 M/sec                    ( +-  0.18% )  (30.68%)
        12,385,170      branch-misses             #    0.24% of all branches          ( +-  0.26% )  (34.13%)
     7,271,687,822      L1-dcache-loads           #    1.095 G/sec                    ( +-  0.12% )  (35.29%)
       649,873,045      L1-dcache-load-misses     #    8.93% of all L1-dcache accesses  ( +-  0.11% )  (41.41%)
     1,950,037,608      L1-icache-loads           #  293.764 M/sec                    ( +-  0.33% )  (43.11%)
        31,365,566      L1-icache-load-misses     #    1.62% of all L1-icache accesses  ( +-  0.39% )  (45.89%)
         6,767,809      dTLB-loads                #    1.020 M/sec                    ( +-  0.47% )  (48.42%)
         6,339,590      dTLB-load-misses          #   95.43% of all dTLB cache accesses  ( +-  0.50% )  (46.60%)
               736      iTLB-loads                #  110.875 /sec                     ( +-  1.79% )  (48.60%)
         4,314,836      iTLB-load-misses          # 518653.73% of all iTLB cache accesses  ( +-  0.63% )  (42.91%)
       144,950,156      L1-dcache-prefetches      #   21.836 M/sec                    ( +-  0.37% )  (41.39%)

           6.89935 +- 0.00703 seconds time elapsed  ( +-  0.10% )

The performance is clearly better.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memcontrol.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 20e26ccd7dddc..8ea5589345a14 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -90,9 +90,18 @@ static bool cgroup_memory_nokmem __initdata;
 
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
-static bool cgroup_memory_noswap __ro_after_init;
+static bool cgroup_memory_noswap __initdata;
+
+static DEFINE_STATIC_KEY_FALSE(memcg_swap_enabled_key);
+static inline bool memcg_swap_enabled(void)
+{
+	return static_branch_likely(&memcg_swap_enabled_key);
+}
 #else
-#define cgroup_memory_noswap		1
+static inline bool memcg_swap_enabled(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -102,7 +111,7 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg_swap_enabled();
 }
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -7264,7 +7273,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
-	if (!cgroup_memory_noswap && memcg != swap_memcg) {
+	if (memcg_swap_enabled() && memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
 			page_counter_charge(&swap_memcg->memsw, nr_entries);
 		page_counter_uncharge(&memcg->memsw, nr_entries);
@@ -7316,7 +7325,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
-	if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg) &&
+	if (memcg_swap_enabled() && !mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
@@ -7348,7 +7357,7 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
-		if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg)) {
+		if (memcg_swap_enabled() && !mem_cgroup_is_root(memcg)) {
 			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 				page_counter_uncharge(&memcg->swap, nr_pages);
 			else
@@ -7364,7 +7373,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!memcg_swap_enabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
@@ -7381,7 +7390,7 @@ bool mem_cgroup_swap_full(struct page *page)
 
 	if (vm_swap_full())
 		return true;
-	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!memcg_swap_enabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
 	memcg = page_memcg(page);
@@ -7689,6 +7698,8 @@ static int __init mem_cgroup_swap_init(void)
 	if (cgroup_memory_noswap)
 		return 0;
 
+	static_branch_enable(&memcg_swap_enabled_key);
+
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-- 
2.35.2

