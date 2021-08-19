Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADF83F23E3
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhHSXzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Aug 2021 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhHSXzL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Aug 2021 19:55:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B7C061575;
        Thu, 19 Aug 2021 16:54:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x1so2357983plg.10;
        Thu, 19 Aug 2021 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=viHGzKzSKeSmri9JZn9sS8NBR5Cy+79a2Ptig9wv0Qs=;
        b=TaNZxESo7L/FXeWjhSVTgPAg1IDCRUPK6KyYgOS8KEh5Ueoegw8kaQCKSRCWmd+5Cw
         Oxdx2z2S0HJ9OPGcBE0X8iT0N213p8QwXdebtVkHUM/bVhuAclxiuxfuOYhElMX9T4cs
         pr3lnTB7xWyvJv3m5KpPdYhnYadnDgzXoXePA1KUzkJmEv0fDxzr7xSEpTyxVFwWKzvL
         5l3RTbYy0SvKoKSUtAbIWofMd1ylOyefJbv7zEH9uO01S0XBJQlNOUIN6jguVqtyAPoP
         eErS0XcWM4YF3Iipuu3Y32GpFObzVNbsCTfC3rT3JUx9jD21hQSCDeWYgA93UCvxrZEY
         L0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=viHGzKzSKeSmri9JZn9sS8NBR5Cy+79a2Ptig9wv0Qs=;
        b=AsAAyZBaDa93SUGZDUgX6POxhgAImgxyGJvTI/8D32z237GE3PI1qVTXuPijwRBjY+
         GcjCwV4raUIOHVHhjy/Z8t67Tn0KKDSqjyJehJIidizrUH9p8Cn9E7eS4gFm3+6RBP19
         JnOo3oLtU3Toj2QWc9tK4yZTyIax/faO8n0z+WyO2FZOM6GkWj77s3c13QPtX0Z2leFI
         IOxV1gsbAyjPFw98nQ6I9Qb6Fmwg/SWO7fsNEgJgPjW3LCGn6QDlQDawN/2l+V5zAUT3
         3xoofdn5DMSr6udJ3jVzb1KL8NMV9ywEhG7XY3WshAeWBboLMGTkEjF5iO8MNCFBCicW
         60Ew==
X-Gm-Message-State: AOAM533Stwz44eJN0EqWbw1u/RwqP4edhFoYDIQW0B33EjCpkfjqB/DE
        i4LyvTgeuhqFfQ8a2o0y4pY=
X-Google-Smtp-Source: ABdhPJzcfsyB3FVDEoajGixH729AKilyC1kk+tgSc28Ar5qRVAFms0rdwEqAvpp4qshjLfNgNCxZXQ==
X-Received: by 2002:a17:902:c406:b0:12d:d0ff:4a9 with SMTP id k6-20020a170902c40600b0012dd0ff04a9mr13905036plk.65.1629417273908;
        Thu, 19 Aug 2021 16:54:33 -0700 (PDT)
Received: from localhost.localdomain ([171.221.147.177])
        by smtp.gmail.com with ESMTPSA id o13sm559660pjq.7.2021.08.19.16.54.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 16:54:33 -0700 (PDT)
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
Cc:     wangyong <wang.yong@zte.com.cn>
Subject: [PATCH v2] mm: Add configuration to control whether vmpressure notifier is enabled
Date:   Thu, 19 Aug 2021 16:53:39 -0700
Message-Id: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: wangyong <wang.yong@zte.com.cn>

Inspired by PSI features, vmpressure inotifier function should
also be configured to decide whether it is used, because it is an
independent feature which notifies the user of memory pressure.

So we add configuration to control whether vmpressure notifier is
enabled, and provide a boot parameter to use vmpressure notifier
flexibly.

Use Christoph Lamenter’s pagefault tool
(https://lkml.org/lkml/2006/8/29/294) for comparative testing.
Test with 5.14.0-rc5-next-20210813 on x86_64 4G Ram
To ensure that the vmpressure function is executed, we enable zram
and let the program occupy memory so that some memory is swapped out

unpatched:
Gb	Rep	Thr	CLine	User(s)	System(s) Wall(s) flt/cpu/s	fault/wsec
2	1	1	1	0.1	0.97	1.13	485490.062	463533.34
2	1	1	1	0.11	0.96	1.12	483086.072	465309.495
2	1	1	1	0.1	0.95	1.11	496687.098	469887.643
2	1	1	1	0.09	0.97	1.11	489711.434	468402.102
2	1	1	1	0.13	0.94	1.12	484159.415	466080.941
average				0.106	0.958	1.118	487826.8162	466642.7042

patched and CONFIG_MEMCG_VMPRESSURE is not set:
Gb	Rep	Thr	CLine	User(s)	System(s) Wall(s) flt/cpu/s	fault/wsec
2	1	1	1	0.1	0.96	1.1	490942.682	473125.98
2	1	1	1	0.08	0.99	1.13	484987.521	463161.975
2	1	1	1	0.09	0.96	1.09	498824.98	476696.066
2	1	1	1	0.1	0.97	1.12	484127.673	465951.238
2	1	1	1	0.1	0.97	1.11	487032		468964.662
average				0.094	0.97	1.11	489182.9712	469579.9842

According to flt/cpu/s, performance improved by 0.2% which is not obvious.

By the way, the patch is mainly to make the vmpressure inotifier function
configurable.

Tested-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong@zte.com.cn>
---

Changes since v1:
-Modify some problems of document format and code

 Documentation/admin-guide/cgroup-v1/memory.rst  |  5 +++--
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 include/linux/vmpressure.h                      |  7 +++++--
 init/Kconfig                                    | 20 +++++++++++++++++++
 mm/Makefile                                     |  3 ++-
 mm/memcontrol.c                                 |  7 ++++++-
 mm/vmpressure.c                                 | 26 +++++++++++++++++++++++++
 7 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5..d605035 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -388,6 +388,7 @@ a. Enable CONFIG_CGROUPS
 b. Enable CONFIG_MEMCG
 c. Enable CONFIG_MEMCG_SWAP (to use swap extension)
 d. Enable CONFIG_MEMCG_KMEM (to use kmem extension)
+e. Enable CONFIG_MEMCG_VMPRESSURE (to use vmpressure extension)
 
 3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
 -------------------------------------------------------------------
@@ -855,8 +856,8 @@ At reading, current status of OOM is shown.
           The number of processes belonging to this cgroup killed by any
           kind of OOM killer.
 
-11. Memory Pressure
-===================
+11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
+=============================================
 
 The pressure level notifications can be used to monitor the memory
 allocation cost; based on the pressure, applications can implement
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 69ded4b..7cf541d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6156,6 +6156,9 @@
 	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
 			Format: <command>
 
+	vmpressure=	[KNL] Enable or disable vmpressure notifier.
+			Format: <bool>
+
 	vsyscall=	[X86-64]
 			Controls the behavior of vsyscalls (i.e. calls to
 			fixed addresses of 0xffffffffff600x00 from legacy
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
index e55f422..975e098 100644
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
@@ -4823,9 +4825,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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

