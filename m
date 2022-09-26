Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8C5EA9FE
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiIZPPC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 11:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiIZPOU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 11:14:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108707E308
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r20so4078812qtn.12
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X0S0bdsMSZwjlbQsv+GYht3cMFqf9TlaOrFi2tt0ZUE=;
        b=ivgKMYEx6KKFhpp8wNE19iM09oj8t0G7ajjdlApXiV8dHxl6sdRPZlL3sNkFlSDNwy
         rnXLGG7lYYJAxGKw1r/ekzCIehnIVG05fD84xOZnCYJ98uQr0VSqu4gi3uFUuh/7uMYt
         odr+evVu3To0Y90IeM8RLSdC8kXkAJV9dsY3cmFWEcyVPtDrJuPsRKaLmE6gFZ28BSIc
         ovC/udwIpbLSyiJdrqlUZu9ncSBsbrTC2ca1wRvfr87LNGa+OY4lP8zmbXErXnQCfk08
         t9y3dA2dkaXRSH3P2RHybF9daxj+aOSeam6tQeY7J+TPfzO+K56S2MduhvUdrFpDD51K
         xVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X0S0bdsMSZwjlbQsv+GYht3cMFqf9TlaOrFi2tt0ZUE=;
        b=d2m6tq88hUGPfC6rdHkR96AqKvCQs+9weXwvRARJuoyPY1Pu1lLes4RL4bByHxUs+I
         SgmRxIAKzzr1gg25dQP5scZRHr/tseRFfkKeUVJ4parN4032iyGT801h8h4k8F8VU62O
         PqyJcmwY+9emAGVR4aogilipFjTdGj5/imt6LB2oWRGj5N1L6oYgGaBqPMf6D+Zng6Vx
         upOlDa2Nznsdi/+f9JHZUXeBDJwc/mH/c2jtQZl16kFlTC94k/FPwDwwSawmPtxT/T8r
         fxG0et3reR8a4I6UiOl9c4compyqRVClpxq47ItJPGDuHytS2ZWby+9rfpGeYcjVhaiQ
         3DpA==
X-Gm-Message-State: ACrzQf1X9fQB+R71AcN0cvGj8SAPJgbyiZEeqDpqO9q2j9utp6PvGnn0
        /LsOGotn95thG+0lMOAcFWYIjw==
X-Google-Smtp-Source: AMsMyM7Ul5O43S3u/fkDoFtmHr+YA4o1q3LjljR0Uy16ObfFPlUp15Qpp7LaXeGU4Il4nCoBD2Oe0A==
X-Received: by 2002:ac8:7d4c:0:b0:35c:c979:dc17 with SMTP id h12-20020ac87d4c000000b0035cc979dc17mr18455434qtb.271.1664200637789;
        Mon, 26 Sep 2022 06:57:17 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b0069fe1dfbeffsm11925212qkb.92.2022.09.26.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:57:17 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: memcontrol: drop dead CONFIG_MEMCG_SWAP config symbol
Date:   Mon, 26 Sep 2022 09:57:04 -0400
Message-Id: <20220926135704.400818-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926135704.400818-1-hannes@cmpxchg.org>
References: <20220926135704.400818-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since 2d1c498072de ("mm: memcontrol: make swap tracking an integral
part of memory control"), CONFIG_MEMCG_SWAP hasn't been a user-visible
config option anymore, it just means CONFIG_MEMCG && CONFIG_SWAP.

Update the sites accordingly and drop the symbol.

[ While touching the docs, remove two references to CONFIG_MEMCG_KMEM,
  which hasn't been a user-visible symbol for over half a decade. ]

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 +---
 arch/mips/configs/db1xxx_defconfig             | 1 -
 arch/mips/configs/generic_defconfig            | 1 -
 arch/powerpc/configs/powernv_defconfig         | 1 -
 arch/powerpc/configs/pseries_defconfig         | 1 -
 arch/sh/configs/sdk7786_defconfig              | 1 -
 arch/sh/configs/urquell_defconfig              | 1 -
 include/linux/swap.h                           | 2 +-
 include/linux/swap_cgroup.h                    | 4 ++--
 init/Kconfig                                   | 5 -----
 mm/Makefile                                    | 4 +++-
 mm/memcontrol.c                                | 6 +++---
 tools/testing/selftests/cgroup/config          | 1 -
 13 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 2cc502a75ef6..5b86245450bd 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -299,7 +299,7 @@ Per-node-per-memcgroup LRU (cgroup's private LRU) is guarded by
 lruvec->lru_lock; PG_lru bit of page->flags is cleared before
 isolating a page from its LRU under lruvec->lru_lock.
 
-2.7 Kernel Memory Extension (CONFIG_MEMCG_KMEM)
+2.7 Kernel Memory Extension
 -----------------------------------------------
 
 With the Kernel memory extension, the Memory Controller is able to limit
@@ -386,8 +386,6 @@ limit, and "K" the kernel limit. There are three possible ways limits can be
 
 a. Enable CONFIG_CGROUPS
 b. Enable CONFIG_MEMCG
-c. Enable CONFIG_MEMCG_SWAP (to use swap extension)
-d. Enable CONFIG_MEMCG_KMEM (to use kmem extension)
 
 3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
 -------------------------------------------------------------------
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index b8bd66300996..83cbdecb27e6 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -9,7 +9,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CFS_BANDWIDTH=y
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 714169e411cf..48e4e251779b 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -3,7 +3,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 49f49c263935..4acca5263404 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -17,7 +17,6 @@ CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
 CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index b571d084c148..fead14ebb1fc 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -16,7 +16,6 @@ CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
 CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index a8662b6927ec..97b7356639ed 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -16,7 +16,6 @@ CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
-CONFIG_CGROUP_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index cb2f56468fe0..be478f3148f2 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -14,7 +14,6 @@ CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
-CONFIG_CGROUP_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
diff --git a/include/linux/swap.h b/include/linux/swap.h
index fc8d98660326..a18cf4b7c724 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -666,7 +666,7 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 	cgroup_throttle_swaprate(&folio->page, gfp);
 }
 
-#ifdef CONFIG_MEMCG_SWAP
+#if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
 int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index a12dd1c3966c..ae73a87775b3 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -4,7 +4,7 @@
 
 #include <linux/swap.h>
 
-#ifdef CONFIG_MEMCG_SWAP
+#if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
 extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
 					unsigned short old, unsigned short new);
@@ -40,6 +40,6 @@ static inline void swap_cgroup_swapoff(int type)
 	return;
 }
 
-#endif /* CONFIG_MEMCG_SWAP */
+#endif
 
 #endif /* __LINUX_SWAP_CGROUP_H */
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..7d86cf6b3012 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -958,11 +958,6 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
-config MEMCG_SWAP
-	bool
-	depends on MEMCG && SWAP
-	default y
-
 config MEMCG_KMEM
 	bool
 	depends on MEMCG && !SLOB
diff --git a/mm/Makefile b/mm/Makefile
index cc23b0052584..8e105e5b3e29 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,7 +98,9 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
-obj-$(CONFIG_MEMCG_SWAP) += swap_cgroup.o
+ifdef CONFIG_SWAP
+obj-$(CONFIG_MEMCG) += swap_cgroup.o
+endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 76bb0a18a2f3..61e05fc281fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3423,7 +3423,7 @@ void split_page_memcg(struct page *head, unsigned int nr)
 		css_get_many(&memcg->css, nr - 1);
 }
 
-#ifdef CONFIG_MEMCG_SWAP
+#ifdef CONFIG_SWAP
 /**
  * mem_cgroup_move_swap_account - move swap charge and swap_cgroup's record.
  * @entry: swap entry to be moved
@@ -7296,7 +7296,7 @@ static int __init mem_cgroup_init(void)
 }
 subsys_initcall(mem_cgroup_init);
 
-#ifdef CONFIG_MEMCG_SWAP
+#ifdef CONFIG_SWAP
 static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 {
 	while (!refcount_inc_not_zero(&memcg->id.ref)) {
@@ -7788,4 +7788,4 @@ static int __init mem_cgroup_swap_init(void)
 }
 subsys_initcall(mem_cgroup_swap_init);
 
-#endif /* CONFIG_MEMCG_SWAP */
+#endif /* CONFIG_SWAP */
diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
index 84fe884fad86..97d549ee894f 100644
--- a/tools/testing/selftests/cgroup/config
+++ b/tools/testing/selftests/cgroup/config
@@ -4,5 +4,4 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_KMEM=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_PAGE_COUNTER=y
-- 
2.37.3

