Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162F3EB4E7
	for <lists+cgroups@lfdr.de>; Fri, 13 Aug 2021 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhHML61 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Aug 2021 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbhHML60 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Aug 2021 07:58:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFCC061756;
        Fri, 13 Aug 2021 04:58:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso15670166pjb.1;
        Fri, 13 Aug 2021 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=HzU+YACWUeocMvFytTKfHrI9Kb6Qo/A9oD03PRz3Uos=;
        b=YG90DA/OTxozaS97az5Tx7aoGIBC36bIbAMwhl/dXRHCSRd4n4Z043vx4hSKb8weOf
         kUW9ge7rQsJ+b1H66WqDyCUUjchjo6lraPrULNJ1IVvTOszKlLAagwoBFxuoQFjnsTCU
         a+GSm17rCJGQhwbQztpGqbUuDyhe8iFQWAWCx1jNghwKmchZLiRvdJPu1f9dERSbjPP7
         Djk4w+trvmZZVwrRkLa5P4K7fbgoU4wMepZ3liPwJZuST89Xst7Cnx3/YCCWdz3kTmLO
         t4edgRsQ0PkABVOHDK1nGowD+xKEezgGNTmQWYWM+/BpZO7ylsQ6iHnus0nGtICSjZKS
         igcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=HzU+YACWUeocMvFytTKfHrI9Kb6Qo/A9oD03PRz3Uos=;
        b=f96Wfws9iv+GuuLR06Pq+6ZzYQWPnKD6BZW7JS3ZiC6caLR9tIoBmX27q0nR3unw/z
         NwumkYwtLyMsVbCPdIhuzDOCuhV30wyxEqLHkSAtacY4zsANsBlON7IgvcC4s86dazGd
         qY2oR+0LI/RBILUWdD4L+Vnsg64R6ieeNrZ6JXjnMbmjTOdcDE8X0cD01EdEUnq0w6KR
         dPkVhx4PtehIVu2Iz5Ya9YkbT7qlpEGfVnMmIARSLedzwUvrsxGzBngyNFnHGBCMAnjP
         idb+zhSiMBJcIWWnapOUQHTNiKWGfsVdaKFp4SwJ3mO0GowxZUy04d4HhpYJWlYVNxkw
         wjSw==
X-Gm-Message-State: AOAM531dswbf0I5WBDDQEWVbBGDoh5ZJhbqxi1rXPycJkrM/jVG2Xb6d
        KnnGSDl46lxnS0OEz2Tcfyg=
X-Google-Smtp-Source: ABdhPJyqPtUYNNUmcxgYYPzRFaArvH3xj5VJoB1dCR3qcfeCl96JAj69TugysW0uh9UVnZgGahzXTw==
X-Received: by 2002:a62:87c5:0:b029:3b5:f90f:c2eb with SMTP id i188-20020a6287c50000b02903b5f90fc2ebmr2238673pfe.28.1628855879661;
        Fri, 13 Aug 2021 04:57:59 -0700 (PDT)
Received: from localhost.localdomain ([171.221.147.253])
        by smtp.gmail.com with ESMTPSA id v15sm2099786pff.105.2021.08.13.04.57.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 04:57:59 -0700 (PDT)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, shakeelb@google.com, guro@fb.com,
        alexs@kernel.org, richard.weiyang@gmail.com, sh_def@163.com,
        sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: [PATCH v1] mm: Add configuration to control whether vmpressure notifier is enabled
Date:   Fri, 13 Aug 2021 04:57:50 -0700
Message-Id: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Inspired by PSI features, vmpressure inotifier function should also be
configured to decide whether it is used, because it is an independent
feature which notifies the user of memory pressure.

Since the vmpressure interface is used in kernel common code, for
users who do not use the vmpressure function, there will be
additional overhead.

So we add configuration to control whether vmpressure notifier is
enabled, and provide a boot parameter to use use vmpressure notifier
flexibly

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v1/memory.rst  |  3 ++-
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 include/linux/memcontrol.h                      |  2 ++
 include/linux/vmpressure.h                      |  7 +++++--
 init/Kconfig                                    | 20 +++++++++++++++++++
 mm/Makefile                                     |  3 ++-
 mm/memcontrol.c                                 |  7 ++++++-
 mm/vmpressure.c                                 | 26 +++++++++++++++++++++++++
 8 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5..967418a 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -388,6 +388,7 @@ a. Enable CONFIG_CGROUPS
 b. Enable CONFIG_MEMCG
 c. Enable CONFIG_MEMCG_SWAP (to use swap extension)
 d. Enable CONFIG_MEMCG_KMEM (to use kmem extension)
+e. Enable CONFIG_MEMCG_VMPRESSURE (to use vmpressure extension)
 
 3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
 -------------------------------------------------------------------
@@ -855,7 +856,7 @@ At reading, current status of OOM is shown.
           The number of processes belonging to this cgroup killed by any
           kind of OOM killer.
 
-11. Memory Pressure
+11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
 ===================
 
 The pressure level notifications can be used to monitor the memory
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4042a82..d119fb8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6158,6 +6158,9 @@
 	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
 			Format: <command>
 
+	vmpressure=	[KNL] Enable or disable vmpressure notifier.
+			Format: <bool>
+
 	vsyscall=	[X86-64]
 			Controls the behavior of vsyscalls (i.e. calls to
 			fixed addresses of 0xffffffffff600x00 from legacy
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ff1464..b201d8e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -257,8 +257,10 @@ struct mem_cgroup {
 
 	unsigned long soft_limit;
 
+#ifdef CONFIG_MEMCG_VMPRESSURE
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
+#endif
 
 	/*
 	 * Should the OOM killer kill all belonging tasks, had it kill one?
diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
index 6a2f51e..dcae02e 100644
--- a/include/linux/vmpressure.h
+++ b/include/linux/vmpressure.h
@@ -29,7 +29,8 @@ struct vmpressure {
 
 struct mem_cgroup;
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_VMPRESSURE
+extern bool vmpressure_enable;
 extern void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		       unsigned long scanned, unsigned long reclaimed);
 extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio);
@@ -48,5 +49,7 @@ static inline void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 			      unsigned long scanned, unsigned long reclaimed) {}
 static inline void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg,
 				   int prio) {}
-#endif /* CONFIG_MEMCG */
+static inline void vmpressure_init(struct vmpressure *vmpr) {}
+static inline void vmpressure_cleanup(struct vmpressure *vmpr) {}
+#endif /* CONFIG_MEMCG_PRESSURE */
 #endif /* __LINUX_VMPRESSURE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 71a028d..d3afeb2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -948,6 +948,26 @@ config MEMCG_KMEM
 	depends on MEMCG && !SLOB
 	default y
 
+config MEMCG_VMPRESSURE
+	bool "Memory pressure notifier"
+	depends on MEMCG
+	default y
+	help
+	  Vmpressure extension is used to monitor the memory allocation cost.
+	  The pressure level can be set according to the use scenario and
+	  application will be notified through eventfd when memory pressure is at
+	  the specific level (or higher).
+
+config VMPRESSURE_DEFAULT_DISABLED
+	bool "Require boot parameter to enable memory pressure notifier"
+	depends on MEMCG_VMPRESSURE
+	default n
+	help
+	  If set, memory pressure notifier will be disabled  but can be
+	  enabled through passing vmpressure=1 on the kernel commandline
+	  during boot.
+	  For those who want to use memory pressure notifier flexibly.
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/mm/Makefile b/mm/Makefile
index 970604e..e4f99c1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,7 +92,8 @@ obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_MEMCG) += memcontrol.o
+obj-$(CONFIG_MEMCG_VMPRESSURE) += vmpressure.o
 obj-$(CONFIG_MEMCG_SWAP) += swap_cgroup.o
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7c205..ee060ae2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -248,6 +248,7 @@ static inline bool should_force_charge(void)
 		(current->flags & PF_EXITING);
 }
 
+#ifdef CONFIG_MEMCG_VMPRESSURE
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -260,6 +261,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 {
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
+#endif
 
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
@@ -4794,9 +4796,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	} else if (!strcmp(name, "memory.oom_control")) {
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
-	} else if (!strcmp(name, "memory.pressure_level")) {
+#ifdef CONFIG_MEMCG_VMPRESSURE
+	} else if (vmpressure_enable &&
+		   !strcmp(name, "memory.pressure_level")) {
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
+#endif
 	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
 		event->register_event = memsw_cgroup_usage_register_event;
 		event->unregister_event = memsw_cgroup_usage_unregister_event;
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4..b0d4358 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -67,6 +67,19 @@ static const unsigned int vmpressure_level_critical = 95;
  */
 static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
 
+DEFINE_STATIC_KEY_FALSE(vmpressure_disabled);
+#ifdef CONFIG_VMPRESSURE_DEFAULT_DISABLED
+bool vmpressure_enable;
+#else
+bool vmpressure_enable = true;
+#endif
+static int __init setup_vmpressure(char *str)
+{
+	return kstrtobool(str, &vmpressure_enable) == 0;
+}
+__setup("vmpressure=", setup_vmpressure);
+
+
 static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 {
 	return container_of(work, struct vmpressure, work);
@@ -246,6 +259,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 
 	vmpr = memcg_to_vmpressure(memcg);
 
+	if (static_branch_likely(&vmpressure_disabled))
+		return;
+
 	/*
 	 * Here we only want to account pressure that userland is able to
 	 * help us with. For example, suppose that DMA zone is under
@@ -326,6 +342,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
  */
 void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio)
 {
+	if (static_branch_likely(&vmpressure_disabled))
+		return;
 	/*
 	 * We only use prio for accounting critical level. For more info
 	 * see comment for vmpressure_level_critical_prio variable above.
@@ -450,6 +468,11 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
  */
 void vmpressure_init(struct vmpressure *vmpr)
 {
+	if (!vmpressure_enable) {
+		static_branch_enable(&vmpressure_disabled);
+		return;
+	}
+
 	spin_lock_init(&vmpr->sr_lock);
 	mutex_init(&vmpr->events_lock);
 	INIT_LIST_HEAD(&vmpr->events);
@@ -465,6 +488,9 @@ void vmpressure_init(struct vmpressure *vmpr)
  */
 void vmpressure_cleanup(struct vmpressure *vmpr)
 {
+
+	if (static_branch_likely(&vmpressure_disabled))
+		return;
 	/*
 	 * Make sure there is no pending work before eventfd infrastructure
 	 * goes away.
-- 
2.7.4

