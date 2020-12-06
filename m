Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567DF2D01C6
	for <lists+cgroups@lfdr.de>; Sun,  6 Dec 2020 09:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgLFI1j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 6 Dec 2020 03:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLFI1j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 6 Dec 2020 03:27:39 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4B3C061A51
        for <cgroups@vger.kernel.org>; Sun,  6 Dec 2020 00:26:17 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v1so5590810pjr.2
        for <cgroups@vger.kernel.org>; Sun, 06 Dec 2020 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibu+HPexsNJ6GCHgTCs1EnvihRdwIFloguIfEoBcFm0=;
        b=0KIdxuQCRm1tphbYacq9bX4Sb+TggrItu57ArKUaQQCoBwXHVcwX/Gwuv524IG7RZD
         IW1KI60Yad/FyRbVdczIJW0sLeWj5gELykG2wY8CQlDTorYmdkrUWAmRKbkHpHE59BEb
         +EH1FxqnpqL/WRaC7sjo+fRRNsF+URl0JgoJ166gWgGczQ2sIx38NeTBgjPmR+/WvHcl
         lXD0igovt2OFRjP9k0WXUnOInptBFTXsD9fR2CZ0UuXKJaI8Y43Ruj2CLaoXCBiWOzsv
         BWz1sOSryCfYCcK4psndLWYxqJn7YuoYVvT+CZoCRQNdV2KH4ixS71fk898ew25yiW5v
         gX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibu+HPexsNJ6GCHgTCs1EnvihRdwIFloguIfEoBcFm0=;
        b=OaXF285JlHw/rcO1Bm2OmJK7Ds+1B1+I+WC1Uh/y8M7vIQy8lNRUL8vrOGMYi6oHyU
         N8kRqbcf+rbeoWMFZLzxh1DOL1bjRhk+fgCy18vD4MwSz24PV7Svgl2b6qM8M0lK7KLI
         6bCkevVPL04b4fh+3Sc25baQRhlBB+M5TSHsBbIX661IcrjaFsVKpSqyktPnoyxxNvyc
         cLM0hHKgmxApFNONKJRycc6u8JS4ToPtb5Np3CnDJpLiLQQMEmtu5TTErmnmd4/FLU+G
         ahut9R/FMtnCmXsSSdpuDjhIB3D2MDWvjm1dcUYTuCS1o4tdv8sq1yH0O3izjDFy0I0p
         +RWw==
X-Gm-Message-State: AOAM531zA0NkN8hq3PxjQzVJ8ZD8a8tfP0owIH/8CNNCCw+OqsPRDFtx
        edgHZCx2IKEaUT8SJev4DDc71Q==
X-Google-Smtp-Source: ABdhPJxkn4xNXd8n2rBmwMbQZBjsprGIlYk6gl8R9Qy0Pg3h+GKmsg0om9+NPc4j2H+hw0dSFDiPaA==
X-Received: by 2002:a17:90a:9516:: with SMTP id t22mr11426018pjo.182.1607243177099;
        Sun, 06 Dec 2020 00:26:17 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:26:16 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/9] mm: memcontrol: convert kernel stack account to byte-sized
Date:   Sun,  6 Dec 2020 16:23:03 +0800
Message-Id: <20201206082318.11532-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The kernel stack account is the only one that counts in KiB.
This patch convert it from KiB to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 2 +-
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 kernel/fork.c          | 8 ++++----
 mm/memcontrol.c        | 2 +-
 mm/page_alloc.c        | 2 +-
 mm/vmstat.c            | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6ffa470e2984..855886a6ba0e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,7 +446,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
-			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..c396b6cfba82 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -101,7 +101,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_node_page_state(NR_KERNEL_STACK_KB));
+		   global_node_page_state(NR_KERNEL_STACK_B) / 1024);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
 		   global_node_page_state(NR_KERNEL_SCS_KB));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 15132adaa233..bd34416293ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -202,7 +202,7 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
+	NR_KERNEL_STACK_B,	/* measured in byte */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 345f378e104d..2913d7c43dcb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -382,11 +382,11 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 
 	/* All stack pages are in the same node. */
 	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 	else
-		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 695dedf8687a..a7ec79dcb7dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1500,7 +1500,7 @@ struct memory_stat {
 static struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 56e603eea1dd..c28f8e1f1ef6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5573,7 +5573,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f7857a7052e4..3e3bcaf7ba7e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -353,7 +353,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
-	if (unlikely(item == NR_KERNEL_STACK_KB))
+	if (unlikely(item == NR_KERNEL_STACK_B))
 		t <<= PAGE_SHIFT;
 
 	if (unlikely(abs(x) > t)) {
@@ -575,7 +575,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
-		if (unlikely(item == NR_KERNEL_STACK_KB))
+		if (unlikely(item == NR_KERNEL_STACK_B))
 			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
-- 
2.11.0

